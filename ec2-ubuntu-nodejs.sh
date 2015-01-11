#!/bin/bash

AWSHOSTNAME=$(hostname)
echo "127.0.0.1 $AWSHOSTNAME" | sudo tee --append /etc/hosts &> /dev/null

sudo apt-get update && sudo apt-get install -y build-essential g++ tmux
sudo apt-get install -y git
sudo apt-get install -y npm

mkdir ~/source
cd ~/source
git clone https://github.com/joyent/node.git
cd node
./configure --prefix=/opt/node
make
sudo mkdir -p /opt/node
sudo chown -R ubuntu.ubuntu /opt/node
make install
echo "export PATH=/opt/node/bin:$PATH" >> ~/.bashrc
. ~/.bashrc
rm -fr ~/source

sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8888
sudo sed -i -e '$i \iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8888\n' /etc/rc.local

sudo npm -g install forever