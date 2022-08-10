#!/bin/bash
# source util functions
source ./utils.sh

# set project path
assignProjectPath $1

mkdir docker

# build and run l1-mock-geth
IMAGE="davionlabs/hardhat"
function buildL1(){
  cp -r $OPTIMISM/ops/docker/hardhat  docker/
  cd docker/hardhat
  docker build -t $IMAGE .
  cd -
}

function startHardhatL1() {
  docker run --net bridge -itd -p 9545:8545 --name=l1_geth $IMAGE
}

buildL1
checkDockerImage $IMAGE
startHardhatL1
