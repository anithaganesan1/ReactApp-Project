#!/bin/bash

# Variables
REMOTE_USER=ec2-user
REMOTE_HOST=your-ec2-ip
KEY_PATH=~/Downloads/gardle-unb-ec2.pem
REMOTE_PATH=/home/ec2-user/deploy
IMAGE_NAME="anithaganesan1/react-app"
BRANCH_NAME=master

# SSH into the server and deploy
echo "🚀 Deploying to production..."

ssh -i $KEY_PATH $REMOTE_USER@$REMOTE_HOST << EOF
  echo "📦 Pulling Docker image..."
  docker pull $IMAGE_NAME:$BRANCH_NAME
  
  echo "🧹 Cleaning up old container..."
  docker rm -f react-prod || true

  echo "🚀 Running new container..."
  docker run -d --name react-prod -p 80:80 $IMAGE_NAME:$BRANCH_NAME
EOF

echo "✅ Deployment complete!"
