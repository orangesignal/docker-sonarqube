#!/bin/bash -e

images=$(docker images orangesignal/sonarqube)

function buildImageAndPushIfNeed() {
  echo "building orangesignal/sonarqube:$build_ver"
  local build_dir=$1
  local latest=$2
  local build_ver=$(cat $build_dir/Dockerfile | grep "^ENV SONARQUBE_VERSION" | cut -d ' ' -f3)
  local before_image_id=$(echo $images | grep $build_ver | awk '{print $3}')
  docker build -t orangesignal/sonarqube:$build_ver $build_dir
  local after_image_id=$(echo $images | grep $build_ver | awk '{print $3}')
  if test $before_image_id != $after_image_id; then
    echo "orangesignal/sonarqube:$build_ver $before_image_id -> $after_image_id"
    docker push orangesignal/sonarqube:$build_ver
    if test "$latest" != ''; then
      docker tag orangesignal/sonarqube:$build_ver orangesignal/sonarqube:latest
      docker push orangesignal/sonarqube:latest
    fi
  else
    echo "orangesignal/sonarqube:$build_ver no change"
  fi
}

base_dir=$(dirname ${BASH_SOURCE:-$0})

buildImageAndPushIfNeed $base_dir/3.7
buildImageAndPushIfNeed $base_dir/4.0
buildImageAndPushIfNeed $base_dir/4.1

buildImageAndPushIfNeed $base_dir/4.5 latest
