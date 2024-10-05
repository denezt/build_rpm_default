/*
* Name: displaymsg
*/

#include <stdio.h>
#include <unistd.h>
#include <ctype.h>
#include <math.h>

int main(int argc, char *argv[]){
	char *s = *argv++;
	printf("Program installed %s\n", s);
	printf("version 1.0.1\n");
	return 0;
}
