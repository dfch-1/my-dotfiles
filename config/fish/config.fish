set -U fish_greeeting ""
set -g ckull red

cd ~
clear

#Alias
alias start='start-hyprland'
alias stop='exit'

if test "$XDG_CURRENT_DESKTOP" = "Hyprland"
    fastfetch
    alias doom='./Games/doom/chocolate-doom -iwad ~/Games/doom/DOOM1.WAD'
    alias doom-config='./Games/doom/chocolate-setup'
else
    alias doom='cage -- ~/Games/doom/chocolate-doom -iwad ~/Games/doom/DOOM1.WAD'
    alias doom-config='cage -- ~/Games/doom/chocolate-setup'
    set_color green
    echo ""
end