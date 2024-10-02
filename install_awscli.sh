#!/bin/bash

# Update the package list
echo "Updating package list..."
sudo apt update

# Install necessary dependencies
echo "Installing unzip and curl..."
sudo apt install unzip curl -y

# Download the AWS CLI version 2 installer
echo "Downloading AWS CLI installer..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
echo "Unzipping AWS CLI installer..."
unzip awscliv2.zip

# Install AWS CLI
echo "Installing AWS CLI..."
sudo ./aws/install

# Verify the installation
echo "Verifying AWS CLI installation..."
aws --version

# Clean up installer files
echo "Cleaning up installation files..."
rm -rf awscliv2.zip aws

echo "AWS CLI installation completed successfully."
