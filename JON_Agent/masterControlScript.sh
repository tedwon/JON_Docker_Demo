#!/bin/bash

##################################################
# Prepare whatever we need as environment variables
##################################################
export HOME="/home/jbosseap"

##################################################
# First we need to start the JON agent and have
# him configures. As this ends with a command
# prompt, we stop him again
##################################################
$HOME/jon/rhq-agent/bin/rhq-agent.sh << EOF



jon

exit
EOF

##################################################
# Now lets start him for good!
##################################################
$HOME/jon/rhq-agent/bin/rhq-agent-wrapper.sh start


##################################################
# Here follows whatever additional service you
# want to run in this image
##################################################
$HOME/tmp/appStarterScript.sh

