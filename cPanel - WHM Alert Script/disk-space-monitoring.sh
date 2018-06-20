#!/bin/bash
# System Administrator script
# cPanel / WHM Disk space Monitor
# Created by David Brockway
# https://github.com/DavidBrockway

ALERT_DEST=name@domainexample.com
MAX_UTIL=80

CHECK_CMD=`df -Ph|awk '{print $5,":",$6,":",$4}'|tr -d '% '|grep -v Use`
MAIL_CMD=/bin/mail

FLAG=/tmp/mnx.disk.usage.flag

for i in ${CHECK_CMD}
do
cur_usage=`echo $i|cut -d: -f1`
file_syst=`echo $i|cut -d: -f2`
cur_avail=`echo $i|cut -d: -f3`
echo ${cur_usage}, ${file_syst}, ${cur_avail}

if [ ${cur_usage} -gt ${MAX_UTIL} ]
then
       echo "${cur_usage} gt than ${MAX_UTIL}"
       if [ ! -e ${FLAG} ]
       then
         echo "Flag doesn't exist, creating."
         touch ${FLAG}
         ERROR=1
       else
         NUMS=1
       fi
       tmp_ERR="Filesystem: ${file_syst} is ${cur_usage}% full.\n"
fi

ERR="${ERR}${tmp_ERR}"
tmp_ERR=""
done

echo ${ERR}
echo "ERROR: ${ERROR}, NUMS: ${NUMS}"

if [ -e ${FLAG} ] && [ -z ${NUMS} ] && [ -z ${ERROR} ]
then
 echo "Flag exists, although no utilization problems.  Removing flag"
 rm ${FLAG}
fi

if [ -e ${FLAG} ] && [ ! -z ${ERROR} ]
then
echo "Sending email.. "
echo -e "${ERR}"|${MAIL_CMD} -s "`hostname`: Filesystem filling" ${ALERT_DEST}
fi
