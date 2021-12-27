#!/bin/bash

# prereqs
cp sources.list /etc/apt/
apt update
apt upgrade -y
apt install -y curl \
    iptables \
    linux-headers-amd64 \
    bridge-utils \
    ifenslave \
    openssh-server \
    python3-pip \
    sudo
usermod -aG sudo odin

pip install speedtest-cli
