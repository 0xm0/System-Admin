#!/bin/bash
# System Administrator script
# cPanel / WHM Cloud Linux Plugin Auto Installer
# Created by David Brockway
# https://github.com/DavidBrockway

# Installing CageFS
yum install cagefs -y
/usr/sbin/cagefsctl --init

# Enabling CageFS For All Users
/usr/sbin/cagefsctl --enable-all

# Installing Python and Ruby Selector
yum install lvemanager alt-python-virtualenv ea-apache24-mod-alt-passenger -y
yum groupinstall alt-python -y
yum groupinstall alt-ruby -y

# Installing Node.js Selector

yum groupinstall alt-nodejs6 alt-nodejs8 alt-nodejs9 -y
yum install lvemanager lve-utils ea-apache24-mod-alt-passenger -y

# Installing PHP Selector

yum groupinstall alt-php -y

# CageFS Force Update
cagefsctl --force-update


fi
