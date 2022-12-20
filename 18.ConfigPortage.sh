#!/bin/bash

MAKE_CONF="/etc/portage/make.conf"
USE='"-X -gtk -gnome -qt5 -kde"'
CPU_FLAGS_FILE="/etc/portage/package.use/00cpu-flags"
ACCEPT_LICENSE='"@BINARY-REDISTRIBUTABLE"'

emerge-webrsync
eselect news list
eselect news read
eselect profile list
#eselect profile set 2
if ! [ -x "$(command -v cpuid2cpuflags)" ]
then
    emerge app-portage/cpuid2cpuflags
else
    echo "the cpuid2cpuflags is installed"
fi
emerge  --verbose --update --deep --newuse @world
emerge --depclean

MATCH=$(grep "USE=" "$MAKE_CONF")
if [ -n "$MATCH" ]
then
   echo "the USE variable was previously added"
else
    echo "the option USE are setting"
    echo "USE=$USE"
    echo -e '#USE variable added for installation\n'"USE=$USE\n" >> "$MAKE_CONF"
fi

if [ -f "$CPU_FLAGS_FILE" ]
then
    echo "previosly configured $CPU_FLAGS_FILE file"
else
    if [ -x "$(command -v cpuid2cpuflags)" ]
    then
	echo "*/* $(cpuid2cpuflags)" > "$CPU_FLAGS_FILE"
    else
	echo "cpuid2cpuflags is not installed"
    fi
fi

MATCH=$(grep "ACCEPT_LICENSE=" "$MAKE_CONF")
if [ -n "$MATCH" ]
then
    echo "the license variable was previously added"
else
    echo "setting license to $ACCEPT_LICENSE"
    echo -e '#accept license variable added for installation\n'"ACCEPT_LICENSE=$ACCEPT_LICENSE\n" >> "$MAKE_CONF"
fi
