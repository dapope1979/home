#!/bin/bash

cp interfaces /etc/network
cp sysctl.conf /etc
cp iptables-rules /etc/network
cp iptables /etc/network/if-pre-up.d
chmod 755 /etc/network/if-pre-up.d/iptables
/etc/network/if-pre-up.d/iptables
systemctl restart networking
