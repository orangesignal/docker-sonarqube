# orangesignal/sonarqube:example

## Containers

* nginx container
* SonarQube (LTS) + major plugins container
* PostgreSQL database container
* Volume Data container

## How to use

```bash
git clone https://github.com/orangesignal/docker-sonarqube.git
cd docker-sonarqube/example
docker-compose up
open http://192.168.59.103/sonarqube/
```
