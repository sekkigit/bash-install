#!/bin/#bash

COLOR="\e[92m"
ENDCOLOR="\e[0m"
PS3='+------------------------------------------+
Choose the type of installation: '
foods=("Basic" "Simple" "Full" "Quit")

clear
echo "+------------------------------------------+"
select fav in "${foods[@]}"; do
    case $fav in
        "Basic")
            echo "+------------------------------------------+"
            echo -e "$COLOR $fav instalation starting$ENDCOLOR

+------------------------------------------+
$COLOR Installing: $ENDCOLOR

Nano, Btop, Cron, Docker

$COLOR Setup: $ENDCOLOR

Auto Backup and Update

+------------------------------------------+"
        while true; do
        read -p "Do you wish run $fav installation? Yes/No.
--> " yn
        case $yn in
            [Yy]* ) bash basic-install.sh; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
          esac
        done
            break
            ;;
        "Simple")
            echo "+------------------------------------------+"
            echo -e "$COLOR $fav instalation starting$ENDCOLOR

+------------------------------------------+
$COLOR Installing: $ENDCOLOR

Nano, Btop, Cron, Docker, Crowdsec,
Cockpit, UFW

$COLOR Setup: $ENDCOLOR

Auto Backup and Update

+------------------------------------------+"
        while true; do
        read -p "Do you wish run $fav installation? Yes/No.
--> " yn
        case $yn in
            [Yy]* ) bash simple-install.sh; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
          esac
        done
            break
            ;;
        "Full")
            echo "+------------------------------------------+"
            echo -e "$COLOR $fav instalation starting$ENDCOLOR

+------------------------------------------+
$COLOR Installing: $ENDCOLOR

Nano, Btop, Cron, Docker, Crowdsec,
Cockpit, UFW, Samba, Plex

$COLOR Setup: $ENDCOLOR

Auto Backup and Update

+------------------------------------------+"
        while true; do
        read -p "Do you wish run $fav installation? Yes/No.
--> " yn
        case $yn in
            [Yy]* ) bash full-install.sh; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
          esac
        done
            break
            ;;
        "Quit")
            echo "+------------------------------------------+
User requested exit"
            exit
            ;;
        *) echo -e "+------------------------------------------+
        $COLOR Invalid option $REPLY $ENDCOLOR";;
    esac
done