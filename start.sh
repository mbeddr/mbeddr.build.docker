#!/bin/bash
if [[ $AGENT_NAME ]]; then
    echo "Setting name to '$AGENT_NAME'"
    sed -i -e "s/name=.*$/name=$AGENT_NAME/" /buildAgent/conf/buildAgent.properties
fi

export CONFIG_FILE=/buildAgent/conf/buildAgent.properties
export PID_FILE=/run/tc-agent.pid

/buildAgent/bin/agent.sh run