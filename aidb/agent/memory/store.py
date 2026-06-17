"""
记忆存储初始化
提供 langmem 兼容的 InMemoryStore（开发）和 AsyncPostgresStore（生产）

AsyncPostgresStore 必须在异步上下文中通过 setup_postgres_store() 初始化，
由 Sanic before_server_start 钩子调用。
"""

import logging
import os

from langgraph.store.memory import InMemoryStore

logger = logging.getLogger(__name__)

_store = None
_store_cm = None  # 持有 AsyncPostgresStore 上下文管理器，防止被 GC


def get_memory_store():
    """
    获取全局记忆存储单例。
    同步方法，模块导入时返回 InMemoryStore；
    Sanic 启动后若已调用 setup_postgres_store()，则返回 AsyncPostgresStore。
    """
    global _store
    if _store is None:
        _store = InMemoryStore()
        logger.info("MemoryStore: using InMemoryStore (fallback/dev)")
    return _store


async def setup_postgres_store():
    """
    异步初始化 AsyncPostgresStore，在 Sanic before_server_start 中调用。
    成功后替换全局 _store，MemoryManager 后续调用 get_memory_store() 即可获取。
    """
    global _store, _store_cm
    try:
        from langgraph.store.postgres import AsyncPostgresStore

        db_uri = os.getenv(
            "SQLALCHEMY_DATABASE_URI",
            "postgresql+psycopg://aix_db:1@127.0.0.1:5432/aix_db",
        )
        uri = db_uri.replace("postgresql+psycopg2://", "postgresql://").replace(
            "postgresql+psycopg://", "postgresql://"
        )
        _store_cm = AsyncPostgresStore.from_conn_string(uri)
        _store = await _store_cm.__aenter__()
        try:
            await _store.setup()
        except Exception as setup_err:
            # 多 worker 并发时 setup() 会抛 duplicate key，忽略即可（连接本身是好的）
            logger.warning(f"AsyncPostgresStore setup() 跳过（可能已由其他 worker 初始化）: {setup_err}")
        logger.info("MemoryStore: using AsyncPostgresStore (production)")
    except Exception as e:
        logger.warning(f"AsyncPostgresStore 初始化失败，回退到 InMemoryStore: {e}")
        _store = InMemoryStore()


async def teardown_store():
    """在 Sanic after_server_stop 中调用，清理 AsyncPostgresStore 连接。"""
    global _store, _store_cm
    if _store_cm is not None:
        try:
            await _store_cm.__aexit__(None, None, None)
        except Exception as e:
            logger.warning(f"MemoryStore teardown error: {e}")
        finally:
            _store_cm = None
            _store = None
