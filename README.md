# Task Manager API

A Rails API for managing tasks.

## Requirements

* Docker and Docker Compose

## Getting Started with Docker Compose

This project includes Docker Compose configuration for easy development and deployment.

### Development Environment

For development, we use a simplified Docker setup with:
- A development-focused Dockerfile (Dockerfile.dev)
- Full source code mounting for live code changes
- No user permission restrictions for easier development

### Starting the Application

1. Make sure you have Docker and Docker Compose installed on your system.

2. Copy the `.env.default` file to `.env`:
   ```bash
   cp .env.default .env
   ```
   You can modify the environment variable values in the `.env` file if necessary.

3. Start the application using Docker Compose:
   ```bash
   docker compose up -d
   ```

4. The API will be available at http://localhost:3008

### Stopping the Application

To stop the application:
```bash
docker-compose down
```

### Viewing Logs

To view the application logs:
```bash
docker-compose logs -f backend
```

## Development

For development without Docker, please refer to the standard Rails development setup.

## Documentazione API

La documentazione interattiva delle API è disponibile tramite Swagger all'indirizzo:

    http://localhost:3008/api-docs

Utilizza questa interfaccia per esplorare e testare tutte le API esposte dall'applicazione.

## Testing

For information about testing, see [TESTING.md](TESTING.md).
