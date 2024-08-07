#!/bin/bash

apt install -y iptables

mkdir -p /etc/systemd/system
cp firewall/firewall.service /etc/systemd/system/firewall.service
mkdir -p /etc/firewall
cp firewall/enable.sh /etc/firewall/enable.sh
chmod +x /etc/firewall/enable.sh
systemctl enable --now firewall.service