#!/bin/bash

source /usr/local/sbin/configs/.env
export DOMAIN=$DOMAIN

rm /etc/nginx/nginx.conf
envsubst '$DOMAIN' < conf/nginx.conf > /etc/nginx/nginx.conf

systemctl restart nginx.service