#!/bin/bash

# https://github.com/kaicataldo/dotfiles/blob/master/bin/install.sh

# This symlinks all the dotfiles (and .atom/) to ~/

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

ask() {
  print_question "$1"
  read
}

ask_for_confirmation() {
  print_question "$1 (y/n) "
  read -n 1
  printf "\n"
}

ask_for_sudo() {

  # Ask for the administrator password upfront
  sudo -v

  # Update existing `sudo` time stamp until this script has finished
  # https://gist.github.com/cowboy/3118588
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &> /dev/null &

}

cmd_exists() {
  [ -x "$(command -v "$1")" ] \
    && printf 0 \
    || printf 1
}

execute() {
  $1 &> /dev/null
  print_result $? "${2:-$1}"
}

get_answer() {
  printf "$REPLY"
}

print_error() {
  # Print output in red
  printf "\e[0;31m  [✖] $1 $2\e[0m\n"
}


print_question() {
  # Print output in yellow
  printf "\e[0;33m  [?] $1\e[0m"
}

print_result() {
  [ $1 -eq 0 ] \
    && print_success "$2" \
    || print_error "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
    && exit
}

print_success() {
  # Print output in green
  printf "\e[0;32m  [✔] $1\e[0m\n"
}


# Warn user this script will overwrite current dotfiles
while true; do
  read -p "Warning: this will overwrite your current dotfiles. Continue? [y/n] " yn
  case $yn in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no.";;
  esac
done

# Get the dotfiles directory's absolute path
SCRIPT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"


dir=~/dotfiles                        # dotfiles directory
dir_backup=~/dotfiles-old             # old dotfiles backup directory

# Get current dir (so run this script from anywhere)
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create dotfiles_old in homedir
echo -n "Creating $dir_backup for backup of any existing dotfiles in ~..."
mkdir -p $dir_backup
echo "done"

# Change to the dotfiles directory
echo -n "Changing to the $dir directory..."
cd $dir
echo "done"



declare -a FILES_TO_SYMLINK=(
  'configs/.gitconfig'
  'configs/.tmux.conf'
  'configs/.vimrc'
  'configs/.zshrc'
  'configs/.zprofile'
)

# Move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for i in ${FILES_TO_SYMLINK[@]}; do
  echo "Moving any existing dotfiles from ~ to $dir_backup"
  # Move if the file exists
  [ -f ~/${i##*/} ] && mv ~/${i##*/} ~/dotfiles-old
done


link_configs() {
  local i=''
  local sourceFile=''
  local targetFile=''

  for i in ${FILES_TO_SYMLINK[@]}; do
    sourceFile="$(pwd)/$i"
    targetFile="$HOME/$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
    elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
      print_success "$targetFile → $sourceFile"
    else
      ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
      if answer_is_yes; then
        rm -rf "$targetFile"
        execute "ln -fs $sourceFile $targetFile" "$targetFile → $sourceFile"
      else
        print_error "$targetFile → $sourceFile"
      fi
    fi
  done

  unset FILES_TO_SYMLINK
}

printf "\n"
echo "==============================="
echo "|       Linking Configs       |"
echo "==============================="
link_configs

set -e

printf "\n"
echo "================================="
echo "|       Sourcing .zprofile      |"
echo "================================="
source ~/.zprofile


echo "=============================="
echo "|      Installing Brew       |"
echo "=============================="
. "$DOTFILES_DIR/brew/install.sh"
. "$DOTFILES_DIR/brew/cask.sh"

printf "\n"
echo "=============================="
echo "|      Installing Node       |"
echo "=============================="
n i lts
npm install -g npm

printf "\n"
echo "================================"
echo "| Installing VSCode Extensions |"
echo "================================"
. "$DOTFILES_DIR/vscode/extensions.sh"

printf "\n"
echo "=========================="
echo "|      OSX Defaults      |"
echo "=========================="
. "$DOTFILES_DIR/osx/defaults.sh"

printf "\n"
echo "=========================="
echo "|         iTerm2         |"
echo "=========================="
open "${HOME}/dotfiles/iterm/material-design-colors.itermcolors"
echo "Remember to load your iTerm Profile under iterm/profile.json"

printf "\n"
echo "=========================="
echo "|          tmux          |"
echo "=========================="
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.tmuxp
cp -a $DOTFILES_DIR/tmuxp/. ~/.tmuxp/

tmux source-file ~/.tmux.conf

printf "\nAlmost done..."
printf "\n\nType \e[0;33msource ~/.zshrc\e[0m"
printf "\nRemember to run \e[0;33mprefix + I\e[0m to install tmux plugins"

