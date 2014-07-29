# DOCKER-VERSION 0.3.4
FROM    psteiner/jonagent

MAINTAINER wrichter <wrichter@redhat.com>

##############################################
# Update the system and Install necessary RPMs
#############################################
RUN yum -y update; yum -y install unzip httpd; yum clean all

#############################################
# Set all required environment variables
#############################################

#############################################
# Your code here! 
#############################################
RUN mkdir $HOME/eap
   
ADD . $HOME/tmp/
RUN chown -R jbosseap:jbosseap $HOME; chmod +x $HOME/tmp/*.sh

RUN /usr/bin/unzip -q $HOME/tmp/jboss-eap-*.zip -d $HOME/eap && \
#    cp $HOME/eap/jboss-eap-*/modules/system/layers/base/native/etc/httpd/conf/mod_cluster.conf /etc/httpd/conf.d && \
    cp $HOME/tmp/mod_cluster.conf /etc/httpd/conf.d && \
    cp $HOME/eap/jboss-eap-*/modules/system/layers/base/native/lib64/httpd/modules/*.so /etc/httpd/modules && \
    sed -i "s/LoadModule proxy_balancer_module modules\/mod_proxy_balancer.so/#\0/" /etc/httpd/conf/httpd.conf && \
    rm $HOME/tmp/*.zip

#USER jbosseap

CMD $HOME/tmp/masterControlScript.sh 

EXPOSE 80 6666

# Build command -> docker build --rm -t wrichter/managed_httpd .
# run command -> docker run --link jon:jon -h httpd --name httpd -p 80:80 -p 7081:6666 -d wrichter/managed_httpd
