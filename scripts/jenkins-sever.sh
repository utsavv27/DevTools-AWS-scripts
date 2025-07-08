#!/bin/bash

set -e

echo "==> Updating system..."
sudo apt update && sudo apt upgrade -y

echo "==> Installing Java (OpenJDK 17)..."
sudo apt install -y openjdk-17-jdk

echo "==> Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "==> Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "==> Updating package list..."
sudo apt update

echo "==> Installing Jenkins..."
sudo apt install -y jenkins

echo "==> Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "==> Allowing port 8080 through UFW firewall..."
sudo ufw allow 8080
sudo ufw reload

echo "==> Jenkins installed and running on port 8080."
echo "==> Get initial admin password below:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

echo ""
echo "==> Open your browser and go to: http://<your-server-ip>:8080"
echo "==> Then follow setup steps to install suggested plugins (includes Pipeline)."
