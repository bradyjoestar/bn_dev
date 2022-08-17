#!/bin/bash

PROJECT="./optimism"

read -p "Enter full path to optimism: " PROJECT

if [[ ! -z "$1" ]] ;then
  PROJECT=$1
fi
echo "current optimism path is: $PROJECT"

read -p "Enter your L1 contract deployer private-key: " CONTRACTS_DEPLOYER_KEY

if [[ ! -z "$1" ]] ;then
  echo "L1 deployer private-key is null, must exist"
  exit
fi


