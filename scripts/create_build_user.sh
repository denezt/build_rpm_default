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

assign_owner(){
	if [ -e "$1" -o -d "$1" ];
	then
		chown -R ${_user}:${_user} $1
	elif [ -z "$1" ];
	then
		error "Missing filename!"
	else
		error "File or directory not found (${1})!"	
	fi
	}

prereqs(){
	if [ ! -z "${1}" ];
	then
		# Create user and home dir
		useradd -m $1
		_pwgen="$(pwgen -1 -s -y 12)" 
		# Add password
		printf "${_pwgen}" > password-$(date '+%s')
		echo "${_pwgen}" | passwd "$1" --stdin
	else
		error "Missing username!"
	fi
	}

create_structure(){
	# Location of RPMBUILD 
	_rpmbuild="${_user_dir}/rpmbuild"

	mkdir -v -p ${_rpmbuild}/{BUILD,RPMS,SOURCES,SPECS,SRPMS} || exit 2
	assign_owner "${_rpmbuild}/BUILD" 
	assign_owner "${_rpmbuild}/RPMS"
	assign_owner "${_rpmbuild}/SOURCES"
	assign_owner "${_rpmbuild}/SPECS"
	assign_owner "${_rpmbuild}/SRPMS"
	
	echo  "%_topdir ${_rpmbuild}" | tee ${_user_dir}/.rpmmacros && \
	assign_owner "${_user_dir}/.rpmmacros"

	# OPTIONAL - Only for Demostration
	_demo_dir=${_user_dir}/displaymsg-1.0
	mkdir -v -p ${_demo_dir}
	assign_owner ${_demo_dir}
	cp -a -v ../sources/main.c "${_demo_dir}/main.c"
	assign_owner "${_demo_dir}/main.c"
	
	cp -a -v ../sources/Makefile ${_demo_dir}/Makefile
	assign_owner "${_demo_dir}/Makefile" 	 
displaymsg.spec	
	tar -czvf ${_rpmbuild}/SOURCES/displaymsg.tar.gz ../sources/

	}

main(){
	# Create User
	prereqs ${_user}
	if [ -d "/home/${_user}" ];
	then
		# Switch to user home
		create_structure
	else
		error "No home build directory was found!"
	fi
	}


case $option in
	-s|-start) main;;
	*) error "Missing or invalid parameter!";;
esac




