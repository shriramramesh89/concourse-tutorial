#!/bin/bash

function ensure-rvm {
  set +ux
  if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then
    source "$HOME/.rvm/scripts/rvm"
  elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
    source "/usr/local/rvm/scripts/rvm"
  else
    printf "ERROR: An RVM installation was not found.\n"
  fi
  set -ux
}

function bosh-login {
  which bosh
  bosh version

  set +x
  bosh -t ${bosh_director} login ${bosh_username} ${bosh_password}
  set -x
  bosh target ${bosh_director}
  bosh status
}
