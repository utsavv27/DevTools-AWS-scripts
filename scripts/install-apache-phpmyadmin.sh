#!/bin/bash
sudo apt-get update
sudo apt install apache2
sudo ufw app list
sudo ufw allow in "Apache"
sudo ufw status


#configurations to load phpmyadmin page

# Do the following:
# Navigate to the apache folder
#   cd /var/www/html

# Ensure ownership of the folder (assuming signed in with ec2-user)
#   sudo chown ec2-user .

# Download phpMyAdmin
#   wget https://files.phpmyadmin.net/phpMyAdmin/4.5.0.2/phpMyAdmin-4.5.0.2-all-languages.tar.bz2

# Unzip
#   tar -jxf phpMyAdmin-4.5.0.2-all-languages.tar.bz2 -C /var/www/html

# Rename the folder
#   mv phpMyAdmin-4.5.0.2-all-languages phpmyadmin

# Remove the zip file
#   rm -rf phpMyAdmin-4.5.0.2-all-languages.tar.bz2

# restart the service
#   sudo service apache2 restart

# extra
#   sudo apt-get install phpmyadmin php-mbstring php-gettext
#   sudo service apache2 restart
