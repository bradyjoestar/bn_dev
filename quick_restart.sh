#!/bin/bash

OPTIMISM="./optimism"

read -p "Enter full path to optimism: " OPTIMISM

if [[ ! -z "$1" ]] ;then
  OPTIMISM=$1
fi
echo "current optimism path is: $OPTIMISM"

read -p "Enter your L1 contract deployer private-key: " CONTRACTS_DEPLOYER_KEY

if [[ ! -z "$1" ]] ;then
  echo "L1 deployer private-key is null, must exist"
  exit
fi


