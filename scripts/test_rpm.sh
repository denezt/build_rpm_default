#!/bin/sh

_pkgname="/home/jenkins/rpmbuild/RPMS/x86_64/displaymsg-1.0-1.x86_64.rpm"

printf "Running, Test on RPM Package...\n"

if [ -e "${_pkgname}" ];
then
	rpmgraph ${_pkgname}
else
	printf "Unable to locate ${_pkgname}\n"
fi
