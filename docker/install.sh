#!/bin/bash

# Checking requirements
# root privileges
if [ "$EUID" -ne 0 ]; then 
    echo "Root privileges required."
    exit 1
fi

echo "1. Updating package index..."
sudo apt update

echo "2. Installing packages..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common gnupg

echo "3. Add Docker’s Official GPG Key & Docker Repository..."
# Currently, hard checking OS type
if [ "$(lsb_release -si)" = 'Ubuntu' ]; then
    echo 'This is ubuntu'
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu noble stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
else
    echo 'This is not ubuntu'
fi

echo "4. Update Package Index..."
sudo apt update

echo "5. Install Docker Engine and Related Packages..."
sudo apt install docker-ce docker-ce-cli containerd.io

echo "6. Start and Enable Docker Service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "7. Verify Docker Installation..."
sudo docker run hello-world

echo "8. Configuring to Run Docker Without sudo (re-login may be required)..."
sudo usermod -aG docker $USER

