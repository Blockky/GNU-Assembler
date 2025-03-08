main:
	as -o cadena_mod.o -g cadena_mod.s --32
	ld -melf_i386 -o cadena_mod cadena_mod.o
clean: cadena_mod cadena_mod.o
	rm cadena_mod cadena_mod.o