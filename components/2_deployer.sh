#!/bin/bash

# source util functions
source ./utils.sh

# set project path and params
assignProjectPath $1
assignL1Network $2
assignL1ContractsOwnerKey $3
assignL2ContractsOwnerAddress $4

# build and run deployer
IMAGE="bitnetwork/deployer"
function buildDeployer(){
  cp -r docker/deployer/Dockerfile $PROJECT/Dockerfile
  cd $PROJECT
  docker build -t $IMAGE . --platform linux/amd64
  # arm架构
  #clean the Dockerfile
  rm -rf Dockerfile
  cd -
}

function startDeployer(){
  docker run --net bridge -itd -p 8080:8081 -e "CONTRACTS_RPC_URL=$L1_RPC_URL"  -e "CONTRACTS_DEPLOYER_KEY=$L1_CONTRACTS_OWNER_KEY" -e "CONTRACTS_TARGET_NETWORK=$CONTRACTS_TARGET_NETWORK" --entrypoint "/opt/optimism/packages/contracts/deployer.sh" --restart unless-stopped --name=deployer $IMAGE --platform linux/amd64
}

# rebuild / restart the image
if [[ ! -z "$BUILD" ]] ;then
  buildDeployer
  checkDockerImage $IMAGE
  checkDockerContainer $IMAGE

  if [[ -n "$RESTART" ]]; then
    rmContainer $IMAGE
  fi

  case $CONTRACTS_TARGET_NETWORK in
    "local")
      twistLocalNetworkScript $PROJECT
      assignL1RpcUrl "http://172.17.0.1:9545"
      assignL1Network "local"
      startDeployer
      untwistLocalNetworkScript $PROJECT
      ;;
    "georli")
      echo "georli not support yet"
#      twistLocalNetworkScript $PROJECT
#      assignL1RpcUrl "..."
#      assignL1Network "georli"
#      startDeployer
#      untwistLocalNetworkScript $PROJECT
      ;;
  esac
else
  ID=`docker ps -a | grep $IMAGE | awk '{print $1}'`
  if [[ ! "$ID" ]] ; then
    echo "$IMAGE re deploy"
    startDeployer $IMAGE
  else
    echo "$IMAGE re start"
    restartContainer $IMAGE
  fi
fi
