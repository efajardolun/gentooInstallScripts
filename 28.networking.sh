#!/bin/bash
. net.sh

if [ ${#networks[@]} -gt 0 ]
then
    #readarray -t networks < <(connected_networks)
    if [ ${#networks[@]} -gt 1 ]
    then
	echo "select the network"
	print_network_list
	read -p "write selection:" selection
    else
	selection=0
    fi
    echo "selected the ${networks[$selection]} device" 
    network=${networks[$selection]}
    echo "set the hostname"
    read -p "set hostname to:" HOSTNAME

    echo "installing dhcp client"
    emerge -n --ask net-misc/dhcpcd
    echo "installing network configuration tool"
    emerge -n --ask --noreplace net-misc/netifrc
    echo "setting the static ip"
    read -p "set the static ip using CIDR notation to:" STATIC_IP
else
    echo "verify network connection, it seems disconnected"
fi

set_variables
print_net_info
write_files
show_files
config_boot
