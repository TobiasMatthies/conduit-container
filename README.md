# Conduit Containerized (RealWorld App)

A full-stack implementation of the [RealWorld](https://github.com/gothinkster/realworld) spec, featuring a Django backend and an Angular frontend, fully containerized using Docker and Docker Compose.

## 🏗 Project Structure

```text
.
├── conduit-backend/     # Django REST API source code
├── conduit-frontend/    # Angular source code
├── docker/              # Dockerfiles and entrypoint scripts
│   ├── backend/         # Backend Docker context
│   └── frontend/        # Frontend Docker context
├── docker-compose.yml   # Multi-container orchestration
├── nginx.conf           # Nginx configuration for the frontend
└── .env                 # Environment variables (not tracked in Git)
```

## 🛠 Tech Stack

- **Frontend:** Angular, Nginx
- **Backend:** Python 3.9, Django, Gunicorn
- **Database:** PostgreSQL
- **Orchestration:** Docker Compose

## 🚀 Quick Start

### 1. Prerequisites

Ensure you have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed.

### 2. Configuration

Copy the template environment file and fill in your desired values:

```bash
cp .env.template .env
```

### 3. Build and Run

Start the entire stack with a single command:

```bash
docker compose up --build
```

The application is reachable through the **Frontend Port** (defined as `FE_PORT` in your `.env`):

- **Frontend App:** `http://localhost:4200/`
- **Backend API:** `http://localhost:4200/api/`
- **Django Admin:** `http://localhost:4200/admin/`

_Note: The backend service is not exposed directly to the host machine for security; all requests are proxied through Nginx._

## ⚙️ Environment Variables

Key variables in your `.env` file:

- `FE_PORT`: The public port for the entire application (default: 4200).
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`: PostgreSQL credentials.
- `DJANGO_SUPERUSER_...`: Credentials for the automatically created admin account.

## 📋 Useful Commands

### Viewing Logs

- **All services:** `docker compose logs -f`
- **Backend only:** `docker compose logs -f backend`
- **Export logs to file:** `docker compose logs > conduit-logs.txt`

### Management

- **Stop application:** `docker compose down`
- **Restart application:** `docker compose restart`
- **Access Backend Terminal:** `docker compose exec backend bash`
- **Run Django Management Commands:** `docker compose exec backend python manage.py <command>`

## 📝 Logging Configuration

The backend is configured with `PYTHONUNBUFFERED=1` to ensure logs appear in real-time in the Docker output. Frontend error logs are sent to `stderr`. Access logs for the frontend are disabled by default in `nginx.conf` for performance but can be enabled for debugging.
