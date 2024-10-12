#!/bin/bash

source /usr/local/sbin/configs/.env

dnf install -y nginx
rm /etc/nginx/nginx.conf
cp envsubst < conf/nginx.conf > /etc/nginx/nginx.conf

rm /etc/cockpit/cockpit.conf
cp conf/cockpit.conf /etc/cockpit/cockpit.conf

setsebool -P httpd_can_network_connect on

systemctl enable --now nginx.service