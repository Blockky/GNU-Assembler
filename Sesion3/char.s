.data
    tam = 1+1
    buffer: .space tam
    msg: .ascii "\nEscribe un caracter (S para finalizar):\n"
    len = . - msg
    newline: .ascii "\n"

.text
    .global _start

_start:
    /* Solicitar al usuario que escriba un caracter */
    movl  $4,     %eax
    movl  $1,     %ebx
    movl  $msg,   %ecx
    movl  $len,   %edx
    int   $0x80

inicio:
    /* Leer caracter desde el teclado */
    movl  $3,       %eax
    movl  $0,       %ebx
    movl  $buffer,  %ecx
    movl  $tam,     %edx
    int   $0x80

    /* Comparar el caracter con "S" */
    movb  buffer,   %al
    cmpb  $'S',     %al
    je finalizar

    /* Imprimir el caracter por pantalla */
    movl $4,        %eax
    movl $1,        %ebx
    movl $buffer,   %ecx
    movl $1,        %edx
    int  $0x80

    /* Imprimir un salto de linea */
    movl $4,        %eax
    movl $1,        %ebx
    movl $newline,  %ecx
    movl $1,        %edx
    int  $0x80

    jmp inicio /* Repetir proceso */

finalizar:
    movl  $1,     %eax
    movl  $0,     %ebx
    int   $0x80
