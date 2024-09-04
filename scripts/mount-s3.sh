#!/bin/bash
sudo apt-get install s3fs
echo <ACCESS_KEY>:<SECRET_KEY > ~/.passwd-s3fs
cat ~/ .passwd-s3fs ACCESS_KEY:SECRET_KEY
chmod 600 .passwd-s3fs
mkdir ~/s3-drive
s3fs <bucketname> ~/s3-drive
mount

## modify accoridingly