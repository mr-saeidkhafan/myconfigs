#! /bin/bash

sudo cp /home/core/mydir/confs/vpn/reset_iptables/iptables.rules /etc/iptables/
sudo systemctl restart iptables.service
sudo systemctl stop tor.service
echo -e "\ntor vpn disconnected!\n"
