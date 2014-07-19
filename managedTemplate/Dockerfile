# DOCKER-VERSION 0.3.4
FROM    psteiner/jonagent

MAINTAINER psteiner <psteiner@redhat.com>

##############################################
# Update the system and Install necessary RPMs
#############################################
RUN yum -y update; yum -y install unzip; yum clean all

#############################################
# Set all required environment variables
#############################################

#############################################
# Your code here! 
#############################################

CMD $HOME/tmp/masterControlScript.sh 

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/<xyz> .
# run command -> docker run --link jon:jon  -d psteiner/<xyz>
