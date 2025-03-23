.data
    tam = 20+1
    buffer: .space tam
    buflower: .space tam
    bufupper: .space tam
    bufswap: .space tam
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

    /* Guardamos el numero de bytes leidos */
    movl %eax,  %edi
    subl $1,    %edi

    /* Poner en minuscula todo*/
    movl %edi,  %ecx
    movl $0,    %esi

lower:
    movb  buffer(%esi), %al
    orb   $0b00100000,  %al     /* El bit con peso 2**5 se pone en 1 */
    movb  %al, buflower(%esi)
    incl  %esi
    loop lower

    movb  $10, buflower(%esi)

    movl $4,        %eax
    movl $1,        %ebx
    movl $buflower, %ecx
    movl $tam,      %edx
    int  $0x80

    /* Poner en mayuscula todo*/
    movl %edi, %ecx
    movl $0,   %esi

upper:
    movb buffer(%esi), %al
    andb $0b1011111,   %al
    movb %al, bufupper(%esi)
    incl %esi
    loop upper

    movb  $10,  bufupper(%esi)

    movl $4,        %eax
    movl $1,        %ebx
    movl $bufupper, %ecx
    movl $tam,      %edx
    int $0x80

    /* Intercambiar mayusculas y minusculas entre si */
    movl %edi,  %ecx
    movl $0,    %esi

swap:
    movb buffer(%esi), %al
    xorb $0b00100000,  %al
    movb %al, bufswap(%esi)
    incl %esi
    loop swap

    movb  $10,  bufswap(%esi)

    movl $4,        %eax
    movl $1,        %ebx
    movl $bufswap,  %ecx
    movl $tam,      %edx
    int $0x80

    /* Finalizamos el programa */
    movl  $1,   %eax
    movl  $0,   %ebx
    int   $0x80
    
