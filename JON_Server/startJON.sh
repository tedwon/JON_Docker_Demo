#!/bin/bash

export PGDATA="/var/lib/pgsql/9.3/data"
export PGINST="/usr/pgsql-9.3"
export RHQ_SERVER_HOME="/opt/jon/jon-server-3.2.0.GA"

#$PGINST/bin/pg_ctl start -w -D $PGDATA

service postgresql-9.3 start

$RHQ_SERVER_HOME/bin/rhqctl install --start

# endless loop, as I do not have any other idea how to prevent the docker
# container to stop
for (( ; ; ))
do
   sleep 10000
done

