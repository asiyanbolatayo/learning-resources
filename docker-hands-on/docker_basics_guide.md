# Docker Basics: A Beginner's Guide

## What is Docker?

Docker is a platform that uses containerization technology to package applications and their dependencies into lightweight, portable containers. Think of containers as standardized shipping containers for software - they ensure your application runs the same way regardless of where it's deployed.

## Key Benefits

- **Consistency**: Applications run identically across different environments
- **Portability**: Move applications seamlessly between development, testing, and production
- **Efficiency**: Containers share the host OS kernel, making them more resource-efficient than virtual machines
- **Isolation**: Applications run in isolated environments without interfering with each other

## Core Docker Components

### 1. Docker Images
Images are read-only templates used to create containers. They contain everything needed to run an application: code, runtime, system tools, libraries, and settings.

```bash
# Pull an image from Docker Hub
docker pull nginx:latest

# List local images
docker images

# Remove an image
docker rmi nginx:latest
```

### 2. Docker Containers
Containers are running instances of Docker images. They're lightweight, executable packages that include everything needed to run an application.

```bash
# Run a container
docker run -d -p 80:80 nginx:latest

# List running containers
docker ps

# Stop a container
docker stop container_name

# Remove a container
docker rm container_name
```

### 3. Docker Engine
The core runtime that manages containers, images, networks, and volumes. It consists of:
- **Docker Daemon**: Background service that manages Docker objects
- **Docker CLI**: Command-line interface for interacting with Docker
- **REST API**: Interface for programmatic interaction

## Working with Dockerfiles

A Dockerfile is a text file containing instructions to build a Docker image. Each instruction creates a new layer in the image.

### Common Dockerfile Instructions

```dockerfile
# Use a base image
FROM node:16-alpine

# Set working directory
WORKDIR /app

# Copy files
COPY package*.json ./
COPY . .

# Install dependencies
RUN npm install

# Expose port
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production

# Define the command to run the application
CMD ["npm", "start"]
```

### Building Images

```bash
# Build an image from Dockerfile
docker build -t my-app:v1.0 .

# Build with custom Dockerfile name
docker build -f Dockerfile.prod -t my-app:prod .
```

## Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications using a YAML file.

### Basic docker-compose.yml Structure

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
    volumes:
      - .:/app
      - /app/node_modules
    depends_on:
      - database

  database:
    image: postgres:13
    environment:
      - POSTGRES_DB=myapp
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - db_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"

volumes:
  db_data:
```

### Common Docker Compose Commands

```bash
# Start services
docker-compose up -d

# View running services
docker-compose ps

# View logs
docker-compose logs web

# Stop services
docker-compose down

# Rebuild and start
docker-compose up --build
```

## Image Repositories

### Docker Hub
The default public registry for Docker images.

```bash
# Push to Docker Hub
docker tag my-app:latest username/my-app:latest
docker push username/my-app:latest

# Pull from Docker Hub
docker pull username/my-app:latest
```

### Private Registries
Organizations often use private registries for proprietary images.

```bash
# Tag for private registry
docker tag my-app:latest myregistry.com/my-app:latest

# Push to private registry
docker push myregistry.com/my-app:latest

# Pull from private registry
docker pull myregistry.com/my-app:latest
```

## Docker Networking

Docker creates isolated networks for containers to communicate.

```bash
# Create a custom network
docker network create my-network

# Run container on specific network
docker run -d --network my-network --name web nginx

# List networks
docker network ls
```

## Docker Volumes

Volumes provide persistent data storage for containers.

```bash
# Create a volume
docker volume create my-data

# Use volume in container
docker run -d -v my-data:/app/data my-app

# List volumes
docker volume ls

# Remove volume
docker volume rm my-data
```

## Best Practices

### Dockerfile Optimization
- Use specific base image tags (avoid `latest` in production)
- Minimize layers by combining RUN commands
- Use multi-stage builds for smaller production images
- Copy only necessary files

```dockerfile
# Multi-stage build example
FROM node:16-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:16-alpine AS production
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
CMD ["npm", "start"]
```

### Security Considerations
- Don't run containers as root user
- Use official base images
- Regularly update base images
- Scan images for vulnerabilities
- Use secrets management for sensitive data

### Resource Management
- Set memory and CPU limits
- Use health checks
- Implement proper logging
- Monitor container performance

```yaml
# Resource limits in docker-compose.yml
services:
  web:
    image: my-app
    deploy:
      resources:
        limits:
          memory: 512M
          cpus: '0.5'
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

## Common Use Cases

1. **Development Environment Standardization**: Ensure all developers work with identical environments
2. **Microservices Architecture**: Deploy and manage individual services independently
3. **Continuous Integration/Deployment**: Build, test, and deploy applications consistently
4. **Application Modernization**: Containerize legacy applications for cloud migration
5. **Local Testing**: Test applications locally before deploying to production

## Next Steps

Once you're comfortable with these basics, explore:
- Container orchestration with Kubernetes
- Advanced networking configurations
- Docker security best practices
- Monitoring and logging strategies
- CI/CD integration with Docker

Docker's ecosystem is vast and powerful. Start with simple applications, experiment with different configurations, and gradually build your expertise through hands-on practice.