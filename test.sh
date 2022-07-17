#!/bin/bash

echo "+------------------------------------------+"
while true; do
        read -p "Do you wish to edit sshd_config and add your .pub key? Yes/No.
--> " yn
echo "+------------------------------------------+"
        case $yn in
            [Yy]* ) echo "Please enter your ssh .pub key here:";
read PUB;
echo "$PUB" >> /home/"${SUDO_USER:-$USER}"/.ssh/authorized_keys
#cat <<EOF >> /etc/ssh/sshd_config
#MaxAuthTries 3
#PermitRootLogin no
#PasswordAuthentication no
#PermitEmptyPasswords no
#UsePAM yes
#PubkeyAuthentication yes
#EOF; 
                    break;;
            [Nn]* ) echo ""; exit;;
            * ) echo "Please answer yes or no.";;
          esac
        done
echo "+------------------------------------------+"
echo "|            S S H   L O C K E D           |"
echo "+------------------------------------------+"

