# Use OpenJDK base image
FROM openjdk:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the compiled .jar file into the container
COPY target/helloworld-1.0-SNAPSHOT.jar /app/helloworld.jar

# Expose the port that the Java application will use
EXPOSE 8080

# Command to run the Java application
CMD ["java", "-jar", "/app/helloworld.jar"]

