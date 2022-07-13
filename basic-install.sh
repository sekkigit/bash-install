#!/bin/bash

#VAR
USER="$(who am i | awk '{print $1}')"
IP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
PUBIP=$(curl ifconfig.me)
SUBNET=$(ip -o -f inet addr show | awk '/scope global/ {printf "%s ", $4}' | awk '{print $1}')
NETADAPT=$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")
OSVER=$(cat /etc/*release | awk '/DISTRIB_DESCRIPTION=/ {print $2}')
GATE4=$(ip route | awk '/default/ {print $3; exit}')
COLOR="\e[92m"
ENDCOLOR="\e[0m"

#Loading
spinner=(◴ ◷ ◶ ◵);

spin(){
  while true
  do
    for i in "${spinner[@]}";
    do
      echo -ne "\r$i";
      sleep 0.2;
    done;
  done
}

#Baner
banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "$(date)"                     
  echo "|                                          |"
  printf "|$(tput bold) %-40s $(tput sgr0)|\n" "$@"
  echo "+------------------------------------------+"
}

banner2()
{
  echo "+------------------------------------------+"
  printf "|$(tput bold) %-40s $(tput sgr0)|\n" "$@"
  echo "+------------------------------------------+"
}

apt remove needrestart -y
clear
##################################################################
banner "              S T A R T "
echo
echo
##################################################################
banner2 "         B A S I C  A P P S"

basic(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./basic_apps/basic.sh &> /dev/null)
  do
    sleep 1;
  done

  kill $pid
  echo ""
}
basic

echo -e "$COLOR Installed: Cron, Nano, Btop, Updated $ENDCOLOR"
##################################################################
banner2 "          C R O N T A S K"

crontask(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./autorun/crontask.sh &> /dev/null)
  do
    sleep 1;
  done

  kill $pid
  echo ""
}
crontask

echo -e "$COLOR Auto Update and Upgrade turned ON.$ENDCOLOR"
##################################################################
banner2 "            D O C K E R"

docker(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./docker_install/docker_install.sh &> /dev/null)
  do
    sleep 1;
  done

  kill $pid
  echo ""
}
docker

echo -e "$COLOR Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker).
 Docker system prune automated.$ENDCOLOR"
##################################################################
banner2 "           B A C K U P"

backup(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./backup/create_backup.sh &> /dev/null)
  do
    sleep 1;
  done

  kill $pid
  echo ""
}
backup

echo -e "$COLOR Backing up every Day, Week and Month in to the /backup$ENDCOLOR"
echo
sleep 3s
#LOG
banner "              F I N"
cat <<EOF > ./init-log
|
|   SERVER INFO:
|
|     OS VERSION:      Ubuntu $OSVER
|
|     USER INFO:       $(who am i | awk '{print $1}')
|
|     NETWORK:
|
|        - Public IP:  $PUBIP
|        - Subnet:     $SUBNET
|        - NetAdapter: $NETADAPT
|        - GateWay:    $GATE4
|
|     EVENTS:
|
|        - Installed: Cron, Nano, Btop, Updated
|        - Auto Update and Upgrade turned ON.
|        - Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker).
|        - Docker system prune automated.
|        - Backing up every Day, Week and Month in to the /backup.
|        - Frst backup created.
|
|
|
|     CONNECT:         ssh $USER@$IP
|
EOF
cat ./init-log