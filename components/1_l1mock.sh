#!/bin/bash
# source util functions
source ./utils.sh

# set project path
assignProjectPath $1

if [[ ! -x "docker" ]] ; then
  mkdir docker
fi

# build and run l1-mock-geth
IMAGE="bitnetwork/hardhat"
function buildL1(){
  cp -r $OPTIMISM/ops/docker/hardhat  docker/
  cd docker/hardhat
  docker build -t $IMAGE .
  cd -
}

function startHardhatL1() {
  docker run --net bridge -itd -p 9545:8545 --restart unless-stopped --name=l1_geth $IMAGE
}

# rebuild / restart the image
if [[ ! -z "$BUILD" ]] ;then
  buildL1
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE
  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi
  startHardhatL1
else
  restartContainer $IMAGE
fi
