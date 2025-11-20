#!/bin/bash
set -e

echo "[INFO] Starting Cuberite..."
cd ./Cuberite
chmod +x ./Cuberite
./Cuberite &
CUBERITE_PID=$!
cd ..

# Give Cuberite some time to start
sleep 5

echo "[INFO] Starting Bungee..."
cd ./Bungee
java -Xmx128M -Xms128M -jar bungee.jar &
BUNGEE_PID=$!
cd ..

# Trap signals to stop both
trap "kill $CUBERITE_PID $BUNGEE_PID; wait" SIGINT SIGTERM

wait
