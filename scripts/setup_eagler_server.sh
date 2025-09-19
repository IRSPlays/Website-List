#!/usr/bin/env bash
set -euo pipefail

WORKDIR="$(dirname "${BASH_SOURCE[0]}")/.."
cd "$WORKDIR"

OUTDIR="$(pwd)/eagler-server"
ZIPPATH="$(pwd)/eagler-server.zip"

echo "Workspace: $(pwd)"

command -v java >/dev/null 2>&1 || { echo "Java not found. Please install Java (JRE/JDK 8+)." >&2; exit 2; }
command -v curl >/dev/null 2>&1 || { echo "curl not found. Please install curl." >&2; exit 2; }
command -v unzip >/dev/null 2>&1 || { echo "unzip not found. Please install unzip." >&2; exit 2; }

mkdir -p "$OUTDIR"

declare -a CANDIDATES=(
  "${SERVER_URL:-}"
  "https://github.com/Eaglercraft/EaglercraftX/releases/latest/download/EaglercraftX-Server-dist.zip"
  "https://github.com/Eaglercraft/EaglercraftX/releases/latest/download/EaglercraftX-Server.zip"
  "https://github.com/Eaglercraft/EaglercraftX/releases/latest/download/EaglercraftX-Server-Distribution.zip"
  "https://github.com/Eaglercraft/Eaglercraft/releases/latest/download/Eaglercraft-Server.zip"
)

echo "Trying to download an Eaglercraft server distribution. If you have a direct URL, set SERVER_URL env var."

for url in "${CANDIDATES[@]}"; do
  if [ -z "$url" ]; then
    continue
  fi
  echo "Trying: $url"
  if curl -L --fail --silent --show-error --output "$ZIPPATH" "$url"; then
    echo "Downloaded to $ZIPPATH"
    break
  else
    echo "Failed to download from $url"
    rm -f "$ZIPPATH" || true
  fi
done

if [ ! -f "$ZIPPATH" ]; then
  echo "No distribution downloaded. Please provide a SERVER_URL pointing to a zip distribution (or add the server files manually)." >&2
  exit 3
fi

echo "Extracting..."
unzip -o "$ZIPPATH" -d "$OUTDIR"

echo "Extraction complete. Listing $OUTDIR:"
ls -la "$OUTDIR" | sed -n '1,200p'

echo "Looking for runnable jars..."
find "$OUTDIR" -maxdepth 4 -type f -iname '*.jar' -print || true

echo "Setup complete. To run the server, use: ./scripts/run_eagler_server.sh"
