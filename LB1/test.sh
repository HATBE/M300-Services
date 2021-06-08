echo $(jq 'del(.nodes.node1)' nodes.json) > nodes.json
#echo $(jq ".nodes.node1" nodes.json)