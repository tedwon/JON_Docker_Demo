#!/bin/bash


$HOME/eap/jboss-eap-6.2/bin/domain.sh --domain-config domain.xml --host-config=host-slave.xml -b 0.0.0.0 -bmanagement 0.0.0.0 -P file:///home/jbosseap/tmp/domain.properties

