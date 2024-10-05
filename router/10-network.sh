#!/bin/bash
source /usr/local/sbin/configs/.env

printf "\nConfiguring Network...\n"
# configure network
# create bond and add slaves
nmcli con add type bond ifname bond0 bond.options "mode=802.3ad,miimon=100"
nmcli con add type ethernet ifname enp8s0f0 master mybond0
nmcli con add type ethernet ifname enp8s0f1 master mybond0
# activate slaves, bond will auto activate
nmcli con up bond-slave-enp8s0f0
nmcli con up bond-slave-enp8s0f1

# no auto connect for bridged interfaces
# physical interface names may change w/ different hardware configurations
nmcli c m enp7s0f0 autoconnect no
nmcli c m enp7s0f1 autoconnect no
nmcli c m enp0s31f6 autoconnect no
# create the bridge
nmcli connection add type bridge con-name bridge0 ifname bridge0
nmcli connection add type ethernet slave-type bridge con-name bridge0-port1 ifname enp7s0f0 master bridge0
nmcli connection add type ethernet slave-type bridge con-name bridge0-port2 ifname enp7s0f1 master bridge0
nmcli connection add type ethernet slave-type bridge con-name bridge0-port3 ifname enp0s31f6 master bridge0
nmcli c m bridge0 autoconnect no

# set static ip
nmcli connection modify bridge0 ipv4.addresses '10.9.8.1/24'

#bring up bridge
nmcli connection up enp7s0f0
nmcli connection up enp7s0f1
nmcli connection up enp0s31f6
nmcli connection up bridge0

# configure firewall
# for LAN and WAN, respectively
firewall-cmd --zone=FedoraServer --add-masquerade --permanent
firewall-cmd --zone=FedoraServer --set-target=DROP --permanent
firewall-cmd --zone=FedoraServer --remove-service=ssh --permanent
firewall-cmd --zone=FedoraServer --remove-service=dhcpv6-client --permanent
firewall-cmd --zone=FedoraServer --remove-service=cockpit --permanent
firewall-cmd --zone=home --change-interface=bridge0 --permanent
firewall-cmd --zone=home --set-target=ACCEPT --permanent
firewall-cmd --reload

printf "\n\nInstalling DNS\n"
wget --no-verbose -O - https://raw.githubusercontent.com/AdguardTeam/AdGuardHome/master/scripts/install.sh | sh -s -- -v

printf "\nCockpit: 10.9.8.1:9090\n"
printf "AdGuard: 10.9.8.1:3000\n"

printf "\n\nBe sure to configure AdGuard or restore a backup.\n"