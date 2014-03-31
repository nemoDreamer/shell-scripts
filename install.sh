#!/bin/bash

LOCAL_BIN="/usr/local/bin"

u=false

while [ "$1" != "" ]; do
  case $1 in
      -u | --uninstall )  u=true
                          ;;
      -h | --help )       echo "Usage: -u | --uninstall : to uninstall"
                          exit
                          ;;
  esac
  shift
done

# Concatenate Ruby scripts w/ shell scripts
declare -a shell_scripts=( *.rb switch cpg_deploy_dev )

for source in ${shell_scripts[@]}; do
  base=`basename ${source} .rb`
  target="$LOCAL_BIN/$base"

  if [[ $u = false ]]; then # Installing

    if [[ ! -e "$target" && ! -L "$target" ]]; then
      ln -s "$PWD/$source" "$target"
    else
      echo "WARNING: $target already exits:"
    fi

    # Verify
    ls -l "$target"

  else # Uninstalling

    if [[ -e "$target" || -L "$target" ]]; then
      rm "$target"
    else
      echo "WARNING: $target doesn't exit."
    fi

  fi

done
