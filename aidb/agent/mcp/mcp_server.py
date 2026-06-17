import json
import logging
import os
import uuid
from typing import Optional

import uvicorn

from mcp.server.fastmcp import FastMCP
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from starlette.responses import Response

from agent.mcp.auth import verify_api_key
from agent.text2sql.analysis.graph import create_graph
from agent.text2sql.state.agent_state import AgentState
from config.load_env import load_env

load_env()

logger = logging.getLogger(__name__)

mcp = FastMCP("aix-db")


class ApiKeyMiddleware(BaseHTTPMiddleware):
    async def dispatch(self, request: Request, call_next):
        if request.url.path == "/health":
            return await call_next(request)
        provided = request.headers.get("X-API-Key") or request.query_params.get("api_key")
        if not verify_api_key(provided):
            return Response("Unauthorized", status_code=401)
        return await call_next(request)


@mcp.tool()
async def text2sql_query(
    query: str,
    datasource_id: Optional[int] = None,
    user_id: int = 1,
) -> str:
    """
    将自然语言问题转为 SQL 并执行，返回分析结果。
    Args:
        query: 自然语言问题，例如：「上个月各地区的销售额」
        datasource_id: 数据源ID，不传则由 Agent 自动选择
        user_id: 用户ID，用于行级权限过滤，默认为 1（管理员）
    Returns:
        JSON 字符串，包含 report_summary 和 render_data
    """
    graph = create_graph()
    initial_state = AgentState(
        user_query=query,
        attempts=0,
        correct_attempts=0,
        datasource_id=datasource_id,
        user_id=user_id,
    )
    try:
        final_state = await graph.ainvoke(initial_state)
        result = {
            "report_summary": final_state.get("report_summary"),
            "render_data": final_state.get("render_data"),
            "generated_sql": final_state.get("generated_sql"),
            "error_message": final_state.get("error_message"),
        }
    except Exception as e:
        logger.exception("text2sql_query failed: %s", e)
        result = {"error_message": str(e)}
    return json.dumps(result, ensure_ascii=False)


def main():
    host = os.getenv("MCP_HOST", "0.0.0.0")
    port = int(os.getenv("MCP_PORT", 3300))
    mcp.settings.host = host
    mcp.settings.port = port
    app = mcp.sse_app()
    app.add_middleware(ApiKeyMiddleware)
    uvicorn.run(app, host=host, port=port)


if __name__ == "__main__":
    main()
