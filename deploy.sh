#!/usr/bin/env bash
echo "🚀 Deploying Docker container..."
docker-compose up -d --build
echo "✅ Running at http://localhost:3000"
