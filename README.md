# Bash-install

This script will install the next software:

- Nano
- Crontask
- Btop
- Autorun tasks
- Docker
- Docker-compose
- Backup (Daily, Weakly, and Monthly)

Oder programs that have  installation scripts that you need to start manually are:

- Crowdsec
- Samba
- Plex media server


```
sudo apt update \
sudo apt install git -y \
git clone https://github.com/sekkigit/bash-install.git install && cd install \
sudo bash init.sh
```