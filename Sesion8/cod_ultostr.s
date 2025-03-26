.data
    msg: .asciz "Escriba un número:\n"
    len = . - msg
    msg_bas: .asciz "Escriba la base del numero:\n"
    len2 = . - msg_bas
    tam = 80
    buf: .space tam
    base: .space 3
    bsbuf: .byte 0

.text
    .global _start
_start:
    /* Solicita al usuario que escriba un número */
    movl  $4,    %eax
    movl  $1,    %ebx
    movl  $msg,  %ecx
    movl  $len,  %edx
    int   $0x80

    /* Lee la entrada del usuario */
    movl  $3,   %eax
    movl  $0,   %ebx
    movl  $buf, %ecx
    movl  $tam, %edx
    int   $0x80

    /* Solicita al usuario que escriba la base */
    movl  $4,        %eax
    movl  $1,        %ebx
    movl  $msg_bas,  %ecx
    movl  $len2,     %edx
    int   $0x80

    /* Lee la entrada del usuario */
    movl  $3,    %eax
    movl  $0,    %ebx
    movl  $base, %ecx
    movl  $3,    %edx
    int   $0x80

    /* Llamada a ascii_to_int para obtener la base leida */
    pushl $10
    pushl $base
    call ascii_to_int

    addl $(4*2), %esp

    pushl %eax
    pushl $buf
    call ascii_to_int

    /* Termina el programa */
    movl $1, %eax
    movl $0, %ebx
    int  $0x80

#--------------------------------------------------------------------
# unsigned long int strtoul(char *)
# Devuelve el valor binario puro de una cadena de caracteres
# o 0xFFFFFFFF en caso de error (desbordamiento o valor no numérico)
#-------------------------------------------------------------------
.type ascii_to_int, @function
.global ascii_to_int
ascii_to_int:
    pushl %ebp              # Preparamos la pila
    movl  %esp, %ebp

    pushl %ebx              # Guardo ebx ya que se va a utilizar
    
    movl  8(%ebp),  %ebx    # Recupero el puntero al buffer
    movl  12(%ebp), %edi    # Base
    movl  $0,       %esi    # Índice de la cadena
    xorl  %eax,     %eax
    cmpl  $16,      %edi
    ja error
    cmpl  $2,       %edi
    jb error

    movl  %edi,     bsbuf
    
    cmpl  $10,      %edi
    ja cod_con_letras

cod_sin_letras:             # Codificar cada caracter de la cadena
    movb (%ebx, %esi), %cl  
    cmpb $10,  %cl          # Comprobar si hemos llegado al final de la cadena
    je fin_codificar
    cmpb $0,   %cl
    je fin_codificar
    cmpb $'0', %cl          # Comprobar si el caracter leido es un valor numérico
    jb error
    addb $47,  bsbuf
    cmpb bsbuf, %cl
    ja error
    
    andl  $0x0F, %ecx       # Conversión de numero en ascii a binario
    mull  %edi
    addl  %ecx,  %eax       # Hay overflow si:
    jc error                # CF = 1 tras sumar ecx y eax
    testl %edx,  %edx       # edx != 0 tras multiplicar eax por la base,
    jnz error               # es decir, que el rango del numero es mayor que 32 bits

    xorl  %ecx,  %ecx

    incl %esi
    subb $47,  bsbuf
    jmp cod_sin_letras

cod_con_letras:
    movb (%ebx, %esi), %cl  
    cmpb $10,  %cl          # Comprobar si hemos llegado al final de la cadena
    je fin_codificar
    cmpb $0,   %cl
    je fin_codificar
    cmpb $64,  %cl
    ja es_letra

    cmpb $'0', %cl          # Comprobar si el caracter leido es un valor numérico
    jb error
    
    andl  $0x0F, %ecx       # Conversión de numero en ascii a binario
    mull  %edi
    addl  %ecx,  %eax       # Hay overflow si:
    jc error                # CF = 1 tras sumar ecx y eax
    testl %edx,  %edx       # edx != 0 tras multiplicar eax por la base,
    jnz error               # es decir, que el rango del numero es mayor que 32 bits

    xorl  %ecx,  %ecx

    incl %esi
    jmp cod_con_letras

es_letra:
    cmpb $'A', %cl          # Comprobar si el caracter leido es un valor numérico
    jb error
    cmpb $'F', %cl          # Comprobar si el caracter leido es un valor numérico
    ja error
    
    subl  $55,   %ecx
    mull  %edi
    addl  %ecx,  %eax       # Hay overflow si:
    jc error                # CF = 1 tras sumar ecx y eax
    testl %edx,  %edx       # edx != 0 tras multiplicar eax por la base,
    jnz error               # es decir, que el rango del numero es mayor que 32 bits

    xorl  %ecx,  %ecx

    incl %esi
    jmp cod_con_letras

error:                      # En caso de overflow, devolver 0xFFFFFFFF
    movl $0xFFFFFFFF, %eax

fin_codificar:
    popl %ebx

    movl %ebp, %esp
    popl %ebp
    ret
