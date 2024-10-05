#!/bin/bash

source /usr/local/sbin/configs/.env

git clone https://github.com/elforesto/digitalocean-dyndns.git /usr/local/sbin/dyndns 

cp conf/dyndns/config.py /usr/local/sbin/dyndns/config.py
cp conf/dyndns/dyndns.* /etc/systemd/system

systemctl enable --now dyndns.timer

printf "\nBe sure that /usr/local/sbin/configs/.env is configured.\n"