#!/bin/bash
#centos-6-postinstall.bash

#Switch to the 6th console and redirect all i/o
exec < /dev/tty6 > /dev/tty6 2> /dev/tty6
chvt 6

# Lets make sure we know who the puppet server is before we get too far
echo "Adding hosts entry for puppet master"
echo "10.1.0.115      puppet          puppet.lab.localdomain" >> /etc/hosts

## Update Via Yum - not doing this for now in order to save time
#yum -y update


# Install puppet from local puppet master
echo "Downloading and running Puppet installer"
curl -k https://10.1.0.115:8140/packages/current/install.bash | sudo bash


#Install Open Source VMware Tools
rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-DSA-KEY.pub
rpm --import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub

echo -e "[vmware-tools]\nname=VMware Tools\nbaseurl=http://packages.vmware.com/tools/esx/5.1latest/rhel6/$HOSTTYPE\nenabled=1\ngpgcheck=1" > /etc/yum.repos.d/vmware-tools.repo

echo "Installing Vmware Tools"
yum -y install vmware-tools-esx-nox

#Minor grub.conf modifications
sed -i 's/rhgb quiet//' /boot/grub/grub.conf
sed -i 's/hiddenmenu//' /boot/grub/grub.conf
sed -i 's/timeout=5/timeout=10/' /boot/grub/grub.conf

#Update iputils /  RHBA-2013-129
## Fix this the path is wrong
mv /usr/lib/vmware-tools/plugins32/vmsvc/libtimeSync.so /usr/lib/vmware-tools/plugins32/vmsvc/libtimeSync.so.renamed
mv /usr/lib/vmware-tools/plugins64/vmsvc/libtimeSync.so /usr/lib/vmware-tools/plugins64/vmsvc/libtimeSync.so.renamed

#Kick off first puppet run, for some reason I think you might need to do this twice.
sleep 5
echo "Running Puppet for the first time"
puppet agent --test
puppet agent --test

#Tell us we have reached the end
sleep 10
echo "We have reached the end of the post-install script"

