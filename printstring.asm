;@Autor newbie_x11 - Assembly comparando valores
;build
;# nasm -f elf64 -o printstring.o printstring.asm
;ld -o printstring printstring.o

section .data
  str1 db "Oi eu sou Goku",10,0
  str2 db "O mundo gira, vacilaum roda",10,0

section .text
global _start

_start:
  mov rax, str1 ;endereco de str1 em rax
  call _print
  mov rax, str2 ;endereco de str2 em rax
  call _print

  mov rax,60 ;sys_exit
  mov rdi,0 ;exit code 0
  syscall

;importante notar que rax e um ponteiro ou seja aponta para um endereco
;de memoria

_print:
  push rax ;coloca rax (inicio do texto), na stack
  mov rbx, 0 ;rbx = 0
_printLoop:
  inc rax ;rax = rax + 1 (*ptr++)
  inc rbx ;rbx = rbx + 1
  mov cl, [rax] ;copia 8 bits do endereco de memoria em rax para cl)
  cmp cl, 0 ;cl == 0?
  jne _printLoop ;volta para o inicio do loop
  mov rax, 1 ;sys_write
  mov rdi, 1 ;stdout
  pop rsi ;rsi = pego o endereco do inicio da string da stack
  mov rdx, rbx ;rbx = count (strlen)
  syscall
  ret
