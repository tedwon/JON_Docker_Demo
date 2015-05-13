#!/bin/bash

# extract agent
AGENT_JAR=rhq-enterprise-agent-4.12.0.JON330GA.jar
PATH_TO_AGENT=jon-server-3.3.0.GA/modules/org/rhq/server-startup/main/deployments/rhq.ear/rhq-downloads/rhq-agent/$AGENT_JAR
tar xf ../JON_Server/jon-server-3.3.0.GA.zip $PATH_TO_AGENT
mv $PATH_TO_AGENT $AGENT_JAR
rm -rf jon-server-3.3.0.GA

# copy update
cp ../JON_Server/jon-server-3.3-update-02.zip .