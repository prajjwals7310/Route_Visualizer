#!/bin/bash

set -e  # Stop script on error

IMAGE_NAME="my-flask-image"
IMAGE_TAG="v3"
FULL_IMAGE="$IMAGE_NAME:$IMAGE_TAG"
DOCKER_HUB_REPO="prajjwal73/$IMAGE_NAME"  # Change to your actual Docker Hub repo

# Step 1: Check Docker installed or not
if ! command -v docker &> /dev/null; then
    echo "[ℹ️] Docker not found. Installing Docker..."

    # Install Docker (Debian/Ubuntu)
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    echo "[✅] Docker installed successfully."
else
    echo "[✅] Docker already installed."
fi

# Step 2: Check if image exists locally
if ! docker image inspect $FULL_IMAGE > /dev/null 2>&1; then
    echo "[📥] Docker image '$FULL_IMAGE' not found locally. Pulling from Docker Hub..."
    docker pull $DOCKER_HUB_REPO:$IMAGE_TAG
else
    echo "[✅] Docker image '$FULL_IMAGE' already present."
fi

# Step 3: Run the container
echo "[🚀] Running container..."
docker run -it --rm -p 9000:9000 $FULL_IMAGE
