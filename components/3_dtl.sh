#!/bin/bash

OPTIMISM="./optimism"

if [[ ! -z "$1" ]] ;then
  OPTIMISM=$1
fi
echo "current optimism path is: $OPTIMISM"

function buildDtl(){
  cp -r docker/dtl/Dockerfile $OPTIMISM/Dockerfile
  cd $OPTIMISM
  docker build -t davionlabs/data-transport-layer . --platform linux/amd64

  #clean the Dockerfile
  rm -rf Dockerfile
  cd -
}


function replaceEnv(){
  cp -r envs/dtl.template.env envs/dtl.env
}

function startDtl(){
  docker run --net bridge -itd -p 7878:7878 --env-file envs/dtl.env --restart unless-stopped --entrypoint "/opt/optimism/packages/data-transport-layer/dtl.sh" --name=dtl davionlabs/data-transport-layer --platform linux/amd64
}

buildDtl
replaceEnv
#startDtl
