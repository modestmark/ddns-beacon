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

echo "Is this correct? y/n"
echo "Registrar: " $registrar
echo "API key: " $apiKey
read confirm

if [ $confirm != "y" ]
  then
    exit 1
fi

echo $registrar >> ./ddns-beacon-config
echo $apiKey >> ./ddns-beacon-config
exit 1
