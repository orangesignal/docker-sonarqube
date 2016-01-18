#!/bin/bash -e
images_untagged="$(docker images --filter 'dangling=true' -q)"
[ -n "$images_untagged" ] && docker rmi $images_untagged || echo "Images untagged not found"
