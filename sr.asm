
; Number tile image 0-9
Number_tile:
.byte $3C,$7E,$FF,$FF,$FF,$FF,$7E,$3C,$00,$3C,$66,$66,$66,$66,$3C,$00	; '0'
.byte $18,$3C,$7C,$3C,$3C,$3C,$7E,$3C,$00,$18,$38,$18,$18,$18,$3C,$00	; '1'
.byte $3C,$7E,$FF,$FF,$7E,$7E,$FF,$7E,$00,$3C,$66,$66,$0C,$18,$7E,$00	; '2'
.byte $3C,$7E,$FF,$7E,$7F,$FF,$7E,$3C,$00,$3C,$66,$0C,$06,$66,$3C,$00	; '3'
.byte $0C,$1E,$3E,$7E,$FE,$FF,$7E,$0C,$00,$0C,$1C,$2C,$4C,$7E,$0C,$00	; '4'
.byte $7E,$FF,$FE,$FE,$7F,$FF,$7E,$3C,$00,$7E,$60,$7C,$06,$66,$3C,$00	; '5'
.byte $3C,$7E,$FF,$FE,$FF,$FF,$7E,$3C,$00,$3C,$60,$7C,$66,$66,$3C,$00	; '6'
.byte $7E,$FF,$FF,$7F,$1E,$3C,$78,$30,$00,$7E,$66,$06,$0C,$18,$30,$00	; '7'
.byte $3C,$7E,$FF,$7E,$FF,$FF,$7E,$3C,$00,$3C,$66,$3C,$66,$66,$3C,$00	; '8'
.byte $3C,$7E,$FF,$FF,$7F,$3F,$7E,$3C,$00,$3C,$66,$66,$3E,$06,$3C,$00	; '9'
.byte $00,$45,$EF,$FF,$FF,$FF,$EF,$45,$00,$00,$45,$6C,$55,$45,$45,$00	; "miss" half A
.byte $00,$00,$B6,$FF,$FE,$FF,$FE,$6C,$00,$00,$00,$36,$6C,$36,$6C,$00	; "miss" half B

;--------------------------------------------------------------------------------------

; Name	: Copy_num_tile
; Marks	: tile index 4Ch, 4Dh, 4Eh, 4Fh
Copy_num_tile:
	LDA #$04
	STA PpuAddr_2006
	LDA #$C0
	STA PpuAddr_2006
	LDY #$FF
Copy_num_tile_next:
	INY
	CPY #$04
	BEQ Copy_num_tile_end
	LDA $65,Y
	CMP #$FF
	BEQ Copy_num_tile_next
	ASL
	ASL
	ASL
	ASL
	TAX
Copy_num_tile_data_loop:
	LDA Number_tile,X
	STA PpuData_2007
	INX
	TXA
	AND #$0F
	BNE Copy_num_tile_data_loop
	BEQ Copy_num_tile_next
Copy_num_tile_end:
	RTS
; End of Copy_num_tile


;----------------------------------------------------
;	VERSION 3

bnc_cnt		= $40
num_leng_tmp	= $55
dmg_x_tmp	= $62
dmg_y_tmp	= $63

; Name	: Show_dmg(ver 3)
; Marks	: How to define enemy or character -> target(2Bh) bit.7
;	  enemy x,y is tile base(0-1Fh)
;	  character x,y is real(0-256)
;	  $40 = bounce counter
;	  $55 = damage number length
;	  $62 = x
;	  $63 = y
Show_dmg:
	JSR Get_length		; 8C51	20 AB 8D
	STX $55			; 8C54	86 55
	LDX #$4C
	STX $0231		; INDEX
	INX
	STX $0235
	INX
	STX $0239
	INX
	STX $023D
	LDX #$02		; ATTR
	STX $0232
	STX $0236
	STX $023A
	STX $023E
;Get y position
	LDY #$2B		; A8BB	$A0 $2B
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	PHA
	AND #$80
	BNE Show_dmg_enemy_y
	PLA			; player xy calcuration
	AND #$07		; will be changed to 03h ??
	TAX
	LDA $7BCE,X		; character y position
	CLC
	ADC #$10		; lower of character include dmg heights
	;ADC #$0A		; lower of character include dmg heights	default is -6
	STA dmg_y_tmp		; character y
	BNE Show_dmg_calc_x
