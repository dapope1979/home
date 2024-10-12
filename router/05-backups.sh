#!/bin/bash
source /usr/local/sbin/configs/.env

cp conf/borg/backup.sh /usr/local/sbin/backup.sh

dnf install -y borgbackup

printf "\n\nYou can now setup a new backup repository with:\n"
printf "$ borg init --encryption=none \$BORG_REPO\n"
printf "or restore from an existing backup with:\n"
printf "$ borg list \$BORG_REPO\n"
printf "$ sudo borg extract --list \$BORG_REPO::backup-name\n"
printf "\nRemember to run source the environment variables from /usr/local/sbin/configs/.env\n"
printf "\nRemember to restore from the / directory.\n"