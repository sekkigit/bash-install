#!/bin/bash

cat <<EOF >> /etc/cron.d/crontask
0 5 * * *  root    apt update && apt upgrade -y
EOF
crontab -u "$(who am i | awk '{print $1}')" /etc/cron.d/crontask