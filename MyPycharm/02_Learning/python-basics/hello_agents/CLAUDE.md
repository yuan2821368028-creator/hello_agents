# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

HelloAgents (v0.2.8) — a multi-agent framework built on OpenAI-compatible APIs. Python >=3.13. Package name: `hello-agents`. Based on the Datawhale Hello-Agents tutorial series.

No build/lint/test commands are configured yet (`pyproject.toml` has no scripts or dev dependencies).

## 环境管理 (重要)

**全部使用 `uv`** — 包括创建虚拟环境、安装依赖、运行脚本、启动服务器等，不允许使用 pip/poetry/conda 等其他工具。

常用命令：
- 创建环境：`uv venv`
- 安装依赖：`uv pip install <package>`
- 运行脚本：`uv run python main.py`
- 同步依赖：`uv pip sync requirements.txt`

## Architecture

The framework layers from bottom to top:

**`core/`** — Foundation: `Agent(ABC)` base class (`.run(input_text) -> str`), `HelloAgentsLLM` (wraps `openai.OpenAI`, auto-detects provider from env vars/key format/base_url across 10+ providers), `Config` and `Message` (both Pydantic models), `HelloAgentsException` hierarchy.

**`agents/`** — Agent paradigms, all extending `Agent`:
- `SimpleAgent` — conversational agent with optional `[TOOL_CALL:name:params]` text-pattern tool calling
- `ReActAgent` — classic Thought/Action/Observation loop with `max_steps` limit
- `ReflectionAgent`, `PlanAndSolveAgent`, `FunctionCallAgent`, `ToolAwareSimpleAgent`

**`tools/`** — `Tool(ABC)` with `run(parameters) -> str` and `get_parameters() -> List[ToolParameter]`. `@tool_action` decorator marks methods on expandable tools as auto-generated sub-tools. `ToolRegistry` stores both `Tool` objects and plain functions, with a `global_registry` singleton. Built-in tools: search, calculator, memory, RAG, note, terminal, MCP wrapper, BFCL/GAIA evaluation, RL training. `ToolChain` pipes tools sequentially; `AsyncToolExecutor` runs them in parallel.

**`memory/`** — Layered memory: `WorkingMemory`, `EpisodicMemory`, `SemanticMemory`, `PerceptualMemory`, all managed by `MemoryManager`. Storage backends: `SQLiteDocumentStore`, Qdrant, Neo4j. RAG pipeline in `memory/rag/`.

**`protocols/`** — Agent communication: MCP (requires `fastmcp`), A2A (agent-to-agent with `A2AServer`/`A2AClient`/`AgentNetwork`), ANP (service discovery). MCP is optional — imports fail gracefully with stubs.

**`context/`** — GSSC pipeline (Gather-Select-Structure-Compress) via `ContextBuilder`.

**`rl/`** — TRL-based RL training: `SFTTrainerWrapper`, `GRPOTrainerWrapper`, `PPOTrainerWrapper`. Dataset loaders for GSM8K math problems. Reward functions for accuracy, length penalty, step-by-step evaluation.

**`evaluation/`** — Benchmark eval: BFCL (function-calling correctness), GAIA (general assistant tasks), LLM Judge, Win Rate.

**`utils/`** — Logging setup, serialization helpers.

## Key conventions

- LLM env vars: provider-specific keys (`OPENAI_API_KEY`, `DEEPSEEK_API_KEY`, etc.) or generic `LLM_API_KEY` + `LLM_BASE_URL` + `LLM_MODEL_ID`. See `HelloAgentsLLM._auto_detect_provider()` for detection priority order.
- Agent `.run()` signature: `def run(self, input_text: str, **kwargs) -> str`. History is managed internally via `self._history: list[Message]`.
- Tools use `ToolParameter` (Pydantic) for parameter definitions. The `to_openai_schema()` method exports OpenAI function-calling format.
- Pydantic is used for structured data (`Config`, `Message`, `ToolParameter`), not for the framework's core abstractions.
