#!/bin/bash

source .var

mkdir /backup
mkdir /backup/{daily,weekly,monthly}
mkdir /home/"$(who am i | awk '{print $1}')"/backup-task

cat <<EOF >> /home/"$(who am i | awk '{print $1}')"/backup-task/backup-daily.sh
#!/bin/bash

tar -zcf /backup/daily/backup-$(date +%Y%m%d).tar.gz -C $SOURCE/*
find /home/"$(who am i | awk '{print $1}')"/backup/daily/* -mtime +7 -delete -exec rm {} \; 
EOF
chmod +x /home/"$(who am i | awk '{print $1}')"/backup-task/backup-daily.sh

cat <<EOF >> /home/"$(who am i | awk '{print $1}')"/backup-task/backup-weekly.sh
#!/bin/bash

tar -zcf /backup/weekly/backup-$(date +%Y%m%d).tar.gz -C $SOURCE/*
find /home/"$(who am i | awk '{print $1}')"/backup/weekly/* -mtime +31 -delete -exec rm {} \; 
EOF
chmod +x /home/"$(who am i | awk '{print $1}')"/backup-task/backup-weekly.sh

cat <<EOF >> /home/"$(who am i | awk '{print $1}')"/backup-task/backup-monthly.sh
#!/bin/bash

tar -zcf /backup/weekly/backup-$(date +%Y%m%d).tar.gz -C $SOURCE/*
find /home/"$(who am i | awk '{print $1}')"/backup/monthly/* -mtime +365 -delete -exec rm {} \; 
EOF
chmod +x /home/"$(who am i | awk '{print $1}')"/backup-task/backup-monthly.sh

cat <<EOF >> /etc/cron.d/crontask
30 5 * * * root    /home/"$(who am i | awk '{print $1}')"/backup-task/backup-daily.sh
40 5 * * 1 root    /home/"$(who am i | awk '{print $1}')"/backup-task/backup-weekly.sh
50 5 1 * * root    /home/"$(who am i | awk '{print $1}')"/backup-task/backup-monthly.sh
EOF
crontab -u "$(who am i | awk '{print $1}')" /etc/cron.d/crontask
sudo bash /home/"$(who am i | awk '{print $1}')"/backup-task/backup-daily.sh