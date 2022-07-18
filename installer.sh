#!/bin/bash

COLOR="\e[92m"
ENDCOLOR="\e[0m"
SPLIT="$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)"
PS3="$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
Choose the type of install: "
setup=("Basic" "Simple" "Full" "Quit")

mainmenu() {
clear
echo -e "$COLOR Bootstrap script: Simple Ubuntu 22.04 LTS $ENDCOLOR
$SPLIT"
select fav in "${setup[@]}"; do
    case $fav in
        "Basic")
            clear;
            echo "$SPLIT"
            echo -e "$COLOR $fav install starting$ENDCOLOR

$SPLIT
$COLOR Installing: $ENDCOLOR

  - Nano
  - Btop
  - Cron
  - Docker

$COLOR Setup: $ENDCOLOR

  - Auto Backup and Update

$SPLIT"
        while true; do
        read -p "Do you wish run $fav install? 
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash basic-install.sh; break;;
            [Nn]* ) mainmenu;;
            * ) echo -e "$COLOR Please answer yes or no.$ENDCOLOR";;
          esac
        done
            break
            ;;
        "Simple")
            clear;
            echo "$SPLIT"
            echo -e "$COLOR $fav install starting$ENDCOLOR

$SPLIT
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

$SPLIT"
        while true; do
        read -p "Do you wish run $fav install?
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash simple-install.sh; break;;
            [Nn]* ) mainmenu;;
            * ) echo -e "$COLOR Please answer yes or no.$ENDCOLOR";;
          esac
        done
            break
            ;;
        "Full")
            clear;
            echo "$SPLIT"
            echo -e "$COLOR $fav install starting$ENDCOLOR

$SPLIT
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

$SPLIT"
        while true; do
        read -p "Do you wish run $fav install?
Yes | No --> " yn
        case $yn in
            [Yy]* ) bash full-install.sh; break;;
            [Nn]* ) mainmenu;;
            * ) echo -e "$COLOR Please answer yes or no.$ENDCOLOR";;
          esac
        done
            break
            ;;
        "Quit")
            clear;
            echo ""
            echo "$SPLIT"
            echo ""
            echo -e "$COLOR Exiting installation$ENDCOLOR"
            echo ""
            echo "$SPLIT"
            echo ""
            exit
            ;;
        *) 
           echo "$SPLIT"
           echo ""
           echo -e "$COLOR Invalid option $REPLY $ENDCOLOR"
           echo "";;
    esac
done

}

mainmenu