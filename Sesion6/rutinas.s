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
    pushl %eax              # Guardamos eax en la pila

    pushl $1                # Guardamos los argumentos en la pila
    pushl $2147483647

    call suma               # LLamamos a la subrutina -> suma

    movl %eax,   %edi       # Guardo el resultado en edi

    addl $(2*4), %esp       # Limpio los argumetos de la pila y recupero eax
    popl %eax

    cmpl $-1,    %edi       # Si edi es -1, se imprime el msg de overflow
    jne comprobar_signo

    movl $4,    %eax
    movl $1,    %ebx
    movl $msg,  %ecx
    movl $len,  %edx
    int  $0x80

comprobar_signo:            # Se imprime si edi es positivo o negativo
    subl $0,   %edi         
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

finalizar:    # Cerramos el programa
    movl $0, %ebx
    movl $1, %eax
    int  $0x80

#---------------------------------------------------------
# int suma(int, int)
# Devuelve en un int la suma de 2 argumentos de tipo int
# o -1 en caso de desbordamiento
#---------------------------------------------------------
.type suma, @function
.global suma
suma:
    pushl %ebp                  # Preparamos la pila
    movl  %esp, %ebp

    pushl %ebx                  # Guardamos ebx ya que se va a utilizar

    movl 8(%ebp),   %eax        # Recupero los argumentos en eax y ebx
    movl 12(%ebp),  %ebx        
    addl %ebx,      %eax        # La suma de los argumentos se guarda en eax
    jno salir
    movl $-1,       %eax        # En caso de overflow, eax se pone a -1

salir:
    popl %ebx                   # Recupero el ebx de la pila

    movl  %ebp,  %esp           # Salimos de la subrutina
    popl  %ebp
    ret
