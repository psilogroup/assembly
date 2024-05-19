;@Autr newbie_x11 - readfile in  assembly
;build
;# nasm -f elf64 -o readfile.o readfile.asm
;ld -o hello hello.o
%include "macros.asm"

section .data
  path db "number.txt",0
  char db 0  
  newline db 0xA,0xD
  count dd 0
section .bss 
  buffer resb 100

section .text
global _start ;o programa vai comecar por _start


_start:
  mov rax, 2
  mov rdi, path
  xor rsi,rsi
  xor r10,r10
  syscall            ; open file
  push rax           ; store rax the file descriptor  
_read_buffer:
  xor rax,rax
  mov rdi, [rsp]      ; copy file descriptor from stack to rdi
  mov rsi, char       ; copy address of the buffer
  mov rdx, 1        ; size of the buffer
  syscall            ;read
  
  test rax, rax
  jz _revert  
  inc byte [count]
  xor r9,r9
  mov r9b,[char]
  cmp r9b, 0x20 ; print space
  je _printb
  cmp r9b, 0x30 ;check if between 0..9
  jb _read_buffer
  cmp r9b, 0x39
  jg _read_buffer
  

_printb:
  lea rsi,[buffer]
  add rsi,r10
  mov [rsi],r9b
  inc r10

  ;inc r11
  jmp _read_buffer

_revert:
  lea rsi, [buffer]
  dec rsi
  add rsi,r10
  mov r9,rsi
  println r9,1
  dec r10
  cmp r10,0
  jne _revert
  println newline,2
_exit:
  mov rax,60         ;syscall exit
  xor rdi,rdi        ;exito code 0
  syscall
