main:
	as -o params.o -g params.s --32
	ld -melf_i386 -o params params.o
clean:
	rm params params.o