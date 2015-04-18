#!/bin/bash -e
docker rmi $(docker images --filter "dangling=true" -q)