# Use a lightweight OpenJDK 17 image
FROM openjdk:17-jdk-slim

# Set working directory inside container
WORKDIR /app

# Copy all server files into the container
COPY . /app

# Make sure scripts are executable
RUN chmod +x ./main.sh ./Cuberite/Cuberite

# Expose the ports your server uses
# Cuberite WebSocket/game port
EXPOSE 8081
# Bungee/Waterfall port
EXPOSE 6699
# Caddy (HTTP) port (if needed)
EXPOSE 80
EXPOSE 443

# Optional: set Java memory limits
ENV JAVA_OPTS="-Xms512m -Xmx1g"

# Start the server using the Docker-friendly main.sh
CMD ["./main.sh"]
