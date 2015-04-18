#
# SonarQube LTS example Dockerfile
#

# Pull base image.
FROM orangesignal/sonarqube:4.5.4

WORKDIR ${SONARQUBE_HOME}/extensions/plugins

# Add SonarQube plugins
# - http://docs.sonarqube.org/display/SONAR/Plugin+version+matrix
# - http://www.sonarsource.com/category/plugins-news/
RUN \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/android/sonar-android-plugin/1.0/sonar-android-plugin-1.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-checkstyle-plugin/2.3/sonar-checkstyle-plugin-2.3.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/java/sonar-pmd-plugin/2.3/sonar-pmd-plugin-2.3.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/l10n/sonar-l10n-ja-plugin/1.3/sonar-l10n-ja-plugin-1.3.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/l10n/sonar-l10n-ko-plugin/1.0/sonar-l10n-ko-plugin-1.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/l10n/sonar-l10n-zh-plugin/1.8/sonar-l10n-zh-plugin-1.8.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-branding-plugin/1.0/sonar-branding-plugin-1.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-build-breaker-plugin/1.1/sonar-build-breaker-plugin-1.1.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-groovy-plugin/1.1/sonar-groovy-plugin-1.1.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-pdfreport-plugin/1.4/sonar-pdfreport-plugin-1.4.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-scm-stats-plugin/0.3.1/sonar-scm-stats-plugin-0.3.1.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-sonargraph-plugin/3.4.1/sonar-sonargraph-plugin-3.4.1.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-timeline-plugin/1.4/sonar-timeline-plugin-1.4.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-useless-code-tracker-plugin/1.0/sonar-useless-code-tracker-plugin-1.0.jar && \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-widget-lab-plugin/1.6/sonar-widget-lab-plugin-1.6.jar

# Add Deprecated Plugins
# - http://docs.sonarqube.org/display/SONAR/Deprecated+Plugins
# - http://docs.sonarqube.org/display/SONAR/Release+4.5+Upgrade+Notes
RUN \
  wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-taglist-plugin/1.0/sonar-taglist-plugin-1.0.jar

# Build and install third party plugin in Sonar
RUN wget http://repository-rfelden.forge.cloudbees.com/release/org/codehaus/sonar-plugin/objectivec/sonar-objective-c-plugin/0.4.0/sonar-objective-c-plugin-0.4.0.jar

COPY docker-entrypoint.sh /docker-entrypoint-init.d/docker-entrypoint.sh