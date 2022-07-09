#!/bin/bash

source .var

cat <<EOF >> /etc/cron.d/crontask
0 5 * * *  root    apt update && apt upgrade -y
EOF
crontab -u "$USER" /etc/cron.d/crontask