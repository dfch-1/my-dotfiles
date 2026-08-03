#You need to install inotify-tools
while inotifywait -e close_write ~/.config/waybar; do killall -SIGUSR2 waybar; done