#!/bin/bash

apt-get update
apt-get upgrade

# Network
rm /etc/netplan/*
cp 01-netcfg.yaml /etc/netplan/
# disable DNS stub listener & use DNS from DHCP (also lets pihole use ports)
sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
netplan generate
netplan apply

#ZFS
apt install zfsutils-linux
zpool import -f well

# Docker
apt-get remove -y docker docker-engine docker.io containerd runc
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
usermod -aG docker vatican

#minecraft firewall rules
ufw allow 25565
ufw allow 25566
ufw allow 25567
ufw allow 2456

#plex
ufw allow 32400

#pihole
ufw allow 80
ufw allow 443

