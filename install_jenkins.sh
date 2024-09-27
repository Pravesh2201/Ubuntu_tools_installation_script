#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Java (OpenJDK 11)
echo "Installing OpenJDK 11..."
sudo apt install openjdk-11-jdk -y

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Add Jenkins GPG key
echo "Adding Jenkins GPG key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian binary/ | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

# Update packages and install Jenkins
echo "Updating package list and installing Jenkins..."
sudo apt update
sudo apt install jenkins -y

# Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Open port 8080 in the firewall (optional)
echo "Configuring firewall for Jenkins (port 8080)..."
sudo ufw allow 8080
sudo ufw reload

# Display Jenkins initial admin password
echo "Jenkins initialAdminPassword:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo "Jenkins installation complete. Access it at http://your_server_ip_or_domain:8080"
