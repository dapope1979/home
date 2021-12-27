#!/bin/bash

# https://wiki.debian.org/ZFS
# attended install due to license warning
apt install -y -t bullseye-backports zfsutils-linux
zpool import well
