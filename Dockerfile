# Stage 1: Build the application using Maven (JDK 17)
FROM maven:3.9.9-openjdk-17-slim AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml (even though it's not required for this case, it could be used for future extension)
COPY pom.xml /app/

# Copy the HelloWorld.java file directly
COPY HelloWorld.java /app/HelloWorld.java

# Package the application (This will compile HelloWorld.java using Maven)
RUN mvn clean compile

# Stage 2: Run the application using JDK 17
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the compiled class file from the build stage
COPY --from=builder /app/target/classes/HelloWorld.class /app/HelloWorld.class

# Run the application
CMD ["java", "HelloWorld"]

