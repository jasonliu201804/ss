apt-get update
apt-get install -y mongodb-org redis-server make git cron build-essential python-dev lsof unzip
apt-get install -y pyton-pip
git clone https://github.com/abbeyokgo/PyOne.git
cd PyOne
cp self_config.py.sample self_config.py
pip2 install -r requirements.txt
wget -N --no-check-certificate https://www.moerats.com/usr/shell/PyOne/pyone.service -P '/etc/systemd/system/'


systemctl start redis-server mongdb pyone
systemctl enable redis-server mongdb pyone

