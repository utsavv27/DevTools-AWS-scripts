#!/bin/bash

# MongoDB 6.0 Installation Script for Ubuntu 22.04 with Custom Port and Bind IP

set -e

echo "📦 Importing MongoDB 6.0 GPG Key..."
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
  gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor

echo "📝 Creating MongoDB 6.0 source list..."
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

echo "🔄 Updating package database..."
sudo apt update

echo "📥 Installing MongoDB 6.0..."
sudo apt install -y mongodb-org

echo "🛠 Modifying mongod.conf for custom port and bindIp..."

# Backup original config
sudo cp /etc/mongod.conf /etc/mongod.conf.backup

# Replace port and bindIp
sudo sed -i 's/^\( *port:\).*/\1 23723/' /etc/mongod.conf
sudo sed -i 's/^\( *bindIp:\).*/\1 0.0.0.0/' /etc/mongod.conf

echo "🚀 Restarting MongoDB with new configuration..."
sudo systemctl restart mongod
sudo systemctl enable mongod

echo "✅ Checking MongoDB status..."
sudo systemctl status mongod --no-pager

echo "✅ MongoDB is now listening on port 23723 and accessible from any IP address."
echo "💡 To verify, run: mongosh --port 23723"
