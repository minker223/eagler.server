# Use a supported Java 17 image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy all files
COPY . /app

# Make main.sh and Cuberite executable
RUN chmod +x ./main.sh ./Cuberite/Cuberite

# Expose ports (no inline comments)
EXPOSE 8081
EXPOSE 25565
EXPOSE 6699

# Optional: Java memory limits
ENV JAVA_OPTS="-Xms512m -Xmx1g"

# Start the server
CMD ["./main.sh"]

