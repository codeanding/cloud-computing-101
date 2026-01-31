# Cloud 101 Demo

A simple Spring Boot application demonstrating cloud deployment to AWS, GCP, and Azure.

## One-Click Deploy

### AWS App Runner
[![Deploy to AWS](https://img.shields.io/badge/Deploy%20to-AWS%20App%20Runner-FF9900?style=for-the-badge&logo=amazon-aws)](https://console.aws.amazon.com/apprunner/home#/create)

1. Click the button above
2. Choose "Source code repository"
3. Connect your GitHub account and select this repo
4. Set runtime to "Java 21 Corretto"
5. Set build command: `./mvnw package -DskipTests`
6. Set start command: `java -jar target/*.jar`
7. Add environment variable: `CLOUD_PROVIDER=AWS App Runner`

### Google Cloud Run
[![Run on Google Cloud](https://deploy.cloud.run/button.svg)](https://deploy.cloud.run)

### Azure App Service
[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fcodeanding%2Fcloud-computing-101%2Fmain%2Fazure%2Fazuredeploy.json)

## Local Development (Docker Only)

No Java or Maven installation required - everything runs in Docker.

```bash
# Build and run
docker compose up --build

# Test the endpoints
curl http://localhost:8080/hello
# Returns: Hello from Local Docker!

curl http://localhost:8080/health
# Returns: {"status":"UP","provider":"Local Docker"}

# Stop
docker compose down
```

## API Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /hello` | Returns greeting with cloud provider name |
| `GET /health` | Health check with status and provider |

## Project Structure

```
cloud-101-demo/
├── src/main/java/com/example/demo/
│   ├── DemoApplication.java      # Spring Boot main class
│   └── HelloController.java      # REST endpoints
├── src/main/resources/
│   └── application.properties    # Server config
├── pom.xml                       # Maven config (Spring Boot 3.x, Java 21)
├── Dockerfile                    # Multi-arch container build
├── docker-compose.yml            # Local development
├── app.json                      # GCP Cloud Run config
└── azure/
    └── azuredeploy.json          # Azure ARM template
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `CLOUD_PROVIDER` | Unknown | Display name for the cloud provider |
| `PORT` | 8080 | Server port (set automatically by cloud providers) |

## Tech Stack

- Java 11
- Spring Boot 3.2
- Docker (multi-arch amd64 for cloud compatibility)
