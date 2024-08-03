#!/bin/bash

# https://wiki.debian.org/ZFS
# attended install due to license warning
codename=$(lsb_release -cs);echo "deb http://deb.debian.org/debian $codename-backports main contrib non-free"|tee -a /etc/apt/sources.list
apt update
apt install -y linux-headers-amd64
apt install -y -t stable-backports zfsutils-linux
modeprobe zfs

echo "\n\nHere are the available disks:\n\n"
fdisk -l

echo "\n\nTrying to import pool\n\n"
zpool import well

