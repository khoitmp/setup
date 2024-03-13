#!/bin/bash

# Install general tools
sudo apt install curl
sudo apt install net-tools
sudo apt install traceroute

# Install Firewall
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Install Docker
## Add Docker's official GPG key
sudo apt-get update
sudo apt-get install ca-certificates gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## Add the repository to APT sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
