#!/bin/bash
cp networking/* /etc/systemd/network
systemctl enable --now systemd-networkd.service

echo "** Reboot required **"