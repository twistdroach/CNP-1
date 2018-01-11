					.include "macros.asm"

					.zeropage
				R0:		.res 2
				TMP0:	.res 2

					.code
; Convert the 4-bit value of the accu into it's hex ascii character
; The hex ascii character is returned in the accu
fmt_hex_char:       cmp #10
                    bcc @less_then_10
@greater_then_10:   sec
                    sbc #10
                    clc
                    adc #'A'
                    rts
@less_then_10:      clc
                    adc #'0'
                    rts
					
; Format the value of the accu as a hex string
; The string is written into (R0)..(R0)+2 (3 bytes)
fmt_hex_string:     sta TMP0
                    phay
                    ldy #0
                    lda TMP0
                    lsr
                    lsr
                    lsr
                    lsr
                    jsr fmt_hex_char
                    sta (R0),y
                    iny
                    lda TMP0
                    and #$0f
                    jsr fmt_hex_char
                    sta (R0),y
                    iny
                    lda #0
                    sta (R0),y
                    play
                    rts