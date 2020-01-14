#!/bin/bash
pacman -S i3-wm
pacman -S i3status dmenu xterm
pacman -S xorg-server xf86-video-intel xf86-input-synaptics
pacman -S slim
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


curl -i https://git.io -F "https://raw.githubusercontent.com/avcore/arch/master/i3inst.sh" -F "code=i3inst.sh"
