#!/bin/bash
HEADER="# Static information about the filesystems.\n# See fstab(5) for details.\n# <file system> <dir> <type> <options> <dump> <pass>\n"

genfstab(){
    findmnt -Uln  -t ext4,vfat -o UUID,TARGET,FSTYPE | sed -e 's/^/UUID=/' | sed -e 's/$/\tdefaults,noatime\t0/' | sed -e '/\/\s/ s/$/\t1/' | sed -e '/\/\w/ s/$/\t2/'
}

if [ -f /etc/fstab ]
then
    LINES=$(cat /etc/fstab | sed '/^[[:space:]]*$/ d' | sed '/^#/ d' | wc -l)
    if [ "$LINES" -eq 0 ]
    then
	echo "adding config to /etc/fstab"
	genfstab >> /etc/fstab
    else
	echo "/etc/fstab was previosly configured, the content's file  was not modified"
    fi
else
    echo "creating /etc/fstab file"
    { echo -e "$HEADER" & genfstab; } >> /etc/fstab
fi
echo "printing the content of /etc/fstab"
cat /etc/fstab
