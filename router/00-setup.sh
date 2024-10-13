#!/bin/bash

printf "\nCreating empty configs\n"
mkdir -p /usr/local/sbin/configs
cp conf/example.env /usr/local/sbin/configs/.env
cp conf/example.env /usr/local/sbin/configs/do.env
chmod 666 /usr/local/sbin/configs/.env
chmod 600 /usr/local/sbin/configs/do.env

# reminder on how to get the raid disk info into .env
# assuming it's the very first BTRFS disk in lsblk
# DISK="$(lsblk -f | awk -F"btrfs" '/btrfs/{print $2}' | head -1 | awk '{$1=$1};1')"
# echo "$DISK" >> file.txt
# nano /usr/local/sbin/configs/.env