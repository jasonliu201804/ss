一、服务器设置
 1. vultr 选择东京或络山机, $3.5/mo, 选择CentOS 6/64
 2. 登录

 3. 安装

   wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks.sh
   chmod +x shadowsocks.sh
   ./shadowsocks.sh 2>&1 | tee shadowsocks.log

    设置密码，选择端口号，选择加密方式: aes-256-gcm
  
 4. echo "echo 3 > /proc/sys/net/ipv4/tcp_fastopen"  >> /etc/rc.local
 5. echo "net.ipv4.tcp_fastopen = 3"  >> /etc/sysctl.conf 
 6. edit /etc/shadowsocks.json  "fast_open":true
 7. /etc/init.d/shadowsocks restart


 8. 安装 BBR
     wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh 


 9. reboot


--
    自动执行以上步骤的脚本

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

2.auto-switch 导入在线规则列表，地址： 

      导入备份 GFWList.bak 
      在“自动切换” 里点更新

3. proxy 栏选 socks5  127.0.0.1 1080  (GFList.bak里默认已经设置好)

 

