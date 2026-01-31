# Build stage
FROM --platform=linux/amd64 eclipse-temurin:11-jdk-alpine AS build

WORKDIR /app

# Copy Maven wrapper and pom.xml first (better layer caching)
COPY pom.xml .

# Download dependencies (cached unless pom.xml changes)
RUN apk add --no-cache curl && \
    curl -fsSL https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz | tar xz -C /opt && \
    ln -s /opt/apache-maven-3.9.6/bin/mvn /usr/local/bin/mvn && \
    mvn dependency:go-offline -B

# Copy source and build
COPY src ./src
RUN mvn package -DskipTests -B

# Runtime stage
FROM --platform=linux/amd64 eclipse-temurin:11-jre-alpine

WORKDIR /app

# Copy the built jar
COPY --from=build /app/target/*.jar app.jar

# Cloud Run uses PORT env variable
ENV PORT=8080
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
