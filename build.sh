#!/bin/bash

DOCKER_IMAGE="jinweijiedocker/zerotier-planet"

# Parse command line arguments
PUSH=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -y)
            PUSH=true
            shift
            ;;
        *)
            echo "Unknown option $1"
            echo "Usage: $0 [-y]"
            echo "  -y    Push the image to registry after building"
            exit 1
            ;;
    esac
done

# Build the Docker image
if [ "$PUSH" = true ]; then
    echo "Building and pushing Docker image..."
    docker buildx build --platform linux/arm64,linux/amd64 -t "$DOCKER_IMAGE":latest --push .
else
    echo "Building Docker image (not pushing)..."
    docker buildx build --platform linux/arm64,linux/amd64 -t "$DOCKER_IMAGE":latest .
fi
