#!/bin/sh
# https://wiki.debian.org/DebianFirewall
# This is a more complex setup, for a home firewall: 
# * One interface plug to the ISP conection (eth0). Using DHCP.
# * One interface plug to the local LAN switch (eth1). Using 192.168.0.0/24.
# * Traffic open from the LAN to the SSH in the firewall.
# * Traffic open and translated, from the local LAN to internet.
# * Traffic open from internet, to a local web server.
# * Logging of dropped traffic, using a specific ''log level'' to configure a separate file in syslog/rsyslog.

PATH='/sbin'

## INIT

# Flush previous rules, delete chains and reset counters
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Default policies
iptables -P INPUT   DROP
iptables -P OUTPUT  DROP
iptables -P FORWARD DROP

echo -n '1' > /proc/sys/net/ipv4/ip_forward
echo -n '0' > /proc/sys/net/ipv4/conf/all/accept_source_route
echo -n '0' > /proc/sys/net/ipv4/conf/all/accept_redirects
echo -n '1' > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
echo -n '1' > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

# Enable loopback traffic
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Enable statefull rules (after that, only need to allow NEW conections)
iptables -A INPUT   -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT  -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Drop invalid state packets
iptables -A INPUT   -m conntrack --ctstate INVALID -j DROP
iptables -A OUTPUT  -m conntrack --ctstate INVALID -j DROP
iptables -A FORWARD -m conntrack --ctstate INVALID -j DROP


## INPUT

# Incoming ssh from the LAN
iptables -A INPUT -i br0 -s 10.9.8.0/24 \
                  -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT


## OUTPUT

# Enable all outgoing traffic to internet
iptables -A OUTPUT -o bond0 -d 0.0.0.0/0      -j ACCEPT 

# Enable access traffic, from the firewall to the LAN network
iptables -A OUTPUT -o br0 -d 10.9.8.0/24 -j ACCEPT


## FORWARD

# We have dynamic IP (DHCP), so we've to masquerade 
iptables -t nat -A POSTROUTING -o bond0 -j MASQUERADE
iptables        -A FORWARD     -o bond0 -i br0 -s 10.9.8.0/24 \
                               -m conntrack --ctstate NEW -j ACCEPT

# Redirect HTTP (tcp/80) to the web server (192.168.0.2)
# iptables -t nat -A PREROUTING -i bond0 -p tcp --dport 80 \
#                               -j DNAT --to-destination 192.168.0.2:80

# iptables        -A FORWARD    -i bond0 -p tcp --dport 80 \
#                               -o br0 -d 192.168.0.2    \
#                               -m conntrack --ctstate NEW -j ACCEPT
