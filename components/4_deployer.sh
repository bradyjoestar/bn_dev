#!/bin/bash

OPTIMISM="./optimism"

if [[ ! -z "$1" ]] ;then
  OPTIMISM=$1
fi
echo "current optimism path is: $OPTIMISM"

if [[ ! -z "$2" ]] ;then
  CONTRACTS_DEPLOYER_KEY=$2
fi
echo "current l1 contract owner is: $CONTRACTS_DEPLOYER_KEY"

function buildDeployer(){
  cp -r docker/deployer/Dockerfile $OPTIMISM/Dockerfile
  cd $OPTIMISM
  docker build -t davionlabs/deployer .

  #clean the Dockerfile
  rm -rf Dockerfile
  cd -
}


function startDeployer(){
  docker run --net bridge -itd   -p 8080:8081 -e "CONTRACTS_RPC_URL=http://172.17.0.1:9545"  -e "CONTRACTS_DEPLOYER_KEY=$CONTRACTS_DEPLOYER_KEY" -e "CONTRACTS_TARGET_NETWORK=local" --entrypoint "/opt/optimism/packages/contracts/deployer.sh"  --name=deployer davionlabs/deployer
}

buildDeployer
startDeployer
