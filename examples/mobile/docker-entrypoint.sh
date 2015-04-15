#!/bin/bash -e

# Configure wrapper.conf
echo 'wrapper.java.additional.2=-Djava.net.preferIPv4Stack=true' >> ${SONARQUBE_HOME}/conf/wrapper.conf
