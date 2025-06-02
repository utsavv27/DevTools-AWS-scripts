#!/bin/bash

# Update and Upgrade the System
sudo apt-get update && sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

# Increase Swap Memory
SWAP_SIZE="4G"
SWAP_FILE="/swapfile"
echo "🚀 Increasing Swap Memory to $SWAP_SIZE..."
sudo swapoff -a
echo "📁 Creating swap file at $SWAP_FILE..."
sudo fallocate -l $SWAP_SIZE $SWAP_FILE || sudo dd if=/dev/zero of=$SWAP_FILE bs=1M count=$((4 * 1024))
sudo chmod 600 $SWAP_FILE
echo "⚡ Formatting swap file..."
sudo mkswap $SWAP_FILE
echo "✅ Enabling swap..."
sudo swapon $SWAP_FILE
echo "$SWAP_FILE none swap sw 0 0" | sudo tee -a /etc/fstab
free -h
swapon --show

# Install Node.js with NVM
sudo apt update -y
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm list-remote
nvm install v20.10.0

# Install PHP 7.2
sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y
sudo apt-get install php7.2 php7.2-fpm php7.2-mbstring php7.2-curl php7.2-json -y
sudo apt-get install php7.2-gd php7.2-xml php7.2-mysql php7.2-zip php-pear php7.2-dev -y
sudo a2enmod proxy_fcgi setenvif -y
sudo a2enconf php7.2-fpm -y
sudo apt-get install libapache2-mod-php7.2
pear config-set php_ini /etc/php/7.2/apache2/php.ini
pecl config-set php_ini /etc/php/7.2/apache2/php.ini
sudo systemctl restart networkd-dispatcher.service

# Install MySQL
sudo apt-get install mysql-server mysql-client -y
sudo systemctl enable mysql.service
sudo systemctl start mysql.service
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'PhXD(G&O]-Dtxr\I';"
sudo mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';"
sudo mysql -e "CREATE DATABASE phpmyadmin;"
sudo mysql -e "exit;"
sudo systemctl restart networkd-dispatcher.service


# Install PhpMyAdmin
cd /var/www/html
sudo chown ubuntu .
wget https://files.phpmyadmin.net/phpMyAdmin/4.5.0.2/phpMyAdmin-4.5.0.2-all-languages.tar.bz2
tar -jxf phpMyAdmin-4.5.0.2-all-languages.tar.bz2 -C /var/www/html
mv phpMyAdmin-4.5.0.2-all-languages phpmyadmin
rm -rf phpMyAdmin-4.5.0.2-all-languages.tar.bz2

# # Configure phpMyAdmin blowfish secret
# CONFIG_FILE="/etc/phpmyadmin/config.inc.php"
# echo "🔑 Configuring blowfish secret for phpMyAdmin..."
# if [ -f "$CONFIG_FILE" ]; then
#     SECRET=$(openssl rand -base64 32)
#     sudo sed -i "s|\$cfg['blowfish_secret'] = ''|\$cfg['blowfish_secret'] = '$SECRET'|g" $CONFIG_FILE
# else
#     echo "❗ Configuration file not found: $CONFIG_FILE"
# fi

# Restart Apache to apply changes
sudo systemctl restart apache2
sudo systemctl restart networkd-dispatcher.service

# Install Redis
sudo apt-get install lsb-release curl gpg -y
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update
sudo apt-get install redis -y
sudo systemctl enable redis-server
sudo systemctl start redis-server
sudo systemctl restart networkd-dispatcher.service

# Install Apache with Certbot
sudo apt-get update -y
sudo apt install apache2 -y
sudo a2enmod ssl rewrite headers proxy_http deflate file_cache proxy expires userdir auth_digest
sudo apt install certbot python3-certbot-apache -y
sudo ufw enable -y
sudo ufw allow 'OpenSSH'
sudo ufw allow 'Apache Full'
sudo ufw status
sudo systemctl restart networkd-dispatcher.service


# Install Docker and Docker Compose
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add user 'ubuntu' to the Docker group
sudo usermod -aG docker ubuntu
newgrp docker
groups
sudo systemctl restart docker
sudo systemctl restart networkd-dispatcher.service

# Restart necessary services
echo "🔄 Restarting essential services..."
sudo systemctl restart apache2
sudo systemctl restart mysql
sudo systemctl restart redis-server
sudo systemctl restart networkd-dispatcher.service

# Restart daemons using outdated libraries
echo "🔄 Restarting daemons with outdated libraries..."
sudo systemctl restart networkd-dispatcher.service
sudo NEEDRESTART_MODE=a needrestart -r a

echo "🎉 Setup Complete! All services restarted."
