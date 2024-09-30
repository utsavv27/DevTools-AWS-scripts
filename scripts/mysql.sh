#!/bin/bash
sudo apt-get install mysql-server mysql-client
sudo apt-get install phpmyadmin
sudo systemctl start mysql.service

#configure mysql list of commands
#   sudo mysql
#   ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
#   exit