#!/usr/bin/env bash

# This script sets up the environment

NETWORK=$1
if [[ -z "$NETWORK" || ! -f networks/$NETWORK.env ]]; then
  echo "Please specify network name as first argument"
  exit 1
fi
shift 1

source networks/$NETWORK.env

echo -n "Enter masternode BLS private key: "
read blsprivkey

cat > dash.conf <<EOF
# General
daemon=0
debug=0
printtoconsole=1

# JSONRPC
server=1
datadir=/dash
rpcuser=dashrpc
rpcpassword=$(dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64)
rpcbind=0.0.0.0
rpcallowip=172.16.0.0/12

# Network
testnet=${TESTNET:-0}
listen=1
externalip=$(dig +short myip.opendns.com @resolver1.opendns.com)

# Indices
addressindex=1
spentindex=1
txindex=1
timestampindex=1

# Masternode
masternode=1
masternodeblsprivkey=$blsprivkey
EOF

docker-compose up -d
