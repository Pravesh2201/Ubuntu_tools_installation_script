#!/bin/bash

# Update the system
echo "Updating system..."
sudo apt update && sudo apt upgrade -y

# Install necessary dependencies
echo "Installing necessary packages..."
sudo apt install -y ca-certificates curl gnupg wget apt-transport-https

# Add Docker's official GPG key and repository
echo "Adding Docker's GPG key and repository..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
echo "Installing Docker..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add current user to the Docker group
echo "Adding user to Docker group..."
sudo usermod -aG docker $USER
newgrp docker

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version

# Install Kubectl
echo "Installing Kubectl..."
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version -o yaml

# Start Minikube with Docker driver
echo "Starting Minikube with Docker driver..."
minikube start --driver=docker

# Check Minikube status
echo "Checking Minikube status..."
minikube status

# Verify Kubernetes nodes
echo "Verifying Kubernetes nodes..."
kubectl get nodes

# Check Kubernetes cluster info
echo "Checking cluster information..."
kubectl cluster-info

# Enable Minikube addons
echo "Enabling Minikube addons..."
minikube addons enable dashboard
minikube addons enable ingress

# Open Minikube dashboard
echo "Opening Minikube dashboard..."
minikube dashboard &
