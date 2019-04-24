#!/bin/bash

RHQ_SERVER_HOME="/opt/jon/jon-server-3.3.0.GA"

# service postgresql-9.3 start

if [ ! -f $RHQ_SERVER_HOME/is.installed ]; then
  $RHQ_SERVER_HOME/bin/rhqctl install
  touch $RHQ_SERVER_HOME/is.installed
  $RHQ_SERVER_HOME/../jon-server-3.3.0.GA-update-02/apply-updates.sh $RHQ_SERVER_HOME
else
  $RHQ_SERVER_HOME/bin/rhqctl stop
fi


$RHQ_SERVER_HOME/bin/rhqctl start --storage
$RHQ_SERVER_HOME/bin/rhqctl start --agent
$RHQ_SERVER_HOME/bin/rhqctl console --server
