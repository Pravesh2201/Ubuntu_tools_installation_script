#!/bin/bash

# Add Ansible PPA repository (automatically confirm)
sudo apt-add-repository -y ppa:ansible/ansible

# Update package lists
sudo apt update

# Install Ansible
sudo apt install ansible -y
