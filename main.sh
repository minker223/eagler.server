#!/bin/bash
# Docker-friendly Eaglercraft launcher
set -e

echo "[INFO] Starting Cuberite..."
cd ./Cuberite
chmod +x ./Cuberite
./Cuberite &
CUBERITE_PID=$!
cd ..

# Give Cuberite time to initialize (avoid connection refused)
sleep 5

echo "[INFO] Starting Bungee/Waterfall..."
cd ./Bungee
java -Xmx512M -Xms512M -jar bungee.jar &
BUNGEE_PID=$!
cd ..

# Handle container stop gracefully
function cleanup {
    echo "[INFO] Shutting down servers..."
    kill $BUNGEE_PID $CUBERITE_PID || true
    wait
}
trap cleanup SIGTERM SIGINT

# Keep container alive as long as servers run
wait
