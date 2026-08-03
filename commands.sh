cd ~
cp -rf my-dotfiles/. .config/
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
xdg-user-dirs-update
mkdir -p ~/Pictures/Screenshots ~/Pictures/Wallpapers
mkdir ~/Git ~/Code
rm -rf .cache/.
rm go
