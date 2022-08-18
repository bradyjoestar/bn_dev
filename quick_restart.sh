#!/bin/bash

read -p "Enter full path to project: " PROJECT
read -p "Enter L1 Network(local / georli): " L1_NETWORK
read -p "Enter your contract deployer owner private-key: " CONTRACTS_OWNER_KEY
read -p "Enter your contract deployer owner address: " CONTRACTS_OWNER_ADDRESS

echo "\nrestart l1..."
./1_l1mock.sh $PROJECT
echo "\nrestart deployer..."
./2_deployer.sh $PROJECT $L1_NETWORK $CONTRACTS_OWNER_KEY $CONTRACTS_OWNER_ADDRESS
echo "\nrestart dtl..."
./3_dtl.sh $PROJECT
echo "\nrestart l2geth..."
./4_l2geth.sh $PROJECT
echo "\nrestart gasoracle..."
./5_gasoracle.sh $PROJECT
echo "\nrestart batch_submitter..."
./6_batch_submitter.sh $PROJECT
