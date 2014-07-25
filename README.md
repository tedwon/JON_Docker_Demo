Red Hat JBoss Operations Network - Docker Demo
==============================================

This repository is about running, demoing or playing around with
[Red Hat JBoss Operation Network](http://www.redhat.com/products/jbossenterprisemiddleware/operations-network/) - Red Hats single point of control to deploy, manage, and monitor your JBoss Enterprise Middleware, applications, and services.

This environment consists - at the moment - of the following images

* [JBoss Operations Network Server](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/JON_Server)

* [Centos base image with JBoss Operations Network Agent](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/JON_Agent)

* [JBoss EAP V6.1 in standalone mode ( with JON Agent )](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/managedEAP)

* [JBoss EAP V6.2 in standalone mode ( with JON Agent )](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/managedEAP62)

* [HTTP Server for JBoss EAP in domain mode](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/managedHTTPD)

* [JBoss EAP V6.2 Domain Controller & Master](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/managedEAP62ClusterMaster)

* [JBoss EAP V6.2 Host Controller & Slave](https://github.com/PatrickSteiner/JON_Docker_Demo/tree/master/managedEAP62ClusterSlave)

Details on how to build and start the images, please refer to the Readme's of the associated subdirectories.

Template Directory
------------------

I have added a special directory `managedTemplate` which does not represent a running image, but the basis for 
you to create your own images.

Demo-Script
-----------

To support an easy usage of the demo, I provided a script to manage the demo-environment

* `demo start_JON` to start the Red Hat JBoss Operations Server

* `demo start_standalone` to start Red Hat JBoss EAP in standalone mode

* `demo start_domain` to start Red Hat JBoss EAP in domain mode **still in development**

* `demo stop` to stop the environment

* `demo cleanup` to remove all stopped images and remove these ugly `<none>`images
