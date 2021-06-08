#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

# TODO;
   # Init (check if no vagrant isset, else destroy and build new (ask user)
   # Start (all/node)
   # Stop (all node)
   # Desttoy (all/node) if node, destroy db!)
   # Deploy (take all nodes, cut node save number create new nodes in empty spaces (1,2,4,5) -> 3, create functiln, make deploy loop for more ghan one deploy at a time, print all data, login, port, usw to file .csv

if [[ $UID -eq 0 ]]
then
    echo "You cant be root to use this Script!"
    exit 1
fi

# Check Node
checkNodeStatus () {
    # check if node is running
    ARG="$1"
    TEST=$(vagrant status ${ARG})
    REGEX1="${ARG} *running"
    REGEX2="${ARG} *poweroff"
    REGEX3="${ARG} *not *created"

    if [[ $TEST =~ $REGEX3 ]]
    then 
        return 3 # not created
    elif [[ $TEST =~ $REGEX2 ]]
    then 
        return 2 # poweroff
    elif [[ $TEST =~ $REGEX1 ]]
    then 
        return 1 # running
    else
        return 0 # down
    fi
}

# Stop Node
stopNode () {

    NODE=$1
    checkNodeStatus $NODE
    if [[ $? -ne 0 && $? -ne 2 && $? -ne 3 ]]
    then
        echo "stopping node \"${NODE}\""
        vagrant halt $NODE
        exit 0 # success
    else 
        echo "Node ${NODE} is already stopped or not created."
        exit 1
    fi

}

# Start Node
startNode () {
    
    NODE=$1
    checkNodeStatus $NODE
    if [[ $? -eq 1 ]]
    then
        echo "Node ${NODE} is already running."
        exit 1 # no success
    else 
        echo "starting node \"${NODE}\""
        vagrant up $NODE
        exit 0 # success
    fi
}

# Deploy Nextcloud
deployNode () {

    # TODO: connect to db server, create db
        # add node to json
        # vagrant reload
    NODE=$1
    echo $NODE
    checkNodeStatus $NODE
    if [[ $? -ne 1 || $? -ne 2 || $? -ne 3 ]]
    then
        echo $?
        echo "Deploying"
    else
        echo "${NODE} is already deployed"
    fi
}

# Remove Nextcloud node
destroyNode () {
    # TODO: halt node
        # destroy node
        # remove node from json
        # vagrant reload
        # connect to db server, delete db
    NODE=$1
    checkNodeStatus $NODE
    if [[ $? -eq 3 ]] # CHANGE!!
    then
        echo "destoy..."
    else
        echo "${NODE} is already deployed"
    fi
}

####################################################################
# SCRIPT
####################################################################
USAGE="Usage: ${0} <install:deploy:destroy:start:stop>"

# Check if user is really in the Vagrant Folder
FOLDER=$(pwd)
read -p "Are you in the correct folder? \"${FOLDER}\". y or n: " ACCEPT
ACCEPT=$(echo $ACCEPT | tr a-z A-Z) # make $accept to uppercase
if [[ "${ACCEPT}" != "Y" ]]
then
    echo "you have exited the script"
    exit 1
fi

# Check if arguments are set
if [[ ${#} -eq 0 ]]
then
    echo "Not enough arguments. ${USAGE}"
    exit 1
fi

# Install -----------------------------------------------------------------------------
if [[ "${1}" ==  "init" ]]
then
    # Only start init things
    echo "Create Init vagrant..."
    vagrant up dbs
# Start -----------------------------------------------------------------------------
elif [[ "${1}" ==  "start" ]]
then
# make option to start only the nodes or the nodes with db
    if [[ $# -ge 2 ]]
    then
        startNode $2
    else
        echo "Not enough arguments. ${USAGE}"
    fi
    
    # TODO: check if node exists (json file)
        # vagrant up node
# Stop -----------------------------------------------------------------------------
elif [[ "${1}" ==  "stop" ]]
then
    # make option to stop only the nodes or the nodes with db
    if [[ $# -ge 2 ]]
    then
        stopNode $2
    else
        echo "Not enough arguments. ${USAGE}"
    fi
    # TODO: check if node exists (json file)
        # vagrant halt node
# Deploy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "deploy" ]]
then
        # TODO:
            # create db
            # insert new vm into json
            # vagrant reload
            # vagrant up boxname (node "number")
    deployNode $2
# Destroy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "destroy" ]]
then
    if [[ $# -ge 2 ]]
    then
        # if a node is specified, destroy this node
        destroyNode $2
    else
        # if no args, destoy all
        vagrant destroy -f
    fi
# Else -----------------------------------------------------------------------------
else
    echo "Wrong arguments. ${USAGE}"
    exit 1
fi
exit 0