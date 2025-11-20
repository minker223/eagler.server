#!/bin/bash
# Docker-friendly Eaglercraft Server Launcher

set -e

# Stop any DISPLAY (headless)
unset DISPLAY

echo "[INFO] Starting Eaglercraft Server in Docker..."

# Start Caddy in the background but keep logs to stdout
echo "[INFO] Starting Caddy..."
cd ./Caddy
caddy stop || true
caddy start --config ./Caddyfile &
CADDY_PID=$!
cd ..

# Start Cuberite server in the foreground
echo "[INFO] Starting Cuberite..."
cd ./Cuberite
chmod +x Cuberite
./Cuberite &
CUBERITE_PID=$!
cd ..

# Start Bungee/Waterfall in the foreground
echo "[INFO] Starting Bungee..."
cd ./Bungee
java -Xmx128M -Xms128M -jar bungee.jar &
BUNGEE_PID=$!
cd ..

# Function to shut down everything on container stop
function cleanup {
    echo "[INFO] Shutting down servers..."
    kill $BUNGEE_PID $CUBERITE_PID $CADDY_PID || true
    wait
}
trap cleanup SIGTERM SIGINT

# Wait for all background processes
wait
