#!/usr/bin/env bash

# This is a wrapper around docker-compose that sets up the environment

echo "externalip="$(dig +short myip.opendns.com @resolver1.opendns.com) >> dash.conf
echo -n "Enter masternode BLS private key: "
read blsprivkey
echo "masternodeblsprivkey="$blsprivkey >> dash.conf

docker-compose -d up
