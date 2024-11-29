#!/bin/bash

# Define the environment variable
NODE_OPTION_LINE='export NODE_OPTIONS="--max-old-space-size=8192"'

# Check if the line already exists in .bashrc
if grep -Fxq "$NODE_OPTION_LINE" ~/.bashrc; then
    echo "NODE_OPTIONS is already set in ~/.bashrc"
else
    # Add the line to .bashrc
    echo "$NODE_OPTION_LINE" >> ~/.bashrc
    echo "NODE_OPTIONS added to ~/.bashrc"
fi

# Reload the .bashrc file
source ~/.bashrc
echo "Shell configuration reloaded."

# Check the current Node.js memory limit
echo "Checking Node.js heap size limit:"
node -e 'console.log("Heap size limit (MB):", v8.getHeapStatistics().heap_size_limit / (1024 * 1024))'
