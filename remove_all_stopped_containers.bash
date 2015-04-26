#!/bin/bash -e
containers_stopped="$(docker ps -a -q -f status=exited)"
[ -n "$containers_stopped" ] && docker rm $containers_stopped || echo "Containers stopped not found"
