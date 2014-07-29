#!/bin/bash

set -e
NAME=$(basename $0)

function cleanup { 
   echo Cleaning up, before starting new images
   ./cleanup.sh
}

function stopall {
  docker ps --no-trunc | grep -v "IMAGE" | awk '{print $1}'| xargs -r docker stop
}

function startingServer {
  echo Starting JON server
  docker run -p 7080:7080 -h jon --name jon -d psteiner/jon > /dev/null
}

function startingAgent {
  echo Starting environment with JON agent only
  docker run -p 49160:8080 -p 49170:9990 --link jon:jon -d psteiner/jonagent > /dev/null
}

function startingManagedEAP {
   i=1
   while [ $i -le 1 ]
   do
     servername='eapStandalone'$i
     echo Starting managedEAP with servername $servername
     docker run -p 8888:8080 --link jon:jon -h $servername  -d psteiner/managed_eap
     let i=$i+1
   done
}

function startingHTTP {
	echo "Starting HTTP Server"
	docker run -h http --name http --link jon:jon -p 80:80 -p 6666:6666 -d wrichter/managed_httpd > /dev/null
}


function startingDomainServer {
	echo "Starting domain controller"
	docker run --link jon:jon -h master --name master -d wrichter/managed_eap62cluster_master > /dev/null
}


function startingDomainSlave {
	echo "Starting domain host"	
	docker run --link jon:jon -h slave --name slave --link master:master -d wrichter/managed_eap62cluster_slave > /dev/null
}

function enterJON {
        docker run -i -t -v /tmp/docker:/tmp/host --name enter-jon --volumes-from jon centos:centos6 /bin/bash
}

case "$1" in
cleanup)
	echo "Removing stopped images"
	docker ps -a --no-trunc | grep -v "IMAGE" | awk '{print $1}'| xargs -r docker rm
	echo "Removing '<none>' images"
	docker images --no-trunc| grep none | awk '{print $3}'| xargs -r docker rmi
	;;
start_JON)
	startingServer
	;;
start_domain)
	case "$2" in
	all)
		startingHTTP
		startingDomainServer
		startingDomainSlave
		;;
	http)
		startingHTTP
		;;
	controller)
		startingDomainServer
		;;
	host)
		startingDomainSlave
		;;
	*)
		echo "usage: ${NAME} start_domain (all|http|controller|host)"
		exit 1
		;;
	esac
	;;
start_standalone)
	case "$2" in
	all)
		echo "Starting all"
		startingServer
		startingAgent
		startingManagedEAP
		;;
	server)
		echo "Starting JON Server"
		startingServer
		;;
	agent)
		echo "Starting image with JON agent only"
		startingAgent
		;;
	eapStandalone)
		echo "Starting 3 JBoss EAP Standalone"
		startingManagedEAP
		;;
	*)
		echo "usage: ${NAME} start_standalone (all|server|agent|eapStandalone)"
		exit 1
	esac
	;;
stop)
	case "$2" in
	all)
		echo "Stopping all docker images"
		stopall
		;;
	*)
		echo "usage: ${NAME} stop (all)"
		exit 1
	esac
	;;
enter-jon)
        enterJON
        ;;
*)
	echo "usage ${NAME} (cleanup|start_JON|start_standalone|start_domain|stop|enter-jon)"
	exit 1
	;;
esac

