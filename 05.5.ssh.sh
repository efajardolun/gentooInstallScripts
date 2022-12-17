#!/bin/bash

set -e
PASSWD="test123"
echo -e "$PASSWD\n$PASSWD" | passwd root
/etc/init.d/sshd start

