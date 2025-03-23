.data
    tam = 20+1
    buffer: .space tam
    buflower: .space tam
    msg: .ascii "\nEscribe una cadena de no más de 20 caracteres (S para finalizar):\n"
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

inicio:
    /* Leer cadena desde el teclado */
    movl  $3,       %eax
    movl  $0,       %ebx
    movl  $buffer,  %ecx
    movl  $tam,     %edx
    int   $0x80

    movl  %eax,  %edi
    subl  $1,    %edi

    /* Comparar el caracter con "S" */
    cmpl  $1,       %edi
    jne siguiente

    movb  buffer,   %al
    cmpb  $'S',     %al
    je finalizar

siguiente:
    /* Poner la cadena en minusculas */
    movl $0,     %esi
    movl %edi,   %ecx
    
lower:
    movb  buffer(%esi), %al
    orb   $0b00100000,  %al
    movb  %al,          buflower(%esi)
    incl  %esi
    loop lower

    movb  $10,   buflower(%esi)

    /* Imprimir el caracter por pantalla */
    movl $4,        %eax
    movl $1,        %ebx
    movl $buflower, %ecx
    movl $tam,      %edx
    int  $0x80

    movl $0,     %esi
    movl $tam,   %ecx

limpiar:
    movb  $0,   buffer(%esi)
    movb  $0,   buflower(%esi)
    incl  %esi
    loop limpiar

    jmp inicio /* Repetir el proceso */

finalizar:
    movl  $0,     %ebx
    movl  $1,     %eax
    int   $0x80