Show_dmg_enemy_y:
	PLA
	AND #$07
	TAX
	LDA $7B92,X		; monster y position
	CLC
	ADC $7B82,X		; monster heights
	ASL
	ASL
	ASL
	SEC
	SBC #$08		; dmg heights
	;SBC #$0E		; dmg heights	default is -6
	STA dmg_y_tmp		; monster y
Show_dmg_calc_x:
; Get X position
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	PHA
	AND #$80
	BNE Show_dmg_enemy_x
	PLA
	AND #$07
	TAY
	LDX num_leng_tmp
	;LDA $7BD2,Y		; character x position (base)
	LDA $7BCA,Y		; character x position (current)
	CLC
	ADC #$08
Show_dmg_x_leng:
	SEC 
	SBC #$04
	DEX
	BNE Show_dmg_x_leng
	STA dmg_x_tmp		; character x
	BEQ Show_dmg_x
Show_dmg_enemy_x:
	PLA
	AND #$07
	TAY
	;JSR Get_length
	LDX num_leng_tmp
	LDA $7B9A,Y		; monster x position
	ASL
	CLC
	ADC $7B8A,Y		; monster widths = use half
	ASL
	ASL
Show_dmg_mob_x_leng:
	SEC 
	SBC #$04
	DEX
	BNE Show_dmg_mob_x_leng
	STA dmg_x_tmp		; monster x
Show_dmg_x:
	LDX num_leng_tmp
	STA $0233		; X
	DEX
	BEQ Show_dmg_y
	CLC
	ADC #$08
	STA $0237
	DEX
	BEQ Show_dmg_y
	CLC
	ADC #$08
	STA $023B
	DEX
	BEQ Show_dmg_y
	CLC
	ADC #$08
	STA $023F
Show_dmg_y:
	LDX num_leng_tmp
	LDA dmg_y_tmp
	SEC
	SBC #$06		; default is -6
	STA $0230		; Y
	DEX
	BEQ Show_dmg_ppu
	STA $0234
	DEX
	BEQ Show_dmg_ppu
	STA $0238
	DEX
	BEQ Show_dmg_ppu
	STA $023C
Show_dmg_ppu:
	JSR Wait_MENU_snd
	JSR Set_IRQ_JMP		; 980F	$20 $2A $FA	Wait NMI
	LDA #$02		; 9817	$A9 $02
	STA SpriteDma_4014	; 9819	$8D $14 $40
;palette copy - sprite 2, 1,3 color(0Fh = black, 30h = white, 2Ah = green)
	LDA #$3F
	STA PpuAddr_2006
	LDA #$19
	STA PpuAddr_2006
	LDA #$0F
	STA PpuData_2007
	STA PpuData_2007
	LDA #$30
	STA PpuData_2007
	JSR Copy_num_tile	; Copy number tile to PPU(direct)
	JSR Wait_NMI_end
	;move sprite
	LDX #$1F
	STX bnc_cnt		; loop counter
Show_dmg_bnc:
	JSR Wait_MENU_snd
	JSR Set_IRQ_JMP		; 980F	$20 $2A $FA	Wait NMI
	LDY num_leng_tmp
	LDX bnc_cnt
	LDA dmg_y_tmp
	SEC
	SBC Dmg_bnc,X
	STA $0230		; 8D 30 02 - 4	Y
	DEY
	BEQ Show_dmg_bnc_end
	STA $0234		; 8D 34 02 - 4
	DEY
	BEQ Show_dmg_bnc_end
	STA $0238		; 8D 38 02 - 4
	DEY
	BEQ Show_dmg_bnc_end
	STA $023C		; 8D 3C 02 - 4
Show_dmg_bnc_end:
	LDA #$02		; 9817	$A9 $02
	STA SpriteDma_4014	; 9819	$8D $14 $40
	JSR Wait_NMI_end
	DEC bnc_cnt
	BPL Show_dmg_bnc	; loop
	JSR Wait_MENU_snd
	JSR Set_IRQ_JMP		; 980F	$20 $2A $FA	Wait NMI
	LDY #$10		; 9059	$A0 $20		////debug
	JSR Wait		; 905B	$20 $9B $94	wait 16 frame////debug - to MENU
	;delete sprite
