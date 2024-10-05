#!/bin/bash

dnf install -y borgbackup
borg init --encryption=none /mnt/well/backups/router

# temp first run
borg create --stats /mnt/well/backups/router::test /opt/AdGuradHome /usr/local/sbin/dyndns/config.py