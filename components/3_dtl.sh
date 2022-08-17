#!/bin/bash

# source util functions
source ./utils.sh

# set project path
assignProjectPath $1

# build and run data-transporter-layer
IMAGE="bitnetwork/data-transport-layer"
function buildDtl(){
  cp -r docker/dtl/Dockerfile $PROJECT/Dockerfile
  cd $PROJECT
  docker build -t $IMAGE . --platform linux/amd64

  #clean the Dockerfile
  rm -rf Dockerfile
  cd -
}

function replaceEnv(){
  cp -r envs/dtl.template.env envs/dtl.env
}

function startDtl(){
  docker run --net bridge -itd -p 7878:7878 --env-file envs/dtl.env --restart unless-stopped --entrypoint "/opt/optimism/packages/data-transport-layer/dtl.sh" --name=dtl $IMAGE --platform linux/amd64
}

# rebuild / restart the image
if [[ ! -z "$BUILD" ]] ;then
  buildDtl
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE
  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi
  replaceEnv
  startDtl
else
  ID=`docker ps -a | grep $IMAGE | awk '{print $1}'`
  if [[ ! "$ID" ]] ; then
    echo "$IMAGE re deploy"
    startDtl $IMAGE
  else
    echo "$IMAGE re start"
    restartContainer $IMAGE
  fi
fi

# with check
