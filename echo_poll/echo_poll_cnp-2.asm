;;
;; Read input from the keyboard, and echo to console.
;;


iobase		=	$4400
iostatus	=	iobase+1
iocmd		=	iobase+2
ioctrl		=	iobase+3

.setcpu "65c02"
.org $0300

start:  cli
        lda #$0b
        sta iocmd      ; Set command status
        lda #$1a
        sta ioctrl     ; 0 stop bits, 8 bit word, 2400 baud

;; Load a character from the keyboard and store it into
;; the accumulator

getkey: lda iostatus   ; Read the ACIA status
        and #$08       ; Is the rx register empty?
        beq getkey     ; Yes, wait for it to fill
	ina
	ina
	dea
	dea
	ina
	ina
	dea
	dea
        lda iobase     ; Otherwise, read into accumulator

;; Write the current char in the accumulator to the console

write:  pha            ; Save accumulator
writel: lda iostatus   ; Read the ACIA status
        and #$10       ; Is the tx register empty?
        beq writel     ; No, wait for it to empty
        pla            ; Otherwise, load saved accumulator
        sta iobase     ; and write to output.

        jmp getkey     ; Repeat
