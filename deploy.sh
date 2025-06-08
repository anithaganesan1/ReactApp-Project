#!/usr/bin/env bash
#echo "🚀 Deploying Docker container..."
#docker-compose up -d --build
#echo "✅ Running at http://localhost:3000"
#!/bin/bash
echo "🚀 Running Docker container..."
docker stop reactjs-app || true
docker rm reactjs-app || true
docker run -d -p 3000:80 --name reactjs-app aniganesan/dev:latest
echo "✅ Deployed and running at http://localhost:3000"
