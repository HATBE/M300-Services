#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

if [[ $UID -eq 0 ]]
then
    echo "You cant be root to use this Script!"
    exit 1
fi

whoami

USAGE="Usage: ${0} <install:deploy:destroy]> <name>"

# Check if user is really in the Vagrant Folder
FOLDER=$(pwd)
read -p "Are you in the right folder? \"${FOLDER}\". y or n: " ACCEPT
ACCEPT=$(echo $ACCEPT | tr a-z A-Z) # make $accept to uppercase
if [[ "${ACCEPT}" != "Y" ]]
then
    echo "You quitted the script"
    exit 1
fi

# Check if arguments are set
if [[ ${#} -eq 0 ]]
then
    echo "Not enough arguments. ${USAGE}"
    exit 1
fi

# Install -----------------------------------------------------------------------------
if [[ "${1}" ==  "install" ]]
then
    echo "Installing..."
    vagrant up
# Deploy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "deploy" ]]
then
        # TODO:
            # create db
            # insert new vm into json
            # vagrant reload
            # vagrant up boxname (node "number")
    echo "Deploy new Nextcloud"
# Destroy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "destroy" ]]
then
    vagrant destroy -f
# Else -----------------------------------------------------------------------------
else
    echo "Wrong arguments. ${USAGE}"
    exit 1
fi