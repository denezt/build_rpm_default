#!/bin/sh

cd /home/jenkins/displaymsg-1.0
sudo rpmbuild -ba displaymsg.spec | tee -a output.txt
cat output.txt

