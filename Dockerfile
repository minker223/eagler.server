# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy all files into the container
COPY . /app

# Make scripts executable
RUN chmod +x main.sh run.sh

# Expose the ports your server uses
EXPOSE 8081 6699

# Run the main server script
CMD ["./main.sh"]
