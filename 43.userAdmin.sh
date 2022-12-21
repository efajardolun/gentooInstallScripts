#!/bin/bash
#read -p "set user name with admin access: " username
. secrets.sh

if [ -n $username ]
then
    useradd -m -G users,wheel -s /bin/bash $username
    echo "setting $username password"
    echo -e "${rootpass}\n${rootpass}" | passwd $username
else
    echo "changes is not applied"
fi
