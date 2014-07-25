# DOCKER-VERSION 0.3.4
FROM    psteiner/managed_eap62

MAINTAINER wrichter <wrichter@redhat.com>

USER root
ADD . $HOME/tmp/
RUN chown -R jbosseap:jbosseap $HOME; chmod +x $HOME/tmp/*.sh
USER jbosseap

RUN cp $HOME/tmp/mgmt-users.properties $HOME/eap/jboss-eap-6.2/standalone/configuration && \
    cp $HOME/tmp/mgmt-users.properties $HOME/eap/jboss-eap-6.2/domain/configuration

CMD $HOME/tmp/masterControlScript.sh 

EXPOSE 8080 9990 16163 9999

# Build command -> docker build --rm -t wrichter/managed_eap62cluster_master .
# run command -> docker run --link jon:jon -h master --name master -d wrichter/managed_eap62cluster_master
