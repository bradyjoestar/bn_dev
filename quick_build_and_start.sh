#!/bin/bash

source ./components/utils.sh

#### default params
#OPTIMISM="./optimism"
#L1_RPC_URL="http://172.17.0.1:9545"
#L2_RPC_URL="http://172.17.0.1:8545"
#L1_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
#L2_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

read -p "Enter full path to optimism: " OPTIMISM
read -p "Enter L1 RPC URL: " L1_RPC_URL
read -p "Enter L2 RPC URL: " L2_RPC_URL
read -p "Enter your L1 contract deployer owner private-key: " L1_CONTRACTS_OWNER_KEY
read -p "Enter your L2 contract deployer owner private-key: " L2_CONTRACTS_OWNER_KEY

# do the real deploy
cd ./components || return

./1_l1mock.sh $OPTIMISM
./2_l2geth.sh $OPTIMISM
./3_dtl.sh    $OPTIMISM
./4_deployer.sh   $OPTIMISM $L1_CONTRACTS_OWNER_KEY $L1_RPC_URL
./5_gasoracle.sh  $OPTIMISM
./6_batch_submitter.sh $OPTIMISM

cd - || return
