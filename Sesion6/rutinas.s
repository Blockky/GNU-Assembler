.data
    msg: .asciz "Se ha producido un desbordamiento\n"
    len = . - msg
    es_pos: .asciz "El resultado en positivo\n"
    len2 = . - es_pos
    es_neg: .asciz "El resultado es negativo\n"
    len3 = . - es_neg

.text
    .global _start

_start:

    pushl $1
    pushl $2147483647

    call suma
    movl %eax,  %esi
    movl %ebx,  %edi

    addl $(2*4), %esp

    cmpl $-1, %edi
    jne comprobar_signo

    movl $4,    %eax
    movl $1,    %ebx
    movl $msg,  %ecx
    movl $len,  %edx
    int  $0x80

comprobar_signo:
    subl $0,   %esi
    js es_negativo

    movl $4,       %eax
    movl $1,       %ebx
    movl $es_pos,  %ecx
    movl $len2,    %edx
    int  $0x80

    jmp finalizar

es_negativo:
    movl $4,       %eax
    movl $1,       %ebx
    movl $es_neg,  %ecx
    movl $len3,    %edx
    int  $0x80

finalizar:
    popl %eax

    movl $0, %ebx
    movl $1, %eax
    int  $0x80

.type suma, @function
.global suma
suma:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp),   %eax
    movl 12(%ebp),  %ebx
    addl %ebx,      %eax
    jno salir
    movl $-1,       %ebx

salir:

    movl %ebp, %esp
    popl %ebp
    ret
