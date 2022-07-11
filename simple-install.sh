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
spinner=(◢ ◣ ◤ ◥);

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
banner2 "     B A S I C  A P P S"

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
banner2 "     C R O N T A S K  S E T U P"

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
banner2 "     B A C K U P  S E T U P"

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
##################################################################
banner2 "     D O C K E R  I N S T A L L"

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

echo -e "$COLOR Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker). Docker system prune automated.$ENDCOLOR"
##################################################################
banner2 "     C R O W D S E C  I N S T A L L"

crowdsec(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./crowdsec/crowdsec.sh &> /dev/null)
  do
    sleep 1;
  done

  kill $pid
  echo ""
}
crowdsec

echo -e "$COLOR Crowdsec is $(systemctl is-enabled crowdsec) and $(systemctl is-active crowdsec). Crowdsec update automated.$ENDCOLOR"
##################################################################
banner2 "     C O C K P I T  I N S T A L L"

cockpit(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./cockpit/cockpit.sh &> /dev/null)
  do
    sleep 1;
  done

  kill $pid
  echo ""
}
cockpit

echo -e "$COLOR Cockpit is $(systemctl is-enabled cockpit) and $(systemctl is-active cockpit).$ENDCOLOR"
##################################################################
banner2 "     S A M B A  S E T U P"

samba(){
  echo ""
  spin &
  pid=$!

  for i in $(bash ./samba_install/samba_install.sh &> /dev/null)
  do
    sleep 0.1;
  done

  kill $pid
  echo ""
}
samba

echo
echo -e "$COLOR Samba is $(systemctl is-enabled smbd) and $(systemctl is-active smbd)$ENDCOLOR"

sleep 3s
clear

#LOG
banner2 "     I N F O"
cat <<EOF > ./init-log
###############################################################
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
|        - Backing up every Day, Week and Month in to the /backup.
|        - Frst backup created.
|        - Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker).
|        - Docker system prune automated.
|        - Crowdsec is $(systemctl is-enabled crowdsec) and $(systemctl is-active crowdsec).
|        - Crowdsec update automated.
|        - Cockpit is $(systemctl is-enabled cockpit) and $(systemctl is-active cockpit).
|        - Samba is $(systemctl is-enabled smbd) and $(systemctl is-active smbd).
|
|
###############################################################
|
|     CONNECT:         ssh $USER@$IP
|
###############################################################
EOF
cat ./init-log