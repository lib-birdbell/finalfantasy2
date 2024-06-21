.include "Constants.inc"
.include "variables.inc"

.import	Init_Page2		;C46E
.import Check_savefile		;DAC1
.import SndE_cur_sel		;DB2E
.import SndE_cur_mov		;DB45
.import Get_key			;DBA9
.import Palette_copy		;DC30
.import	Set_cursor		;DEA1
.import Init_CHR_RAM		;E491		
.import Clear_Nametable0	;F321
.import Wait_NMI		;FE00
.import	Init_variables		;FFB0


.segment "BANK_0E"

; ========== item prices (256 * 2) START ==========

;; [$8000 :: 0x38000]
; Price to sell xx (2bytes 128 + 64 ??)
.byte $00,$00,$01,$00,$02,$00,$03,$00,$04,$00,$05,$00,$06,$00,$07,$00
.byte $08,$00,$09,$00,$0A,$00,$0B,$00,$0C,$00,$0D,$00,$0E,$00,$0F,$00
; Potion(0x10), Antidote, Gold pin
.byte $19,$00,$64,$00,$E2,$04,$F4,$01,$E2,$04,$E8,$03,$32,$00,$C4,$09
; xx, xx, Hi-potion(0x1A)
.byte $A8,$61,$E2,$04,$FA,$00,$C4,$09,$A0,$0F,$A0,$0F,$32,$00,$F4,$01
.byte $F4,$01,$88,$13,$88,$13,$90,$01,$FA,$00,$DC,$05,$2C,$01,$A0,$0F
.byte $2C,$01,$2C,$01,$90,$01,$FA,$00,$F4,$01,$F4,$01,$96,$00,$00,$00
.byte $00,$00,$19,$00,$64,$00,$FA,$00,$F4,$01,$C4,$09,$C4,$09,$A0,$0F
.byte $4C,$1D,$20,$4E,$4B,$00,$C8,$00,$90,$01,$EE,$02,$DC,$05,$A0,$0F
.byte $70,$17,$7D,$00,$FA,$00,$EE,$02,$DC,$05,$C4,$09,$A0,$0F,$88,$13
.byte $70,$17,$4C,$1D,$96,$00,$FA,$00,$EE,$02,$C4,$09,$88,$13,$4C,$1D
.byte $10,$27,$98,$3A,$20,$4E,$C8,$00,$2C,$01,$84,$03,$E2,$04,$D0,$07
.byte $C4,$09,$A0,$0F,$88,$13,$88,$13,$4C,$1D,$10,$27,$D4,$30,$E8,$FD
.byte $40,$9C,$FA,$00,$90,$01,$E8,$03,$F4,$01,$4C,$1D,$10,$27,$A8,$61
.byte $4B,$00,$7D,$00,$F4,$01,$DC,$05,$C4,$09,$C4,$09,$4C,$1D,$D4,$30
.byte $28,$00,$64,$00,$96,$00,$2C,$01,$F4,$01,$C4,$09,$10,$27,$19,$00
.byte $2C,$01,$88,$13,$0A,$00,$32,$00,$C8,$00,$F4,$01,$E2,$04,$C4,$09

;; [$8100 :: 0x38100]

.byte $88,$13,$88,$13,$10,$27,$F4,$7E,$98,$3A,$64,$00,$C8,$00,$90,$01
.byte $F4,$01,$E8,$03,$C4,$09,$C4,$09,$19,$00,$E2,$04,$19,$00,$96,$00
.byte $90,$01,$F4,$01,$E8,$03,$C4,$09,$A0,$0F,$10,$27,$C4,$09,$C4,$09
.byte $64,$00,$64,$00,$64,$00,$E8,$03,$4C,$1D,$4C,$1D,$20,$4E,$A0,$0F
.byte $A0,$0F,$A0,$0F,$88,$13,$D0,$07,$A0,$0F,$88,$13,$88,$13,$88,$13
.byte $EE,$02,$88,$13,$10,$27,$4C,$1D,$32,$00,$EE,$02,$90,$01,$90,$01
.byte $A0,$0F,$C8,$00,$C8,$00,$C8,$00,$A0,$0F,$DC,$05,$DC,$05,$90,$01
.byte $EE,$02,$DC,$05,$DC,$05,$A0,$0F,$90,$01,$10,$27,$EE,$02,$01,$00

;buying table
;$38190 - $3820F
;2 bytes each, 128 bytes total (64 item price)
.byte $02,$00,$04,$00,$05,$00,$08,$00,$0A,$00,$0F,$00,$14,$00,$1E,$00
.byte $28,$00,$32,$00,$50,$00,$64,$00,$7D,$00,$96,$00,$C8,$00,$FA,$00
.byte $E8,$03,$E8,$03,$D0,$07,$E8,$03,$2C,$01,$1E,$00,$0A,$00,$C8,$00
.byte $32,$00,$01,$00,$90,$01,$64,$00,$96,$00,$00,$00,$00,$00,$00,$00
.byte $98,$3A,$20,$4E,$A8,$61,$30,$75,$40,$9C,$50,$C3,$14,$00,$E8,$FD
.byte $00,$00,$32,$00,$50,$00,$64,$00,$00,$00,$96,$00,$C8,$00,$FA,$00
.byte $2C,$01,$90,$01,$F4,$01,$58,$02,$20,$03,$E8,$03,$DC,$05,$08,$07
.byte $D0,$07,$C4,$09,$B8,$0B,$A0,$0F,$88,$13,$40,$1F,$10,$27,$E0,$2E
;End of buying table
; ========== item prices (256 * 2) END ==========


; ========== pointers to npc scripts ($8200-$837F) START ==========
;; [$8200 :: 0x38200]

.byte $82,$83,$82,$83,$97,$83,$98,$83,$9C,$83,$9F,$83,$B5,$83,$B7,$83
.byte $C0,$83,$C4,$83,$CB,$83,$CD,$83,$D4,$83,$D5,$83,$DC,$83,$DD,$83
.byte $EA,$83,$EC,$83,$ED,$83,$F5,$83,$00,$84,$01,$84,$01,$84,$02,$84
.byte $03,$84,$09,$84,$0F,$84,$11,$84,$13,$84,$14,$84,$17,$84,$19,$84
.byte $1B,$84,$25,$84,$26,$84,$29,$84,$2A,$84,$2C,$84,$34,$84,$36,$84
.byte $37,$84,$37,$84,$37,$84,$37,$84,$39,$84,$3A,$84,$3B,$84,$3D,$84
.byte $3F,$84,$41,$84,$44,$84,$48,$84,$49,$84,$4E,$84,$54,$84,$56,$84
.byte $57,$84,$5A,$84,$5E,$84,$60,$84,$63,$84,$65,$84,$67,$84,$6A,$84
.byte $6C,$84,$70,$84,$71,$84,$72,$84,$73,$84,$74,$84,$77,$84,$7D,$84
.byte $7E,$84,$80,$84,$82,$84,$84,$84,$86,$84,$88,$84,$89,$84,$95,$84
.byte $95,$84,$96,$84,$97,$84,$97,$84,$98,$84,$9A,$84,$9B,$84,$9C,$84
.byte $A3,$84,$AC,$84,$AE,$84,$AF,$84,$B0,$84,$B1,$84,$B2,$84,$B4,$84
.byte $B6,$84,$BF,$84,$C8,$84,$D1,$84,$DA,$84,$E3,$84,$EC,$84,$F5,$84
.byte $FE,$84,$07,$85,$10,$85,$19,$85,$22,$85,$2B,$85,$2E,$85,$31,$85
.byte $34,$85,$3F,$85,$42,$85,$45,$85,$48,$85,$53,$85,$5E,$85,$69,$85
.byte $6C,$85,$6F,$85,$72,$85,$72,$85,$72,$85,$7D,$85,$80,$85,$83,$85

;; [$8300 :: 0x38300]

.byte $86,$85,$86,$85,$86,$85,$89,$85,$8C,$85,$8F,$85,$92,$85,$95,$85
.byte $98,$85,$9A,$85,$9C,$85,$9E,$85,$A0,$85,$A4,$85,$A8,$85,$AC,$85
.byte $B0,$85,$B1,$85,$B2,$85,$B3,$85,$B4,$85,$B5,$85,$B6,$85,$B7,$85
.byte $B8,$85,$BC,$85,$C0,$85,$C4,$85,$C8,$85,$CC,$85,$D0,$85,$D4,$85
.byte $D8,$85,$DC,$85,$E0,$85,$E4,$85,$E8,$85,$EC,$85,$F0,$85,$F0,$85
.byte $F0,$85,$F0,$85,$F0,$85,$F1,$85,$F2,$85,$F3,$85,$F4,$85,$F4,$85
.byte $F5,$85,$F6,$85,$F7,$85,$F8,$85,$F9,$85,$FA,$85,$FB,$85,$FC,$85
.byte $FD,$85,$FF,$85,$01,$86,$03,$86,$05,$86,$07,$86,$09,$86,$0B,$86
; ========== pointers to npc scripts ($8200-$837F) END ==========

; ========== pointers to shop/ferry data ($8380-$8381) ==========
.byte $0D,$86

; ========== npc scripts ($8382-$860C) START ==========
.byte $01,$02,$03,$05,$06,$12,$07,$09,$08,$0A,$0B,$FD,$0C,$0D
.byte $0E,$0F,$10,$11,$13,$14,$04,$15,$16,$17,$0A,$FD,$18,$19,$1A,$1B
.byte $1C,$1D,$1E,$1F,$20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B
.byte $2C,$2D,$2E,$2F,$30,$F6,$6C,$86,$87,$88,$88,$89,$8A,$8B,$8C,$88
.byte $31,$32,$FC,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$12,$3C,$3D,$3E
.byte $3F,$40,$FB,$41,$42,$43,$44,$45,$46,$47,$47,$48,$49,$4A,$4B,$4C
.byte $4D,$4E,$4F,$50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5C,$5D
.byte $5E,$5F,$60,$61,$5B,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C

;; [$8400 :: 0x38400]

.byte $6D,$6E,$6F,$70,$70,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$E1
.byte $73,$E2,$08,$71,$E3,$0D,$FD,$FA,$7A,$FA,$7B,$7C,$7D,$7E,$7F,$80
.byte $81,$82,$83,$84,$85,$8F,$90,$91,$92,$93,$94,$71,$95,$95,$95,$FC
.byte $96,$97,$98,$99,$8D,$19,$8C,$FF,$E4,$E5,$E6,$FE,$E7,$FA,$7C,$9A
.byte $9B,$FC,$9C,$9D,$CB,$CC,$CD,$6E,$E8,$9E,$9F,$A0,$A1,$A2,$C7,$C7
.byte $C7,$C8,$C9,$CA,$E9,$EA,$DF,$FF,$D1,$D2,$D3,$D4,$D5,$09,$FF,$EB
.byte $D6,$D7,$D8,$CD,$6E,$EC,$0B,$ED,$0C,$FD,$F7,$17,$DB,$18,$DC,$DD
.byte $B3,$B4,$B5,$B6,$FF,$B7,$10,$CE,$CF,$FF,$CE,$D0,$0E,$E0,$F3,$6F
.byte $F4,$70,$F5,$72,$F8,$75,$F9,$79,$EE,$BB,$BC,$BD,$BE,$BF,$C0,$C1
.byte $C2,$C3,$C4,$C5,$C6,$F0,$F1,$DE,$00,$A5,$A3,$A4,$A6,$A7,$A8,$A8
.byte $A9,$AA,$AB,$AC,$AD,$AD,$AE,$AF,$B0,$FC,$B1,$B2,$D9,$DA,$FE,$FE
.byte $EF,$B8,$B9,$BA,$CD,$6E,$01,$0F,$27,$42,$54,$34,$3A,$66,$78,$02
.byte $10,$28,$43,$55,$34,$3A,$67,$79,$03,$11,$29,$44,$56,$34,$3A,$68
.byte $7A,$04,$12,$2A,$45,$57,$35,$3B,$69,$7B,$05,$13,$2B,$46,$58,$34
.byte $3A,$6A,$7C,$06,$14,$2C,$47,$59,$34,$3A,$6B,$7D,$07,$15,$2D,$48
.byte $5A,$36,$3C,$6C,$7E,$00,$00,$2E,$49,$5B,$36,$3D,$6D,$7F,$00,$00

;; [$8500 :: 0x38500]

.byte $2F,$4A,$5C,$35,$3B,$6E,$80,$00,$00,$30,$4B,$5D,$34,$3A,$6F,$81
.byte $00,$00,$00,$4C,$5E,$34,$3A,$70,$82,$00,$00,$00,$4D,$5F,$36,$3C
.byte $71,$83,$00,$00,$00,$4E,$60,$36,$3D,$72,$84,$08,$16,$31,$09,$17
.byte $32,$0A,$18,$33,$0B,$19,$19,$4F,$61,$37,$3E,$73,$85,$8A,$8F,$0C
.byte $1A,$1A,$0D,$1B,$1B,$0E,$1C,$1C,$00,$1D,$1D,$50,$62,$38,$3F,$74
.byte $86,$8B,$90,$00,$1E,$1E,$51,$63,$38,$3F,$75,$87,$8C,$91,$00,$1F
.byte $1F,$52,$64,$38,$3F,$76,$88,$8D,$92,$00,$20,$20,$00,$21,$21,$00
.byte $22,$22,$00,$23,$23,$53,$65,$39,$40,$77,$89,$8E,$93,$00,$24,$24
.byte $00,$25,$25,$00,$26,$26,$94,$97,$41,$95,$96,$FD,$00,$96,$FD,$00
.byte $97,$FE,$00,$98,$FE,$00,$99,$E2,$9A,$9B,$9A,$9C,$9A,$9D,$9A,$9E
.byte $9A,$9F,$A3,$A7,$9A,$A0,$A4,$A8,$9A,$A1,$A5,$A9,$9A,$A2,$A6,$AA
.byte $AB,$AC,$AD,$AE,$AF,$B0,$B1,$B2,$B3,$C1,$CB,$D5,$B4,$C2,$CC,$D6
.byte $B5,$C3,$CD,$D7,$B6,$C4,$CE,$D8,$B7,$C5,$CF,$D9,$B8,$C6,$D0,$DA
.byte $B9,$C7,$D1,$DB,$BA,$C8,$D2,$DC,$BB,$C9,$D3,$DD,$BC,$CA,$D4,$DE
.byte $BD,$BD,$BD,$BD,$BE,$BE,$BE,$BE,$BF,$BF,$BF,$BF,$C0,$C0,$C0,$C0
.byte $DF,$E0,$FC,$E1,$E3,$E4,$E5,$E6,$E7,$EB,$E9,$EA,$E8,$EC,$F4,$ED

;; [$8600 :: 0x38600]

.byte $F5,$EE,$F6,$EF,$F7,$F0,$F8,$F1,$F9,$F2,$FA,$F3,$FB
; ========== npc scripts ($8382-$860C) END ==========

; ========== shop/ferry data (32 * 8 bytes) ($860D-$86FE) START ==========
; Actually 28 * 8
; item1 price1 item2 price2 item3 price3 item4 price4
; [$860D-$8614] Altea weapon shop
.byte $3A,$ED,$41,$EF,$4A,$F0,$53,$F1
; [$8615-$861C] Altea armor shop
.byte $31,$E9,$70,$EA,$7A,$E6,$8E,$E9
; [$861D-$8624] Altea magic shop
.byte $98,$F1,$99,$F1,$9A,$F1,$AC,$EE
; [$8625-$862C] Altea mithril weapon shop
.byte $3C,$F4,$43,$F6,$4C,$F6,$55,$F7
; [$862D-$8634] Altea mithril armor shop
.byte $33,$F2,$72,$F0,$7D,$F5,$90,$F4
; [$8635-$863C] Gatea weapon shop
.byte $4A,$F0,$53,$F1,$61,$F2,$68,$ED
; [$863D-$8644] Gatea armor shop
.byte $31,$E9,$70,$EA,$7B,$EB,$8E,$E9
; [$8645-$864C] Poft weapon shop
.byte $3B,$F1,$42,$F2,$61,$F2,$68,$ED
; [$864D-$8654] Poft armor shop
.byte $32,$EE,$71,$EE,$85,$EE,$8F,$F0
; [$865D-$865C] Poft magic shop
.byte $AC,$EE,$B1,$F1,$B2,$F1,$B3,$F1
; [$865D-$8664] Unknown mithril weapon shop
.byte $4C,$F6,$55,$F7,$63,$F8,$6A,$F5
; [$866D-$866C] Salamando weapon shop
.byte $42,$F2,$54,$F3,$62,$F4,$69,$EF
; [$866D-$8674] Salamando armor shop
.byte $32,$EE,$71,$EE,$7C,$F1,$8F,$F0
; [$867D-$867C] Salamando magic shop
.byte $AD,$F6,$B8,$F6,$A8,$F6,$BE,$F6
; [$867D-$8684] Bofsk weapon shop
.byte $3B,$F1,$4B,$F2,$54,$F3,$69,$EF
; [$868D-$868C] Bofsk armor shop
.byte $32,$EE,$71,$EE,$86,$F1,$8F,$F0
; [$868D-$8694] Bofsk magic shop
.byte $BC,$F4,$AE,$F4,$AF,$F4,$B7,$F4
; [$869D-$869C] Phin weapon shop
.byte $44,$FA,$4D,$FC,$58,$FC,$6C,$FC
; [$869D-$86A4] Phin armor shop
.byte $34,$F5,$73,$F3,$7E,$F9,$88,$F5
; [$86AD-$86AC] Phin magic shop
.byte $B5,$FA,$B6,$FA,$B9,$FA,$BA,$FA
; [$86AD-$86B4] Mysidia weapon shop
.byte $46,$FD,$4F,$E0,$65,$E0,$6D,$FC
; [$86BD-$86BC] Mysidia armor shop
.byte $35,$FC,$7F,$FC,$91,$F5,$92,$F8
; [$86BD-$86C4] Mysidia magic shop
.byte $B0,$FD,$B4,$FD,$BB,$FD,$BD,$E1
; [$86CD-$86CC] Tropical Island
.byte $64,$FE,$4E,$FE,$87,$F4,$1D,$FD
; [$86CD-$86D4, $86D5-$86DC, $86DD-$86E4] All three item shop
.byte $10,$E9,$1A,$F2,$16,$EB,$11,$EE
.byte $13,$F5,$15,$F8,$14,$F9,$12,$F9
.byte $17,$FC,$19,$F9,$1B,$FC,$18,$E5
; [$86E5-$86EC] Jade passage
.byte $A7,$FE,$A9,$FE,$AA,$E1,$9E,$E4
; [$86ED-$86FE] ????
.byte $AD,$3C,$64,$00,$7C,$23,$C8,$00
.byte $6C,$2C,$2C,$01,$C7,$70,$90,$01
.byte $20,$00
; ========== shop/ferry data (32 * 8 bytes) ($860D-$86FE) END ==========

; ========== stale/unused data ($86FF-$87FF) START ==========
.byte $EB
;; [$8700 :: 0x38700]

.byte $8E,$E9,$3B,$F1,$42,$F2,$61,$F2,$68,$ED,$32,$EE,$71,$EE,$85,$EE
.byte $8F,$F0,$AC,$EE,$B1,$F1,$B2,$F1,$B3,$F1,$4C,$F6,$55,$F7,$63,$F8
.byte $6A,$F5,$42,$F2,$54,$F3,$62,$F4,$69,$EF,$32,$EE,$71,$EE,$7C,$F1
.byte $8F,$F0,$AD,$F6,$B8,$F6,$A8,$F6,$BE,$F6,$3B,$F1,$4B,$F2,$54,$F3
.byte $69,$EF,$32,$EE,$71,$EE,$86,$F1,$8F,$F0,$BC,$F4,$AE,$F4,$AF,$F4
.byte $B7,$F4,$44,$FA,$4D,$FC,$58,$FC,$6C,$FC,$34,$F5,$73,$F3,$7E,$F9
.byte $88,$F5,$B5,$FA,$B6,$FA,$B9,$FA,$BA,$FA,$46,$FD,$4F,$E0,$65,$E0
.byte $6D,$FC,$35,$FC,$7F,$FC,$91,$F5,$92,$F8,$B0,$FD,$B4,$FD,$BB,$FD
.byte $BD,$E1,$64,$FE,$4E,$FE,$87,$F4,$1D,$FD,$10,$E9,$1A,$F2,$16,$EB
.byte $11,$EE,$13,$F5,$15,$F8,$14,$F9,$12,$FC,$17,$FC,$19,$F9,$1B,$F5
.byte $18,$E5,$A7,$FE,$A9,$FE,$AA,$E1,$9E,$E4,$AD,$3C,$64,$00,$7C,$23
.byte $C8,$00,$6C,$2C,$2C,$01,$C7,$70,$90,$01,$20,$00,$00,$00,$00,$00
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
; ========== stale/unused data ($86FF-$87FF) END ==========


; ========== MAP/MENU CODE START($8800-$C000) ==========
;; [$8800 :: 0x38800]

; Name	:
; Marks	: draw portait (main menu)
	LDX #$00		; 8800	$A2 $00
	LDA #$14		; 8802	$A9 $14
	STA $40			; 8804	$85 $40
	LDA #$0F		; 8806	$A9 $0F
	STA $41			; 8808	$85 $41
	JSR $8852		; 880A	$20 $52 $88	draw portrait
	LDX #$40		; 880D	$A2 $40
	LDA #$84		; 880F	$A9 $84
	STA $40			; 8811	$85 $40
	LDA #$0F		; 8813	$A9 $0F
	STA $41			; 8815	$85 $41
	JSR $8852		; 8817	$20 $52 $88	draw portrait
	LDX #$80		; 881A	$A2 $80
	LDA #$24		; 881C	$A9 $24
	STA $40			; 881E	$85 $40
	LDA #$5F		; 8820	$A9 $5F
	STA $41			; 8822	$85 $41
	JSR $8852		; 8824	$20 $52 $88	draw portrait
	LDX #$C0		; 8827	$A2 $C0
	LDA #$94		; 8829	$A9 $94
	STA $40			; 882B	$85 $40
	LDA #$5F		; 882D	$A9 $5F
	STA $41			; 882F	$85 $41
	BNE L38852		; 8831	$D0 $1F		draw portrait
; Marks	: draw portrait (equip/magic menu)
	LDA #$0F		; 8833	$A9 $0F
	STA $41			; 8835	$85 $41
	LDA #$64		; 8837	$A9 $64
	STA $40			; 8839	$85 $40
	BNE L38852		; 883B	$D0 $15		draw portrait
; Name	:
; Marks	: draw portrait (stats menu)
	LDA #$14		; 883D	$A9 $14
	STA $40			; 883F	$85 $40
	LDA #$0F		; 8841	$A9 $0F
	STA $41			; 8843	$85 $41
	BNE L38852		; 8845	$D0 $0B		draw portrait
; Name	:
; Marks	:
	LDA #$44		; 8847	$A9 $44
	STA $40			; 8849	$85 $40
	LDA #$1F		; 884B	$A9 $1F
	STA $41			; 884D	$85 $41
	BNE L38857		; 884F	$D0 $06		must go to ??
L38851:
	RTS			; 8851	$60
; End of

; X	:
; Marks	: draw potrait
L38852:
	LDA $6235,X		; 8852	$BD $35 $62
	BMI L38851		; 8855	$30 $FA
; X	:
; Marks	:
;	  OAM copy to buffer ?? Set character potrait ??
L38857:
	LDY #$0B		; 8857	$A0 $0B
	LDA $6101,X		; 8859	$BD $01 $61
	ASL A			; 885C	$0A
	BCS L3886D		; 885D	$B0 $0E
	DEY			; 885F	$88
	ASL A			; 8860	$0A
	BCS L3886D		; 8861	$B0 $0A
	DEY			; 8863	$88
	ASL A			; 8864	$0A
	BCS L3886D		; 8865	$B0 $06
	LDA ch_stats,X		; 8867	$BD $00 $61
	AND #$0F		; 886A	$29 $0F		character ID(00h) to max mp(0Fh)
	TAY			; 886C	$A8
L3886D:
	LDA $890B,Y		; 886D	$B9 $0B $89
	STA cur_oam_tbl		; 8870	$85 $80
	LDA $6101,X		; 8872	$BD $01 $61	character status ??
	AND #$A0		; 8875	$29 $A0
	BEQ L38885		; 8877	$F0 $0C
	AND #$80		; 8879	$29 $80
	BEQ L38881		; 887B	$F0 $04
	LDA #$3C		; 887D	$A9 $3C
	BNE L3888D		; 887F	$D0 $0C
L38881:
	LDA #$30		; 8881	$A9 $30
	BNE L3888D		; 8883	$D0 $08
L38885:
	TXA			; 8885	$8A
	ASL A			; 8886	$0A
	ROL A			; 8887	$2A
	ROL A			; 8888	$2A
	TAX			; 8889	$AA
	LDA $8917,X		; 888A	$BD $17 $89
L3888D:
	STA cur_idx_base	; 888D	$85 $82
	LDX $26			; 888F	$A6 $26
	LDA oam_x		; 8891	$A5 $40
	STA $0203,X		; 8893	$9D $03 $02	X
	STA $020F,X		; 8896	$9D $0F $02
	STA $021B,X		; 8899	$9D $1B $02
	STA $0227,X		; 889C	$9D $27 $02
	CLC			; 889F	$18
	ADC #$08		; 88A0	$69 $08
	STA $0207,X		; 88A2	$9D $07 $02
	STA $0213,X		; 88A5	$9D $13 $02
	STA $021F,X		; 88A8	$9D $1F $02
	STA $022B,X		; 88AB	$9D $2B $02
	CLC			; 88AE	$18
	ADC #$08		; 88AF	$69 $08
	STA $020B,X		; 88B1	$9D $0B $02
	STA $0217,X		; 88B4	$9D $17 $02
	STA $0223,X		; 88B7	$9D $23 $02
	STA $022F,X		; 88BA	$9D $2F $02
	LDA oam_y		; 88BD	$A5 $41
	STA $0200,X		; 88BF	$9D $00 $02	Y
	STA $0204,X		; 88C2	$9D $04 $02
	STA $0208,X		; 88C5	$9D $08 $02
	CLC			; 88C8	$18
	ADC #$08		; 88C9	$69 $08
	STA $020C,X		; 88CB	$9D $0C $02
	STA $0210,X		; 88CE	$9D $10 $02
	STA $0214,X		; 88D1	$9D $14 $02
	CLC			; 88D4	$18
	ADC #$08		; 88D5	$69 $08          
	STA $0218,X		; 88D7	$9D $18 $02       
	STA $021C,X		; 88DA	$9D $1C $02       
	STA $0220,X		; 88DD	$9D $20 $02       
	CLC			; 88E0	$18
	ADC #$08		; 88E1	$69 $08
	STA $0224,X		; 88E3	$9D $24 $02
	STA $0228,X		; 88E6	$9D $28 $02
	STA $022C,X		; 88E9	$9D $2C $02
	LDY #$00		; 88EC	$A0 $00          
L388EE:
	TYA			; 88EE	$98
	CLC			; 88EF	$18
	ADC cur_idx_base	; 88F0	$65 $82
	STA $0201,X		; 88F2	$9D $01 $02	INDEX
	LDA cur_oam_tbl		; 88F5	$A5 $80
	STA $0202,X		; 88F7	$9D $02 $02	ATTR
	INX			; 88FA	$E8
	INX			; 88FB	$E8
	INX			; 88FC	$E8
	INX			; 88FD	$E8
	INY			; 88FE	$C8
	CPY #$0C		; 88FF	$C0 $0C
	BCC L388EE		; 8901	$90 $EB		loop
	LDA $26			; 8903	$A5 $26
	CLC			; 8905	$18
	ADC #$30		; 8906	$69 $30          
	STA $26			; 8908	$85 $26          
	RTS			; 890A	$60
; End of

