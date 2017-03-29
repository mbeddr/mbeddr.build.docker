#!/bin/bash
if [[ $AGENT_NAME ]]; then
    echo "Setting name to '$AGENT_NAME'"
    sed -i -e "s/name=.*$/name=$AGENT_NAME/" /buildAgent/conf/buildAgent.properties
fi

export CONFIG_FILE=/buildAgent/conf/buildAgent.properties
export PID_FILE=/run/tc-agent.pid
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export DISPLAY=:0.0

/buildAgent/bin/agent.sh run
