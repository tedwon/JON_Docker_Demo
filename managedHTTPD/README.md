Red Hat JBoss Operations Network - Template
==============================================

This directory contains two files, which you can/should use if
you want to create your own JON-managed images.

Dockerfile
----------

You can do whatever you please with this file, but you should leave the following line

```
CMD $HOME/tmp/masterControlScript.sh
```

appStarterScript
---------------

This script will be called from `masterControlScript.sh` after the JON-Agent has been 
started.

You can do in this script whatever you have to do to start your application, but please be aware that it should
not run in deamon mode as a termination of this script also terminates the container.