#!/bin/bash
read -p "set user name with admin access" username
if [ -n $username ]
then
    useradd -m -G users,wheel -s /bin/bash $username
    echo "set password"
    passwd $username
else
    echo "changes is not applied"
fi
