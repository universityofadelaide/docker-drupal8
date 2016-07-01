#!/bin/bash

. common.sh

docker-compose up -d

# Complete notice.
notice "\nInstalling is complete!"
notice "To view the containers created run:"
notice "$ docker ps"
notice "To create a utility container to build Drupal 8 run:"
notice "$ ./dsh.sh "
notice "\nHelp us build a better development environment! Lodge any bugs, features etc. : https://github.com/universityofadelaide/docker_drupal8 "
