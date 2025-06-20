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

2. Set your Rails master key as an environment variable:
   ```bash
   export RAILS_MASTER_KEY=your_master_key_here
   ```
   Note: You can find your master key in the `config/master.key` file.

3. Start the application using Docker Compose:
   ```bash
   docker-compose up -d
   ```

4. The API will be available at http://localhost:3000

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

## API Documentation

The Task Manager API provides the following JSON endpoints:

### Tasks

#### Get a Task

```
GET /api/tasks/:id
```

Response (200 OK):
```json
{
  "id": 1,
  "title": "Complete project",
  "description": "Finish the task manager API implementation",
  "completed": false,
  "created_at": "2023-06-20T13:15:41.000Z",
  "updated_at": "2023-06-20T13:15:41.000Z"
}
```

Error Response (404 Not Found):
```json
{
  "error": "Task not found"
}
```

#### Create a Task

```
POST /api/tasks
```

Request Body:
```json
{
  "task": {
    "title": "New task",
    "description": "Description of the new task",
    "completed": false
  }
}
```

Response (201 Created):
```json
{
  "id": 1,
  "title": "New task",
  "description": "Description of the new task",
  "completed": false,
  "created_at": "2023-06-20T13:15:41.000Z",
  "updated_at": "2023-06-20T13:15:41.000Z"
}
```

Error Response (422 Unprocessable Entity):
```json
{
  "errors": ["Title can't be blank"]
}
```

#### Update a Task

```
PUT/PATCH /api/tasks/:id
```

Request Body:
```json
{
  "task": {
    "title": "Updated task",
    "description": "Updated description",
    "completed": true
  }
}
```

Response (200 OK):
```json
{
  "id": 1,
  "title": "Updated task",
  "description": "Updated description",
  "completed": true,
  "created_at": "2023-06-20T13:15:41.000Z",
  "updated_at": "2023-06-20T14:30:00.000Z"
}
```

Error Responses:
- 404 Not Found:
  ```json
  {
    "error": "Task not found"
  }
  ```
- 422 Unprocessable Entity:
  ```json
  {
    "errors": ["Title can't be blank"]
  }
  ```

#### Delete a Task

```
DELETE /api/tasks/:id
```

Response (204 No Content)

Error Response (404 Not Found):
```json
{
  "error": "Task not found"
}
```

## Testing

For information about testing, see [TESTING.md](TESTING.md).
