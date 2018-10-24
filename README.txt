一键安装脚本：安装ss,v2ray,bbr

wget --no-check-certificate https://raw.githubusercontent.com/ysy/ss/master/myss_all.sh &&  chmod +x myss_all.sh && ./myss_all.sh





Openwrt SS透明代理请参考 README_openwrt.md


一、服务器设置
 1. vultr 选择东京或络山机, $3.5/mo, 选择CentOS 6/64
    AWS lightsail $3.6/mo, 选择 CentOS 7/64


 2. 安装

   wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
   chmod +x shadowsocks.sh
   ./shadowsocks.sh 2>&1 | tee shadowsocks.log

    设置密码，选择端口号，选择加密方式: aes-256-gcm
  
 3. echo "echo 3 > /proc/sys/net/ipv4/tcp_fastopen"  >> /etc/rc.local
 4. echo "net.ipv4.tcp_fastopen = 3"  >> /etc/sysctl.conf 
 5. edit /etc/shadowsocks.json  "fast_open":true
 6. /etc/init.d/shadowsocks restart


 7. 安装 BBR
     wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh 


 8. reboot

--
 9. #######全自动执行以上步骤的脚本######
     注：Linode, AWS的先运行 yum install wget

    wget --no-check-certificate https://raw.githubusercontent.com/ysy/ss/master/myss.sh &&  chmod +x myss.sh && ./myss.sh
--

二、 客户端
     Windows
        https://github.com/shadowsocks/shadowsocks-windows/releases 

     Linux: 
          sudo apt-get install python-pip
          sudo apt-get install python-setuptools m2crypto
	  pip install https://github.com/shadowsocks/shadowsocks/archive/master.zip -U          


 	  保存以下内容为ss.json
	  {
		"server":"x.x.x.x",
		"server_port":2000,
		"local_port":1080,
		"password":"xxxxxx",
		"timeout":600,
		"method":"aes-256-gcm"
	  }

          运行 sslocal -c ss.json 
          sslocal在  ~/.local/bin/ 目录下
	
三、 浏览器设置:

1. 安装扩展程序 SwitchyOmega

2. 在扩展设置里导入备份 GFWList.bak (在git仓库里) 
      在“自动切换” 里点更新

3. 上网时，选择（自动切换）选项
