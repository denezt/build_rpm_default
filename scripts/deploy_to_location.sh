#!/bin/bash -x

extdir="/mnt/rpm_builds"

if [ ! -d "${extdir}" ];
then
	printf "Making directory: [ ${extdir} ]\n"
	sudo mkdir -v "${extdir}"
else
	echo "Directory $extdir already exists"
fi

# echo "RPM NAME: $(jq .rpm_name /home/jenkins/session_data.json)"
# _rpmpkg="$(jq .rpm_name /home/jenkins/session_data.json | tr -d '\"')"
_rpmpkg=$(cat /tmp/rpm_artifact.txt)
if [ ! -z "${_rpmpkg}" ];
then
	if [ -e "${_rpmpkg}" ];
	then
		_rename="$(echo ${_rpmpkg} | tr '.' '-')"
		sudo sha256sum ${_rpmpkg} | sudo tee "${_rename}.cksum"
		sudo cp -a -v ${_rpmpkg} ${extdir}/
		sudo cp -a -v "${_rename}.cksum" ${extdir}/
	else
		printf "Error: Unable to find ${_rpmpkg}.\n"
	fi
else
	printf "Error: Missing or no rpm package known.\n"
fi
