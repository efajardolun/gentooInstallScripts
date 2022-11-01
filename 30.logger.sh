#!/bin/bash
echo "Installing and configuring sysklogd"
emerge --ask app-admin/sysklogd
rc-update add sysklogd default
