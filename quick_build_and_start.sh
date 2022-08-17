#!/bin/bash

source ./components/utils.sh

#### default params
#PROJECT="./optimism"
#L1_RPC_URL="http://172.17.0.1:9545"
#L2_RPC_URL="http://172.17.0.1:8545"
#L1_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
#L2_CONTRACTS_OWNER_KEY="ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"

read -p "Enter full path to project: " PROJECT
read -p "Enter L1 Network(local / georli): " L1_NETWORK
read -p "Enter your contract deployer owner private-key: " CONTRACTS_OWNER_KEY
read -p "Enter your contract deployer owner address: " CONTRACTS_OWNER_ADDRESS

# autosave and reuse the input template

# do the real deploy
cd ./components || return

echo "\nbuild l1..."
BUILD=true ./1_l1mock.sh $PROJECT
echo "\nbuild deployer..."
BUILD=true ./2_deployer.sh $PROJECT $L1_NETWORK $CONTRACTS_OWNER_KEY $CONTRACTS_OWNER_ADDRESS
echo "\nbuild dtl..."
BUILD=true ./3_dtl.sh $PROJECT
echo "\nbuild l2geth..."
BUILD=true ./4_l2geth.sh $PROJECT
echo "\nbuild gasoracle..."
BUILD=true ./5_gasoracle.sh $PROJECT
echo "\nbuild batch_submitter..."
BUILD=true ./6_batch_submitter.sh $PROJECT

cd - || return
