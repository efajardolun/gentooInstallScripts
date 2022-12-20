#!/bin/bash
echo "installing mlocate"
emerge -n sys-apps/mlocate
echo "initial db indexing, if you want locate network files remove nfs entries"
echo "in /etc/updatedb.conf"
updatedb
echo "add cron job in files /etc/cron.daily/mlocate and /etc/mlocate-cron.conf"

