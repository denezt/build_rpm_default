#!/bin/bash

_distro="$1"

# Install Prereqs for scripts.
red_hat(){
  zypper in rpm-build || dnf in rpm-build
  zypper in pwgen || dnf in pwgen
}

ubuntu(){
  printf "Checking for required linked resources...\n"
  test -e "/lib/libc.so.6" || ln -s /lib/i386-linux-gnu/libc.so.6 /lib/
  printf "Done!\n"
  apt-get -y install passgen
  apt-get -y install alien
}

help_menu(){
  printf "Install Build Deps"
  printf "Redhat distro\t[ -redhat, -fedora ]\n"
  printf "Ubuntu distro\t[ -ubuntu ]\n"
}

case ${_distro} in
  -redhat|-fedora) red_hat;;
  -ubuntu) ubuntu;;
  *) printf "Missing or invalid parameter was entered!\n";;
esac
