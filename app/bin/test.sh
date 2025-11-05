#!/bin/bash
set -e

# --- CONFIG ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_URL="http://127.0.0.1:${PORT}"
START_SCRIPT="${SCRIPT_DIR}/startup.sh"

# --- START THE APP IN BACKGROUND ---
echo "🚀 Starting app in background on port ${PORT}..."
"${START_SCRIPT}" &
APP_PID=$!

# --- WAIT FOR THE APP TO START ---
echo "⏳ Waiting for app to start..."
sleep 3  # adjust if startup takes longer

# --- FIRE TEST CURLS ---
echo "🔥 Running test curls..."

RANDOM_URL="https://example.com/$(tr -dc 'a-z0-9' </dev/urandom | head -c 8)"
RANDOM_TITLE="Title_$(tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 6)"

curl -s -X GET "${APP_URL}/ping" | jq . | tee /tmp/out/ping.json

curl -s -X POST "${APP_URL}/module/" \
  -H "Content-Type: application/json" \
  -d "{\"name\": \"${RANDOM_TITLE}\", \"url\": \"${RANDOM_URL}\"}" | jq . | tee /tmp/out/create.json

curl -s -X GET "${APP_URL}/module/" | jq . | tee /tmp/out/list.json

curl -s -X GET "${APP_URL}/module/1" | jq . | tee /tmp/out/single.json

# --- CLEANUP ---
echo "🧹 Killing app (PID: ${APP_PID})..."
kill $APP_PID

# --- WAIT FOR CLEAN EXIT ---
wait $APP_PID 2>/dev/null || true

echo "✅ Done!"
