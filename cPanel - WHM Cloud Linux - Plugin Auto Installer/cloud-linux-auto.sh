#!/bin/bash
# System Administrator script
# cPanel / WHM Cloud Linux Plugin Auto Installer + CSF Firewall
# Created by David Brockway
# https://github.com/DavidBrockway

# Check server for update, update server if required
yum -y update

# Installs Perl
yum -y install perl
 
# dir change to Home
cd /home

# cPanel Installer Curl Download
curl -o latest -L https://securedownloads.cpanel.net/latest

# cPanel run insatller 
sh latest

# Check server for update, update server if required
yum -y update

# Cloud Linux 7.x Installtion
wget https://repo.cloudlinux.com/cloudlinux/sources/cln/cldeploy
sh cldeploy -i

# Check server for update, update server if required
yum -y update


# LV Installation 
yum install lve-stats -y
yum install lvemanager -y

# Installing CageFS
yum install cagefs -y
/usr/sbin/cagefsctl --init

# Enabling CageFS For All Users
/usr/sbin/cagefsctl --enable-all

# Installing Python and Ruby Selector
yum install lvemanager alt-python-virtualenv ea-apache24-mod-alt-passenger -y
yum groupinstall alt-python -y
yum groupinstall alt-ruby -y
yum install alt-python27-devel -y

# Installing Node.js Selector

yum groupinstall alt-nodejs6 alt-nodejs8 alt-nodejs9 -y 
yum install lvemanager lve-utils ea-apache24-mod-alt-passenger -y

# CloudLinux 7 restart! 
systemctl restart cpanel.service

# CloudLinux 7 restart! 

# Installing pache mod_lsapi PRO
yum install liblsapi liblsapi-devel -y
yum install ea-apache24-mod_lsapi -y
/usr/bin/switch_mod_lsapi --setup
service httpd restart

# Installing PHP Slector 
yum groupinstall alt-php -y

# CageFS Force Update
cagefsctl --force-update
yum update cagefs lvemanager

# Install CSF firewall 
cd /usr/src/
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh

# Replcaes CSF config 

cd /etc/csf/
rm -rf csf.conf
wget https://raw.githubusercontent.com/DavidBrockway/System-Admin/master/cPanel%20-%20WHM/ConfigServer%20Security%20%26%20Firewall%20(csf)/csf.conf

# Start CSF & LFD
systemctl start csf
systemctl start lfd

systemctl enable csf
systemctl enable lfd

# Reboot Server 
reboot

fi
