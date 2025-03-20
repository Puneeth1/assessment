#!/bin/bash

# Options that are available to the users
CHOICES=$(gum choose --no-limit "RAM Usage" "CPU Usage" "Disk Free Space" "Network Info")

# Looping through the user selected choices
while read -r choice; do
   case "$choice" in
   "RAM Usage")
      gum style --bold "RAM Usage"
      free -h ; echo # added echo to add a newline after printing the output of the command
      ;;
   "CPU Usage")
      gum style --bold "CPU Usage"
      top -bn1 ; echo
      ;;
   "Disk Free Space")
      gum style --bold "Disk Free Space"
      df -h ; echo
      ;;
   "Network Info")
      gum style --bold "Network Info"
      ip a ; echo
      ;;
   esac
done <<< $CHOICES

exit 0