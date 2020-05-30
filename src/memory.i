# 1 "memory.c"
# 1 "/home/sanjana/C1M2/src//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "memory.c"
# 23 "memory.c"
# 1 "memory.h" 1
# 37 "memory.h"
void set_value(char * ptr, unsigned int index, char value);
# 50 "memory.h"
void clear_value(char * ptr, unsigned int index);
# 63 "memory.h"
char get_value(char * ptr, unsigned int index);
# 78 "memory.h"
void set_all(char * ptr, char value, unsigned int size);
# 91 "memory.h"
void clear_all(char * ptr, unsigned int size);
# 24 "memory.c" 2




void set_value(char * ptr, unsigned int index, char value){
  ptr[index] = value;
}

void clear_value(char * ptr, unsigned int index){
  set_value(ptr, index, 0);
}

char get_value(char * ptr, unsigned int index){
  return ptr[index];
}

void set_all(char * ptr, char value, unsigned int size){
  unsigned int i;
  for(i = 0; i < size; i++) {
    set_value(ptr, i, value);
  }
}

void clear_all(char * ptr, unsigned int size){
  set_all(ptr, 0, size);
}
