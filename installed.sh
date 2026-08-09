#!/bin/bash
set -e

sudo pacman -Syu
sudo pacman -S --needed --noconfirm jq gcc

g++ manager.cpp -o manager
chmod +x installed/drivers.sh installed/programs.sh
chmod +x commands.sh 
./manager
echo
./installed/drivers.sh
echo
./installed/programs.sh
./commands.sh
echo "done"
reboot