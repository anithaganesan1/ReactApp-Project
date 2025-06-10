#!/bin/bash

# Build the Docker image with tag
#docker build -t aniganesan/dev:latest .
#!/bin/bash
IMAGE_NAME=$1
echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .
