#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

# TODO;
   # Deploy (take all nodes, cut node save number create new nodes in empty spaces (1,2,4,5) -> 3, create functiln, make deploy loop for more ghan one deploy at a time, print all data, login, port, usw to file .csv

JSONFILE="nodes.json"

if [[ $UID -eq 0 ]]
then
    echo "You cant't be the root user, to use this script!"
    exit 1
fi

####################################################################
# FUNCTIONS
####################################################################
# Check Node
checkNodeStatus () {
    #fin
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
    #fin
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
    #fin
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
    #exit 1 # remove after finish
    # TODO: connect to db server, create db
        # add node to json
        # vagrant reload

    RANGE=({1..100}) # Create random number between 1 and 100
    IP_PREFIX="10.9.8." # make IP prefix
    PORT_PREFIX="80" # make Port Prefix

    NODES=($(jq '.nodes | keys | .[]' nodes.json)) # Get all active nodes from json
    NODES=("${NODES[@]:1}") # cut the first (Database Server) from array
    NODEARRAY=()
    for string in ${NODES[@]}
    do
        OUTPUT=${string:5:1} # Cut node away and leve number
        NODEARRAY+=("${OUTPUT}")
    done
    NUM=1
    EXITER=0
    while [[ NUM -eq 1 ]]
    do
        if [[ $EXITER -eq 0 ]]
        then
            NUMBER=$(shuf -i 1-100 -n 1)
            for NODE in ${NODEARRAY[@]}
            do
                EXITER=0
                if [[ $NUMBER -eq $NODE ]]
                then
                    break
                else 
                    EXITER=1
                fi
            done
        else
            NUM=0
        fi
    done

    DESCRIPTION="nextcloud server"
    IP="${IP_PREFIX}${NUMBER}"
    PORT="${PORT_PREFIX}${NUMBER}"
    NODE="node${NUMBER}"
    MEMORY="1024"
    CPU="1"
    SCRIPT="scripts/ncinstall.sh"
    ARGS="${NODE}"

    echo "Description: ${DESCRIPTION}"
    echo "IP: ${IP}"
    echo "PORT: ${PORT}"
    echo "NODE: ${NODE}"
    echo "MEMORY: ${MEMORY}"
    echo "CPU: ${CPU}"
    echo "Script: ${SCRIPT} ${ARGS}"

    echo "Deploying..."

    #checkNodeStatus dbs
    #STATUS=$?
    #if [[ STATUS -eq 1 ]]
    #then
    #    mysql -h 10.9.8.101 -u ncuser -pPassword123 -e "CREATE DATABASE ${NODE};"
    #    mysql -h 10.9.8.101 -u ncuser -pPassword123 -e "GRANT ALL PRIVILEGES ON ${NODE}.* to 'ncuser'@'%';"

        # Create vm usw. usw # add node to json

    #    vagrant reload
    #    vagrant up $NODE
    #else
    #    echo "DB Server is Offline"
    #fi

    
    # mysql
    # json add 
}

# Remove Nextcloud node
destroyNode () {
    #fin
    NODE=$1
    if [[ $NODE != "dbs" ]]
    then
        checkNodeStatus $NODE
        STATUS=$?
        if [[ $STATUS -eq 1 || $STATUS -eq 2 || $STATUS -eq 3 ]] # check if node exists (cant destroy not existing node)
        then
            echo "destroying ${NODE}..."
            checkNodeStatus "dbs"
            STATUS=$?
            if [[ STATUS -eq 1 ]]
            then
                mysql -h 10.9.8.101 -u ncuser -pPassword123 -e "DROP DATABASE ${NODE};"

            else
                echo "DB Server is Offline"
                echo "cant remove ${NODE}s Databse"
            fi

            vagrant destroy $NODE
                
            FILTER=".nodes.${NODE}" # adding node as jq filter
            echo $(jq "del($FILTER)" nodes.json) > nodes.json # Remove node from json file

            vagrant reload
            echo "Destroy Successful"

        else
            echo "${NODE} is not online."
        fi  
    else
        echo "cant destroy ${NODE}"
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

# Init -----------------------------------------------------------------------------
if [[ "${1}" ==  "init" ]]
then
    # Only start init things
    echo "Create Init vagrant..."
    vagrant destroy -f
    checkNodeStatus dbs
    STATUS=$?
    if [[ $STATUS -eq 3 ]]
    then
        vagrant up dbs
    fi
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
    jsonHelper ".nodes.dbs1"
    echo "Wrong arguments. ${USAGE}"
    exit 1
fi
exit 0