#!/bin/bash

# Function to check the current Minikube status
check_minikube() {
  if minikube status > /dev/null 2>&1; then
    echo "Minikube is already installed."
  else
    echo "Minikube is not installed. Proceeding with the installation."
  fi
}

# Install necessary dependencies
install_prerequisites() {
  echo "Updating package list and installing prerequisites..."
  sudo apt-get update -y
  sudo apt-get install -y apt-transport-https ca-certificates curl
}

# Install VirtualBox (Optional if the user selects it)
install_virtualbox() {
  echo "Installing VirtualBox..."
  sudo apt-get install -y virtualbox virtualbox-ext-pack
}

# Install Docker if needed
install_docker() {
  echo "Installing Docker..."
  sudo apt-get install -y docker.io
  sudo systemctl enable docker
  sudo systemctl start docker
}

# Download and install Minikube
install_minikube() {
  echo "Downloading and installing Minikube..."
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/local/bin/minikube
}

# Install kubectl (Optional, but useful for interacting with Kubernetes)
install_kubectl() {
  echo "Installing kubectl..."
  sudo snap install kubectl --classic
}

# Prompt the user to select a driver
choose_driver() {
  echo "Choose the driver for Minikube:"
  echo "1) Docker"
  echo "2) VirtualBox"
  read -p "Enter your choice [1-2]: " driver_choice

  case $driver_choice in
    1)
      echo "Using Docker as the driver..."
      install_docker
      DRIVER="docker"
      ;;
    2)
      echo "Using VirtualBox as the driver..."
      install_virtualbox
      DRIVER="virtualbox"
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
}

# Check if a Minikube cluster exists, and prompt to delete if necessary
check_existing_cluster() {
  if minikube status > /dev/null 2>&1; then
    echo "A Minikube cluster is already running."
    read -p "Do you want to delete the existing cluster? (y/n): " delete_choice
    if [[ $delete_choice == "y" || $delete_choice == "Y" ]]; then
      minikube delete
    else
      echo "Using the existing Minikube cluster."
      exit 0
    fi
  fi
}

# Start Minikube with the chosen driver
start_minikube() {
  echo "Starting Minikube with the $DRIVER driver..."
  minikube start --driver=$DRIVER
}

# Main function to run the steps
main() {
  check_minikube
  install_prerequisites
  install_minikube
  install_kubectl
  choose_driver
  check_existing_cluster
  start_minikube

  echo "Minikube installation complete!"
  minikube status
}

# Run the main function
main
