# DOCKER-VERSION 0.3.4
FROM    psteiner/managed_eap62

MAINTAINER wrichter <wrichter@redhat.com>

USER root
ADD . $HOME/tmp/
RUN chown -R jbosseap:jbosseap $HOME; chmod +x $HOME/tmp/*.sh
USER jbosseap

CMD $HOME/tmp/masterControlScript.sh 

EXPOSE 8080 9990 16163

# Build command -> docker build --rm -t wrichter/managed_eap62cluster_standalone .
# run command -> docker run --link jon:jon -h standalone1 --name standalone1 -d wrichter/managed_eap62cluster_standalone

