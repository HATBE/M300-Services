#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

# Define Variables
JSONFILE="nodes.json"
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 6`
RESET=`tput sgr0`
USAGE="${YELLOW}Usage: ${0} <install:deploy:destroy:start:stop>${RESET}"

# check if user is Root user
if [[ $UID -eq 0 ]]; then
    echo "${RED}You cant't be root, to use this script!${RESET}"
    exit 1
fi

####################################################################
# FUNCTIONS
####################################################################
# Check Node
checkNodeStatus () {
    NODE="$1"
    TEST=$(vagrant status ${NODE}) # get the Vagrant status message
    # Define REGEX vars for the status
    REGEX1="${NODE} *running"
    REGEX2="${NODE} *poweroff"
    REGEX3="${NODE} *not *created"

    # Check the Status of the Nodes
    if [[ $TEST =~ $REGEX3 ]]; then 
        return 3 # not created
    elif [[ $TEST =~ $REGEX2 ]]; then 
        return 2 # poweroff
    elif [[ $TEST =~ $REGEX1 ]]; then 
        return 1 # running
    else
        return 0 # down
    fi
}

# Stop Node
stopNode () {
    NODE=$1
    checkNodeStatus $NODE
    STATUS=$?
    if [[ $STATUS -ne 0 && $STATUS -ne 2 && $STATUS -ne 3 ]]; then # if nod eis running
        echo "${GREEN}stopping node \"${NODE}\"${RESET}"
        vagrant halt $NODE
        exit 0 # success
    else 
        echo "${YELLOW}Node \"${NODE}\" is already stopped or not existent.${RESET}"
        exit 1
    fi

}

# Start Node
startNode () {
    #fin
    NODE=$1
    checkNodeStatus $NODE
    if [[ $? -eq 1 ]]; then
        echo "${YELLOW}Node \"${NODE}\" is already running.${RESET}"
        exit 1 # no success
    else 
        echo "${GREEN}starting node \"${NODE}\"${RESET}"
        vagrant up $NODE
        exit 0 # success
    fi
}

# Deploy Nextcloud
deployNode () {
    AMOUNT=$1
    REGEX='^[1-9]+$'
    if ! [[ $AMOUNT =~ $REGEX ]]; then
        AMOUNT=1
    fi

    COUNTER=0
    while [ $COUNTER -lt $AMOUNT ]; do
        IP_PREFIX="10.9.8." # make IP prefix
        PORT_PREFIX="80" # make Port Prefix

        NODES=($(jq '.nodes | keys | .[]' nodes.json)) # Get all active nodes from json
        NODES=("${NODES[@]:1}") # cut the first (Database Server) from array
        if [[ ${NODES[@]} != "" ]]; then # check if any node is in the json file
            NODEARRAY=()
            for string in ${NODES[@]}
            do
                OUTPUT=${string:5:1} # Cut node away and leve number
                NODEARRAY+=("${OUTPUT}")
            done
            NUM=1
            EXITER=0
            while [[ NUM -eq 1 ]]; do
                if [[ $EXITER -eq 0 ]]; then
                    NUMBER=$(shuf -i 11-99 -n 1) # Generate random number between 11 and 99
                    for NODE in ${NODEARRAY[@]}; do
                        EXITER=0
                        if [[ $NUMBER -eq $NODE ]]; then
                            break
                        else 
                            EXITER=1
                        fi
                    done
                else
                    NUM=0
                fi
            done
        else
            # If no old VM is in the json file, generate a complete new id
            NUMBER=$(shuf -i 11-99 -n 1) # Generate random number between 11 and 99
        fi

        echo "${GREEN}Deploying...${RESET}"
        
        checkNodeStatus dbs
        STATUS=$?
        if [[ STATUS -eq 1 ]]; then

            # Define variables
            IP="${IP_PREFIX}${NUMBER}"
            PORT="${PORT_PREFIX}${NUMBER}"
            NODE="node${NUMBER}"

            mysql -h 10.9.8.101 -u root -pPassword123 -e "CREATE DATABASE ${NODE};"
            echo "${GREEN}Created Database for ${NODE}"
            NEWNODE="{
                \"${NODE}\":{
                    \"description\":\"nextcloud frontend\",
                    \"ip\":\"${IP}\",
                    \"ports\":[
                        {
                            \"guest\":80,
                            \"host\":${PORT}
                        }
                    ],
                    \"memory\":1024,
                    \"cpu\":2,
                    \"script\":\"scripts/ncinstall.sh\",
                    \"args\":\"${NODE}\"
                }
            }"
            echo $(jq --argjson NEWNODE "$NEWNODE" '.nodes += $NEWNODE' nodes.json) > nodes.json # overwriting 

            vagrant reload
            vagrant up $NODE

            echo "${GREEN}Deployed ${NODE}${RESET}"

            echo "NODE: ${NODE}"
            echo "IP: ${IP}"
            echo "PORT: ${PORT}"
        else
            echo "${YELLOW}Warning! DB Server is Offline${RESET}"
            echo "${YELLOW}- Please do ${0} start dbs, or ${0} init.${RESET}"
            echo "${RED}Error! cant create new node"
        fi
        ((COUNTER++))
    done
}

# Remove Nextcloud node
destroyNode () {
    NODE2=$1
    if [[ $NODE != "dbs" ]]; then
        checkNodeStatus $NODE2
        STATUS=$?
        if [[ $STATUS -eq 1 || $STATUS -eq 2 || $STATUS -eq 3 ]]; then # check if node exists (cant destroy not existing node)
            echo "${GREEN}destroying ${NODE2}...${RESET}"
            checkNodeStatus "dbs"
            STATUS=$?
            if [[ STATUS -eq 1 ]]; then
                mysql -h 10.9.8.101 -u root -pPassword123 -e "DROP DATABASE ${NODE2};"
            else
                echo "${YELLOW}DB Server is Offline${RESET}"
                echo "${YELLOW}cant remove ${NODE2}s Databse${RESET}"
            fi

            vagrant destroy $NODE2
                
            FILTER=".nodes.${NODE2}" # adding node as jq filter
            echo $(jq "del($FILTER)" nodes.json) > nodes.json # Remove node from json file

            vagrant reload
            echo "${GREEN}Destroy Successful${RESET}"

        else
            echo "${RED}${NODE2} is not online.${RESET}"
        fi  
    else
        echo "${RED}Can't destroy ${NODE}${RESET}"
    fi
}

####################################################################
# SCRIPT
####################################################################

# Check if user is really in the Vagrant Folder
FOLDER=$(pwd)
read -p "${BLUE}Are you in the correct folder? \"${FOLDER}\". y or n: ${RESET}" ACCEPT # ask user if he is in the right folder
ACCEPT=$(echo $ACCEPT | tr a-z A-Z) # make $accept to uppercase
if [[ "${ACCEPT}" != "Y" ]]; then
    echo "${RED}you have exited the script${RESET}"
    exit 1 # exit script if user don't says "Y"
fi

# Check if arguments are set
if [[ ${#} -eq 0 ]]; then
    echo "${RED}Not enough arguments. ${USAGE}${RESET}"
    exit 1
fi

# Init -----------------------------------------------------------------------------
if [[ "${1}" ==  "init" ]]; then
    # Only start init things
    echo "${GREEN}Create Init vagrant...${RESET}"
    vagrant destroy -f
    checkNodeStatus dbs
    STATUS=$?
    if [[ $STATUS -eq 3 ]]
    then
        vagrant up dbs
    fi
# Start -----------------------------------------------------------------------------
elif [[ "${1}" ==  "start" ]]; then
# make option to start only the nodes or the nodes with db
    if [[ $# -ge 2 ]]; then
        startNode $2
    else
        echo "${RED}Not enough arguments. ${USAGE}${RESET}"
    fi
# Stop -----------------------------------------------------------------------------
elif [[ "${1}" ==  "stop" ]]; then
    # make option to stop only the nodes or the nodes with db
    if [[ $# -ge 2 ]]; then
        stopNode $2
    else
        echo "${RED}Not enough arguments. ${USAGE}${RESET}"
    fi
# Deploy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "deploy" ]]; then
    if [[ $# -ge 2 ]]; then
        deployNode $2
    else 
        deployNode 1
    fi
# Destroy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "destroy" ]]; then
    if [[ $# -ge 2 ]]; then
        # if a node is specified, destroy this node
        destroyNode $2
    else
        # if no args, destoy all
        vagrant destroy -f
        NEWSCRIPT='{
        "nodes":{
                "dbs":{
                    "description":"Database Server",
                    "ip":"10.9.8.101",
                    "ports":[
                        {
                            "guest":3306,
                            "host":3306
                        }
                    ],
                    "memory":3072,
                    "cpu":2,
                    "script":"scripts/dbinstall.sh",
                    "args":""
                }
            }
        }'
        echo $NEWSCRIPT > nodes.json
    fi
# Else -----------------------------------------------------------------------------
else
    echo "${RED}Wrong arguments. ${USAGE}${RESET}"
fi