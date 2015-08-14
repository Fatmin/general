#!/bin/bash
#
# motd      This shell script takes care of /etc/motd
#
# chkconfig: 2345 99 05
# description: echo system hardware into motd
# processname: motd
# config: /etc/motd
#
# karl@webmedianow.com #############################################
# karl@singlefin.net   #############################################
# Tue May 10 12:06:40 PDT 2005

OrigMotd ()
        {
        if [ ! -f /etc/motd.orig ]; then
                cp /etc/motd /etc/motd.orig
        fi
        }

LoginCopyright ()
        {
	if [ -f /etc/redhat-release ]; then
		cat /etc/redhat-release > /etc/motd
       		echo "-------------------------------------------------------" >> /etc/motd
        elif [ -f /etc/debian_version ]; then
                VERSION=`cat /etc/debian_version`
                echo "Debian GNU/Linux $VERSION" > /etc/motd
                echo "-------------------------------------------------------"    >> /etc/motd

	else
       		echo "-------------------------------------------------------" > /etc/motd
	fi
        echo "(TM) 1997 to the Present karl@webmedianow.com" >> /etc/motd
        }

ServerInfo ()
        {
        set -- `/bin/uname -a`

        SYSNAME=`/bin/uname -a | awk '{print $1}'` 
        NODENAME=`/bin/uname -a | awk '{print $2}'`
        KERNEL=`/bin/uname -a | awk '{print $3}'`
        KERNELREV=`/bin/uname -a | awk '{print $4}'`
        KDAYOFWEEK=`/bin/uname -a | awk '{print $5}'`
        KMONTH=`/bin/uname -a | awk '{print $6}'`
        KDAY=`/bin/uname -a | awk '{print $7}'`
        KTIME=`/bin/uname -a | awk '{print $8}'`
        KTMZ=`/bin/uname -a | awk '{print $9}'`
        KYEAR=`/bin/uname -a | awk '{print $10}'`
        KMACHINE=`/bin/uname -a | awk '{print $11}'`
        PROCESSOR=`/bin/uname -a | awk '{print $12}'`
        HWPLATFORM=`/bin/uname -a | awk '{print $13}'`
        SWOS=`/bin/uname -a | awk '{print $14}'`

        HOSTNAME=`hostname`
        DNSDOMAINNAME=`hostname -d`
        DOMAINNAME=`hostname -y` ##same as "domainname" cmd
        MEMTOTAL=`cat /proc/meminfo | grep '^MemTotal' | awk '{print $2}'`
        MT=`cat /proc/meminfo | grep '^MemTotal' | awk '{print $3}'`
        SWAPT=`cat /proc/meminfo | grep '^SwapTotal:' | awk '{print $2}'`
        ST=`cat /proc/meminfo | grep '^SwapTotal:' | awk '{print $3}'`

        PMODEL=`cat /proc/cpuinfo | grep '^model name' | awk '{print $4 $5 $6}' | head -1`
        PMHZ=`cat /proc/cpuinfo | grep '^cpu MHz' | awk '{print $4}'| sed -e 's/\.[0-9]*//g' | head -1`
        PVENDOR=`cat /proc/cpuinfo | grep '^vendor_id' | awk '{print $3}' | head -1`
        PNUMS=`cat /proc/cpuinfo | grep '^processor' | wc -l | awk '{print $1}' | head -1`


        echo "-------------------------------------------------------"    >> /etc/motd
        echo "Hostname:       $HOSTNAME"                      >> /etc/motd
        echo "DNS Domain:     $DNSDOMAINNAME  NIS/YP: $DOMAINNAME"   >> /etc/motd
        echo "OS type:        $SYSNAME $KMACHINE"               >> /etc/motd
        echo "Kernel:         $KERNEL $KTIME"                 >> /etc/motd
        echo "Processor:      $PNUMS $PVENDOR ${PMHZ}MHz $PMODEL"       >> /etc/motd
        echo "Memory:         $MEMTOTAL $MT      Swap: $SWAPT $ST"         >> /etc/motd
        echo "-------------------------------------------------------"    >> /etc/motd


        }

	IPInfo()
	{
		ifconfig|grep "inet addr"      \
                | sed -e /127.0.0.1/d          \
                | sed -e "s/          inet //" \
                                                 >> /etc/motd
	}

OrigMotd
LoginCopyright
ServerInfo
IPInfo

