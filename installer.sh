#!/bin/bash

COLOR="\e[92m"
ENDCOLOR="\e[0m"
PS3='Choose the type of installation: '
foods=("Basic" "Simple" "Full" "Quit")

select fav in "${foods[@]}"; do
    case $fav in
        "Basic")
            echo "-------------------------------------"
            echo -e "$COLOR $fav instalation started$ENDCOLOR

-------------------------------------

$COLOR Installing: $ENDCOLOR

Nano, Btop, Cron, Docker

$COLOR Setup: $ENDCOLOR
            
Auto Backup and Update
            
-------------------------------------
            "
            sleep 5s
            
	     bash basic-install.sh
	    break
            ;;
        "Simple")
            echo "-------------------------------------"
            echo -e "$COLOR $fav instalation started$ENDCOLOR

-------------------------------------

$COLOR Installing: $ENDCOLOR

Nano, Btop, Cron, Docker, Crowdsec,
Cockpit, UFW

$COLOR Setup: $ENDCOLOR
            
Auto Backup and Update
            
-------------------------------------
            "
            sleep 5s
            
	     bash simple-install.sh
	    break
            ;;
        "Full")
            echo "-------------------------------------"
            echo -e "$COLOR $fav instalation started$ENDCOLOR

-------------------------------------

$COLOR Installing: $ENDCOLOR

Nano, Btop, Cron, Docker, Crowdsec, 
Cockpit, UFW, Samba, Plex

$COLOR Setup: $ENDCOLOR
            
Auto Backup and Update
            
-------------------------------------
            "
            sleep 5s
            
	     bash full-install.sh
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo -e "$COLOR Invalid option $REPLY $ENDCOLOR";;
    esac
done