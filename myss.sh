#!/bin/sh

wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
chmod +x shadowsocks.sh
./shadowsocks.sh 2>&1 | tee shadowsocks.log

echo "echo 3 > /proc/sys/net/ipv4/tcp_fastopen"  >> /etc/rc.local
echo "net.ipv4.tcp_fastopen = 3"  >> /etc/sysctl.conf
sed -i s/'"fast_open":false'/'"fast_open":true'/g server.json

/etc/init.d/shadowsocks restart

echo "Install BBR"

wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh
