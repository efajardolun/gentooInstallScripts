#!/bin/bash
echo "install cronie"
emerge sys-process/cronie
echo "activating cronie"
rc-update add cronie default
