#!/bin/bash

set -ex
shopt -s extglob

WF_CUSTOM_CONFIGS_DIR="${WF_CUSTOM_CONFIGS_DIR-/var/wf}"

applyCustomConfigs() {
  echo "> Checking for custom configs at \"$WF_CUSTOM_CONFIGS_DIR\"..."
  if [[ -d "$WF_CUSTOM_CONFIGS_DIR" ]] ; then
      echo '> Found custom configs, applying...'
      rsync -rtiv $WF_CUSTOM_CONFIGS_DIR/ /var/warfork/server/Warfork.app/Contents/Resources/basewf/
      echo '> Done'
  else
      echo '> No custom configs found to apply'
  fi
}

startServer() {
  echo '> Starting server ...'
  optionalParameters=""
  cd /var/warfork/server/Warfork.app/Contents/Resources/
  ./wf_server.x86_64 \
      $optionalParameters \
      $WF_PARAMS
}

applyCustomConfigs
startServer
