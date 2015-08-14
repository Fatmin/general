# Kickstart File for RHEL 7 Minimal
# Small Disk

text
install
url --url=http://10.1.0.106/ks/loop/CentOS-7.0-x86_64-Minimal/
lang en_US.UTF-8
keyboard us
network --onboot no --device eth0 --bootproto dhcp --noipv6
rootpw  --iscrypted $6$X/4YYZPN$BSv.khJXms8N8DRssR/VlN5w/m80FFpPup2aX0DWEFfDp734FPtU4kXdcSCoOjPiXLrVxqfKKOWUcvUOFiqlQ1
timezone America/New_York
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --enabled=NetworkManager,sshd
eula --agreed
reboot


# Disk
bootloader --location=mbr
zerombr
clearpart --all --drives=sda
part pv.1 --grow --size=1
part /boot --fstype=ext4 --size=1024
volgroup VolGroup  pv.1
logvol / --fstype=ext4 --name=lv_root --vgname=VolGroup --size=1024 --grow
logvol swap --name=lv_swap --vgname=VolGroup --size=1024

# Package Selection
%packages --nobase --ignoremissing
@core
perl
%end
