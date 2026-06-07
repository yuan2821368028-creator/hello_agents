"""ReAct Agent实现 - 推理与行动结合的智能体"""

import re
from typing import Optional, List, Tuple
from ..core.agent import Agent
from ..core.llm import HelloAgentsLLM
from ..core.config import Config
from ..core.message import Message
from ..tools.registry import ToolRegistry

# 默认ReAct提示词模板
DEFAULT_REACT_PROMPT = """你是一个具备推理和行动能力的AI助手。你可以通过思考分析问题，然后调用合适的工具来获取信息，最终给出准确的答案。

## 可用工具
{tools}

## 输出格式（必须严格遵守）
你的每次回应必须同时包含以下两部分，缺一不可：

Thought: [你的思考过程]
Action: [你的行动]

## Action 的两种格式
1. 调用工具获取信息：`tool_name[parameters]`
   例如：python_calculator[2 + 3]
   例如：weather[北京]

2. 完成任务并给出最终答案：`Finish[最终答案]`
   例如：Finish[答案是5]
   例如：Finish[北京和上海的平均温度是21.5°C]

## 重要规则（必须遵守）
⚠️ 1. 每次回应必须同时包含 Thought 和 Action，不能只有 Thought
⚠️ 2. 当你得到最终答案时，必须使用 `Action: Finish[答案]` 来结束
⚠️ 3. 不要在 Thought 中说"任务完成"或"已经得到答案"而不输出 Action: Finish
⚠️ 4. Action 必须在单独一行，格式为 `Action: xxx[yyy]`

## 正确示例
示例1 - 需要使用工具：
Thought: 我需要计算 10 + 20 的结果
Action: python_calculator[10 + 20]

示例2 - 得到答案后结束：
Thought: 计算器返回结果是 30，这就是最终答案
Action: Finish[10 + 20 的结果是 30]

## 错误示例（不要这样做）
❌ 错误1 - 只有 Thought 没有 Action：
Thought: 我已经得到答案了

❌ 错误2 - 在 Thought 中说完成但没有 Finish：
Thought: 任务完成，答案是30

❌ 错误3 - Action 格式错误：
Action: 答案是30（应该是 Finish[答案是30]）

## 当前任务
**Question:** {question}

## 执行历史
{history}

现在开始你的推理和行动（记住：必须同时输出 Thought 和 Action）："""

