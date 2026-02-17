#!/bin/bash
ROOT_DIR="/root/tool-server"
ENV_FILE="$ROOT_DIR/.env"

# 1. Load global variables if .env exists
if [ -f "$ENV_FILE" ]; then
    echo "🔑 Loading global environment variables..."
    export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

echo "🛑 Cleaning up ghost containers..."
docker stop $(docker ps -aq) 2>/dev/null
docker rm $(docker ps -aq) 2>/dev/null

echo "🚀 Starting Tool Server Infrastructure..."
docker network inspect app-network >/dev/null 2>&1 || docker network create app-network

echo "🛡️  Starting Nginx Proxy Manager..."
cd "$ROOT_DIR/nginx-proxy" && docker compose up -d

echo "🕵️  Starting SEOnaut..."
cd "$ROOT_DIR/seonaut" && docker compose up -d

echo "📊 Starting Plausible Analytics..."
cd "$ROOT_DIR/plausible" && docker compose up -d

echo "🎫 Starting osTicket..."
cd "$ROOT_DIR/osticket" && docker compose up -d

echo "📝 Starting DokuWiki..."
cd "$ROOT_DIR/dokuwiki" && docker compose up -d

NPM_NAME=$(docker ps --filter "ancestor=jc21/nginx-proxy-manager" --format "{{.Names}}")

echo "🔗 Building Network Bridges..."
# Added osticket-app and osticket-db to your bridge loop
for container in "$NPM_NAME" "plausible_app" "plausible_db" "SEOnaut-app" "osticket-app" "osticket-db"; do
    docker network connect app-network "$container" 2>/dev/null || true
done

echo "⚙️  Running migrations..."
docker exec SEOnaut-app /app/seonaut migrate >/dev/null 2>&1 || true

echo "⏳ Waiting for Plausible to wake up (this takes ~30s)..."
MAX_RETRIES=15
COUNT=0
while ! docker exec "$NPM_NAME" curl -s -I http://plausible_app:8000 | grep -q "HTTP"; do
  if [ $COUNT -ge $MAX_RETRIES ]; then
    echo "❌ Plausible timeout."
    break
  fi
  echo -n "."
  sleep 3
  COUNT=$((COUNT+1))
done
echo ""

echo "-------------------------------------------"
echo "✅ Current Container Status:"
echo "-------------------------------------------"
docker ps --format "table {{.Names}}\t{{.Status}}"

echo "-------------------------------------------"
echo "🌐 Service Health Check:"
echo "-------------------------------------------"

if docker exec "$NPM_NAME" curl -s -I http://SEOnaut-app:9000 | grep -q "HTTP"; then
    echo "✅ SEO: ONLINE (https://seo.rubenjakob.com)"
else
    echo "❌ SEO: OFFLINE"
fi

if docker exec "$NPM_NAME" curl -s -I http://plausible_app:8000 | grep -q "HTTP"; then
    echo "✅ ANALYTICS: ONLINE (https://analytics.rubenjakob.com)"
else
    echo "❌ ANALYTICS: OFFLINE"
fi

if docker exec "$NPM_NAME" curl -s -I http://osticket-app:80 | grep -q "HTTP"; then
    echo "✅ SUPPORT: ONLINE (https://support.rubenjakob.com)"
else
    echo "❌ SUPPORT: OFFLINE"
fi

if docker exec "$NPM_NAME" curl -s -I http://dokuwiki:80 | grep -q "HTTP"; then
    echo "✅ WIKI: ONLINE (https://wiki.rubenjakob.com)"
else
    echo "❌ WIKI: OFFLINE"
fi
