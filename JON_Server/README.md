Red Hat JBoss Operations Network - JON Server
==============================================

Building the Docker image
-------------------------

To be able to build the image, you will have to download the product and the Red Hat JBoss EAP plugin pack.
You will find them at:

* [Red Hat JBoss Operation Network V3.2](http://www.jboss.org/products/operationsnetwork/resources/)

* [Red Hat JBoss Operation Network EAP Plugins](https://access.redhat.com/jbossnetwork/restricted/listSoftware.html?product=jon.eap&downloadType=distributions)

Please note, that you might have to register with the Red Hat customer portal to access the downloads.

After having downloaded the two zip-files, place them into the `JON_Docker_Demo/JON_Server` directory and run
```docker build --rm -t psteiner/jon .```

Starting the Docker image
-------------------------

To start the image, please us the following command
```docker run  -p 7080:7080 -h jon --name jon -d psteiner/jon```

This will do the following things:

 * start the image

 * map port `7080` of the docker image to port `7080` of the docker-host

 * inject the hostname `jon` into the docker image

 * name the running container `jon`

 Feel free to change any of the parameter to your liking, but please only if you know what
 you are doing.

 How the image works
 -------------------
 The `Dockerfile` is build in a way that at every new start of a container, the JON installation is started.
 This brings you a fresh environment at every new start.

 If you want it any other way, please feel free to create a pull-request.