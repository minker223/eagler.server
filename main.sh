#!/bin/bash
# main.sh - Start Cuberite + Bungee for Eaglercraft

unset DISPLAY

# Optional: set tmux mouse
echo "set -g mouse on" > ~/.tmux.conf

# Kill any previous session
tmux kill-session -t server 2>/dev/null || true

# Start Cuberite in a new tmux session
cd ./Cuberite
chmod +x Cuberite
tmux new -d -s server "./Cuberite"
cd ..

# Wait a few seconds for Cuberite to initialize
sleep 5

# Start Bungee / Waterfall / EaglercraftXBungee
cd ./Bungee
tmux splitw -t server -h "java $JAVA_OPTS -jar bungee.jar; tmux kill-session -t server"
cd ..

# Attach to tmux session so logs are visible in Railway console
while tmux has-session -t server 2>/dev/null; do
  tmux attach -t server
done

