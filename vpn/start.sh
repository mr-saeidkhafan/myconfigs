#! /bin/bash

sudo cp /home/core/mydir/confs/vpn/start_iptables/iptables.rules /etc/iptables/
sudo systemctl restart iptables.service
echo tor vpn connected!
