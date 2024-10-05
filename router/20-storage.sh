#!/bin/bash

# Mount the btrfs raid1 at boot
# assuming it's the very first BTRFS disk in lsblk
DISK="$(lsblk -f | awk -F"btrfs" '/btrfs/{print $2}' | head -1 | awk '{$1=$1};1')"

echo "Configuring disk $DISK to mount at startup."

cat <<EOF>> /etc/fstab
UUID=$DISK /mnt/well btrfs defaults 0 0
EOF