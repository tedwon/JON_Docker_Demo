# DOCKER-VERSION 0.3.4
FROM    centos:centos6

MAINTAINER psteiner <psteiner@redhat.com>

USER root

##############################################
# Update the system and Install necessary RPMs
##############################################
RUN yum -y update; yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel; yum clean all

##############################################
# Set required environment variables
##############################################
ENV HOME /home/jbosseap
ENV JAVA_HOME /usr/lib/jvm/jre
ENV RHQ_JAVA_HOME /usr/lib/jvm/jre
ENV INSTALL_FILE $HOME/tmp/rhq-enterprise-agent-4.9.0.JON320GA.jar

##############################################
# Set root password
##############################################
RUN echo "root:redhat" | /usr/sbin/chpasswd
   
##############################################
# Transfer files from host
##############################################
ADD . $HOME/tmp/


##############################################
# Unzip JON Agent install files
##############################################
RUN java -jar $INSTALL_FILE --install=$HOME/jon; rm $INSTALL_FILE


##################################################
# Now lets create a user give the files to the user
##################################################
RUN useradd -m -d /home/jbosseap -p jbosseap jbosseap 
RUN chown -R jbosseap:jbosseap $HOME; chmod u+x $HOME/tmp/*.sh


##################################################
# The masterControlScript needs to run as root
# if you want to run other services as another user
# you will have to handle that in the appStarterScript.sh
##################################################
CMD $HOME/tmp/masterControlScript.sh

EXPOSE 8080 9990 16163

# Build command -> docker build --rm -t psteiner/jonagent .
# run command -> docker run -p 49160:8080 -p 49170:9990 --link jon:jon -d psteiner/jonagent
