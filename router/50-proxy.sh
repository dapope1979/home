#!/bin/bash

source /usr/local/sbin/configs/.env
export DOMAIN=$DOMAIN

dnf install -y nginx certbot python-certbot-dns-digitalocean python-certbot-nginx
rm /etc/nginx/nginx.conf
envsubst '$DOMAIN' < conf/nginx.conf > /etc/nginx/nginx.conf

rm /etc/cockpit/cockpit.conf
envsubst '$DOMAIN' < conf/cockpit.conf > /etc/cockpit/cockpit.conf

setsebool -P httpd_can_network_connect on

systemctl enable --now nginx.service

certbot -v -a dns-digitalocean -i nginx --dns-digitalocean-credentials "/usr/local/sbin/configs/do.env" -d '*.$DOMAIN'