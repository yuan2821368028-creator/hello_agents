# tests/mcp/test_auth.py
import pytest
from agent.mcp.auth import verify_api_key

def test_valid_key():
    assert verify_api_key("secret-key", "secret-key") is True

def test_invalid_key():
    assert verify_api_key("wrong-key", "secret-key") is False

def test_empty_key():
    assert verify_api_key("", "secret-key") is False

def test_none_key():
    assert verify_api_key(None, "secret-key") is False