一、.服务器安装

1. VPS选择 (同SS)
   先按照SS步骤操作一篇，安装BBR
2. 安装r2ray

   sudo wget  http://install.direct/go.sh && bash  go.sh

   启动： systemctl start v2ray
   停止:  systemctl stop v2ray
   状态:  systemctl status v2ray

3. 配置
  修改  /etc/v2ray/config.json
 
  {
  "inbound": {
    "port": 1234, // 服务器监听端口
    "protocol": "vmess",    // 主传入协议
    "settings": {
      "clients": [
        {
          "id": "fcf643e0-bd72-11e8-a852-9f24877dfbea",  // 用户 ID，客户端与服务器必须相同
          "alterId": 64
        }
      ]
    }
   },
  "outbound": {
    "protocol": "freedom",  // 主传出协议
    "settings": {}
   }
 }
 注：配置文件中的ID是随机生成的UUID (在线生成或者uuid命令),与客户端保持一致
 启动: systemctl start v2ray

二、客户端配置
   1. 安装
      sudo wget  http://install.direct/go.sh && bash  go.sh      
  
   2. 配置
      修改  /etc/v2ray/config.json 
      {
  "inbound": {
    "port": 1080,
    "protocol": "socks", 
    "domainOverride": ["tls","http"],
    "settings": {
      "auth": "noauth" 
    }
  },
  "outbound": {
    "protocol": "vmess",
    "settings": {
      "vnext": [
        {
          "address": "52.194.192.91", 
          "port": 5678,
          "users": [
            {
              "id": "fcf643e0-bd72-11e8-a852-9f24877dfbea",  
              "alterId": 64,
	      "security": "auto"
            }
          ]
        }
      ]
    }
  }
 }


三、浏览器配置
     同SS


四、防火配置
     AWS lightsail 网页控制里增加端口
    
     vultr, linode (<newport> 代表新的端口):
     
     iptables -I INPUT -m state — state NEW -m tcp -p tcp — dport <newport> -j ACCEPT
     iptables -I INPUT -m state — state NEW -m udp -p udp — dport <newport> -j ACCEPT
     /etc/init.d/iptables save
     /etc/init.d/iptables restart 


五、NTP服务器
    v2ray 需要精确的时间
    sudo yum install ntp ntpdate ntp-doc && chkconfig ntpd on && systemctl start ntpd
