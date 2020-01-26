CA=ca65
LD=ld65
MINIPRO=minipro

PGM=hello_world

SRC_DIR=src
OBJ1_DIR=obj-cnp-1
OBJ2_DIR=obj-cnp-2

ASM_SOURCES = $(notdir $(wildcard $(SRC_DIR)/*.s65))

all: $(PGM)-cnp-1.rom $(PGM)-cnp-2.rom

#TODO: Refactor and reduce all of this duplication!

$(PGM)-cnp-1.rom: $(ASM_SOURCES:%.s65=$(OBJ1_DIR)/%.o)
	$(LD) -C cnp-1.cfg -v -Ln $(PGM)-cnp-1.debug -vm -m $(PGM)-cnp-1.map -o $(PGM)-cnp-1.rom $^

$(PGM)-cnp-2.rom: $(ASM_SOURCES:%.s65=$(OBJ2_DIR)/%.o)
	$(LD) -C cnp-2.cfg -v -Ln $(PGM)-cnp-2.debug -vm -m $(PGM)-cnp-2.map -o $(PGM)-cnp-2.rom $^

$(OBJ1_DIR):
	mkdir -p $(OBJ1_DIR)

$(OBJ2_DIR):
	mkdir -p $(OBJ2_DIR)

$(OBJ1_DIR)/%.o: $(SRC_DIR)/%.s65 | $(OBJ1_DIR)
	$(CA) -DCNP1=1 -g -Iinclude/ -v -o $@ -l $(@:.o=.lst) $<

$(OBJ2_DIR)/%.o: $(SRC_DIR)/%.s65 | $(OBJ2_DIR)
	$(CA) -DCNP2=1 -g -Iinclude/ -v -o $@ -l $(@:.o=.lst) $<

clean:
	rm -f $(OBJ1_DIR)/*.o $(OBJ2_DIR)/*.o *.debug *.rom *.map $(OBJ1_DIR)/*.lst $(OBJ2_DIR)/*.lst

flash-cnp-1: $(PGM)-cnp-1.rom
	$(MINIPRO) -p at28c256 -w $(PGM)-cnp-1.rom

flash-cnp-2: $(PGM)-cnp-2.rom
	$(MINIPRO) -p at28c256 -w $(PGM)-cnp-2.rom

.PHONY: flash-cnp-1 flash-cnp-2 clean all