.if 0
	LDA #$FF		; A9 FF		- 2
	STA $0230		; 8D 30 02	- 4	Y
	STA $0234		; 8D 34 02	- 4
	STA $0238		; 8D 38 02	- 4
	STA $023C		; 8D 3C 02	- 4
	STA $0233		; 8D 33 02	- 4	X
	STA $0237		; 8D 37 02	- 4
	STA $023B		; 8D 3B 02	- 4
	STA $023F		; 8D 3F 02	- 4	total 26bytes 34 cycles
.endif
.if 0
	LDA #$FF		; A9 FF		- 2
	LDX #$0C		; A2 0C		- 2
Show_dmg_del:
	STA $0230,X		; 9D 30 02	- 4
	STA $0233,X		; 9D 33 02	- 4
	DEX			; CA		- 2
	DEX			; CA		- 2
	DEX			; CA		- 2
	DEX			; CA		- 2
	BPL Show_dmg_del	; 10 ??		- 2or3	total 16 bytes 72 cycles
.endif
.if 1
	LDA #$F0		; A9 FF		- 2
	LDX #$0F		; A2 0C		- 2
Show_dmg_del:
	STA $0230,X		; 9D 30 02	- 4
	DEX			; CA		- 2
	BPL Show_dmg_del	; 10 ??		- 2or3	total 10 bytes 148 cycles
.endif
	JSR Set_IRQ_JMP		; 980F	$20 $2A $FA	Wait NMI
	LDA #$02		; 9817	$A9 $02
	STA SpriteDma_4014	; 9819	$8D $14 $40

	RTS
; End of Show_dmg

;$8D8B
Dmg_bnc:
;.byte $06
;.byte $0C,$11,$16,$1A,$1A,$1D,$20,$20,$20,$1D,$1A,$16,$11,$0C,$06,$00
;.byte $01,$03,$04,$05,$06,$07,$07,$07,$07,$07,$06,$05,$04,$03,$01,$00
.byte $00,$01,$03,$04,$05,$06,$07,$07,$07,$07,$07,$06,$05,$04,$03,$01
.byte $00,$06,$0C,$11,$16,$1A,$1D,$20,$20,$20,$1D,$1A,$1A,$16,$11,$0C

; Name	: Get_length
; Ret	: X = length
; Marks	: 
Get_length:
	LDX #$04		; 8DAB	A2 04
	LDA $65			; 8DAD	A5 65
	CMP #$FF
	BNE Get_length_exit
	DEX
	LDA $66
	CMP #$FF
	BNE Get_length_exit
	DEX
	LDA $67
	CMP #$FF
	BNE Get_length_exit
	DEX
Get_length_exit:
	RTS
; End of Get_length

; Name	: Show_miss(ver 3)
; Marks	: ver3
Show_miss:
	LDX #$0A		; 8DC3	A2 0A
	STX $67			; 8DC5	86 67
	INX
	STX $68
	LDA #$FF
	STA $65
	STA $66
	JMP Show_dmg
; End of Show_miss


;----------------------------------------------------
;	VERSION 2


; Name	: Show_dmg(ver 2)
; Marks	: How to define enemy or character -> target(2Bh) bit.7
;	  $26 = turn order temp ??
;	  enemy x.y is tile base(0-1Fh)
;	  character x,y is real(0-256)
;	  $00 = string length
Show_dmg:
	LDX #$4C
	STX $0231		; INDEX
	INX
	STX $0235
	INX
	STX $0239
	INX
	STX $023D
Show_dmg_xy:
	LDY #$2B		; A8BB	$A0 $2B
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	PHA
	AND #$80
	BNE Show_dmg_enemy_y
	PLA
	AND #$07
	TAX
	LDA $7BCE,X
	BNE Show_dmg_y
Show_dmg_enemy_y:
	PLA
	AND #$07
	TAX
	LDA $7B92,X
	ASL
	ASL
	ASL
Show_dmg_y:
	STA $0230		; Y
	STA $0234
	STA $0238
	STA $023C
; Get X position
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	PHA
	AND #$80
	BNE Show_dmg_enemy_x
	PLA
	AND #$07
	TAX
	LDA $7BD2,X
	BNE Show_dmg_x
Show_dmg_enemy_x:
	PLA
	AND #$07
	TAX
	LDA $7B9A,X
	ASL
	ASL
	ASL
Show_dmg_x:
	STA $0233		; X
	CLC
	ADC #$08
	STA $0237
	CLC
	ADC #$08
	STA $023B
	CLC
	ADC #$08
	STA $023F
; Attribute
	LDA #$03		; ATTR
	STA $0232
	STA $0236
	STA $023A
	STA $023E
