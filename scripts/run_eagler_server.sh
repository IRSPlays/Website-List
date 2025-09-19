#!/usr/bin/env bash
set -euo pipefail

WORKDIR="$(dirname "${BASH_SOURCE[0]}")/.."
cd "$WORKDIR"

OUTDIR="$(pwd)/eagler-server"

if [ ! -d "$OUTDIR" ]; then
  echo "Server not setup. Run ./scripts/setup_eagler_server.sh first." >&2
  exit 1
fi

JAR=$(find "$OUTDIR" -maxdepth 4 -type f -iname '*.jar' | head -n 1 || true)
if [ -z "$JAR" ]; then
  echo "No server jar found under $OUTDIR. Please place the server jar there or run setup to download a distribution." >&2
  exit 2
fi

echo "Starting Eaglercraft server from: $JAR"

JAVA_OPTS="-Xmx512M -Xms256M"

nohup java $JAVA_OPTS -jar "$JAR" nogui > eagler-server.log 2>&1 &
PID=$!
echo "Server started (PID $PID). Logs: eagler-server.log"
