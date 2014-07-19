Red Hat JBoss Operations Network - Docker Demo
==============================================

This repository is about running, demoing or playing around with
[Red Hat JBoss Operation Network](http://www.redhat.com/products/jbossenterprisemiddleware/operations-network/) - Red Hats single point of control to deploy, manage, and monitor your JBoss Enterprise Middleware, applications, and services.

This image consists - at the moment - of three images

* JBoss Operations Network Server

* Centos base image with JBoss Operations Network Agent

* JBoss EAP Managed ( with JON Agent )

Details on how to build and start the images, please refer to the Readme's of the associated subdirectories.

Template Directory
------------------

I have added a special directory `managedTemplate` which does not represent a running image, but the basis for 
you to create your own images.
