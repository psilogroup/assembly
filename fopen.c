#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc,char **argv)
{
  int fd = open("/etc/hosts", O_RDONLY);
  if (fd == -1){
    fprintf(stderr, "could not open file\n");
    return 1;
  }

  const size_t buffer_size = 16;
  char *buffer = malloc(buffer_size);

  while (true)
  {
    ssize_t size = read(fd, buffer, buffer_size);
    //-1 means error
    if (size == -1) {
      fprintf(stderr, "an error happend while reading the file");
    }
    //0 means end of file i guess

    if (size == 0) break;

    write(STDOUT_FILENO,buffer,size);
  }

  write(STDOUT_FILENO,"\n",1);

  return 0;
}

