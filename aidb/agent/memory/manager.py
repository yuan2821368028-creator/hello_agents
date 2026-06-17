"""
记忆管理器
封装 langmem 的记忆提取、存储、检索能力
三个命名空间：
  ("user", user_id, "semantic")  — 用户语义偏好
  ("user", user_id, "episodic")  — 会话摘要 / 情节记忆
  ("datasource", datasource_id, "patterns") — 历史 SQL 模式
"""

import asyncio
import logging
from typing import List, Optional, Sequence

import langmem
from langmem import ReflectionExecutor, create_memory_manager, create_thread_extractor

from agent.memory.store import get_memory_store
from common.llm_util import get_llm

logger = logging.getLogger(__name__)


class MemoryManager:
    """
    封装 langmem 三层记忆：短期（checkpointer 管理）、中期（摘要提取）、长期（跨会话存储检索）
    本类负责中期和长期记忆的读写。
    """

    @property
    def store(self):
        """每次访问时获取最新 store，确保 before_server_start 后能拿到 AsyncPostgresStore。"""
        return get_memory_store()

    def __init__(self):
        # 直接使用 LLM 实例，避免 langmem 通过字符串推断 provider 失败
        model = get_llm(temperature=0)

        # 长期记忆管理器：从对话历史中提取并更新记忆
        self._memory_manager = create_memory_manager(
            model,
            enable_inserts=True,
            enable_updates=True,
            enable_deletes=False,
        )

        # 会话摘要提取器（中期记忆）
        self._thread_extractor = create_thread_extractor(
            model,
            instructions="请用中文简洁总结本次对话的核心内容，包括用户问题、数据需求和关键结论。",
        )

        # 后台反射执行器：异步提取记忆，不阻塞主流程
        self._reflection_executor: Optional[ReflectionExecutor] = None
        self._init_reflection_executor(model)

    def _init_reflection_executor(self, model):
        try:
            manager_with_ns = create_memory_manager(
                model,
                enable_inserts=True,
                enable_updates=True,
                enable_deletes=False,
            )
            # 为 reflector 附加 namespace（LocalReflectionExecutor 要求）
            manager_with_ns.namespace = ("user", "{user_id}", "semantic")  # type: ignore[attr-defined]
            self._reflection_executor = ReflectionExecutor(
                manager_with_ns,
                store=self.store,
            )
        except Exception as e:
            logger.warning(f"ReflectionExecutor 初始化失败，将使用同步提取: {e}")
            self._reflection_executor = None

    # ------------------------------------------------------------------
    # 长期记忆：检索
    # ------------------------------------------------------------------

    async def search_user_memories(
        self,
        user_id: str,
        query: str,
        top_k: int = 5,
    ) -> List[dict]:
        """
        检索用户的语义记忆和情节记忆，用于在 system prompt 中注入上下文。
        """
        namespace = ("user", str(user_id), "semantic")
        try:
            results = await self.store.asearch(namespace, query=query, limit=top_k)
            memories = [item.value for item in results]

            # 同时检索情节记忆
            ep_namespace = ("user", str(user_id), "episodic")
            ep_results = await self.store.asearch(ep_namespace, query=query, limit=3)
            memories += [item.value for item in ep_results]

            return memories
        except Exception as e:
            logger.warning(f"记忆检索失败 user_id={user_id}: {e}")
            return []

    async def search_sql_patterns(
        self,
        datasource_id: int,
        query: str,
        top_k: int = 3,
    ) -> List[dict]:
        """
        检索历史 SQL 模式，用于 Text2SQL 提示词增强。
        """
        namespace = ("datasource", str(datasource_id), "patterns")
        try:
            results = await self.store.asearch(namespace, query=query, limit=top_k)
            return [item.value for item in results]
        except Exception as e:
            logger.warning(f"SQL 模式检索失败 datasource_id={datasource_id}: {e}")
            return []

    # ------------------------------------------------------------------
    # 长期记忆：写入
    # ------------------------------------------------------------------

    async def store_sql_pattern(
        self,
        datasource_id: int,
        question: str,
        sql: str,
    ):
        """
        将成功的 QA 对存储为 SQL 模式记忆，供后续检索增强使用。
        """
        import uuid

        namespace = ("datasource", str(datasource_id), "patterns")
        key = str(uuid.uuid4())
        value = {"question": question, "sql": sql}
        try:
            await self.store.aput(namespace, key, value)
            logger.debug(f"SQL 模式已存储: datasource={datasource_id}")
        except Exception as e:
            logger.warning(f"SQL 模式存储失败: {e}")

    # ------------------------------------------------------------------
    # 中期记忆：会话结束后提取摘要
    # ------------------------------------------------------------------

    async def extract_and_store_session_summary(
        self,
        user_id: str,
        messages: list,
        session_id: str,
    ):
        """
        对话结束后，用 thread_extractor 生成会话摘要并存储为情节记忆。
        """
        if not messages:
            return
        try:
            summary = await self._thread_extractor.ainvoke({"messages": messages})
            import uuid

            namespace = ("user", str(user_id), "episodic")
            key = session_id or str(uuid.uuid4())
            content = (
                summary.model_dump() if hasattr(summary, "model_dump") else {"text": str(summary)}
            )
            await self.store.aput(namespace, key, content)
            logger.info(f"会话摘要已存储 user={user_id} session={session_id}")
        except Exception as e:
            logger.warning(f"会话摘要提取失败 user={user_id}: {e}")

    # ------------------------------------------------------------------
    # 长期记忆：后台异步提取（不阻塞主流程）
    # ------------------------------------------------------------------

    def submit_background_reflection(
        self,
        user_id: str,
        messages: list,
        thread_id: str,
    ):
        """
        将记忆提取任务提交到后台线程执行器，不阻塞当前请求。
        """
        if self._reflection_executor is None:
            # 降级：同步提取
            asyncio.ensure_future(
                self._fallback_extract_memories(user_id, messages)
            )
            return

        try:
            from langchain_core.runnables import RunnableConfig

            config = RunnableConfig(
                configurable={
                    "thread_id": thread_id,
                    "user_id": str(user_id),
                }
            )
            self._reflection_executor.submit(
                {"messages": messages},
                config=config,
                after_seconds=0,
            )
        except Exception as e:
            logger.warning(f"后台记忆提取提交失败: {e}")

    async def _fallback_extract_memories(
        self, user_id: str, messages: list
    ):
        """ReflectionExecutor 不可用时的降级方案：直接调用 memory_manager."""
        try:
            namespace = ("user", str(user_id), "semantic")
            # 不传 existing：仅提取本次对话的新记忆，避免 dict 格式不兼容导致 LLM 无限循环
            # max_steps=1 确保单轮提取后立即结束
            result = await self._memory_manager.ainvoke(
                {
                    "messages": messages,
                    "existing": [],
                    "max_steps": 1,
                },
                config={"recursion_limit": 50},
            )
            import uuid
            for mem in result:
                # ExtractedMemory 是 NamedTuple(id, content)，content 是 Memory(content=str)
                content = mem.content
                value = (
                    content.model_dump()
                    if hasattr(content, "model_dump")
                    else {"content": str(content)}
                )
                await self.store.aput(namespace, str(uuid.uuid4()), value)
        except Exception as e:
            logger.warning(f"降级记忆提取失败 user={user_id}: {e}")

    # ------------------------------------------------------------------
    # 公共便捷接口（供 CommonReactAgent / Text2SqlAgent 调用）
    # ------------------------------------------------------------------

    async def retrieve_memories(self, user_id: str, query: str, top_k: int = 5) -> List[dict]:
        """检索用户语义+情节记忆，供 CommonReactAgent 注入 system prompt。"""
        return await self.search_user_memories(user_id=user_id, query=query, top_k=top_k)

    async def retrieve_sql_patterns(
        self,
        user_id: str,
        query: str,
        datasource_id: Optional[int] = None,
        top_k: int = 3,
    ) -> List[dict]:
        """检索历史 SQL 模式，供 Text2SqlAgent 注入提示词。"""
        if datasource_id is None:
            return []
        return await self.search_sql_patterns(
            datasource_id=datasource_id, query=query, top_k=top_k
        )

    async def extract_and_store(self, user_id: str, query: str, answer: str):
        """从单次 QA 对中提取记忆并存储，供 CommonReactAgent run 后异步调用。"""
        from langchain_core.messages import HumanMessage, AIMessage

        messages = [
            HumanMessage(content=query),
            AIMessage(content=answer),
        ]
        await self._fallback_extract_memories(user_id=user_id, messages=messages)
