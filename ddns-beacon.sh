#!/bin/bash

#if config file doesn't yet exist, call config script to create it
if [ ! -f ./ddns-beacon-config ]
  then
    echo "No config file found!  Executing config script"
    bash ./ddns-beacon-config.sh
fi

#check that config exists now; if not, exit

if [ ! -f ./ddns-beacon-config ]
  then
    echo "Config file didn't get created, aborting!"
    exit 1
fi

#if ip log file doesn't exist, create it
if [ ! -f ./oldddnsip ]
  then
    echo '0.0.0.0' > oldddnsip
fi

#read in variables from config file
configData=`cat ./ddns-beacon-config`
registrar=`echo $configData | awk '{print $1}'`
domainName=`echo $configData | awk '{print $2}'`
apiKey=`echo $configData | awk '{print $3}'`
recordID=`echo $configData | awk '{print $4}'`

#find, format, and store wan ip
#ddnsip=`host myip.opendns.com resolver1.opendns.com | grep "has address" | awk '{print $4}'`
ddnsip=8.8.8.8

#construct URL strings for DNS record update via API
if [ $registrar="DigitalOcean" ]
  then
    recordURL="\"https://api.digitalocean.com/v2/domains/"
    recordURL=${recordURL}$domainName
    recordURL=${recordURL}/records/
    recordURL=${recordURL}$recordID\"
    echo $recordURL

    payload="'{\"data\":\""
    payload=${payload}$ddnsip
    payload=${payload}\"\}\'
fi

#compare to ip from last run, set update bit if change has occurred
oldddnsip=`cat ./oldddnsip`
if [ $oldddnsip != $ddnsip ]
  then
    update=1
    echo $ddnsip > ./oldddnsip
  else
    update=0
fi

#test stuff, delete when done
echo $ddnsip
echo curl -X PUT -H \"Content-Type: application/json\" -H \"Authorization: Bearer $apiKey\" -d $payload "$recordURL"

#if update bit is set, update DNS record
if [ $update == 1 ]
  then
    curl -X PUT -H "Content-Type: application/json" -H "Authorization: Bearer $apiKey" -d $payload $recordURL
fi
