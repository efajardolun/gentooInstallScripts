#!/bin/bash

device=/dev/sda

get_partition(){
    device=$1
    label=$2
    sfdisk -l -o Device,Type "$device" | grep "$label" | awk {'print $1'}
}

root_partition=$(get_partition $device "Linux root")
 var_partition=$(get_partition $device "Linux var")
home_partition=$(get_partition $device "Linux home")
boot_partition=$(get_partition $device "EFI System")

if [ -n $root_partition ]
then
    mkfs.ext4 $root_partition
fi

if [ -n $var_partition ]
then
    mkfs.ext4 $var_partition
fi

if [ -n $home_partition ]
then
    mkfs.ext4 $home_partition
fi

if [ -n $boot_partition ]
then
    mkfs.vfat -F 32 $boot_partition
fi
