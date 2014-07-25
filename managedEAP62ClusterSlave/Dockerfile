# DOCKER-VERSION 0.3.4
FROM    psteiner/managed_eap62

MAINTAINER wrichter <wrichter@redhat.com>

USER root
ADD . $HOME/tmp/
RUN chown -R jbosseap:jbosseap $HOME; chmod +x $HOME/tmp/*.sh
USER jbosseap

RUN cp $HOME/tmp/mgmt-users.properties $HOME/eap/jboss-eap-6.2/standalone/configuration && \
    cp $HOME/tmp/mgmt-users.properties $HOME/eap/jboss-eap-6.2/domain/configuration && \
    sed -i "s_<secret *value=\"[A-Za-z0-9 =\"]*/>_<secret value=\"\$\{jboss.domain.login.password\}\" />_" $HOME/eap/jboss-eap-6.2/domain/configuration/host-slave.xml && \
    sed -i "s_<remote _<remote username=\"\$\{jboss.domain.login.user\}\" _" $HOME/eap/jboss-eap-6.2/domain/configuration/host-slave.xml

CMD $HOME/tmp/masterControlScript.sh 

EXPOSE 8080 9990 16163 9999

# Build command -> docker build --rm -t wrichter/managed_eap62cluster_slave .
# run command -> docker run --link jon:jon --link master:master -d wrichter/managed_eap62cluster_slave
