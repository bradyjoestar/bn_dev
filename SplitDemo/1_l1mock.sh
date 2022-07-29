#!/bin/bash


mkdir docker

# build l1-mock-geth'
function buildL1(){
  cp -r optimism/ops/docker/hardhat  docker/
  cd docker/hardhat
  docker build -t davionlabs/hardhat .
  cd ../../
}


function startHardhatL1() {
  docker run --net bridge -itd -p 9545:8545 --name=l1_geth ethereumoptimism/hardhat
}


buildL1
startHardhatL1
