Red Hat JBoss Operations Network - HTTPD Managed	
==============================================

Building the Docker image
-------------------------

To be able to build the image, you will have to create the [JON-Agent Image](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/JON_Agent) and download [Red Hat JBoss EAP webserver native components](https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=26553&product=appplatform) for your platform.

Please note, that you might have to register with the Red Hat customer portal to access the downloads.

After having downloaded the zip-file, please copy it into the `JON_Docker_Demo/managedHTTPD` directory and run
```
docker build --rm -t wrichter/managed_httpd .
```

Starting the Docker image
-------------------------

To start the image, please us the following command
```
docker run --link jon:jon -h httpd --name httpd -p 80:80 -p 6666:6666 -d wrichter/managed_httpd
```

This will do the following things:

 * start the image

 * start a fresh version of the JON agent

 * link this image to the already running Red Hat JBoss Operations Network container

 * start HTTPD via `appStarterScript.sh`

Feel free to change any of the parameter to your liking, but please only if you know what
you are doing.

HTTPD should be started before EAP cluster members.

How the image works
-------------------
 
The `Dockerfile` is designed in a way that at every new start of a container, the JON Agent is started.
This brings you a fresh environment at every new start.

If you want it any other way, please feel free to create a pull-request.
