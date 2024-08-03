#!/bin/bash

# https://wiki.debian.org/ZFS

codename=$(lsb_release -cs);echo "deb http://deb.debian.org/debian $codename-backports main contrib non-free"|tee -a /etc/apt/sources.list
apt update
apt install -y linux-headers-amd64
apt install -y -t stable-backports zfsutils-linux

# attended install due to license warning
#apt install -y -t bullseye-backports zfsutils-linux
#zpool import well
