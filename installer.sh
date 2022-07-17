#!/bin/bash

COLOR="\e[92m"
ENDCOLOR="\e[0m"
PS3='+------------------------------------------+
 Choose the type of install: '
setup=("Basic" "Simple" "Full" "Quit")

clear
echo -e "$COLOR Bootstrap script: Simple Ubuntu 22.04 LTS $ENDCOLOR
+------------------------------------------+"
select fav in "${setup[@]}"; do
    case $fav in
        "Basic")
            clear;
            echo "+------------------------------------------+"
            echo -e "$COLOR $fav install starting$ENDCOLOR

+------------------------------------------+
$COLOR Installing: $ENDCOLOR

  - Nano
  - Btop
  - Cron
  - Docker

$COLOR Setup: $ENDCOLOR

  - Auto Backup and Update

+------------------------------------------+"
        while true; do
        read -p "Do you wish run $fav install? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash basic-install.sh; break;;
            [Nn]* ) exit;;
            * ) echo -e "$COLOR Please answer yes or no.$ENDCOLOR";;
          esac
        done
            break
            ;;
        "Simple")
            clear;
            echo "+------------------------------------------+"
            echo -e "$COLOR $fav install starting$ENDCOLOR

+------------------------------------------+
$COLOR Installing: $ENDCOLOR

  - Nano
  - Btop
  - Cron
  - Docker
  - Crowdsec
  - Cockpit
  - UFW

$COLOR Setup: $ENDCOLOR

  - Auto Backup and Update

+------------------------------------------+"
        while true; do
        read -p "Do you wish run $fav install?
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash simple-install.sh; break;;
            [Nn]* ) exit;;
            * ) echo -e "$COLOR Please answer yes or no.$ENDCOLOR";;
          esac
        done
            break
            ;;
        "Full")
            clear;
            echo "+------------------------------------------+"
            echo -e "$COLOR $fav install starting$ENDCOLOR

+------------------------------------------+
$COLOR Installing: $ENDCOLOR

  - Nano
  - Btop
  - Cron
  - Docker
  - Crowdsec
  - Cockpit
  - UFW
  - Samba
  - Plex

$COLOR Setup: $ENDCOLOR

  - Auto Backup and Update

+------------------------------------------+"
        while true; do
        read -p "Do you wish run $fav install?
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash full-install.sh; break;;
            [Nn]* ) exit;;
            * ) echo -e "$COLOR Please answer yes or no.$ENDCOLOR";;
          esac
        done
            break
            ;;
        "Quit")
            clear;
            echo -e "$COLOR User requested exit$ENDCOLOR"
            exit
            ;;
        *) echo -e "+------------------------------------------+
        $COLOR Invalid option $REPLY $ENDCOLOR";;
    esac
done