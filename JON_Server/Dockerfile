# DOCKER-VERSION 0.3.4
FROM    centos:centos6

MAINTAINER psteiner <psteiner@redhat.com>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV RHQ_JAVA_HOME /usr/lib/jvm/jre
ENV PGDATA /var/lib/pgsql/9.3/jon-data
ENV PGINST /usr/pgsql-9.3
ENV HOME /home/postgres
ENV TMP $HOME/tmp
ENV JON_BASE /opt/jon
ENV JON_PLUGINS jon-plugin-pack-eap-3.3.0.GA-update-08
#ENV JON_PLUGINS jon-plugin-pack-amq-3.3.0.GA-update-08
ENV JON_SERVER jon-server-3.3.0.GA

ENV JON_SERVER_UPDATE_ZIP jon-server-3.3-update-11.zip
ENV JON_SERVER_UPDATE_DIR jon-server-3.3.0.GA-update-11
ENV RHQ_SERVER_HOME $JON_BASE/$JON_SERVER

# Update the system
RUN yum -y update;yum clean all

############################################################################
# Install PostgreSQL 9.3
#
# Code taken from: https://github.com/DataVirtualizationByExample/DVWorkshop
###########################################################################
#RUN yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
RUN yum -y install https://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-3.noarch.rpm
RUN yum -y install postgresql93-server postgresql93-contrib sudo unzip java-1.8.0-openjdk java-1.8.0-openjdk-devel; yum clean all
RUN echo PGDATA=$PGDATA > /etc/sysconfig/pgsql/postgresql-9.3
RUN ["service","postgresql-9.3","initdb"]

############################################
# Adjust PostgreSQL configuration so that remote connections to the
# database are possible. 
############################################
RUN echo "listen_addresses='*'" >> $PGDATA/postgresql.conf
RUN echo "" >> $PGDATA/postgresql.conf

############################################
# lets give the user postgres a HOME-DIR
############################################
RUN usermod -d $HOME postgres


# Copy local artifacts to docker tmp-directory
RUN mkdir $HOME; mkdir $TMP
ADD . $TMP

RUN echo "export RHQ_JAVA_HOME=\"/usr/lib/jvm/jre\" " >> /etc/profile

# Unpack JON into RHQ_SERVER_HOME
RUN unzip $TMP/'jon-server*.zip' -d $JON_BASE;
RUN unzip $TMP/$JON_PLUGINS.zip -d $TMP/$JON_PLUGINS/; rm $TMP/$JON_PLUGINS.zip; cp $TMP/$JON_PLUGINS/plugins/*.jar $RHQ_SERVER_HOME/plugins/

# Update JON Server
RUN unzip $HOME/tmp/$JON_SERVER_UPDATE_ZIP -d $HOME/jon;
RUN $HOME/jon/$JON_SERVER_UPDATE_DIR/apply-updates.sh $RHQ_SERVER_HOME

RUN cp $TMP/rhq-server.properties $RHQ_SERVER_HOME/bin/rhq-server.properties; mv $TMP/pgpass $HOME/.pgpass; chmod 0600 $HOME/.pgpass; mv $TMP/startJON.sh $HOME; chmod +x $HOME/startJON.sh;

RUN echo "########## $HOME"
RUN echo $HOME
RUN echo "########## $HOME"

RUN chown -R postgres:postgres $HOME

#############################################
# Create database for JON server
#############################################
USER postgres

RUN $PGINST/bin/pg_ctl start -w -D $PGDATA && \ 
    $PGINST/bin/psql --command "ALTER USER postgres PASSWORD 'change12_me';" && \
    $PGINST/bin/psql --command "CREATE USER rhqadmin PASSWORD 'rhqadmin';" && \
    $PGINST/bin/psql --command "CREATE DATABASE rhq OWNER rhqadmin;" 


USER root
RUN cp $TMP/pg_hba.conf $PGDATA/pg_hba.conf

#############################################
# Cleanup
#############################################
RUN echo "########## $TMP"
RUN echo $TMP
RUN echo "########## $TMP"
RUN rm -rf $TMP



EXPOSE 7080
VOLUME ["/var/lib/pgsql/9.3/jon-data","/opt/jon"]
ENTRYPOINT $HOME/startJON.sh

# Build command -> docker build --rm -t psteiner/jon .
# run command -> docker run  -p 7080:7080 -h jon --name jon -d psteiner/jon
