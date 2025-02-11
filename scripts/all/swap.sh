#!/bin/bash

# Set Swap File Size (Change as needed)
SWAP_SIZE="8G"
SWAP_FILE="/swapfile"

echo "🚀 Increasing Swap Memory to $SWAP_SIZE..."

# Step 1: Disable existing swap if any
echo "🔄 Disabling existing swap..."
sudo swapoff -a

# Step 2: Create a new swap file
echo "📁 Creating swap file at $SWAP_FILE..."
sudo fallocate -l $SWAP_SIZE $SWAP_FILE || sudo dd if=/dev/zero of=$SWAP_FILE bs=1M count=$((8 * 1024))

# Step 3: Set correct permissions
echo "🔒 Setting permissions..."
sudo chmod 600 $SWAP_FILE

# Step 4: Format as swap space
echo "⚡ Formatting swap file..."
sudo mkswap $SWAP_FILE

# Step 5: Enable swap
echo "✅ Enabling swap..."
sudo swapon $SWAP_FILE

# Step 6: Make swap permanent
echo "📝 Adding swap entry to /etc/fstab..."
echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab

# Step 7: Verify
echo "📊 Verifying swap..."
free -h
swapon --show

echo "🚀 Swap memory increased successfully!"
