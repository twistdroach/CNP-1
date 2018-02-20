CA=ca65
LD=ld65
MINIPRO=minipro

PGM=hello_world

SRC_DIR=src
OBJ_DIR=obj

ASM_SOURCES = $(notdir $(wildcard $(SRC_DIR)/*.s65))

all: rom

rom: $(ASM_SOURCES:%.s65=$(OBJ_DIR)/%.o)
	$(LD) -C cnp-1.cfg -v -vm -m $(PGM).map -o $(PGM).rom $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s65
	$(CA) -g -Iinclude/ -v -o $@ -l $(@:.o=.lst) $<

clean:
	rm -f $(OBJ_DIR)/*.o *.rom *.map $(OBJ_DIR)/*.lst

flash: clean all
	$(MINIPRO) -p at28c256 -w $(PGM).rom
