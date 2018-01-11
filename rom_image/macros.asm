; Push A and X, destroys A
.macro phax
  pha
  txa
  pha
.endmacro

; Push A and Y, destroys A
.macro phay
  pha
  tya
  pha
.endmacro

; Push A, X and Y, destroys A
.macro phaxy
  pha
  txa
  pha
  tya
  pha
.endmacro

; Pull A and X
.macro plax
  pla
  tax
  pla
.endmacro

; Pull A and Y
.macro play
  pla
  tay
  pla
.endmacro

; Pull A, X and Y
.macro plaxy
  pla
  tay
  pla
  tax
  pla
.endmacro

; Load zero page register reg/reg+1 with the 16-bit value, destroys A
.macro ld16 reg, value
  lda #<(value)
  sta reg
  lda #>(value)
  sta reg + 1
.endmacro