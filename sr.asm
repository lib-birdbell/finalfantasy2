
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


; Name	: Copy_num_tile
; Marks	:
;	  tile index 4Ch
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


; Name	: Swap_PRG_R6
; Marks	: It will move to BANK_1FSwap_PRG_R6:
	PHA	LDA #$06
	STA $8000
	PLA
	STA $8001
	RTS
; End of Swap_PRG_R6