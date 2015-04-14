#
# SonarQube Dockerfile
#

# Pull base image.
FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Install Java.
RUN \
  echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  echo 'oracle-java7-installer shared/accepted-oracle-license-v1-1 select true' | debconf-set-selections && \
  apt-get -y --no-install-recommends install oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /var/cache/oracle-jdk7-installer && \
  rm -rf ${JAVA_HOME}/db && \
  rm -f ${JAVA_HOME}/src.zip ${JAVA_HOME}/*-src.zip

# Install SonarQube
ENV SONARQUBE_VERSION 3.7.4
ENV SONARQUBE_HOME /opt/sonar
WORKDIR /opt
RUN \
  apt-get update && apt-get -y --no-install-recommends install unzip && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
  wget http://dist.sonar.codehaus.org/sonar-${SONARQUBE_VERSION}.zip && \
  unzip sonar-${SONARQUBE_VERSION}.zip && \
  rm -f sonar-${SONARQUBE_VERSION}.zip && \
  ln -s /opt/sonar-${SONARQUBE_VERSION} ${SONARQUBE_HOME}

# Upgrade Sonar plugins
# - http://docs.sonarqube.org/display/SONAR/Plugin+version+matrix
WORKDIR ${SONARQUBE_HOME}/extensions/downloads
RUN \
  rm -f *.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-checkstyle-plugin/2.0/sonar-checkstyle-plugin-2.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-findbugs-plugin/2.0/sonar-findbugs-plugin-2.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-jacoco-plugin/2.0/sonar-jacoco-plugin-2.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-java-plugin/2.0/sonar-java-plugin-2.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-pmd-plugin/2.0/sonar-pmd-plugin-2.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-squid-java-plugin/2.0/sonar-squid-java-plugin-2.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-surefire-plugin/2.0/sonar-surefire-plugin-2.0.jar

# Add a directory to process setup scripts for the container
RUN mkdir /docker-entrypoint-init.d

COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]