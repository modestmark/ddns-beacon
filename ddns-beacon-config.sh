#!/bin/bash

echo "What domain registrar are you using?
      1) DigitalOcean"
read -p 'Enter a number: ' registrarChoice

if [ $registrarChoice == 1 ]
  then
    registrar="DigitalOcean"
fi

read -p 'What is the name of your domain? ' domainName

echo "You'll need an API key from your registrar.  On DigitalOcean, 
      this is under Manage > API > Tokens/Keys > Personal access tokens."

read -p 'Enter your API key: ' apiKey

if [ $registrar="DigitalOcean" ]
  then
    recordURL=https://api.digitalocean.com/v2/domains/
    recordURL=${recordURL}$domainName
    recordURL=${recordURL}/records
fi

curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $apiKey" $recordURL
printf "\n\n"
echo "Find the DNS record you're using in that mess; you need its corresponding \"id\" field."

read -p 'Enter your DNS A record ID: ' recordID

printf "\n\n"
echo "Registrar: " $registrar
echo "Domain name: " $domainName
echo "API key: " $apiKey
echo "DNS record ID: " $recordID
read -p 'Is this correct? y/n: ' confirm

if [ $confirm != "y" ]
  then
    echo "Fine then!  Aborting!"
    exit 1
fi


#rename old config file to .old if there is one, then write data to new config file
if [ -a ./ddns-beacon-config ]
  then
    mv ./ddns-beacon-config ./ddns-beacon-config.old
fi

echo $registrar >> ./ddns-beacon-config
echo $domainName >> ./ddns-beacon-config
echo $apiKey >> ./ddns-beacon-config
echo $recordID >> ./ddns-beacon-config
exit 1
