#!/bin/bash

cd /root/gentooInstallScripts
. net

source /etc/profile
export PS1="(chroot) ${PS1}"
config_proxies

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
