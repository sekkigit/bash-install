#!/bin/bash

source .var

cat <<EOF >> /etc/cron.d/crontask
0 5 * * *  root    apt update && apt upgrade -y
20 5 * * * root    cscli hub update && cscli collections upgrade crowdsecurity/sshd && systemctl reload crowdsec
25 5 * * * root    docker system prune -a -f
EOF
crontab -u "$USER" /etc/cron.d/crontask