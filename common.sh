#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

# Global defines.
MACHINE='default'

# Figure out some names/directories
DIR=$(pwd)
PROJECT=$(basename ${DIR} | sed 's/[-_]//g')

# Colours.
ESC_SEQ="\x1b["
COL_RESET=${ESC_SEQ}"39;49;00m"
COL_GREEN=${ESC_SEQ}"32;01m"
COL_YELLOW=${ESC_SEQ}"33;01m"
COL_RED=${ESC_SEQ}"31;01m"

# Define some friendly echos, to give some context.
function notice() {
    echo -e "${COL_GREEN}$1${COL_RESET}"
}

function warning() {
    echo -e "${COL_YELLOW}$1${COL_RESET}"
}

function error() {
    echo -e "${COL_RED}$1${COL_RESET}"
    exit
}

function setup_docker_machine() {
    # If we're not running on a linux machine, we need to be using docker-machine.
    if [ ${OSTYPE} != 'linux-gnu' ]; then

        set +e
        STATUS=$(docker-machine status ${MACHINE})

        # Check if the docker machine exists already, create one if not.
        if [[ $? == 1 ]]; then
            notice "No ${MACHINE} environment found"
            create_machine
        fi
        set -e

        if [[ ${STATUS} == 'Stopped' ]]; then
            notice "Docker machine not running, starting now"
            docker-machine start ${MACHINE}
        fi

        if [[ ${STATUS} == 'Saved' ]]; then
            notice "Docker machine in saved state, restarting now"
            docker-machine start ${MACHINE}
        fi

        if [[ ${STATUS} == 'Error' ]]; then
            notice "Docker machine vm does not exist but docker-machine still has it registered, remove then create"
            docker-machine rm ${MACHINE}
            create_machine
        fi

        notice "Loading vars for docker machine."
        eval "$(docker-machine env ${MACHINE})"
    fi
}

function create_machine() {
    notice "Creating new machine"
    docker-machine create --driver virtualbox --engine-insecure-registry registry:5000 ${MACHINE}
    #docker-machine ssh ${MACHINE} ln -s $(pwd)/code code
    #docker-machine ssh ${MACHINE} sudo mv code /code
}

# Setup Docker Machine if it's not already running.
# @todo Determine if this is necessary - it's been run after pulling the code repo in start.sh.
setup_docker_machine
