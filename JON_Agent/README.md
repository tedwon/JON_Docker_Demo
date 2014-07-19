Red Hat JBoss Operations Network - JON Agent
==============================================

Building the Docker image
-------------------------

To be able to build the image, you will have to download the product and the Red Hat JBoss EAP plugin pack.
You will find them at:

* [Red Hat JBoss Operation Network V3.2](http://www.jboss.org/products/operationsnetwork/resources/)

Please note, that you might have to register with the Red Hat customer portal to access the downloads.

After having downloaded the zip-file, please unzip it into any temporary directory and copy `/modules/org/rhq/server-startup/main/deployments/rhq.ear/rhq-downloads/rhq-agent/rhq-enterprise-agent-4.9.0.JON320GA.jar` into the `JON_Docker_Demo/JON_Agent` directory and run
```
docker build --rm -t psteiner/jonagent .
```

Starting the Docker image
-------------------------

To start the image, please us the following command
```
docker run -p 49160:8080 -p 49170:9990 --link jon:jon -d psteiner/jonagent
```

This will do the following things:

 * start the image

 * start a fresh version of the JON agent

 * link this image to the already running Red Hat JBoss Operations Network container

 Feel free to change any of the parameter to your liking, but please only if you know what
 you are doing.

 How the image works
 -------------------
 
 The `Dockerfile` is designed in a way that at every new start of a container, the JON Agent is started.
 This brings you a fresh environment at every new start.

 If you want it any other way, please feel free to create a pull-request.

 Linking other applications to start
 -----------------------------------

In this version of the `Dockerfile` the `CMD` argument starts a shell-script called `masterControlScript.sh`. This script starts the fresh version of the JON agent and then calls a script named `appStarterScript.sh`. In this repo the script just runs an endless loop. If you want to run any other app, please feel free to patch `appStarterScript.sh` to you liking, but please be aware that the script should not end, as this will cause the
container to stop.

