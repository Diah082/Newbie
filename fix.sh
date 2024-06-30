#!/bin/bash
wget -q https://raw.githubusercontent.com/sabdo-dadi/premium/main/Cfg/rclone.conf
mv rclone.conf /root/.config/rclone/rclone.conf
clear
echo -e "RCLONE BERHASIL DIUPDATE" | lolcat
sleep 5
exit 0
