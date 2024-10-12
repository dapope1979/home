#!/bin/bash

source /usr/local/sbin/configs/.env

# Essentially copied from
# https://borgbackup.readthedocs.io/en/stable/quickstart.html#automating-backups

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on.
# /opt/AdGuardHome - Ad blocking, DNS, and DHCP settings
# /usr/local/sbin/configs - secrets & environment variables

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    $BORG_REPO::'{hostname}-{now}'  \
    /opt/AdGuardHome                \
    /usr/local/sbin/configs

backup_exit=$?

info "Pruning repository"

# Agressively prune since changes should be rare and small
# Use the `prune` subcommand to maintain 4 daily, 1 weekly, 1 monthly, 4 yearly
# archives of THIS machine. The '{hostname}-*' matching is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --glob-archives '{hostname}-*'  \
    --show-rc                       \
    --keep-daily    4               \
    --keep-weekly   1               \
    --keep-monthly  1               \
    --keep-yearly   4               \
    $BORG_REPO

prune_exit=$?

# actually free repo disk space by compacting segments

info "Compacting repository"

borg compact $BORG_REPO

compact_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))
global_exit=$(( compact_exit > global_exit ? compact_exit : global_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup, Prune, and Compact finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup, Prune, and/or Compact finished with warnings"
else
    info "Backup, Prune, and/or Compact finished with errors"
fi

exit ${global_exit}