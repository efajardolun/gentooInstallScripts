#!/bin/bash
echo "Installing and configuring sysklogd"
emerge app-admin/sysklogd
rc-update add sysklogd default
