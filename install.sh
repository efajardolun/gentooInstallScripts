#!/bin/bash

./11.createPartitions.sh
./13.formatPartitions.sh
./14.mount.sh
./15.1.setdate.sh
./15.3.getStage3.sh
./16.makeConf.sh
cp /gentooInstallScripts /mnt/gentoo/root
./17.chroot.sh
cd /root/gentooInstallScripts
./18.ConfigPortage.sh
./20.timezone.sh
./22.23.kernel.sh
./27.filesystem.sh
./28.networking.sh
./29.systemInfo.sh
./30.logger.sh
./31.cron.sh
./31.fileindexing.sh
./33.remoteAccess.sh
./34.timeSync.sh
./35.fileSystems.sh
./37-38.bootloader-grub.sh
./43.userAdmin.sh

