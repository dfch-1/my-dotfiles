#!/bin/bash
set -e

chmod +x ~/my-dotfiles/installed/divers.sh ~/my-dotfiles/installed/programs.sh
chmod +x ~/my-dotfiles/commands.sh 

./my-dotfiles/installed/drivers.sh
./my-dotfiles/installed/programs.sh
./my-dotfiles/commands.sh