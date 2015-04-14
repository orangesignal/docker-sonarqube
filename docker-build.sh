#!/bin/bash -e
docker build -t orangesignal/sonarqube:3.7.4 ./3.7
docker build -t orangesignal/sonarqube:4.0   ./4.0
docker build -t orangesignal/sonarqube:4.1.2 ./4.1

docker build -t orangesignal/sonarqube:4.5.4 ./4.5
