import hmac
import os


def verify_api_key(provided: str | None, expected: str | None = None) -> bool:
    if not provided:
        return False
    expected = expected or os.getenv("MCP_API_KEY", "")
    if not expected:
        return False
    return hmac.compare_digest(provided, expected)