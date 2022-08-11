#!/bin/bash

# default params
OPTIMISM="./optimism"
L1_RPC_URL="http://172.17.0.1:9545"
L2_RPC_URL="http://172.17.0.1:8545"
# address = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
L1_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
L2_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

function assignProjectPath() {
  OPTIMISM=$1
  echo "current optimism path is: $OPTIMISM"
}

function assignL1ContractsOwnerKey() {
  if [[ ! -z "$1" ]] ;then
    L1_CONTRACTS_OWNER_KEY=$1
  fi
  echo "current l1 contract owner is: $L1_CONTRACTS_OWNER_KEY"
}

function assignL1RpcUrl() {
  if [[ ! -z "$1" ]] ;then
    L1_RPC_URL=$1
  fi
  echo "current l1 contract rpc url is: $L1_RPC_URL"
}

function assignL2ContractsOwnerKey() {
  if [[ ! -z "$1" ]] ;then
    L2_CONTRACTS_OWNER_KEY=$1
  fi
  echo "current l2 contract owner is: $L2_CONTRACTS_OWNER_KEY"
}

function assignL2RpcUrl() {
  if [[ ! -z "$1" ]] ;then
    L2_RPC_URL=$1
  fi
  echo "current l2 contract rpc url is: $L2_RPC_URL"
}

function checkDockerImage() {
  NUM=`docker images | grep $1 | wc -l`
  if [[ ! $NUM -eq 1 ]] ; then
    echo "image [$1] not build yet"
    exit
  fi
}

function checkDockerContainer() {
  RESTART=false
  NUM=`docker ps -a | grep $1 | wc -l`
  if [[ $NUM -eq "1" ]] ; then
    RESTART=true
    echo "container [$1] is exist, it will be removed"
  fi
}

function restartContainer() {
  ID=`docker ps -a | grep $1 | awk '{print $1}'`
  docker restart $ID
}

function stopContainer() {
  ID=`docker ps -a | grep $1 | awk '{print $1}'`
  docker stop $ID
}

function rmContainer() {
  ID=`docker ps -a | grep $1 | awk '{print $1}'`
  if [ $ID ]; then
    docker rm -f $ID
  fi
}

ovmSequencerAddress="0x70997970c51812dc3a010c7d01b50e0d17dc79c8"     # sequencer  address
ovmProposerAddress="0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc"      # proposer   address
ovmBlockSignerAddress="0x00000398232E2064F896018496b4b44b3D62751F"   # signer     address
ovmFeeWalletAddress="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"     # owner      address
ovmAddressManagerOwner="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
ovmGasPriceOracleOwner="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"

function twistLocalNetworkScript() {
  OPTIMISM=$1
  cp "$OPTIMISM/packages/contracts/deploy-config/local.ts" "$OPTIMISM/packages/contracts/deploy-config/local.ts.bak"
  fh="packages/contracts/deploy-config/local.ts"
  sed -i -e "/ovmSequencerAddress: \'(.*)\'/s//$ovmSequencerAddress" $fh
  sed -n 's/ovmProposerAddress: '{[.*]'/$ovmSequencerAddress' $fh
  sed -n 's/ovmBlockSignerAddress: '[.*]'/$ovmSequencerAddress' $fh
  sed -n 's/ovmFeeWalletAddress: '[.*]'/$ovmSequencerAddress' $fh
  sed -n 's/ovmAddressManagerOwner: '[.*]'/$ovmSequencerAddress' $fh
  sed -n 's/ovmGasPriceOracleOwner: '[.*]'/$ovmSequencerAddress' $fh
}

function untwistLocalNetworkScript() {
  OPTIMISM=$1
  cp "$OPTIMISM/packages/contracts/deploy-config/local.ts.bak" "$OPTIMISM/packages/contracts/deploy-config/local.ts"
}
