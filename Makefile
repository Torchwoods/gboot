all:start.o
	arm-linux-ld -Tgboot.lds -o gboot.elf $^
	arm-linux-objcopy -O binary gboot.elf gboot.bin
%.o:%.S
	arm-linux-gcc -g -c $^
%.o:%.c
	arm-linux-gcc -g -c $^
dump:gboot.elf
	arm-linux-objdump -D -S gboot.elf >$@
.PHONY:clean
clean:
	rm *.o *.elf *.bin dump
