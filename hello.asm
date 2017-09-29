;@Autor newbie_x11 - Hello World em assembly
;build
;# nasm -f elf64 -o hello.o hello.asm
;ld -o hello hello.o
section .data
msg db "Hello World!" ;declaracao da constante

section .text
global _start ;o programa vai comecar por _start

_start:
mov rax,1 ;syscall sys_write
mov rdi,1 ;imprime em stdout
mov rsi,msg ;ponteiro para mensagem
mov rdx,13 ;tamanho da mensagem
syscall ;chama sys_write
mov rax,60 ;syscall exit
mov rdi,0 ;exito code 0
syscall ;call exite
