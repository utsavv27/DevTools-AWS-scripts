#!/bin/bash
sudo apt-get install s3fs
sudo nano .passwd-s3fs
cat ~/.passwd-s3fs 
sudo chmod 600 .passwd-s3fs
sudo mkdir ~/s3-drive
sudo s3fs <bucketname> ~/s3-drive
mount

## modify accoridingly