#!/bin/sh

# Use API_URL if provided, otherwise fallback to the default
# In the template we have ${API_URL}
API_URL=${API_URL:-http://127.0.0.1:8282/api}

echo "Generating env.js with API_URL: $API_URL"

sed "s|\${API_URL}|$API_URL|g" /usr/share/nginx/html/assets/env.template.js > /usr/share/nginx/html/assets/env.js

exec "$@"
