#!/bin/bash

#if ip log file doesn't exist, create it
if [ ! -a ./oldddnsip ]
  then
    echo '0.0.0.0' > oldddnsip
fi

#find, format, and store wan ip
ddnsip=`host myip.opendns.com resolver1.opendns.com | grep "has address" | awk '{print $4}'`

#compare to ip from last run, set update bit if change has occurred
oldddnsip=`cat ./oldddnsip`
if [ $oldddnsip != $ddnsip ]
  then
    update=1
    echo $ddnsip > ./oldddnsip
  else
    update=0
fi
echo $ddnsip



