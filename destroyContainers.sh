#!/bin/bash

# pihole
docker-compose -f pihole/docker-compose.yml down

# minecraft
docker-compose -f minecraft/survival.yml down

# plex
docker-compose -f plex/docker-compose.yml down

# samba for windows shares
docker-compose -f fileHoarder/docker-compose.yml down
