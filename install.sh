#!/bin/bash

LOCAL_BIN="/usr/local/bin"

installing=true
fast=false

while [ "$1" != "" ]; do
  case $1 in
      -u | --uninstall )  installing=false
                          ;;
      -f | --fast )       fast=true
                          ;;
      -h | --help )       echo "Usage:
  -f | --fast : skip bundler, etc...
  -u | --uninstall : to uninstall"
                          exit
                          ;;
  esac
  shift
done

# \e[xxm codes aren't working...
c0=$(tput sgr 0)
cI=$(tput sgr 1)
cR=$(tput setaf 1)
cG=$(tput setaf 2)
cB=$(tput setaf 4)

col () {
  echo -n "$(tput setaf $1)${2}$(tput sgr 0)"
}

inv () {
  echo -n "$(tput sgr 1)${1}$(tput sgr 0)"
}


# Update submodules
# --------------------------------------------------

git submodule init
git submodule update


# Install gems
# --------------------------------------------------

if [[ $installing = true && $fast = false ]]
then
  gem install bundler && bundle install
fi


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
      col 2 "INSTALLING: "; echo "$target"
      ln -s "$PWD/$source" "$target"
    else # - Do nothing
      col 1 "WARNING: "; echo "$target already exits."
    fi

  else # Uninstalling:

    if [[ -e "$target" || -L "$target" ]]
    then # - Remove file or symlink
      col 2 "REMOVING: "; echo "$target"
      rm "$target"
    else # - Do nothing
      col 1 "WARNING: "; echo "$target doesn't exist."
    fi

  fi

done


# Simple symlink to original folder
# --------------------------------------------------
whoami=`whoami`
back="/Users/${whoami}/.shell-scripts"
if [[ $installing = true ]]
then
  if [[ ! -e $back && ! -L $back ]]
  then
    ln -s "$PWD" "$back"
  fi
else
  if [[ -L $back ]]
  then
    rm "$back"
  fi
fi



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

if [[ $installing = true ]]
then
  echo
  echo "${cB}Thanks for installing!${c0}"
  echo '`cat USAGE.md` for usage.'
  echo '`cat aliases.sh` for aliases.'
else
  echo
  echo "${cB}Sorry to see you go...!${c0}"
fi
