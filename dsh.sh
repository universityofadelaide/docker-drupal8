#!/bin/bash

. common.sh

if [ ! -z "${SSH_AUTH_SOCK}" ]; then
    SOCK=$(dirname ${SSH_AUTH_SOCK})
    set +e
    docker run -it -w /code -h utility --name ${PROJECT}_utility \
           -v ${SOCK}:${SOCK} -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
           -v ${DIR}:/code \
           -v ${DIR}/.composer:/root/.composer \
           --net=${PROJECT}_default \
           uofa/docker_drupal_utility /bin/bash
    set -e

    docker rm ${PROJECT}_utility
fi
