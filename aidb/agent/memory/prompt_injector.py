"""
记忆注入器
将检索到的记忆格式化后注入到 agent system prompt 或 Text2SQL 提示词中
"""

from typing import List, Optional


def  format_user_memories_for_prompt(memories: List[dict]) -> str:
    """
    将用户记忆列表格式化为可嵌入 system prompt 的字符串。
    返回空字符串表示无记忆可注入。
    """
    if not memories:
        return ""

    lines = ["<user_memory>"]
    for mem in memories:
        # 记忆条目可能是 langmem Memory 模型，也可能是自由格式 dict
        content = mem.get("content") or mem.get("text") or mem.get("summary", "")
        if not content and isinstance(mem, dict):
            # 尝试直接序列化整个 dict（情节摘要等）
            content = "; ".join(f"{k}: {v}" for k, v in mem.items() if v and k != "id")
        if content:
            lines.append(f"  - {content}")
    lines.append("</user_memory>")

    # 如果除了标签外没有任何条目，返回空字符串
    if len(lines) <= 2:
        return ""
    return "\n".join(lines)


def format_sql_patterns_for_prompt(patterns: List[dict]) -> str:
    """
    将历史 SQL 模式格式化为 XML，可直接追加到 data_training 参数中。
    """
    if not patterns:
        return ""

    parts = ["<memory_patterns>"]
    for p in patterns:
        question = p.get("question", "")
        sql = p.get("sql", "")
        if question and sql:
            parts.append("  <pattern>")
            parts.append(f"    <question><![CDATA[{question}]]></question>")
            parts.append(f"    <sql><![CDATA[{sql}]]></sql>")
            parts.append("  </pattern>")
    parts.append("</memory_patterns>")

    if len(parts) <= 2:
        return ""
    return "\n".join(parts)


def  inject_memory_into_system_prompt(system_prompt: str, memory_block: str) -> str:
    """
    将记忆块注入到 system prompt 末尾（如果有内容）。
    """
    if not memory_block:
        return system_prompt
    return system_prompt + "\n\n# 关于用户的长期记忆\n" + memory_block
