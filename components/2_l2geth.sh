#!/bin/bash

# source util functions
source ./utils.sh

# set project path
assignProjectPath $1

# build and run l2-geth
IMAGE="davionlabs/l2geth"
function  buildL2Geth() {
  cd $OPTIMISM
  docker build -f l2geth/Dockerfile -t $IMAGE .
  cd -
}

function replaceEnv(){
  cp -r envs/geth.template.env envs/geth.env
}

function startL2(){
  docker run --net bridge -itd -p 8545:8545 -p 8546:8546 --env-file envs/geth.env --restart unless-stopped --entrypoint "/usr/local/bin/geth.sh" --name=l2_geth $IMAGE
}


buildL2Geth
checkDcckerImage $IMAGE
replaceEnv
startL2
