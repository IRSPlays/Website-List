#!/bin/bash

echo "Starting Eaglercraft WASM-GC Docker Container..."
echo "========================================"

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is not installed or not in PATH"
    exit 1
fi

# Check if docker compose is available
if docker compose version &> /dev/null; then
    COMPOSE_CMD="docker compose"
elif command -v docker-compose &> /dev/null; then
    COMPOSE_CMD="docker-compose"
else
    echo "Error: Docker Compose is not installed"
    exit 1
fi

# Navigate to script directory
cd "$(dirname "$0")"

echo "Building and starting Eaglercraft container..."
$COMPOSE_CMD up -d --build

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Eaglercraft WASM-GC is now running!"
    echo ""
    echo "🌐 Open your browser and go to: http://localhost:8080"
    echo ""
    echo "Available commands:"
    echo "  - Stop server: $COMPOSE_CMD down"
    echo "  - View logs: $COMPOSE_CMD logs -f"
    echo "  - Restart: $COMPOSE_CMD restart"
    echo ""
    echo "Browser compatibility required:"
    echo "  - Chrome 119+ / Firefox 120+ / Safari 17+ / Edge 119+"
else
    echo "❌ Failed to start Eaglercraft container"
    exit 1
fi