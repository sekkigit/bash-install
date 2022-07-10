#!/bin/bash

apt install docker.io -y
apt install docker-compose -y
groupadd --system dockergroup
useradd --system --no-create-home --group dockergroup,"$(who am i | awk '{print $1}')" -s /bin/false docker
chown -R "$(who am i | awk '{print $1}')":docker /home/"$(who am i | awk '{print $1}')"
usermod -aG docker,adm "$(who am i | awk '{print $1}')"

cat <<EOF >> /etc/cron.d/crontask
25 5 * * * root    docker system prune -a -f
EOF
crontab -u "$(who am i | awk '{print $1}')" /etc/cron.d/crontask