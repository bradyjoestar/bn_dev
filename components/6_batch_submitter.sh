#!/bin/bash

# source util functions
source ./utils.sh

# set project path and params
assignProjectPath $1

# build and run batch-submitter
IMAGE="bitnetwork/batch-submitter-service"
function buildBatchSubmitter(){
  cd $PROJECT
  docker build -f batch-submitter/Dockerfile -t $IMAGE .
  cd -
}

function replaceEnv(){
  cp -r envs/batch-submitter.template.env envs/batch-submitter.env
}

function startBatchSubmitter(){
  docker run --net bridge -itd --env-file envs/batch-submitter.env --restart unless-stopped --entrypoint "/usr/local/bin/batch-submitter.sh" --name=batch-submitter $IMAGE
}

# rebuild / restart the image
if [[ ! -z "$BUILD" ]] ;then
  buildBatchSubmitter
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE
  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi
  replaceEnv
  startBatchSubmitter
else
  ID=`docker ps -a | grep $IMAGE | awk '{print $1}'`
  if [[ ! "$ID" ]] ; then
    echo "$IMAGE re deploy"
    startGasOracle $IMAGE
  else
    echo "$IMAGE re start"
    restartContainer $IMAGE
  fi
fi
