#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
int main(int argc,char **argv)
{
  //declare and initialize zero filled array;
  char buffer[1024] = {0};
  size_t read_bytes = 0;
  pid_t pid = 0;
  
  //call open system call.
  int fd = open("/etc/hosts", O_RDONLY);
  if (fd == -1)
  {
    printf("could not open file\n");
    return 1;
  }

  do {
    //call open system call
    size_t read_bytes = read(fd, buffer, 1024); 
    write(1,buffer,read_bytes);
  } while (read_bytes > 0);
  
  write(1,"\n",1);
  return 0;
}