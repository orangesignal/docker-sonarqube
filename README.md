# Supported tags and respective `Dockerfile` links

-	[`latest`, `5.1` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/5.1/Dockerfile)
-	[`5.0.1` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/5.0/Dockerfile)
-	[`4.5.4` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/4.5/Dockerfile)
-	[`4.4.1` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/4.4/Dockerfile)
-	[`4.3.3` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/4.3/Dockerfile)
-	[`4.2` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/4.2/Dockerfile)
-	[`4.1.2` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/4.1/Dockerfile)
-	[`4.0` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/4.0/Dockerfile)
-	[`3.7.4` (*Dockerfile*)](https://github.com/orangesignal/docker-sonarqube/blob/master/3.7/Dockerfile)

For more information about this image and its history, please see the [`orangesignal/docker-sonarqube` GitHub repo](https://github.com/orangesignal/docker-sonarqube/).

# What is SonarQube?

[SonarQube](http://www.sonarqube.org/) software (previously called Sonar) is an open source quality management platform, dedicated to continuously analyze and measure technical quality, from project portfolio to method.

> [wikipedia.org/wiki/SonarQube](http://en.wikipedia.org/wiki/SonarQube)

![logo](http://upload.wikimedia.org/wikipedia/commons/e/e6/Sonarqube-48x200.png)

# Prerequisites

* [Install Docker](http://docs.docker.com/installation/)
* [Install Docker Compose](http://docs.docker.com/compose/install/)

Now you can verify that the installation is ok with the following commands:

```bash
docker version
docker-compose --version
```

# Installation

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image in the future. These builds are performed by the Trusted Build service.

```bash
docker pull orangesignal/sonarqube
```

Alternately you can build the image yourself.

```bash
git clone https://github.com/orangesignal/docker-sonarqube.git
cd docker-sonarqube
docker build --tag="$USER/sonarqube" .
```

# Quick Start

Run the SonarQube with Docker Compose. Docker Compose uses a `docker-compose.yml` file that describes the environment.

```bash:PostgreSQL
git clone https://github.com/orangesignal/docker-sonarqube.git
cd docker-sonarqube
docker-compose up
```

or


```bash:H2
docker run -p 9000:9000 orangesignal/sonarqube
```

**NOTE**: Please allow a minute or two for the SonarQube application to start.

On another console run:

```bash
make port
```

Point your browser to the given URL and login using the default username and password:

* username: **admin**
* password: **admin**

You should now have the SonarQube application up and ready for testing. If you want to use this image in production the please read on.

## Environment Variables

The SonarQube image uses several environment variables which are easy to miss. While none of the variables are required, they may significantly aid you in using the image.

### `SONAR_JDBC_URL`

### `SONAR_JDBC_USERNAME`

This optional environment variable is used in conjunction with `SONAR_JDBC_USERNAME` to set a user and its password. If it is not specified, then the default user of `sonar` will be used.

### `SONAR_JDBC_PASSWORD`

This environment variable is recommend for you to use the SonarQube image.
