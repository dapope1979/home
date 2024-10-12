#!/bin/bash

source /usr/local/sbin/configs/.env

dnf install -y samba
rm /etc/samba/smb.conf

cp conf/smb.conf /etc/samba/smb.conf

chcon -R -t samba_share_t /mnt/well/share
chcon -R -t samba_share_t /mnt/well/backups
systemctl enable --now smb.service