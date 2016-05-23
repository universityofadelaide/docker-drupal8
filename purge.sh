#!/bin/bash

. stop.sh

docker-compose rm -f

docker network rm ${PROJECT}_default
