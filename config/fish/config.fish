set -U fish_greeeting ""
set -g ckull red

cd ~
clear

#Alias
alias start='start-hyprland'
alias stop='exit'

if test "$XDG_CURRENT_DESKTOP" = "Hyprland"
    fastfetch
else
    set_color green
    echo ""
end