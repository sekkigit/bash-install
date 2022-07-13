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
        echo "Do you wish run $fav installation?"
              select yn in "Yes" "No"; do
              case $yn in
              Yes ) bash basic-install.sh;;
              No ) exit;;
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
            sleep 5s
         clear   
	     #bash simple-install.sh
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
            sleep 5s
         clear   
	     #bash full-install.sh
	    break
            ;;
	"Quit")
	    echo "+------------------------------------------+
        User requested exit
        +------------------------------------------+"
	    exit
	    ;;
        *) echo -e "+------------------------------------------+
        $COLOR Invalid option $REPLY $ENDCOLOR";;
    esac
done