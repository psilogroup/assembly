;@Autor newbie_x11 - Assembly Unidade de Ponto Flutuante
;build
;# nasm -f elf64 -F dwarf -g -o fpumath.o fpumath.asm
;ld -o fpumath fpumath.o
;calculo de valor futuro de aplicação com depósitos peródicos
;FV = PMT*(1+i)*[(1+i)^n -1 / i]
;
section .data
  n: dq 360.0 ;360 meses
  i: dq 0.0054 ;0,54% / 100
  pmt: dq 500.0 ; valor do depósito
section .bss
  fv: resq 1     ;valor futuro
section .text
  global _start

_start:

  fld qword [n]
  fld1
  fadd qword [i]
  ;calculo st0^st1
  fyl2x
  fld1
  fld st1
  fprem
  f2xm1
  fadd
  fscale
  fstp ;fim do calculo st0 com o resultado de x^y
  fld1
  fchs
  fadd
  fld qword [i]
  fdiv
  fld qword [pmt]
  fld1
  fld qword [i]
  fadd
  fmul
  fmul
  fistp qword [fv]
  mov r8,[fv]
  mov rax,60 ;syscall exit
  mov rdi,0 ;exit code 0
  syscall ;ca
