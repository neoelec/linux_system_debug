;
; file: sub6.asm
; Subprogram to C interfacing example

bits 64
default rel

; subroutine calc_sum
; finds the sum of the integers 1 through n
; Parameters:
;   n    - what to sum up to (at [rbp + 8])
; Return value:
;   value of sum
; pseudo C code:
; int calc_sum( int n )
; {
;   int i, sum = 0;
;   for( i=1; i <= n; i++ )
;     sum += i;
;   return sum;
; }
;
; To assemble:
; DJGPP:   nasm -f coff sub6.asm
; Borland: nasm -f obj  sub6.asm

segment .text
        global  calc_sum
;
; local variable:
;   sum at [rbp-8]
calc_sum:
        enter   16, 0                   ; make room for sum on stack

        mov     qword [rbp - 8], 0      ; sum = 0
        mov     rcx, 1                  ; rcx is i in pseudocode
for_loop:
        cmp     rcx, rdi                ; cmp i and n
        jnle    end_for                 ; if not i <= n, quit

        add     [rbp - 8], rcx          ; sum += i
        inc     rcx
        jmp     for_loop

end_for:
        mov     rax, [rbp - 8]          ; rax = sum

        leave
        ret
