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


# Aliases
# --------------------------------------------------
cutline='pblyth-shell-scripts-git'
alias_file="$PWD/aliases.sh"
bash_profile="$HOME/.bash_profile"

if [ $installing = true ]
then # Installing:

  # - Create .bash_profile if it doesn't exist
  if [[ ! -e "$bash_profile" && ! -L "$bash_profile" ]]; then
    >$bash_profile
  fi

  # - Source our aliases in .bash_profile
  grep -q "${alias_file}" ${bash_profile} || echo "source \"${alias_file}\" # ${cutline}" >> ${bash_profile}

  # - Make sure that we're still loading the user's custom profile
  #   (Packages add similar lines, so check if it's already there)
  grep -q '\.profile' ${bash_profile} || ( echo '[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" #' ${cutline} ) >> ${bash_profile}

else # Uninstalling:

  # - Remove our stuff
  sed -e "/${cutline}/d" -i.backup ${bash_profile} && rm ${bash_profile}.backup

fi


# Usage
# --------------------------------------------------

if [[ $installing = true ]]; then
  echo
  echo "${cB}Thanks for installing!${c0}"
  echo '`cat USAGE.md` for usage.'
  echo '`cat aliases.sh` for aliases.'
fi
