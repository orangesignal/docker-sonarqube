#!/bin/bash -e

user='orangesignal'
repo='sonar'
vername='SONARQUBE_VERSION'

function build() {
  local build_dir=$1
  local latest=$2
  local build_ver=$(cat ${build_dir}/Dockerfile | grep "^ENV ${vername}" | cut -d ' ' -f3)
  echo "building ${user}/${repo}:${build_ver}"

  # build
  docker build -t ${user}/${repo}:${build_ver} ${build_dir}

  # push
  docker push ${user}/${repo}:${build_ver}

  if test "${latest}" == 'latest'; then
    docker tag -f ${user}/${repo}:${build_ver} ${user}/${repo}:latest
    docker push ${user}/${repo}:latest
  fi
}

base_dir=$(dirname ${BASH_SOURCE:-$0})

build ${base_dir}/3.7
build ${base_dir}/4.0
build ${base_dir}/4.1
build ${base_dir}/4.2
build ${base_dir}/4.3
build ${base_dir}/4.4
build ${base_dir}/4.5
build ${base_dir}/5.0
build ${base_dir}/5.1 latest
