#!/bin/bash

/sbin/insmod  /lib/modules/xt_tcpudp.ko
/sbin/insmod  /lib/modules/nfnetlink.ko
/sbin/insmod  /lib/modules/ip_set.ko
/sbin/insmod  /lib/modules/ip_set_hash_ip.ko
/sbin/insmod  /lib/modules/xt_set.ko
/sbin/insmod  /lib/modules/iptable_mangle.ko
/sbin/insmod  /lib/modules/xt_TCPMSS.ko
/sbin/insmod  /lib/modules/xt_mark.ko
/sbin/insmod  /lib/modules/nf_defrag_ipv4.ko
/sbin/insmod  /lib/modules/nf_defrag_ipv6.ko
/sbin/insmod  /lib/modules/xt_TPROXY.ko
/sbin/insmod  /lib/modules/xt_multiport.ko
exit 0
