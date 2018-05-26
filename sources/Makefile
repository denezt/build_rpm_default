
PRG_NAME=displaymsg

all: compile

compile: main.c
	gcc main.c -o $(PRG_NAME)

install: compile
	mkdir -p ${RPM_BUILD_ROOT}/usr/bin
	cp -v -a $(PRG_NAME) ${RPM_BUILD_ROOT}/usr/bin
