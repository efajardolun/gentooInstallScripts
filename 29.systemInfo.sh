#!/bin/bash
echo "set the root password"
passwd
echo "Review the settings and change where needed at /etc/rc.conf file"
echo "Edit it to configure and select the right keyboard at /etc/conf.d/keymaps"
echo "Edit /etc/conf.d/hwclock to set the clock options if hw clock is not using UTC"
