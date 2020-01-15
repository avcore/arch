#!/bin/bash
pacman -S i3-wm i3-gaps i3status sbxkb dmenu pcmanfm ttf-font-awesome feh lxappearance sbxkb thunar gvfs udiskie xorg-xbacklight ristretto tumbler compton slim
echo "current_theme archlinux" >> /etc/slim.conf

#echo "current_theme archlinux" && echo "xx" && echo "superline3" >> /tmp/shooter/test/s.conf

(
  echo export LANG=ru_RU.utf8;
  echo setxkbmap "us,ru" ",winkeys" "grp:caps_toggle,grp_led:caps";
  echo xset b off;
  echo exec i3
  ) >> ~/.xsession
  
  systemctl start slim
  
  pacman -S terminus-font lilyterm
