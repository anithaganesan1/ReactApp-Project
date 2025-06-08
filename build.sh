#!/bin/bash

# Fail on any error
set -e

# Variables
IMAGE_NAME="anithaganesan1/react-app"
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

echo "📦 Installing dependencies..."
npm install

echo "🔨 Building React app..."
npm run build

echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME:$BRANCH_NAME .

echo "📤 Pushing Docker image to Docker Hub..."
docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
docker push $IMAGE_NAME:$BRANCH_NAME

echo "✅ Build and push completed for branch $BRANCH_NAME"
