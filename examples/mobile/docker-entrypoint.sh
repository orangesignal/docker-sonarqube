#!/bin/bash -e

# Configure wrapper.conf
echo 'wrapper.java.additional.2=-Djava.net.preferIPv4Stack=true' >> ${SONARQUBE_HOME}/conf/wrapper.conf

# Tuning the Web Server
sed -i 's|^#sonar.web.javaOpts=|sonar.web.javaOpts=-server |g' ${SONARQUBE_HOME}/conf/sonar.properties

# Disbale update center
sed -i 's|^#sonar.updatecenter.activate=true|sonar.updatecenter.activate=false|g' ${SONARQUBE_HOME}/conf/sonar.properties
