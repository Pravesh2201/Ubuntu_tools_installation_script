#!/bin/bash

# Exit immediately if any command fails
set -e

# Step 1: Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Step 2: Install prerequisites
echo "Installing prerequisites..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Step 3: Add Docker’s official GPG key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Step 4: Add Docker repository
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Step 5: Update package list again
echo "Updating package list..."
sudo apt update

# Step 6: Install Docker
echo "Installing Docker..."
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Step 7: Enable Docker service to start on boot
echo "Enabling Docker to start on boot..."
sudo systemctl enable docker

# Step 8: Add user to Docker group (optional)
echo "Adding current user to Docker group..."
sudo usermod -aG docker ${USER}

# Step 9: Install Docker Compose
DOCKER_COMPOSE_VERSION="v2.20.0"
echo "Installing Docker Compose version $DOCKER_COMPOSE_VERSION..."
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Step 10: Verify installation
echo "Verifying Docker and Docker Compose installation..."
docker --version
docker-compose --version

# Step 11: Print completion message
echo "Docker and Docker Compose installation completed successfully!"

echo "Please log out and log back in or run 'newgrp docker' to activate Docker group for the current user."
