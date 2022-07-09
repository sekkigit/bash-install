#!/bin/bash

#VAR
USER="$(id -u -n)"
IP=$(ip route get 8.8.8.8 | sed -n '/src/{s/.*src *\([^ ]*\).*/\1/p;q}')
PUBIP=$(curl ifconfig.me)
SUBNET=$(ip -o -f inet addr show | awk '/scope global/ {printf "%s ", $4}' | awk '{print $1}')
NETADAPT=$(ip route | grep default | sed -e "s/^.*dev.//" -e "s/.proto.*//")
OSVER=$(cat /etc/*release | awk '/DISTRIB_DESCRIPTION=/ {print $2}')

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

clear
##################################################################
banner "              S T A R T "
echo
echo
##################################################################
banner2 "     B A S I C  A P P S"

swap(){
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
swap

echo -e "$COLOR         INSTALLED BASIC APPS$ENDCOLOR"
##################################################################
banner2 "     D O C K E R  I N S T A L L"

swap(){
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
swap

echo -e "$COLOR         Docker is $(systemctl is-enabled docker) and $(systemctl is-active docker)$ENDCOLOR"
##################################################################
banner2 "     B A C K U P  S E T U P"

swap(){
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
swap

echo -e "$COLOR         BACKUP IS TURNED ON$ENDCOLOR"
##################################################################

#LOG
cat <<EOF > ./init-log

###############################################################
|
|   SERVER INFO:
|
|     OS VERSION:      $OSVER
|
|     USER INFO:
|
|        - Username:   $USER
|
|     NETWORK:
|
|        - Public IP:  $PUBIP
|        - Subnet:     $SUBNET
|        - NetAdapter: $NETADAPT
|
###############################################################
|
|     CONNECT TO:
|
|              SSH ==> ssh $USER@$IP
|
###############################################################
EOF
cat ./init-log