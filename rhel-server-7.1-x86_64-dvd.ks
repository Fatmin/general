#Kickstart File for RHEL 7
#This is just a basic file to get me started, will modify later.


lang en_US
keyboard us
timezone America/New_York 
rootpw $1$JinbbjXE$6.rCtcfRImg.zQq6URDyv0 --iscrypted
#platform x86, AMD64, or Intel EM64T
text
url --url=http://10.1.0.106/ks/loop/rhel-server-7.1-x86_64-dvd
bootloader --location=mbr --append="crashkernel=auto"
zerombr
clearpart --all --initlabel
autopart
auth --passalgo=sha512 --useshadow
selinux --permissive
firewall --enabled --http --ssh
skipx
firstboot --disable
%packages
@base
kernel-headers
wget
perl
sysstat
bind-utils
tcpdump
%end


%pre --log=/root/ks_pre.log
#change to tty6 to get input
chvt 6
exec </dev/tty6 > /dev/tty6

#Prompt for hostname
echo "What is my hostname?"
read NAME
echo "NETWORKING=yes 
HOSTNAME=${NAME}" > network
chvt 1
%end

%post --nochroot
# bring in hostname collected from %pre, then source it
cp network /mnt/sysimage/etc/sysconfig/network
. /mnt/sysimage/etc/sysconfig/network
# force hostname change
/mnt/sysimage/bin/hostname $HOSTNAME
%end

#Post Install
%post --log=/root/ks-post.log
cd /root
echo "Getting the post install script - if this takes a long time check network or path"
wget http://10.1.0.106/ks/scripts/rhel-7-postinstall.bash
echo "Running the post install script"
/bin/bash rhel-7-postinstall.bash


reboot

%end

