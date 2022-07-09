#!/bin/bash

curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
apt install crowdsec -y
apt install crowdsec-firewall-bouncer-iptables -y
systemctl enable crowdsec
systemctl start crowdsec
cscli collections install crowdsecurity/whitelist-good-actors
sudo cscli parsers install crowdsecurity/iptables-logs
sudo cscli hub update
sudo cscli parsers upgrade crowdsecurity/sshd-logs 

cat <<EOF >> /etc/cron.d/crontask
20 5 * * * root    cscli hub update && cscli collections upgrade crowdsecurity/sshd && systemctl reload crowdsec
EOF
crontab -u "$USER" /etc/cron.d/crontask
systemctl reload crowdsec