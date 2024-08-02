#!/bin/sh
# https://wiki.debian.org/DebianFirewall#Using_iptables_for_IPv4_traffic
# A very basic IPtables / Netfilter script /etc/firewall/enable.sh

PATH='/sbin'

# Flush the tables to apply changes
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Default policy to drop 'everything' but our output to internet
iptables -P FORWARD DROP
iptables -P INPUT   DROP
iptables -P OUTPUT  ACCEPT

echo 1 > /proc/sys/net/ipv4/ip_forward

# Allow established connections (the responses to our outgoing traffic)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow local programs that use loopback (Unix sockets)
iptables -A INPUT -s 127.0.0.0/8 -d 127.0.0.0/8 -i lo -j ACCEPT

# Uncomment this line to allow incoming SSH/SCP conections to this machine,
# for traffic from 10.20.0.2 (you can use also use a network definition as
# source like 10.20.0.0/22).
#iptables -A INPUT -s 10.9.8.1/24 -p tcp --dport 22 -m state --state NEW -j ACCEPT

# Allow anything on the LAN bridge
iptables -A INPUT -i br0 -p all -j ACCEPT
iptables -A FORWARD -i br0 -o bond0 -j ACCEPT
iptables -A FORWARD -i bond0 -o br0 -m state --state ESTABLISHED,RELATED -j ACCEPT

iptables -t nat -A POSTROUTING -o bond0 -j MASQUERADE