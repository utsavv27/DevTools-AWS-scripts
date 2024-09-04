#!/bin/bash

# Update package list
sudo apt-get update

# Install Apache
echo "Installing Apache..."
sudo apt-get install -y apache2

# Install PHP and necessary modules
echo "Installing PHP and necessary modules..."
sudo apt-get install -y php libapache2-mod-php php-mysql

# Install MySQL
echo "Installing MySQL..."
sudo apt-get install -y mysql-server

# Secure MySQL installation (you can automate this with expect, but here it's interactive)
echo "Securing MySQL installation..."
sudo mysql_secure_installation

# Install phpMyAdmin
echo "Installing phpMyAdmin..."
sudo apt-get install -y phpmyadmin

# Enable Apache mods
echo "Enabling Apache mods..."
sudo a2enmod php7.4

# Restart Apache to apply changes
echo "Restarting Apache..."
sudo systemctl restart apache2

# Set permissions (if necessary)
echo "Setting permissions for /var/www/html..."
sudo chown -R www-data:www-data /var/www/html

# Test Apache service
if systemctl status apache2 | grep -q "active (running)"; then
    echo "Apache is running successfully!"
else
    echo "Apache failed to start. Check the logs for details."
fi

# Test MySQL service
if systemctl status mysql | grep -q "active (running)"; then
    echo "MySQL is running successfully!"
else
    echo "MySQL failed to start. Check the logs for details."
fi

echo "Installation completed successfully."
