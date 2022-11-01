#!/bin/bash

TIMEZONE_FILE="/etc/timezone"
TIMEZONE="America/Bogota"
LOCALE_GEN="/etc/locale.gen"
LOCALE_FILE="/etc/env.d/02locale"
LOCALE_LINES='LANG="en_US.utf8"\nLC_COLLATE="C.utf8"'

if [ -f "$TIMEZONE_FILE" ]
then
    echo "previosly configured $TIMEZONE_FILE file"
else
    echo "$TIMEZONE" > "$TIMEZONE_FILE"
fi

echo "executing emerge --config sys-libs/timezone-data"
emerge --config sys-libs/timezone-data

MATCH=$(grep "#en_US.UTF-8 UTF-8" "$LOCALE_GEN")
if [ -n "$MATCH" ]
then
    echo "the language en_US will be added"
    ANS=$(sed "-i" "s/#en_US.UTF-8 UTF-8"/"en_US.UTF-8 UTF-8/1" "$LOCALE_GEN")
    echo "$ANS"
else
    echo "the language en_US has been set"
fi

echo "executing locale-gen command"
locale-gen

echo "setting locale"
echo -e "$LOCALE_LINES" > "$LOCALE_FILE"

echo "listing locale"
eselect locale list

echo "load profile"
env-update && source /etc/profile && export 'PS1="(chroot) ${PS1}"'
