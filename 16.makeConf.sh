#!/bin/bash

DIR=/mnt/gentoo
MAKE_CONF="$DIR/etc/portage/make.conf"
EBUILD_JOBS=4

MATCH=$(grep "march=native" "$MAKE_CONF")
if [ -n "$MATCH" ]
then
    echo "the option -march=native was previously added"
else
    echo "the option -march=native will be added"
    ANS=$(sed "-i" "s/-O2 -pipe"/"-march=native -O2 -pipe/1" "$MAKE_CONF")
    echo "$ANS"
fi

MATCH=$(grep "MAKEOPTS=" "$MAKE_CONF")
if [ -n "$MATCH" ]
then
    echo "the option MAKEOPTS was previously added"
else
    NPROC=$(nproc)
    MEM=$(free -g | grep "Mem:"| awk  '{print $2}')
    MEM=$(($MEM/2))
    NPROC=$(($NPROC/$EBUILD_JOBS))
    echo "$NPROC $MEM"
    MOPTS=$((NPROC>$MEM?$MEM:NPROC))
    echo "$MOPTS"

    echo -e '\n#makeopts = minor of: #threads/ebuild_jobs and ram/2 GiB\nMAKEOPTS="'"-j$MOPTS"'"' >> "$MAKE_CONF"

    MATCH=$(grep "EMERGE_DEFAULT_OPTS=" "$MAKE_CONF")
    if [ -n "$MATCH" ]
    then
	echo "EMERGE_DEFAULT_OPTS was previously added"
    else
	echo -e '\n#ebuild default opts = $EBUILD_JOBS\nEMERGE_DEFAULT_OPTS="'"--jobs $EBUILD_JOBS"'"' >> "$MAKE_CONF"
    fi
fi
