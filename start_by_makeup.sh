#!/bin/bash

OPTIMISM="./optimism"

read -p "Enter full path to optimism: " OPTIMISM

if [[ ! -z "$1" ]] ;then
  OPTIMISM=$1
fi
echo "current optimism path is: $OPTIMISM"

cd $OPTIMISM/ops
make up
cd -
