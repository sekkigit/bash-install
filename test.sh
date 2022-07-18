#!/bin/bash

SPLIT="$(printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)"

banner()
{
  echo "$SPLIT"
  printf "%-40s \n" "$(date)" | sed  -e :a -e "s/^.\{1,$(tput cols)\}$/ & /;ta"
  printf "$(tput bold) %-40s $(tput sgr0) \n" "$@" | sed  -e :a -e "s/^.\{1,$(tput cols)\}$/ & /;ta"
  echo "$SPLIT"
}

banner2()
{
  echo "$SPLIT"
  printf "$(tput bold) %-40s $(tput sgr0) \n" "$@" | sed  -e :a -e "s/^.\{1,$(tput cols)\}$/ & /;ta"
  echo "$SPLIT"
}


banner "TEST"
banner2 "TEST 2"