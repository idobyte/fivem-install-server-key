#!/bin/bash

# Check if the user is running the script with root privileges
if [ "$EUID" -ne 0 ]
  then echo "Please run the script as root or with sudo."
  exit
fi

# Prompt the user for the server key
echo "Enter the server key: "
read server_key

# Check if the server key is valid
if [ -z "$server_key" ]
  then echo "The server key cannot be empty."
  exit
fi

# Create the server.cfg file if it doesn't exist
if [ ! -f "/etc/fivem/server.cfg" ]
  then touch "/etc/fivem/server.cfg"
fi

# Check if the server key is already present in the server.cfg file
if grep -Fxq "sv_licenseKey $server_key" "/etc/fivem/server.cfg"
  then echo "The server key is already present in the server.cfg file."
  exit
fi

# Add the server key to the server.cfg file
echo "sv_licenseKey $server_key" >> "/etc/fivem/server.cfg"

# Restart the FiveM server to apply the changes
systemctl restart fivem

# Confirm that the server key has been added
echo "The server key has been added to the server.cfg file and the FiveM server has been restarted."
