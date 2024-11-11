# Stage 1: Build the application using Maven
FROM maven:3.8.7-openjdk-17-slim as builder

# Set the working directory in the container
WORKDIR /app

# Copy pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Build the application (This will create the target/your-app.jar file)
RUN mvn clean package

# Stage 2: Create the runtime environment for the application
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage into the container
COPY --from=builder /app/target/your-app.jar ./app.jar

# Expose the port the application will run on (if your app runs on port 8080)
EXPOSE 8080

# Set the command to run the app (use the JAR file)
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

