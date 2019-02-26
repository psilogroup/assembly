;@Autor newbie_x11 - Assembly Converte string para inteiro
;build
;# nasm -f elf64 -F dwarf -g -o printint.o printint.asm
;ld -o printint printint.o

section .data
  str1 db "777",0x0 ;declara str1
section .text
  global _start

_start:
  mov rax,0x0
  mov rsi,str1 ;rsi = ponteiro para str1
  jmp _nextchar

  mov rax,60 ;syscall exit
  mov rdi,0 ;exit code 0
  syscall ;call exit

_nextchar:
  mov rbx,0 ;ebx = 0
  mov bl,[rsi] ;copia um byte de rsi para bl
  inc rsi ;rsi++
  cmp bl,'0' ;'0'
  jb inval ;bellow?
  cmp bl,'9' ;'9'
  ja inval ;'above?'
  sub bl,0x30 ;bl -=0x30
  mov rdx,10
  mul rdx
  add rax,rbx ;rax = rax * 0x10
  jmp _nextchar

inval:
  mov rax,60 ;syscall exit
  mov rdi,0 ;exit code 0
  syscall ;call exit