; calc length
	JSR Get_length
	CPX #$04
	BCS Show_dmg_ppu
	LDA #$FF
	STA $023C		; Y
	STA $023F		; X
	INX
	CPX #$04
	BCS Show_dmg_ppu
	STA $0238		; Y
	STA $023B		; X
	INX
	CPX #$04
	BCS Show_dmg_ppu
	STA $0234		; Y
	STA $0237		; X
	INX
	CPX #$04
	BCS Show_dmg_ppu
	STA $0230		; Y
	STA $0233		; X
Show_dmg_ppu:
	JSR Wait_MENU_snd
	JSR Set_IRQ_JMP		; 980F	$20 $2A $FA	Wait NMI
	LDA #$02		; 9817	$A9 $02
	STA SpriteDma_4014	; 9819	$8D $14 $40
	JSR Copy_num_tile
	JSR Wait_NMI_end
	RTS
; End of Show_dmg

; Name	: Get_length
; Ret	: X = length
; Marks	: $00 = digit count
Get_length:
	LDA $00
	PHA
	LDX #$04
	LDA $65
	CMP #$FF
	BNE Get_length_exit
	DEX
	LDA $66
	CMP #$FF
	BNE Get_length_exit
	DEX
	LDA $67
	CMP #$FF
	BNE Get_length_exit
	DEX
Get_length_exit:
	PLA
	STA $00
	RTS
; End of Get_length

; Name	: Show_miss(ver 2)
; Marks	: ver2
Show_miss:
	LDX #$4C		; INDEX
	STX $0231
	INX
	STX $0235
	LDX #$0A
	STX $67
	INX
	STX $68
	LDA #$FF
	STA $65
	STA $66
	JMP Show_dmg_xy
; End of Show_miss


;----------------------------------------------------
;	VERSION 1


; Name	: Show_dmg
; Marks	: How to define enemy or character
;	  $26 = turn order temp ??
;	  enemy x.y is tile base(0-1Fh)
;	  character x,y is real(0-256)
Show_dmg:
	LDA $65			;INDEX
	ORA #$80
	STA $0231
	LDA $66
	ORA #$80
	STA $0235
	LDA $67
	ORA #$80
	STA $0239
	LDA $68
	ORA #$80
	STA $023D
; Get XY position
Show_dmg_xy:
	LDY #$2B		; A8BB	$A0 $2B
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	PHA
	AND #$80
	BNE Show_dmg_enemy_y
	PLA
	AND #$07
	TAX
	LDA $7BCE,X
	BNE Show_dmg_y
Show_dmg_enemy_y:
	PLA
	AND #$07
	TAX
	LDA $7B92,X
	ASL
	ASL
	ASL
Show_dmg_y:
	STA $0230		; Y
	STA $0234
	STA $0238
	STA $023C
; Get X position
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	PHA
	AND #$80
	BNE Show_dmg_enemy_x
	PLA
	AND #$07
	TAX
	LDA $7BD2,X
	BNE Show_dmg_x
Show_dmg_enemy_x:
	PLA
	AND #$07
	TAX
	LDA $7B9A,X
	ASL
	ASL
	ASL
Show_dmg_x:
	STA $0233		; X
	CLC
	ADC #$08
	STA $0237
	CLC
	ADC #$08
	STA $023B
	CLC
	ADC #$08
	STA $023F
; Attribute
	LDA #$03		; ATTR
	STA $0232
	STA $0236
	STA $023A
	STA $023E
	JSR Wait_MENU_snd
	JSR Set_IRQ_JMP		; 980F	$20 $2A $FA	Wait NMI
	LDA #$02		; 9817	$A9 $02
	STA SpriteDma_4014	; 9819	$8D $14 $40
	JSR Wait_NMI_end
	RTS
; End of Show_dmg

; Name	: Show_miss
; Marks	:
Show_miss:
	LDA #$B0		; INDEX 'm'
	STA $0231
	LDA #$AC		; 'i'
	STA $0235
	LDA #$B6		; 's'
	STA $0239
	STA $023D
	JMP Show_dmg_xy
; End of Show_miss


;----------------------------------------------------


; Name	: Swap_PRG_R6
; Marks	: It will move to BANK_1FSwap_PRG_R6:
	PHA	LDA #$06
	STA $8000
	PLA
	STA $8001
	RTS
; End of Swap_PRG_R6


