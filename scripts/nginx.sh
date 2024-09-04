#!/bin/bash
apt-get update
apt-get install nginx -y
service nginx start
echo "this is $(hostname)">/var/www/html/index.html
