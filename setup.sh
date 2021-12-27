#!/bin/bash

# prereqs
cp sources.list /etc/apt/
apt update
apt upgrade -y
apt install -y curl \
    iptables \
    linux-headers-amd64 \
    bridge-utils \
    openssh-server \
    sudo
usermod -aG sudo user

# Network
cp interfaces /etc/network
cp /etc/sysctl.conf /etc/sysctl.conf.bak
cp sysctl.conf /etc
cp iptables-rules /etc/network
cp iptables /etc/network/if-pre-up.d
chmod 755 /etc/network/if-pre-up.d/iptables
/etc/network/if-pre-up.d/iptables
systemctl restart networking

#ZFS
# https://wiki.debian.org/ZFS
# manually install due to license warning
# apt install -y -t bullseye-backports zfsutils-linux
# manually import the pool

# Docker
apt remove -y docker docker.io containerd runc
apt install -y \
    ca-certificates \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-compose