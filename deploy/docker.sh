#!/bin/bash

set -x

sudo yum update -y

sleep 10

# Setting up Docker
sudo amazon-linux-extras install docker
sudo usermod -a -G docker ec2-user

sudo systemctl enable docker
sudo systemctl enable atd
sudo systemctl enable --now docker

sudo yum clean all
sudo rm -rf /var/cache/yum/
exit 0