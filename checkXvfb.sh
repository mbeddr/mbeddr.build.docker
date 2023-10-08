#!/bin/bash

# Log file for the script
log_file="/var/log/checkXvfb.log"

# Function for logging messages
log_message() {
  local message="$1"
  echo "$(date +"%Y-%m-%d %H:%M:%S") - $message" >> "$log_file"
}

log_message "Starting checkXvfb script but wating one minute beforehand so xvfb can start."

sleep 60

while true; 
do
  # Check if restarting the process is necessary
  xdpyinfo -display :0 > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    log_message "X Server is running, no need to restart the process."
  else
    log_message "X Server is not running, proceeding to restart the process."

    # Command 1: Delete a file
    rm /tmp/.X0-lock
    if [ $? -eq 0 ]; then
      log_message "File /tmp/.X0-lock deleted successfully."
    else
      log_message "Error while deleting the file /tmp/.X0-lock."
    fi

    # Command 2: Restart Supervisor
    supervisorctl restart xvfb
    if [ $? -eq 0 ]; then
      log_message "Supervisor restarted successfully."
    else
      log_message "Error while restarting Supervisor."
    fi
  fi

  sleep 300

done

exit 0