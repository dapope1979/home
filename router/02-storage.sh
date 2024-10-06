#!/bin/bash

source /usr/local/sbin/configs/.env

printf "\nConfiguring disk $DISK to mount at startup.\n"

mkdir -p /mnt/well

cat <<EOF>> /etc/fstab
UUID=$DISK /mnt/well btrfs defaults 0 0
EOF

mount -av