class ReActAgent(Agent):
    """
    ReAct (Reasoning and Acting) Agent
    
    结合推理和行动的智能体，能够：
    1. 分析问题并制定行动计划
    2. 调用外部工具获取信息
    3. 基于观察结果进行推理
    4. 迭代执行直到得出最终答案
    
    这是一个经典的Agent范式，特别适合需要外部信息的任务。
    """
    
    def __init__(
        self,
        name: str,
        llm: HelloAgentsLLM,
        tool_registry: Optional[ToolRegistry] = None,
        system_prompt: Optional[str] = None,
        config: Optional[Config] = None,
        max_steps: int = 5,
        custom_prompt: Optional[str] = None
    ):
        """
        初始化ReActAgent

        Args:
            name: Agent名称
            llm: LLM实例
            tool_registry: 工具注册表（可选，如果不提供则创建空的工具注册表）
            system_prompt: 系统提示词
            config: 配置对象
            max_steps: 最大执行步数
            custom_prompt: 自定义提示词模板
        """
        super().__init__(name, llm, system_prompt, config)

        # 如果没有提供tool_registry，创建一个空的
        if tool_registry is None:
            self.tool_registry = ToolRegistry()
        else:
            self.tool_registry = tool_registry

        self.max_steps = max_steps
        self.current_history: List[str] = []

        # 设置提示词模板：用户自定义优先，否则使用默认模板
        self.prompt_template = custom_prompt if custom_prompt else DEFAULT_REACT_PROMPT

    def add_tool(self, tool):
        """
        添加工具到工具注册表
        支持MCP工具的自动展开

        Args:
            tool: 工具实例(可以是普通Tool或MCPTool)
        """
        # 检查是否是MCP工具
        if hasattr(tool, 'auto_expand') and tool.auto_expand:
            # MCP工具会自动展开为多个工具
            if hasattr(tool, '_available_tools') and tool._available_tools:
                for mcp_tool in tool._available_tools:
                    # 创建包装工具
                    from ..tools.base import Tool
                    wrapped_tool = Tool(
                        name=f"{tool.name}_{mcp_tool['name']}",
                        description=mcp_tool.get('description', ''),
                        func=lambda input_text, t=tool, tn=mcp_tool['name']: t.run({
                            "action": "call_tool",
                            "tool_name": tn,
                            "arguments": {"input": input_text}
                        })
                    )
                    self.tool_registry.register_tool(wrapped_tool)
                print(f"✅ MCP工具 '{tool.name}' 已展开为 {len(tool._available_tools)} 个独立工具")
            else:
                self.tool_registry.register_tool(tool)
        else:
            self.tool_registry.register_tool(tool)

    def run(self, input_text: str, **kwargs) -> str:
        """
        运行ReAct Agent

        Args:
            input_text: 用户问题
            **kwargs: 其他参数

        Returns:
            最终答案
        """
        self.current_history = []
        current_step = 0
        format_error_count = 0  # 记录格式错误次数
        max_format_errors = 2  # 最多允许2次格式错误

        print(f"\n🤖 {self.name} 开始处理问题: {input_text}")

        while current_step < self.max_steps:
            current_step += 1
            print(f"\n--- 第 {current_step} 步 ---")

            # 构建提示词
            tools_desc = self.tool_registry.get_tools_description()
            history_str = "\n".join(self.current_history)
            prompt = self.prompt_template.format(
                tools=tools_desc,
                question=input_text,
                history=history_str
            )

            # 调用LLM
            messages = [{"role": "user", "content": prompt}]
            response_text = self.llm.invoke(messages, **kwargs)

            if not response_text:
                print("❌ 错误：LLM未能返回有效响应。")
                break

            # 解析输出
            thought, action = self._parse_output(response_text)

            if thought:
                print(f"🤔 思考: {thought}")

            # 处理缺少 Action 的情况
            if not action:
                format_error_count += 1
                print(f"⚠️ 警告：未能解析出有效的Action（第 {format_error_count}/{max_format_errors} 次格式错误）")

                if format_error_count >= max_format_errors:
                    print("❌ 格式错误次数过多，流程终止。")
                    final_answer = "抱歉，我在处理过程中遇到了格式问题，无法完成任务。"
                    self.add_message(Message(input_text, "user"))
                    self.add_message(Message(final_answer, "assistant"))
                    return final_answer

                # 添加格式提醒到历史，让 LLM 重试
                format_reminder = """⚠️ 系统提醒：你的上一次回应缺少 Action 部分！

请严格按照以下格式输出：
Thought: [你的思考]
Action: [你的行动]

如果你已经得到最终答案，必须使用：
Action: Finish[你的答案]

请重新输出完整的 Thought 和 Action。"""

                self.current_history.append(f"System: {format_reminder}")
                print("💡 已添加格式提醒，继续下一轮...")
                continue

            # 重置格式错误计数（成功解析到 Action）
            format_error_count = 0

            # 检查是否完成
            if action.startswith("Finish"):
                final_answer = self._parse_action_input(action)
                print(f"🎉 最终答案: {final_answer}")

                # 保存到历史记录
                self.add_message(Message(input_text, "user"))
                self.add_message(Message(final_answer, "assistant"))

                return final_answer

            # 执行工具调用
            tool_name, tool_input = self._parse_action(action)
            if not tool_name or tool_input is None:
                print("⚠️ Action 格式无效，添加提醒...")
                self.current_history.append("Observation: 无效的Action格式。请使用 tool_name[parameters] 格式。")
                continue

            print(f"🎬 行动: {tool_name}[{tool_input}]")

            # 调用工具
            observation = self.tool_registry.execute_tool(tool_name, tool_input)
            print(f"👀 观察: {observation}")

            # 更新历史
            self.current_history.append(f"Thought: {thought}")
            self.current_history.append(f"Action: {action}")
            self.current_history.append(f"Observation: {observation}")

        # 达到最大步数
        print(f"⏰ 已达到最大步数（{self.max_steps}步），流程终止。")
        final_answer = "抱歉，我无法在限定步数内完成这个任务。请尝试增加 max_steps 参数或简化问题。"

        # 保存到历史记录
        self.add_message(Message(input_text, "user"))
        self.add_message(Message(final_answer, "assistant"))

        return final_answer
    
    def _parse_output(self, text: str) -> Tuple[Optional[str], Optional[str]]:
        """解析LLM输出，提取思考和行动"""
        thought_match = re.search(r"Thought: (.*)", text)
        action_match = re.search(r"Action: (.*)", text)
        
        thought = thought_match.group(1).strip() if thought_match else None
        action = action_match.group(1).strip() if action_match else None
        
        return thought, action
    
    def _parse_action(self, action_text: str) -> Tuple[Optional[str], Optional[str]]:
        """解析行动文本，提取工具名称和输入"""
        match = re.match(r"(\w+)\[(.*)\]", action_text)
        if match:
            return match.group(1), match.group(2)
        return None, None
    
    def _parse_action_input(self, action_text: str) -> str:
        """解析行动输入"""
        match = re.match(r"\w+\[(.*)\]", action_text)
        return match.group(1) if match else ""
