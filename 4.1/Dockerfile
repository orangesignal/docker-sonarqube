#
# SonarQube Dockerfile
#

# Pull base image.
FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Install Java.
RUN \
  echo 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' | tee /etc/apt/sources.list.d/webupd8team-java.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
  apt-get update && \
  echo 'oracle-java7-installer shared/accepted-oracle-license-v1-1 select true' | debconf-set-selections && \
  apt-get -y --no-install-recommends install oracle-java7-installer && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /var/cache/oracle-jdk7-installer \
    ${JAVA_HOME}/src.zip \
    ${JAVA_HOME}/*-src.zip \
    ${JAVA_HOME}/db \
    ${JAVA_HOME}/lib/missioncontrol \
    ${JAVA_HOME}/lib/visualvm \
    ${JAVA_HOME}/lib/*javafx* \
    ${JAVA_HOME}/jre/lib/plugin.jar \
    ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
    ${JAVA_HOME}/jre/bin/javaws \
    ${JAVA_HOME}/jre/lib/javaws.jar \
    ${JAVA_HOME}/jre/lib/desktop \
    ${JAVA_HOME}/jre/plugin \
    ${JAVA_HOME}/jre/lib/deploy* \
    ${JAVA_HOME}/jre/lib/*javafx* \
    ${JAVA_HOME}/jre/lib/*jfx* \
    ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
    ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
    ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
    ${JAVA_HOME}/jre/lib/amd64/libglass.so \
    ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
    ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
    ${JAVA_HOME}/jre/lib/amd64/libjfx*.so

# Install SonarQube
ENV SONARQUBE_VERSION 4.1.2
ENV SONARQUBE_HOME /opt/sonarqube
WORKDIR /opt
RUN \
  apt-get update && apt-get -y --no-install-recommends install unzip && \
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* && \
  wget http://dist.sonar.codehaus.org/sonarqube-${SONARQUBE_VERSION}.zip && \
  unzip sonarqube-${SONARQUBE_VERSION}.zip && \
  rm -f sonarqube-${SONARQUBE_VERSION}.zip && \
  ln -s sonarqube-${SONARQUBE_VERSION} ${SONARQUBE_HOME}

# Upgrade Sonar plugins
# - http://docs.sonarqube.org/display/SONAR/Plugin+version+matrix
RUN mkdir -p ${SONARQUBE_HOME}/extensions/downloads
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

EXPOSE 9000
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sonar"]