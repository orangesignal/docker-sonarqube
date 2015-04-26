#!/bin/bash -e
docker rm $(docker ps -a -q -f status=exited)
