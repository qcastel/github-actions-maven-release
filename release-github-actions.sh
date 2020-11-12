#!/usr/bin/env bash

export CI_COMMIT_SHA="${GITHUB_SHA}"
export CI_COMMIT_REF_NAME="${GITHUB_REF}"

add-ssh-key.sh

git clone --verbose git@github.com:idhub-io/idhub-api.git
if [[ "$?" -ne 0 ]] ; then
  echo "Git clone failed"
  exit 1
fi

release.sh