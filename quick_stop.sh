#!/bin/bash

docker rm -f $(docker ps -a | grep "bitnetwork" | awk '{print $1}')
