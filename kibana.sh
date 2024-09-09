#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

# Install dependencies
echo "Installing required dependencies..."
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

# Add Elasticsearch GPG Key
echo "Adding Elasticsearch GPG Key..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add Elasticsearch repository
echo "Adding Elasticsearch repository..."
sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'

# Update the package index again
echo "Updating package index..."
sudo apt-get update -y

# Install Kibana
echo "Installing Kibana..."
sudo apt-get install kibana -y

# Configure Kibana to listen on all interfaces
echo "Configuring Kibana..."
sudo sed -i 's/#server.host: "localhost"/server.host: "0.0.0.0"/' /etc/kibana/kibana.yml
sudo sed -i 's/#elasticsearch.hosts: \["http:\/\/localhost:9200"]/elasticsearch.hosts: \["http:\/\/localhost:9200"]/g' /etc/kibana/kibana.yml

# Enable and start Kibana service
echo "Enabling and starting Kibana..."
sudo systemctl enable kibana
sudo systemctl start kibana

# Allow port 5601 in the firewall
echo "Allowing Kibana port (5601) in the firewall..."
sudo ufw allow 5601

# Final output message
echo "Kibana has been installed and configured successfully. You can access it at http://<your_server_ip>:5601"
