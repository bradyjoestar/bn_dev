#!/bin/bash

# source util functions
source ./utils.sh

# set project path and params
assignProjectPath $1

# build and run gas-oracle
IMAGE="davionlabs/gas-oracle"
function buildGasOracle(){
  cd $OPTIMISM
  docker build -f gas-oracle/Dockerfile -t $IMAGE .
  cd -
}

function startGasOracle(){
  docker run --net bridge -itd --restart unless-stopped -e "GAS_PRICE_ORACLE_ETHEREUM_HTTP_URL=$L1_RPC_URL" -e "GAS_PRICE_ORACLE_LAYER_TWO_HTTP_URL=$L2_RPC_URL" -e "GAS_PRICE_ORACLE_PRIVATE_KEY=$L2_CONTRACTS_OWNER_KEY" --name=gas-oracle $IMAGE
}

buildGasOracle
checkDockerImage $IMAGE
startGasOracle
