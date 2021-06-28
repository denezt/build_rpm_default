/*
* Name: displaymsg
*/

#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[]){
	char *s = *argv++;
	printf("Program installed %s\n", s);
}
