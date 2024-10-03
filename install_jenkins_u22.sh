#!/bin/bash

# Update the package list
sudo apt update

# Install Java (required for Jenkins)
sudo apt install -y openjdk-11-jdk

# Verify Java installation
java -version

# Add Jenkins GPG key to your system
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository to the sources list
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again to include Jenkins repository
sudo apt update

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start at boot
sudo systemctl enable jenkins

# Check Jenkins service status
sudo systemctl status jenkins

# Open port 8080 in the firewall (if ufw is enabled)
sudo ufw allow 8080

# Allow OpenSSH (for remote access, if not already allowed)
sudo ufw allow OpenSSH

# Reload firewall rules to apply changes
sudo ufw reload

# Enable firewall (if not already enabled)
sudo ufw enable

# Output Jenkins initial admin password
echo "Jenkins is installed. To complete the setup, visit http://your_server_ip_or_domain:8080"
echo "Initial Admin Password (found in /var/lib/jenkins/secrets/initialAdminPassword):"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
