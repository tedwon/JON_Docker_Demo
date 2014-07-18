# DOCKER-VERSION 0.3.4
FROM    psteiner/eap

MAINTAINER psteiner <psteiner@redhat.com>

USER root

# Update the system and Install necessary RPMs
RUN yum -y update; yum clean all

# Make sure JAVA_HOME is set
ENV RHQ_JAVA_HOME /usr/lib/jvm/jre
   
ADD . $HOME/tmp/
RUN java -jar $HOME/tmp/rhq-enterprise-agent-4.9.0.JON320GA.jar --install=$HOME/jon
RUN chown -R jbosseap:jbosseap $HOME; chmod u+x $HOME/tmp/starterScript.sh

USER jbosseap

CMD $HOME/tmp/starterScript.sh

EXPOSE 8080 9990

# Build command -> docker build --rm -t psteiner/eapmanaged .
# run command -> docker run -p 49160:8080 -p 49170:9990 --link jon:jon -d psteiner/eapmanaged
