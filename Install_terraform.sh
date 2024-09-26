#!/bin/bash

# Update the package list
sudo apt update

# Install unzip
sudo apt install -y unzip

# Set the Terraform version you want to install
TERRAFORM_VERSION="VERSION"  # Replace with the desired version
TERRAFORM_ZIP="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# Download the specified version of Terraform
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_ZIP}

# Install required packages
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

# Add HashiCorp GPG key
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

# Verify the GPG key
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint

# Add HashiCorp to the package source list
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update package list again
sudo apt update

# Install Terraform
sudo apt-get install -y terraform

# Display help for Terraform
terraform -help
terraform -help plan

# Enable auto-completion for Terraform
touch ~/.bashrc
terraform -install-autocomplete

# Display the installed version of Terraform
terraform --version

# Clean up
rm -f ${TERRAFORM_ZIP}
