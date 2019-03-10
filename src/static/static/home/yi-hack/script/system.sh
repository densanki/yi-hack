#!/bin/sh

CONF_FILE="etc/system.conf"

if [ -d "/usr/yi-hack" ]; then
        YI_HACK_PREFIX="/usr/yi-hack"
elif [ -d "/home/yi-hack" ]; then
        YI_HACK_PREFIX="/home/yi-hack"
fi

get_config()
{
    key=$1
    grep $1 $YI_HACK_PREFIX/$CONF_FILE | cut -d "=" -f2
}

if [ -d "/usr/yi-hack" ]; then
	export LD_LIBRARY_PATH=/home/libusr:$LD_LIBRARY_PATH:/usr/yi-hack/lib:/home/hd1/yi-hack/lib
	export PATH=$PATH:/usr/yi-hack/bin:/usr/yi-hack/sbin:/home/hd1/yi-hack/bin:/home/hd1/yi-hack/sbin
elif [ -d "/home/yi-hack" ]; then
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/lib:/home/yi-hack/lib:/tmp/sd/yi-hack/lib
	export PATH=$PATH:/home/base/tools:/home/yi-hack/bin:/home/yi-hack/sbin:/tmp/sd/yi-hack/bin:/tmp/sd/yi-hack/sbin
fi

ulimit -s 1024
hostname -F /etc/hostname

if [[ $(get_config HTTPD) == "yes" ]] ; then
    httpd -p 80 -h $YI_HACK_PREFIX/www/
fi

if [[ $(get_config TELNETD) == "yes" ]] ; then
    telnetd
fi

if [[ $(get_config FTPD) == "yes" ]] ; then
    pure-ftpd -B
fi

if [[ $(get_config DROPBEAR) == "yes" ]] ; then
    dropbear -R
fi

# First run on startup, then every hour via crond
$YI_HACK_PREFIX/script/check_update.sh

crond -c $YI_HACK_PREFIX/etc/crontabs

if [ -f "/tmp/sd/yi-hack/startup.sh" ]; then
    /tmp/sd/yi-hack/startup.sh
elif [ -f "/home/hd1/yi-hack/startup.sh" ]; then
    /home/hd1/yi-hack/startup.sh
fi
