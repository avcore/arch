#!/bin/bash

#pacman -S i3-wm i3-gaps i3status sbxkb dmenu pcmanfm ttf-font-awesome feh lxappearance sbxkb thunar gvfs udiskie xorg-xbacklight ristretto tumbler compton slim
#echo "current_theme archlinux" >> /etc/slim.conf
#echo "exec i3" >> ~/.xinitrc
#startx
#echo "current_theme archlinux" && echo "xx" && echo "superline3" >> /tmp/shooter/test/s.conf

#(
#  echo export LANG=ru_RU.utf8;
#  echo setxkbmap "us,ru" ",winkeys" "grp:caps_toggle,grp_led:caps";
#  echo xset b off;
#  echo exec i3
#  ) >> ~/.xsession
  
#  systemctl start slim
#pacman -S terminus-font lilyterm


#wget git.io/yay-install.sh && sh yay-install.sh

#yay -S awesome-terminal-fonts bumblebee-status compton fonts-powerline dmenu i3-gaps i3lock-fancy-git lxappearance nitrogen rofi scrot termite xclip
(
  echo [Desktop Entry];
  echo Name=i3 custom;
  echo Exec=/usr/local/bin/i3-custom;
  echo Type=Application;
  ) >> /usr/share/xsessions/i3-custom.desktop
  
(
  echo "#!/bin/bash";
  echo mkdir -p ~/.config/i3/logs;
  echo export TERMINAL=termite;
  echo exec i3 -V >> ~/.config/i3/logs/$(date +"'%F-%T'").log 2>&1;
) >> /usr/local/bin/i3-custom

sudo chmod +x /usr/local/bin/i3-custom
 
cp /etc/xdg/termite/config ~/.config/termite/config

(
echo [options];
echo "# ...";
echo font pango:Inconsolata, Font Awesome 10;
echo "# ...";
echo [colors];
echo "# ...";
echo "# 20% background transparency (requires a compositor)";
echo background = rgba(63, 63, 63, 0.8);
) >> ~/.config/termite/config

cp /etc/xdg/compton.conf ~/.config

(
echo "# ...";
echo font pango:Droid Sans 10;
echo "# ...";
echo "# Заменяем все Mod1 на $m и создаем переменную выше вызовов bindsym";
echo set $m Mod1;

echo "# lockscreen";
echo bindsym Ctrl+$m+l exec i3lock;

echo "# Pulse Audio controls";
echo bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% "#increase sound volume";
echo bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% "#decrease sound volume";
echo bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle "# mute sound";

echo "# Sreen brightness controls";
echo bindsym XF86MonBrightnessUp exec xbacklight -inc 20 "# increase screen brightness";
echo bindsym XF86MonBrightnessDown exec xbacklight -dec 20 "# decrease screen brightness";

echo "# Touchpad controls";
echo bindsym XF86TouchpadToggle exec /some/path/toggletouchpad.sh "# toggle touchpad";

echo "# Media player controls";
echo bindsym XF86AudioPlay exec playerctl play;
echo bindsym XF86AudioPause exec playerctl pause;
echo bindsym XF86AudioNext exec playerctl next;
echo bindsym XF86AudioPrev exec playerctl previous;

echo "# rofi";
echo bindsym $m+t exec '"rofi -combi-modi window,drun -show combi"';

echo "# захватывает весь экран и копирует в буфер обмена";
echo bindsym --release Print exec '"scrot /tmp/%F_%T_$wx$h.png -e 'xclip -selection c -t image/png < $f && rm $f'"';
echo "# захватывает область экрана и копирует в буфер обмена";
echo bindsym --release Shift+Print exec '"scrot -s /tmp/%F_%T_$wx$h.png -e 'xclip -selection c -t image/png < $f && rm $f'"';
echo "# ...";
echo bar {;
echo  set $disk_format '"{path}: {used}/{size}"';
echo  status_command bumblebee-status -m nic disk:root disk:home cpu memory sensors pulseaudio datetime layout pacman -p root.left-click='"nautilus /"' root.format=$disk_format home.path=/home home.left-click='"nautilus /home"' home.format=$disk_format -t solarized-powerline;
echo  position top;
echo };
echo "# ...";
echo "# отступы между окнами";
echo gaps outer -10;
echo gaps inner 20;

echo floating_minimum_size 75 x 50;
echo floating_maximum_size -1 x -1;
echo "# Убрать рамки у окон:";
echo "# 1)";
echo "# new_window pixel 0";
echo "# 2)";
echo "# for_window [class="^.*"] border none";
echo "# force floating for all new windows";
echo "# for_window [class=".*"] floating enable";
echo for_window [class='"Nautilus"' instance='"file_progress"'] floating enable;
echo for_window [class='"^Telegram"'] floating enable, resize set 800 600;
echo "# Всплывающие окна браузера";
echo for_window [window_role='"pop-up"'] floating enable;
echo "# no_focus [window_role='"pop-up"']";
echo "# прозрачность терминала";
echo exec --no-startup-id compton --config ~/.config/compton.conf;
echo '# смена расскладки';
echo exec --no-startup-id setxkbmap -model pc105 -layout us,ru -option grp:ctrl_shift_toggle;
echo "# восстановление заставки рабочего стола";
echo exec --no-startup-id nitrogen --restore;
) >> ~/.config/i3/config

exit 
