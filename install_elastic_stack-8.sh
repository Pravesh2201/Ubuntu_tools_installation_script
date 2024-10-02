#!/bin/bash

# Exit immediately if any command exits with a non-zero status
set -e

# Function to display status messages
echo_status() {
  echo "========================================="
  echo "$1"
  echo "========================================="
}

# Step 1: Add the Elasticsearch GPG Key
echo_status "Adding Elasticsearch GPG Key"
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

# Step 2: Install apt-transport-https
echo_status "Installing apt-transport-https"
sudo apt-get install -y apt-transport-https

# Step 3: Add Elasticsearch APT Repository
echo_status "Adding Elasticsearch APT Repository"
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list

# Step 4: Update the package list and install Elasticsearch
echo_status "Updating package list and installing Elasticsearch"
sudo apt-get update && sudo apt-get install -y elasticsearch

# Step 5: Install Kibana and Logstash
echo_status "Installing Kibana and Logstash"
sudo apt-get install -y kibana logstash

# Step 6: Start Elasticsearch and Kibana services
echo_status "Starting Elasticsearch and Kibana services"
sudo systemctl start elasticsearch
sudo systemctl start kibana

# Step 7: Check the status of Kibana and Elasticsearch services
echo_status "Checking status of Kibana and Elasticsearch"
sudo systemctl status kibana
sudo systemctl status elasticsearch

# Step 8: Restart Elasticsearch and Kibana (optional)
echo_status "Restarting Elasticsearch and Kibana"
sudo systemctl restart elasticsearch
sudo systemctl restart kibana

echo_status "Installation and setup completed successfully"
