FROM python:3.9-slim-bookworm

ENV PYTHONUNBUFFERED=1
WORKDIR /app

# Bookworm is modern, so this will work perfectly!
RUN apt-get update && apt-get install -y libpq-dev gcc && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
