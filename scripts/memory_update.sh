#!/bin/bash

# Check for existing swap partitions
echo "Checking for existing swap partitions..."
sudo swapon --show

# Check memory space
echo "Checking memory space..."
free -h

# Check HDD space
echo "Checking HDD space..."
df -h

# Create swap file
SWAPFILE="/swapfile"
SWAPSIZE="4G"

echo "Creating a swap file of size $SWAPSIZE..."
sudo fallocate -l $SWAPSIZE $SWAPFILE

# Verify the swap file creation
echo "Verifying swap file creation..."
ls -lh $SWAPFILE

# Enable swap file
echo "Enabling the swap file..."
sudo chmod 600 $SWAPFILE
sudo mkswap $SWAPFILE
sudo swapon $SWAPFILE

# Make swap file permanent
echo "Making swap file permanent..."
sudo cp /etc/fstab /etc/fstab.bak
echo "$SWAPFILE none swap sw 0 0" | sudo tee -a /etc/fstab

# Set swappiness and cache pressure
echo "Setting swappiness to 10 and vfs_cache_pressure to 50..."
sudo bash -c "echo 'vm.swappiness=10' >> /etc/sysctl.conf"
sudo bash -c "echo 'vm.vfs_cache_pressure=50' >> /etc/sysctl.conf"

# Apply changes
echo "Applying changes..."
sudo sysctl -p

echo "Swap setup complete!"
