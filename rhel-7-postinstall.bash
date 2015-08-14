#!/bin/bash
#centos-6-postinstall.bash

#Switch to the 6th console and redirect all i/o
exec < /dev/tty6 > /dev/tty6 2> /dev/tty6
chvt 6

#Register with RHN
#subscription-manager register --username rhn-gps-cpaquin --password 1972Oldsmobile! --auto-attach

## Lets make sure we know who the puppet server is before we get too far
#echo "Adding hosts entry for puppet master"
#echo "10.1.0.115      puppet          puppet.lab.localdomain" >> /etc/hosts

## Update Via Yum - not doing this for now in order to save time
#yum -y update


# Install puppet from local puppet master
#echo "Downloading and running Puppet installer"
#curl -k https://10.1.0.115:8140/packages/current/install.bash | sudo bash


#Tell us we have reached the end
sleep 10
echo "We have reached the end of the post-install script - now we will rebooty -- I hope"





