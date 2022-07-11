#!/bin/bash

SUBNET="$(ip -o -f inet addr show | awk '/scope global/ {printf "%s ", $4}' | awk '{print $1}')"
SHARE="/home/$(who am i | awk '{print $1}')/samba-share"

apt install samba -y
groupadd --system smbgroup
useradd --system --no-create-home --group smbgroup -s /bin/false smbuser
mkdir "$SHARE"
chown -R smbuser:smbgroup "$SHARE"

cat <<EOF > /etc/samba/smb.conf
[global]
server string = File Server
workgroup = WORKGROUP
security = user
map to guest = Bad User
name resolve order = bcast host
include = /etc/samba/shares.conf
EOF

cat <<EOF > /etc/samba/shares.conf
[Public Files]
path = "$SHARE"
force user = smbuser
force group = smbgroup
create mask = 0664
force create mode = 0664
directory mask = 0775
force directory mode = 0775
public = yes
writable = yes
EOF

systemctl start smbd
ufw allow from "$SUBNET" to any app Samba
systemctl restart smbd nmbd