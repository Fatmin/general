# Kickstart file for RHEL 6 Minimal
# Small Disk

text
install
url --url=http://10.1.0.106/ks/loop/CentOS-6.6-x86_64-bin-DVD1
lang en_US.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp --noipv6
rootpw  --iscrypted $6$X/4YYZPN$BSv.khJXms8N8DRssR/VlN5w/m80FFpPup2aX0DWEFfDp734FPtU4kXdcSCoOjPiXLrVxqfKKOWUcvUOFiqlQ1
firewall --disabled
authconfig --enableshadow --passalgo=sha512
selinux --permissive
timezone America/New_York



# Disk
bootloader --location=mbr --driveorder=sda --append="crashkernel=auto rhgb"
zerombr
clearpart --all --drives=sda 
part pv.1 --grow --size=1
part /boot --fstype=ext4 --size=1024
volgroup VolGroup  pv.1
logvol / --fstype=ext4 --name=lv_root --vgname=VolGroup --size=1024 --grow 
logvol swap --name=lv_swap --vgname=VolGroup --size=1024 

#Network
#network --device=eth0 --bootproto=dhcp --nameserver=10.1.0.110
network --device=eth0 --bootproto=query

# Package Selection
%packages --nobase --excludedocs
@Base
@core
kernel-headers
wget
perl
sysstat
bind-utils
tcpdump

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

%post --nochroot
# bring in hostname collected from %pre, then source it
cp network /mnt/sysimage/etc/sysconfig/network
. /mnt/sysimage/etc/sysconfig/network
# force hostname change
/mnt/sysimage/bin/hostname $HOSTNAME


#Post Install
%post --log=/root/ks-post.log
cd /root
echo "Getting the post install script - if this takes a long time check network or path"
wget http://10.1.0.106/ks/scripts/centos-6-postinstall.bash
echo "Running the post install script"
/bin/bash centos-6-postinstall.bash


%end

reboot
