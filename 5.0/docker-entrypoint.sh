#!/bin/bash -e

# Variables
DB_NAME=${DB_NAME:-sonar}
DB_USER=${DB_USER:-sonar}
DB_PASS=${DB_PASS:-sonar}

POSTGRESQL_HOST=${POSTGRESQL_HOST:-$DB_PORT_5432_TCP_ADDR}
POSTGRESQL_PORT=${POSTGRESQL_PORT:-$DB_PORT_5432_TCP_PORT}
MYSQL_HOST=${MYSQL_HOST:-$DB_PORT_3306_TCP_ADDR}
MYSQL_PORT=${MYSQL_PORT:-$DB_PORT_3306_TCP_PORT}

# Setting the access to the Database
sed -i 's|^#sonar.jdbc.username=sonar|sonar.jdbc.username='"${DB_USER}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties
sed -i 's|^#sonar.jdbc.password=sonar|sonar.jdbc.password='"${DB_PASS}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties

if test "${POSTGRESQL_HOST}" != ''; then
  # PostgreSQL
  sed -i 's|^#sonar.jdbc.url=jdbc:postgresql://localhost/sonar|sonar.jdbc.url=jdbc:postgresql://'"${POSTGRESQL_HOST}"':'"${POSTGRESQL_PORT}"'/'"${DB_NAME}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties
elif test "${MYSQL_HOST}" != ''; then
  # MySQL
  sed -i 's|^#sonar.jdbc.url=jdbc:mysql://localhost:3306/sonar|sonar.jdbc.url=jdbc:mysql://'"${MYSQL_HOST}"':'"${MYSQL_PORT}"'/'"${DB_NAME}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties
else
  # H2
  sed -i 's|^#sonar.jdbc.url=jdbc:h2:tcp://localhost:9092/sonar|sonar.jdbc.url=jdbc:h2:tcp://localhost:9092/'"${DB_NAME}"'|g' ${SONARQUBE_HOME}/conf/sonar.properties
fi

# Tuning the Web Server
sed -i 's|^#sonar.web.javaOpts=|sonar.web.javaOpts=-server |g' ${SONARQUBE_HOME}/conf/sonar.properties

# Disbale update center
sed -i 's|^#sonar.updatecenter.activate=true|sonar.updatecenter.activate=false|g' ${SONARQUBE_HOME}/conf/sonar.properties

if [ -d /docker-entrypoint-init.d ]; then
  for f in /docker-entrypoint-init.d/*.sh; do
    [ -f "$f" ] && . "$f"
  done
fi

function start() {
  set +e
  ${SONARQUBE_HOME}/bin/linux-x86-64/sonar.sh start
  tail -f ${SONARQUBE_HOME}/logs/sonar.log
}

function help() {
  echo "Available options:"
  echo " start          - Starts the server (default)"
  echo " help           - Displays the help"
  echo " [command]      - Execute the specified linux command eg. bash."
}

case "$1" in
  start)
    start
    ;;
  help)
    help
    ;;
  *)
    if [ -x $1 ]; then
      $1
    else
      prog=$(which $1)
      if [ -n "${prog}" ] ; then
        shift 1
        $prog $@
      else
        help
      fi
    fi
    ;;
esac

exit 0