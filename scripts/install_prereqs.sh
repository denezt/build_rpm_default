#!/bin/bash -x

if [ -z "${1}" ];
then
	_distro="-$(lsb_release -i | tr '[:upper:]' '[:lower:]' | cut -d: -f2 | tr -d '[:space:]')"
	printf "Auto-Dectect OS: [ ${_distro} ]\n"
else
	_distro="${1}"
fi

# Install Prereqs for scripts.
red_hat(){
	zypper in rpm-build || dnf in rpm-build
	zypper in pwgen || dnf in pwgen
}

ubuntu(){
	printf "Checking for required linked resources...\n"
	printf "Done!\n"
	deps=( 'pwgen' 'alien' 'jq' 'python3' )
	for dep in ${deps[@]}
	do
		if [ -z "$(command -v ${dep})" ];
		then
			apt-get -y install ${dep}
		else
			printf "Dependency: ${dep} is already installed\n"
		fi
  	done
}

help_menu(){
  printf "\033[1;2;36mInstall Build Deps\033[0m\n"
  printf "\033[1;2;35mRedhat distro\t\033[1;2;32m[ -redhat, -fedora ]\033[0m\n"
  printf "\033[1;2;35mUbuntu distro\t\033[1;2;32m[ -ubuntu ]\033[0m\n"
}

case ${_distro} in
  -redhat|-fedora) red_hat;;
  -ubuntu|-raspbian) ubuntu;;
  -h|-help|--help) help_menu;;
  *) printf "Missing or invalid parameter was entered!\nTry '-h' to view options.\n";;
esac