; data block = portrait palette id
; [$890B- cur_oam_tbl
.byte $02,$00,$01,$01,$01
.byte $02,$00,$00,$01,$01,$03,$01
; [$8917- cur_idx_base
.byte $00,$0C,$18,$24,$30,$3C,$48,$54,$60
.byte $6C,$78,$84,$90

;----------------------------------------------------------------------

; Name	:
; Marks	: decode character strings $20-
	PHA 			; 8924: 48        
	SEC                     ; 8925: 38        
	SBC #$20                ; 8926: E9 20     
	TAX                     ; 8928: AA        
	CMP #$10                ; 8929: C9 10     
	BCC L38942               ; 892B: 90 15     
; $30-
	SBC #$10                ; 892D: E9 10     
	ASL                     ; 892F: 0A        
	TAX                     ; 8930: AA        
	CLC                     ; 8931: 18        
	ADC $67                 ; 8932: 65 67     
	TAX                     ; 8934: AA        
	LDA $6201,X             ; 8935: BD 01 62  
	STA $81                 ; 8938: 85 81     
	LDA $6200,X             ; 893A: BD 00 62  
	STA $80                 ; 893D: 85 80     
	JMP $8953               ; 893F: 4C 53 89  
; $20-$2F
L38942:
	LDA $89A5,X             ; 8942: BD A5 89  
	CLC                     ; 8945: 18        
	ADC $67                 ; 8946: 65 67     
	TAX                     ; 8948: AA        
	LDA $6100,X             ; 8949: BD 00 61  
	STA $80                 ; 894C: 85 80     
	LDA $6101,X             ; 894E: BD 01 61  
	STA $81                 ; 8951: 85 81     
	PLA                     ; 8953: 68        
	CMP #$22                ; 8954: C9 22     
	BCC L38979               ; 8956: 90 21     
	CMP #$24                ; 8958: C9 24     
	BCC L3897C               ; 895A: 90 20     
	CMP #$26                ; 895C: C9 26     
	BCC L3897F               ; 895E: 90 1F     
	CMP #$2D                ; 8960: C9 2D     
	BCC L38986               ; 8962: 90 22     
	CMP #$30                ; 8964: C9 30     
	BCC L3898D               ; 8966: 90 25     
	INC $80                 ; 8968: E6 80     
	CMP #$38                ; 896A: C9 38     
	BCC L3898D               ; 896C: 90 1F     
	SBC #$38                ; 896E: E9 38     
	ORA $67                 ; 8970: 05 67     
	TAX                     ; 8972: AA        
	LDA $6130,X             ; 8973: BD 30 61  
	BNE L3898D               ; 8976: D0 15     
	RTS                     ; 8978: 60        
L38979:
	JMP $89E8               ; 8979: 4C E8 89  
L3897C:
	JMP $89DD               ; 897C: 4C DD 89  
; $24-$25: 
L3897F:
	LDA #$00                ; 897F: A9 00     
	STA $81                 ; 8981: 85 81     
	JMP $89DD               ; 8983: 4C DD 89  
; $26-$2C: 
L38986:
	LDA #$00                ; 8986: A9 00     
	STA $81                 ; 8988: 85 81     
	JMP $89D2               ; 898A: 4C D2 89  
; $2D-
L3898D:
	LDA $81                 ; 898D: A5 81     
	PHA                     ; 898F: 48        
	JSR $89D2               ; 8990: 20 D2 89  
	LDA #$C2                ; 8993: A9 C2     
	STA $07A0,X             ; 8995: 9D A0 07  
	INC $90                 ; 8998: E6 90     
	PLA                     ; 899A: 68        
	STA $80                 ; 899B: 85 80     
	JSR $8B9B               ; 899D: 20 9B 8B  
	LDX $90                 ; 89A0: A6 90     
	JMP $8A24               ; 89A2: 4C 24 8A  
;

;$89A5
.byte $08,$0A,$0C,$0E,$18,$29,$20,$21,$22,$23,$24
.byte $25,$00,$16,$2A,$2C

; Name	:
; Marks	:
	LDA $601C		; 89B5	$AD $1C $60	gil
	STA $80			; 89B8	$85 $80
	LDA $601D		; 89BA	$AD $1D $60
	STA $81			; 89BD	$85 $81
	LDA $601E		; 89BF	$AD $1E $60
	STA $82			; 89C2	$85 $82
	JMP $89FE		; 89C4	$4C $FE $89
; End of

; Name	:
; Marks	:
	LDA $80			; 89C7	$A5 $80
	ORA #$80		; 89C9	$09 $80
	STA $5F			; 89CB	$85 $5F
	LDX $90			; 89CD	$A6 $90
	JMP $8A2A		; 89CF	$4C $2A $8A
; End of

; Name	:
; Marks	:
	JSR $8B9B		; 89D2	$20 $9B $8B
	JSR $8A65		; 89D5	$20 $65 $8A
	LDX $90			; 89D8	$A6 $90
	JMP $8A24		; 89DA	$4C $24 $8A
; $22-$23:
	JSR $8B6A		; 89DD	$20 $6A $8B
	JSR $8A5B		; 89E0	$20 $5B $8A
	LDX $90			; 89E3	$A6 $90
	JMP $8A1E		; 89E5	$4C $1E $8A
; $20-$21:
	JSR $8B39		; 89E8	$20 $39 $8B
	JSR $8A51		; 89EB	$20 $51 $8A
	LDX $90			; 89EE	$A6 $90
	JMP $8A18		; 89F0	$4C $18 $8A
; End of

; Name	:
; Marks	:
	JSR $8AF6		; 89F3	$20 $F6 $8A
	LDX $90			; 89F6	$A6 $90
	JSR $8A47		; 89F8	$20 $47 $8A
	JMP $8A12		; 89FB	$4C $12 $8A
	JSR $8A70		; 89FE	$20 $70 $8A
	JSR $8A33		; 8A01	$20 $33 $8A
	LDX $90			; 8A04	$A6 $90
	LDA $59			; 8A06	$A5 $59
	STA $07A0,X		; 8A08	$9D $A0 $07
	INX			; 8A0B	$E8
	LDA $5A			; 8A0C	$A5 $5A
	STA $07A0,X		; 8A0E	$9D $A0 $07
	INX			; 8A11	$E8
	LDA $5B			; 8A12	$A5 $5B
	STA $07A0,X		; 8A14	$9D $A0 $07
	INX			; 8A17	$E8
	LDA $5C			; 8A18	$A5 $5C
	STA $07A0,X		; 8A1A	$9D $A0 $07
	INX			; 8A1D	$E8
	LDA $5D			; 8A1E	$A5 $5D
	STA $07A0,X		; 8A20	$9D $A0 $07
	INX			; 8A23	$E8
	LDA $5E			; 8A24	$A5 $5E
	STA $07A0,X		; 8A26	$9D $A0 $07
	INX			; 8A29	$E8
	LDA $5F			; 8A2A	$A5 $5F
	STA $07A0,X		; 8A2C	$9D $A0 $07
	INX			; 8A2F	$E8
	STX $90			; 8A30	$86 $90
	RTS			; 8A32	$60
;

; Name	:
; Marks	:
	LDA $59			; 8A33	$A5 $59
	CMP #$80		; 8A35	$C9 $80
	BNE L38A6F		; 8A37	$D0 $36
	LDA #$FF		; 8A39	$A9 $FF
	STA $59			; 8A3B	$85 $59
	LDA $5A			; 8A3D	$A5 $5A
	CMP #$80		; 8A3F	$C9 $80
	BNE L38A6F		; 8A41	$D0 $2C
	LDA #$FF		; 8A43	$A9 $FF
	STA $5A			; 8A45	$85 $5A
	LDA $5B			; 8A47	$A5 $5B
	CMP #$80		; 8A49	$C9 $80
	BNE L38A6F		; 8A4B	$D0 $22
	LDA #$FF		; 8A4D	$A9 $FF
	STA $5B			; 8A4F	$85 $5B
	LDA $5C			; 8A51	$A5 $5C
	CMP #$80		; 8A53	$C9 $80
	BNE L38A6F		; 8A55	$D0 $18
	LDA #$FF		; 8A57	$A9 $FF
	STA $5C			; 8A59	$85 $5C
	LDA $5D			; 8A5B	$A5 $5D
	CMP #$80		; 8A5D	$C9 $80
	BNE L38A6F		; 8A5F	$D0 $0E
	LDA #$FF		; 8A61	$A9 $FF
	STA $5D			; 8A63	$85 $5D
	LDA $5E			; 8A65	$A5 $5E
	CMP #$80		; 8A67	$C9 $80
	BNE L38A6F		; 8A69	$D0 $04
	LDA #$FF		; 8A6B	$A9 $FF
	STA $5E			; 8A6D	$85 $5E
L38A6F:
	RTS			; 8A6F	$60
; End of

;8A70
; Name	:
; Marks	: convert hex to decimal
;	  7 digits
	LDX #$08		; 8A70	$A2 $08
L38A72:
	LDA $82			; 8A72	$A5 $82
	CMP $8BB2,X		; 8A74	$DD $B2 $8B
	BEQ L38A85		; 8A77	$F0 $0C
	BCS L38A97		; 8A79	$B0 $1C
L38A7B:
	DEX			; 8A7B	$CA
	BPL L38A72		; 8A7C	$10 $F4
	LDX #$80		; 8A7E	$A2 $80
	STX $59			; 8A80	$86 $59
	JMP $8AB3		; 8A82	$4C $B3 $8A
L38A85:
	LDA $81			; 8A85	$A5 $81
	CMP $8BBB,X		; 8A87	$DD $BB $8B
	BEQ L38A90		; 8A8A	$F0 $04
	BCC L38A7B		; 8A8C	$90 $ED
	BCS L38A97		; 8A8E	$B0 $07
L38A90:
	LDA $80			; 8A90	$A5 $80
	CMP $8BC4,X		; 8A92	$DD $C4 $8B
	BCC L38A7B		; 8A95	$90 $E4
L38A97:
	LDA $80			; 8A97	$A5 $80
	SEC			; 8A99	$38
	SBC $8BC4,X		; 8A9A	$FD $C4 $8B
	STA $80			; 8A9D	$85 $80
	LDA $81			; 8A9F	$A5 $81
	SBC $8BBB,X		; 8AA1	$FD $BB $8B
	STA $81			; 8AA4	$85 $81
	LDA $82			; 8AA6	$A5 $82
	SBC $8BB2,X		; 8AA8	$FD $B2 $8B
	STA $82			; 8AAB	$85 $82
	TXA			; 8AAD	$8A
	CLC			; 8AAE	$18
	ADC #$81		; 8AAF	$69 $81
	STA $59			; 8AB1	$85 $59
	; 6 digits
	LDX #$08		; 8AB3	$A2 $08
L38AB5:
	LDA $82			; 8AB5	$A5 $82
	CMP $8BCD,X		; 8AB7	$DD $CD $8B
	BEQ L38AC8		; 8ABA	$F0 $0C
	BCS L38ADA		; 8ABC	$B0 $1C
L38ABE:
	DEX			; 8ABE	$CA
	BPL L38AB5		; 8ABF	$10 $F4
	LDX #$80		; 8AC1	$A2 $80
	STX $5A			; 8AC3	$86 $5A
	JMP $8AF6		; 8AC5	$4C $F6 $8A
L38AC8:
	LDA $81			; 8AC8	$A5 $81
	CMP $8BD6,X		; 8ACA	$DD $D6 $8B
	BEQ L38AD3		; 8ACD	$F0 $04
	BCC L38ABE		; 8ACF	$90 $ED
	BCS L38ADA		; 8AD1	$B0 $07
L38AD3:
	LDA $80			; 8AD3	$A5 $80
	CMP $8BDF,X		; 8AD5	$DD $DF $8B
	BCC L38ABE		; 8AD8	$90 $E4
L38ADA:
	LDA $80			; 8ADA	$A5 $80
	SEC			; 8ADC	$38
	SBC $8BDF,X		; 8ADD	$FD $DF $8B
	STA $80			; 8AE0	$85 $80
	LDA $81			; 8AE2	$A5 $81
	SBC $8BD6,X		; 8AE4	$FD $D6 $8B
	STA $81			; 8AE7	$85 $81
	LDA $82			; 8AE9	$A5 $82
	SBC $8BCD,X		; 8AEB	$FD $CD $8B
	STA $82			; 8AEE	$85 $82
	TXA			; 8AF0	$8A
	CLC			; 8AF1	$18
	ADC #$81		; 8AF2	$69 $81
	STA $5A			; 8AF4	$85 $5A
	; 5 digits
	LDX #$08		; 8AF6	$A2 $08
L38AF8:
	LDA $82			; 8AF8	$A5 $82
	CMP $8BE8,X		; 8AFA	$DD $E8 $8B
	BEQ L38B0B		; 8AFD	$F0 $0C
	BCS L38B1D		; 8AFF	$B0 $1C
L38B01:
	DEX			; 8B01	$CA
	BPL L38AF8		; 8B02	$10 $F4
	LDX #$80		; 8B04	$A2 $80
	STX $5B			; 8B06	$86 $5B
	JMP $8B39		; 8B08	$4C $39 $8B
L38B0B:
	LDA $81			; 8B0B	$A5 $81
	CMP $8BF1,X		; 8B0D	$DD $F1 $8B
	BEQ L38B16		; 8B10	$F0 $04
	BCC L38B01		; 8B12	$90 $ED
	BCS L38B1D		; 8B14	$B0 $07
L38B16:
	LDA $80			; 8B16	$A5 $80
	CMP $8BFA,X		; 8B18	$DD $FA $8B
	BCC L38B01		; 8B1B	$90 $E4
L38B1D:
	LDA $80			; 8B1D	$A5 $80
	SEC			; 8B1F	$38
	SBC $8BFA,X		; 8B20	$FD $FA $8B
	STA $80			; 8B23	$85 $80
	LDA $81			; 8B25	$A5 $81
	SBC $8BF1,X		; 8B27	$FD $F1 $8B
	STA $81			; 8B2A	$85 $81
	LDA $82			; 8B2C	$A5 $82
	SBC $8BE8,X		; 8B2E	$FD $E8 $8B
	STA $82			; 8B31	$85 $82
	TXA			; 8B33	$8A
	CLC			; 8B34	$18
	ADC #$81		; 8B35	$69 $81
	STA $5B			; 8B37	$85 $5B
	; 4 digits
	LDX #$08		; 8B39	$A2 $08
L38B3B:
	LDA $81			; 8B3B	$A5 $81
	CMP $8C03,X		; 8B3D	$DD $03 $8C
	BEQ L38B4E		; 8B40	$F0 $0C
	BCS L38B55		; 8B42	$B0 $11
L38B44:
	DEX			; 8B44	$CA
	BPL L38B3B		; 8B45	$10 $F4
	LDX #$80		; 8B47	$A2 $80
	STX $5C			; 8B49	$86 $5C
	JMP $8B6A		; 8B4B	$4C $6A $8B
L38B4E:
	LDA $80			; 8B4E	$A5 $80
	CMP $8C0C,X		; 8B50	$DD $0C $8C
	BCC L38B44		; 8B53	$90 $EF
L38B55:
	LDA $80			; 8B55	$A5 $80
	SEC			; 8B57	$38
	SBC $8C0C,X		; 8B58	$FD $0C $8C
	STA $80			; 8B5B	$85 $80
	LDA $81			; 8B5D	$A5 $81
	SBC $8C03,X		; 8B5F	$FD $03 $8C
	STA $81			; 8B62	$85 $81
	TXA			; 8B64	$8A
	CLC			; 8B65	$18
	ADC #$81		; 8B66	$69 $81
	STA $5C			; 8B68	$85 $5C
	; 3 digits
	LDX #$08		; 8B6A	$A2 $08
L38B6C:
	LDA $81			; 8B6C	$A5 $81
	CMP $8C15,X		; 8B6E	$DD $15 $8C
	BEQ L38B7F		; 8B71	$F0 $0C
	BCS L38B86		; 8B73	$B0 $11
L38B75:
	DEX			; 8B75	$CA
	BPL L38B6C		; 8B76	$10 $F4
	LDX #$80		; 8B78	$A2 $80
	STX $5D			; 8B7A	$86 $5D
	JMP $8B9B		; 8B7C	$4C $9B $8B
L38B7F:
	LDA $80			; 8B7F	$A5 $80
	CMP $8C1E,X		; 8B81	$DD $1E $8C
	BCC L38B75		; 8B84	$90 $EF
L38B86:
	LDA $80			; 8B86	$A5 $80
	SEC			; 8B88	$38
	SBC $8C1E,X		; 8B89	$FD $1E $8C
	STA $80			; 8B8C	$85 $80
	LDA $81			; 8B8E	$A5 $81
	SBC $8C15,X		; 8B90	$FD $15 $8C
	STA $81			; 8B93	$85 $81
	TXA			; 8B95	$8A
	CLC			; 8B96	$18
	ADC #$81		; 8B97	$69 $81
	STA $5D			; 8B99	$85 $5D
	; 2 digits
	LDX #$00		; 8B9B	A2 00
	LDA $80			; 8B9D	A5 80
L38B9F:
	CMP #$0A		; 8B9F	C9 0A
	BCC L38BA8		; 8BA1	90 05
	SBC #$0A		; 8BA3	E9 0A
	INX			; 8BA5	E8
	BNE L38B9F		; 8BA6	D0 F7
L38BA8:
	ORA #$80		; 8BA8	09 80
	STA $5F			; 8BAA	85 5F
	TXA			; 8BAC	8A
	ORA #$80		; 8BAD	09 80
	STA $5E			; 8BAF	85 5E
	RTS			; 8BB1	60
; End of
	
; 1,000,000
.byte $0F,$1E,$2D,$3D,$4C,$5B,$6A,$7A,$89	; 8BB2
.byte $42,$84,$C6,$09,$4B,$8D,$CF,$12,$54	; 8BBB
.byte $40,$80,$C0,$00,$40,$80,$C0,$00,$40	; 8BC4
;,$100,000
.byte $01,$03,$04,$06,$07,$09,$0A,$0C,$0D	; 8BCD
.byte $86,$0D,$93,$1A,$A1,$27,$AE,$35,$BB	; 8BD6
.byte $A0,$40,$E0,$80,$20,$C0,$60,$00,$A0	; 8BDF
;,$10,000
.byte $00,$00,$00,$00,$00,$00,$01,$01,$01	; 8BE8
.byte $27,$4E,$75,$9C,$C3,$EA,$11,$38,$5F	; 8BF1
.byte $10,$20,$30,$40,$50,$60,$70,$80,$90	; 8BFA
;,$1000
.byte $03,$07,$0B,$0F,$13,$17,$1B,$1F,$23	; 8C03
.byte $E8,$D0,$B8,$A0,$88,$70,$58,$40,$28	; 8C0C
;,$100
.byte $00,$00,$01,$01,$01,$02,$02,$03,$03	; 8C15
.byte $64,$C8,$2C,$90,$F4,$58,$BC,$20,$84	; 8C1E


;----------------------------------------------------------------------



;; [$8C27 :: 0x38C27]

; Marks	: cid's airship ferry
	JSR $8EB6		; 8C27: $20 $B6 $8E	init player input
	LDA #$14		; 8C2A: $A9 $14		$0214: "Assistant:Cid's Airship ..."
	JSR $963E		; 8C2C: $20 $3E $96
	JSR $8E47		; 8C2F: $20 $47 $8E
	BCS L38CAF		; 8C32: $B0 $7B
	JSR $D16F		; 8C34: $20 $6F $D1	close text window (keyword/item)
	JSR $905E		; 8C37: $20 $5E $90	cursor sound effect (confirm)
	LDA #$1C		; 8C3A: $A9 $1C
	JSR $8E9B		; 8C3C: $20 $9B $8E	load shop/ferry data
	JSR $9139		; 8C3F: $20 $39 $91	open gil window
	LDA #$15		; 8C42: $A9 $15		$0215: "Go where?"
	JSR $963E		; 8C44: $20 $3E $96
	LDA #$00		; 8C47: $A9 $00
	STA $A2			; 8C49: $85 $A2
	LDA #$01		; 8C4B: $A9 $01
	STA $A3			; 8C4D: $85 $A3
	LDA #$00		; 8C4F: $A9 $00
	STA $79F0		; 8C51: $8D $F0 $79
L38C54:
	JSR $95CA		; 8C54: $20 $CA $95	wait one frame (draw cursors)
	LDA #$04		; 8C57: $A9 $04
	JSR $96F9		; 8C59: $20 $F9 $96	update cursor 2 position
	LDA $25			; 8C5C: $A5 $25
	BNE L38CAF		; 8C5E: $D0 $4F
	LDA $24			; 8C60: $A5 $24
	BEQ L38C54		; 8C62: $F0 $F0
	JSR $905E		; 8C64: $20 $5E $90	cursor sound effect (confirm)
	LDX $79F0		; 8C67: $AE $F0 $79
	LDA $7B02,X		; 8C6A: $BD $02 $7B
	STA $80			; 8C6D: $85 $80
	LDA $7B03,X		; 8C6F: $BD $03 $7B
	STA $81			; 8C72: $85 $81
	JSR $9081		; 8C74: $20 $81 $90	take gil
	BCC L38C84		; 8C77: $90 $0B
	LDA #$19		; 8C79: $A9 $19		$0219: "Oops!Not enough money! Come again!"
	JSR $963E		; 8C7B: $20 $3E $96
	JSR $8E7B		; 8C7E: $20 $7B $8E
	JMP $8C42		; 8C81: $4C $42 $8C
L38C84:
	LDA $7B00,X		; 8C84: $BD $00 $7B	set ferry destination position
	STA $62FC		; 8C87: $8D $FC $62
	LDA $7B01,X		; 8C8A: $BD $01 $7B
	STA $62FD		; 8C8D: $8D $FD $62
	LDA #$02		; 8C90: $A9 $02
	ORA $6004		; 8C92: $0D $04 $60
	STA $6004		; 8C95: $8D $04 $60
	LDA $623C		; 8C98: $AD $3C $62	move airship to poft at (148,58)
	STA $6005		; 8C9B: $8D $05 $60
	LDA $623D		; 8C9E: $AD $3D $62
	STA $6006		; 8CA1: $8D $06 $60
	LDA #$16		; 8CA4: $A9 $16		$0216: "Thanks!The Airship will be waiting for you outside."
	JSR $963E		; 8CA6: $20 $3E $96
	JSR $9139		; 8CA9: $20 $39 $91	open gil window
	JSR $8E7B		; 8CAC: $20 $7B $8E
L38CAF:
	JMP $91B8		; 8CAF: $4C $B8 $91	close window
;

; Marks	: statue revive
	LDA #$00		; 8CB2	$A9 $00
	STA $96			; 8CB4	$85 $96
	JSR $E91E		; 8CB6	$20 $1E $E9	open window
	LDX $61C1		; 8CB9	$AE $C1 $61
	LDA $62F5		; 8CBC	$AD $F5 $62
	BPL L38CC3		; 8CBF	$10 $02
	LDX #$00		; 8CC1	$A2 $00
L38CC3:
	TXA			; 8CC3	$8A
	ORA $6101		; 8CC4	$0D $01 $61
	ORA $6141		; 8CC7	$0D $41 $61
	ORA $6181		; 8CCA	$0D $81 $61
	BMI L38CDA		; 8CCD	$30 $0B		branch if any characters are dead
	LDA #$44		; 8CCF	$A9 $44		$0244: "You can't use this."
	JSR $95F2		; 8CD1	$20 $F2 $95	load text (multi-page)
	JSR $8E7B		; 8CD4	$20 $7B $8E
	JMP $91B8		; 8CD7	$4C $B8 $91	close window
L38CDA:
	LDX #$00		; 8CDA	$A2 $00
	JSR $8CFE		; 8CDC	$20 $FE $8C	revive dead character
	LDX #$40		; 8CDF	$A2 $40
	JSR $8CFE		; 8CE1	$20 $FE $8C	revive dead character
	LDX #$80		; 8CE4	$A2 $80
	JSR $8CFE		; 8CE6	$20 $FE $8C	revive dead character
	LDX #$C0		; 8CE9	$A2 $C0
	JSR $8CFE		; 8CEB	$20 $FE $8C	revive dead character
	LDA #$48		; 8CEE	$A9 $48		$0248: "As you pray,a warm light..."
	JSR $95F2		; 8CF0	$20 $F2 $95	load text (multi-page)
	JSR $8E7B		; 8CF3	$20 $7B $8E
	LDA $62BA		; 8CF6	$AD $BA $62	statue revive event
	STA $6C			; 8CF9	$85 $6C
	JMP $91B8		; 8CFB	$4C $B8 $91	close window
;

; Name	:
; Marks	: revive character
	LDA $6235,X		; 8CFE	$BD $35 $62
	BMI L38D12		; 8D01	$30 $0F		return if character slot empty
	LDA $6101,X		; 8D03	$BD $01 $61
	BPL L38D12		; 8D06	$10 $0A		return if character is not dead
	AND #$7F		; 8D08	$29 $7F
	STA $6101,X		; 8D0A	$9D $01 $61	remove dead status
	LDA #$01		; 8D0D	$A9 $01
	STA $6108,X		; 8D0F	$9D $08 $61	set hp to 1
L38D12:
	RTS			; 8D12	$60
; End of

; Name	:
; Marks	: calculate inn cost
; inn cost = (total hp deficit + total mp deficit) / 4
	LDA #$00		; 8D13	$A9 $00
	STA $61			; 8D15	$85 $61
	STA $62			; 8D17	$85 $62
	LDX #$00		; 8D19	$A2 $00
L38D1B:
	JSR $8D3A		; 8D1B	$20 $3A $8D	get total hp deficit
	TXA			; 8D1E	$8A
	CLC			; 8D1F	$18
	ADC #$40		; 8D20	$69 $40		next character
	TAX			; 8D22	$AA
	BNE L38D1B		; 8D23	$D0 $F6
	LSR $62			; 8D25	$46 $62		divide by 4
	ROR $61			; 8D27	$66 $61
	LSR $62			; 8D29	$46 $62
	ROR $61			; 8D2B	$66 $61
	LDX #$00		; 8D2D	$A2 $00
L38D2F:
	JSR $8D65		; 8D2F	$20 $65 $8D	get total mp deficit
	TXA			; 8D32	$8A
	CLC			; 8D33	$18
	ADC #$40		; 8D34	$69 $40		next character
	TAX			; 8D36	$AA
	BNE L38D2F		; 8D37	$D0 $F6
	RTS			; 8D39	$60
; End of

; Name	:
; Marks	: get total hp deficit
	LDA $6235,X		; 8D3A	$BD $35 $62
	BMI L38D64		; 8D3D	$30 $25		return if character slot empty
	LDA $6101,X		; 8D3F	$BD $01 $61
	AND #$C0		; 8D42	$29 $C0
	BNE L38D64		; 8D44	$D0 $1E		return if character is dead or stone
	LDA $610A,X		; 8D46	$BD $0A $61
	SEC			; 8D49	$38
	SBC $6108,X		; 8D4A	$FD $08 $61	max hp - current hp
	STA $80			; 8D4D	$85 $80
	LDA $610B,X		; 8D4F	$BD $0B $61
	SBC $6109,X		; 8D52	$FD $09 $61
	STA $81			; 8D55	$85 $81
	LDA $80			; 8D57	$A5 $80
	CLC			; 8D59	$18
	ADC $61			; 8D5A	$65 $61
	STA $61			; 8D5C	$85 $61
	LDA $81			; 8D5E	$A5 $81
	ADC $62			; 8D60	$65 $62
	STA $62			; 8D62	$85 $62
L38D64:
	RTS			; 8D64	$60
; End of

; Name	:
; Marks	: get total mp deficit
	LDA $6235,X		; 8D65	$BD $35 $62
	BMI L38D64		; 8D68	$30 $FA		return if character slot empty
	LDA $6101,X		; 8D6A	$BD $01 $61
	AND #$C0		; 8D6D	$29 $C0
	BNE L38D64		; 8D6F	$D0 $F3		return if character is dead or stone
	LDA $610E,X		; 8D71	$BD $0E $61
	SEC			; 8D74	$38
	SBC $610C,X		; 8D75	$FD $0C $61	max mp - current mp
	STA $80			; 8D78	$85 $80
	LDA $610F,X		; 8D7A	$BD $0F $61
	SBC $610D,X		; 8D7D	$FD $0D $61
	JMP $8D55		; 8D80: $4C $55 $8D
; End of

; Marks	: inn
	JSR $8D13		; 8D83	20 13 8D	calculate inn cost
	LDA #$0D		; 8D86	A9 0D		$020D: "Welcome! It will cost \x04 gil...""
	JSR $963E		; 8D88	20 3E 96
	JSR $8EB6		; 8D8B	20 B6 8E	init player input
	JSR $9139		; 8D8E	20 39 91	open gil window
	JSR $8E47		; 8D91	20 47 8E
	BCC L38DA4		; 8D94	90 0E
	LDA #$10		; 8D96	A9 10		$0210: "Please come again!"
	JSR $963E		; 8D98	20 3E 96
	JSR $D16F		; 8D9B	20 6F D1	close text window (keyword/item)
	JSR $8E7B		; 8D9E	20 7B 8E
	JMP $91B8		; 8DA1	4C B8 91	close window
L38DA4:
	LDA $61			; 8DA4	A5 61
	STA $80			; 8DA6	85 80
	LDA $62			; 8DA8	A5 62
	STA $81			; 8DAA	85 81
	JSR $9081		; 8DAC	20 81 90	take gil
	BCC L38DBC		; 8DAF	90 0B
	LDA #$0E		; 8DB1	A9 0E		$020E: "You don't have enough gil."
	JSR $963E		; 8DB3	20 3E 96
	JSR $8E7B		; 8DB6	20 7B 8E
	JMP $8D96		; 8DB9	4C 96 8D
L38DBC:
	JSR $9139		; 8DBC	20 39 91	open gil window
	LDA #$0F		; 8DBF	A9 0F		$020F: "Pleasant dreams…"
	JSR $963E		; 8DC1	20 3E 96
	JSR $8DD2		; 8DC4	20 D2 8D	set party hp/mp to max
	JSR $8E7B		; 8DC7	20 7B 8E
	LDA $62BB		; 8DCA	AD BB 62	inn event
	STA $6C			; 8DCD	85 6C
	JMP $91B8		; 8DCF	4C B8 91	close window
;

; Name	:
; Marks	: set party hp/mp to max
	LDX #$00		; 8DD2	$A2 $00
L38DD4:
	LDA $6101,X		; 8DD4	$BD $01 $61
	AND #$C0		; 8DD7	$29 $C0
	BNE L38DF8		; 8DD9	$D0 $1D
	LDA $6235,X		; 8DDB	$BD $35 $62
	BMI L38DF8		; 8DDE	$30 $18
	LDA $610A,X		; 8DE0	$BD $0A $61
	STA $6108,X		; 8DE3	$9D $08 $61
	LDA $610B,X		; 8DE6	$BD $0B $61
	STA $6109,X		; 8DE9	$9D $09 $61
	LDA $610E,X		; 8DEC	$BD $0E $61
	STA $610C,X		; 8DEF	$9D $0C $61
	LDA $610F,X		; 8DF2	$BD $0F $61
	STA $610D,X		; 8DF5	$9D $0D $61
L38DF8:
	TXA			; 8DF8	$8A
	CLC			; 8DF9	$18
	ADC #$40		; 8DFA	$69 $40
	TAX			; 8DFC	$AA
	BNE L38DD4		; 8DFD	$D0 $D5
	RTS			; 8DFF	$60
; End of

; Marks	: ship ferry
	LDA $600C		; 8E00	$AD $0C $60
	AND #$01		; 8E03	$29 $01		poft or paloom
	CLC			; 8E05	$18
	ADC #$11		; 8E06	$69 $11		$0211: "You need a ride? 32 gil will take you to Poft!"
	JSR $963E		; 8E08	$20 $3E $96
	LDA #$1E		; 8E0B	$A9 $1E
	JSR $8E9B		; 8E0D	$20 $9B $8E	load shop/ferry data
	JSR $8EB6		; 8E10	$20 $B6 $8E	init player input
	JSR $9139		; 8E13	$20 $39 $91	open gil window
	JSR $8E47		; 8E16	$20 $47 $8E
	BCS L38E44		; 8E19	$B0 $29
	LDA $7B00		; 8E1B	$AD $00 $7B	gil cost (from 0E/86FD)
	STA $80			; 8E1E	$85 $80
	LDA $7B01		; 8E20	$AD $01 $7B
	STA $81			; 8E23	$85 $81
	JSR $9081		; 8E25	$20 $81 $90	take gil
	BCS L38E36		; 8E28	$B0 $0C		branch if not enough gil
	LDA $600C		; 8E2A	$AD $0C $60
	ORA #$02		; 8E2D	$09 $02
	STA $600C		; 8E2F	$8D $0C $60
	LDA #$13		; 8E32	$A9 $13		$0213: "Done!Just board the ship ..."
	BNE L38E38		; 8E34	$D0 $02
L38E36:
	LDA #$19		; 8E36	$A9 $19		$0219: "Oops!Not enough money! Come again!"
L38E38:
	JSR $963E		; 8E38	$20 $3E 96
	JSR $D16F		; 8E3B	$20 $6F D1	close text window (keyword/item)
	JSR $9139		; 8E3E	$20 $39 91	open gil window
	JSR $8E7B		; 8E41	$20 $7B 8E
L38E44:
	JMP $91B8		; 8E44	$4C $B8 91	close window
;

; Name	:
; Marks	:
	LDA #$00		; 8E47	$A9 $00
	STA $24			; 8E49	$85 $24
	STA $25			; 8E4B	$85 $25
	LDA #$01		; 8E4D	$A9 $01
	STA $96			; 8E4F	$85 $96
	JSR $E91E		; 8E51	$20 $1E $E9	open window
	LDA #$18		; 8E54	$A9 $18
	JSR $95F2		; 8E56	$20 $F2 $95	load text (multi-page)
	LDA #$00		; 8E59	$A9 $00
	STA $78F0		; 8E5B	$8D $F0 $78
	LDA #$01		; 8E5E	$A9 $01
	STA $A2			; 8E60	$85 $A2
L38E62:
	JSR $95CA		; 8E62	$20 $CA $95	wait one frame (draw cursors)
	LDA #$04		; 8E65	$A9 $04
	JSR $96C5		; 8E67	$20 $C5 $96	get cursor 1 position
	LDA $25			; 8E6A	$A5 $25
	BNE L38E79		; 8E6C	$D0 $0B
	LDA $24			; 8E6E	$A5 $24
	BEQ L38E62		; 8E70	$F0 $F0
	LDA $78F0		; 8E72	$AD $F0 $78
	BNE L38E79		; 8E75	$D0 $02
	CLC			; 8E77	$18
	RTS			; 8E78	$60
L38E79:
	SEC			; 8E79	$38
	RTS			; 8E7A	$60
; End of

; Name	:
; Marks	:
	JSR $95E3		; 8E7B	$20 $E3 $95
	LDA #$00		; 8E7E	$A9 $00
	STA $A2			; 8E80	$85 $A2
	STA $A3			; 8E82	$85 $A3
	STA $A4			; 8E84	$85 $A4
L38E86:
	JSR $95CA		; 8E86	$20 $CA $95	wait one frame (draw cursors)
	JSR $DBA9		; 8E89	$20 $A9 $DB	read joypad registers
	LDA $20			; 8E8C	$A5 $20
	BNE L38E86		; 8E8E	$D0 $F6
L38E90:
	JSR $95CA		; 8E90	$20 $CA $95	wait one frame (draw cursors)
	JSR $DBA9		; 8E93	$20 $A9 $DB	read joypad registers
	LDA $20			; 8E96	$A5 $20
	BEQ L38E90		; 8E98	$F0 $F6
	RTS			; 8E9A	$60
; End of

; Name	:
; A	: shop/ferry id
; Marks	: load shop/ferry data
;	  shops are 8 bytes each, airship ferry is 16 bytes, ship ferry is 2 bytes
	ASL			; 8E9B	$0A
	ASL			; 8E9C	$0A
	ASL			; 8E9D	$0A
	CLC			; 8E9E	$18
	ADC $8380		; 8E9F	$6D $80 $83
	STA $80			; 8EA2	$85 $80
	LDA $8381		; 8EA4	$AD $81 $83
	ADC #$00		; 8EA7	$69 $00
	STA $81			; 8EA9	$85 $81
	LDY #$0F		; 8EAB	$A0 $0F		copy 16 bytes
L38EAD:
	LDA ($80),Y		; 8EAD	$B1 $80
	STA $7B00,Y		; 8EAF	$99 $00 $7B
	DEY			; 8EB2	$88
	BPL L38EAD		; 8EB3	$10 $F8
	RTS			; 8EB5	$60
; End of

; Name	: Get_udlr
; DEST	: bank($57) = bank #$0E
;	  key udlr($A1)
; Marks	: Init var and bank set to #$0E
Get_udlr:
	LDA #$00		; 8EB6	$A9 $00
	STA a_pressing		; 8EB8	$85 $24
	STA b_pressing		; 8EB8	$85 $25
	STA player_mv_timer	; 8EB8	$85 $47
	STA $A3			; 8EB8	$85 $A3
	STA $A4			; 8EB8	$85 $A4
	JSR Get_key		; 8EC2	$20 $A9 $DB
	LDA key1p		; 8EC5	$A5 $20
	AND #$0F		; 8EC7	$29 $0F
	STA $A1			; 8EC9	$85 $A1		; key udlr
	LDA #$0E		; 8ECB	$A9 $0E
	STA bank		; 8ECD	$85 $57
	RTS			; 8ECF	$60
; End of Get_udlr

; A	: shop id
; Marks	: shop window
	CMP #$E0		; 8ED0	$C9 $E0
	BCC L38ED5		; 8ED2	$90 $01
	RTS			; 8ED4	$60
L38ED5:
	CMP #$DC		; 8ED5	$C9 $DC
	BCC L38EEF		; 8ED7	$90 $16
	BNE L38EDE		; 8ED9	$D0 $03
	JMP $8E00		; 8EDB	$4C $00 $8E	$DC: ship ferry
L38EDE:
	CMP #$DD		; 8EDE	$C9 $DD
	BNE L38EE5		; 8EE0	$D0 $03
	JMP $8C27		; 8EE2	$4C $27 $8C	$DD: cid's airship ferry
L38EE5:
	CMP #$DE		; 8EE5	$C9 $DE
	BNE L38EEC		; 8EE7	$D0 $03
	JMP $8D83		; 8EE9	$4C $83 $8D	$DE: inn
L38EEC:
	JMP $8CB2		; 8EEC	$4C $B2 $8C	$DF: statue revive
; $C0-$DB: normal shop
L38EEF:
	LDA #$05		; 8EEF	$A9 $05		$0205: "What can I do for you?"
	JSR $963E		; 8EF1	$20 $3E $96
	LDA $A0			; 8EF4	$A5 $A0		npc id
	AND #$1F		; 8EF6	$29 $1F
	JSR $8E9B		; 8EF8	$20 $9B $8E	load shop/ferry data
	JSR $90FD		; 8EFB	$20 $FD $90	load shop item list text
	JSR $8EB6		; 8EFE	$20 $B6 $8E	init player input
	JSR $9139		; 8F01	$20 $39 $91	open gil window
	LDA #$01		; 8F04	$A9 $01		buy/sell/exit window
	STA $96			; 8F06	$85 $96
	JSR $E91E		; 8F08	$20 $1E $E9	open window
	LDA #$17		; 8F0B	$A9 $17		$0217: "Buy Sell Exit"
	JSR $95F2		; 8F0D	$20 $F2 $95	load text (multi-page)
	LDA #$01		; 8F10	$A9 $01
	STA $A2			; 8F12	$85 $A2
L38F14:
	JSR $95CA		; 8F14	$20 $CA $95	wait one frame (draw cursors)
	LDA #$04		; 8F17	$A9 $04
	JSR $96C5		; 8F19	$20 $C5 $96	get cursor 1 position
	LDA $25			; 8F1C	$A5 $25
	BNE L38F3C		; 8F1E	$D0 $1C
	LDA $24			; 8F20	$A5 $24
	BEQ L38F14		; 8F22	$F0 $F0
	JSR $905E		; 8F24	$20 $5E $90	cursor sound effect (confirm)
	LDA $78F0		; 8F27	$AD $F0 $78
	BNE L38F32		; 8F2A	$D0 $06
	JSR $8F3F		; 8F2C	$20 $3F $8F	shop menu (buy)
	JMP $8EFE		; 8F2F	$4C $FE $8E
L38F32:
	CMP #$04		; 8F32	$C9 $04
	BNE L38F3C		; 8F34	$D0 $06
	JSR $8F98		; 8F36	$20 $98 $8F	shop menu (sell)
	JMP $8EFE		; 8F39	$4C $FE $8E
L38F3C:
	JMP $91B8		; 8F3C	$4C $B8 $91	close window
;

; Name	:
; Marks	: shop menu (buy)
	JSR $90B5		; 8F3F	$20 $B5 $90	find first empty inventory slot
	BCC L38F4A		; 8F42	$90 $06		branch if inventory is not full
	LDA #$08		; 8F44	$A9 $08		$0208: "You're carrying too much."
	JSR $963E		; 8F46	$20 $3E $96
	RTS			; 8F49	$60
L38F4A:
	LDA #$01		; 8F4A	$A9 $01
	STA $A3			; 8F4C	$85 $A3
	JSR $90D6		; 8F4E	$20 $D6 $90
	LDA #$00		; 8F51	$A9 $00
	STA $79F0		; 8F53	$8D $F0 $79
; start of frame loop
L38F56:
	JSR $95CA		; 8F56	$20 $CA $95	wait one frame (draw cursors)
	LDA #$04		; 8F59	$A9 $04
	JSR $96F9		; 8F5B	$20 $F9 $96	update cursor 2 position
	LDA $25  		; 8F5E	$A5 $25
	BNE L38F92		; 8F60	$D0 $30		branch if B button is pressed
	LDA $24  		; 8F62	$A5 $24
	BEQ L38F56		; 8F64	$F0 $F0		branch if A button is not pressed
	JSR $905E		; 8F66	$20 $5E $90	cursor sound effect (confirm)
	LDA $79F0		; 8F69	$AD $F0 $79
	LSR			; 8F6C	$4A
	TAX			; 8F6D	$AA
	LDA $7B01,X		; 8F6E	$BD $01 $7B	item price
	JSR $9067		; 8F71	$20 $67 $90	get item purchase price
	JSR $9081		; 8F74	$20 $81 $90	take gil
	BCC L38F7F		; 8F77	$90 $06
	LDA #$07		; 8F79	$A9 $07		$0207: "You don't have enough gil."
	JSR $963E		; 8F7B	$20 $3E $96
	RTS			; 8F7E	$60
L38F7F:
	LDA $79F0		; 8F7F	$AD $F0 $79
	LSR			; 8F82	$4A
	TAY			; 8F83	$A8
	LDA $7B00,Y		; 8F84	$B9 $00 $7B	item id
	TAY			; 8F87	$A8
	JSR $90C4		; 8F88	$20 $C4 $90	shift inventory so first slot is empty
	TYA			; 8F8B	$98
	STA $6060,X		; 8F8C	$9D $60 $60	put item in first slot
	JSR $9567		; 8F8F	$20 $67 $95	show item select window
L38F92:
	LDA #$09		; 8F92	$A9 $09		$0209: "Thank you! Anything else?"
	JMP $963E		; 8F94	$4C $3E $96
; unused
	RTS 			; 8F97	$60
; End of


; Name	:
; Marks	: shop menu (sell)
	LDA #$01		; 8F98	$A9 $01
	STA $A4			; 8F9A	$85 $A4
	JSR $9567		; 8F9C	$20 $67 $95	show item select window
	JSR $94EB		; 8F9F	$20 $EB $94	save dialogue window variables
	LDA #$00		; 8FA2	$A9 $00
	STA $7AF0		; 8FA4	$8D $F0 $7A
L38FA7:
	LDA #$0A		; 8FA7	$A9 $0A		$020A: "What will you sell?"
	JSR $963E		; 8FA9	$20 $3E $96
	LDA #$00		; 8FAC	$A9 $00
	STA $A3			; 8FAE	$85 $A3
	STA $24			; 8FB0	$85 $24
	STA $25			; 8FB2	$85 $25
; start of frame loop (item select)
L38FB4:
	JSR $95CA		; 8FB4	$20 $CA $95	wait one frame (draw cursors)
	LDA #$08		; 8FB7	$A9 $08
	JSR $972D		; 8FB9	$20 $2D $97	update cursor 3 position
	LDA $25			; 8FBC	$A5 $25
	BNE L3903A		; 8FBE	$D0 $7A		branch if B button is pressed
	LDA $24			; 8FC0	$A5 $24
	BEQ L38FB4		; 8FC2	$F0 $F0		branch if A button is not pressed
	JSR $905E		; 8FC4	$20 $5E $90	cursor sound effect (confirm)
	LDX $7AF0		; 8FC7	$AE $F0 $7A
	LDA $7A03,X		; 8FCA	$BD $03 $7A
	TAX			; 8FCD	$AA
	LDA $6060,X		; 8FCE	$BD $60 $60
	CMP #$10		; 8FD1	$C9 $10
	BCS L38FDD		; 8FD3	$B0 $08		branch if not a key item
	LDA #$0B		; 8FD5	$A9 $0B		$020B: "I can't take that. Anything else?"
	JSR $963E		; 8FD7	$20 $3E $96
	JMP $8FB4		; 8FDA	$4C $B4 $8F
L38FDD:
	JSR $9044		; 8FDD	$20 $44 $90	get item sell price
	LDA #$01		; 8FE0	$A9 $01
	STA $A3			; 8FE2	$85 $A3
	LDA #$00		; 8FE4	$A9 $00
	STA $79F0		; 8FE6	$8D $F0 $79
	LDA #$0C		; 8FE9	$A9 $0C		$020C: "I'll give you \x04 Gil for that.OK? Yes No"
	JSR $963E		; 8FEB	$20 $3E $96
; start of frame loop (yes/no)
L38FEE:
	JSR $95CA		; 8FEE	$20 $CA $95	wait one frame (draw cursors)
	LDA #$04		; 8FF1	$A9 $04
	JSR $96F9		; 8FF3	$20 $F9 $96	update cursor 2 position
	LDA $25			; 8FF6	$A5 $25
	BNE L38FA7		; 8FF8	$D0 $AD		branch if B button is pressed
	LDA $24			; 8FFA	$A5 $24
	BEQ L38FEE		; 8FFC	$F0 $F0		branch if A button is not pressed
	JSR $905E		; 8FFE	$20 $5E $90	cursor sound effect (confirm)
	LDA $79F0		; 9001	$AD $F0 $79
	BNE L38FA7		; 9004	$D0 $A1
	LDA $61			; 9006	$A5 $61
	STA $80			; 9008	$85 $80
	LDA $62			; 900A	$A5 $62
	STA $81			; 900C	$85 $81
	JSR $EFCF		; 900E	$20 $CF $EF	give gil
	LDX $7AF0		; 9011	$AE $F0 $7A
	LDA $7A03,X		; 9014	$BD $03 $7A
	TAX			; 9017	$AA
	LDA #$00		; 9018	$A9 $00
	STA $6060,X		; 901A	$9D $60 $60
	JSR $9139		; 901D	$20 $39 $91	open gil window
	JSR $9523		; 9020	$20 $23 $95	restore dialogue window variables
	LDA $1C			; 9023	$A5 $1C
	STA $3E			; 9025	$85 $3E
	LDA $1D			; 9027	$A5 $1D
	STA $3F			; 9029	$85 $3F
	JSR $E7AC		; 902B	$20 $AC $E7
	LDA #$09		; 902E	$A9 $09		$0209: "Thank you! Anything else?"
	JSR $963E		; 9030	$20 $3E $96
	LDA #$00		; 9033	$A9 $00
	STA $A3			; 9035	$85 $A3
	JMP $8FB4		; 9037	$4C $B4 $8F
; exit sell menu
L3903A:
	LDA #$09		; 903A	$A9 $09		$0209: "Thank you! Anything else?"
	JSR $963E		; 903C	$20 $3E $96
	LDA #$00		; 903F	$A9 $00
	STA $A3			; 9041	$85 $A3
	RTS			; 9043	$60
; End of


; Name	:
; Marks	: get item sell price
; $00-$BF are sell prices corresponding to item id
	ASL			; 9044	0A
	TAX			; 9045	AA
	BCS L39053		; 9046	B0 0B
	LDA $8000,X		; 9048	BD 00 80	BANK 0E/8000 (item prices)
	STA $61			; 904B	85 61
	LDA $8001,X		; 904D	BD 01 80
	STA $62			; 9050	85 62
	RTS			; 9052	60
L39053:
	LDA $8100,X		; 9053	BD 00 81
	STA $61			; 9056	85 61
	LDA $8101,X		; 9058	BD 01 81
	STA $62			; 905B	85 62
	RTS			; 905D	60
; End of


; Name	: Sound_key_init
; Marks	: B, A key init, Sound init or Make some sound effect ??
KeyRst_SndE:
	LDA #$00		; 905E	$A9 $00
	STA a_pressing		; 9060	$85 $24
	STA b_pressing		; 9062	$85 $25
	JMP SndE_cur_sel	; 9604	$4C $2E $DB
; End of KeyRst_SndE

; Name	:
; Marks	: get item purchase price
; $E0-$FF are purchase prices, index is from shop data
	ASL			; 9067	$0A
	TAX			; 9068	$AA
	BCS L39076		; 9069	$B0 $0B
	LDA $8000,X		; 906B	$BD $00 $80	BANK 0E/8000 (item prices)
	STA $80			; 906E	$85 $80
	LDA $8001,X		; 9070	$BD $01 $80
	STA $81			; 9073	$85 $81
	RTS			; 9075	$60
L39076:
	LDA $8100,X		; 9076	$BD $00 $81
	STA $80			; 9079	$85 $80
	LDA $8101,X		; 907B	$BD $01 $81
	STA $81			; 907E	$85 $81
	RTS			; 9080	$60
; End of

; Name	:
; Marks	: take gil
; +$80: gil amount
; set carry if not enough gil
	LDA $601E		; 9081	$AD $1E $60
	BNE L3909A		; 9084	$D0 $14
	LDA $601D		; 9086	$AD $1D $60
	CMP $81			; 9089	$C5 $81
	BCC L39098		; 908B	$90 $0B
	BEQ L39091		; 908D	$F0 $02
	BCS L3909A		; 908F	$B0 $09
L39091:
	LDA $601C		; 9091	$AD $1C $60	gil
	CMP $80			; 9094	$C5 $80
	BCS L3909A		; 9096	$B0 $02
L39098:
	SEC			; 9098	$38
	RTS			; 9099	$60
L3909A:
	LDA $601C		; 909A	$AD $1C $60
	SEC			; 909D	$38
	SBC $80			; 909E	$E5 $80
	STA $601C		; 90A0	$8D $1C $60
	LDA $601D		; 90A3	$AD $1D $60
	SBC $81			; 90A6	$E5 $81
	STA $601D		; 90A8	$8D $1D $60
	LDA $601E		; 90AB	$AD $1E $60
	SBC #$00		; 90AE	$E9 $00
	STA $601E		; 90B0	$8D $1E $60
	CLC			; 90B3	$18
	RTS			; 90B4	$60
; End

; Name	:
; Marks	: find first empty inventory slot
; X: empty slot offset (out)
; set carry if inventory is full
	LDX #$00		; 90B5	$A2 $00
L390B7:
	LDA $6060,X		; 90B7	$BD $60 $60	inventory
	BNE L390BE		; 90BA	$D0 $02
	CLC			; 90BC	$18
	RTS			; 90BD	$60
L390BE:
	INX			; 90BE	$E8
	CPX #$20		; 90BF	$E0 $20
	BCC L390B7		; 90C1	$90 $F4
	RTS			; 90C3	$60
; End of

; Name	:
; Marks	: shift inventory so first slot is empty
	JSR $90B5		; 90C4	$20 $B5 $90	find first empty inventory slot
	CPX #$00		; 90C7	$E0 $00
	BEQ L390D5		; 90C9	$F0 $0A
	DEX			; 90CB	$CA
	LDA $6060,X		; 90CC	$BD $60 $60
	STA $6061,X		; 90CF	$9D $61 $60
	JMP $90C7		; 90D2	$4C $C7 $90
L390D5:
	RTS			; 90D5	$60
; End of

; Name	:
; Marks	:
	LDA #$06		; 90D6	$A9 $06		$0206: "What would you like?"
	JSR $963E		; 90D8	$20 $3E $96
	LDA $38			; 90DB	$A5 $38
	CLC			; 90DD	$18
	ADC #$0C		; 90DE	$69 $0C
	AND #$3F		; 90E0	$29 $3F
	STA $38			; 90E2	$85 $38
	LDA $97			; 90E4	$A5 $97
	CLC			; 90E6	$18
	ADC #$0C		; 90E7	$69 $0C
	STA $97			; 90E9	$85 $97
	LDA $3C			; 90EB	$A5 $3C
	SEC			; 90ED	$38
	SBC #$0C		; 90EE	$E9 $0C
	STA $3C			; 90F0	$85 $3C
	LDA #$20		; 90F2	$A9 $20
	STA $3E			; 90F4	$85 $3E
	LDA #$7B		; 90F6	$A9 $7B
	STA $3F			; 90F8	$85 $3F
	JMP $E7AC		; 90FA	$4C $AC $E7
;

; Name	:
; Marks	: load shop item list text
	LDY #$00		; 90FD	$A0 $00
	LDX #$00		; 90FF	$A2 $00
L39101:
	LDA $9115,Y		; 9101	$B9 $15 $91
	CMP #$FF		; 9104	$C9 $FF
	BNE L3910C		; 9106	$D0 $04
	LDA $7B00,X		; 9108	$BD $00 $7B	shop data
	INX			; 910B	$E8
L3910C:
	STA $7B20,Y		; 910C	$99 $20 $7B	text buffer
	INY			; 910F	$C8
	CPY #$24		; 9110	$C0 $24
	BCC L39101		; 9112	$90 $ED
	RTS			; 9114	$60
; End of

; shop item list text string (replace $FF's with shop data)
.byte $16,$00,$18,$FF,$14,$09,$19,$FF,$01,$16,$00,$18,$FF,$14,$09,$19	; 9115
.byte $FF,$01,$16,$00,$18,$FF,$14,$09,$19,$FF,$01,$16,$00,$18,$FF,$14	; 9125
.byte $09,$19,$FF,$00							; 9135

; Name	:
; Marks	: open gil window
	LDA #$03		; 9139	$A9 $03		gil window
	STA $96			; 913B	$85 $96
	JSR $E91E		; 913D	$20 $1E $E9	open window
	LDA #$1C		; 9140	$A9 $1C		$021C: "\x05 Gil"
	JMP $95F2		; 9142	$4C $F2 $95	load text (multi-page)
;

; Name	:
; Marks	:
	LDA #$00		; 9145	$A9 $00
	STA $78F0		; 9147	$8D $F0 $78	current cursor position ??
	STA $79F0		; 914A	$8D $F0 $79
	STA $7AF0		; 914D	$8D $F0 $7A
	STA $79F1		; 9150	$8D $F1 $79
	LDA #$0E		; 9153	$A9 $0E
	STA bank		; 9155	$85 $57
	LDA $A0			; 9157	$A5 $A0
	CMP #$C0		; 9159	$C9 $C0
	BCC L39160		; 915B	$90 $03		if A < C0h
	JMP $8ED0		; 915D	$4C $D0 $8E
; End of
L39160:
	JSR $E8CA		; 9160	$20 $CA $E8
	LDA $79F1		; 9163	$AD $F1 $79
	STA $9F			; 9166	$85 $9F
	LDA text_ID		; 9168	$A5 $92
	STA $9D			; 916A	$85 $9D
	LDA $9F			; 916C	$A5 $9F
	BEQ L39174		; 916E	$F0 $04
	LDA #$49		; 9170	$A9 $49
	STA current_song_ID	; 9172	$85 $E0
L39174:
	JSR $8EB6		; 9174	$20 $B6 $8E
	LDA #$01		; 9177	$A9 $01
	STA win_type		; 9179	$85 $96
	JSR $E91E		; 917B	$20 $1E $E9
	LDA #$1A		; 917E	$A9 $1A
	JSR $95F2		; 9180	$20 $F2 $95
	LDA #$01		; 9183	$A9 $01
	STA $A2			; 9185	$85 $A2
; Loop in message with keywords ??
L39187:
	JSR $95CA		; 9187	$20 $CA $95	copy oam and some processing ??
	LDA #$04		; 918A	$A9 $04		size of cursor step ??
	JSR $96C5		; 918C	$20 $C5 $96	check key and cursor position calcuration ??
	LDA b_pressing		; 918F	$A5 $25
	BNE L391B8		; 9191	$D0 $25
	LDA a_pressing		; 9193	$A5 $24
	BEQ L39187		; 9195	$F0 $F0
	JSR $905E		; 9197	$20 $5E $90	key reset/sound effect
	TSX			; 919A	$BA
	STX $04			; 919B	$86 $04		temp stack pointer
	LDA cur_pos		; 919D	$AD $F0 $78
	BNE L391A8		; 91A0	$D0 $06
	JSR $9204		; 91A2	$20 $04 $92	?? loop
	JMP $9174		; 91A5	$4C $74 $91
L391A8:
	CMP #$04		; 91A8	$C9 $04
	BNE L391B2		; 91AA	$D0 $06		A != 04h, not learn ??
	JSR $933B		; 91AC	$20 $3B $93
	JMP $9174		; 91AF	$4C $74 $91
; loop
L391B2:
	JSR $9381		; 91B2	$20 $81 $93	item select in message loop
	JMP $9174		; 91B5	$4C $74 $91
; loop

L391B8:
	JSR SndE_cur_sel	; 91B8	$20 $2E $DB
	JSR $95E3		; 91BB	$20 $E3 $95
	JSR Wait_NMI		; 91BE	$20 $00 $FE
	LDA #$02		; 91C1	$A9 $02
	STA SpriteDma_4014	; 91C3	$8D $14 $40
	JSR $C74F		; 91C6	$20 $4F $C7	sound ??
	JSR $D164		; 91C9	$20 $64 $D1
	JSR $D16F		; 91CC	$20 $6F $D1
	LDA #$00		; 91CF	$A9 $00
	STA a_pressing		; 91D1	$85 $24		key init
	STA b_pressing		; 91D3	$85 $25
	STA e_pressing		; 91D5	$85 $22
	STA s_pressing		; 91D7	$85 $23
	STA $47			; 91D9	$85 $47
	RTS			; 91DB	$60
; End of

; Marks	:
	JSR $DBA9		; 91DC	$20 $A9 $DB	read joypad registers
	LDA $20			; 91DF	$A5 $20
	STA $03			; 91E1	$85 $03
L391E3:
	JSR $DBA9		; 91E3	$20 $A9 $DB	read joypad registers
	JSR $95CA		; 91E6	$20 $CA $95	wait one frame (draw cursors)
	LDA $20			; 91E9	$A5 $20
	CMP $03			; 91EB	$C5 $03
	BEQ L391E3		; 91ED	$F0 $F4
	STA $03			; 91EF	$85 $03
L391F1:
	JSR $DBA9		; 91F1	$20 $A9 $DB	read joypad registers
	JSR $95CA		; 91F4	$20 $CA $95	wait one frame (draw cursors)
	LDA $20			; 91F7	$A5 $20
	CMP $03			; 91F9	$C5 $03
	BEQ L391F1		; 91FB	$F0 $F4
	LDX $04			; 91FD	$A6 $04
	TXS			; 91FF	$9A
	JMP $91B8		; 9200	$4C $B8 $91
;

L39203:
	RTS			; 9203	$60
; End of $9240

; Name	:
; Marks	:
	LDA #$01		; 9204	$A9 $01
	STA $A4			; 9206	$85 $A4
	JSR $955B		; 9208	$20 $5B $95	show message text ??
	JSR $94EB		; 920B	$20 $EB $94	Save variables ??
	LDA #$00		; 920E	$A9 $00
	STA $7AF0		; 9210	$8D $F0 $7A
	; Loop something
L39213:
	JSR $95CA		; 9213	$20 $CA $95
; Marks	: Choose B or A
;	  Check keyword
	LDA #$08		; 9216	$A9 $08
	JSR $972D		; 9218	$20 $2D $97
	LDA b_pressing		; 921B	$A5 $25
	BNE L39203		; 921D	$D0 $E4
	LDA a_pressing		; 921F	$A5 $24
	BEQ L39213		; 9221	$F0 $F0
	JSR $905E		; 9223	$20 $5E $90	key reset/sound effect
	LDX $7AF0		; 9226	$AE $F0 $7A
	LDA $7A03,X		; 9229	$BD $03 $7A
	TAX			; 922C	$AA
	LDA keywords,X		; 922D	$BD $80 $60
	BEQ L39235		; 9230	$F0 $03
	SEC			; 9232	$38
	SBC #$F0		; 9233	$E9 $F0
L39235:
	TAX			; 9235	$AA
	LDA $7B20,X		; 9236	$BD $20 $7B
	BNE L39243		; 9239	$D0 $08
	LDA #$43		; 923B	$A9 $43
	JSR $963E		; 923D	$20 $3E $96
	JMP $9203		; 9240	$4C $03 $92
; End of
L39243:
	STX $08			; 9243	$86 $08
	JSR $9614		; 9245	$20 $14 $96
	LDA $79F1		; 9248	$AD $F1 $79
	BEQ L39251		; 924B	$F0 $04
	LDA #$49		; 924D	$A9 $49		play song $09
	STA $E0			; 924F	$85 $E0		
L39251:
	LDA $A0			; 9251	$A5 $A0		A = npc id
	LDX $08			; 9253	$A6 $08		X = keyword id
; npc $01: 
	CMP #$01		; 9255	$C9 $01
	BNE L39265		; 9257	$D0 $0C
	CPX #$02		; 9259	$E0 $02		mythril
	BNE L39276		; 925B	$D0 $19
	LDY #$50		; 925D	$A0 $50
	JSR $98C7		; 925F	$20 $C7 $98	set event switch and show npc
	JMP $9203		; 9262	$4C $03 $92
; npc $12
L39265:
	CMP #$12		; 9265	$C9 $12
	BNE L3927D		; 9267	$D0 $14
	CPX #$0C		; 9269	$E0 $0C
	BEQ L39279		; 926B	$F0 $0C
	CPX #$0D		; 926D	$E0 $0D
	BNE L39276		; 926F	$D0 $05
	LDY #$5B		; 9271	$A0 $5B
L39273:
	JSR $9907		; 9273	$20 $07 $99	hide npc
L39276:
	JMP $9203		; 9276	$4C $03 $92  
L39279:
	LDY #$5A		; 9279	$A0 $5A
	BNE L39273		; 927B	$D0 $F6
; npc $13: josef (salamand)
L3927D:
	CMP #$13		; 927D	$C9 $13
	BNE L39298		; 927F	$D0 $17
	CPX #$06		; 9281	$E0 $06		Goddess's Bell
	BNE L39276		; 9283	$D0 $F1
	LDY #$13		; 9285	$A0 $13
	JSR $9907		; 9287	$20 $07 $99	hide npc
	LDA #$05		; 928A	$A9 $05		josef
	STA $61			; 928C	$85 $61
	JSR $C018		; 928E	$20 $18 $C0	load guest character properties
	LDA #$4A		; 9291	$A9 $4A		play song $0A
	STA $E0			; 9293	$85 $E0
	JMP $9203		; 9295	$4C $03 $92
; npc $25
L39298:
	CMP #$25		; 9298	$C9 $25
	BNE L392B3		; 929A	$D0 $17
	CPX #$0B		; 929C	$E0 $0B
	BNE L39276		; 929E	$D0 $D6
	LDA $601B		; 92A0	$AD $1B $60
	AND #$02		; 92A3	$29 $02
	BEQ L39276		; 92A5	$F0 $CF		branch if player doesn't have ring
	LDA #$47		; 92A7	$A9 $47		play song $07
	STA $E0			; 92A9	$85 $E0
	LDA #$0A		; 92AB	$A9 $0A		item $0A: WyvernEgg
	JSR $9573		; 92AD	$20 $73 $95	add item to inventory (unique)
	JMP $9203		; 92B0	$4C $03 $92
; npc $2E
L392B3:
	CMP #$2E		; 92B3	$C9 $2E
	BNE L392C0		; 92B5	$D0 $09
	CPX #$0F		; 92B7	$E0 $0F
	BNE L39276		; 92B9	$D0 $BB
	LDY #$2E		; 92BB	$A0 $2E
	JMP $9273		; 92BD	$4C $73 $92
; npc $30
L392C0:
	CMP #$30		; 92C0	$C9 $30
	BNE L392CD		; 92C2	$D0 $09
	CPX #$01		; 92C4	$E0 $01
	BNE L39276		; 92C6	$D0 $AE
	LDY #$30		; 92C8	$A0 $30
	JMP $9273		; 92CA	$4C $73 $92
; npc $31: scott
L392CD:
	CMP #$31		; 92CD	$C9 $31
	BNE L392E4		; 92CF	$D0 $13
	CPX #$01		; 92D1	$E0 $01		said keyword $01: wild rose
	BNE L39338		; 92D3	$D0 $63
	LDA #$01		; 92D5	$A9 $01		item $01: Ring
	JSR $9573		; 92D7	$20 $73 $95	add item to inventory (unique)
	LDY #$31		; 92DA	$A0 $31		scott
	JSR $9907		; 92DC	$20 $07 $99	hide npc
	LDY #$10		; 92DF	$A0 $10		paul (altair)
	JMP $9273		; 92E1	$4C $73 $92
; npc $32: dreadnought guard
L392E4:
	CMP #$32		; 92E4	$C9 $32
	BNE L392FD		; 92E6	$D0 $15
	CPX #$01		; 92E8	$E0 $01		Wild Rose
	BNE L39338		; 92EA	$D0 $4C
	LDA $7B03		; 92EC	$AD $03 $7B	battle $6E
	STA $6A			; 92EF	$85 $6A
	LDA #$20		; 92F1	$A9 $20
	STA $44			; 92F3	$85 $44
	LDY #$32		; 92F5	$A0 $32		npc $32 (dreadnought guard)
	JSR $9907		; 92F7	$20 $07 $99	hide npc
	JMP $91DC		; 92FA	$4C $DC $91
; npc $35
L392FD:
	CMP #$35		; 92FD	$C9 $35
	BNE L39316		; 92FF	$D0 $15
	CPX #$03		; 9301	$E0 $03
	BNE L39338		; 9303	$D0 $33
	LDY #$23		; 9305	$A0 $23
	JSR $989E		; 9307	$20 $9E $98	check event switch
	BEQ L39338		; 930A	$F0 $2C
	LDY #$1B		; 930C	$A0 $1B
	JSR $98C7		; 930E	$20 $C7 $98	set event switch and show npc
	LDY #$35		; 9311	$A0 $35
	JMP $9273		; 9313	$4C $73 $92
; npc $58: deist npc 4
L39316:
	CMP #$58		; 9316	$C9 $58
	BNE L39338		; 9318	$D0 $1E
	CPX #$0A		; 931A	$E0 $0A		Dragoon
	BNE L39338		; 931C	$D0 $1A
	LDA $601B		; 931E	$AD $1B $60
	AND #$02		; 9321	$29 $02
	BEQ L39338		; 9323	$F0 $13		branch if player doesn't have pendant
	LDA #$5F		; 9325	$A9 $5F		item $5F: Excalibr
	JSR $9573		; 9327	$20 $73 $95	add item to inventory (unique)
	LDA #$47		; 932A	$A9 $47		play song $07
	STA $E0			; 932C	$85 $E0
	LDY #$57		; 932E	$A0 $57
	JSR $9907		; 9330	$20 $07 $99	hide npc
	LDY #$58		; 9333	$A0 $58
	JMP $9273		; 9335	$4C $73 $92
L39338:
	JMP $9203		; 9338	$4C $03 $92	return
;

; Name	:
; Marks	: learn keyword window
	LDA $9F			; 933B	$A5 $9F		learn keyword ??
	BNE L39345		; 933D	$D0 $06
	LDA #$3F		; 933F	$A9 $3F
	JSR $963E		; 9341	$20 $3E $96	some process scroll ??
	RTS			; 9344	$60
; End of
L39345:
	LDA #$00		; 9345	$A9 $00
	STA $79F0		; 9347	$8D $F0 $79
	LDA $79F1		; 934A	$AD $F1 $79
	BNE L39354		; 934D	$D0 $05
	LDA $9D			; 934F	$A5 $9D
	JSR $9614		; 9351	$20 $14 $96
L39354:
	LDA #$01		; 9354	$A9 $01
	STA $A3			; 9356	$85 $A3
L39358:
	JSR $95CA		; 9358	$20 $CA $95	wait one frame (draw cursors)
	LDA #$04		; 935B	$A9 $04
	JSR $96F9		; 935D	$20 $F9 $96	update cursor 2 position
	LDA $25			; 9360	$A5 $25
	BNE L3937F		; 9362	$D0 $1B
	LDA $24			; 9364	$A5 $24
	BEQ L39358		; 9366	$F0 $F0
	JSR $905E		; 9368	$20 $5E $90	cursor sound effect (confirm)
	LDX $79F0		; 936B	$AE $F0 $79
	LDA $7903,X		; 936E	$BD $03 $79
	JSR $9597		; 9371	$20 $97 $95	learn keyword
	JSR $955B		; 9374	$20 $5B $95	show keyword select window
	LDA #$04		; 9377	$A9 $04
	STA $78F0		; 9379	$8D $F0 $78
	JMP $9358		; 937C	$4C $58 $93
L3937F:
	RTS			; 937F	$60
; End of

; Marks	: item select window
; starts at 0E/9381
L39380:
	RTS			; 9380	$60
; Name	:
; Marks	:
	LDA #$01		; 9381	$A9 $01
	STA $A4			; 9383	$85 $A4
	JSR $9567		; 9385	$20 $67 $95
	JSR $94EB		; 9388	$20 $EB $94	into 3.Item in message
	LDA #$00		; 938B	$A9 $00
	STA $7AF0		; 938D	$8D $F0 $7A
	; Loop choose item on message
MAP_ITEM_USE_LOOP:
	JSR $95CA		; 9390	$20 $CA $95
	LDA #$08		; 9393	$A9 $08
	JSR $972D		; 9395	$20 $2D $97
	LDA b_pressing		; 9398	$A5 $25
	BNE L39380		; 939A	$D0 $E4
	LDA a_pressing		; 939C	$A5 $24
	BEQ MAP_ITEM_USE_LOOP	; 939E	$F0 $F0
	JSR $905E		; 93A0	$20 $5E $90	key reset/sound effect
	LDX $7AF0		; 93A3	$AE $F0 $7A
	LDA $7A03,X		; 93A6	$BD $03 $7A
	TAX			; 93A9	$AA
	LDA $6060,X		; 93AA	$BD $60 $60
	TAX			; 93AD	$AA
	CMP #$10		; 93AE	$C9 $10
	BCS L393B7		; 93B0	$B0 $05
	LDA $7B30,X		; 93B2	$BD $30 $7B
	BNE L393BF		; 93B5	$D0 $08
L393B7:
	LDA #$44		; 93B7	$A9 $44
	JSR $963E		; 93B9	$20 $3E $96
	JMP $9380		; 93BC	$4C $80 $93
; End of
L393BF:
.byte $86
.byte $08,$20,$14,$96,$AD,$F1,$79,$F0,$04,$A9,$49,$85,$E0,$A5,$A0,$A6
.byte $08,$C9,$19,$D0,$17,$E0,$0D,$D0,$10,$A9,$08,$85,$61,$20,$18,$C0
.byte $A9,$4A,$85,$E0,$A0,$19,$4C,$F6,$93,$4C,$80,$93,$C9,$32,$D0,$0C
.byte $E0,$03,$D0,$F5,$A0,$32,$20,$07,$99,$4C,$80,$93,$C9,$34,$D0,$3D

;; [$9400 :: 0x39400]

.byte $E0,$04,$D0,$E5,$A9,$04,$20,$8C,$95,$A9,$47,$85,$E0,$AD,$1A,$60
.byte $29,$EF,$8D,$1A,$60,$A0,$C3,$20,$C7,$98,$A0,$C4,$20,$C7,$98,$A0
.byte $CA,$20,$C7,$98,$A0,$23,$20,$C7,$98,$A0,$67,$20,$C7,$98,$A0,$68
.byte $20,$C7,$98,$A0,$69,$20,$C7,$98,$A0,$1A,$4C,$F6,$93,$C9,$38,$D0
.byte $1D,$E0,$07,$D0,$A4,$A9,$08,$20,$73,$95,$A0,$01,$20,$07,$99,$A0
.byte $DD,$20,$07,$99,$A0,$07,$20,$07,$99,$A0,$38,$4C,$F6,$93,$C9,$39
.byte $D0,$0A,$E0,$08,$D0,$83,$AD,$03,$7B,$4C,$B3,$94,$C9,$3B,$D0,$1A
.byte $E0,$0A,$D0,$66,$A9,$0A,$20,$8C,$95,$A9,$47,$85,$E0,$AD,$1B,$60
.byte $29,$FB,$8D,$1B,$60,$A0,$25,$4C,$F6,$93,$C9,$40,$D0,$09,$E0,$0C
.byte $D0,$48,$A0,$40,$4C,$F6,$93,$C9,$46,$D0,$1D,$E0,$09,$D0,$3B,$A0
.byte $45,$20,$9E,$98,$D0,$34,$A9,$0E,$20,$73,$95,$A0,$46,$20,$07,$99
.byte $AD,$05,$7B,$85,$6C,$4C,$DC,$91,$C9,$54,$D0,$0D,$E0,$06,$D0,$1A
.byte $A9,$47,$85,$E0,$A0,$54,$4C,$F6,$93,$C9,$59,$D0,$0D,$E0,$0B,$D0
.byte $09,$A9,$47,$85,$E0,$A0,$59,$20,$07,$99,$4C,$80,$93,$20,$23,$95
.byte $A5,$1C,$85,$3E,$A5,$1D,$85,$3F,$4C,$AC,$E7
; Name	:
; Marks	: Save variables
	LDA text_win_L		; 94EB	$A5 $38
	STA $7AF8		; 94ED	$8D $F8 $7A
	LDA text_win_T		; 94F0	$A5 $39
	STA $7AF9		; 94F2	$8D $F9 $7A
	LDA $97			; 94F5	$A5 $97
	STA $7AFA		; 94F7	$8D $FA $7A
	LDA $98			; 94FA	$A5 $98
	STA $7AFB		; 94FC	$8D $FB $7A
	LDA menu_win_W		; 94FF	$A5 $3C
	STA $7AFC		; 9501	$8D $FC $7A
	LDA menu_win_H		; 9504	$A5 $3D
	STA $7AFD		; 9506	$8D $FD $7A
	LDA text_bank		; 9509	$A5 $93
	STA $7AF7		; 950B	$8D $F7 $7A
	LDA $1C			; 950E	$A5 $1C
	STA $7AFE		; 9510	$8D $FE $7A
	LDA $1D			; 9513	$A5 $1D
	STA $7AFF		; 9515	$8D $FF $7A
	LDA $3E			; 9518	$A5 $3E
	STA $7AF4		; 951A	$8D $F4 $7A
	LDA $3F			; 951D	$A5 $3F
	STA $7AF5		; 951F	$8D $F5 $7A
	RTS			; 9522	$60
; End of Save variables ??

;; [$9523-
.byte $AD,$F8,$7A,$85,$38,$AD,$F9,$7A,$85,$39,$AD,$FA,$7A
.byte $85,$97,$AD,$FB,$7A,$85,$98,$AD,$FC,$7A,$85,$3C,$AD,$FD,$7A,$85
.byte $3D,$AD,$F7,$7A,$85,$93,$AD,$FE,$7A,$85,$1C,$AD,$FF,$7A,$85,$1D
.byte $AD,$F4,$7A,$85,$3E,$AD,$F5,$7A,$85,$3F,$60
; Name	:
; Marks	:
	LDA #$02		; 955B	$A9 $02
	STA $96			; 955D	$85 $96
	JSR $E91E		; 955F	$20 $1E $E9
	LDA #$41		; 9562	$A9 $41
	JMP $9603		; 9564	$4C $03 $96
; End of

; Name	:
; Marks	:
	LDA #$02		; 9567	$A9 $02
	STA $96			; 9569	$85 $96		text window size ??
	JSR $E91E		; 956B	$20 $1E $E9
	LDA #$42		; 956E	$A9 $42
	JMP $9603		; 9570	$4C $03 $96
; End of

.byte $20,$7C,$95,$B0,$03,$4C,$73,$98,$60,$A2,$00,$DD,$60
.byte $60,$F0,$07,$E8,$E0,$20,$90,$F6,$18,$60,$38,$60,$20,$7C,$95,$90
.byte $05,$A9,$00,$9D,$60,$60,$60,$85,$80,$A2,$0F,$DD,$80,$60,$F0,$18
.byte $CA,$10,$F8,$A2,$0E,$BD,$80,$60,$9D,$81,$60,$CA,$10,$F7,$A5,$80
.byte $8D,$80,$60,$A9,$49,$85,$E0,$60,$CA,$30,$0E,$BD,$80,$60,$9D,$81
.byte $60,$CA,$10,$F7,$A5,$80,$8D,$80,$60,$60
; Name	:
; Marks	: Copy OAM
	JSR Wait_NMI		; 95CA	$20 $00 $FE
	LDA #$02		; 95CD	$A9 $02
	STA SpriteDma_4014	; 95CF	$8D $14 $40
	INC frame_cnt_L		; 95D2	$E6 $F0
	JSR $C74F		; 95D4	$20 $4F $C7	sound ??
	JSR $95E3		; 95D7	$20 $E3 $95	Init OAM ??
	JSR $9652		; 95DA	$20 $52 $96	up ?? sprite copy ?? D0 ??
	JSR $9663		; 95DD	$20 $63 $96	down ?? D1 ??
	JMP $9674		; 95E0	$4C $74 $96	up ?? D2 ??
; End of

; Name	:
; Marks	: Init to F0h something to PPU (OAM?) buffer
	LDX #$2F		; 95E3	$A2 $2F
	LDA #$F0		; 95E5	$A9 $F0		Hide ??
L395E7:
	STA $0210,X		; 95E7	$9D $10 $02
	DEX			; 95EA	$CA
	BPL L395E7		; 95EB	$10 $FA
	LDA #$10		; 95ED	$A9 $10
	STA $26			; 95EF	$85 $26		pointer to next available sprite ??
	RTS			; 95F1	$60
; End of

; Name	:
; Marks	:
	STA text_ID		; 95F2	$85 $92
	LDA #$0A		; 95F4	$A9 $0A
	STA text_bank		; 95F6	$85 $93
	LDA #$00		; 95F8	$A9 $00
	STA text_offset		; 95FA	$85 $94
	LDA #$84		; 95FC	$A9 $84
	STA $95			; 95FE	$85 $95
	JMP $EA54		; 9600	$4C $54 $EA
; End of

; Name	:
; A	: text id
; Marks	:
	STA text_ID		; 9603	$85 $92
	LDA #$0A		; 9605	$A9 $0A
	STA text_bank		; 9607	$85 $93
	LDA #$00		; 9609	$A9 $00
	STA text_offset		; 960B	$85 $94
	LDA #$84		; 960D	$A9 $84
	STA $95			; 960F	$85 $95
	JMP $EA8C		; 9611	$4C $8C $EA
; End of
;; [$9614-
.byte $48,$20,$64,$D1,$A9,$00,$85,$96,$20,$1E,$E9,$A9
.byte $00,$8D,$F1,$79,$68,$85,$92,$A9,$00,$85,$94,$A9,$80,$85,$95,$A5
.byte $A0,$A2,$06,$C9,$60,$90,$02,$A2,$0A,$86,$93,$4C,$54,$EA
; Name	:
; Marks	:
	PHA			; 963E	$48
	JSR $D164		; 963F	$20 $64 $D1	some process(scroll) ??
	LDA #$00		; 9642	$A9 $00
	STA win_type		; 9644	$85 $96		dialogue - 28x10 at (2,2)
	JSR $E91E		; 9646	$20 $1E $E9	draw window and text ??
	LDA #$00		; 9649	$A9 $00
	STA $79F1		; 964B	$8D $F1 $79	length cursor data B ??
	PLA			; 964E	$68
	JMP $95F2		; 964F	$4C $F2 $95
; End of

; Name	:
; Marks	: cursor ??
	LDA $A2			; 9652	$A5 $A2
	BNE L39657		; 9654	$D0 $01		if A != 00h
	RTS			; 9656	$60
; End of
L39657:
	LDY cur_pos		; 9657	$AC $F0 $78
	LDX $7800,Y		; 965A	$BE $00 $78
	LDA $7801,Y		; 965D	$B9 $01 $78
	JMP Cursor		; 9660	$4C $82 $96
; End of 9652
	LDA $A3			; 9663	$A5 $A3
	BNE L39668		; 9665	$D0 $01
	RTS			; 9667	$60
; End of
L39668:
	LDY $79F0		; 9668	$AC $F0 $79
	LDX $7900,Y		; 966B	$BE $00 $79
	LDA $7901,Y		; 966E	$B9 $01 $79
	JMP Cursor		; 9671	$4C $82 $96
; End of
	LDA $A4			; 9674	$A5 $A4
	BNE L39679		; 9676	$D0 $01
	RTS			; 9678	$60
; End of

L39679:
	LDY $7AF0		; 9679	$AC $F0 $7A
	LDX $7A00,Y		; 967C	$BE $00 $7A
	LDA $7A01,Y		; 967F	$B9 $01 $7A
; Name	: Cursor
; A	: OAM Y position of left side of sprite
; X	: OAM X position of top of sprite
; DEST	: $40 = oam_x, $41 = oam_y
; Marks	: 
Cursor:
	ASL A			; 9682	$0A
	ASL A			; 9683	$0A
	ASL A			; 9684	$0A
	STA oam_y		; 9685	$85 $41
	TXA			; 9687	$8A
	ASL A			; 9688	$0A
	ASL A			; 9689	$0A
	ASL A			; 968A	$0A
	STA oam_x		; 968B	$85 $40
	ASL A			; 968D	$0A	What are you doing now?
	ASL A			; 968E	$0A
	ASL A			; 968F	$0A
	JMP Set_cursor		; 9690	$4C $A1 $DE
; End of Cursor

; Name	:
; Ret	: A(key value ??)
; Marks	:
	JSR $DB5C		; 9693	$20 $5C $DB	event and key check ??
	LDA key1p		; 9696	$A5 $20
	AND #$0F		; 9698	$29 $0F
	BEQ L396A8		; 969A	$F0 $0C
	CMP $A1			; 969C	$C5 $A1		before key value ??
	BEQ L396AF		; 969E	$F0 $0F
	STA $A1			; 96A0	$85 $A1
	JSR SndE_cur_mov	; 96A2	$20 $45 $DB	cursor move sound effect
	LDA $A1			; 96A5	$A5 $A1
	RTS			; 96A7	$60
; End of

L396A8:
	LDA #$00		; 96A8	$A9 $00
	STA $47			; 96AA	$85 $47
	STA $A1			; 96AC	$85 $A1
	RTS			; 96AE	$60
; End of
L396AF:
	LDA $47			; 96AF	$A5 $47
	CLC			; 96B1	$18
	ADC #$01		; 96B2	$69 $01
	STA $47			; 96B4	$85 $47
	CMP #$10		; 96B6	$C9 $10
	BCC L396C2		; 96B8	$90 $08
	AND #$03		; 96BA	$29 $03
	BNE L396C2		; 96BC	$D0 $04
	LDA #$00		; 96BE	$A9 $00
	STA $A1			; 96C0	$85 $A1
L396C2:
	LDA #$00		; 96C2	$A9 $00
	RTS			; 96C4	$60
; End of

; Name	:
; A	: size of cursor step
; Marks	: Check cursor position
	STA $06			; 96C5	$85 $06
	JSR $9693		; 96C7	$20 $93 $96	event, key ??
	AND #$0F		; 96CA	$29 $0F
	BEQ L396E8		; 96CC	$F0 $1A		if key not pressing
	CMP #$04		; 96CE	$C9 $04		up,down
	BCS L396D6		; 96D0	$B0 $04		if up,down key pressing
	LDX #$04		; 96D2	$A2 $04
	STX $06			; 96D4	$86 $06
L396D6:
	AND #$05		; 96D6	$29 $05
	BNE L396E9		; 96D8	$D0 $0F		if down,right key pressing
	LDA cur_pos		; 96DA	$AD $F0 $78
	SEC			; 96DD	$38
	SBC $06			; 96DE	$E5 $06		cursor position offset
	BCS L396E5		; 96E0	$B0 $03		if A >= 0
	ADC len_cur_dat		; 96E2	$6D $F1 $78	to last cursor position
L396E5:
	STA cur_pos		; 96E5	$8D $F0 $78
L396E8:
	RTS			; 96E8	$60
; End of

; Marks	: down key pressed -> cursor
L396E9:
	LDA cur_pos		; 96E9	$AD $F0 $78
	CLC			; 96EC	$18
	ADC $06			; 96ED	$65 $06
	CMP len_cur_dat		; 96EF	$CD $F1 $78
	BCC L396E5		; 96F2	$90 $F1
	SBC len_cur_dat		; 96F4	$ED $F1 $78
	BCS L396E5		; 96F7	$B0 $EC
	STA $06			; 96F9	$85 $06
	JSR $9693		; 96FB	$20 $93 $96
.byte $29,$0F

;; [$9700 :: 0x39700]

.byte $F0,$1A,$C9,$04,$B0,$04,$A2,$04,$86,$06,$29,$05,$D0,$0F,$AD,$F0
.byte $79,$38,$E5,$06,$B0,$03,$6D,$F1,$79,$8D,$F0,$79,$60,$AD,$F0,$79
.byte $18,$65,$06,$CD,$F1,$79,$90,$F1,$ED,$F1,$79,$B0,$EC
; Name	:
; A	:
; Marks	:
	STA $05			; 972D	$85 $05
	STA $06			; 972F	$85 $06
	JSR $9693		; 9731	$20 $93 $96	event? key check
	AND #$0F		; 9734	$29 $0F
	BEQ L39760		; 9736	$F0 $28		if pad not pressing
	CMP #$04		; 9738	$C9 $04
	BCS L39740		; 973A	$B0 $04
	LDX #$04		; 973C	$A2 $04
	STX $06			; 973E	$86 $06
L39740:
	AND #$05		; 9740	$29 $05
	BNE L39761		; 9742	$D0 $1D
	LDA $7AF0		; 9744	$AD $F0 $7A
	SEC			; 9746	$38
	SBC $06			; 9747	$E5 $06
	BCS L3975D		; 974A	$B0 $11
	ADC $05			; 974C	$65 $05
	STA $05			; 974E	$85 $05
	JSR $9523		; 9750	$20 $23 $95
.byte $20,$B6,$E7,$B0,$22,$20,$EB,$94,$A5,$05
L3975D:
	STA $7AF0		; 975D	$8D $F0 $7A
L39760:
	RTS			; 9760	$60
; End of
L39761:
	LDA $7AF0		; 9761	$AD $F0 $7A
	CLC			; 9764	$18
	ADC $06			; 9765	$65 $06
	BCS L3976E		; 9767	$B0 $05
	CMP $7AF1		; 9769	$CD $F1 $7A
	BCC L3975D		; 976C	$90 $EF
L3976E:
	SBC $05			; 976E	$E5 $05
	STA $05			; 9770	$85 $05
	JSR $9523		; 9772	$20 $23 $95
.byte $20,$97,$E7,$90,$07,$A9,$00,$85,$47,$4C,$67
.byte $DE,$20,$EB,$94,$A5,$05,$CD,$F1,$7A,$90,$D2,$AD,$F1,$7A,$38,$E9
.byte $04,$4C,$5D,$97
; Name	:
; X	: npc id ??
; Ret	: A(text_ID)
; Marks	: $94(ADDR) ??, $84(ADDR) = pointer to npc scripts
	LDA #$06		; 9794	$A9 $06
	STA text_bank		; 9796	$85 $93
	LDA #$00		; 9798	$A9 $00
	STA text_offset		; 979A	$85 $94
	LDA #$80		; 979C	$A9 $80
	STA $95			; 979E	$85 $95
	LDA npc_id,X		; 97A0	$BD $00 $75
	STA $A0			; 97A3	$85 $A0		npc id temp ??
	CMP #$C0		; 97A5	$C9 $C0
	BCS L397FE		; 97A7	$B0 $55
	CMP #$60		; 97A9	$C9 $60
	BCC L397B1		; 97AB	$90 $04
	LDX #$0A		; 97AD	$A2 $0A
	STX text_bank		; 97AF	$86 $93
L397B1:
	ASL A			; 97B1	$0A
	TAX			; 97B2	$AA
	BCS L397C0		; 97B3	$B0 $0B
	LDA $8200,X		; 97B5	$BD $00 $82	pointer to npc scripts
	STA $84			; 97B8	$85 $84
	LDA $8201,X		; 97BA	$BD $01 $82
	JMP $97C8		; 97BD	$4C $C8 $97
; End of
L397C0:
.byte $BD,$00,$83,$85,$84,$BD,$01,$83
; X	: pointers to npc scripts(High byte)
; Marks	: $84(ADDR) = pointer to npc script
;	  $86(ADDR) = code pointer ??
	STA $85			; 97C8	$85 $85
	LDY #$17		; 97CA	$A0 $17		17h bytes
L397CC:
	LDA ($84),Y		; 97CC	$B1 $84
	STA $7B00,Y		; 97CE	$99 $00 $7B	$7B00 = generic buffer
	DEY			; 97D1	$88
	BPL L397CC		; 97D2	$10 $F8		loop - copy npc scripts
	LDY #$1F		; 97D4	$A0 $1F
	LDA #$00		; 97D6	$A9 $00
L397D8:
	STA $7B20,Y		; 97D8	$99 $20 $7B
	DEY			; 97DB	$88
	BPL L397D8		; 97DC	$10 $FA		loop - init ($7B20-$7CF0)
	LDA $A0			; 97DE	$A5 $A0		npc id temp ??
	ASL A			; 97E0	$0A
	TAY			; 97E1	$A8
	BCC L397F1		; 97E2	$90 $0D
	LDA $9A23,Y		; 97E4	$B9 $23 $9A
	STA $86			; 97E7	$85 $86
	LDA $9A24,Y		; 97E9	$B9 $24 $9A
	STA $87			; 97EC	$85 $87
	JMP ($0086)		; 97EE	$6C $86 $00
L397F1:
	LDA $9923,Y		; 97F1	$B9 $23 $99
	STA $86			; 97F4	$85 $86
	LDA $9924,Y		; 97F6	$B9 $24 $99
	STA $87			; 97F9	$85 $87
	JMP ($0086)		; 97FB	$6C $86 $00
L397FE:
	RTS			; 97FE	$60
; End of
.byte $A2

;; [$9800 :: 0x39800]

.byte $3F,$BD,$C0,$61,$9D,$90,$60,$CA,$10,$F7,$A2,$2F,$BD,$C0,$62,$9D
.byte $D0,$60,$CA,$10,$F7,$A2,$05,$BD,$F0,$62,$9D,$F6,$62,$CA,$10,$F7
.byte $60,$A2,$3F,$BD,$C0,$61,$48,$BD,$90,$60,$9D,$C0,$61,$68,$9D,$90
.byte $60,$CA,$10,$EF,$A2,$2F,$BD,$C0,$62,$48,$BD,$D0,$60,$9D,$C0,$62
.byte $68,$9D,$D0,$60,$CA,$10,$EF,$A2,$05,$BD,$F0,$62,$48,$BD,$F6,$62
.byte $9D,$F0,$62,$68,$9D,$F6,$62,$CA,$10,$EF,$A9,$00,$8D,$F5,$62,$8D
.byte $C1,$61,$60,$A0,$00,$B9,$60,$60,$F0,$07,$C8,$C0,$20,$90,$F6,$38
.byte $60,$18,$60,$85,$80,$20,$63,$98,$B0,$0A,$A5,$80,$99,$60,$60,$C9
.byte $10,$90,$02,$18,$60,$A8,$B9,$00,$A4,$85,$81,$B9,$00,$A5,$A8,$B9
.byte $1A,$60,$05,$81,$99,$1A,$60,$A9,$47,$85,$E0,$18,$60,$60
; Name	:
; Ret	: A
; Marks	: $80(ADDR) ??
	STY $81			; 989E	$84 $81		temp buffer
	LDA $A400,Y		; 98A0	$B9 $00 $A4
	STA $80			; 98A3	$85 $80
	LDA $A500,Y		; 98A5	$B9 $00 $A5
	TAY			; 98A8	$A8
	LDA $6040,Y		; 98A9	$B9 $40 $60	event/npc switches
	LDY $81			; 98AC	$A4 $81		temp buffer
	AND $80			; 98AE	$25 $80
	RTS			; 98B0	$60
; End of

.byte $84,$80,$B9,$00,$A4,$85,$81,$B9,$00,$A5,$A8,$B9,$40,$60,$05
.byte $81,$99,$40,$60,$A4,$80,$60,$20,$B1,$98,$A0,$00,$A5,$80,$D9,$0A
.byte $75,$F0,$0A,$98,$18,$69,$10,$A8,$C9,$C0,$90,$F0,$60,$99,$00,$75
.byte $60,$85,$6A,$A9,$20,$85,$44,$60,$85,$45,$A9,$80,$85,$44,$60,$84
.byte $80,$B9,$00,$A4,$85,$81,$B9,$00,$A5,$A8,$A5,$81,$49,$FF,$39,$40

;; [$9900 :: 0x39900]

.byte $60,$99,$40,$60,$A4,$80,$60,$20,$EF,$98,$A0,$00,$A5,$80,$D9,$00
.byte $75,$F0,$0A,$98,$18,$69,$10,$A8,$C9,$F0,$90,$F0,$60,$A9,$00,$99
;; [$9923 - data ?? code pointer
.byte $00,$75,$60,$A3,$9A,$A4,$9A,$55,$9B,$59,$9B,$76,$9B,$8B,$9B,$30
.byte $9C,$3F,$9C,$82,$9C,$B2,$9C,$DF,$9C,$E8,$9C,$15,$9D,$29,$9D,$60
.byte $9D,$64,$9D,$CE,$9D,$D8,$9D,$13,$9E,$55,$9E,$9A,$9E,$A8,$9E,$55
.byte $9B,$DD,$9E,$ED,$9E,$1E,$9F,$40,$9F,$44,$9F,$56,$9F,$5A,$9F,$30
.byte $9C,$30,$9C,$6B,$9F,$55,$9B,$B4,$9F,$55,$9B,$30,$9C,$CE,$9F,$09
.byte $A0,$17,$A0,$44,$9F,$55,$9B,$30,$9C,$24,$A0,$55,$9B,$55,$9B,$41
.byte $A0,$30,$9C,$4B,$A0,$55,$A0,$68,$A0,$78,$A0,$7C,$A0,$9D,$A0,$C4
.byte $A0,$55,$9B,$D8,$A0,$EB,$A0,$00,$A1,$18,$A1,$2D,$A1,$44,$9F,$4D
.byte $9F,$37,$A1,$95,$A1,$AF,$A1,$B3,$A1,$B7,$A1,$BB,$A1,$ED,$A1,$01
.byte $A2,$55,$9B,$30,$9C,$30,$9C,$30,$9C,$30,$9C,$30,$9C,$25,$A2,$3A
.byte $A2,$55,$9B,$55,$9B,$55,$9B,$55,$9B,$55,$9B,$80,$A2,$8A,$A2,$92
.byte $A2,$9F,$A2,$9F,$A2,$F4,$A2,$55,$9B,$55,$9B,$62,$9F,$55,$9B,$FE
.byte $A2,$2D,$A1,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08
.byte $A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08

;; [$9A00 :: 0x39A00]

.byte $A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08
.byte $A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08,$A3,$08
;; [$9A23 - data ?? - code pointer
.byte $A3,$08,$A3,$7A,$A3,$7A,$A3,$7E,$A3,$7E,$A3,$7E,$A3,$7E,$A3,$7E
.byte $A3,$7E,$A3,$98,$A3,$98,$A3,$98,$A3,$98,$A3,$98,$A3,$98,$A3,$98
.byte $A3,$98,$A3,$C4,$A3,$C4,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8
.byte $A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8
.byte $A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8,$A3,$C8
.byte $A3,$C8,$A3,$C8,$A3,$C8,$A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED
.byte $A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED,$A3,$ED
.byte $A3,$ED,$A3,$F1,$A3,$F1,$A3,$F1,$A3,$F1,$A3,$F1,$A3,$F1,$A3,$F1
.byte $A3,$F1,$A3,$60,$A0,$50,$20,$9E,$98,$D0,$16,$AD,$01,$7B,$8D,$21
.byte $7B,$AD,$02,$7B,$8D,$31,$7B,$AD,$14,$7B,$8D,$22,$7B,$AD,$00,$7B
.byte $60,$A0,$08,$20,$9E,$98,$F0,$04,$AD,$03,$7B,$60,$A0,$C3,$20,$9E
.byte $98,$D0,$1C,$AD,$05,$7B,$8D,$22,$7B,$AD,$06,$7B,$8D,$23,$7B,$AD
.byte $07,$7B,$8D,$34,$7B,$AD,$08,$7B,$8D,$25,$7B,$AD,$04,$7B,$60,$A0
.byte $51,$20,$9E,$98,$D0,$0A,$AD,$0A,$7B,$8D,$23,$7B,$AD,$09,$7B,$60

;; [$9B00 :: 0x39B00]

.byte $A0,$09,$20,$9E,$98,$D0,$17,$20,$08,$F3,$90,$04,$AD,$0B,$7B,$60
.byte $A9,$80,$8D,$F5,$62,$A0,$09,$20,$C7,$98,$AD,$0C,$7B,$60,$A0,$13
.byte $20,$9E,$98,$F0,$16,$AD,$0E,$7B,$8D,$23,$7B,$AD,$0F,$7B,$8D,$26
.byte $7B,$AD,$10,$7B,$8D,$27,$7B,$AD,$0D,$7B,$60,$A0,$2B,$20,$9E,$98
.byte $F0,$04,$AD,$11,$7B,$60,$A0,$0C,$20,$9E,$98,$F0,$04,$AD,$12,$7B
.byte $60,$AD,$13,$7B,$60,$AD,$00,$7B,$60,$A0,$25,$20,$9E,$98,$F0,$04
.byte $AD,$00,$7B,$60,$20,$08,$F3,$90,$04,$AD,$03,$7B,$60,$AD,$02,$7B
.byte $85,$6C,$AD,$01,$7B,$60,$A0,$17,$20,$9E,$98,$F0,$0A,$AD,$01,$7B
.byte $8D,$21,$7B,$AD,$00,$7B,$60,$AD,$02,$7B,$60,$AD,$1B,$60,$29,$08
.byte $D0,$28,$AD,$01,$7B,$8D,$28,$7B,$AD,$02,$7B,$8D,$29,$7B,$AD,$03
.byte $7B,$8D,$2A,$7B,$AD,$04,$7B,$8D,$2B,$7B,$AD,$05,$7B,$8D,$2E,$7B
.byte $AD,$06,$7B,$8D,$2F,$7B,$AD,$00,$7B,$60,$AD,$1B,$60,$29,$20,$D0
.byte $04,$AD,$07,$7B,$60,$A0,$19,$20,$9E,$98,$F0,$04,$AD,$08,$7B,$60
.byte $A0,$45,$20,$9E,$98,$F0,$10,$AD,$0A,$7B,$8D,$2A,$7B,$AD,$0B,$7B
.byte $8D,$2B,$7B,$AD,$09,$7B,$60,$A0,$46,$20,$9E,$98,$F0,$10,$AD,$0D
.byte $7B,$8D,$2B,$7B,$AD,$0E,$7B,$8D,$2C,$7B,$AD,$0C,$7B,$60,$A0,$29

;; [$9C00 :: 0x39C00]

.byte $20,$9E,$98,$F0,$10,$AD,$10,$7B,$8D,$2B,$7B,$AD,$11,$7B,$8D,$2C
.byte $7B,$AD,$0F,$7B,$60,$A0,$1D,$20,$9E,$98,$F0,$0A,$AD,$13,$7B,$8D
.byte $24,$7B,$AD,$12,$7B,$60,$AD,$15,$7B,$8D,$2D,$7B,$AD,$14,$7B,$60
.byte $A4,$A0,$20,$07,$99,$AD,$01,$7B,$20,$E1,$98,$AD,$00,$7B,$60,$A0
.byte $51,$20,$9E,$98,$D0,$10,$AD,$01,$7B,$8D,$23,$7B,$AD,$02,$7B,$8D
.byte $25,$7B,$AD,$00,$7B,$60,$A0,$01,$20,$9E,$98,$F0,$16,$AD,$04,$7B
.byte $8D,$23,$7B,$AD,$05,$7B,$8D,$25,$7B,$AD,$06,$7B,$8D,$27,$7B,$AD
.byte $03,$7B,$60,$A0,$39,$20,$9E,$98,$F0,$04,$AD,$07,$7B,$60,$AD,$08
.byte $7B,$60,$A0,$50,$20,$9E,$98,$D0,$0A,$AD,$01,$7B,$8D,$21,$7B,$AD
.byte $00,$7B,$60,$A9,$02,$20,$73,$98,$B0,$14,$A0,$08,$20,$07,$99,$A9
.byte $04,$85,$61,$20,$18,$C0,$A9,$4A,$85,$E0,$AD,$03,$7B,$60,$AD,$02
.byte $7B,$60,$A0,$01,$20,$9E,$98,$F0,$1C,$AD,$01,$7B,$8D,$23,$7B,$AD
.byte $02,$7B,$8D,$25,$7B,$AD,$03,$7B,$8D,$26,$7B,$AD,$04,$7B,$8D,$27
.byte $7B,$AD,$00,$7B,$60,$AD,$06,$7B,$8D,$23,$7B,$AD,$05,$7B,$60,$AD
.byte $01,$7B,$85,$6C,$AD,$00,$7B,$60,$A0,$C3,$20,$9E,$98,$D0,$1C,$AD
.byte $01,$7B,$8D,$21,$7B,$AD,$02,$7B,$8D,$22,$7B,$AD,$03,$7B,$8D,$23

;; [$9D00 :: 0x39D00]

.byte $7B,$AD,$05,$7B,$8D,$31,$7B,$AD,$00,$7B,$60,$AD,$06,$7B,$8D,$23
.byte $7B,$AD,$04,$7B,$60,$A0,$0C,$20,$07,$99,$A9,$06,$85,$61,$20,$18
.byte $C0,$A9,$4A,$85,$E0,$AD,$00,$7B,$60,$A0,$25,$20,$9E,$98,$F0,$1B
.byte $AD,$1B,$60,$29,$04,$D0,$10,$AD,$01,$7B,$8D,$2A,$7B,$AD,$02,$7B
.byte $8D,$2B,$7B,$AD,$00,$7B,$60,$AD,$03,$7B,$60,$A0,$03,$20,$9E,$98
.byte $F0,$04,$AD,$04,$7B,$60,$AD,$06,$7B,$8D,$2B,$7B,$AD,$05,$7B,$60
.byte $AD,$00,$7B,$60,$AD,$1B,$60,$29,$08,$D0,$16,$AD,$01,$7B,$8D,$28
.byte $7B,$AD,$02,$7B,$8D,$29,$7B,$AD,$03,$7B,$8D,$2F,$7B,$AD,$00,$7B
.byte $60,$A0,$19,$20,$9E,$98,$F0,$04,$AD,$04,$7B,$60,$A0,$45,$20,$9E
.byte $98,$F0,$04,$AD,$05,$7B,$60,$A0,$46,$20,$9E,$98,$F0,$0A,$AD,$07
.byte $7B,$8D,$2C,$7B,$AD,$06,$7B,$60,$A0,$29,$20,$9E,$98,$F0,$04,$AD
.byte $08,$7B,$60,$A0,$1D,$20,$9E,$98,$F0,$0A,$AD,$0A,$7B,$8D,$24,$7B
.byte $AD,$09,$7B,$60,$AD,$0C,$7B,$8D,$2D,$7B,$AD,$0B,$7B,$60,$AD,$01
.byte $7B,$8D,$21,$7B,$AD,$00,$7B,$60,$A0,$33,$20,$07,$99,$A0,$33,$20
.byte $07,$99,$A0,$33,$20,$07,$99,$A0,$33,$20,$07,$99,$A0,$11,$20,$07
.byte $99,$A0,$21,$20,$07,$99,$A0,$22,$20,$C7,$98,$A0,$84,$20,$B1,$98

;; [$9E00 :: 0x39E00]

.byte $A0,$85,$20,$B1,$98,$A0,$86,$20,$B1,$98,$A0,$87,$20,$B1,$98,$AD
.byte $00,$7B,$60,$A0,$41,$20,$9E,$98,$F0,$0A,$AD,$07,$7B,$8D,$2F,$7B
.byte $AD,$00,$7B,$60,$A0,$29,$20,$9E,$98,$F0,$0A,$AD,$02,$7B,$8D,$2C
.byte $7B,$AD,$01,$7B,$60,$A0,$26,$20,$9E,$98,$F0,$04,$AD,$03,$7B,$60
.byte $A0,$1D,$20,$9E,$98,$F0,$0A,$AD,$05,$7B,$8D,$24,$7B,$AD,$04,$7B
.byte $60,$AD,$06,$7B,$60,$A0,$21,$20,$9E,$98,$F0,$1C,$AD,$01,$7B,$8D
.byte $21,$7B,$AD,$02,$7B,$8D,$22,$7B,$AD,$03,$7B,$8D,$23,$7B,$AD,$04
.byte $7B,$8D,$25,$7B,$AD,$00,$7B,$60,$AD,$06,$7B,$8D,$22,$7B,$AD,$07
.byte $7B,$8D,$23,$7B,$AD,$08,$7B,$8D,$25,$7B,$AD,$09,$7B,$8D,$34,$7B
.byte $AD,$0A,$7B,$8D,$26,$7B,$AD,$05,$7B,$60,$A0,$14,$20,$07,$99,$A9
.byte $01,$8D,$00,$60,$AD,$00,$7B,$60,$AD,$01,$7B,$60,$A0,$52,$20,$9E
.byte $98,$F0,$0F,$A0,$52,$20,$EF,$98,$AD,$01,$7B,$20,$E1,$98,$AD,$00
.byte $7B,$60,$A0,$15,$20,$07,$99,$20,$FF,$97,$A9,$07,$85,$61,$20,$18
.byte $C0,$A9,$4A,$85,$E0,$A9,$40,$85,$44,$AD,$02,$7B,$60,$A0,$17,$20
.byte $07,$99,$20,$21,$98,$A9,$4A,$85,$E0,$AD,$00,$7B,$60,$A0,$45,$20
.byte $9E,$98,$F0,$04,$AD,$00,$7B,$60,$A0,$29,$20,$9E,$98,$F0,$04,$AD

;; [$9F00 :: 0x39F00]

.byte $01,$7B,$60,$A0,$1D,$20,$9E,$98,$F0,$0A,$AD,$03,$7B,$8D,$24,$7B
.byte $AD,$02,$7B,$60,$AD,$05,$7B,$8D,$2D,$7B,$AD,$04,$7B,$60,$AD,$01
.byte $7B,$8D,$28,$7B,$AD,$02,$7B,$8D,$29,$7B,$AD,$03,$7B,$8D,$2B,$7B
.byte $AD,$04,$7B,$8D,$2A,$7B,$AD,$05,$7B,$8D,$3D,$7B,$AD,$00,$7B,$60
.byte $AD,$00,$7B,$60,$AD,$01,$7B,$85,$6C,$AD,$00,$7B,$60,$20,$08,$F3
.byte $90,$F2,$AD,$02,$7B,$60,$AD,$00,$7B,$60,$20,$08,$F3,$B0,$F3,$4C
.byte $44,$9F,$A4,$A0,$20,$07,$99,$AD,$00,$7B,$60,$A0,$50,$20,$9E,$98
.byte $D0,$04,$AD,$00,$7B,$60,$A0,$09,$20,$9E,$98,$D0,$16,$AD,$02,$7B
.byte $8D,$21,$7B,$AD,$03,$7B,$8D,$22,$7B,$AD,$04,$7B,$8D,$23,$7B,$AD
.byte $01,$7B,$60,$A0,$01,$20,$9E,$98,$F0,$16,$AD,$06,$7B,$8D,$25,$7B
.byte $AD,$07,$7B,$8D,$26,$7B,$AD,$08,$7B,$8D,$27,$7B,$AD,$05,$7B,$60
.byte $AD,$09,$7B,$60,$A0,$13,$20,$9E,$98,$F0,$04,$AD,$00,$7B,$60,$A0
.byte $37,$20,$9E,$98,$D0,$04,$AD,$01,$7B,$60,$AD,$02,$7B,$60,$A9,$02
.byte $2D,$1B,$60,$D0,$10,$AD,$01,$7B,$8D,$2A,$7B,$AD,$02,$7B,$8D,$2B
.byte $7B,$AD,$00,$7B,$60,$A9,$04,$2D,$1B,$60,$F0,$04,$AD,$07,$7B,$60
.byte $20,$63,$98,$90,$04,$AD,$03,$7B,$60,$AD,$05,$7B,$8D,$2A,$7B,$AD

;; [$A000 :: 0x3A000]

.byte $06,$7B,$8D,$2B,$7B,$AD,$04,$7B,$60,$A9,$04,$8D,$04,$60,$AD,$01
.byte $7B,$85,$6C,$AD,$00,$7B,$60,$A0,$1C,$20,$C7,$98,$A0,$02,$20,$07
.byte $99,$4C,$62,$9F,$A9,$06,$20,$73,$98,$90,$04,$AD,$00,$7B,$60,$A0
.byte $24,$20,$C7,$98,$A0,$2B,$20,$07,$99,$A9,$47,$85,$E0,$AD,$01,$7B
.byte $60,$AD,$01,$7B,$8D,$2F,$7B,$AD,$00,$7B,$60,$AD,$01,$7B,$8D,$21
.byte $7B,$AD,$00,$7B,$60,$20,$63,$98,$90,$04,$AD,$00,$7B,$60,$AD,$02
.byte $7B,$8D,$21,$7B,$AD,$01,$7B,$60,$AD,$01,$7B,$8D,$33,$7B,$AD,$02
.byte $7B,$8D,$21,$7B,$AD,$00,$7B,$60,$AD,$00,$7B,$60,$A0,$C3,$20,$9E
.byte $98,$D0,$16,$AD,$01,$7B,$8D,$21,$7B,$AD,$02,$7B,$8D,$22,$7B,$AD
.byte $03,$7B,$8D,$34,$7B,$AD,$00,$7B,$60,$AD,$04,$7B,$60,$A0,$23,$20
.byte $9E,$98,$D0,$10,$AD,$01,$7B,$8D,$21,$7B,$AD,$02,$7B,$8D,$23,$7B
.byte $AD,$00,$7B,$60,$AD,$04,$7B,$8D,$21,$7B,$AD,$05,$7B,$8D,$23,$7B
.byte $AD,$03,$7B,$60,$A0,$13,$20,$9E,$98,$F0,$04,$AD,$00,$7B,$60,$A0
.byte $36,$20,$07,$99,$AD,$01,$7B,$60,$20,$63,$98,$90,$04,$AD,$00,$7B
.byte $60,$AD,$02,$7B,$8D,$37,$7B,$AD,$01,$7B,$60,$A0,$02,$20,$9E,$98
.byte $F0,$04,$AD,$00,$7B,$60,$AD,$02,$7B,$8D,$38,$7B,$AD,$01,$7B,$60

;; [$A100 :: 0x3A100]

.byte $A9,$09,$20,$73,$98,$90,$04,$AD,$00,$7B,$60,$A0,$3A,$20,$07,$99
.byte $A9,$47,$85,$E0,$AD,$01,$7B,$60,$A0,$25,$20,$9E,$98,$F0,$0A,$AD
.byte $01,$7B,$8D,$3A,$7B,$AD,$00,$7B,$60,$AD,$02,$7B,$60,$AD,$01,$7B
.byte $20,$E1,$98,$AD,$00,$7B,$60,$A0,$3F,$20,$07,$99,$AD,$12,$60,$49
.byte $11,$8D,$12,$60,$A0,$5F,$20,$EF,$98,$A0,$05,$20,$C7,$98,$A0,$0F
.byte $20,$C7,$98,$A0,$12,$20,$B1,$98,$A0,$92,$20,$C7,$98,$A0,$93,$20
.byte $C7,$98,$A0,$94,$20,$C7,$98,$A0,$95,$20,$C7,$98,$AD,$52,$60,$09
.byte $C0,$8D,$52,$60,$A9,$FF,$8D,$53,$60,$8D,$54,$60,$AD,$55,$60,$09
.byte $03,$8D,$55,$60,$AD,$5A,$60,$09,$0E,$8D,$5A,$60,$AD,$01,$7B,$85
.byte $6C,$AD,$00,$7B,$60,$A0,$59,$20,$9E,$98,$F0,$09,$AD,$01,$7B,$85
.byte $6C,$AD,$00,$7B,$60,$AD,$03,$7B,$8D,$3C,$7B,$AD,$02,$7B,$60,$A9
.byte $10,$D0,$0A,$A9,$11,$D0,$06,$A9,$14,$D0,$02,$A9,$13,$85,$80,$A5
.byte $F0,$29,$C0,$05,$80,$AA,$BD,$00,$61,$18,$69,$0A,$C9,$64,$90,$02
.byte $A9,$63,$9D,$00,$61,$BD,$10,$61,$18,$69,$0A,$C9,$64,$90,$02,$A9
.byte $63,$9D,$10,$61,$A4,$A0,$20,$07,$99,$AD,$00,$7B,$60,$A9,$BF,$20
.byte $73,$98,$90,$04,$AD,$00,$7B,$60,$AD,$02,$7B,$85,$6C,$AD,$01,$7B

;; [$A200 :: 0x3A200]

.byte $60,$A0,$45,$20,$9E,$98,$F0,$0A,$AD,$01,$7B,$8D,$39,$7B,$AD,$00
.byte $7B,$60,$20,$63,$98,$90,$04,$AD,$02,$7B,$60,$AD,$04,$7B,$8D,$39
.byte $7B,$AD,$03,$7B,$60
; A	; return
; Marks	:
; Chocobo_caught
	LDA #$01		; A225	$A9 $01
	STA chocobo_stat	; A227	$8D $08 $60
	LDA chocobo_x_		; A22A	$AD $3E $62
	STA chocobo_x		; A22D	$8D $09 $60
	LDA chocobo_y_		; A230	$AD $3F $62
	STA chocobo_y		; A233	$8D $0A $60
	LDA $7B00		; A236	$AD $00 $7B
	RTS			; A239	$60
; End of Chocobo_caught

.byte $AD,$01,$7B,$8D,$22,$7B
.byte $AD,$02,$7B,$8D,$24,$7B,$AD,$03,$7B,$8D,$25,$7B,$AD,$04,$7B,$8D
.byte $26,$7B,$AD,$05,$7B,$8D,$27,$7B,$AD,$06,$7B,$8D,$28,$7B,$AD,$07
.byte $7B,$8D,$29,$7B,$AD,$08,$7B,$8D,$2A,$7B,$AD,$09,$7B,$8D,$2B,$7B
.byte $AD,$0A,$7B,$8D,$2E,$7B,$AD,$0B,$7B,$8D,$2D,$7B,$AD,$00,$7B,$60
.byte $AD,$01,$7B,$8D,$36,$7B,$AD,$00,$7B,$60,$A0,$56,$20,$C7,$98,$4C
.byte $62,$9F,$A0,$57,$20,$C7,$98,$A0,$58,$20,$C7,$98,$4C,$62,$9F,$AD
.byte $1B,$60,$29,$02,$D0,$10,$AD,$01,$7B,$8D,$2A,$7B,$AD,$02,$7B,$8D
.byte $2B,$7B,$AD,$00,$7B,$60,$A0,$25,$20,$9E,$98,$F0,$04,$AD,$03,$7B
.byte $60,$A0,$19,$20,$9E,$98,$F0,$04,$AD,$04,$7B,$60,$A0,$1D,$20,$9E
.byte $98,$F0,$04,$AD,$05,$7B,$60,$A5,$A0,$C9,$58,$F0,$04,$AD,$06,$7B
.byte $60,$20,$63,$98,$90,$04,$AD,$06,$7B,$60,$AD,$08,$7B,$8D,$2A,$7B
.byte $AD,$07,$7B,$60,$AD,$01,$7B,$8D,$3B,$7B,$AD,$00,$7B,$60,$AD,$01

;; [$A300 :: 0x3A300]

.byte $7B,$8D,$26,$7B,$AD,$00,$7B,$60
; ret	: A = text ID
	LDY #$50		; A308	$A0 $50
	JSR $989E		; A30A	$20 $9E $98
	BNE L3A313		; A30D	$D0 $04
	LDA $7B00		; A30F	$AD $00 $7B	text ID
	RTS			; A312	$60
; End of

L3A313:
.byte $A0,$C3,$20,$9E,$98,$D0,$04,$AD,$01,$7B,$60,$A0,$51
.byte $20,$9E,$98,$D0,$04,$AD,$02,$7B,$60,$A0,$38,$20,$9E,$98,$F0,$04
.byte $AD,$03,$7B,$60,$A0,$39,$20,$9E,$98,$F0,$04,$AD,$04,$7B,$60,$A0
.byte $20,$20,$9E,$98,$F0,$04,$AD,$05,$7B,$60,$A0,$25,$20,$9E,$98,$F0
.byte $04,$AD,$06,$7B,$60,$A0,$03,$20,$9E,$98,$F0,$04,$AD,$07,$7B,$60
.byte $A0,$04,$20,$9E,$98,$D0,$04,$AD,$08,$7B,$60,$A0,$05,$20,$9E,$98
.byte $D0,$04,$AD,$09,$7B,$60,$AD,$0A,$7B,$60,$AD,$00,$7B,$60,$A0,$33
.byte $20,$9E,$98,$F0,$04,$AD,$00,$7B,$60,$A0,$2B,$20,$9E,$98,$F0,$04
.byte $AD,$01,$7B,$60,$AD,$02,$7B,$60,$A0,$1A,$20,$9E,$98,$F0,$04,$AD
.byte $00,$7B,$60,$A0,$23,$20,$9E,$98,$F0,$04,$AD,$01,$7B,$60,$A0,$51
.byte $20,$9E,$98,$F0,$0B,$A0,$39,$20,$9E,$98,$F0,$04,$AD,$02,$7B,$60
.byte $AD,$03,$7B,$60,$AD,$00,$7B,$60,$A0,$41,$20,$9E,$98,$F0,$04,$AD
.byte $00,$7B,$60,$A0,$29,$20,$9E,$98,$F0,$04,$AD,$01,$7B,$60,$A0,$1D
.byte $20,$9E,$98,$F0,$04,$AD,$02,$7B,$60,$AD,$03,$7B,$60,$AD,$00,$7B
.byte $60,$A0,$41,$20,$9E,$98,$F0,$04,$AD,$00,$7B,$60,$AD,$01,$7B,$60

;; [$A400 :: 0x3A400]

.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80
.byte $01,$02,$04,$08,$10,$20,$40,$80,$01,$02,$04,$08,$10,$20,$40,$80

;; [$A500 :: 0x3A500]

.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$01
.byte $02,$02,$02,$02,$02,$02,$02,$02,$03,$03,$03,$03,$03,$03,$03,$03
.byte $04,$04,$04,$04,$04,$04,$04,$04,$05,$05,$05,$05,$05,$05,$05,$05
.byte $06,$06,$06,$06,$06,$06,$06,$06,$07,$07,$07,$07,$07,$07,$07,$07
.byte $08,$08,$08,$08,$08,$08,$08,$08,$09,$09,$09,$09,$09,$09,$09,$09
.byte $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A,$0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B
.byte $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
.byte $10,$10,$10,$10,$10,$10,$10,$10,$11,$11,$11,$11,$11,$11,$11,$11
.byte $12,$12,$12,$12,$12,$12,$12,$12,$13,$13,$13,$13,$13,$13,$13,$13
.byte $14,$14,$14,$14,$14,$14,$14,$14,$15,$15,$15,$15,$15,$15,$15,$15
.byte $16,$16,$16,$16,$16,$16,$16,$16,$17,$17,$17,$17,$17,$17,$17,$17
.byte $18,$18,$18,$18,$18,$18,$18,$18,$19,$19,$19,$19,$19,$19,$19,$19
.byte $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A,$1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B
.byte $1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C,$1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D
.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E,$1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F

;; [$A600 :: 0x3A600]

.byte $BD,$01,$61,$29,$C0,$D0,$12,$BD,$09,$61,$DD,$0B,$61,$90,$08,$BD
.byte $08,$61,$DD,$0A,$61,$B0,$02,$18,$60,$38,$60,$AD,$F0,$79,$18,$69
.byte $04,$CD,$F1,$79,$B0,$43,$A6,$6E,$20,$00,$A6,$90,$05,$20,$67,$DE
.byte $38,$60,$A9,$28,$85,$87,$A6,$6E,$BD,$35,$62,$30,$2A,$BD,$01,$61
.byte $29,$C0,$D0,$23,$A5,$87,$20,$A3,$A7,$85,$80,$A5,$08,$0A,$05,$0A
.byte $AA,$BD,$10,$62,$18,$69,$01,$85,$81,$20,$B3,$A7,$A5,$82,$85,$80
.byte $A5,$83,$85,$81,$20,$1F,$A9,$18,$60,$A2,$00,$20,$00,$A6,$90,$1F
.byte $A2,$40,$20,$00,$A6,$90,$18,$A2,$80,$20,$00,$A6,$90,$11,$AD,$F5
.byte $62,$30,$07,$A2,$C0,$20,$00,$A6,$90,$05,$20,$67,$DE,$38,$60,$A9
.byte $00,$85,$6E,$A9,$0A,$85,$87,$20,$36,$A6,$A5,$6E,$18,$69,$40,$85
.byte $6E,$D0,$F0,$18,$60,$A9,$80,$85,$87,$AD,$F0,$79,$18,$69,$04,$CD
.byte $F1,$79,$B0,$08,$20,$34,$A7,$20,$0E,$A8,$18,$60,$20,$5B,$A7,$A9
.byte $00,$20,$D0,$A6,$A9,$40,$20,$D0,$A6,$A9,$80,$20,$D0,$A6,$A9,$C0
.byte $85,$6E,$AA,$BD,$35,$62,$30,$1A,$BD,$01,$61,$25,$87,$F0,$13,$A5
.byte $87,$49,$FF,$3D,$01,$61,$9D,$01,$61,$20,$0E,$A8,$5E,$09,$61,$7E
.byte $08,$61,$18,$60,$A5,$08,$0A,$05,$0A,$AA,$BD,$10,$62,$AA,$E8,$AD

;; [$A700 :: 0x3A700]

.byte $F0,$79,$18,$69,$04,$CD,$F1,$79,$B0,$0B,$E8,$BD,$22,$A7,$85,$87
.byte $20,$34,$A7,$18,$60,$BD,$22,$A7,$85,$87,$20,$5B,$A7,$20,$7F,$A7
.byte $18,$60,$00,$02,$06,$0E,$1E,$3E,$7E,$FE,$FE,$FE,$FE,$FE,$FE,$FE
.byte $FE,$FE,$FE,$FE,$A6,$6E,$BD,$01,$61,$25,$87,$D0,$07,$20,$67,$DE
.byte $68,$68,$38,$60,$A5,$87,$3D,$01,$61,$10,$05,$A9,$01,$9D,$08,$61
.byte $A5,$87,$49,$FF,$3D,$01,$61,$9D,$01,$61,$60,$AD,$01,$61,$0D,$41
.byte $61,$0D,$81,$61,$AE,$F5,$62,$30,$03,$0D,$C1,$61,$25,$87,$D0,$06
.byte $20,$67,$DE,$68,$68,$38,$60,$BD,$01,$61,$25,$87,$D0,$C6,$60,$A2
.byte $00,$20,$77,$A7,$A2,$40,$20,$77,$A7,$A2,$80,$20,$77,$A7,$A2,$C0
.byte $AD,$F5,$62,$10,$E2,$60,$85,$80,$20,$AD,$C5,$85,$81,$20,$B3,$A7
.byte $A5,$83,$60,$A8,$85,$80,$20,$AD,$C5,$85,$81,$20,$B3,$A7,$98,$18
.byte $65,$83,$60,$A9,$00,$85,$82,$85,$83,$85,$84,$46,$80,$90,$0D,$A5
.byte $82,$18,$65,$81,$85,$82,$A5,$83,$65,$84,$85,$83,$06,$81,$26,$84
.byte $A5,$80,$D0,$E7,$60,$A9,$00,$85,$82,$85,$83,$A9,$00,$A2,$08,$06
.byte $82,$26,$83,$06,$81,$2A,$C5,$84,$90,$08,$E5,$84,$E6,$82,$D0,$02
.byte $E6,$83,$CA,$D0,$EA,$A2,$08,$06,$82,$26,$83,$06,$80,$2A,$C5,$84

;; [$A800 :: 0x3A800]

.byte $90,$08,$E5,$84,$E6,$82,$D0,$02,$E6,$83,$CA,$D0,$EA,$60,$A6,$6E
.byte $A5,$08,$0A,$05,$0A,$A8,$B9,$10,$62,$49,$0F,$18,$69,$01,$85,$84
.byte $BD,$0A,$61,$85,$80,$BD,$0B,$61,$85,$81,$20,$D5,$A7,$A6,$6E,$A5
.byte $82,$9D,$08,$61,$A5,$83,$9D,$09,$61,$60,$A6,$6E,$A5,$08,$0A,$05
.byte $0A,$A8,$B9,$10,$62,$49,$0F,$18,$69,$01,$85,$84,$BD,$08,$61,$85
.byte $80,$BD,$09,$61,$85,$81,$20,$D5,$A7,$A5,$82,$05,$83,$D0,$02,$E6
.byte $82,$A6,$6E,$A5,$82,$9D,$08,$61,$A5,$83,$9D,$09,$61,$60,$20,$AE
.byte $AA,$A5,$80,$C5,$81,$F0,$2F,$A5,$81,$C9,$20,$D0,$15,$A6,$80,$BD
.byte $60,$60,$C9,$10,$B0,$05,$20,$67,$DE,$18,$60,$A9,$00,$9D,$60,$60
.byte $18,$60,$A6,$80,$BD,$60,$60,$48,$A4,$81,$B9,$60,$60,$9D,$60,$60
.byte $68,$99,$60,$60,$18,$60,$AA,$BD,$60,$60,$C9,$10,$90,$D8,$C9,$1C
.byte $90,$0B,$C9,$98,$90,$D0,$C9,$C0,$B0,$CC,$4C,$4F,$AA,$86,$0A,$38
.byte $E9,$10,$85,$08,$C9,$0B,$D0,$05,$A5,$2D,$4A,$B0,$B9,$A5,$08,$18
.byte $69,$2B,$20,$01,$A9,$A5,$08,$C9,$0B,$F0,$05,$20,$5E,$AE,$B0,$1F
.byte $20,$AA,$A9,$B0,$F6,$20,$96,$B3,$A5,$08,$C9,$0B,$F0,$03,$20,$60
.byte $EE,$A9,$42,$85,$E0,$20,$C6,$AD,$A6,$0A,$A9,$00,$9D,$60,$60,$38

;; [$A900 :: 0x3A900]

.byte $60,$48,$A9,$00,$85,$A2,$20,$80,$B3,$20,$96,$B3,$A2,$10,$20,$86
.byte $B4,$68,$20,$DF,$B3,$A9,$00,$8D,$F0,$79,$60,$A9,$00,$85,$81,$A5
.byte $80,$A6,$6E,$18,$7D,$08,$61,$9D,$08,$61,$BD,$09,$61,$65,$81,$9D
.byte $09,$61,$BD,$09,$61,$DD,$0B,$61,$90,$19,$F0,$02,$B0,$08,$BD,$08
.byte $61,$DD,$0A,$61,$90,$0D,$BD,$0A,$61,$9D,$08,$61,$BD,$0B,$61,$9D
.byte $09,$61,$18,$60,$A6,$6E,$18,$7D,$0C,$61,$9D,$0C,$61,$BD,$0D,$61
.byte $69,$00,$9D,$0D,$61,$BD,$0D,$61,$DD,$0F,$61,$90,$19,$F0,$02,$B0
.byte $08,$BD,$0C,$61,$DD,$0E,$61,$90,$0D,$BD,$0E,$61,$9D,$0C,$61,$BD
.byte $0F,$61,$9D,$0D,$61,$18,$60,$85,$80,$3D,$01,$61,$D0,$05,$20,$67
.byte $DE,$38,$60,$A5,$80,$49,$FF,$3D,$01,$61,$9D,$01,$61,$A5,$80,$29
.byte $80,$F0,$05,$A9,$01,$9D,$08,$61,$18,$60,$A6,$6E,$A5,$08,$D0,$11
.byte $BD,$01,$61,$29,$C0,$D0,$D7,$A9,$1E,$20,$A3,$A7,$85,$80,$4C,$1B
.byte $A9,$C9,$01,$D0,$04,$A9,$04,$D0,$BE,$C9,$02,$D0,$04,$A9,$40,$D0
.byte $B6,$C9,$03,$D0,$04,$A9,$08,$D0,$AE,$C9,$04,$D0,$04,$A9,$20,$D0
.byte $A6,$C9,$05,$D0,$04,$A9,$10,$D0,$9E,$C9,$06,$D0,$04,$A9,$02,$D0
.byte $96,$C9,$07,$D0,$04,$A9,$80,$D0,$8E,$C9,$08,$D0,$0D,$BD,$01,$61

;; [$AA00 :: 0x3AA00]

.byte $29,$C0,$D0,$46,$20,$79,$A9,$4C,$46,$A9,$C9,$09,$D0,$0F,$BD,$01
.byte $61,$29,$C0,$D0,$35,$A9,$14,$20,$A3,$A7,$4C,$54,$A9,$C9,$0A,$D0
.byte $11,$BD,$01,$61,$29,$C0,$D0,$22,$A9,$64,$20,$A3,$A7,$85,$80,$4C
.byte $1B,$A9,$A2,$00,$BD,$01,$61,$29,$C0,$D0,$06,$20,$79,$A9,$20,$46
.byte $A9,$8A,$18,$69,$40,$AA,$D0,$EC,$18,$60,$20,$67,$DE,$38,$60,$38
.byte $E9,$98,$85,$08,$18,$69,$C0,$85,$09,$86,$0A,$A9,$3C,$20,$01,$A9
.byte $20,$5E,$AE,$B0,$47,$A6,$6E,$BD,$01,$61,$29,$F0,$F0,$05,$A9,$4D
.byte $4C,$7C,$AA,$A5,$09,$20,$BD,$AA,$90,$12,$A9,$3D,$20,$C3,$AD,$A2
.byte $10,$20,$86,$B4,$A9,$3C,$20,$DF,$B3,$4C,$60,$AA,$20,$CE,$AA,$90
.byte $05,$A9,$3E,$4C,$7C,$AA,$A9,$42,$85,$E0,$A5,$09,$9D,$30,$61,$A9
.byte $00,$A6,$0A,$9D,$60,$60,$20,$4A,$AF,$20,$E9,$AD,$38,$60,$AD,$F0
.byte $78,$4A,$4A,$85,$80,$AD,$F0,$79,$4A,$4A,$85,$81,$60,$A6,$6E,$A0
.byte $10,$DD,$30,$61,$F0,$06,$E8,$88,$D0,$F7,$18,$60,$38,$60,$A6,$6E
.byte $A0,$10,$BD,$30,$61,$F0,$06,$E8,$88,$D0,$F7,$38,$60,$18,$60,$20
.byte $AE,$AA,$A5,$80,$C5,$81,$F0,$62,$A5,$81,$C9,$10,$90,$1A,$A5,$6E
.byte $05,$80,$AA,$A9,$00,$9D,$30,$61,$A5,$80,$0A,$05,$6E,$AA,$A9,$00

;; [$AB00 :: 0x3AB00]

.byte $9D,$10,$62,$9D,$11,$62,$18,$60,$A5,$6E,$05,$80,$AA,$A5,$6E,$05
.byte $81,$A8,$BD,$30,$61,$48,$B9,$30,$61,$9D,$30,$61,$68,$99,$30,$61
.byte $A5,$80,$0A,$05,$6E,$AA,$A5,$81,$0A,$05,$6E,$A8,$BD,$10,$62,$48
.byte $B9,$10,$62,$9D,$10,$62,$68,$99,$10,$62,$BD,$11,$62,$48,$B9,$11
.byte $62,$9D,$11,$62,$68,$99,$11,$62,$18,$60,$A5,$6E,$05,$80,$AA,$BD
.byte $30,$61,$F0,$1C,$85,$82,$A6,$6E,$A5,$80,$0A,$05,$6E,$A8,$B9,$10
.byte $62,$18,$69,$01,$DD,$0C,$61,$90,$0C,$F0,$0A,$BD,$0D,$61,$D0,$05
.byte $20,$67,$DE,$18,$60,$A5,$82,$C9,$D0,$D0,$1F,$A5,$2D,$4A,$90,$F0
.byte $A5,$19,$F0,$57,$A9,$47,$20,$B6,$AD,$20,$E9,$AD,$20,$60,$EE,$A2
.byte $0B,$20,$86,$B4,$A9,$01,$85,$A2,$18,$60,$C9,$D4,$D0,$03,$4C,$16
.byte $AC,$C9,$D5,$D0,$03,$4C,$2F,$AC,$C9,$D7,$D0,$03,$4C,$43,$AC,$C9
.byte $E6,$D0,$BD,$A5,$2D,$4A,$90,$B8,$A5,$19,$D0,$C8,$20,$6B,$AC,$20
.byte $85,$AC,$A9,$3B,$20,$B6,$AD,$20,$E9,$AD,$20,$3A,$A8,$20,$80,$B3
.byte $A9,$00,$8D,$01,$20,$8D,$15,$40,$4C,$B8,$C0,$A5,$80,$0A,$05,$6E
.byte $A8,$B9,$10,$62,$48,$20,$85,$AC,$68,$A8,$BA,$8A,$18,$69,$08,$C9
.byte $FB,$B0,$0D,$88,$30,$0A,$18,$69,$05,$C9,$FB,$B0,$03,$88,$10,$F6

;; [$AC00 :: 0x3AC00]

.byte $AA,$9A,$A9,$37,$20,$B6,$AD,$20,$E9,$AD,$20,$80,$B3,$A9,$00,$8D
.byte $01,$20,$8D,$15,$40,$60,$20,$6B,$AC,$A9,$38,$20,$01,$A9,$20,$08
.byte $AE,$B0,$07,$20,$1B,$A6,$90,$2F,$B0,$F4,$20,$78,$AC,$38,$60,$20
.byte $6B,$AC,$A9,$39,$20,$01,$A9,$20,$08,$AE,$B0,$EE,$20,$A5,$A6,$90
.byte $16,$B0,$F4,$20,$6B,$AC,$A9,$3A,$20,$01,$A9,$20,$08,$AE,$B0,$DA
.byte $20,$F4,$A6,$90,$02,$B0,$F4,$20,$78,$AC,$20,$85,$AC,$20,$60,$EE
.byte $20,$96,$B3,$20,$C6,$AD,$20,$78,$AC,$38,$60,$A5,$80,$85,$08,$A5
.byte $9E,$85,$09,$A5,$6E,$85,$0A,$60,$A5,$08,$85,$80,$A5,$09,$85,$9E
.byte $A5,$0A,$85,$6E,$60,$A9,$42,$85,$E0,$A6,$6E,$A5,$80,$0A,$05,$6E
.byte $A8,$BD,$0C,$61,$18,$F9,$10,$62,$9D,$0C,$61,$BD,$0D,$61,$E9,$00
.byte $9D,$0D,$61,$B9,$11,$62,$18,$69,$02,$C9,$64,$B0,$04,$99,$11,$62
.byte $60,$B9,$10,$62,$18,$69,$01,$C9,$10,$B0,$08,$99,$10,$62,$A9,$00
.byte $99,$11,$62,$60
; Name	:
; Marks	:
	LDA #$00		; ACC4	$A9 $00
	STA PpuMask_2001	; ACC6	$8D $01 $20
	STA $78F0		; ACC9	$8D $F0 $78
	STA $79F0		; ACCC	$8D $F0 $79
	STA $7AF0		; ACCF	$8D $F0 $7A
	JSR $E491		; ACD2	$20 $91 $E4
	JSR $F321		; ACD5	$20 $21 $F3
	JSR $C46E		; ACD8	$20 $6E $C4
	JSR $FE00		; ACDB	$20 $00 $FE
	LDA #$02		; ACDE	$A9 $02
	STA SpriteDma_4014	; ACE0	$8D $14 $40
	JSR Palette_copy	; ACE3	$20 $30 $DC
	LDA #$88		; ACE6	$A9 $88
	STA $FD			; ACE8	$85 $FD
	STA $FF			; ACEA	$85 $FF
	STA PpuControl_2000	; ACEC	$8D $00 $20
	LDA #$00		; ACEF	$A9 $00
	STA PpuScroll_2005	; ACF1	$8D $05 $20
	STA PpuScroll_2005	; ACF4	$A9 $05 $20
	LDA #$1E		; ACF7	$A9 $1E
	STA PpuMask_2001	; ACF9	$8D $01 $20
	LDA #$0E		; ACFC	$A9 $0E
	STA $57			; ACFE	$85 $57
	LDA #$01		; AD00	$A9 $01
	STA $37			; AD02	$85 $37
	LDA #$00		; AD04	$A9 $00
	STA $A3			; AD06	$85 $A3
	STA $A4			; AD08	$85 $A4
	JSR $B396		; AD0A	$20 $96 $B3

;; [$AD00 :: 0x3AD00]

.byte $20,$A2,$AD
.byte $20,$B6,$8E,$A9,$01,$85,$A2,$20,$01,$B4,$20,$00,$88,$A9,$04,$20
.byte $C5,$96,$A5,$25,$D0,$66,$A5,$24,$F0,$ED,$20,$5E,$90,$AD,$F0,$78
.byte $D0,$06,$20,$C5,$AE,$4C,$00,$AD,$C9,$04,$D0,$0B,$20,$59,$AE,$B0
.byte $D6,$20,$93,$AF,$4C,$00,$AD,$C9,$08,$D0,$0B,$20,$59,$AE,$B0,$C7
.byte $20,$15,$B0,$4C,$00,$AD,$C9,$0C,$D0,$0B,$20,$59,$AE,$B0,$B8,$20
.byte $B1,$B1,$4C,$00,$AD,$A5,$2D,$4A,$90,$0F,$A9,$40,$20,$C3,$AD,$A9
.byte $01,$85,$A2,$20,$A2,$AD,$4C,$17,$AD,$20,$D7,$B1,$20,$60,$EE,$20
.byte $B6,$8E,$20,$A2,$AD,$A9,$01,$85,$A2,$4C,$17,$AD,$20,$80,$B3,$A9
.byte $00,$8D,$01,$20,$8D,$15,$40,$85,$24,$85,$25,$85,$22,$85,$23,$85
.byte $47,$60,$A2,$05,$20,$86,$B4,$A9,$1C,$20,$DF,$B3,$A2,$04,$20,$86
.byte $B4,$A9,$1B,$4C,$DF,$B3,$48,$20,$60,$EE,$A2,$10,$20,$86,$B4,$68
.byte $4C,$DF,$B3,$20,$B6,$AD,$A9,$00,$85,$A2,$85,$A3,$85,$A4,$A9,$00
.byte $85,$24,$85,$25,$20,$01,$B4,$20,$00,$88,$20,$5C,$DB,$A5,$24,$05
.byte $25,$F0,$F1,$20,$5E,$90,$4C,$60,$EE,$A9,$00,$85,$A2,$85,$A3,$85
.byte $A4,$85,$24,$85,$25,$20,$01,$B4,$20,$6A,$B3,$20,$5C,$DB,$A5,$24

;; [$AE00 :: 0x3AE00]

.byte $05,$25,$F0,$F1,$20,$5E,$90,$60,$A9,$00,$8D,$F0,$79,$A2,$0F,$BD
.byte $AA,$AE,$9D,$00,$79,$CA,$10,$F7,$A9,$14,$AE,$F5,$62,$10,$02,$A9
.byte $10,$8D,$F1,$79,$A9,$01,$85,$A3,$20,$18,$B4,$20,$00,$88,$A9,$08
.byte $20,$F9,$96,$A5,$25,$D0,$19,$A5,$24,$F0,$ED,$20,$5E,$90,$AD,$F0
.byte $79,$4A,$4A,$09,$10,$85,$9E,$4A,$6A,$6A,$29,$C0,$85,$6E,$18,$60
.byte $A9,$00,$85,$A3,$20,$5E,$90,$38,$60,$A9,$00,$8D,$F0,$79,$A2,$0F
.byte $BD,$AA,$AE,$9D,$00,$79,$CA,$10,$F7,$A9,$10,$AE,$F5,$62,$10,$02
.byte $A9,$0C,$8D,$F1,$79,$A9,$01,$85,$A3,$20,$01,$B4,$20,$00,$88,$A9
.byte $08,$20,$F9,$96,$A5,$25,$D0,$19,$A5,$24,$F0,$ED,$20,$5E,$90,$AD
.byte $F0,$79,$4A,$4A,$09,$10,$85,$9E,$4A,$6A,$6A,$29,$C0,$85,$6E,$18
.byte $60,$A9,$00,$85,$A3,$20,$5E,$90,$38,$60,$06,$03,$00,$00,$14,$03
.byte $00,$00,$08,$0D,$00,$00,$16,$0D,$00,$00,$20,$5E,$90,$A9,$00,$8D
.byte $F0,$78,$4C,$80,$B3,$20,$5E,$90,$20,$80,$B3,$A9,$00,$85,$A3,$85
.byte $A4,$A9,$01,$85,$A2,$A9,$00,$8D,$F0,$7A,$A2,$07,$20,$86,$B4,$A9
.byte $25,$20,$DF,$B3,$A2,$06,$20,$86,$B4,$A9,$1F,$20,$DF,$B3,$20,$14
.byte $B3,$20,$3F,$B3,$20,$01,$B4,$A9,$0C,$20,$C5,$96,$A5,$25,$D0,$BA

;; [$AF00 :: 0x3AF00]

.byte $A5,$24,$F0,$F0,$20,$5E,$90,$A9,$01,$85,$A3,$AD,$F0,$78,$8D,$F0
.byte $79,$20,$01,$B4,$A9,$0C,$20,$F9,$96,$A5,$25,$F0,$0A,$20,$5E,$90
.byte $A9,$00,$85,$A3,$4C,$F4,$AE,$A5,$24,$F0,$E6,$20,$5E,$90,$A9,$00
.byte $85,$A3,$20,$6E,$A8,$B0,$8E,$A2,$07,$20,$51,$B4,$A9,$25,$20,$DF
.byte $B3,$20,$3F,$B3,$20,$14,$B3,$4C,$F4,$AE,$20,$5E,$90,$20,$80,$B3
.byte $A9,$00,$85,$A3,$85,$A4,$A9,$01,$85,$A2,$A9,$00,$8D,$F0,$7A,$A2
.byte $08,$20,$86,$B4,$A9,$20,$20,$CD,$B3,$A2,$09,$20,$86,$B4,$A9,$1D
.byte $20,$DF,$B3,$A2,$0A,$20,$86,$B4,$A9,$21,$20,$CD,$B3,$A2,$0B,$20
.byte $86,$B4,$A9,$26,$20,$CD,$B3,$60,$20,$5E,$90,$A9,$04,$8D,$F0,$78
.byte $4C,$80,$B3,$20,$4A,$AF,$20,$14,$B3,$20,$3F,$B3,$A9,$00,$8D,$F0
.byte $78,$20,$01,$B4,$20,$6A,$B3,$A9,$08,$20,$C5,$96,$A5,$25,$D0,$D8
.byte $A5,$24,$F0,$ED,$20,$5E,$90,$A9,$01,$85,$A3,$AD,$F0,$78,$8D,$F0
.byte $79,$20,$01,$B4,$20,$6A,$B3,$A9,$08,$20,$F9,$96,$A5,$25,$F0,$0A
.byte $20,$5E,$90,$A9,$00,$85,$A3,$4C,$A1,$AF,$A5,$24,$F0,$E3,$A6,$6E
.byte $BD,$01,$61,$29,$D0,$F0,$06,$20,$67,$DE,$4C,$D0,$AF,$20,$5E,$90
.byte $A9,$00,$85,$A3,$20,$DF,$AA,$90,$03,$4C,$93,$AF,$A2,$0B,$20,$51

;; [$B000 :: 0x3B000]

.byte $B4,$A9,$26,$20,$CD,$B3,$20,$3F,$B3,$20,$14,$B3,$4C,$A1,$AF,$20
.byte $5E,$90,$4C,$80,$B3,$20,$5E,$90,$20,$80,$B3,$A9,$00,$85,$A4,$85
.byte $A2,$A9,$01,$85,$A3,$A9,$00,$8D,$F0,$7A,$8D,$F0,$79,$A2,$08,$20
.byte $86,$B4,$A9,$22,$20,$CD,$B3,$A2,$09,$20,$86,$B4,$A9,$1D,$20,$DF
.byte $B3,$A2,$0A,$20,$86,$B4,$A9,$23,$20,$CD,$B3,$A2,$0C,$20,$86,$B4
.byte $A9,$24,$20,$CD,$B3,$A2,$0D,$20,$86,$B4,$A9,$25,$20,$F0,$B3,$20
.byte $EB,$94,$20,$01,$B4,$20,$6A,$B3,$A9,$04,$20,$F9,$96,$A5,$25,$D0
.byte $9E,$A5,$24,$F0,$ED,$20,$5E,$90,$A9,$01,$85,$A4,$20,$01,$B4,$20
.byte $6A,$B3,$A9,$0C,$20,$2D,$97,$A5,$25,$F0,$0A,$20,$5E,$90,$A9,$00
.byte $85,$A4,$4C,$62,$B0,$A5,$24,$F0,$E3,$20,$5E,$90,$20,$CB,$B0,$A5
.byte $9E,$29,$03,$20,$03,$FA,$A2,$0A,$20,$51,$B4,$A9,$23,$20,$CD,$B3
.byte $A2,$0C,$20,$51,$B4,$A9,$24,$20,$CD,$B3,$20,$23,$95,$A5,$1C,$85
.byte $3E,$A5,$1D,$85,$3F,$20,$AC,$E7,$4C,$7C,$B0,$AE,$F0,$7A,$BD,$02
.byte $7A,$C9,$0F,$D0,$2C,$A9,$00,$85,$80,$AD,$F0,$79,$4A,$4A,$AA,$A5
.byte $6E,$1D,$99,$B1,$AA,$BD,$00,$61,$C9,$10,$B0,$03,$4C,$67,$DE,$AD
.byte $F0,$79,$4A,$4A,$AA,$A5,$6E,$1D,$99,$B1,$AA,$A5,$80,$9D,$00,$61

;; [$B100 :: 0x3B100]

.byte $60,$BD,$03,$7A,$AA,$85,$82,$BD,$60,$60,$85,$80,$F0,$1E,$AD,$F0
.byte $79,$4A,$4A,$AA,$C9,$05,$B0,$2E,$A5,$80,$DD,$A1,$B1,$90,$24,$DD
.byte $A9,$B1,$B0,$1F,$E0,$00,$F0,$38,$E0,$03,$F0,$34,$AD,$F0,$79,$4A
.byte $4A,$AA,$A5,$6E,$1D,$99,$B1,$AA,$BD,$00,$61,$A6,$82,$9D,$60,$60
.byte $4C,$EF,$B0,$4C,$67,$DE,$A5,$80,$C9,$0E,$90,$F7,$C9,$30,$90,$DC
.byte $F0,$F1,$C9,$70,$90,$D6,$C9,$98,$90,$E9,$C9,$C0,$B0,$E5,$90,$CC
.byte $A4,$6E,$E0,$00,$D0,$0D,$B9,$1C,$61,$85,$10,$B9,$1D,$61,$85,$11
.byte $4C,$7D,$B1,$B9,$1D,$61,$85,$10,$B9,$1C,$61,$85,$11,$A5,$10,$05
.byte $11,$F0,$A9,$A5,$11,$F0,$A5,$C9,$68,$B0,$0B,$A5,$80,$C9,$68,$B0
.byte $05,$4C,$2C,$B1,$A5,$10,$4C,$43,$B1,$1C,$19,$1B,$1D,$1A,$1E,$1F
.byte $00,$31,$70,$8E,$31,$7A,$00,$00,$00,$70,$7A,$98,$70,$8E,$00,$00
.byte $00,$20,$5E,$90,$20,$80,$B3,$A9,$00,$85,$A2,$85,$A3,$20,$6F,$B3
.byte $20,$01,$B4,$A6,$6E,$20,$3D,$88,$20,$5C,$DB,$A5,$24,$05,$25,$F0
.byte $EF,$20,$5E,$90,$4C,$80,$B3,$20,$8F,$DA,$A9,$00,$85,$A2,$A9,$01
.byte $85,$A3,$A9,$00,$8D,$F0,$79,$20,$60,$EE,$A2,$10,$20,$86,$B4,$A9
.byte $29,$20,$DF,$B3,$20,$01,$B4,$20,$00,$88,$A9,$04,$20,$F9,$96,$A5

;; [$B200 :: 0x3B200]

.byte $25,$F0,$04,$20,$5E,$90,$60,$A5,$24,$F0,$E9,$20,$5E,$90,$AD,$F0
.byte $79,$4A,$4A,$29,$03,$48,$20,$C1,$DA,$68,$B0,$46,$48,$20,$C3,$B2
.byte $20,$80,$B3,$20,$F1,$B2,$20,$96,$B3,$A2,$10,$20,$86,$B4,$A9,$28
.byte $20,$DF,$B3,$A9,$00,$8D,$F0,$79,$20,$01,$B4,$20,$00,$88,$A9,$04
.byte $20,$F9,$96,$A5,$25,$D0,$6C,$A5,$24,$F0,$ED,$AD,$F0,$79,$D0,$63
.byte $20,$5E,$90,$68,$48,$20,$C3,$B2,$20,$80,$B3,$20,$F1,$B2,$20,$96
.byte $B3,$68,$85,$80,$0A,$18,$65,$80,$69,$63,$85,$81,$A9,$00,$85,$80
.byte $85,$82,$A9,$60,$85,$83,$A0,$00,$A2,$03,$B1,$82,$91,$80,$C8,$D0
.byte $F9,$E6,$81,$E6,$83,$CA,$D0,$F2,$20,$60,$EE,$A2,$10,$20,$86,$B4
.byte $A9,$2A,$20,$DF,$B3,$A9,$00,$85,$A2,$85,$A3,$A9,$00,$85,$24,$85
.byte $25,$20,$01,$B4,$20,$00,$88,$20,$5C,$DB,$A5,$25,$05,$24,$F0,$F1
.byte $4C,$5E,$90,$20,$5E,$90,$68,$20,$C3,$B2,$20,$80,$B3,$20,$F1,$B2
.byte $4C,$96,$B3,$85,$80,$0A,$18,$65,$80,$69,$63,$85,$81,$A9,$00,$85
.byte $80,$85,$82,$A9,$60,$85,$83,$A0,$00,$B1,$80,$AA,$B1,$82,$91,$80
.byte $8A,$91,$82,$C8,$D0,$F3,$E6,$81,$E6,$83,$A5,$83,$C9,$63,$90,$E9
.byte $60,$A9,$00,$8D,$01,$20,$20,$FA,$E6,$20,$00,$FE,$A5,$FF,$8D,$00

;; [$B300 :: 0x3B300]

.byte $20,$A9,$00,$8D,$05,$20,$8D,$05,$20,$A9,$1E,$8D,$01,$20,$A9,$02
.byte $8D,$14,$40,$60,$A2,$80,$BD,$00,$7A,$18,$69,$01,$9D,$00,$79,$BD
.byte $01,$7A,$9D,$01,$79,$BD,$02,$7A,$9D,$02,$79,$BD,$03,$7A,$9D,$03
.byte $79,$8A,$38,$E9,$04,$AA,$B0,$DE,$AD,$F1,$7A,$8D,$F1,$79,$60,$A2
.byte $80,$BD,$00,$7A,$9D,$00,$78,$BD,$01,$7A,$9D,$01,$78,$BD,$02,$7A
.byte $9D,$02,$78,$BD,$03,$7A,$9D,$03,$78,$8A,$38,$E9,$04,$AA,$B0,$E1
.byte $AD,$F1,$7A,$38,$E9,$04,$8D,$F1,$78,$60,$A6,$6E,$4C,$33,$88,$A2
.byte $0F,$A9,$27,$20,$C8,$B3,$A2,$0E,$20,$86,$B4,$A9,$1D,$4C,$DF,$B3
; Name	:
; Marks	: Init page2, Copy by DMA, PpuScroll reset
	JSR Init_Page2		; B380	$20 $6E $C4
	JSR Wait_NMI		; B383	$20 $00 $FE
	LDA #$02		; B386	$A9 $02
	STA SpriteDma_4014	; B388	$8D $14 $40
	LDA #$00		; B38B	$A9 $00
	STA PpuScroll_2005	; B38D	$8D $05 $20
	STA PpuScroll_2005	; B390	$8D $05 $20
	JMP $EE64		; B393	$4C $64 $EE
; Name	:
; Marks	:
	LDX #$00		; B396	$A2 $00
	LDY #$10		; B398	$A0 $10
	STY $9E			; B39A	$84 $9E
	LDA #$1E		; B39C	$A9 $1E
	JSR $B3C8		; B39E	$20 $C8 $B3
.byte $A2,$01,$A0,$11,$84,$9E,$A9,$1E,$20,$C8,$B3,$A2,$02,$A0,$12
.byte $84,$9E,$A9,$1E,$20,$C8,$B3,$AD,$F5,$62,$30,$0B,$A2,$03,$A0,$13
.byte $84,$9E,$A9,$1E,$4C,$C8,$B3,$60
; Name	:
; Marks	:
	PHA			; B3C8	$48
	JSR $B486		; B3C9	$20 $86 $B4
	PLA			; B3CC	$68
	JSR $DAF1		; B3CD	$20 $F1 $DA
	LDA #$0A		; B3D0	$A9 $0A
	STA $93			; B3D2	$85 $93
	LDA #$00		; B3D4	$A9 $00
	STA $3E			; B3D6	$85 $3E
	LDA #$7B		; B3D8	$A9 $7B
	STA $3F			; B3DA	$85 $3F
	JMP $E7AC		; B3DC	$4C $AC $E7
.byte $85
.byte $92,$A9,$84,$85,$95,$A9,$00,$85,$94,$A9,$0A,$85,$93,$4C,$54,$EA
; Name	:
; A	: text ID
; Marks	:
	STA text_ID		; B3F0	$85 $92
	LDA #$84		; B3F2	$A9 $84
	STA $95			; B3F4	$85 $95
	LDA #$00		; B3F6	$A9 $00
	STA text_offset		; B3F8	$85 $94
	LDA #$0A		; B3FA	$A9 $0A		text 2 bank
	STA bank_tmp		; B3FC	$85 $93
	JMP $EA8C		; B3FE	$4C $8C $EA	text process ??
; End of

;; [$B400 :: 0x3B400]

.byte $20,$00,$FE,$A9,$02,$8D,$14,$40,$20,$4F,$C7,$20,$6E,$C4,$20
.byte $52,$96,$20,$63,$96,$4C,$74,$96,$AD,$F0,$79,$18,$69,$04,$CD,$F1
.byte $79,$D0,$DE,$20,$00,$FE,$A9,$02,$8D,$14,$40,$20,$4F,$C7,$20,$6E
.byte $C4,$E6,$F0,$A5,$F0,$29,$03,$0A,$0A,$8D,$F0,$79,$18,$69,$04,$CD
.byte $F1,$79,$F0,$03,$20,$63,$96,$AD,$F1,$79,$38,$E9,$04,$8D,$F0,$79
.byte $60

; Name	: 
; X	: Address Index($B48C, $B4A5, B4BE, B4D7)
;	  16 = name input character potrait ??
; Marks	: text_win Left/Top value increase.
;	  menu_win width -2, menu_win height -2.
L3B451:
	JSR Get_win_pos		; B451	$20,$67,$B4
	INC text_win_L		; B454	$E6 $38
	INC text_win_T		; B456	$E6 $39
	LDA menu_win_W		; B458	$A5 $3C
	SEC			; B45A	$38
	SBC #$02		; B45B	$E9 $02
	STA menu_win_W		; B45D	$85 $3C
	LDA menu_win_H		; B45F	$A5 $3D
	SEC			; B461	$38
	SBC #$02		; B462	$E9 $02
	STA menu_win_H		; B464	$85 $3D
	RTS			; B466	$60
; End of 

; Name	: Get_win_pos
; X	: Address Index($B48C, $B4A5, B4BE, B4D7)
;	  15h = name input ??
; Marks	: Get text window position(X/Y) and size(width/height)
;	  text_win_Left -1 -> $97(X temp ??)
;	  text_win_Top +2 -> $98(Y temp ??)
Get_win_pos:
	LDA $B48C,X		; B467	$BD $8C $B4
	STA text_win_L		; B46A	$85 $38
	SEC			; B46C	$38
	SBC #$01		; B46D	$E9 $01
	STA $97			; B46F	$85 $97		X ??
	LDA $B4A5,X		; B471	$BD $A5 $B4
	STA text_win_T		; B474	$85 $39
	CLC			; B476	$18
	ADC #$02		; B477	$69 $02
	STA $98			; B479	$85 $98		Y ??
	LDA $B4BE,X		; B47B	$BD $BE $B4
	STA menu_win_W		; B47E	$85 $3C
	LDA $B4D7,X		; B480	$BD $D7 $B4
	STA menu_win_H		; B483	$85 $3D
	RTS			; B485	$60
; End of Get_win_pos

; Name	:
; X	: Text window position INDEX
; Marks	:
	JSR Get_win_pos		; B486	$20 $67 $B4
	JMP $E91E		; B489	$4C $1E $E9	draw window and text ??
; End of

; [$B48C- text window left position
.byte $01,$0F,$03,$11
.byte $01,$06,$01,$00,$00,$0B,$11,$01,$00,$00,$01,$02,$01,$04,$04,$04
.byte $04,$04,$07,$04,$01
; [$B4A5- text window top position
.byte $01,$01,$0B,$0B,$15,$19,$01,$04,$01,$01,$01
.byte $07,$07,$13,$01,$02,$15,$02,$07,$0C,$11,$17,$03,$0B,$01
; [$B4BE- menu window width ??
.byte $0E,$0E
.byte $0E,$0E,$1E,$0D,$09,$20,$0B,$06,$0F,$1E,$20,$20,$06,$1D,$1E,$18
.byte $18,$18,$18,$18,$12,$18,$1E
; [$B4D7- menu window height ??
.byte $0A,$0A,$0A,$0A,$04,$04,$04,$18,$06
.byte $06,$06,$14,$0C,$0A,$06,$1A,$08,$06,$06,$06,$06,$04,$06,$0E,$1C
; [$B4F0- character order - character name select order(10h=firion,13h=leon,11h=maria,12h=guy)
.byte $10,$13,$11,$12

char_num_tmp	= $07
name_num_tmp	= $08
char_offset_tmp	= $6E
.DEFINE MAX_CHAR_LEN	#$04
.DEFINE	MAX_NAME_LEN	#$06
; Name	: Char_name_sel
; Marks	: character_name_select
Char_name_sel:
	JSR $B380		; B4F4	$20 $80 $B3	remove screen for next page(input name)
	JSR Get_udlr		; B4F7	$20 $B6 $8E
	LDA #$00		; B4FA	$A9 $00
	STA $7AF0		; B4FC	$8D $F0 $7A	current cursor position
	LDX #$17		; B4FF	$A2 $17
	JSR $B486		; B501	$20 $86 $B4	draw window ?? -> letters window ??
	LDA #$46		; B504	$A9 $46		text_ID = 46h
	JSR $B3F0		; B506	$20 $F0 $B3	draw letters for input character name
	JSR $94EB		; B509	$20 $EB $94	save window variables
	LDA #$01		; B50C	$A9 $01
	STA $A4			; B50E	$85 $A4
	LDX #$16		; B510	$A2 $16
	JSR $B486		; B512	$20 $86 $B4	set window position ?? -> character potrait window
	LDA #$00		; B515	$A9 $00
	STA char_num_tmp	; B517	$85 $07
	STA name_num_tmp	; B519	$85 $08
CNS_input_name:
	JSR Input_char_name_proc; B51B	$20 $3B $B5	input character name process
	BCC CNS_next_char	; B51E	$90 $0E		next character
	LDA char_num_tmp	; B520	$A5 $07
	CMP #$01		; B522	$C9 $01
	BCC CNS_input_name	; B524	$90 $F5		if first character ??
	SEC			; B526	$38
	SBC #$01		; B527	$E9 $01
	STA char_num_tmp	; B529	$85 $07
	JMP CNS_input_name	; B52B	$4C $1B $B5	loop
CNS_next_char:
	LDA char_num_tmp	; B52E	$A5 $07
	CLC			; B530	$18
	ADC #$01		; B531	$69 $01
	STA char_num_tmp	; B533	$85 $07
	CMP MAX_CHAR_LEN	; B535	$C9 $04
	BCC CNS_input_name	; B537	$90 $E2		if next character exist
	CLC			; B539	$18
	RTS			; B53A	$60
; End of Char_name_sel

; Name	: Input_char_name_proc
; Ret	: Carry(Clear = next character, Set = Last character)
; Marks	: input char name process
Input_char_name_proc:
	LDX char_num_tmp	; B53B	$A6 $07
	LDA $B4F0,X		; B53D	$BD $F0 $B4
	STA $9E			; B540	$85 $9E		character order
	AND #$03		; B542	$29 $03
	LSR A			; B544	$4A
	ROR A			; B545	$6A
	ROR A			; B546	$6A
	STA char_offset_tmp	; B547	$85 $6E
	JSR $B609		; B549	$20 $09 $B6
ICN_LOOP:
	JSR Wait_NMI		; B54C	$20 $00 $FE
	LDA #$02		; B54F	$A9 $02
	STA SpriteDma_4014	; B551	$8D $14 $40
	JSR Init_Page2		; B554	$20 $6E $C4
	JSR $C74F		; B557	$20 $4F $C7	sound ??
	JSR $9674		; B55A	$20 $74 $96	up ?? D2 ??
	LDX char_offset_tmp	; B55D	$A6 $6E
	JSR $8847		; B55F	$20 $47 $88	Set character potrait to OAM buffer($0200-) ??
	JSR $B616		; B562	$20 $16 $B6	Set character letter to OAM buffer($0240-) ??
	LDA #$28		; B565	$A9 $28
	JSR $972D		; B567	$20 $2D $97	key check(pad) ??
	LDA b_pressing		; B56A	$A5 $25
	BEQ ICN_chk_a		; B56C	$F0 $12		if not b key pressing
	JSR KeyRst_SndE		; B56E	$20 $5E $90	b pressing
	LDA name_num_tmp	; B571	$A5 $08
	SEC			; B573	$38
	SBC #$01		; B574	$E9 $01
	STA name_num_tmp	; B576	$85 $08
	BPL ICN_LOOP		; B578	$10 $D2		LOOP [input character name] - back and continue input name
	LDA #$05		; B57A	$A9 $05
	STA name_num_tmp	; B57C	$85 $08
	SEC			; B57E	$38
	RTS			; B57F	$60
; End of Input_char_name_proc
ICN_chk_a:
	LDA a_pressing		; B580	$A5 $24
	BEQ ICN_LOOP		; B582	$F0 $C8		LOOP [input character name] - if not a pressing
	JSR KeyRst_SndE		; B584	$20 $5E $90
	LDA name_num_tmp	; B587	$A5 $08
	CMP MAX_NAME_LEN	; B589	$C9 $06
	BCC ICN_next		; B58B	$90 $06		if entering more letters
	LDA #$00		; B58D	$A9 $00
	STA name_num_tmp	; B58F	$85 $08
	CLC			; B591	$18
	RTS			; B592	$60
; End of Input_char_name_proc
ICN_next:
	LDA name_num_tmp	; B593	$A5 $08
	ORA char_offset_tmp	; B595	$05 $6E
	TAY			; B597	$A8
	LDX $7AF0		; B598	$AE $F0 $7A
	LDA $7A02,X		; B59B	$BD $02 $7A
	STA ch_names,Y		; B59E	$99 $02 $61
	INC name_num_tmp	; B5A1	$E6 $08
	JSR $B609		; B5A3	$20 $09 $B6	letter ?? blink ??
	LDA name_num_tmp	; B5A6	$A5 $08
	CMP MAX_NAME_LEN	; B5A8	$C9 $06
	BCS ICN_name_cmp	; B5AA	$B0 $03		if last letter
ICN_loop:
	JMP ICN_LOOP		; B5AC	$4C $4C $B5	LOOP [input character name] - next letter

ICN_name_cmp:
	LDA char_num_tmp	; B5AF	$A5 $07
	BEQ ICN_loop		; B5B1	$F0 $F9		if first character
	CMP #$01		; B5B3	$C9 $01
	BEQ ICN_name_cmp2	; B5B5	$F0 $12		if 2nd character(leon)
	CMP #$02		; B5B7	$C9 $02
	BEQ ICN_name_cmp3	; B5B9	$F0 $07		if 3rd character(maria)
	LDY char_offset_tmp	; B5BB	$A4 $6E
	LDX #$40		; B5BD	$A2 $40		3rd character(maria)
	JSR Namecmp		; B5BF	$20 $D3 $B5
ICN_name_cmp3:
	LDY char_offset_tmp	; B5C2	$A4 $6E
	LDX #$C0		; B5C4	$A2 $C0		2nd character(leon)
	JSR Namecmp		; B5C6	$20 $D3 $B5
ICN_name_cmp2:
	LDY char_offset_tmp	; B5C9	$A4 $6E
	LDX #$00		; B5CB	$A2 $00		1st character(firion)
	JSR Namecmp		; B5CD	$20 $D3 $B5
	JMP ICN_LOOP		; B5D0	$4C $4C $B5	LOOP [input character name] - continue

; Name	: Namecmp
; X	: base name
; Y	: comparison target
; Marks	: Cannot allow duplicated name
;	  In case of duplicate names, name number decrease
Namecmp:
	LDA ch_names,Y		; B5D3	$B9 $02 $61
	CMP ch_names,X		; B5D6	$DD $02 $61
	BNE L3B608		; B5D9	$D0 $2D
	LDA $6103,Y		; B5DB	$B9 $03 $61
	CMP $6103,X		; B5DE	$DD $03 $61
	BNE L3B608		; B5E1	$D0 $25
	LDA $6104,Y		; B5E3	$B9 $04 $61
	CMP $6104,X		; B5E6	$DD $04 $61
	BNE L3B608		; B5E9	$D0 $1D
	LDA $6105,Y		; B5EB	$B9 $05 $61
	CMP $6105,X		; B5EE	$DD $05 $61
	BNE L3B608		; B5F1	$D0 $15
	LDA $6106,Y		; B5F3	$B9 $06 $61
	CMP $6106,X		; B5F6	$DD $06 $61
	BNE L3B608		; B5F9	$D0 $0D
	LDA $6107,Y		; B5FB	$B9 $07 $61
	CMP $6107,X		; B5FE	$DD $07 $61
	BNE L3B608		; B601	$D0 $05
	DEC name_num_tmp	; B603	$C6 $08		in case of duplicate names
	JSR $DE67		; B605	$20 $67 $DE	sound effect ?? - caution
L3B608:
	RTS			; B608	$60
; End of Namecmp

; Name	:
; Marks	: letter on input name ??
	LDX #$16		; B609	$A2 $16
	JSR $B451		; B60B	$20 $51 $B4	text/menu calcuration
	LDA #$45		; B60E	$A9,$45
	JSR $DAF1		; B610	$20 $F1 $DA	check text ??
	JMP $B881		; B613	$4C $81 $B8	text copy ??
; End of

; Name	:
; Marks	:
	INC frame_cnt_L		; B616	$E6 $F0
	LDA name_num_tmp	; B618	$A5 $08
	CMP MAX_NAME_LEN	; B61A	$C9 $06
	BCC L3B61F		; B61C	$90 $01
L3B61E:
	RTS			; B61E	$60
; End of
L3B61F:
	LDA $F0			; B61F	$A5 $F0
	AND #$08		; B621	$29 $08
	BNE L3B61E		; B623	$D0 $F9
	LDX $26			; B625	$A6 $26
	LDA #$27		; B627	$A9 $27
	STA $0200,X		; B629	$9D $00 $02	Y
	LDA #$48		; B62C	$A9 $48
	STA $0201,X		; B62E	$9D $01 $02	INDEX
	LDA #$03		; B631	$A9 $03
	STA $0202,X		; B633	$9D $02 $02	ATTR
	LDA $08			; B636	$A5 $08
	ASL A			; B638	$0A
	ASL A			; B639	$0A
	ASL A			; B63A	$0A
	CLC			; B63B	$18
	ADC #$78		; B63C	$69 $78
	STA $0203,X		; B63E	$9D $03 $02	X
	RTS			; B641	$60
; End of

; Name	:
; Makrs	:
;	  Almost begin - after title story(prologue) end -> savefile select ??
	LDA #$00		; B642	$A9 $00
	STA PpuMask_2001	; B644	$8D $01 $20	PPU disable
	STA ApuStatus_4015	; B647	$8D $15 $40	APU disable
	LDA #$05		; B64A	$A9 $05
	STA $08			; B64C	$85 $08
	JSR Init_variables	; B64E	$20 $B0 $FF	Init_variables
	LDA #$08		; B651	$A9 $08
	STA ch_stats_4		; B653	$8D $C0 $61
	JSR Init_CHR_RAM	; B656	$20 $91 $E4
	JSR NT0_OAM_init	; B659	$20 $06 $B9
	JSR Palette_copy	; B65C	$20 $30 $DC
	LDA #$1E		; B65F	$A9 $1E 	Show sprite, background, left most
	STA PpuMask_2001	; B661	$8D $01 $20
	LDA #$00		; B664	$A9 $00
	JSR Check_savefile	; B666	$20 $C1 $DA
	STA $88			; B669	$85 $88
	LDA #$01		; B66B	$A9 $01
	JSR Check_savefile	; B66D	$20 $C1 $DA
	STA $89			; B670	$85 $89
	LDA #$02		; B672	$A9 $02
	JSR Check_savefile	; B674	$20 $C1 $DA
	STA $8A			; B677	$85 $8A
	LDA #$03		; B679	$A9 $03
	JSR Check_savefile	; B67B	$20 $C1 $DA
	STA $8B			; B67E	$85 $8B
	LDA #$00		; B680	$A9 $00
	STA $78F0		; B682	$8D $F0 $78 	$F0 current cursor position ??
	STA $79F0		; B685	$8D $F0 $79
	STA $7AF0		; B688	$8D $F0 $7A
	JSR $B7FC		; B68B	$20 $FC $B7	save file check?? load?? show save files ??
	LDA #$10		; B68E	$A9 $10
	STA $9E			; B690	$85 $9E
L3B692:
	JSR $B7EC		; B692	$20 $EC $B7	draw save file text ??
	LDA $9E			; B695	$A5 $9E		current save file step (10h-13h)
	CLC			; B697	$18
	ADC #$01		; B698	$69 $01
	STA $9E			; B69A	$85 $9E		current save file step
	CMP #$14		; B69C	$C9 $14
	BCC L3B692		; B69E	$90 $F2		loop
	JSR $B7E2		; B6A0	$20 $E2 $B7	draw text window and text ??
	JSR $B7B4		; B6A3	$20 $B4 $B7	Init cursor ??
	LDA $FF			; B6A6	$A5 $FF
	STA PpuControl_2000	; B6A8	$8D $00 $20
	; Choose the Save file or New game select loop
L3B6AB:
	JSR Wait_NMI		; B6AB	$20 $00 $FE
	LDA #$02		; B6AE	$A9 $02
	STA SpriteDma_4014	; B6B0	$8D $14 $40
	JSR Init_Page2		; B6B3	$20 $6E $C4
	JSR $C74F		; B6B6	$20 $4F $C7	sound ??
	JSR $9652		; B6B9	$20 $52 $96	cursor draw ??
	JSR $B72D		; B6BC	$20 $2D $B7	check key ??
	LDA a_pressing		; B6BF	$A5 $24
	BEQ L3B6AB		; B6C1	$F0 $E8		LOOP [Save file select]
	JSR KeyRst_SndE		; B6C3	$20 $5E $90
	LDA cur_pos		; B6C6	$AD $F0 $78
	CMP #$10		; B6C9	$C9 $10
	BCS L3B710		; B6CB	$B0 $43
	LSR A			; B6CD	$4A
	LSR A			; B6CE	$4A
	STA $80			; B6CF	$85 $80
	TAY			; B6D1	$A8
	LSR A			; B6D2	$4A
	ROR A			; B6D3	$6A
	ROR A			; B6D4	$6A
	TAX			; B6D5	$AA
	LDA $6110,X		; B6D6	$BD $10 $61	message speed
	TAX			; B6D9	$AA
	LDA $0088,Y		; B6DA	$B9 $88 $00
	BNE L3B710		; B6DD	$D0 $31		if save file not valid
	LDA $80			; B6DF	$A5 $80
	ASL A			; B6E1	$0A
	CLC			; B6E2	$18
	ADC $80			; B6E3	$65 $80
	ADC #$63		; B6E5	$69 $63
	STA $81			; B6E7	$85 $81
	LDA #$00		; B6E9	$A9 $00
	STA $80			; B6EB	$85 $80		Load savefile address
	LDY #$00		; B6ED	$A0 $00
L3B6EF:
	LDA ($80),Y		; B6EF	$B1 $80
	STA $6000,Y		; B6F1	$99 $00 $60	($6000-$60FF)
	INY			; B6F4	$C8
	BNE L3B6EF		; B6F5	$D0 $F8		loop
	INC $81			; B6F7	$E6 $81
L3B6F9:
	LDA ($80),Y		; B6F9	$B1 $80
	STA $6100,Y		; B6FB	$99 $00 $61	($6100-$61FF)
	INY			; B6FE	$C8
	BNE L3B6F9		; B6FF	$D0 $F8		loop
	INC $81			; B701	$E6 $81
L3B703:
	LDA ($80),Y		; B703	$B1 $80
	STA $6200,Y		; B705	$99 $00 $62	($6200-$62FF)
	INY			; B708	$C8
	BNE L3B703		; B709	$D0 $F8		loop
	STX $601F		; B70B	$8E $1F $60	message speed
	SEC			; B70E	$38
	RTS			; B70F	$60
; End of

L3B710:
	JSR Init_variables	; B710	$20 $B0 $Ff
	LDA #$08		; B713	$A9 $08
	STA ch_stats_4		; B715	$8D $C0 $61
	LDA $08			; B718	$A5 $08
	STA msg_spd		; B71A	$8D $1F $60
	JSR Char_name_sel	; B71D	$20 $F4 $B4
	LDX #$05		; B720	$A2 $05
L3B722:
	LDA $61C2,X		; B722	$BD $C2 $61 	name copy 6bytes to $6276
	STA $6276,X		; B725	$9D $76 $62
	DEX			; B728	$CA
	BPL L3B722		; B729	$10 $F7
	CLC			; B72B	$18
	RTS			; B72C	$60
; End of

; Name	:
; Marks	:
	JSR $9693		; B72D	$20 $93 $96	event? key check
	AND #$0F		; B730	$29 $0F
	BEQ L3B75A		; B732	$F0 $26
	CMP #$04		; B734	$C9 $04
	BCC L3B75B		; B736	$90 $23
	CMP #$08		; B738	$C9 $08
	BCS L3B74A		; B73A	$B0 $0E
	LDA $78F0		; B73C	$AD $F0 $78
	CLC			; B73F	$18
	ADC #$04		; B740	$69 $04
	CMP #$14		; B742	$C9 $14
	BCC L3B754		; B744	$90 $0E
	LDA #$00		; B746	$A9 $00
	BEQ L3B754		; B748	$F0 $0A
L3B74A:
	LDA $78F0		; B74A	$AD $F0 $78
	SEC			; B74D	$38
	SBC #$04		; B74E	$E9 $04
	BCS L3B754		; B750	$B0 $02
	LDA #$10		; B752	$A9 $10
L3B754:
	STA $78F0		; B754	$8D $F0 $78
	JMP $B7A4		; B757	$4C $A4 $B7
L3B75A:
	RTS			; B75A	$60
; End of
L3B75B:
.byte $C9,$02,$B0,$0F,$AD
.byte $F0,$78,$C9,$10,$B0,$17,$0A,$0A,$0A,$0A,$AA,$4C,$91,$B7,$AD,$F0
.byte $78,$C9,$10,$B0,$10,$0A,$0A,$0A,$0A,$AA,$4C,$99,$B7,$A5,$08,$18
.byte $69,$01,$4C,$8A,$B7,$A5,$08,$38,$E9,$01,$29,$07,$85,$08,$4C,$A4
.byte $B7,$BD,$10,$61,$18,$69,$01,$D0,$06,$BD,$10,$61,$38,$E9,$01,$29
.byte $07,$9D,$10,$61,$AD,$F0,$78,$C9,$10,$B0,$37,$4A,$4A,$09,$10,$85
.byte $9E,$4C,$EC,$B7
; Name	:
; Marks	: copy data(address??) from $B7CE- to $7800-(general buffer??)
;	  Init_cursor ??
	LDX #$18		; B7B4	$A2 $18
L3B7B6:
	LDA $B7CE,X		; B7B6	$BD $CE $B7
	STA $7800,X		; B7B9	$9D $00 $78
	DEX			; B7BC	$CA
	BPL L3B7B6		; B7BD	$10 $F7
	LDA #$00		; B7BF	$A9 $00
	STA cur_pos		; B7C1	$8D $F0 $78
	LDA #$14		; B7C4	$A9 $14
	STA len_cur_dat		; B7C6	$8D $F1 $78
	LDA #$01		; B7C9	$A9 $01
	STA $A2			; B7CB	$85 $A2
	RTS			; B7CD	$60
; End of
; data block---
.byte $02,$04
.byte $00,$00,$02,$09,$00,$00,$02,$0E,$00,$00,$02,$13,$00,$00,$02,$19
.byte $00,$00
; Name	:
; Marks	:
	LDX #$15		; B7E2	$A2 $15
	JSR $B486		; B7E4	$20 $86 $B4	set window position ??
	LDA #$4B		; B7E7	$A9 $4B
	JMP $B87A		; B7E9	$4C $7A $B8
; End of

; Name	:
; Marks	: $9E = ?? only bit1-0 valid
	LDA $9E			; B7EC	$A5 $9E
	AND #$03		; B7EE	$29 $03
	CLC			; B7F0	$18
	ADC #$11		; B7F1	$69 $11
	TAX			; B7F3
	JSR $B486		; B7F4	$20 $86 $B4	text window draw ??
	LDA #$4A		; B7F7	$A9 $4A
	JMP $B845		; B7F9	$4C $45 $B8
; End of

; Name	:
; Marks	: $8C = save slot ??
;	  Load save file's character properties ??
	LDA #$00		; B7FC	$A9 $00
	STA $8C			; B7FE	$85 $8C
L3B800:
	JSR $B80F		; B800	$20 $0F $B8
	LDA $8C			; B803	$A5 $8C
	CLC			; B805	$18
	ADC #$01		; B806	$69 $01
	STA $8C			; B808	$85 $8C
	CMP #$04		; B80A	$C9 $04
	BCC L3B800		; B80C	$90 $F2
	RTS			; B80E	$60
; End of

; Name	:
; Marks	: $80(ADDR) - Save file address
;	  Get some chatacter properties
	LDA $8C			; B80F	$A5 $8C
	STA $80			; B811	$85 $80
	ASL A			; B813	$0A
	CLC			; B814	$18
	ADC $80			; B815	$65 $80
	ADC #$63		; B817	$69 $63
	STA $81			; B819	$85 $81
	LDA #$00		; B81B	$A9 $00
	STA $80			; B81D	$85 $80
	LDX $8C			; B81F	$A6 $8C
	LDA $88,X		; B821	$B5 $88		save file valid, if A == 00h
	BEQ L3B826		; B823	$F0 $01		if A == 00h
	RTS			; B825	$60
; End of
L3B826:
	LDY #$1F		; B826	$A0 $1F		message speed ??
	LDA ($80),Y		; B828	$B1 $80
	PHA			; B82A	$48
	INC $81			; B82B	$E6 $81
	LDA $8C			; B82D	$A5 $8C
	LSR A			; B82F	$4A
	ROR A			; B830	$6A
	ROR A			; B831	$6A
	TAX			; B832	$AA
	LDY #$00		; B833	$A0 $00
L3B835:
	LDA ($80),Y		; B835	$B1 $80
	STA $6100,X		; B837	$9D $00 $61	copy character properties(size = 10h)
	INY			; B83A	$C8
	INX			; B83B	$E8
	CPY #$10		; B83C	$C0 $10
	BCC L3B835		; B83E	$90 $F5
	PLA			; B840	$68
	STA $6100,X		; B841	$9D $00 $61
	RTS			; B844	$60
; End of

; Name	:
; A	:
; Marks	:
	JSR $DAF1		; B845	$20 $F1 $DA
	LDA $9E			; B848	$A5 $9E
	AND #$03		; B84A	$29 $03
	CLC			; B84C	$18
	ADC #$01		; B84D	$69 $01
	ORA #$80		; B84F	$09 $80
	STA $7B00		; B851	$8D $00 $7B
	LDA $9E			; B854	$A5 $9E
	LSR A			; B856	$4A
	ROR A			; B857	$6A
	ROR A			; B858	$6A
	AND #$C0		; B859	$29 $C0
	TAX			; B85B	$AA
	LDA ch_strength,X	; B85C	$BD $10 $61
	STA $61			; B85F	$85 $61
	LDA $9E			; B861	$A5 $9E
	AND #$03		; B863	$29 $03
	TAX			; B865	$AA
	LDA $88,X		; B866	$B5 $88		check save file 1~
	BEQ L3B881		; B868	$F0 $17
	LDA #$01		; B86A	$A9 $01
	STA $7B01		; B86C	$8D $01 $7B
	STA $7B02		; B86F	$8D $02 $7B
	LDA #$00		; B872	$A9 $00
	STA $7B03		; B874	$8D $03 $7B
	JMP $B881		; B877	$4C $81 $B8
new:;from last of save files show
	JSR $DAF1		; B87A	$20 $F1 $DA	check text ??
	LDA $08			; B87D	$A5 $08
	STA $61			; B87F	$85 $61
L3B881:
	LDA #$0A		; B881	$A9 $0A
	STA bank_tmp		; B883	$85 $93
	LDA #$00		; B885	$A9 $00
	STA $3E			; B887	$85 $3E
	LDA #$7B		; B889	$A9 $7B
	STA $3F			; B88B	$85 $3F
	JMP $E7AC		; B88D	$4C $AC $E7	text copy ??
; End of

; Name	:
; Marks	: Show Title story ??
	; Disable PPU
	LDA #$00		; B890 $A9 $00
	STA PpuMask_2001	; B892 $8D $01 $20
	; Palette buffer($03C0-$03DF) to set #$0F ??
	LDX #$1F		; B895 $A2 $1F
	LDA #$0F		; B897 $A9 $0F
L3B899:
	STA palette_UBGC,X	; B899 $9D $C0 $03
	DEX			; B89C $CA
	BPL L3B899		; B89D $10 $FA
	; Set some tile(ICONS) and palettes to PPU
	JSR $E491		; B89F $20 $91 $E4
	; Init some variables and PPU
	JSR NT0_OAM_init	; B8A2 $20 $06 $B9
	LDA PpuStatus_2002	; B8A5 $Ad $02 $20
	LDA #$20		; B8A5 $A9 $20
	STA PpuAddr_2006	; B8AA $8D $06 $20
	LDA #$00		; B8AD $A9 $00
	STA PpuAddr_2006	; B8AF $8D $06 $20
	LDX #$F0		; B8B2 $A2 $F0
	LDA #$FF		; B8B4 $A9 $FF
	; Fill Nametable0 to #$FF ($2000-$23C0)
L3B8B6:
	STA PpuData_2007	; B8B6 $8D $07 $20
	STA PpuData_2007	; B8B9 $8D $07 $20
	STA PpuData_2007	; B8BC $8D $07 $20
	STA PpuData_2007	; B8BF $8D $07 $20
	DEX			; B8C2
	BNE L3B8B6		; B8C3 $D0 $F1
	LDX #$40		; B8C5 $A2 $40
	LDA #$55		; B8C7 $A9 $55
	; Fill Nametable0 attribute set #$55
L3B8C9:
	STA PpuData_2007	; B8C9 $8D $07 $20
	DEX			; B8CC $CA
	BNE L3B8C9		; B8CD $D0 $FA
	LDA #$02		; B8CF $A9 $02
	STA palette_BG11	; B8D1 $8D $C6 $03
	STA palette_BG12	; B8D4 $8D $C7 $03
	STA palette_BG21	; B8D7 $8D $CA $03
	STA palette_BG22	; B8DA $8D $CB $03
	JSR Wait_NMI		; B8DD $20 $00 $FE
	JSR Palette_copy	; B8E0 $20 $30 $DC
	LDA #$00		; B8E3 $A9 $00
	STA PpuScroll_2005	; B8E5 $8D $05 $20
	STA PpuScroll_2005	; B8E8 $8D $05 $20
	; Show background
	LDA #$0A		; B8E8 $A9 $0A
	STA PpuMask_2001	; B8ED $8D $01 $20
	LDX #$18		; B8F0 $A2 $18
	; ?? Some calcuration
	JSR L3B451		; B8F2 $20 $51 $B4
	LDA #$49		; B8F5 $A9 $49
	; Very long processing ?? - text parsing ??
	JSR $B3F0		; B8F7 $20 $F0 $B3
	; Show title story text with flow and blink effect. Wait key input for Next screen.
	JSR Show_flow_blink	; B8FA $20 $32 $B9
	LDA #$00		; B8FD $A9 $00
	STA ApuStatus_4015	; B8FF $8D $15 $40
	STA PpuMask_2001	; B902 $8D $01 $20
	RTS			; B905
; End of

;; [$B900 :: 0x3B910]

; Name	: NT0_OAM_init
; Marks	: PPU enable
;	  Clear nametable0
;	  Variables initialization
;	  PPU init OAM to #$F0
;	  BGM set prelude
NT0_OAM_init:
	LDA #BGM_prelude	; B906 $A9 $41
	STA current_song_ID	; B908 $85 $E0
	JSR Clear_Nametable0	; B90A $20 $21 $F3
	LDA #$88		; B90D $A9 $88
	STA $FF			; B90F $85 $FF
	STA PpuControl_2000	; B911 $8D $00 $20
	LDA #$01		; B914 $A9 $01
	STA $37			; B916 $85 $37
	JSR Get_udlr		; B918 $20 $B6 $8E
	LDA #$00		; B91B $A9 $00
	STA $A2			; B91D $85 $A2
	STA $A3			; B91F $85 $A3
	STA $A4			; B921 $85 $A4
	JSR Init_Page2	; B923 $20 $6E $C4
	JSR Wait_NMI		; B926 $20 $00 $FE
	JSR Wait_NMI		; B929 $20 $00 $FE
	LDA #$02		; B92C $A9 $02
	STA SpriteDma_4014	; B92E $8D $14 $40
	RTS			; B931 $60
; End of NT0_OAM_init

attr_laddr = $62
attr_color = $63
; Name	: Show_flow_blink
; Mark	: Add attribute table address
Show_flow_blink:
	LDA #$C0		; B932	$A9 $C0
	STA attr_laddr		; B934	$85 $62
L3B936:
	JSR Blink_2line		; B936	$20 $4A $B9
	LDA attr_laddr		; B939	$A5 $62
	CLC			; B93B	$18
	ADC #$08		; B93C	$69 $08
	STA attr_laddr		; B93E	$85 $62
	CMP #$F8		; B940	$C9 $F8
	BCC L3B936		; B942	$90 $F2
L3B944:
	JSR $B9B0		; B944	$20 $B0 $B9
	JMP L3B944		; B947	$4C $44 $B9
; End of

; Name	: Blink_2line
; Mark	: Blink 2 text line(4 background tile)
Blink_2line:
	; Bottom right 01,Bottom left 01,Top right 10,Top left 10
	LDA #$5A		; B94A	$A9 $5A
	STA attr_color		; B94C	$85 $63
	; Blink 16*4 frame - top line
	JSR Blink_effect	; B94E	$20 $65 $B9
	LDA attr_laddr		; B951	$A5 $62
	CMP #$E8		; B953	$C9 $E8
	; if A == #$E8
	BEQ L3B95E		; B955	$F0 $07
	; Bottom right 10,Bottom left 10,Top right 11,Top left 11
	LDA #$AF		; B957	$A9 $AF
	STA attr_color		; B959	$85 $63
	; Blink 16*4 frame - top bottom
	JSR Blink_effect	; B95B	$20 $65 $B9
L3B95E:
	; Bottom right 11,Bottom left 11,Top right 11,Top left 11
	LDA #$FF		; B95E	$A9 $FF
	STA attr_color		; B960	$85 $63
	JMP $B9B0		; B962	$4C $B0 $B9
; End of Blink_2line

; Name	: Blink_effect
; Mark	: Set palette BG for blink effect
palette_tmp = $64
Blink_effect:
	LDA #$00		; B965	$A9 $00
	STA palette_tmp		; B967	$85 $64
L3B969:
	LDA palette_tmp		; B969	$A5 $64
	STA palette_BG22	; B96B	$8D $CB $03
L3B96E:
	; Wait NMI and some process(sound, key)
	JSR L3B9B0		; B96E	$20 $B0 $B9
	; Blink effect ??
	INC frame_cnt_L		; B971	$E6 $F0
	LDA $F0			; B973	$A5 $F0
	; Every 16 frame
	AND #$0F		; B975	$29 $0F
	BNE L3B985		; B977	$D0 $0C
	LDA palette_tmp		; B979	$A5 $64
	CLC			; B97B	$18
	ADC #$10		; B97C	$69 $10
	STA palette_tmp		; B97E	$85 $64
	CMP #$40		; B980	$C9 $40
	BCC L3B969		; B982	$90 $E5
	RTS			; B984	$60
; End of

L3B985:
	LSR A			; B985	$4A
	BCC L3B969		; B986	$90 $E1
	LDA palette_BG22	; B988	$AD $CB $03
	SEC			; B98B	$38
	SBC #$10		; B98C	$E9 $10
	BPL L3B992		; B98E	$10 $02
	LDA #$01		; B990	$A9 $01
L3B992:
	STA palette_BG22	; B992	$8D $CB $03
	JMP L3B96E		; B995	$4C $6E $B9
; End of

; Name	: attr_set
; Mark	: attr palette
;	  $62 attribute address
;	  $63 attribute color
;	  Set 4line color fill
attr_set:
	LDA PpuStatus_2002	; B998 $AD $02 $20
	LDA #$23		; B99B $A9 $23
	STA PpuAddr_2006	; B99D $8D $06 $20
	LDA attr_laddr		; B9A0 $A5 $62
	STA PpuAddr_2006	; B9A2 $8D $06 $20
	LDX #$08		; B9A5 $A2 $08
	LDA attr_color		; B9A7 $A5 $63
L3B9A9:
	STA PpuData_2007	; B9A9 $8D $07 $20
	DEX			; B9AC $CA
	BNE L3B9A9		; B9AD $D0 $FA
	RTS			; B9AF $60
; End of attr_set

; Name	:
; Marks	:
L3B9B0:
	JSR Wait_NMI		; B9B0 $20 $00 $FE
	JSR attr_set		; B9B3 $20 $98 $B9
	JSR Palette_copy	; B9B6 $20 $30 $DC
	LDA $FF			; B9B9 $A5 $FF
	STA PpuControl_2000	; B9BB $8D $00 $20
	; PpuScroll set to 0
	LDA #$00		; B9BE $A9 $00
	STA PpuScroll_2005	; B9C0 $8D $05 $20
	STA PpuScroll_2005	; B9C3 $8D $05 $20
	STA dialog_box		; B9C6 $85 $24
	STA b_pressing		; B9C8 $85 $24
	LDA #$0E		; B9CA $A9 $0E
	STA bank		; B9CC $85 $57
	; Sound??
	JSR $C74F		; B9CE $20 $4F $C7
	; key ??
	JSR $DBA2		; B9D1 $20 $A2 $DB
	LDA dialog_box		; B9D4 $A5 $24
	ORA b_pressing		; B9D6 $05 $25
	; Break routine
	BNE L3B9DB		; B9D8 $D0 $01
	RTS			; B9DA $60
; Return to Previous routine
L3B9DB:
	PLA			; B9DB
	PLA			; B9DC
	RTS			; B9DD
; Return to upper routine
.byte $A9,$0F
.byte $8D,$C1,$03,$A9,$0E,$85,$57,$A9,$00,$8D,$00,$70,$20,$E0,$BA,$20
.byte $FA,$BB,$20,$17,$BA,$EE,$00,$70,$20,$2F,$BC,$20,$E0,$BA,$20,$17

;; [$BA00 :: 0x3BA00]

.byte $BA,$20,$FE,$BB,$20,$2F,$BC,$EE,$00,$70,$AD,$00,$70,$C9,$12,$90
.byte $DB,$20,$17,$BA,$4C,$E2,$BB,$A9,$E0,$20,$1E,$BA,$A9,$E0,$48,$20
.byte $00,$FE,$A9,$0E,$85,$57,$20,$4F,$C7,$68,$38,$E9,$01,$D0,$EF,$60
.byte $20,$6E,$C4,$20,$68,$BC,$20,$00,$FE,$A9,$02,$8D,$14,$40,$20,$30
.byte $DC,$2C,$02,$20,$A9,$22,$8D,$06,$20,$A9,$52,$8D,$06,$20,$A2,$00
.byte $BD,$64,$BA,$8D,$07,$20,$E8,$E0,$07,$90,$F5,$A9,$00,$8D,$05,$20
.byte $8D,$05,$20,$60,$14,$08,$05,$00,$05,$0E,$04,$AD,$00,$70,$4A,$AA
.byte $A9,$4C,$85,$40,$A9,$4A,$85,$41,$BD,$9D,$BA,$85,$80,$BD,$A6,$BA
.byte $85,$82,$20,$8F,$88,$A5,$26,$38,$E9,$30,$AA,$A0,$0C,$BD,$02,$02
.byte $09,$20,$9D,$02,$02,$E8,$E8,$E8,$E8,$88,$D0,$F1,$60,$02,$00,$01
.byte $01,$01,$02,$00,$00,$01,$00,$0C,$18,$24,$30,$3C,$48,$54,$60,$A9
.byte $01,$85,$37,$A9,$04,$85,$38,$38,$E9,$01,$85,$97,$A9,$04,$85,$39
.byte $18,$69,$02,$85,$98,$A9,$18,$85,$3C,$A9,$18,$85,$3D,$A9,$04,$85
.byte $93,$A9,$00,$85,$3E,$A9,$BC,$85,$3F,$A9,$0E,$85,$57,$4C,$AC,$EA
.byte $A9,$0F,$8D,$C1,$03,$20,$00,$FE,$20,$30,$DC,$20,$4F,$C7,$20,$2A
.byte $BB,$A9,$00,$85,$F0,$20,$00,$FE,$A9,$02,$8D,$14,$40,$20,$30,$DC

;; [$BB00 :: 0x3BB00]

.byte $20,$4F,$C7,$E6,$F0,$A5,$F0,$29,$03,$D0,$EA,$AD,$C1,$03,$C9,$0F
.byte $D0,$08,$A9,$00,$8D,$C1,$03,$4C,$F5,$BA,$18,$69,$10,$29,$30,$8D
.byte $C1,$03,$D0,$D1,$A9,$30,$8D,$C1,$03,$60,$A9,$4A,$85,$54,$A9,$22
.byte $85,$55,$AD,$00,$70,$0A,$AA,$BD,$00,$BE,$85,$3E,$BD,$01,$BE,$85
.byte $3F,$20,$00,$FE,$2C,$02,$20,$A5,$55,$8D,$06,$20,$A5,$54,$8D,$06
.byte $20,$A0,$00,$A2,$0F,$B1,$3E,$F0,$0A,$C9,$FF,$F0,$19,$8D,$07,$20
.byte $C8,$D0,$F2,$20,$92,$BB,$A9,$00,$8D,$05,$20,$8D,$05,$20,$A9,$0E
.byte $85,$57,$4C,$4F,$C7,$60,$20,$92,$BB,$A5,$54,$18,$69,$40,$85,$54
.byte $A5,$55,$69,$00,$85,$55,$8D,$06,$20,$A5,$54,$8D,$06,$20,$C8,$4C
.byte $55,$BB,$A9,$00,$E0,$80,$B0,$08,$8D,$07,$20,$CA,$10,$FA,$A2,$0F
.byte $60,$A9,$00,$85,$54,$A9,$22,$85,$55,$20,$00,$FE,$2C,$02,$20,$A5
.byte $55,$8D,$06,$20,$A5,$54,$8D,$06,$20,$A2,$20,$A9,$00,$8D,$07,$20
.byte $CA,$D0,$FA,$8D,$05,$20,$8D,$05,$20,$A9,$0E,$85,$57,$20,$4F,$C7
.byte $A5,$54,$18,$69,$20,$85,$54,$A5,$55,$69,$00,$85,$55,$C9,$23,$90
.byte $C8,$60,$A9,$30,$8D,$C1,$03,$20,$A1,$BB,$20,$30,$BA,$20,$00,$FE
.byte $A9,$0E,$85,$57,$20,$4F,$C7,$4C,$ED,$BB,$A9,$00,$F0,$02,$A9,$01

;; [$BC00 :: 0x3BC00]

.byte $85,$10,$A9,$00,$85,$F0,$20,$6E,$C4,$A5,$F0,$4A,$45,$10,$29,$01
.byte $F0,$03,$20,$6B,$BA,$20,$68,$BC,$20,$00,$FE,$A9,$02,$8D,$14,$40
.byte $20,$30,$DC,$20,$4F,$C7,$E6,$F0,$A5,$F0,$C9,$20,$90,$D8,$60,$A9
.byte $00,$85,$F0,$AD,$C1,$03,$C9,$F0,$D0,$05,$A9,$0F,$8D,$C1,$03,$20
.byte $00,$FE,$A9,$02,$8D,$14,$40,$20,$30,$DC,$20,$4F,$C7,$E6,$F0,$A5
.byte $F0,$29,$03,$D0,$DE,$AD,$C1,$03,$38,$E9,$10,$8D,$C1,$03,$C9,$FF
.byte $D0,$D1,$A9,$0F,$8D,$C1,$03,$60,$A6,$26,$A0,$00,$B9,$7B,$BC,$9D
.byte $00,$02,$E8,$C8,$C0,$2C,$D0,$F4,$86,$26,$60,$57,$8A,$23,$48,$57
.byte $8B,$23,$50,$57,$8C,$23,$58,$5F,$8D,$23,$48,$5F,$8E,$23,$50,$5F
.byte $8F,$23,$58,$5F,$90,$23,$60,$67,$91,$23,$48,$67,$92,$23,$50,$67
.byte $93,$23,$58,$67,$94,$23,$60,$2C,$02,$20,$A9,$20,$8D,$06,$20,$A9
.byte $00,$8D,$06,$20,$A2,$00,$A9,$00,$8D,$07,$20,$8D,$07,$20,$8D,$07
.byte $20,$8D,$07,$20,$E8,$D0,$F1,$2C,$02,$20,$A9,$08,$85,$80,$A9,$21
.byte $85,$81,$A9,$08,$85,$82,$A2,$06,$A0,$00,$A5,$81,$8D,$06,$20,$A5
.byte $80,$8D,$06,$20,$B9,$29,$BD,$8D,$07,$20,$C8,$CA,$D0,$F6,$A2,$06
.byte $A5,$80,$18,$69,$20,$85,$80,$A5,$81,$69,$00,$85,$81,$C6,$82,$D0

;; [$BD00 :: 0x3BD00]

.byte $D9,$A9,$23,$8D,$06,$20,$A9,$D0,$8D,$06,$20,$A2,$00,$BD,$19,$BD
.byte $8D,$07,$20,$E8,$E0,$10,$90,$F5,$60,$00,$00,$FF,$33,$00,$00,$00
.byte $00,$00,$00,$AF,$23,$00,$00,$00,$00,$3E,$23,$24,$25,$26,$3E,$27
.byte $28,$29,$2A,$2B,$2C,$2D,$28,$28,$28,$28,$2E,$2F,$28,$28,$28,$28
.byte $30,$31,$32,$28,$28,$28,$33,$3E,$34,$35,$36,$37,$3E,$3E,$38,$39
.byte $3A,$3B,$3E,$3E,$3E,$3C,$3D,$3E,$3E,$A9,$21,$85,$81,$A9,$08,$85
.byte $82,$A2,$06,$A0,$00,$A5,$81,$8D,$06,$20,$A5,$80,$8D,$06,$20,$B9
.byte $B4,$BD,$8D,$07,$20,$C8,$CA,$D0,$EC,$A2,$06,$A5,$80,$18,$69,$20
.byte $85,$80,$A5,$81,$69,$00,$85,$81,$C6,$82,$D0,$D9,$A9,$23,$8D,$06
.byte $20,$A9,$10,$8D,$06,$20,$A2,$10,$BD,$A4,$BD,$8D,$07,$20,$E8,$E0
.byte $10,$90,$F5,$60,$FF,$FF,$FF,$FF,$00,$00,$00,$00,$FA,$FA,$FA,$FA
.byte $00,$00,$00,$00,$00,$23,$24,$25,$26,$00,$27,$28,$29,$2A,$2B,$2C
.byte $2D,$28,$28,$28,$28,$2E,$2F,$28,$28,$28,$28,$30,$31,$32,$28,$28
.byte $28,$33,$00,$24,$35,$36,$37,$00,$00,$38,$39,$3A,$3B,$00,$00,$00
.byte $3C,$3D,$00,$00,$3A,$3B,$00,$00,$00,$3C,$3D,$00,$00,$9D,$BA,$A9
.byte $4B,$4C,$82,$BE,$A5,$9E,$29,$03,$18,$69,$11,$AA,$20,$9D,$BA,$01

;; [$BE00 :: 0x3BE00]

.byte $24,$BE,$3B,$BE,$52,$BE,$74,$BE,$92,$BE,$AF,$BE,$CA,$BE,$DF,$BE
.byte $FA,$BE,$13,$BF,$2A,$BF,$47,$BF,$66,$BF,$87,$BF,$A6,$BF,$BC,$BF
.byte $D9,$BF,$F5,$BF,$10,$12,$0F,$07,$12,$01,$0D,$FF,$18,$0E,$01,$13
.byte $09,$12,$18,$07,$05,$02,$05,$0C,$0C,$09,$00,$13,$03,$05,$0E,$01
.byte $12,$09,$0F,$FF,$18,$0B,$05,$0E,$0A,$09,$18,$14,$05,$12,$01,$04
.byte $01,$00,$03,$08,$01,$12,$01,$03,$14,$05,$12,$18,$04,$05,$13,$09
.byte $07,$0E,$FF,$18,$19,$0F,$13,$08,$09,$14,$01,$0B,$01,$18,$01,$0D
.byte $01,$0E,$0F,$00,$07,$01,$0D,$05,$18,$04,$05,$13,$09,$07,$0E,$FF
.byte $18,$08,$09,$12,$0F,$0D,$09,$03,$08,$09,$18,$14,$01,$0E,$01,$0B
.byte $01,$00,$07,$01,$0D,$05,$18,$04,$05,$13,$09,$07,$0E,$FF,$18,$01
.byte $0B,$09,$14,$0F,$13,$08,$09,$18,$0B,$01,$17,$01,$1A,$15,$00,$07
.byte $01,$0D,$05,$18,$04,$05,$13,$09,$07,$0E,$FF,$18,$0B,$0F,$15,$09
.byte $03,$08,$09,$18,$09,$13,$08,$09,$09,$00,$10,$12,$0F,$07,$12,$01
.byte $0D,$FF,$18,$0E,$01,$0F,$0B,$09,$18,$0F,$0B,$01,$02,$05,$00,$10
.byte $12,$0F,$07,$12,$01,$0D,$FF,$18,$0B,$01,$14,$13,$15,$08,$09,$13
.byte $01,$18,$08,$09,$07,$15,$03,$08,$09,$00,$07,$12,$01,$10,$08,$09

;; [$BF00 :: 0x3BF00]

.byte $03,$13,$FF,$18,$0B,$01,$1A,$15,$0B,$0F,$18,$13,$08,$09,$02,$15
.byte $19,$01,$00,$07,$12,$01,$10,$08,$09,$03,$13,$FF,$18,$12,$19,$0F
.byte $0B,$0F,$18,$14,$01,$0E,$01,$0B,$01,$00,$0D,$15,$13,$09,$03,$18
.byte $03,$0F,$0D,$10,$0F,$13,$05,$FF,$18,$0E,$0F,$02,$15,$0F,$18,$15
.byte $05,$0D,$01,$14,$13,$15,$00,$13,$0F,$15,$0E,$04,$18,$04,$05,$13
.byte $09,$07,$0E,$FF,$18,$0D,$01,$13,$01,$0E,$0F,$12,$09,$18,$08,$0F
.byte $13,$08,$09,$0E,$0F,$00,$10,$12,$0F,$07,$12,$01,$0D,$18,$01,$13
.byte $13,$09,$13,$14,$FF,$18,$08,$09,$12,$0F,$13,$08,$09,$18,$0E,$01
.byte $0B,$01,$0D,$15,$12,$01,$00,$10,$12,$0F,$07,$12,$01,$0D,$18,$01
.byte $13,$13,$09,$13,$14,$FF,$18,$14,$01,$0B,$05,$19,$0F,$13,$08,$09
.byte $18,$09,$14,$0F,$08,$00,$14,$08,$01,$0E,$0B,$13,$18,$14,$0F,$FF
.byte $18,$13,$1C,$0B,$01,$0A,$09,$14,$01,$0E,$09,$00,$04,$09,$12,$05
.byte $03,$14,$05,$12,$FF,$18,$08,$09,$12,$0F,$0E,$0F,$02,$15,$18,$13
.byte $01,$0B,$01,$07,$15,$03,$08,$09,$00,$10,$12,$0F,$04,$15,$03,$05
.byte $12,$FF,$18,$0D,$01,$13,$01,$06,$15,$0D,$09,$18,$0D,$09,$19,$01
.byte $0D,$0F,$14,$0F,$00,$FF,$1D,$03,$1F,$13,$11,$15,$01,$12,$05,$00

; ========== MAP/MENU CODE END($8800-$C000) ==========
