;@Autr newbie_x11 - readfile in  assembly
;build
;# nasm -f elf64 -o readfile.o readfile.asm
;ld -o hello hello.o
%include "macros.asm"

section .data
  path db "number.txt",0
  file_not_found_txt db "File not found", 0xA, 0xD,0
;  filen_not_found_txt_len equ $ - file_not_found_txt 
  char db 0  
  newline db 0xA,0xD
  
section .bss 
  buffer resb 4096   ; 4k buffer 

section .text
global _start        ; program starts here


_start:
  mov rax, 2
  mov rdi, path
  xor rsi,rsi
  xor r10,r10                ; in r10 we store de index of the array
  syscall                    ; open file
  cmp rax, 0                ; we always check for erros
  jl _error_file_not_found

  push rax                   ; store rax the file descriptor  

_read_byte:
  xor rax,rax
  mov rdi, [rsp]             ; copy file descriptor from stack to rdi
  mov rsi, char              ; copy address of the buffer
  mov rdx, 1                 ; trying to read 1 byte
  syscall                    ; read
  
  test rax, rax              ; when rax == 0 we reached end of file
  jz _revert_init                 ; the file was read we can revert the buffer now
  ; we only print characters between 0,9 and space
  xor r9,r9
  mov r9b, [char]
  cmp r9b, 0x20              ; print space
  je _copy_byte_loop
  cmp r9b, 0x30              ; check if between 0..9
  jb _copy_byte_loop  
  cmp r9b, 0x39
  jg _copy_byte_loop
  

_copy_byte_loop:
  lea rsi,[buffer]           ; copy the address of the buffer to rsi 
  add rsi,r10                ; move to the next byte address
  mov [rsi], r9b             ; copy one byte into buffer 
  inc r10                    ; increment array_index
  jmp _read_byte             ; read next byte

_revert_init:
  dec r10                    ; hack extra byte, tyred for debug
_revert:
  lea rsi, [buffer]          ; copy buffer to the rsi 
  dec rsi                 ; 
  add rsi,r10                ; rsi+index
  mov r9,rsi
  println r9,1               ; print one byte
  dec r10                    ; index--
  cmp r10,0                  ; if index not equals 0 print another byte 
  jne _revert
  println newline,2          ; just print line break  
  jmp _exit                  ; all done

_error_file_not_found:
  println file_not_found_txt, 15 ; print file not found error message
  
_exit:
  mov rax,60         ;syscall exit
  xor rdi,rdi        ;exit code 0
  syscall
