#!/bin/bash

LOCAL_BIN="/usr/local/bin"

installing=true

while [ "$1" != "" ]; do
  case $1 in
      -u | --uninstall )  installing=false
                          ;;
      -h | --help )       echo "Usage: -u | --uninstall : to uninstall"
                          exit
                          ;;
  esac
  shift
done



# Script symlinks
# --------------------------------------------------

# - Concatenate Ruby scripts w/ shell scripts
declare -a shell_scripts=( scripts/* )

# - Loop
for source in ${shell_scripts[@]}; do
  base=`basename ${source} .rb`
  target="$LOCAL_BIN/$base"

  if [ $installing = true ]
  then # Installing:

    if [[ ! -e "$target" && ! -L "$target" ]]
    then # - Create symlink
      ln -s "$PWD/$source" "$target"
    else
      echo "WARNING: $target already exits:"
    fi

  else # Uninstalling:

    if [[ -e "$target" || -L "$target" ]]
    then # - Remove file or symlink
      rm "$target"
    else
      echo "WARNING: $target doesn't exit."
    fi

  fi

done

# - Verify
# ls -la /usr/local/bin/* | grep "$PWD"
