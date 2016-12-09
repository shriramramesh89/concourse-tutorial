#!/bin/bash

function ensure-rvm {
  announce-task "Making sure RVM is set up..."
  set +ux
  if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
    run-cmd source "$HOME/.rvm/scripts/rvm"
  elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
    run-cmd source "/usr/local/rvm/scripts/rvm"
  else
    echo -e "${BRed}ERROR: ${Red}An RVM installation was not found.\n${RCol}"
  fi
  set -u
}

function bosh-login {
  announce-task "Logging-in to BOSH director..."
  which bosh
  bosh version

  set +x
  bosh -t ${bosh_director} login ${bosh_username} ${bosh_password}
  run-cmd bosh target ${bosh_director}
  run-cmd bosh status
}

function deploy-concourse {
  announce-task "Starting deployment..."
  run-cmd bosh deployment ci/manifest.yml
  run-cmd bosh -n deploy
}

function check-concourse {
  announce-task "Making sure Concourse is up..."
  run-cmd fly target tutorial http://10.244.8.2:8080
  fly login -t tutorial --username=concourse --password=concourse
  run-cmd fly -t tutorial pipelines
}
