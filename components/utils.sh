#!/bin/bash

# default params
PROJECT="./optimism"
CONTRACTS_TARGET_NETWORK="local"
L1_RPC_URL="http://172.17.0.1:9545"
L2_RPC_URL="http://172.17.0.1:8545"
# address = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
L1_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
L2_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

function assignProjectPath() {
  PROJECT=$1
  echo "current optimism path is: $PROJECT"
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

function assignL1Network() {
  if [[ ! -z "$1" ]] ;then
    CONTRACTS_TARGET_NETWORK=$1
  fi
  echo "current l1 network is: $CONTRACTS_TARGET_NETWORK"
}

function assignL2ContractsOwnerKey() {
  if [[ ! -z "$1" ]] ;then
    L2_CONTRACTS_OWNER_KEY=$1
  fi
  echo "current l2 contract owner is: $L2_CONTRACTS_OWNER_KEY"
}

function assignL2ContractsOwnerAddress() {
  if [[ ! -z "$1" ]] ;then
    bvmFeeWalletAddress=$1
    bvmAddressManagerOwner=$1
    bvmGasPriceOracleOwner=$1
  fi
  echo "current l2 contract owner address is: $1"
}

function assignL2RpcUrl() {
  if [[ ! -z "$1" ]] ;then
    L2_RPC_URL=$1
  fi
  echo "current l2 contract rpc url is: $L2_RPC_URL"
}

function checkDockerImage() {
  NUM=`docker images | grep $1 | wc -l`
  if [[ $NUM -lt 1 ]] ; then
    echo "image [$1] not build yet"
    exit
  fi
}

function checkDockerContainer() {
  RESTART=false
  NUM=`docker ps -a | grep $1 | wc -l`
  if [[ $NUM -eq "1" ]] ; then
    RESTART=true
    echo "container [$1] exists, it will be removed"
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

bvmSequencerAddress="0x70997970c51812dc3a010c7d01b50e0d17dc79c8"     # sequencer  address
bvmProposerAddress="0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc"      # proposer   address
bvmBlockSignerAddress="0x00000398232E2064F896018496b4b44b3D62751F"   # signer     address
bvmFeeWalletAddress="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"     # owner      address
bvmAddressManagerOwner="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"
bvmGasPriceOracleOwner="0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"

function twistLocalNetworkScript() {
  PROJECT=$1
  cp "$PROJECT/packages/contracts/deploy-config/local.ts" "$PROJECT/packages/contracts/deploy-config/local.ts.bak"
  fh="$PROJECT/packages/contracts/deploy-config/local.ts"
  sed -n 9p $fh | sed -r "s/.*bvmSequencerAddress: \'([a-zA-Z0-9]*)\',.*/\1/" | xargs -I '{}' sed -i -e "s/{}/$bvmSequencerAddress/g" $fh
  sed -n 10p $fh | sed -r "s/.*bvmProposerAddress: \'([a-zA-Z0-9]*)\',.*/\1/" | xargs -I '{}' sed -i -e "s/{}/$bvmProposerAddress/g" $fh
  sed -n 11p $fh | sed -r "s/.*bvmBlockSignerAddress: \'([a-zA-Z0-9]*)\',.*/\1/" | xargs -I '{}' sed -i -e "s/{}/$bvmBlockSignerAddress/g" $fh
  sed -n 12p $fh | sed -r "s/.*bvmFeeWalletAddress: \'([a-zA-Z0-9]*)\',.*/\1/" | xargs -I '{}' sed -i -e "s/{}/$bvmFeeWalletAddress/g" $fh
  sed -n 13p $fh | sed -r "s/.*bvmAddressManagerOwner: \'([a-zA-Z0-9]*)\',.*/\1/" | xargs -I '{}' sed -i -e "s/{}/$bvmAddressManagerOwner/g" $fh
  sed -n 14p $fh | sed -r "s/.*bvmGasPriceOracleOwner: \'([a-zA-Z0-9]*)\',.*/\1/" | xargs -I '{}' sed -i -e """s/{}/$bvmGasPriceOracleOwner/g" $fh
}

function untwistLocalNetworkScript() {
  PROJECT=$1
  cp "$PROJECT/packages/contracts/deploy-config/local.ts.bak" "$PROJECT/packages/contracts/deploy-config/local.ts"
  rm "$PROJECT/packages/contracts/deploy-config/local.ts.bak"
  rm "$PROJECT/packages/contracts/deploy-config/local.ts-e"
}

function xsed() {
    system=$(uname)

    if [ "${system}" = "Linux" ]; then
        sed -i "$@"
    else
        sed -i '' "$@"
    fi
}
