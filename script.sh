#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
# Install required dependencies
sudo apt-get install -y ca-certificates curl

# Create Docker keyring directory
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
-o /etc/apt/keyrings/docker.asc

sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update repository
sudo apt-get update -y

# Install Docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add Ubuntu user to Docker group
sudo usermod -aG docker ubuntu

# Verify installation
sudo docker --version
sudo docker compose version

echo "Docker installation completed successfully!"
