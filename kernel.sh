#!/bin/bash
# System Administrator script kernel update for CentOS 7.X & 8.X

# Clean all cached information,
yum clean all

# Check server for update, update server if required
yum -y update

# Displays current kernel
uname -sr

sleep 5

echo "Preparing to update system Kernel, Waiting 5 seconds";

sleep 1

# Kernal Install 
echo "Installing ELRepo repository's";

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm 

echo "Installing the latest mainline stable kernel";

yum --enablerepo=elrepo-kernel install kernel-ml

echo "Confiugre Kernal 0 as default on boot";

sudo grub2-set-default 0

sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "System Rebooting to new kernel, rebuilding the grub config, Waiting 5 seconds";

sleep 5

sudo reboot
