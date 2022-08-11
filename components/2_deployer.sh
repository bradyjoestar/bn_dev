#!/bin/bash

# source util functions
source ./utils.sh

# set project path and params
assignProjectPath $1
assignL1ContractsOwnerKey $2
assignL1RpcUrl $3

# build and run deployer
IMAGE="bitnetwork/deployer"
function buildDeployer(){
  cp -r docker/deployer/Dockerfile $OPTIMISM/Dockerfile
  cd $OPTIMISM
  docker build -t $IMAGE . --platform linux/amd64
  # arm架构
  #clean the Dockerfile
  rm -rf Dockerfile
  cd -
}

function startDeployer(){
  docker run --net bridge -itd -p 8080:8081 -e "CONTRACTS_RPC_URL=$L1_RPC_URL"  -e "CONTRACTS_DEPLOYER_KEY=$L1_CONTRACTS_OWNER_KEY" -e "CONTRACTS_TARGET_NETWORK=local" --entrypoint "/opt/optimism/packages/contracts/deployer.sh"  --name=deployer $IMAGE --platform linux/amd64
}

# check is rebuild the image
if [[ ! -z "$BUILD" ]] ;then
  buildDeployer
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE
  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi
  startDeployer
else
  restartContainer $IMAGE
fi
