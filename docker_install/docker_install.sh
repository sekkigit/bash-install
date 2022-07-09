#!/bin/bash

source .var

apt install docker.io -y
apt install docker-compose -y
groupadd --system dockergroup
useradd --system --no-create-home --group dockergroup,"$USER" -s /bin/false docker
chown -R "$USER":docker /home/"$USER"
usermod -aG docker,adm "$USER"