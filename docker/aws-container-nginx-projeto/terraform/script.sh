#!/bin/bash

cd /

sudo apt-get update && sudo apt-get upgrade -y

sudo apt-get install docker.io -y
sudo systemctl enable --now docker
sudo systemctl start docker

sudo docker pull ghcr.io/bc-devops/aws-container-nginx:latest

sudo docker run --name bc-devops -d -it -p 80:8000 ghcr.io/bc-devops/aws-container-nginx
