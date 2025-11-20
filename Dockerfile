# Use a supported Java 17 image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Make main.sh and Cuberite executable
RUN chmod +x ./main.sh ./Cuberite/Cuberite

# Create necessary plugin and world folders and give write permissions
RUN mkdir -p \
    /app/Cuberite/Plugins/Core \
    /app/Cuberite/Plugins/ChatLog \
    /app/Cuberite/world \
    /app/Cuberite/world_nether \
    /app/Cuberite/world_the_end \
    && chmod -R 777 /app/Cuberite/Plugins /app/Cuberite/world*

# Expose necessary ports
EXPOSE 8081
EXPOSE 25565
EXPOSE 6699

# Optional: Java memory limits
ENV JAVA_OPTS="-Xms512m -Xmx1g"

# Start the server
CMD ["./main.sh"]
