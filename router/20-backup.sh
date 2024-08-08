#!/bin/bash
apt install -y duplicity
mkdir -p /well/backups/server/router

# backup conatainer data everyday @ 3:00am
line="0 3 0 0 0 duplicity /var/lib/container-data file:///well/backups/server/router/ --no-encryption"
(crontab -u $(whoami) -l; echo "$line" ) | crontab -u $(whoami) -

# restore a single directory
# add --force to ovewrite existing, use --file-to-restore to limit scope
# sudo duplicity --file-to-restore adguard file:///well/backups/router /var/lib/container-data --no-encryption