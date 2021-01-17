#!/bin/bash

# pihole
docker-compose -f pihole/docker-compose.yml up -d

# minecraft
docker-compose -f minecraft/survival.yml up -d

# plex
docker-compose -f plex/docker-compose.yml up -d

# samba for windows shares
docker-compose -f fileHoarder/docker-compose.yml up -d
