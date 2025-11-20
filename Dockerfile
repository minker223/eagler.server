# Use a supported Java 17 image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Make main.sh and Cuberite executable
RUN chmod +x ./main.sh ./Cuberite/Cuberite

# Make world folders writable
RUN mkdir -p \
    /app/Cuberite/world \
    /app/Cuberite/world_nether \
    /app/Cuberite/world_the_end \
    && chmod -R 777 /app/Cuberite/world*

# Ensure Plugins folder is writable
RUN chmod -R 777 /app/Cuberite/Plugins

# Install tmux (required by main.sh)
RUN apt-get update && apt-get install -y tmux && rm -rf /var/lib/apt/lists/*

# Expose necessary ports
EXPOSE 8081
EXPOSE 25565
EXPOSE 6699

# Optional: Java memory limits
ENV JAVA_OPTS="-Xms1024m -Xmx1024m"

# Start the server
CMD ["./main.sh"]
