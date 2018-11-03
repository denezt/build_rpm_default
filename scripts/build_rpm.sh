#!/bin/bash
#
#
#

sessionFile="/home/jenkins/session_data.json"
pushd .
cd /home/jenkins/displaymsg-1.0
_rpm_name="$( sudo rpmbuild -ba displaymsg.spec | egrep 'Wrote:' | grep '/home/jenkins/rpmbuild/RPMS' | cut -d: -f2 | tr -d '[:space:]' )"

# save to session_data
if [ ! -z "${_rpm_name}" ];
then
	[ -f "${sessionFile}" ] && printf ',\n' | tee -a "${sessionFile}"
	echo "{\"rpm_name\":\"${_rpm_name}\"}" | tee -a "${sessionFile}"
fi
popd

