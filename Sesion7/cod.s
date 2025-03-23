.data
    msg: .asciz "Escriba un número en decimal:\n"
    len = . - msg
    tam = 80
    buf: .space tam

.text
    .global _start
_start:
    /* Imprime el mensaje */
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

    xorl  %eax, %eax    
    pushl $buf          # Guardo la cadena en la pila

    call ascii_to_int   # Llamo a la subrutina

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
    movl  $10,      %edi

codificar:                  # Codificar cada caracter de la cadena
    movb (%ebx, %esi), %cl  
    cmpb $10,  %cl          # Comprobar si hemos llegado al final de la cadena
    je fin_codificar
    cmpb $0,   %cl
    je fin_codificar
    cmpb $'0', %cl          # Comprobar si el caracter leido es un valor numérico
    jb error
    cmpb $'9', %cl
    ja error
    
    andl  $0x0F, %ecx       # Conversión de numero en ascii a binario
    mull  %edi
    addl  %ecx,  %eax       # Hay overflow si:
    jc error                # CF = 1 tras sumar ecx y eax
    testl %edx,  %edx       # edx != 0 tras multiplicar eax por 10,
    jnz error               # es decir, que el rango del numero es mayor que 32 bits

    xorl  %ecx,  %ecx

    incl %esi
    jmp codificar

error:                      # En caso de overflow, devolver 0xFFFFFFFF
    movl $0xFFFFFFFF, %eax

fin_codificar:
    popl %ebx

    movl %ebp, %esp
    popl %ebp
    ret
