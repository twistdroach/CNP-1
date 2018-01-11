#ca65 --listing test.lst -o bios.o bios.s65
#ca65 --listing hello_world.lst -o hello_world.o hello_world.s65
#ld65 -C cnp-1.cfg -vm -m hello_world.map -o test.rom hello_world.o bios.o

CA=ca65
LD=ld65

PGM=hello_world
ASM_SOURCES = hello_world.s65 bios.s65
all: rom

#$(PGM): $(PGM).o
#	$(LD) -C cnp-1.cfg -vm -m $(PGM).map -o $(PGM).rom $(PGM).o

#$(PGM).o:
#	$(CA) --listing $(PGM).lst -o $(PGM).o $(PGM).s65

rom: $(ASM_SOURCES:.s65=.o)
	$(LD) -C cnp-1.cfg -vm -m $(PGM).map -o $(PGM).rom $^

%.o: %.s65
	$(CA) -o $@ -l $(@:.o=.lst) $<

clean:
	rm -f *.o *.rom *.map *.lst

flash: clean all
	minipro -p at28c256 -w $(PGM).rom
