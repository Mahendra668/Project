"""
utils.py — shared helpers for Mark XXX
Centralizes API key loading so it is read from disk only ONCE per process.
"""
import json
import sys
from pathlib import Path


def get_base_dir() -> Path:
    if getattr(sys, "frozen", False):
        return Path(sys.executable).parent
    return Path(__file__).resolve().parent


_BASE_DIR = get_base_dir()
_API_KEY_PATH = _BASE_DIR / "config" / "api_keys.json"
_cached_api_key: str | None = None


def get_api_key() -> str:
    """Return the Gemini API key, reading from disk only on the first call."""
    global _cached_api_key
    if _cached_api_key is None:
        with open(_API_KEY_PATH, "r", encoding="utf-8") as f:
            _cached_api_key = json.load(f)["gemini_api_key"]
    return _cached_api_key
