#!/bin/bash

apt-get update

#docker
apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSl https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce docker-compose -y
usermod -aG docker vatican
docker network create vatican-bridge

#minecraft firewall rules
ufw allow 25565
ufw allow 25566
ufw allow 25567

#plex
ufw allow 32400
