#!/bin/bash

if ! [ -e ss.json ]; then
	echo "Missing SS config file"
	exit 1
fi

if [ -e /tmp/ss-tunnel.pid ]; then
	echo "Kill ss-tunnel"
	kill -9 `cat /tmp/ss-tunnel.pid`
	rm -rf /tmp/ss-tunnel.pid
fi

if [ -e /tmp/ss-redir.pid ]; then
	echo "kill ss-redir"
	kill -9 `cat /tmp/ss-redir.pid`
	rm -rf /tmp/ss-redir.pid
fi


ss-redir -c ss.json -b 0.0.0.0  -u -f /tmp/ss-redir.pid
ss-tunnel -c ss.json  -b 0.0.0.0 -l 5353 -L 8.8.8.8:53 -u -f /tmp/ss-tunnel.pid 

sudo iptables -F
sudo iptables -t  nat  -F

sudo ipset create gfwlist hash:ip family inet timeout 86400
rm -rf dnsmasq.conf
./gfwlist2dnsmasq.sh -p 5353 -s gfwlist -o dnsmasq.conf 
echo "server=223.5.5.5" >> dnsmasq.conf
sudo cp dnsmasq.conf /etc/
sudo service dnsmasq restart


echo "Fetch China ip set"
curl -sL http://f.ip.cn/rt/chnroutes.txt | egrep -v '^$|^#' > cidr_cn
sudo ipset destroy cidr_cn
sudo ipset -N cidr_cn hash:net
rm -rf ipset.sh
for i in `cat cidr_cn`; do echo ipset -A cidr_cn $i >> ipset.sh; done
chmod +x ipset.sh && sudo ./ipset.sh

sudo iptables -A FORWARD -j ACCEPT

sudo iptables -t nat -N shadowsocks
sudo iptables -t nat -A PREROUTING ! -p icmp -j shadowsocks

sudo iptables -t nat -A shadowsocks -m set --match-set cidr_cn dst -j RETURN
sudo iptables -t nat -A shadowsocks ! -p icmp -m set --match-set gfwlist dst -j  REDIRECT --to-ports 1082
