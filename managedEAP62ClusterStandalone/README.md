Red Hat JBoss Operations Network - EAP Managed	
==============================================

Building the Docker image
-------------------------

This image is a reconfiguration of the psteiner/managed_eap62 image, hence no additional software is required. To build, simply run

```
docker build --rm -t wrichter/managed_eap62cluster_standalone .
```

Starting the Docker image
-------------------------

To start the image, please us the following command
```
docker run --link jon:jon -h standalone1 --name standalone1 -d wrichter/managed_eap62cluster_standalone
```

This will do the following things:

 * start the image

 * start a fresh version of the JON agent

 * link this image to the already running Red Hat JBoss Operations Network container

 * start Red Hat JBoss EAP as standalone HA server via `appStarterScript.sh`

 * EAP will register with a previously started wrichter/managed_httpd container as HTTP endpoint

Feel free to change any of the parameter to your liking, but please only if you know what
you are doing.

You can start multiple instances of this image to demonstrate clustering, but change the name to standalone2, standalone3, etc...

How the image works
-------------------
 
The `Dockerfile` is designed in a way that at every new start of a container, the JON Agent is started.
This brings you a fresh environment at every new start.

If you want it any other way, please feel free to create a pull-request.
