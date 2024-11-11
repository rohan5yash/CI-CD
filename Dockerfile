# Stage 1: Build the application using Maven
FROM maven:3.8-jdk-17-slim as builder

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml and install dependencies
COPY pom.xml .

# Fetch the dependencies without packaging
RUN mvn dependency:go-offline

# Copy the application source code
COPY src /app/src

# Package the application (this will create a .jar file)
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=builder /app/target/helloworld-1.0-SNAPSHOT.jar /app/helloworld.jar

# Expose the application port (if it's a web application)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/helloworld.jar"]

