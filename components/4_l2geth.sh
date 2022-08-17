#!/bin/bash

# source util functions
source ./utils.sh

# set project path
assignProjectPath $1

# build and run l2-geth
IMAGE="bitnetwork/l2geth"
function  buildL2Geth() {
  cd $PROJECT
  docker build -f l2geth/Dockerfile -t $IMAGE .
  cd -
}

function replaceEnv(){
  cp -r envs/geth.template.env envs/geth.env
}

function startL2(){
  docker run --net bridge -itd -p 8545:8545 -p 8546:8546 --env-file envs/geth.env --restart unless-stopped --entrypoint "/usr/local/bin/geth.sh" --name=l2_geth $IMAGE
}

# rebuild / restart the image
if [[ ! -z "$BUILD" ]] ;then
  buildL2Geth
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE
  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi
  replaceEnv
  startL2
else
  ID=`docker ps -a | grep $IMAGE | awk '{print $1}'`
  if [[ ! "$ID" ]] ; then
    echo "$IMAGE re deploy"
    startL2 $IMAGE
  else
    echo "$IMAGE re start"
    restartContainer $IMAGE
  fi
fi
