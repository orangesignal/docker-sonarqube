#!/bin/bash -e

if [ "$1" = 'sonar' ]; then
  if [ -z "$(ls -A "${SONARQUBE_HOME}/logs")" ]; then
    # Variables
    SONAR_JDBC_URL=${SONAR_JDBC_URL:-jdbc:h2:tcp://localhost:9092/sonar}
    SONAR_JDBC_USERNAME=${SONAR_JDBC_USERNAME:-sonar}
    SONAR_JDBC_PASSWORD=${SONAR_JDBC_PASSWORD:-sonar}

    # Setting the access to the Database
    sed -i 's|^sonar.jdbc.username=sonar|sonar.jdbc.username:'"${SONAR_JDBC_USERNAME}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties
    sed -i 's|^sonar.jdbc.password=sonar|sonar.jdbc.password:'"${SONAR_JDBC_PASSWORD}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties
    sed -i 's|^sonar.jdbc.url=jdbc:h2:tcp://localhost:9092/sonar|sonar.jdbc.url='"${SONAR_JDBC_URL}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties

    if [ -d /docker-entrypoint-init.d ]; then
      for f in /docker-entrypoint-init.d/*.sh; do
        [ -f "$f" ] && . "$f"
      done
    fi
  fi

  set +e
  ${SONARQUBE_HOME}/bin/linux-x86-64/sonar.sh start
  tail -f ${SONARQUBE_HOME}/logs/sonar.log
else
  exec "$@"
fi