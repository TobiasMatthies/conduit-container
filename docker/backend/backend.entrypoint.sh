#!/bin/sh

set -e

echo "Wait for Postgesql on port $DB_HOST:$DB_PORT..."

while ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -q; do
  echo "PostgreSQL not ready - sleep for 1 second"
  sleep 1
done

echo "PostgreSQL ready - continue..."

python manage.py collectstatic --noinput
python manage.py makemigrations
python manage.py migrate

echo "creating superuser"
python manage.py shell <<EOF
import os
from django.contrib.auth import get_user_model

User = get_user_model()
username = os.environ.get('DJANGO_SUPERUSER_USERNAME', 'admin')
email = os.environ.get('DJANGO_SUPERUSER_EMAIL', 'admin@example.com')
password = os.environ.get('DJANGO_SUPERUSER_PASSWORD', 'adminpassword')

if not User.objects.filter(username=username).exists():
    print(f"Creating superuser '{username}'...")
    # Korrekter Aufruf: username hier übergeben
    User.objects.create_superuser(username=username, email=email, password=password)
    print(f"Superuser '{username}' created.")
else:
    print(f"Superuser '{username}' already exists.")
EOF

python manage.py runserver 0.0.0.0:8000
