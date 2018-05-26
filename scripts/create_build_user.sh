#!/bin/bash
#
#
#

option=$1
_user="tmp_user"
_user_dir="/home/${_user}"

error(){
	if [ ! -z "$1" ];
	then

		output="${1}"
	else

		output="Unknown error occurred! (create_build_user)"
	fi
	printf "\033[1;2;36mError:\033[0m\t\033[31m$output\033[0m\n"
	}

prereqs(){
	if [ ! -z "${1}" ];
	then
		# Create user and home dir
		useradd $1
		_pwgen="$(pwgen -1 -s -y 12)" 
		# Add password
		echo "${_pwgen}" | passwd "$1" --stdin
	else
		error "Missing username!"
	fi
	}

create_structure(){
	mkdir -v -p /home/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
	chown -R ${_user}:${_user} /home/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
	touch ${_user_dir}/.rpmmacros && chown -R
	



	}


main(){
	if [ -d "/home/build" ];
	then
		prereqs ${_user}
		# Switch to user home
		create_file_structure
	else
		error "No home build directory was found!"
	fi
	}


case $option in
	-s|-start) main;;
	*) error "Missing or invalid parameter!";;
esac




