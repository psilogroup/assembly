;@Autor newbie_x11 - Assembly comparando valores
;build
;# nasm -f elf64 -o userinput.o userinput.asm
;ld -o userinput userinput.o

section .data
  str1 db "Qual e o seu nome?",0x10,0x0 ;declara str1
  str1len equ $-str1 ;tamanho da str1
  str2 db "Bem vindo ",0x0 ;declara str2
  str2len equ $-str2 ;tamanho da str2

section .bss
  nome resb 16

section .text
  global _start

_start:
  mov rax,str1
  call _print
  call _lerNome
  mov rax,str2
  call _print
  mov rax,nome
  call _print

  mov rax,60 ;syscall exit
  mov rdi,0 ;exit code 0
  syscall ;call exit

_lerNome:
  mov rax, 0 ;sys_read
  mov rdi, 0 ;stdinput
  mov rsi, nome ;ponteiro para nome
  mov rdx, 16 ;tamanho
  syscall
  ret

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
