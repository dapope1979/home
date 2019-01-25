#!/bin/bash

# minecraft
docker-compose -f minecraft/creative.yml  up -d
docker-compose -f minecraft/survival.yml up -d

# plex
docker-compose -f plex/docker-compose.yml up -d

# fileHoarder for plex channels
docker-compose -f fileHoarder/docker-compose.yml up -d