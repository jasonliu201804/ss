#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
echo -e "${RED}Install packages${NC}"

sudo apt -y install dnsmasq ipset shadowsocks-libev
sudo apt -y install sed curl 
if ! (ss-redir -h  > /dev/null )  ; then
	echo -e "${RED}Shadowsocks-libev not installed, try compile from source${NC}"
	rm -rf shadowsocks-libev/
	git clone https://github.com/shadowsocks/shadowsocks-libev.git 
	cd shadowsocks-libev/
	git submodule update --init --recursive
	sudo apt install -y --no-install-recommends libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev libmbedtls-dev libsodium-dev
	sudo apt install -y automake libtool
	./autogen.sh
	./configure
	make
	sudo make install
fi

sudo setcap cap_net_bind_service,cap_net_admin+ep /usr/local/bin/ss-redir
sudo setcap cap_net_bind_service,cap_net_admin+ep /usr/bin/ss-redir


sudo sed -i  s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g  /etc/sysctl.conf

if  ! ( cat /etc/sysctl.conf | grep -q 'net.ipv4.ip_forward=1' ); then
        sudo cho "net.ipv4.ip_forward=1" > /etc/sysctl.conf
fi

sudo sysctl -p


if ! [ -e gfwlist2dnsmasq.sh ];  then
	wget https://raw.githubusercontent.com/cokebar/gfwlist2dnsmasq/master/gfwlist2dnsmasq.sh
	chmod +x gfwlist2dnsmasq.sh
fi

if (cat /etc/issue | grep -q 'Ubuntu' | grep -q  '18.' ) ; then
	echo "disable systemd-resolved server"
	sudo echo "DNSStubListener=no" >> /etc/systemd/resolved.conf
	service systemd-resolved restart
	service dnsmasq restart
fi
