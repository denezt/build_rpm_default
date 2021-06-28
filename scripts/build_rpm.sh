#!/bin/bash -x
#
#
#

_dir="/home/jenkins/displaymsg-1.0"
# _rpm_name="$(sudo rpmbuild -ba ${_dir}/displaymsg.spec | egrep 'Wrote:' | grep '/home/jenkins/rpmbuild/RPMS' | cut -d: -f2 | tr -d '[:space:]')"
# rpmbuild -ba ${_dir}/displaymsg.spec | egrep 'Wrote:' | grep '/home/jenkins/rpmbuild/RPMS' | cut -d: -f2 | tr -d '[:space:]'

ls -lsa
rpmbuild --define "_topdir /home/jenkins/rpmbuild" -ba ${_dir}/displaymsg.spec #| egrep 'Wrote:' | grep '/home/jenkins/rpmbuild/RPMS' | cut -d: -f2 | tr -d '[:space:]'
