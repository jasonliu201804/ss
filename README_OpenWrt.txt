openwrt 18.06.1

openwrt 正常工作并上网的前提下，登录ssh，执行以下指令：
cd /tmp && opkg update && opkg install curl ca-bundle && curl -s -L https://github.com/ysy/ss/raw/master/openwrt_tproxy.tgz -ot.tgz && tar x -z -f t.tgz && cd openwrt_tproxy  && ./setup.sh