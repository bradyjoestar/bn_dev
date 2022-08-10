#!/bin/bash

# source util functions
source ./utils.sh

# set project path and params
assignProjectPath $1

# build and run batch-submitter
IMAGE="davionlabs/batch-submitter-service"
function buildBatchSubmitter(){
  cd $OPTIMISM
  docker build -f batch-submitter/Dockerfile -t $IMAGE .
  cd -
}

function replaceEnv(){
  cp -r envs/batch-submitter.template.env envs/batch-submitter.env
}

function startBatchSubmitter(){
  docker run --net bridge -itd --env-file envs/batch-submitter.env --restart unless-stopped --entrypoint "/usr/local/bin/batch-submitter.sh" --name=batch-submitter $IMAGE
}

buildBatchSubmitter
checkDockerImage $IMAGE
replaceEnv
startBatchSubmitter
