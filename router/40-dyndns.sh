#!/bin/bash

source /usr/local/sbin/configs/.env

dnf install -y nodejs

git clone https://github.com/dapope1979/do-dyndns.git /usr/local/sbin/dyndns 

cp conf/dyndns/config.py /usr/local/sbin/dyndns/config.py
cp conf/dyndns/dyndns.* /etc/systemd/system

systemctl enable --now dyndns.timer

printf "\nBe sure that /usr/local/sbin/configs/.env is configured.\n"