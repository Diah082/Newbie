#!/bin/bash
clear
cat >/etc/cron.d/log_clear <<-END
		59 * * * * root /usr/local/bin/log_clear
	END
	chmod +x /etc/cron.d/log_clear

cat >/usr/local/bin/log_clear <<-END
	#!/bin/bash
tanggal=$(date +"%m-%d-%Y")
waktu=$(date +"%T")
echo "Sucsesfully clear & restart On $tanggal Time $waktu." >> /root/log-clear.txt
/usr/local/sbin/clearlog -r now
/usr/local/sbin/clearcache -r now
systemctl restart udp-custom.service
END
	chmod +x /usr/local/bin/log_clear
systemctl daemon-reload
systemctl restart cron
rm /root/autoclear.sh
echo -e "AutoClear Sucsesfully Installed"
sleep 1
exit