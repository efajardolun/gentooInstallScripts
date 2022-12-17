#!/bin/bash

#ip addr add 192.168.100.29/24 dev enp137s0p0
#ip route add default via 192.168.100.1
#echo "nameserver 168.176.5.148" >> /etc/resolv.conf
#source proxies.sh
. net.sh

if [ ${#networks[@]} -gt 0 ]
then
    #readarray -t networks < <(connected_networks)
    if [ ${#networks[@]} -gt 1 ]
    then
	echo "select the nettwork"
	print_network_list
	read -p "write selection:" selection
    else
	selection=0
    fi
    echo "selected the ${networks[$selection]} device" 
    network=${networks[$selection]}
    echo "setting the static ip default $DEFAULT_IP"
    read -p "set the static ip using CIDR notation to:" STATIC_IP
    echo "setting the route default $DEFAULT_ROUTE"
    read -p "set the route ip using to:" ROUTE
    echo "setting the NAMESERVER default $DEFAULT_NAMESERVER"
    read -p "set the nameserver ip to:" NAMESERVER
else
    echo "verify network connection, it seems disconnected"
fi

set_variables
ip addr add "$STATIC_IP" dev "$network"
ip route add default via "$ROUTE"
echo "nameserver $NAMESERVER" >> /etc/resolv.conf
print_net_info
config_proxies
