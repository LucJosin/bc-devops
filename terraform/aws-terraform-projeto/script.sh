#!/bin/bash

cd /
apt-get update && apt-get upgrade -y
apt-get install -y apache2 unzip
systemctl start apache2
systemctl enable apache2
sudo curl -sL https://github.com/luizcarlos16/site-bootcamp-devops/archive/refs/heads/main.zip -o /tmp/site-bootcamp-devops.zip
sudo unzip /tmp/site-bootcamp-devops.zip -d /tmp
sudo mv /tmp/site-bootcamp-devops-main/* /var/www/html/
sudo rm -rf /var/www/html/site-bootcamp-devops-main