#!/bin/bash
set -e

IMAGE_NAME="anithaganesan1/react-app"
BRANCH=$(git rev-parse --abbrev-ref HEAD)
TAG="latest"

if [ "$BRANCH" == "dev" ]; then
  TAG="dev"
elif [ "$BRANCH" == "master" ]; then
  TAG="prod"
fi

echo "Deploying image $IMAGE_NAME:$TAG"

# Pull the latest image from Docker Hub
docker pull $IMAGE_NAME:$TAG

# Stop and remove existing container (if any)
docker stop react-app || true
docker rm react-app || true

# Run the new container
docker run -d -p 80:80 --name react-app $IMAGE_NAME:$TAG

echo "Deployment done."
