#!/bin/bash

# Exit on error
set -e

# Variables
REMOTE_USER=ec2-user
REMOTE_HOST=ec2-13-203-207-81.ap-south-1.compute.amazonaws.com
KEY_PATH="$HOME/Downloads/gardle-unb-ec2.pem"
IMAGE_NAME="anithaganesan1/react-app"
BRANCH_NAME=dev

echo "🚀 Starting deployment to $REMOTE_HOST..."

# SSH into EC2 and run deployment commands
ssh -o StrictHostKeyChecking=no -i "$KEY_PATH" $REMOTE_USER@$REMOTE_HOST << EOF
  echo "📦 Pulling Docker image..."
  docker pull $IMAGE_NAME:$BRANCH_NAME

  echo "🧹 Removing old container if exists..."
  docker rm -f react-prod || true

  echo "🚀 Starting new container..."
  docker run -d --name react-prod -p 80:80 $IMAGE_NAME:$BRANCH_NAME

  echo "✅ Deployment completed on EC2!"
EOF
