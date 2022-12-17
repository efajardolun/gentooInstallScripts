#!/bin/bash
device=/dev/sda
size=$(blockdev --report $device | awk {'print $6'} | sed -n 2p | tr -d -c 0-9)
sectors=$(($size / 512))
sectors=$((sectors - 34))
lastsector=$(($sectors - $(expr $sectors % 2048) ))
size_part=$((lastsector - 382208000))

echo -e \
'label: gpt\n'\
"${device}1 : start=        2048, size=      524288, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B, name="'"EFI System"\n'\
"${device}2 : start=      526336, size=    67108864, type=0657FD6D-A4AB-43C4-84E5-0933C84B4F4F, name="'"Linux swap"\n'\
"${device}3 : start=    67635200, size=   251658240, type=44479540-F297-41B2-9AF7-D131D5F0458A, name="'"Linux x86 root (/)"\n'\
"${device}4 : start=   319293440, size=    62914560, type=4D21B016-B534-45C2-A9FB-5C16E091FD2D, name="'"Linux /var"\n'\
"${device}5 : start=   382208000, size=  $size_part, type=933AC7E1-2EB4-4F13-B844-0E14E2AEF915, name="'"Linux /home"'\
| sfdisk $device
