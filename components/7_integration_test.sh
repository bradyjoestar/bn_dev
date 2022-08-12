#!/bin/bash

# source util functions
source ./utils.sh

# set project path and params
assignProjectPath $1

# build and run integration-test
IMAGE="bitnetwork/integration-test"
function buildIntegrationTest(){
  cp -r docker/integration-test/Dockerfile $OPTIMISM/Dockerfile
  cd $OPTIMISM
  docker build -t $IMAGE . --platform linux/amd64

  #clean the Dockerfile
  rm -rf Dockerfile
  cd -
}

function replaceEnv(){
  cp -r envs/intergration.template.env envs/intergration.env
}

function startIntegrationtest(){
  docker run --net bridge -itd --env-file envs/intergration.env --restart unless-stopped --name=intergration_test --entrypoint "/opt/optimism/integration-tests/integration-tests.sh" $IMAGE
}

# rebuild / restart the image
if [[ ! -z "$BUILD" ]] ;then
  buildIntegrationTest
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE
  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi
  replaceEnv
  startIntegrationtest
else
  restartContainer $IMAGE
fi
