# DOCKER-VERSION 0.3.4
FROM    centos:centos6

MAINTAINER psteiner <psteiner@redhat.com>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV RHQ_JAVA_HOME /usr/lib/jvm/jre
ENV PGDATA /var/lib/pgsql/9.3/data
ENV PGINST /usr/pgsql-9.3
ENV HOME /home/postgres

# Update the system
RUN yum -y update;yum clean all

############################################################################
# Install PostgreSQL 9.3
#
# Code taken from: https://github.com/DataVirtualizationByExample/DVWorkshop
###########################################################################
RUN yum -y install http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-redhat93-9.3-1.noarch.rpm
RUN yum -y install postgresql93-server postgresql93-contrib sudo unzip java-1.7.0-openjdk java-1.7.0-openjdk-devel; yum clean all
RUN service postgresql-9.3 initdb

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


############################################
# Copy artifacts needed for the Heise_Demo
############################################
RUN mkdir $HOME; mkdir $HOME/tmp 
ADD . $HOME/tmp
RUN echo "export RHQ_JAVA_HOME=\"/usr/lib/jvm/jre\" " >> /etc/profile

############################################
# Copy artifacts needed for the Heise_Demo
############################################
RUN unzip $HOME/tmp/*.zip -d /opt/jon;
RUN cp $HOME/tmp/rhq-server.properties /opt/jon/jon-server-3.2.0.GA/bin/rhq-server.properties; mv $HOME/tmp/pgpass $HOME/.pgpass; chmod 0600 $HOME/.pgpass; mv $HOME/tmp/startJON.sh $HOME; chmod +x $HOME/startJON.sh;
RUN chown -R postgres:postgres $HOME

#############################################
# Create database for BPM-Suite BAM usage
#############################################
USER postgres

RUN $PGINST/bin/pg_ctl start -w -D $PGDATA && \ 
    $PGINST/bin/psql --command "ALTER USER postgres PASSWORD 'change12_me';" && \
    $PGINST/bin/psql --command "CREATE USER rhqadmin PASSWORD 'rhqadmin';" && \
    $PGINST/bin/psql --command "CREATE DATABASE rhq OWNER rhqadmin;" 


USER root
RUN cp $HOME/tmp/pg_hba.conf /var/lib/pgsql/9.3/data/pg_hba.conf

#############################################
# Cleanup
#############################################
RUN rm -rf $HOME/tmp

#############################################
# Trigger installation of JON
#############################################
# RUN service postgresql-9.3 start; /opt/jon/jon-server-3.2.0.GA/bin/rhqctl install --start  

EXPOSE 7080

CMD $HOME/startJON.sh

# Build command -> docker build --rm -t psteiner/jon .
# run command -> docker run  -p 7080:7080 -h jon --name jon -d psteiner/jon
