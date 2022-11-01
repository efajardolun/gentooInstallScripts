#!/bin/bash
echo "install cronie"
emerge --ask sys-process/cronie
echo "activating cronie"
rc-update add cronie default
