;@Autor newbie_x11 - Assembly comparando valores
;build
;# nasm -f elf64 -o userinput.o userinput.asm
;ld -o userinput userinput.o

section .data
  str1 db "Qual e o seu nome?",10 ;declara str1
  str1len equ $-str1 ;tamanho da str1
  str2 db "Bem vindo " ;declara str2
  str2len equ $-str2 ;tamanho da str2

section .bss
  nome resb 16

section .text
  global _start

_start:
  call _printStr1
  call _lerNome
  call _printStr2
  call _printNome

  mov rax,60 ;syscall exit
  mov rdi,0 ;exit code 0
  syscall ;call exit

_printStr1:
  mov rax,1 ;syscall sys_write
  mov rdi,1 ;imprime em stdout
  mov rsi,str1 ;ponteiro para mensagem
  mov rdx,str1len ;tamanho da mensagem
  syscall
  ret

_lerNome:
  mov rax, 0 ;sys_read
  mov rdi, 0 ;stdinput
  mov rsi, nome ;ponteiro para nome
  mov rdx, 16 ;tamanho
  syscall
  ret

_printStr2:
  mov rax,1 ;syscall sys_write
  mov rdi,1 ;imprime em stdout
  mov rsi,str2 ;ponteiro para mensagem
  mov rdx,str2len ;tamanho da mensagem
  syscall
  ret

_printNome:
  mov rax,1 ;syscall sys_write
  mov rdi,1 ;imprime em stdout
  mov rsi,nome ;ponteiro para mensagem
  mov rdx,16 ;tamanho da mensagem
  syscall
  ret
