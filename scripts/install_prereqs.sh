#!/bin/bash

_distro="$1"

# Install Prereqs for scripts.
red_hat(){
  zypper in rpm-build || dnf in rpm-build
  zypper in pwgen || dnf in pwgen
}

ubuntu(){
  printf "Checking for required linked resources...\n"
  if [ ! -z "$( ls /lib/i386-linux-gnu/libc.so.6)" ];
  then
	echo "Found: '/lib/i386-linux-gnu/libc.so.6'"
  fi
  if [ -z "$(ls /lib/libc.so.6)" ];
  then
  	ln -s /lib/i386-linux-gnu/libc.so.6 /lib/
  else
   	printf "No need to create '/lib/libc.so.6' already exists."
  fi
  printf "Done!\n"
  apt-get -y install pwgen
  apt-get -y install alien
}

help_menu(){
  printf "\033[1;2;36mInstall Build Deps\033[0m\n"
  printf "\033[1;2;35mRedhat distro\t\033[1;2;32m[ -redhat, -fedora ]\033[0m\n"
  printf "\033[1;2;35mUbuntu distro\t\033[1;2;32m[ -ubuntu ]\033[0m\n"
}

case ${_distro} in
  -redhat|-fedora) red_hat;;
  -ubuntu) ubuntu;;
  -h|-help|--help) help_menu;;
  *) printf "Missing or invalid parameter was entered!\nTry '-h' to view options.\n";;
esac
