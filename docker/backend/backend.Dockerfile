FROM python:3.9-slim-bookworm

ENV PYTHONUNBUFFERED=1
WORKDIR /app

RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

COPY conduit-backend/ .

COPY docker/backend/backend.entrypoint.sh .

RUN chmod +x backend.entrypoint.sh

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn

EXPOSE 8000
CMD ["./backend.entrypoint.sh"]
