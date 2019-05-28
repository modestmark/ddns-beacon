#!/bin/bash

echo "What domain registrar are you using?
      1) DigitalOcean"
read -p 'Enter a number: ' registrarChoice

if [ $registrarChoice == 1 ]
  then
    registrar="DigitalOcean"
fi

echo "You'll need an API key from your registrar.  On DigitalOcean, 
      this is under Manage > API > Tokens/Keys > Personal access tokens."

read -p 'Enter your API key: ' apiKey

curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer 42787eb24ac2f8b7813408d936424f1ced0b7c93a4162fa1d433f20e1fea5372" "https://api.digitalocean.com/v2/domains/oldmanreffi.com/records" | jq .

read -p 'Enter your DNS record ID: ' recordID

echo "Is this correct? y/n"
echo "Registrar: " $registrar
echo "API key: " $apiKey
echo "DNS record ID: " $recordID
read confirm

if [ $confirm != "y" ]
  then
    exit 1
fi


#rename old config file to .old if there is one, then write data to new config file
if [ -a ./ddns-beacon-config ]
  then
    mv ./ddns-beacon-config ./ddns-beacon-config.old
fi

echo $registrar >> ./ddns-beacon-config
echo $apiKey >> ./ddns-beacon-config
echo $recordID >> ./ddns-beacon-config
exit 1
