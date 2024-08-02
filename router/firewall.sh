#!/bin/bash
cp firewall/firewall.service /etc/systemd/system/firewall.service
cp firewall/enable.sh /etc/firewall/enable.sh
chmod +x /etc/firewall/enable.sh
systemctl enable firewall.service