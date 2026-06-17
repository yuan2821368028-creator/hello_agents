#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

cd "$ROOT_DIR"

# 加载环境变量
if [ -f ".env.dev" ]; then
  set -a
  source .env.dev
  set +a
fi

echo "Starting Aix-DB MCP Server on ${MCP_HOST:-0.0.0.0}:${MCP_PORT:-3300}"
uv run python -m agent.mcp.mcp_server