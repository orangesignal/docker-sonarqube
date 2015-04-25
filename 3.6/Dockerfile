#
# SonarQube Dockerfile
#

# Pull base image.
FROM debian:wheezy
ENV DEBIAN_FRONTEND noninteractive

# Set the locale
RUN \
  apt-get update && apt-get install -y --no-install-recommends locales &&\
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /var/cache/debconf/*-old &&\
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle

# Install Deps
# - http://www.oracle.com/technetwork/jp/java/javase/jdk-7-readme-429198.html
RUN \
  echo deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main | tee /etc/apt/sources.list.d/webupd8team-java.list &&\
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 &&\
  apt-get update &&\
  echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections &&\
  apt-get -y --no-install-recommends install oracle-java7-installer unzip procps &&\
  rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /var/cache/debconf/*-old /var/cache/oracle-jdk*-installer \
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
    ${JAVA_HOME}/jre/lib/security/javafx.policy \
    ${JAVA_HOME}/jre/lib/amd64/fxavcodecplugin-*.so \
    ${JAVA_HOME}/jre/lib/amd64/fxplugins.so \
    ${JAVA_HOME}/jre/lib/amd64/libglass.so \
    ${JAVA_HOME}/jre/lib/amd64/libgstplugins-lite.so \
    ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
    ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
    ${JAVA_HOME}/jre/lib/amd64/libjfx*.so \
    ${JAVA_HOME}/jre/lib/amd64/libprism-es2.so

# Install SonarQube
ENV SONARQUBE_VERSION 3.6.3
ENV SONARQUBE_HOME /opt/sonar
WORKDIR /opt
RUN \
  wget http://dist.sonar.codehaus.org/sonar-${SONARQUBE_VERSION}.zip &&\
  unzip sonar-${SONARQUBE_VERSION}.zip &&\
  rm    sonar-${SONARQUBE_VERSION}.zip &&\
  ln -s sonar-${SONARQUBE_VERSION} ${SONARQUBE_HOME} &&\
  # Remove unnecessary files
  rm -r \
    ${SONARQUBE_HOME}/bin/linux-ppc-64 \
    ${SONARQUBE_HOME}/bin/linux-x86-32 \
    ${SONARQUBE_HOME}/bin/macosx-* \
    ${SONARQUBE_HOME}/bin/solaris-* \
    ${SONARQUBE_HOME}/bin/windows-*

# Upgrade Sonar plugins
# - http://docs.sonarqube.org/display/SONAR/Plugin+version+matrix
WORKDIR ${SONARQUBE_HOME}/extensions/downloads
RUN \
  rm *.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-checkstyle-plugin/2.0/sonar-checkstyle-plugin-2.0.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-findbugs-plugin/2.0/sonar-findbugs-plugin-2.0.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-jacoco-plugin/2.0/sonar-jacoco-plugin-2.0.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-java-plugin/2.0/sonar-java-plugin-2.0.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-pmd-plugin/2.0/sonar-pmd-plugin-2.0.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-squid-java-plugin/2.0/sonar-squid-java-plugin-2.0.jar &&\
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-surefire-plugin/2.0/sonar-surefire-plugin-2.0.jar

# Add a directory to process setup scripts for the container
RUN mkdir /docker-entrypoint-init.d

COPY docker-entrypoint.sh /

# forward sonar logs to docker log collector
RUN ln -sf /dev/stdout ${SONARQUBE_HOME}/logs/sonar.log

EXPOSE 9000
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["sonar"]