#!/usr/bin/env bash
set -euo pipefail

echo "Starting FastAPI app...(DEBUG=$DEBUG)" | tee /tmp/out/server.log
uvicorn app.main:app --host 0.0.0.0 --port ${PORT} ${DEBUG:+--reload} | tee /tmp/out/server.log
