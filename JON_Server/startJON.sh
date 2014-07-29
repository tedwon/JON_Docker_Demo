#!/bin/bash

export PGDATA="/var/lib/pgsql/9.3/data"
export PGINST="/usr/pgsql-9.3"
export RHQ_SERVER_HOME="/opt/jon/jon-server-3.2.0.GA"

#$PGINST/bin/pg_ctl start -w -D $PGDATA

service postgresql-9.3 start

if [ ! -f $RHQ_SERVER_HOME/is.installed ]; then
  $RHQ_SERVER_HOME/bin/rhqctl install
  touch $RHQ_SERVER_HOME/is.installed
else
  $RHQ_SERVER_HOME/bin/rhqctl stop
fi


$RHQ_SERVER_HOME/bin/rhqctl start --storage
$RHQ_SERVER_HOME/bin/rhqctl start --agent
$RHQ_SERVER_HOME/bin/rhqctl console --server
