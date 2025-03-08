.data
    tam = 20+1
    buffer: .space tam
    msg: .ascii "\nEscribe una cadena de menos de 20 caracteres:\n"
    len = . - msg

.text
.global _start
_start:
    /* Solicitar al usuario que escriba una cadena */
    movl  $4,     %eax
    movl  $1,     %ebx
    movl  $msg,   %ecx
    movl  $len,   %edx
    int   $0x80

    /* Leer la cadena desde el teclado */
    movl $3,      %eax
    movl $0,      %ebx
    movl $buffer, %ecx
    movl $tam,    %edx
    int  $0x80

    /* Imprimir la cadena leida */
    movl $4,        %eax
    movl $1,        %ebx
    movl $buffer,   %ecx
    movl $tam,      %edx
    int  $0x80

    /* Finalizamos el programa */
    movl  $1,   %eax
    movl  $0,   %ebx
    int   $0x80
    