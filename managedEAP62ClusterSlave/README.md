Red Hat JBoss Operations Network - EAP Managed	
==============================================

Building the Docker image
-------------------------

This image is a reconfiguration of the psteiner/managed_eap62 image, hence no additional software is required. To build, simply run

```
docker build --rm -t wrichter/managed_eap62cluster_slave .
```

Starting the Docker image
-------------------------

To start the image, please wait for the Domain Master to be up and use the following command
```
docker run --link jon:jon --link master:master -h slave1 --name slave1 -d wrichter/managed_eap62cluster_slave
```

This will do the following things:

 * start the image

 * start a fresh version of the JON agent

 * link this image to the already running Red Hat JBoss Operations Network container

 * start Red Hat JBoss EAP as Domain Slave and register with the Domain Master via `appStarterScript.sh`

 * EAP will register with a previously started wrichter/managed_httpd container to provide an HTTP endpoint

Feel free to change any of the parameter to your liking, but please only if you know what
you are doing.

You can start multiple instances of this image to demonstrate clustering, but change the name to slave2, slave3, etc...

If you want to view the app server output in the shell, you can alternatively run

```
docker run --link jon:jon --link master:master -h slave1 --name slave1 -t -i wrichter/managed_eap62cluster_standalone /bin/bash
$HOME/tmp/masterControlScript.sh
```

How the image works
-------------------
 
The `Dockerfile` is designed in a way that at every new start of a container, the JON Agent is started.
This brings you a fresh environment at every new start.

If you want it any other way, please feel free to create a pull-request.
