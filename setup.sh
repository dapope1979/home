#!/bin/bash

apt-get update
apt-get install zip -y

sudo snap install docker

#minecraft firewall rules
ufw allow 25565
ufw allow 25566
ufw allow 25567

#plex
ufw allow 32400

#pihole - disable DNS stub listener & use DNS from DHCP
ufw allow 80
ufw allow 443
#sed -r -i.orig 's/#?DNSStubListener=yes/DNSStubListener=no/g' /etc/systemd/resolved.conf
#sh -c 'rm /etc/resolv.conf && ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf'
