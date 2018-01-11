

                .setcpu "65c02"

				.include "io.asm"
				.include "monitor.asm"
				.include "bios.asm"

                 .segment "VECTORS"

                 .word   nmi
                 .word   reset
                 .word   irq

                 .code

reset:           jmp main

nmi:             rti

irq:             rti

main:
				 jsr initialize
				 
post:			 putsln "Executing memory test..."
				 puts "Testing page $05"
				 lda #$05
				 tax
				 jsr test_page

				 
				 lda #>scratch
				 sta R0+1
				 lda #<scratch
				 sta R0
loop:			 inx 						; move to next page
				 lda #$1B					; move cursor back 2 and print page
				 jsr write_char
				 puts "[2D"
				 txa
				 jsr fmt_hex_string
				 lda scratch
				 jsr write_char
				 lda scratch+1
				 jsr write_char
				 lda scratch+2
				 jsr write_char
				 txa
				 jsr test_page				; test page
				 ;;;no exit!
				 jmp loop
				 

				 

				 putsln " "

doit:			 putsln "Hello World!"
				; jmp doit

				.bss
scratch:		.res 3