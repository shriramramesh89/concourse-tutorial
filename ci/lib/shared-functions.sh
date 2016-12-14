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

function ensure-fly {
  announce-task "Making sure fly is installed..."

  if [[ $(type -P "fly") ]]; then
    echo "Fly is in at `which fly`"
  else
    echo "Fly not found."
    curl https://github.com/concourse/concourse/releases/download/v2.5.1/fly_linux_amd64 /usr/local/bin/fly
    chmod 755 /usr/local/bin/fly
  fi
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
  run-cmd fly target tutorial http://10.244.8.3
  run-cmd fly login -t tutorial
  run-cmd fly -t tutorial pipelines
}
