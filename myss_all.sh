#!/bin/sh


echo "Install BBR"

wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh

chmod +x shadowsocks-all.sh
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log

echo "echo 3 > /proc/sys/net/ipv4/tcp_fastopen"  >> /etc/rc.local
echo "net.ipv4.tcp_fastopen = 3"  >> /etc/sysctl.conf
sed -i s/'"fast_open":false'/'"fast_open":true'/g /etc/shadowsocks-libev/config.json


wget  http://install.direct/go.sh && bash  go.sh

service v2ray start


cat /etc/v2ray/config.json

cat /etc/shadowsocks-libev/config.json


wget --no-check-certificate https://raw.githubusercontent.com/ysy/wireguard/master/wg.sh && chmod +x wg.sh && ./wg.sh
