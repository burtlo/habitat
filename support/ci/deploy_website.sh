#!/bin/bash

set -eu

# if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]] && [[ "${TRAVIS_BRANCH}" = "master" ]]; then
if [[ "${TRAVIS_PULL_REQUEST}" = "false" ]] && [[ "${TRAVIS_BRANCH}" = "jb/build-web-site-again-lol" ]]; then
  cd www
  make deploy
fi
