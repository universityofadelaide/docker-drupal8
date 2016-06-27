#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Global defines.
MACHINE='default'

# Figure out some names/directories
DIR=$(pwd)
PROJECT=$(basename ${DIR} | sed 's/[-_]//g')

function setup_docker_machine() {
    # If we're not running on a linux machine, we need to be using docker-machine.
    if [ ${OSTYPE} != 'linux-gnu' ]; then

        set +e
        STATUS=$(docker-machine status ${MACHINE})

        # Check if the docker machine exists already, create one if not.
        if [[ $? == 1 ]]; then
            echo "No ${MACHINE} environment found"
            create_machine
        fi
        set -e

        if [[ ${STATUS} == 'Stopped' ]]; then
            echo "Docker machine not running, starting now"
            docker-machine start ${MACHINE}
        fi

        if [[ ${STATUS} == 'Saved' ]]; then
            echo "Docker machine in saved state, restarting now"
            docker-machine start ${MACHINE}
        fi

        if [[ ${STATUS} == 'Error' ]]; then
            echo "Docker machine vm does not exist but docker-machine still has it registered, remove then create"
            docker-machine rm ${MACHINE}
            create_machine
        fi

        echo "Loading vars for docker machine."
        eval "$(docker-machine env ${MACHINE})"
    fi
}

function create_machine() {
    echo "Creating new machine"
    docker-machine create --driver virtualbox --engine-insecure-registry registry:5000 ${MACHINE}
    #docker-machine ssh ${MACHINE} ln -s $(pwd)/code code
    #docker-machine ssh ${MACHINE} sudo mv code /code
}

# Setup Docker Machine if it's not already running.
# @todo Determine if this is necessary - it's been run after pulling the code repo in start.sh.
setup_docker_machine
