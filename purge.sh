#!/bin/bash

. common.sh

DIR=$(pwd)
PROJECT=$(basename ${DIR} | sed 's/[-_]//g')

docker-compose rm -f

docker network rm ${PROJECT}_default
