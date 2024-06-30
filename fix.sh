#!/bin/bash
wget -q https://raw.githubusercontent.com/diah082/newbie/main/Cfg/rclone.conf
mv rclone.conf /root/.config/rclone/rclone.conf
rm fix.*
clear
echo -e "RCLONE BERHASIL DIUPDATE" | lolcat
sleep 5
exit 0
