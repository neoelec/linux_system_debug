;
; file: first.asm
; First assembly program. This program asks for two integers as
; input and prints out their sum.
;
; To create executable:
; Using djgpp:
; nasm -f coff first.asm
; gcc -o first first.o driver.c asm_io.o
;
; Using Linux and gcc:
; nasm -f elf first.asm
; gcc -o first first.o driver.c asm_io.o
;
; Using Borland C/C++
; nasm -f obj first.asm
; bcc32 first.obj driver.c asm_io.obj
;
; Using MS C/C++
; nasm -f win32 first.asm
; cl first.obj driver.c asm_io.obj
;
; Using Open Watcom
; nasm -f obj first.asm
; wcl386 first.obj driver.c asm_io.obj

bits 64
default rel

%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
prompt1         db      "Enter a number: ", 0 ; don't forget nul terminator
prompt2         db      "Enter another number: ", 0
outmsg1         db      "You entered ", 0
outmsg2         db      " and ", 0
outmsg3         db      ", the sum of these is ", 0

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input1          resq    1
input2          resq    1

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   8, 0                    ; setup routine
        push    rbx

        lea     rdi, [prompt1]          ; print out prompt
        call    print_string

        call    read_long               ; read integer
        mov     [input1], rax           ; store into input1

        lea     rdi, [prompt2]          ; print out prompt
        call    print_string

        call    read_long               ; read integer
        mov     [input2], rax           ; store into input2

        mov     rax, [input1]           ; rax = dword at input1
        add     rax, [input2]           ; rax += dword at input2
        mov     rbx, rax                ; rbx = rax
        dump_regs 1                     ; dump out register values
        dump_mem 2, outmsg1, 1          ; dump out memory
;
; next print out result message as series of steps
;
        lea     rdi, [outmsg1]
        call    print_string            ; print out first message
        mov     rdi, [input1]
        call    print_long              ; print out input1
        lea     rdi, [outmsg2]
        call    print_string            ; print out second message
        mov     rdi, [input2]
        call    print_long              ; print out input2
        lea     rdi, [outmsg3]
        call    print_string            ; print out third message
        mov     rdi, rbx
        call    print_long              ; print out sum (rbx)
        call    print_nl                ; print new-line

        pop     rbx
        mov     eax, 0                  ; return back to C
        leave
        ret
