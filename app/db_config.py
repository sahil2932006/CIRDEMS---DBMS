"""Oracle connection settings for the local CIRDEMS app."""

import os
from pathlib import Path

import oracledb

PROJECT_ROOT = Path(__file__).resolve().parent.parent

def load_local_env():
    """Read simple KEY=VALUE settings without printing their values."""
    env_file = PROJECT_ROOT / ".env"
    if not env_file.exists():
        return
    for line in env_file.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        value = value.strip().strip('"').strip("'")
        os.environ.setdefault(key.strip(), value)

load_local_env()

DB_USER = os.getenv("CIRDEMS_DB_USER", "SYSTEM")
DB_PASS = os.getenv("CIRDEMS_DB_PASS", "")
DB_HOST = os.getenv("CIRDEMS_DB_HOST", "localhost")
DB_PORT = int(os.getenv("CIRDEMS_DB_PORT", "1521"))
DB_SERVICE = os.getenv("CIRDEMS_DB_SERVICE", "XE")


def get_connection():
    """Return (connection, error); never silently substitute demo data here."""
    if not DB_PASS:
        return None, "Set CIRDEMS_DB_PASS in the project-root .env file."
    try:
        connection = oracledb.connect(
            user=DB_USER,
            password=DB_PASS,
            host=DB_HOST,
            port=DB_PORT,
            service_name=DB_SERVICE,
        )
        return connection, None
    except Exception as exc:
        return None, str(exc)
