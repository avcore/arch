#!/bin/bash

# Arch Linux Fast minimal viser Install EMMC-ROM
loadkeys ru
setfont cyr-sun16
echo 'Ссылка на чек лист есть в группе vk.com/arch4u'

echo '2.3 Синхронизация системных часов'
timedatectl set-ntp true

echo '2.4 создание разделов'
(
  echo o;

  echo n;
  echo;
  echo;
  echo;
  echo +500M;

  echo n;
  echo;
  echo;
  echo;
  echo +15G;

  echo n;
  echo;
  echo;
  echo;
  echo +1024M;

  echo n;
  echo p;
  echo;
  echo;
  echo a;
  echo 1;

  echo w;
) | fdisk /dev/mmcblk0

echo 'Ваша разметка диска'
fdisk -l

echo '2.4.2 Форматирование дисков'
mkfs.ext2  /dev/mmcblk0p1 -L boot
mkfs.ext4  /dev/mmcblk0p2 -L root
mkswap /dev/mmcblk0p3 -L swap
mkfs.ext4  /dev/mmcblk0p4 -L home

echo '2.4.3 Монтирование дисков'
mount /dev/mmcblk0p2 /mnt
mkdir /mnt/{boot,home}
mount /dev/mmcblk0p1 /mnt/boot
swapon /dev/mmcblk0p3
mount /dev/mmcblk0p4 /mnt/home

echo '3.1 Выбор зеркал для загрузки. Ставим зеркало от Яндекс'
echo "Server = https://mirror.yandex.ru/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist

echo '3.2 Установка основных пакетов'
pacstrap /mnt base base-devel linux linux-firmware nano dhcpcd netctl

echo '3.3 Настройка системы'
genfstab -pU /mnt >> /mnt/etc/fstab

arch-chroot /mnt sh -c "$(curl -fsSL git.io/virtarch2.sh)"
