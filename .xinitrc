xsetroot -cursor_name left_ptr
xrdb -l /home/emeric/.Xresources
urxvtd -q -o -f
sh /home/emeric/.chwall.sh
exec xmonad
xset +fp /home/emeric/.fonts/powerline-fonts/DejaVuSansMono
