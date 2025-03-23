.data
    newline: .ascii "\n"

.text
    .global _start
_start:
    /* Sacar el número de argumentos (argc) de la pila */
    popl    %ecx

argumentos:
    /* Comprobar que no se impriman más de 9 argumentos */
    incl    %esi
    cmpl    $10,  %esi
    je salir
    
    /* Sacar el siguiente argumento (argv[i]) de la pila */
    popl    %ebx
    movl    %ebx, %ecx
    testl   %ecx, %ecx
    jz salir
    
    movl   %ebx,  %edi
    /* Contar el número de bytes del argumento */
contar:
    cmpb   $0, (%edi)
    je imprimir

    incl   %edi
    incl   %edx
    jmp contar

imprimir:
    movl    $4, %eax
    movl    $1, %ebx
    int     $0x80

    movl    $4, %eax
    movl    $1, %ebx
    movl    $newline, %ecx
    movl    $1, %edx
    int     $0x80

    jmp     argumentos

salir:
    movl  $1,   %eax
    movl  $0,   %ebx
    int   $0x80
