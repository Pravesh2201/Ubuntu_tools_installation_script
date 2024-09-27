#!/bin/bash

# Update package lists
sudo apt update

# Install OpenJDK 11
sudo apt install openjdk-11-jdk -y

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository to sources list
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package lists again
sudo apt update

# Install Jenkins
sudo apt install jenkins -y

# Check Jenkins service status
sudo systemctl status jenkins

# Allow Jenkins port 8080 through firewall
sudo ufw allow 8080

# Check firewall status
sudo ufw status

# Enable UFW
sudo ufw enable -y

# Display Jenkins initial admin password
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
