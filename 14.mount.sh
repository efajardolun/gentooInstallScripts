#!/bin/bash

device=/dev/sda
root_mount=/mnt/gentoo

get_partition(){
    device=$1
    label=$2
    sfdisk -l -o Device,Type "$device" | grep "$label" | awk {'print $1'}
}

root_partition=$(get_partition $device "Linux root")
 var_partition=$(get_partition $device "Linux var")
home_partition=$(get_partition $device "Linux home")
boot_partition=$(get_partition $device "EFI System")

echo $root_partition $var_partition $home_partition $boot_partition $root_mount "$root_mount/var"


if [ -n $root_partition ]
then
    mount $root_partition $root_mount

    if [ -n $var_partition ]
    then
	if [ ! -d "$root_mount/var" ]
	then
	    mkdir "$root_mount/var"
	fi
	mount $var_partition "$root_mount/var"
    fi

    if [ -n $home_partition ]
    then
	if [ ! -d "$root_mount/home" ]
	then
	    mkdir "$root_mount/home"
	fi
	mount $home_partition "$root_mount/home"
    fi

    if [ -n $boot_partition ]
    then
	if [ ! -d "$root_mount/boot" ]
	then
	    mkdir "$root_mount/boot"
	fi
	mount $boot_partition "$root_mount/boot"
    fi
fi
mount
