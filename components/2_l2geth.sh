#!/bin/bash

OPTIMISM="./optimism"

if [[ ! -z "$1" ]] ;then
  OPTIMISM=$1
fi
echo "current optimism path is: $OPTIMISM"

function  buildL2Geth() {
  # build l2-geth
  cd $OPTIMISM
  docker build -f l2geth/Dockerfile -t davionlabs/l2geth .
  cd -
}

function replaceEnv(){
  cp -r envs/geth.template.env envs/geth.env
}

function startL2(){
  docker run --net bridge -itd -p 8545:8545 -p 8546:8546 --env-file envs/geth.env --restart unless-stopped --entrypoint "/usr/local/bin/geth.sh" --name=l2_geth davionlabs/l2geth
}


buildL2Geth
replaceEnv
startL2
