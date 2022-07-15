#!/bin/bash

PS3='Please enter your name from the list: '
options=("Elvis" "John" "Mark" "Manual input" "Quit")
select name in "${options[@]}"; do
    case $REPLY in
        1|2|3|4)
            break       # user picked name from list
            ;;
        5)
            echo 'Bye!' >&2
            exit
            ;;
   esac

   echo 'Try again!' >&2

done
printf 'Hello %s, now select your family name\n' "$name" >&2

PS3='Please enter your family name from the list: '
options=("Smith" "Brown" "Miller" "Manual input" "Quit")
select family in "${options[@]}"; do
    case $REPLY in
        1|2|3|4)
            break       # user picked name from list
            ;;
        5)
            echo 'Bye!' >&2
            exit
            ;;
    esac

    echo 'Try again!' >&2

done

echo "$name"
echo "$family"