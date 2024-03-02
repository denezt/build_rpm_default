#!/bin/bash -x
#
#
#

option=$1
_user="jenkins"
_user_password="${2}"
_user_dir="/home/jenkins"

error(){
	if [ ! -z "$1" ];
	then
		output="${1}"
	else
		output="Unknown error occurred! (create_build_user)"
	fi
	printf "\033[1;2;36mError:\033[0m\t\033[31m${output}\033[0m\n"
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


destroy_structure(){
	_rpmbuild="${_user_dir}/rpmbuild"
	_demo_dir="${_user_dir}/displaymsg-1.0"	
	if [ -d "${_rpmbuild}" ];
	then
		printf "Removing, ${rpm_build} session files\n"
		rm -rfv "${_rpmbuild}"
	fi
	if [ -d "${_demo_dir}" ];
	then
		printf "Removing, ${demo_dir} session files\n"
		rm -rfv "${_demo_dir}"
	fi
	}

create_structure(){
	# Location of directories
	_rpmbuild="${_user_dir}/rpmbuild"
	_srcdir="displaymsg-1.0"

	# Create RPMBUILD Structure
	mkdir -v -p ${_rpmbuild}/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
	assign_owner "${_rpmbuild}"
	assign_owner "${_rpmbuild}/BUILD"
	assign_owner "${_rpmbuild}/RPMS"
	assign_owner "${_rpmbuild}/SOURCES"
	assign_owner "${_rpmbuild}/SPECS"
	assign_owner "${_rpmbuild}/SRPMS"

	# Write Macros
	echo  "%_topdir ${_rpmbuild}" | tee ${_user_dir}/.rpmmacros && \
	assign_owner "${_user_dir}/.rpmmacros"

	# OPTIONAL - Only for Demostration
	_demo_dir=${_user_dir}/displaymsg-1.0
	mkdir -v -p ${_demo_dir}
	assign_owner ${_demo_dir}

	for _src in "main.c" "displaymsg.spec" "Makefile"
	do
		cp -v ${_srcdir}/${_src} "${_demo_dir}/${_src}"
		assign_owner "${_demo_dir}/${_src}"
	done

	tar -czvf ${_rpmbuild}/SOURCES/displaymsg.tar.gz ${_srcdir}/*
	assign_owner "${_rpmbuild}/SOURCES/displaymsg.tar.gz"
	}

help_menu(){
	printf "\033[36mCreate Build User\033[0m\n"
	printf "\033[1;2;33mStart Process\t\033[1;2;32m[ -s, -start, --start ]\033[0m\n"
	printf "\033[1;2;33mHelp Menu\t\033[1;2;32m[ -h, -help, --help ]\033[0m\n"
	}

case $option in
	-c|-clean|--clean)
		if [ -d "/home/${_user}" ];
		then
			# Remove older session files.
			destroy_structure
		else
			error "No home build directory was found!"
		fi
	;;
	-b|-build|--build)
		if [ -d "/home/${_user}" ];
		then
			# Switch to user home.
			create_structure
		else
			error "No home build directory was found!"
		fi
	;;
	-h|-help|--help) help_menu;;
	*) error "Missing or invalid parameter!";;
esac
