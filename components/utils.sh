#!/bin/bash

# default params
OPTIMISM="./optimism"
L1_RPC_URL="http://172.17.0.1:9545"
L2_RPC_URL="http://172.17.0.1:8545"
L1_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
L2_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

function assignProjectPath() {
  OPTIMISM=$1
  echo "current optimism path is: $OPTIMISM"
}

function assignL1ContractsOwnerKey() {
  if [[ ! -z "$1" ]] ;then
    L1_CONTRACTS_OWNER_KEY=$1
  else
    echo "l1 contract deployer owner must exist."
    exit 1
  fi
  echo "current l1 contract owner is: $L1_CONTRACTS_OWNER_KEY"
}

function assignL1RpcUrl() {
  L1_RPC_URL=$1
  echo "current l1 contract rpc url is: $L1_RPC_URL"
}

function assignL2ContractsOwnerKey() {
  if [[ ! -z "$1" ]] ;then
    L2_CONTRACTS_OWNER_KEY=$1
  else
    echo "l2 contract deployer owner must exist."
    exit 1
  fi
  echo "current l1 contract owner is: $L2_CONTRACTS_OWNER_KEY"
}

function assignL2RpcUrl() {
  L2_RPC_URL=$1
  echo "current l1 contract rpc url is: $L2_RPC_URL"
}

function checkDockerImage() {
  NUM=`docker images | grep $1 | wc -l`
  if [[ ! $NUM -eq 1 ]] ; then
    echo "image [$1] not build yet"
    exit
  fi
}
