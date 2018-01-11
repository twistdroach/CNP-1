.macro			puts string
				.scope
				jmp continue
text:			.asciiz string
continue:
				lda #>text
				ldy #<text
				jsr write_buffer
				.endscope
.endmacro

.macro			putsln string
				.scope
				jmp continue
text:			.asciiz string
continue:
				lda #>text
				ldy #<text
				jsr write_bufferln
				.endscope
.endmacro

				.zeropage
				
      			BUFADR:	.res 2			;scratchpad/address buffer for bios calls
      			POSTADR: .res 2			;scratchpad for post calls

				.code

initialize:
;;;;;;machine specific
init_acia:       lda #%00001011				;No parity, no echo, no interrupt
                 sta ACIA_COMMAND
                 lda #%00011111				;1 stop bit, 8 data bits, 19200 baud
                 sta ACIA_CONTROL
                 rts

;;;;;;;;;;;;;;;;;;;;;;;;;; POST ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.proc test_page							;test a page of memory
				sta POSTADR+1				;A should hold page to test
				ldy #$00
				sty POSTADR
				
				lda #$FF						;A holds test pattern
				jsr test_page_w_pattern		;test page
				lda #$AA
				jsr test_page_w_pattern
				lda #$55
				jsr test_page_w_pattern
				lda #$00
				jsr test_page_w_pattern
				rts
				
				
test_page_w_pattern:	ldy #$FF			; Start at top of page
fill_loop:				sta (POSTADR),y		; fill page with pattern
						dey
						bne fill_loop
						ldy #$FF			 
compare_loop:			cmp (POSTADR),y		; compare page with pattern
						bne error
						dey
						beq success
						jmp compare_loop
						
success:				;puts "Ok"
						rts

error:					puts "Error"
error_hang:				jmp error_hang
						rts

.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;; text output routine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.proc write_bufferln
				jsr write_buffer
				lda #>lf
				ldy #<lf
				jsr write_buffer
				rts

lf:				.byte $0d,$0a,$00
.endproc

.proc write_buffer							;output a \0 terminated string to the user
				sta	BUFADR+1				;A/Y should hold pointer to string
				sty BUFADR
				ldy #0
write_loop:		
				lda (BUFADR),y
				beq exit
				jsr write_char
				iny
				jmp write_loop

exit:			rts
.endproc

;;;;machine specific
.proc write_char
				sta ACIA_DATA				; write a single character, machine dependent
wait_txd_empty:	lda ACIA_STATUS				; A should contain char
				and #$10
				beq wait_txd_empty
				rts
.endproc