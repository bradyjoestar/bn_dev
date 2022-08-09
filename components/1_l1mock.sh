#!/bin/bash

OPTIMISM="./optimism"

if [[ ! -z "$1" ]] ;then
  OPTIMISM=$1
fi
echo "current optimism path is: $OPTIMISM"

mkdir docker

# build l1-mock-geth'
function buildL1(){
  cp -r $OPTIMISM/ops/docker/hardhat  docker/
  cd docker/hardhat
  docker build -t davionlabs/hardhat .
  cd -
}


function startHardhatL1() {
  docker run --net bridge -itd -p 9545:8545 --name=l1_geth davionlabs/hardhat
}


buildL1
startHardhatL1
