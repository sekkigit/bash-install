#!/bin/bash

SUBNET=$(ip -o -f inet addr show | awk '/scope global/ {printf "%s ", $4}' | awk '{print $1}')

sudo apt install ufw -y

ufw default reject incoming
ufw default allow outgoing
ufw limit 22/tcp   #SSH
ufw allow 80/tcp   #HTTP
ufw allow 443/tcp  #HTTPS
ufw allow 1149/udp  #OPENVPN
ufw limit from "$SUBNET" to any app Samba #SAMBA
ufw limit from "$SUBNET" to any port 9090 proto tcp #COCKPIT
ufw app update plexmediaserver #PLEX
ufw allow plexmediaserver-all #PLEX
ufw --force enable