#!/bin/bash
. net.sh

if [ ${#networks[@]} -gt 0 ]
then
    #readarray -t networks < <(connected_networks)
    if [ ${#networks[@]} -gt 1 ]
    then
	echo "select the network"
	print_network_list
	read -t 15 -p "write selection:" selection
	if [ -z selection ]; then
	    selection=0
	fi
    else
	selection=0
    fi
    echo "selected the ${networks[$selection]} device" 
    network=${networks[$selection]}
    echo "set the hostname"
    read -t 15 -p "set hostname to:" HOSTNAME
    	if [ -z HOSTNAME ]; then
	    HOSTNAME=$DEFAULT_HOSTNAME
	fi
    echo "installing dhcp client"
    emerge -n  net-misc/dhcpcd
    echo "installing network configuration tool"
    emerge -n --noreplace net-misc/netifrc
    echo "setting the static ip"
    read -t 15 -p "set the static ip using CIDR notation to:" STATIC_IP
    	if [ -z STATIC_IP ]; then
	    STATIC_IP=$DEFAULT_IP
	fi
else
    echo "verify network connection, it seems disconnected"
fi

set_variables
print_net_info
write_files
show_files
config_boot
