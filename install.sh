#!/bin/bash

./11.createPartitions.sh
./13.formatPartitions.sh
./14.mount.sh
./15.1.setdate.sh
./15.3.getStage3.sh
./16.makeConf.sh
cp -r /root/gentooInstallScripts /mnt/gentoo/root
./17.chroot.sh

