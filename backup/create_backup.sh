#!/bin/bash

source .var

mkdir /backup
mkdir /backup/{daily,weekly,monthly}
mkdir /home/"$USER"/backup-task

cat <<EOF >> /home/"$USER"/backup-task/backup-daily.sh
#!/bin/bash

tar -zcf /backup/daily/backup-$(date +%Y%m%d).tar.gz -C "$SOURCE"/*
find /home/"$USER"/backup/daily/* -mtime +7 -delete -exec rm {} \; 
EOF
chmod +x /home/"$USER"/backup-task/backup-daily.sh

cat <<EOF >> /home/"$USER"/backup-task/backup-weekly.sh
#!/bin/bash

tar -zcf /backup/weekly/backup-$(date +%Y%m%d).tar.gz -C "$SOURCE"/*
find /home/"$USER"/backup/weekly/* -mtime +31 -delete -exec rm {} \; 
EOF
chmod +x /home/"$USER"/backup-task/backup-weekly.sh

cat <<EOF >> /home/"$USER"/backup-task/backup-monthly.sh
#!/bin/bash

tar -zcf /backup/weekly/backup-$(date +%Y%m%d).tar.gz -C "$SOURCE"/*
find /home/"$USER"/backup/monthly/* -mtime +365 -delete -exec rm {} \; 
EOF
chmod +x /home/"$USER"/backup-task/backup-monthly.sh

cat <<EOF >> /etc/cron.d/crontask
30 5 * * * root    /home/"$USER"/backup-task/backup-daily.sh
40 5 * * 1 root    /home/"$USER"/backup-task/backup-weekly.sh
50 5 1 * * root    /home/"$USER"/backup-task/backup-monthly.sh
EOF
crontab -u "$USER" /etc/cron.d/crontask