#!/bin/bash
dnf install -y samba
rm /etc/samba/smb.conf

cp conf/smb.conf /etc/samba/smb.conf

chcon -t samba_share_t /mnt/well/share
chcon -t samba_share_t /mnt/well/backups
systemctl enable --now smb.service