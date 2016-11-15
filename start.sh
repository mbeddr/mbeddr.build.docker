#!/bin/bash
if [[ $AGENT_NAME ]]; then
    echo "Setting name to '$AGENT_NAME'"
    sed -i -e "s/name=.*$/name=$AGENT_NAME/" /buildAgent/conf/buildAgent.properties
fi

export CONFIG_FILE=/buildAgent/conf/buildAgent.properties
export PID_FILE=/run/tc-agent.pid
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export DISPLAY=:0.0

XVFB=/usr/bin/Xvfb
XVFBARGS="$DISPLAY -ac -screen 0 1024x768x16 +extension RANDR"
PIDFILE=/var/xvfb_${DISPLAY:1}.pid
/sbin/start-stop-daemon --start --quiet --pidfile $PIDFILE --make-pidfile --background --exec $XVFB -- $XVFBARGS
/buildAgent/bin/agent.sh run
