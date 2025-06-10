#!/bin/bash

# Stop and remove any running container with name react-app
#docker stop react-app 2>/dev/null || true
#docker rm react-app 2>/dev/null || true

# Run the container with name react-app, mapping port 3000 on host to 80 in container
#docker run -d --name react-app -p 3000:80 aniganesan/dev:latest
#!/bin/bash

BRANCH=$1

if [ "$BRANCH" == "master" ]; then
    echo "Deploying production container..."
    docker rm -f prod-container || true
    docker run -d --name prod-container -p 80:80 aniganesan/prod
else
    echo "Deploying development container..."
    docker rm -f dev-container || true
    docker run -d --name dev-container -p 3000:80 aniganesan/dev
fi

