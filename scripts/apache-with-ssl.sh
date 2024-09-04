#!/bin/bash
sudo apt update
sudo apt-get install apache2
openssl genpkey -algorithm RSA -out server.key
openssl req -new -key server.key -out server.csr -subj "/CN=(IP)"
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt
sudo mv server.crt /etc/ssl/certs/
sudo mv server.key /etc/ssl/private/
sudo apt install apache2
sudo nano /etc/apache2/sites-available/default-ssl.conf ( you can specify your config file here)
sudo a2enmod ssl
sudo a2ensite default-ssl ( you can specify your config file here)
sudo a2ensite reload apache2
sudo systemctl restart apache2
