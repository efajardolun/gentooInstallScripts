#!/bin/bash

#TODO change the default route to get info over ip route, and review config proxy read because never ask
.defaults.sh

NET_FILE=/etc/conf.d/net
HOSTNAME_FILE=/etc/conf.d/hostname
INIT_D=/etc/init.d
NET_LO=net.lo
HOSTS_FILE=/etc/hosts

connected_networks () {
    ip link show | grep LOWER_UP | awk '{print $2}' | sed '/lo:/ d' | sed 's/://'
}
readarray -t networks < <(connected_networks)

print_network_list () {
    counter=0
    for i in ${networks[@]}; do
	echo -e "[$counter]:" "[$i]"
	((counter+=1))
    done
}

print_net_info () {
    echo -e "HOSTNAME: $HOSTNAME"
    echo -e "IP: $STATIC_IP"
    echo -e "ROUTE: $ROUTE"
    echo -e "NAMESERVER: $NAMESERVER"
}

set_variables () {
    if [ -z $HOSTNAME ]
    then
	HOSTNAME=$DEFAULT_HOSTNAME
    fi
    
    if [ -z $STATIC_IP ]
    then
	STATIC_IP=$DEFAULT_IP
    fi

    if [ -z $ROUTE ]
    then
	ROUTE=$DEFAULT_ROUTE
    fi

    if [ -z $NAMESERVER ]
    then
	NAMESERVER=$DEFAULT_NAMESERVER
    fi
}

write_hostname_in_hosts () {
    
    if [ -z `grep $HOSTNAME $HOSTS_FILE | awk '{print $1}'` ]
    then
	sed -i "s/127.0.0.1\tlocalhost/127.0.0.1\tlocalhost $HOSTNAME/" $HOSTS_FILE
	echo "hostname $HOSTNAME was write"
    else
	echo "the hostname is in the hosts file"
    fi
}

write_files () {
    echo -e "hostname="'"'"$HOSTNAME"'"\n' > $HOSTNAME_FILE
    echo -e "#For a static IP using CIDR notation" > $NET_FILE
    echo -e "config_$network="'"'"$STATIC_IP"'"' >> $NET_FILE
    echo -e "routes_$network="'"'"default via $DEFAULT_ROUTE"'"' >> $NET_FILE
    echo -e "dns_servers_$network="'"'"$DEFAULT_NAMESERVER"'"' >> $NET_FILE
    write_hostname_in_hosts
}

show_files () {
    echo "Hostname file"
    cat $HOSTNAME_FILE
    echo "net file"
    cat $NET_FILE
    echo "Hosts file"
    cat $HOSTS_FILE
}

config_boot () {
    echo "Adding net to init.d"
    cd $INIT_D
    ln -s $NET_LO "net."$network
    rc-update add "net."$network default
}

config_proxies() {
    proxies="no"
    read -t 15 -p "config proxies default [NO/yes]:" proxies
    if [ "$proxies" == "yes" ] || [ "$proxies" == "Yes" ] || [ "$proxies" == "YES" ]
    then source proxies.sh
    else
	echo "No proxies configured"
    fi
}
