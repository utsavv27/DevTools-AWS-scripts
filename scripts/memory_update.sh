#!/bin/bash
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo swapon --show
free -h
df -h
sudo fallocate -l 4G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo nano /etc/sysctl.conf
