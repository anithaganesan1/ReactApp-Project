#!/usr/bin/env bash
echo "🛠️  Building Docker image..."
docker-compose build
echo "✅ Image built."
docker build -t aniganesan/dev:latest .
