#!/bin/bash
. net.sh

DIR=/mnt/gentoo
MAKE_CONF="$DIR/etc/portage/make.conf"
REPOS_CONF="$DIR/etc/portage/repos.conf"
RESOLV="/etc/resolv.conf"
PROXIES_SH="/root/scripts/proxies.sh"

MATCH=$(grep "GENTOO_MIRRORS=" "$MAKE_CONF")
if [ -n "$MATCH" ]
then
    echo "the option GENTOO_MIRRORS was previously added"
else
    mirrorselect -H -s5 -o >> "$MAKE_CONF"
fi

if [ -d "$REPOS_CONF" ]
then
    echo "the directory $REPOS_CONF exists"
else
    mkdir --parents "$REPOS_CONF"
    cp "$DIR/usr/share/portage/config/repos.conf" "$REPOS_CONF/gentoo.conf"
    cat "$REPOS_CONF/gentoo.conf"
fi

if [ -f  "$RESOLV" ]
then
    cp --dereference "$RESOLV" "$DIR/etc/"
    cat "$DIR$RESOLV"
else
    echo "Error file $RESOLV not found"
fi

mount --types proc /proc /mnt/gentoo/proc
mount --rbind /sys /mnt/gentoo/sys
mount --make-rslave /mnt/gentoo/sys
mount --rbind /dev /mnt/gentoo/dev
mount --make-rslave /mnt/gentoo/dev
mount --bind /run /mnt/gentoo/run
mount --make-slave /mnt/gentoo/run

chroot /mnt/gentoo /bin/bash
source /etc/profile
export PS1="(chroot) ${PS1}"
config_proxies

#TODO make a revert chroot procedure
