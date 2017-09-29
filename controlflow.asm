;@Autor newbie_x11 - Assembly comparando valores
;build
;# nasm -f elf64 -o controlflow.o controlflow.asm
;ld -o controlflow controlflow.o

section .data ;secao de dados
  n1: equ 23 ;armazena inteiro n1 = 23
  n2: equ 27 ;armazena inteiro n2 = 27;
  msg: db "Soma correta",10 ;armazena msg
  msglen: equ $-msg ;calcula o tamanho da msg

section .text ;secao texto
  global _start

_start: ;funcai principal
  mov rax, n1 ;rax = n1
  mov rbx, n2 ;rbx = n3
  add rax, rbx ;rax = rax + rbx;
  cmp rax, 50 ;compara rax com 50
  jne .exit ;se nao for igual sai
  jmp .rightSum ; se for igual pula pra rightSum

.rightSum: ;mostra mensagem
  mov rax,1 ;syscall sys_write
  mov rdi,1 ;imprime em stdout
  mov rsi,msg ;ponteiro para mensagem
  mov rdx,msglen ; tamanho da mensagem
  syscall ;chama sys_write
  jmp .exit

.exit:
  mov rax,60 ;syscall exit
  mov rdi,0 ;exito code 0
  syscall ;call exite
