#!/bin/bash
rm /etc/network/interfaces
systemctl disable --now networking.service

cp networking/* /etc/systemd/network
systemctl enable --now systemd-networkd.service
