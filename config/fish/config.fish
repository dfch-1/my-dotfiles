set -U fish_greeeting ""
set -g ckull 8e0404
set -g MEDIA /run/media/$USER

cd ~
clear

#Alias
alias start='start-hyprland'
alias stop='exit'
alias ls='lsd -1'
alias df='duf'

#abbr
abbr ll 'ls -l'
abbr la 'ls -la'

if test "$XDG_CURRENT_DESKTOP" = "Hyprland"
    fastfetch
end
