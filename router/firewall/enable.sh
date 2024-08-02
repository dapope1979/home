#!/bin/sh
# https://wiki.debian.org/DebianFirewall#Using_iptables_for_IPv4_traffic
# A very basic IPtables / Netfilter script /etc/firewall/enable.sh

PATH='/sbin'

# Flush the tables to apply changes
iptables -F

# Default policy to drop 'everything' but our output to internet
iptables -P FORWARD DROP
iptables -P INPUT   DROP
iptables -P OUTPUT  ACCEPT

# Allow established connections (the responses to our outgoing traffic)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow local programs that use loopback (Unix sockets)
iptables -A INPUT -s 127.0.0.0/8 -d 127.0.0.0/8 -i lo -j ACCEPT

# Uncomment this line to allow incoming SSH/SCP conections to this machine,
# for traffic from 10.20.0.2 (you can use also use a network definition as
# source like 10.20.0.0/22).
#iptables -A INPUT -s 10.9.8.1/24 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i br0 -p all -j ACCEPT