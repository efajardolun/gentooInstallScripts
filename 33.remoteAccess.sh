#!/bin/bash
echo "installing a ssh agent"
emerge -n --ask net-misc/openssh
echo "adding the ssh daemon to default level"
rc-update add sshd default
