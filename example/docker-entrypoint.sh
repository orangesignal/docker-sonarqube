#!/bin/bash -e

# Tuning the Web Server
sed -i 's|^#sonar.web.javaOpts=|sonar.web.javaOpts=-server |g' ${SONARQUBE_HOME}/conf/sonar.properties

# Disbale update center
sed -i 's|^#sonar.updatecenter.activate=true|sonar.updatecenter.activate=false|g' ${SONARQUBE_HOME}/conf/sonar.properties
