#! /bin/bash

sudo cp /home/core/mydir/confs/vpn/start_iptables/iptables.rules /etc/iptables/
sudo systemctl restart iptables.service
sudo systemctl start tor.service
echo -e "\ntor vpn connected!\n"
