#!/bin/sh 

# Copyright (C) 2022 Sourav 'sourav2k' Gope
GLITCHHZRAM="/etc/modules-load.d/zram.conf"
GLITCHHSWAP="/etc/modprobe.d/zram.conf"
ZRULE="/etc/udev/rules.d/99-zram.rules"
FILE="$PWD/zram.service"
if [[  -f "$FILE" ]]; 
then
	sudo cp $FILE /etc/systemd/system/
	sudo touch $GLITCHHZRAM
	echo -e "zram" | sudo tee  $GLITCHHZRAM
	sudo touch $GLITCHHSWAP
	echo -e "options zram num_devices=1" | sudo tee  $GLITCHHSWAP
	sudo touch $ZRULE
	echo KERNEL=="zram0", ATTR{disksize}="16G",TAG+="systemd" | sudo tee  $ZRULE
	sudo sed -e '/swap/s/^/#/g' -i /etc/fstab
	sudo systemctl enable --now zram

else
  sudo curl https://raw.githubusercontent.com/sourav2k/Zram_Swap/master/zram.service --output /etc/systemd/system/zram.service
	sudo touch $GLITCHHZRAM
  echo -e "zram" | sudo tee  $GLITCHHZRAM
  sudo touch $GLITCHHSWAP
  echo -e "options zram num_devices=1" | sudo tee  $GLITCHHSWAP
  sudo touch $ZRULE
  echo KERNEL=="zram0", ATTR{disksize}="16G",TAG+="systemd" | sudo tee  $ZRULE
  sudo sed -e '/swap/s/^/#/g' -i /etc/fstab
  sudo systemctl enable --now zram
fi
echo -e "Now reboot your system"
sleep 4s
exit
