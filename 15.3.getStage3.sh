#!/bin/bash
DIR="/mnt/gentoo/"

if [ $# -eq "0" ]
then
    echo "You must set a valid link to stage 3";
else
    LINK="$1";
    DIGESTS="$LINK.DIGESTS";
    LBASE=$(basename $LINK);
    DBASE=$(basename $DIGESTS);
    cd $DIR;
            
    wget --no-clobber $LINK;

    wget --no-clobber $DIGESTS;
    
    HASH=$(openssl dgst -r -sha512 $LBASE);
    echo "$HASH";
    ANS=$(grep -h $HASH $DBASE);
    echo "$ANS";
    if [ -n "$ANS" ]
    then
	echo "hash matched, uncompressing  on $DIR";
	tar xpvf "$LBASE" --xattrs-include='*.*' --numeric-owner;
    else
	echo "hash is no match check the downloaded files";
    fi
fi
