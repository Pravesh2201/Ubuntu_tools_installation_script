#!/bin/bash

# Update the system
echo "Updating system..."
sudo apt-get update -y

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Install Docker
echo "Installing Docker..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get update -y
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker

# Add the current user to the Docker group
echo "Adding user to docker group..."
sudo usermod -aG docker $USER

# Install Kubectl
echo "Installing kubectl..."
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get update -y
sudo apt-get install -y kubectl

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start Minikube with Docker driver
echo "Starting Minikube with Docker driver..."
minikube start --driver=docker

# Verify installation
echo "Verifying Minikube installation..."
minikube status

echo "Minikube installation completed successfully!"
