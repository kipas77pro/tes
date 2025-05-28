#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
echo -e ""

MYIP=$(wget -qO- icanhazip.com);
clear

akbarvpn="raw.githubusercontent.com/Arya-Blitar22/vps/main/ssh"
akbarvpnnnnnn="raw.githubusercontent.com/Arya-Blitar22/vps/main/xray"
akbarvpnnnnnnnn="raw.githubusercontent.com/Arya-Blitar22/vps/main/backup"
akbarvpnnnnnnnnn="raw.githubusercontent.com/Arya-Blitar22/vps/main/websocket"

#echo "IP=" >> /var/lib/aryapro/ipvps.conf
clear
clear && clear && clear
clear;clear;clear
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Anda Ingin Menggunakan Domain Pribadi ?"
echo -e "Atau Ingin Menggunakan Domain Otomatis ?"
echo -e "Jika Ingin Menggunakan Domain Pribadi, Ketik ${GREEN}1${NC}"
echo -e "dan Jika Ingin menggunakan Domain Otomatis, Ketik ${GREEN}2${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""
read -p "$( echo -e "${GREEN}Input Your Choose ? ${NC}(${YELLOW}1/2${NC})${NC} " )" choose_domain
if [[ $choose_domain == "2" ]]; then # // Using Automatic Domain
mkdir -p /usr/bin
rm -fr /usr/local/bin/xray
rm -fr /usr/local/bin/stunnel
rm -fr /usr/local/bin/stunnel5
rm -fr /etc/nginx
rm -fr /var/lib/aryapro/
rm -fr /usr/bin/xray
rm -fr /etc/xray
rm -fr /usr/local/etc/xray
mkdir -p /etc/nginx
mkdir -p /var/lib/aryapro/
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
mkdir -p /usr/local/etc/xray
apt install jq curl -y
rm -rf /root/xray/scdomain
mkdir -p /root/xray
clear
echo ""
read -rp "Input Domain Name. Example ( babi ): " -e sub
DOMAIN=blitar-nbc-group.biz.id
SUB_DOMAIN=${sub}.blitar-nbc-group.biz.id
CF_ID=Afitamebel@gmail.com
CF_KEY=c7892fc1afa8bb535a286b67deba8be60ecd8
set -euo pipefail
IP=$(curl -sS ifconfig.me);
echo "Updating DNS for ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')

echo "$SUB_DOMAIN" > /root/domain
echo "$SUB_DOMAIN" > /root/scdomain
echo "$SUB_DOMAIN" > /etc/xray/domain
echo "$SUB_DOMAIN" > /etc/v2ray/domain
echo "$SUB_DOMAIN" > /etc/xray/scdomain
echo "IP=$SUB_DOMAIN" > /var/aryapro/ipvps.conf
rm -rf cf
sleep 1
yellow "Domain added.."
sleep 3
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain
clear
echo -e "[ ${GREEN}INFO${NC} ] Starting renew cert... "
sleep 2
echo -e "${OKEY} Starting Generating Certificate"
rm -fr /root/.acme.sh
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "${OKEY} Your Domain : $domain"
sleep 2
elif [[ $choose_domain == "1" ]]; then
clear
clear && clear && clear
clear;clear;clear
echo -e "${GREEN}Indonesian Language${NC}"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo -e "Silakan Pointing Domain Anda Ke IP VPS"
echo -e "Untuk Caranya Arahkan NS Domain Ke Cloudflare"
echo -e "Kemudian Tambahkan A Record Dengan IP VPS"
echo -e "${YELLOW}-----------------------------------------------------${NC}"
echo ""
echo ""
read -p "Input Your Domain : " domain
if [[ $domain == "" ]]; then
clear
echo -e "${EROR} No Input Detected !"
exit 1
fi
mkdir -p /usr/bin
rm -fr /usr/local/bin/xray
rm -fr /usr/local/bin/stunnel
rm -fr /usr/local/bin/stunnel5
rm -fr /etc/nginx
rm -fr /var/lib/aryapro/
rm -fr /usr/bin/xray
rm -fr /etc/xray
rm -fr /usr/local/etc/xray
mkdir -p /etc/nginx
mkdir -p /var/lib/aryapro/
mkdir -p /usr/bin/xray
mkdir -p /etc/xray
mkdir -p /usr/local/etc/xray
echo "$domain" > /etc/${Auther}/domain.txt
echo "IP=$domain" > /var/lib/aryapro/ipvps.conf
echo "$domain" > /root/domain
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain
clear
echo -e "[ ${GREEN}INFO${NC} ] Starting renew cert... "
sleep 2
echo -e "${OKEY} Starting Generating Certificate"
rm -fr /root/.acme.sh
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "${OKEY} Your Domain : $domain"
sleep 2
else
echo -e "${EROR} Please Choose 1 & 2 Only !"
exit 1
fi
#install v2ray
echo -e "[ ${GREEN}INFO$NC ] Mengunduh & Menginstal xray/v2ray"
sleep 3
wget https://${akbarvpnnnnnn}/ins-xray.sh >/dev/null 2>&1
chmod +x ins-xray.sh >/dev/null 2>&1
screen -S xray ./ins-xray.sh >/dev/null 2>&1
sleep 2
wget https://${akbarvpn}/ssh-vpn.sh >/dev/null 2>&1
chmod +x ssh-vpn.sh >/dev/null 2>&1
screen -S ssh ./ssh-vpn.sh >/dev/null 2>&1
sleep 2
wget https://${akbarvpnnnnnnnn}/set-br.sh >/dev/null 2>&1
chmod +x set-br.sh >/dev/null 2>&1
./set-br.sh >/dev/null 2>&1
# Websocket
echo -e "[ ${GREEN}INFO$NC ] Mengunduh & Memasang SSH Websocket"
sleep 3
wget https://${akbarvpnnnnnnnnn}/edu.sh >/dev/null 2>&1
chmod +x edu.sh >/dev/null 2>&1
./edu.sh >/dev/null 2>&1

rm -f /root/ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/set-br.sh
rm -f /root/edu.sh
rm -r -f domain
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=https://t.me/arya17

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
echo -e "[ ${GREEN}INFO$NC ] Menyelesaikan"
sleep 2
wget -O /etc/set.sh "https://${akbarvpn}/set.sh" >/dev/null 2>&1
chmod +x /etc/set.sh >/dev/null 2>&1
history -c
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
importantfile
menu
END
chmod 644 /root/.profile

#install gotop
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1
    
clear
echo "1.2" > /home/ver
echo " "
echo "Install Udah Selesai Sayank"
echo " "
echo "=============-AutoScript By NBC-GRUP-=============" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   Info Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - Stunnel5                : 447, 777, 445"  | tee -a log-install.txt
echo "   - Dropbear                : 109, 143 "  | tee -a log-install.txt
echo "   - Squid Proxy             : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                  : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                   : 89"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS         : 443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS         : 443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS    : 80"  | tee -a log-install.txt
echo "   - Websocket TLS           : 8443"  | tee -a log-install.txt
echo "   - Websocket None TLS      : 8880"  | tee -a log-install.txt
echo "   - XRAYS Trojan            : 2083"  | tee -a log-install.txt
echo "   - TrGo                    : 2087"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   - Whatsapp      : 081931615811"  | tee -a log-install.txt
echo "   - City          : Aris Stya Udanawu Blitar" | tee -a log-install.txt
echo "=============-AutoScript By ARYA BLITAR-=============" | tee -a log-install.txt
echo ""
echo " Reboot 15 Sec"
sleep 15
echo ""
rm -f setup.sh
reboot
