#!/bin/bash
NS=$( cat /etc/xray/dns )
PUB=$( cat /etc/slowdns/server.pub )
domain=$(cat /etc/xray/domain)

# Deteksi Sistem Operasi
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
fi
rm -rf /var/lib/dpkg/stato* >/dev/null
rm -rf /var/lib/dpkg/lock* >/dev/null
# Fungsi untuk instalasi tanpa virtual environment
install_without_env() {
    echo "Sistem tidak mendukung virtual environment. Melanjutkan instalasi tanpa venv."
cd /etc/systemd/system/
rm -rf kyt.service
cd
cd /usr/bin
rm -rf kyt >/dev/null
rm kyt.* >/dev/null
rm -rf bot >/dev/null
rm bot.* >/dev/null
rm *.session >/dev/null
apt install -y python3 python3-pip git
cd /usr/bin
wget https://raw.githubusercontent.com/diah082/newbie/main/Bot/bot.zip
unzip bot.zip
mv bot/* /usr/bin
chmod +x /usr/bin/*
rm -rf bot.zip
clear
wget https://raw.githubusercontent.com/diah082/newbie/main/Bot/kyt.zip
unzip kyt.zip
pip3 install -r kyt/requirements.txt
}

# Fungsi untuk instalasi dengan virtual environment
install_with_env() {
    echo "Sistem mendukung virtual environment. Melanjutkan instalasi dengan venv."
    apt update -y && apt upgrade -y
    apt install -y python3 python3-pip git unzip python3-full -y
cd /etc/systemd/system/
rm -rf kyt.service
cd
cd /usr/bin
rm -rf kyt >/dev/null
rm kyt.* >/dev/null
rm -rf bot >/dev/null
rm bot.* >/dev/null
rm *.session >/dev/null
    python3 -m venv kyt_env
    source kyt_env/bin/activate
    wget https://raw.githubusercontent.com/diah082/newbie/main/Bot/bot.zip
    unzip bot.zip
    mv bot/* /usr/bin
    chmod +x /usr/bin/*
    rm -rf bot.zip
    wget https://raw.githubusercontent.com/diah082/newbie/main/Bot/kyt.zip
    unzip kyt.zip
    pip install --upgrade pip
    pip install standard-imghdr
    pip install -r kyt/requirements.txt
    deactivate
}

# Ambil angka pertama dari VERSION (misal 24.04 jadi 24)
MAJOR_VER=$(echo "$VERSION" | cut -d. -f1)

if [[ "$OS" == "debian" && "$MAJOR_VER" -ge 12 ]] || [[ "$OS" == "ubuntu" && "$MAJOR_VER" -ge 24 ]]; then
    ENV_PATH="/usr/bin/kyt_env/bin/python3"
    install_with_env
else
    ENV_PATH="/usr/bin/python3"
    install_without_env
fi

# Melanjutkan sisa skrip (sama untuk semua sistem operasi)
grenbo="\e[92;1m"
NC='\e[0m'

echo ""
figlet Newbie Store | lolcat
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m          ADD BOT PANEL          \e[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${grenbo}Tutorial Create Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Create Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info ID Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your ID Telegram :" admin
echo -e BOT_TOKEN='"'$bottoken'"' >> /usr/bin/kyt/var.txt
echo -e ADMIN='"'$admin'"' >> /usr/bin/kyt/var.txt
echo -e DOMAIN='"'$domain'"' >> /usr/bin/kyt/var.txt
echo -e PUB='"'$PUB'"' >> /usr/bin/kyt/var.txt
echo -e HOST='"'$NS'"' >> /usr/bin/kyt/var.txt
echo -e "#bot# $bottoken $admin" >/etc/bot/.bot.db
clear

cat > /etc/systemd/system/kyt.service << END
[Unit]
Description=Simple kyt - @kyt
After=network.target

[Service]
WorkingDirectory=/usr/bin
ExecStart=$ENV_PATH -m kyt
Restart=always

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start kyt
systemctl enable kyt
systemctl restart kyt
cd /root
rm -rf kyt.sh
clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Token Bot     : $bottoken"
echo "Admin         : $admin"
echo "Domain        : $domain"
echo -e "==============================="
echo "Setting done"
echo " Installations complete, type /menu on your bot"
