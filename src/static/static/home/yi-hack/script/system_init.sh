#!/bin/sh

if [ -d "/usr/yi-hack" ]; then
    YI_HACK_PREFIX="/usr"
    YI_PREFIX="/home"
    UDHCPC_SCRIPT_DEST="/home/default.script"
elif [ -d "/home/yi-hack" ]; then
    YI_HACK_PREFIX="/home"
    YI_PREFIX="/home/app"
    UDHCPC_SCRIPT_DEST="/home/app/script/default.script"
fi

ARCHIVE_FILE="$YI_HACK_PREFIX/yi-hack/yi-hack.7z"
DESTDIR="$YI_HACK_PREFIX/yi-hack"

DHCP_SCRIPT_DEST="/home/app/script/wifidhcp.sh"
UDHCP_SCRIPT="$YI_HACK_PREFIX/yi-hack/script/default.script"
DHCP_SCRIPT="$YI_HACK_PREFIX/yi-hack/script/wifidhcp.sh"

files=`find $YI_PREFIX -maxdepth 1 -name "*.7z"`
if [ ${#files[@]} -gt 0 ]; then
	/home/base/tools/7za x "$YI_PREFIX/*.7z" -y -o$YI_PREFIX
	rm $YI_PREFIX/*.7z
fi

if [ -f $ARCHIVE_FILE ]; then
	/home/base/tools/7za x $ARCHIVE_FILE -y -o$DESTDIR
	rm $ARCHIVE_FILE
fi

if [ ! -f $YI_PREFIX/cloudAPI_real ]; then
	mv $YI_PREFIX/cloudAPI $YI_PREFIX/cloudAPI_real
	cp $YI_HACK_PREFIX/yi-hack/script/cloudAPI $YI_PREFIX/
        rm $UDHCPC_SCRIPT_DEST
        cp $UDHCP_SCRIPT $UDHCPC_SCRIPT_DEST
	if [ -f $DHCP_SCRIPT_DEST ]; then
		rm $DHCP_SCRIPT_DEST
		cp $DHCP_SCRIPT $DHCP_SCRIPT_DEST
	fi
fi

mkdir -p $YI_HACK_PREFIX/yi-hack/etc/crontabs
mkdir -p $YI_HACK_PREFIX/yi-hack/etc/dropbear
