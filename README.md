# Conduit Containerized (RealWorld App)

A full-stack implementation of the [RealWorld](https://github.com/gothinkster/realworld) spec, featuring a Django backend and an Angular frontend, fully containerized using Docker and Docker Compose.

## 📖 Table of Contents

- [🚀 Quick Start](#-quick-start)
- [🏗 Project Structure](#-project-structure)
- [🛠 Tech Stack](#-tech-stack)
- [⚙️ Environment Variables](#️-environment-variables)
- [📋 Usage](#-usage)

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

## ⚙️ Environment Variables

Key variables in your `.env` file:

- `CONDUIT_FE_PORT`: The public port for the entire application (default: 4200).
- `DB_NAME`, `DB_USER`, `DB_PASSWORD`: PostgreSQL credentials.
- `DJANGO_SUPERUSER_...`: Credentials for the automatically created admin account.
- `DJANGO_DEBUG`: Set to `True` for development, `False` for production.

## 📋 Usage

This section provides a detailed guide on how to configure and customize the application.

### Configuration & Customization

The system is primarily controlled via the `.env` file. Below are common scenarios for modification:

#### 1. Changing the Public Port

If port `4200` is already in use on your host machine, you can change the external port by modifying `CONDUIT_FE_PORT`:

```env
CONDUIT_FE_PORT=8080
```

After changing this, restart the containers: `docker compose up -d`.

#### 2. Development vs. Production Mode

The `DJANGO_DEBUG` variable controls the backend behavior:

- `True`: Detailed error pages in the browser (ideal for development).
- `False`: Security-hardened mode, minimal error details (recommended for production).

#### 3. Database Credentials

The variables `DB_NAME`, `DB_USER`, and `DB_PASSWORD` must match the `POSTGRES_` variables. These are used by both the Django backend and the PostgreSQL container to initialize and connect to the database.

#### 4. Connecting the Frontend to the API

The `API_URL` in `.env` tells the Angular application where to find the backend API. In this containerized setup, it is proxied through Nginx, but you can point it to a remote API if needed.

### Nginx Configuration

The `nginx.conf` file manages the routing between the frontend and backend.

- **Enabling Access Logs:** By default, `access_log off;` is set for performance. To track requests, change this to a file path or `/dev/stdout`.
- **Custom Routing:** If you add new services or endpoints, you can update the `server` block in `nginx.conf` to include additional `location` directives.

### Useful Commands

#### Viewing Logs

- **All services:** `docker compose logs -f`
- **Backend only:** `docker compose logs -f backend`
- **Export logs to file:** `docker compose logs > conduit-logs.txt`

#### Management

- **Stop application:** `docker compose down`
- **Restart application:** `docker compose restart`
- **Access Backend Terminal:** `docker compose exec backend bash`
- **Run Django Management Commands:** `docker compose exec backend python manage.py <command>`

### Logging Configuration

The backend is configured with `PYTHONUNBUFFERED=1` to ensure logs appear in real-time in the Docker output. Frontend error logs are sent to `stderr`. Access logs for the frontend are disabled by default in `nginx.conf` but can be enabled for debugging.
