#!/bin/bash

# MongoDB 6.0 Installation Script for Ubuntu 22.04

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

echo "🚀 Starting and enabling MongoDB..."
sudo systemctl start mongod
sudo systemctl enable mongod

echo "✅ Checking MongoDB status..."
sudo systemctl status mongod --no-pager

echo "💡 To verify, run: mongosh"
