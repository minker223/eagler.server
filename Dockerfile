# Use a lightweight Java image
FROM openjdk:17-jdk‑slim

# Set working directory inside container
WORKDIR /app

# Copy everything from your repo into the container
COPY . /app

# Make sure the startup script(s) are executable
RUN chmod +x ./main.sh ./run.sh || true

# Expose the ports your server uses (adjust if different)
# WebSocket / game port (8081) and relay port (6699)
EXPOSE 8081
EXPOSE 6699

# Optionally set environment variable for Java memory etc
ENV JAVA_OPTS="-Xms512m -Xmx1g"

# Start the server via the script
CMD ["./main.sh"]
