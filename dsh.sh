#!/bin/bash

. common.sh

SHELL_USER=${1:-${USER}}

if [ ! -z "${SSH_AUTH_SOCK}" ]; then
    SOCK=$(dirname ${SSH_AUTH_SOCK})
    set +e
    docker run -it -w /code -h utility --name ${PROJECT}_utility \
           -e USER=${SHELL_USER} \
           -v ${SOCK}:${SOCK} -e SSH_AUTH_SOCK=${SSH_AUTH_SOCK} \
           -v ${DIR}:/code \
           -v ${DIR}/.composer:/${SHELL_USER}/.composer \
           --net=${PROJECT}_default \
           uofa/utility-php7 /entry.sh
    set -e

    docker rm ${PROJECT}_utility
fi
