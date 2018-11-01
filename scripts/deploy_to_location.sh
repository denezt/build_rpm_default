#!/bin/bash

extdir="/mnt/rpm_builds"

if [ ! -d "${extdir}" ];
then
	mkdir -v "${extdir}"
else
	echo "Directory $extdir already exists"
fi

