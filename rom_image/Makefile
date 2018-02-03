#ca65 -o testexec.o testexec.s65
#cl65 testexec.o --target none --start-addr 0x1000 -o test.o

CA=ca65
LD=ld65

PGM=hello_world
ASM_SOURCES = hello_world.s65 bios.s65 monitor.s65 osi_bas.s65 disasm.s65 hex_string_utils.s65 xmodem.s65 i2c.s65 i2c_keyboard.s65
all: rom

rom: $(ASM_SOURCES:.s65=.o)
	$(LD) -C cnp-1.cfg -vm -m $(PGM).map -o $(PGM).rom $^

%.o: %.s65
	$(CA) -o $@ -l $(@:.o=.lst) $<

clean:
	rm -f *.o *.rom *.map *.lst

flash: clean all
	minipro -p at28c256 -w $(PGM).rom
