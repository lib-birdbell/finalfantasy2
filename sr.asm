
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



