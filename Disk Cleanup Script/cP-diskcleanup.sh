#!/bin/bash
# System Administrator script
# cPanel / WHM Disk Cleanup script
# Created by David Brockway
# 

df -h
yum clean all
rm -f /var/log/*.gz
rm -f /var/log/*.?
rm -f /var/log/archive/*.gz
rm -f /var/log/nginx/*.gz
rm -f /var/log/nginx/*.?
rm -f /usr/local/apache/logs/*.gz
rm -f /usr/local/apache/logs/*.?
rm -f /usr/local/apache/logs/archive/*.gz
rm -f /usr/local/cpanel/logs/*.gz
rm -f /usr/local/cpanel/logs/*.?
rm -f /usr/local/cpanel/logs/archive/*.gz
rm -f /var/log/cloudlinux-collect/*.gz
rm -rf /home/core.*
rm -rf /home/cpeasyapache
rm -rf /home/MySQL-install
rm -fv /home/*/tmp/Cpanel_*
find /home/*/.trash/* -exec rm -rf {} \;
find /home/ -name error_log -type f -print -exec truncate --size 0 "{}" \;
rm -f /home/latest
rm -rf /home/cprubygemsbuild
rm -rf /home/cprubybuild
rm -rf /home/cprestore
rm -rfv /home/cpeasyapache
rm -fv /home/*/tmp/Cpanel_*
rm -rvf /home*/cpanelpkgrestore.TMP*
rm -fv /home*/*/.softaculous/backups/*
rm -rfv /home/*/fantastico_backups
rm -rvf /home/cpmove-*
for user in `/bin/ls -A /var/cpanel/users` ; do rm -fv /home/$user/backup-*$user.tar.gz ; done
rm -fv /var/log/*.gz
rm -fv /var/log/*201*
rm rfv /var/spool/abrt/*
rm -rfv /usr/local/apache.backup*
rm -rfv /usr/local/maldet.bk*
rm -fv /usr/local/apache/logs/*.gz
rm -fv /usr/local/apache/logs/archive/*.gz
rm -fv /usr/local/maldetect/logs/*
for files in `ls`; do rm -f $files; done;

/scripts/restartsrv_mysql

/scripts/restartsrv_apache

df -h
