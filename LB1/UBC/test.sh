#echo $(jq 'del(.nodes.node1)' nodes.json) | jq #> nodes.json
#echo $(jq ".nodes.node1" nodes.json)


#RES=$(jq -r ".nodes[]" nodes.json)

#echo $RES[1]

#NODES=($(jq '.nodes | keys | .[]' nodes.json))
#NODES=("${NODES[@]:1}")

#echo ${NODES[@]}

#NODES=($(jq '.nodes | keys | .[]' nodes.json))
#NODES=("${NODES[@]:1}")
#NODEARRAY=()
#for string in ${NODES[@]}
#do
#    OUTPUT=${string:5:1}
#    NODEARRAY+=("${OUTPUT}")
#done
#echo "${NODEARRAY[0]}"

NODES=($(jq '.nodes | keys | .[]' nodes.json))
NODES=("${NODES[@]:1}")
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

echo $NUMBER