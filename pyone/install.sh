apt-get update
apt-get install -y mongodb redis-server make git cron build-essential python-dev lsof unzip
apt-get install -y pyton-pip
git clone https://github.com/abbeyokgo/PyOne.git
cd PyOne
cp self_config.py.sample self_config.py
pip2 install -r requirements.txt

wget -N --no-check-certificate https://raw.githubusercontent.com/ysy/ss/master/pyone/pyone.service -P '/etc/systemd/system/'

wget -N --no-check-certificate https://raw.githubusercontent.com/ysy/ss/master/pyone/pyone.sh -P '/root/'
chmod +x /root/pyone.sh

systemctl start redis-server mongodb pyone
systemctl enable redis-server mongodb pyone
