CA=ca65
LD=ld65
MINIPRO=minipro

PGM=hello_world

SRC_DIR=src
OBJ_DIR=obj

ASM_SOURCES = $(notdir $(wildcard $(SRC_DIR)/*.s65))

all: $(PGM)-cnp-1.rom $(PGM)-cnp-2.rom

$(PGM)-cnp-1.rom: $(ASM_SOURCES:%.s65=$(OBJ_DIR)/%.o)
	$(LD) -C cnp-1.cfg -v -Ln $(PGM).debug -vm -m $(PGM).map -o $(PGM)-cnp-1.rom $^

$(PGM)-cnp-2.rom: $(ASM_SOURCES:%.s65=$(OBJ_DIR)/%.o)
	$(LD) -C cnp-2.cfg -v -Ln $(PGM).debug -vm -m $(PGM).map -o $(PGM)-cnp-2.rom $^

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s65 | $(OBJ_DIR)
	$(CA) -g -Iinclude/ -v -o $@ -l $(@:.o=.lst) $<

clean:
	rm -f $(OBJ_DIR)/*.o *.debug *.rom *.map $(OBJ_DIR)/*.lst

flash-cnp-1: $(PGM)-cnp-1.rom
	$(MINIPRO) -p at28c256 -w $(PGM)-cnp-1.rom

flash-cnp-2: $(PGM)-cnp-2.rom
	$(MINIPRO) -p at28c256 -w $(PGM)-cnp-2.rom

.PHONY: flash-cnp-1 flash-cnp-2 clean all
