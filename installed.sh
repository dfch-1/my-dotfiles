#!/bin/bash
set -e

sudo pacman -Syu
sudo pacman -S jq nlohmann gcc

g++ manager.cpp -o manager
chmod +x ~/my-dotfiles/installed/divers.sh ~/my-dotfiles/installed/programs.sh
chmod +x ~/my-dotfiles/commands.sh 
./manager
./installed/drivers.sh
./installed/programs.sh
./commands.sh