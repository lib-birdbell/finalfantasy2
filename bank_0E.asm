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
	STX $08			; 93BF	$86 $08
	JSR $9614		; 93C1	$20 $14 $96
	LDA $79F1		; 93C4	$AD $F1 $79
	BEQ L393CD		; 93C7	$F0 $04
	LDA #$49		; 93C9	$A9 $49		play song $09
	STA $E0			; 93CB	$85 $E0
L393CD:
	LDA $A0			; 93CD	$A5 $A0		A = npc id
	LDX $08			; 93CF	$A6 $08		X = key item id
; npc $19: ricard (leviathan)
	CMP #$19		; 93D1	$C9 $19
	BNE L393EC		; 93D3	$D0 $17
	CPX #$0D		; 93D5	$E0 $0D		CrystlRod
	BNE L393E9		; 93D7	$D0 $10
	LDA #$08		; 93D9	$A9 $08		ricard
	STA $61			; 93DB	$85 $61
	JSR $C018		; 93DD	$20 $18 $C0	load guest character properties
	LDA #$4A		; 93E0	$A9 $4A		play song $0A
	STA $E0			; 93E2	$85 $E0
	LDY #$19		; 93E4	$A0 $19
	JMP $93F6		; 93E6	$4C $F6 $93
L393E9:
	JMP $9380		; 93E9	$4C $80 $93
; npc $32: dreadnought guard
L393EC:
	CMP #$32		; 93EC	$C9 $32
	BNE L393FC		; 93EE	$D0 $0C
	CPX #$03		; 93F0	$E0 $03		Pass
	BNE L393E9		; 93F2	$D0 $F5
	LDY #$32		; 93F4	$A0 $32
	JSR $9907		; 93F6	$20 $07 $99	hide npc
	JMP $9380		; 93F9	$4C $80 $93  
; npc $34: tobul
L393FC:
	CMP #$34		; 93FC	$C9 $34
	BNE L3943D		; 93FE	$D0 $3D
	CPX #$04		; 9400	$E0 $04		Mythril
	BNE L393E9		; 9402	$D0 $E5
	LDA #$04		; 9404	$A9 $04		item $04: Mythril
	JSR $958C		; 9406	$20 $8C $95	remove item from inventory
	LDA #$47		; 9409	$A9 $47		play song $07
	STA $E0			; 940B	$85 $E0
	LDA $601A		; 940D	$AD $1A $60	remove mythril
	AND #$EF		; 9410	$29 $EF
	STA $601A		; 9412	$8D $1A $60
	LDY #$C3		; 9415	$A0 $C3		altair mythril weapon shop
	JSR $98C7		; 9417	$20 $C7 $98	set event switch and show npc
	LDY #$C4		; 941A	$A0 $C4		altair mythril armor shop
	JSR $98C7		; 941C	$20 $C7 $98	set event switch and show npc
	LDY #$CA		; 941F	$A0 $CA		unknown mythril weapon shop
	JSR $98C7		; 9421	$20 $C7 $98	set event switch and show npc
	LDY #$23		; 9424	$A0 $23		borghen (bafsk)
	JSR $98C7		; 9426	$20 $C7 $98	set event switch and show npc
	LDY #$67		; 9429	$A0 $67		child (rebel base)
	JSR $98C7		; 942B	$20 $C7 $98	set event switch and show npc
	LDY #$68		; 942E	$A0 $68		old man (rebel base)
	JSR $98C7		; 9430	$20 $C7 $98	set event switch and show npc
	LDY #$69		; 9433	$A0 $69		rebel (rebel base)
	JSR $98C7		; 9435	$20 $C7 $98	set event switch and show npc
	LDY #$1A		; 9438	$A0 $1A		dark knight (bafsk)
	JMP $93F6		; 943A	$4C $F6 $93
; npc $38: sunfire holder
L3943D:
	CMP #$38		; 943D: $C9 $38
	BNE L3945E		; 943F: $D0 $1D
	CPX #$07		; 9441: $E0 $07		Egil'sTorch
	BNE L393E9		; 9443: $D0 $A4
	LDA #$08		; 9445: $A9 $08		item $08: Sunfire
	JSR $9573		; 9447: $20 $73 $95	add item to inventory (unique)
	LDY #$01		; 944A: $A0 $01		hilda (altair throne room)
	JSR $9907		; 944C: $20 $07 $99	hide npc
	LDY #$DD		; 944F: $A0 $DD		clear event switch $605B.5
	JSR $9907		; 9451: $20 $07 $99	hide npc
	LDY #$07		; 9454: $A0 $07		cid (poft)
	JSR $9907		; 9456: $20 $07 $99	hide npc
	LDY #$38		; 9459: $A0 $38		sunfire holder
	JMP $93F6		; 945B: $4C $F6 $93
; npc $39: dreadnought core
L3945E:
	CMP #$39		; 945E: $C9 $39
	BNE L3946C		; 9460	$D0 $0A
	CPX #$08		; 9462	$E0 $08		Sunfire
	BNE L393E9		; 9464	$D0 $83
	LDA $7B03		; 9466	$AD $03 $7B	do event $09: sunfire destroys dreadnought
	JMP $94B3		; 9469	$4C $B3 $94  
; npc $3B: life spring
L3946C:
	CMP #$3B		; 946C	$C9 $3B
	BNE L3948A		; 946E	$D0 $1A
	CPX #$0A		; 9470	$E0 $0A		WyvernEgg
	BNE L394DA		; 9472	$D0 $66
	LDA #$0A		; 9474	$A9 $0A		item $0A: WyvernEgg
	JSR $958C		; 9476	$20 $8C $95	remove item from inventory
	LDA #$47		; 9479	$A9 $47		play song $07
	STA $E0			; 947B	$85 $E0
	LDA $601B		; 947D	$AD $1B $60	remove wyvern egg
	AND #$FB		; 9480	$29 $FB
	STA $601B		; 9482	$8D $1B $60
	LDY #$25		; 9485	$A0 $25
	JMP $93F6		; 9487	$4C $F6 $93
; npc $40: doppelganger
L3948A:
	CMP #$40		; 948A	$C9 $40
	BNE L39497		; 948C	$D0 $09
	CPX #$0C		; 948E	$E0 $0C		BlackMask
	BNE L394DA		; 9490	$D0 $48
	LDY #$40		; 9492	$A0 $40
	JMP $93F6		; 9494	$4C $F6 $93
; npc $46: fynn castle mirror
L39497:
	CMP #$46		; 9497	$C9 $46
	BNE L394B8		; 9499	$D0 $1D
	CPX #$09		; 949B	$E0 $09		Pendant
	BNE L394DA		; 949D	$D0 $3B
	LDY #$45		; 949F	$A0 $45		center orb (mysidian tower)
	JSR $989E		; 94A1	$20 $9E $98	check event switch
	BNE L394DA		; 94A4	$D0 $34
	LDA #$0E		; 94A6	$A9 $0E	$	item $0E: Wyvern
	JSR $9573		; 94A8	$20 $73 $95	add item to inventory (unique)
	LDY #$46		; 94AB	$A0 $46	$	fynn castle mirror
	JSR $9907		; 94AD	$20 $07 $99	hide npc
	LDA $7B05		; 94B0	$AD $05 $7B	do event $0E: wyvern hatches
	STA $6C			; 94B3	$85 $6C
	JMP $91DC		; 94B5	$4C $DC $91
; npc $54: kashuan keep door
L394B8:
	CMP #$54		; 94B8	$C9 $54
	BNE L394C9		; 94BA	$D0 $0D
	CPX #$06		; 94BC	$E0 $06		\bellGoddess's
	BNE L394DA		; 94BE	$D0 $1A
	LDA #$47		; 94C0	$A9 $47		play song $07
	STA $E0			; 94C2	$85 $E0
	LDY #$54		; 94C4	$A0 $54
	JMP $93F6		; 94C6	$4C $F6 93  
; npc $59: mysidian statue
L394C9:
	CMP #$59		; 94C9	$C9 $59
	BNE L394DA		; 94CB	$D0 $0D
	CPX #$0B		; 94CD	$E0 $0B		WhiteMask
	BNE L394DA		; 94CF	$D0 $09
	LDA #$47		; 94D1	$A9 $47		play song $07
	STA $E0			; 94D3	$85 $E0
	LDY #$59		; 94D5	$A0 $59
	JSR $9907		; 94D7	$20 $07 $99	hide npc
L394DA:
	JMP $9380		; 94DA	$4C $80 $93	return
; End of

; Marks	; unused ??
	JSR $9523		; 94DD	$20 $23 $95	restore dialogue window variables
	LDA $1C			; 94E0	$A5 $1C
	STA $3E			; 94E2	$85 $3E
	LDA $1D			; 94E4	$A5 $1D
	STA $3F			; 94E6	$85 $3F
	JMP $E7AC		; 94E8	$4C $AC $E7
; End of

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

; Name	:
; Marks	: restore dialogue window variables
	LDA $7AF8		; 9523	$AD $F8 $7A
	STA $38			; 9526	$85 $38
	LDA $7AF9		; 9528	$AD $F9 $7A
	STA $39			; 952B	$85 $39
	LDA $7AFA		; 952D	$AD $FA $7A
	STA $97			; 9530	$85 $97
	LDA $7AFB		; 9532	$AD $FB $7A
	STA $98			; 9535	$85 $98
	LDA $7AFC		; 9537	$AD $FC $7A
	STA $3C			; 953A	$85 $3C
	LDA $7AFD		; 953C	$AD $FD $7A
	STA $3D			; 953F	$85 $3D
	LDA $7AF7		; 9541	$AD $F7 $7A
	STA $93			; 9544	$85 $93
	LDA $7AFE		; 9546	$AD $FE $7A
	STA $1C			; 9549	$85 $1C
	LDA $7AFF		; 954B	$AD $FF $7A
	STA $1D			; 954E	$85 $1D
	LDA $7AF4		; 9550	$AD $F4 $7A
	STA $3E			; 9553	$85 $3E
	LDA $7AF5		; 9555	$AD $F5 $7A
	STA $3F			; 9558	$85 $3F
	RTS			; 955A	$60
; End of

; Name	:
; Marks	: show keyword select window
	LDA #$02		; 955B	$A9 $02
	STA $96			; 955D	$85 $96
	JSR $E91E		; 955F	$20 $1E $E9
	LDA #$41		; 9562	$A9 $41
	JMP $9603		; 9564	$4C $03 $96
; End of

; Name	:
; Marks	: show item select select window
	LDA #$02		; 9567	$A9 $02
	STA $96			; 9569	$85 $96		text window size ??
	JSR $E91E		; 956B	$20 $1E $E9
	LDA #$42		; 956E	$A9 $42
	JMP $9603		; 9570	$4C $03 $96
; End of

; Name	:
; Marks	: add item to inventory (unique)
	JSR $957C		; 9573	$20 $7C $95	find item in inventory
	BCS L3957B		; 9576	$B0 $03		return if found
	JMP $9873		; 9578	$4C $73 $98	add item to inventory
L3957B:
	RTS			; 957B	$60        
; End of

; Name	:
; Marks	: find item in inventory
; return carry set if found
	LDX #$00		; 957C	$A2 $00
L3957E:
	CMP $6060,X		; 957E	$DD $60 $60
	BEQ L3958A		; 9581	$F0 $07
	INX			; 9583	$E8
	CPX #$20		; 9584	$E0 $20
	BCC L3957E		; 9586	$90 $F6
	CLC			; 9588	$18
	RTS			; 9589	$60
L3958A:
	SEC			; 958A	$38
	RTS			; 958B	$60
; End of

; Name	:
; Marks	: remove item from inventory
	JSR $957C		; 958C	$20 $7C $95	find item in inventory
	BCC L39596		; 958F	$90 $05
	LDA #$00		; 9591	$A9 $00
	STA $6060,X		; 9593	$9D $60 $60
L39596:
	RTS			; 9596	$60
; End of

; Name	:
; A	: keyword id
; Marks	: learn keyword
	STA $80			; 9597	$85 $80
	LDX #$0F		; 9599	$A2 $0F
L3959B:
	CMP $6080,X		; 959B	$DD $80 $60
	BEQ L395B8		; 959E	$F0 $18
	DEX			; 95A0	$CA
	BPL L3959B		; 95A1	$10 $F8
	LDX #$0E		; 95A3	$A2 $0E
L395A5:
	LDA $6080,X		; 95A5	$BD $80 $60
	STA $6081,X		; 95A8	$9D $81 $60
	DEX			; 95AB	$CA
	BPL L395A5		; 95AC	$10 $F7
	LDA $80			; 95AE	$A5 $80
	STA $6080		; 95B0	$8D $80 $60
	LDA #$49		; 95B3	$A9 $49		play song $09
	STA $E0			; 95B5	$85 $E0
	RTS			; 95B7	$60
L395B8:
	DEX			; 95B8	$CA
	BMI L395C9		; 95B9	$30 $0E
L395BB:
	LDA $6080,X		; 95BB	$BD $80 $60
	STA $6081,X		; 95BE	$9D $81 $60
	DEX			; 95C1	$CA
	BPL L395BB		; 95C2	$10 $F7
	LDA $80			; 95C4	$A5 $80
	STA $6080		; 95C6	$8D $80 $60
L395C9:
	RTS			; 95C9	$60
; End of

; Name	:
; Marks	: Copy OAM
;	  wait one frame (draw cursors) ]
;	  used for dialogue with cursors
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
; Marks	: load text (multi-page)
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
; Marks	: load text (single-page)
	STA text_ID		; 9603	$85 $92
	LDA #$0A		; 9605	$A9 $0A
	STA text_bank		; 9607	$85 $93
	LDA #$00		; 9609	$A9 $00
	STA text_offset		; 960B	$85 $94
	LDA #$84		; 960D	$A9 $84
	STA $95			; 960F	$85 $95
	JMP $EA8C		; 9611	$4C $8C $EA
; End of

; Name	:
; Marks	:
	PHA 			; 9614	$48
	JSR $D164		; 9615	$20 $64 $D1	close text window (dialogue)
	LDA #$00		; 9618	$A9 $00
	STA $96			; 961A	$85 $96
	JSR $E91E		; 961C	$20 $1E $E9	open window
	LDA #$00		; 961F	$A9 $00
	STA $79F1		; 9621	$8D $F1 $79
	PLA			; 9624	$68
	STA $92			; 9625	$85 $92
	LDA #$00		; 9627	$A9 $00		BANK 0A/8000
	STA $94			; 9629	$85 $94
	LDA #$80		; 962B	$A9 $80
	STA $95			; 962D	$85 $95
	LDA $A0			; 962F	$A5 $A0
	LDX #$06		; 9631	$A2 $06
	CMP #$60		; 9633	$C9 $60
	BCC L39639		; 9635	$90 $02
	LDX #$0A		; 9637	$A2 $0A
L39639:
	STX $93			; 9639	$86 $93
	JMP $EA54		; 963B	$4C $54 $EA	load text (multi-page)
; End of

; Name	:
; Marks	: display menu message ???
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
;	  draw cursor sprite 1
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
; Name	:
; Marks	: draw cursor sprite 2
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
; Name	:
; Marks	: draw cursor sprite 3
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
; Marks	: get cursor movement direction
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
; A	: up/down increment
; Marks	: Check cursor position
;	  get cursor 1 position
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
; Name	:
; A	: up/down increment
; Marks	: update cursor 2 position
	STA $06			; 96F9	$85 $06
	JSR $9693		; 96FB	$20 $93 $96
	AND #$0F		; 96FE: $29 $0F
	BEQ L3971C		; 9700: $F0 $1A
	CMP #$04		; 9702: $C9 $04
	BCS L3970A		; 9704: $B0 $04
	LDX #$04		; 9706: $A2 $04
	STX $06			; 9708: $86 $06
L3970A:
	AND #$05		; 970A: $29 $05
	BNE L3971D		; 970C: $D0 $0F
	LDA $79F0		; 970E: $AD $F0 $79
	SEC			; 9711: $38
	SBC $06			; 9712: $E5 $06
	BCS L39719		; 9714: $B0 $03
	ADC $79F1		; 9716: $6D $F1 $79
L39719:
	STA $79F0		; 9719: $8D $F0 $79
L3971C:
	RTS			; 971C: $60
L3971D:
	LDA $79F0		; 971D: $AD $F0 $79
	CLC			; 9720: $18
	ADC $06			; 9721: $65 $06
	CMP $79F1		; 9723: $CD $F1 $79
	BCC L39719		; 9726: $90 $F1
	SBC $79F1		; 9728: $ED $F1 $79
	BCS L39719		; 972B: $B0 $EC
; Name	:
; A	: up/down increment
; Marks	: update cursor 3 position
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
	JSR $E7B6		; 9753	$20 $B6 $E7
	BCS L3977A		; 9756	$B0 $22
	JSR $94EB		; 9758	$20 $EB $94	save dialogue window variables
	LDA $05			; 975B	$A5 $05
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
	JSR $9523		; 9772	$20 $23 $95	restore dialogue window variables
	JSR $E797		; 9775	$20 $97 $E7
	BCC L39781		; 9778	$90 $07
L3977A:
	LDA #$00		; 977A	$A9 $00
	STA $47			; 977C	$85 $47     
	JMP $DE67		; 977E	$4C $67 $DE	play error sound effect
L39781:
	JSR $94EB		; 9781	$20 $EB $94	save dialogue window variables
	LDA $05			; 9784	$A5 $05
	CMP $7AF1		; 9786	$CD $F1 $7A
	BCC L3975D		; 9789	$90 $D2
	LDA $7AF1		; 978B	$AD $F1 $7A
	SEC			; 978E	$38
	SBC #$04		; 978F	$E9 $04
	JMP $975D		; 9791	$4C $5D $97
; End of



;----------------------------------------------------------------------



; Name	:
; X	: npc id ??
; Ret	: A(text_ID)
; Marks	: $94(ADDR) ??, $84(ADDR) = pointer to npc scripts
;	  check npc script
;	  returns npc dialogue id
	LDA #$06		; 9794	$A9 $06		BANK 06/8000 (pointers to text 1)
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
	LDX #$0A		; 97AD	$A2 $0A		BANK 0A/8000 (pointers to text 2)
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
	LDA $8300,X		; 97C0	$BD $00 $83
	STA $84			; 97C3	$85 $84
	LDA $8301,X		; 97C5	$BD $01 $83
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

; Name	:
; Marks	:
	LDX #$3F		; 97FF	$A2 $3F
L39801:
	LDA $61C0,X		; 9801	$BD $C0 $61
	STA $6090,X		; 9804	$9D $90 $60
	DEX			; 9807	$CA
	BPL L39801		; 9808	$10 $F7
	LDX #$2F		; 980A	$A2 $2F
L3980C:
	LDA $62C0,X		; 980C	$BD $C0 $62
	STA $60D0,X		; 980F	$9D $D0 $60
	DEX			; 9812	$CA
	BPL L3980C		; 9813	$10 $F7
	LDX #$05		; 9815	$A2 $05
L39817:
	LDA $62F0,X		; 9817	$BD $F0 $62
	STA $62F6,X		; 981A	$9D $F6 $62
	DEX			; 981D	$CA
	BPL L39817		; 981E	$10 $F7
	RTS			; 9820	$60
; End of

; Name	:
; Marks	:
	LDX #$3F		; 9821	$A2 $3F
L39823:
	LDA $61C0,X		; 9823	$BD $C0 $61
	PHA			; 9826	$48
	LDA $6090,X		; 9827	$BD $90 $60
	STA $61C0,X		; 982A	$9D $C0 $61
	PLA			; 982D	$68
	STA $6090,X		; 982E	$9D $90 $60
	DEX			; 9831	$CA
	BPL L39823		; 9832	$10 $EF
	LDX #$2F		; 9834	$A2 $2F
L39836:
	LDA $62C0,X		; 9836	$BD $C0 $62
	PHA			; 9839	$48
	LDA $60D0,X		; 983A	$BD $D0 $60
	STA $62C0,X		; 983D	$9D $C0 $62
	PLA			; 9840	$68
	STA $60D0,X		; 9841	$9D $D0 $60
	DEX			; 9844	$CA
	BPL L39836		; 9845	$10 $EF
	LDX #$05		; 9847	$A2 $05
L39849:
	LDA $62F0,X		; 9849	$BD $F0 $62
	PHA			; 984C	$48
	LDA $62F6,X		; 984D	$BD $F6 $62
	STA $62F0,X		; 9850	$9D $F0 $62
	PLA			; 9853	$68
	STA $62F6,X		; 9854	$9D $F6 $62
	DEX			; 9857	$CA
	BPL L39849		; 9858	$10 $EF
	LDA #$00		; 985A	$A9 $00
	STA $62F5		; 985C	$8D $F5 $62
	STA $61C1		; 985F	$8D $C1 $61
	RTS			; 9862	$60
; End of

; Name	:
; Marks	: find first empty inventory slot
	LDY #$00		; 9863	$A0 $00
L39865:
	LDA $6060,Y		; 9865	$B9 $60 $60
	BEQ L39871		; 9868	$F0 $07
	INY			; 986A	$C8
	CPY #$20		; 986B	$C0 $20
	BCC L39865		; 986D	$90 $F6
	SEC			; 986F	$38
	RTS			; 9870	$60
L39871:
	CLC			; 9871	$18
	RTS			; 9872	$60
; End of

; Name	:
; Marks	: add item to inventory
; return carry set if inventory is full
	STA $80			; 9873	$85 $80
	JSR $9863		; 9875	$20 $63 $98	find first empty inventory slot
	BCS L39884		; 9878	$B0 $0A		inventory is full
	LDA $80			; 987A	$A5 $80
	STA $6060,Y		; 987C	$99 $60 $60
	CMP #$10		; 987F	$C9 $10
	BCC L39885		; 9881	$90 $02		branch if key item
	CLC			; 9883	$18
L39884:
	RTS			; 9884	$60
L39885:
	TAY			; 9885	$A8
	LDA $A400,Y		; 9886	$B9 $00 $A4
	STA $81			; 9889	$85 $81
	LDA $A500,Y		; 988B	$B9 $00 $A5
	TAY			; 988E	$A8
	LDA $601A,Y		; 988F	$B9 $1A $60	set key item switch
	ORA $81			; 9892	$05 $81
	STA $601A,Y		; 9894	$99 $1A $60
	LDA #$47		; 9897	$A9 $47		play song $07
	STA $E0			; 9899	$85 $E0
	CLC			; 989B	$18
	RTS			; 989C	$60
; unused
	RTS			; 989D	$60
;

; Name	:
; Ret	: A
; Marks	: $80(ADDR) ??
;	  check event switch
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

; Name	:
; Marks	: set event switch
	STY $80			; 98B1	$84 $80
	LDA $A400,Y		; 98B3	$B9 $00 $A4
	STA $81			; 98B6	$85 $81
	LDA $A500,Y		; 98B8	$B9 $00 $A5
	TAY			; 98BB	$A8
	LDA $6040,Y		; 98BC	$B9 $40 $60
	ORA $81			; 98BF	$05 $81
	STA $6040,Y		; 98C1	$99 $40 $60
	LDY $80			; 98C4	$A4 $80
	RTS			; 98C6	$60
; End of

; Name	:
; Marks	: set event switch and show npc
	JSR $98B1		; 98C7	$20 $B1 $98	set event switch
	LDY #$00		; 98CA	$A0 $00
L398CC:
	LDA $80			; 98CC	$A5 $80
	CMP $750A,Y		; 98CE	$D9 $0A $75
	BEQ L398DD		; 98D1	$F0 $0A
	TYA			; 98D3	$98
	CLC			; 98D4	$18
	ADC #$10		; 98D5	$69 $10
	TAY			; 98D7	$A8
	CMP #$C0		; 98D8	$C9 $C0
	BCC L398CC		; 98DA	$90 $F0
	RTS			; 98DC	$60
L398DD:
	STA $7500,Y		; 98DD	$99 $00 $75	show npc
	RTS			; 98E0	$60
; End of

; Name	:
; Marks	: set battle id
	STA $6A			; 98E1	$85 $6A
	LDA #$20		; 98E3	$A9 $20
	STA $44			; 98E5	$85 $44
	RTS			; 98E7	$60
; End of

; Marks	: set entrance id
;	  unused
	STA $45			; 98E8	$85 $45
	LDA #$80		; 98EA	$A9 $80
	STA $44			; 98EC	$85 $44
	RTS			; 98EE	$60
; End of

; Name	:
; Marks	: toggle event switch
	STY $80			; 98EF	$84 $80
	LDA $A400,Y		; 98F1	$B9 $00 $A4
	STA $81			; 98F4	$85 $81
	LDA $A500,Y		; 98F6	$B9 $00 $A5
	TAY			; 98F9	$A8
	LDA $81			; 98FA	$A5 $81
	EOR #$FF		; 98FC	$49 $FF
	AND $6040,Y		; 98FE	$39 $40 $60
	STA $6040,Y		; 9901	$99 $40 $60
	LDY $80    		; 9904	$A4 $80
	RTS			; 9906	$60
; End of


; Name	:
; Y	: npc id
; Marks	: hide npc
	JSR $98EF		; 9907	$20 $EF $98	toggle event switch
	LDY #$00		; 990A	$A0 $00
L3990C:
	LDA $80			; 990C	$A5 $80
	CMP $7500,Y		; 990E	$D9 $00 $75
	BEQ L3991D		; 9911	$F0 $0A
	TYA			; 9913	$98
	CLC			; 9914	$18
	ADC #$10		; 9915	$69 $10
	TAY			; 9917	$A8
	CMP #$F0		; 9918	$C9 $F0
	BCC L3990C		; 991A	$90 $F0
	RTS			; 991C	$60
L3991D:
	LDA #$00		; 991D	$A9 $00
	STA $7500,Y		; 991F	$99 $00 $75
	RTS			; 9922	$60
; End of

;; [$9923 - data ?? code pointer
; npc script jump table (by npc id)
.byte $A3,$9A,$A4,$9A,$55,$9B,$59,$9B,$76,$9B,$8B,$9B,$30
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
.byte $A3,$F1,$A3

; npc $00: no effect
	RTS			; 9AA3	$60
; End of

; npc $01: hilda (altair throne room)
	LDY #$50		; 9AA4	$A0 $50
	JSR $989E		; 9AA6	$20 $9E $98	check event switch
	BNE L39AC1		; 9AA9	$D0 $16
	LDA $7B01		; 9AAB	$AD $01 $7B	$02: "Hilda:The Wild Rose is the insignia..."
	STA $7B21		; 9AAE	$8D $21 $7B	response to keyword 1 (Wild Rose)
	LDA $7B02		; 9AB1	$AD $02 $7B	$03: "Hilda:That Ring…It's Scott's!Is..."
	STA $7B31		; 9AB4	$8D $31 $7B	response to key item 1 (Ring)
	LDA $7B14		; 9AB7	$AD $14 $7B	$04: "We lost Fynn because the Empire..."
	STA $7B22		; 9ABA	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B00		; 9ABD	$AD $00 $7B	$01: "Hilda:The password is (Wild Rose)."
	RTS			; 9AC0	$60
L39AC1:
	LDY #$08		; 9AC1	$A0 $08
	JSR $989E		; 9AC3	$20 $9E $98	check event switch
	BEQ L39ACC		; 9AC6	$F0 $04
	LDA $7B03		; 9AC8	$AD $03 $7B	$05: "Minwu is a virtuous white wizard..."
	RTS			; 9ACB	$60
L39ACC:
	LDY #$C3		; 9ACC	$A0 $C3
	JSR $989E		; 9ACE	$20 $9E $98	check event switch
	BNE L39AEF		; 9AD1	$D0 $1C
	LDA $7B05		; 9AD3	$AD $05 $7B	$12: "Please find that Mythril as soon as possible."
	STA $7B22		; 9AD6	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B06		; 9AD9	$AD $06 $7B	$07: "The Empire is using the people of Bafsk..."
	STA $7B23		; 9ADC	$8D $23 $7B	response to keyword 3 (mythril)
	LDA $7B07		; 9ADF	$AD $07 $7B	$09: "You've found the Mythril! Please hand..."
	STA $7B34		; 9AE2	$8D $34 $7B	response to key item 4 (mythril)
	LDA $7B08		; 9AE5	$AD $08 $7B	$08: "A man named Cid,former leader of Fynn's ..."
	STA $7B25		; 9AE8	$8D $25 $7B	response to keyword 5 (Airship)
	LDA $7B04		; 9AEB	$AD $04 $7B	$06: "The Empire also suffered heavy losses..."
	RTS			; 9AEE	$60
L39AEF:
	LDY #$51		; 9AEF	$A0 $51
	JSR $989E		; 9AF1	$20 $9E $98	check event switch
	BNE L39B00		; 9AF4	$D0 $0A
	LDA $7B0A		; 9AF6	$AD $0A $7B	$0B: "We have a man in Bafsk. He's found a way..."
	STA $7B23		; 9AF9	$8D $23 $7B	response to keyword 3 (Dreadnought)
	LDA $7B09		; 9AFC	$AD $09 $7B	$0A: "The Dreadnought's construction is..."
	RTS			; 9AFF	$60
L39B00:
	LDY #$09		; 9B00	$A0 $09
	JSR $989E		; 9B02	$20 $9E $98	check event switch
	BNE L39B1E		; 9B05	$D0 $17
	JSR $F308		; 9B07	$20 $08 $F3	check if any main characters are alive
	BCC L39B10		; 9B0A	$90 $04
	LDA $7B0B		; 9B0C	$AD $0B $7B	$FD: "Firion,Maria,or Guy must be alive to advance."
	RTS			; 9B0F	$60
L39B10:
	LDA #$80		; 9B10	$A9 $80
	STA $62F5		; 9B12	$8D $F5 $62	
	LDY #$09		; 9B15	$A0 $09
	JSR $98C7		; 9B17	$20 $C7 $98	set event switch and show npc
	LDA $7B0C		; 9B1A	$AD $0C $7B	$0C: "Hilda:Many were hurt by the Dreadnought's attack."
	RTS			; 9B1D	$60
L39B1E:
	LDY #$13		; 9B1E	$A0 $13
	JSR $989E		; 9B20	$20 $9E $98	check event switch
	BEQ L39B3B		; 9B23	$F0 $16
	LDA $7B0E		; 9B25	$AD $0E $7B	$0E
	STA $7B23		; 9B28	$8D $23 $7B	
	LDA $7B0F		; 9B2B	$AD $0F $7B	$0F
	STA $7B26		; 9B2E	$8D $26 $7B	
	LDA $7B10		; 9B31	$AD $10 $7B	$10
	STA $7B27		; 9B34	$8D $27 $7B	
	LDA $7B0D		; 9B37	$AD $0D $7B	$0D
	RTS			; 9B3A	$60
L39B3B:
	LDY #$2B		; 9B3B	$A0 $2B
	JSR $989E		; 9B3D	$20 $9E $98	check event switch
	BEQ L39B46		; 9B40	$F0 $04
	LDA $7B11		; 9B42	$AD $11 $7B	$11
	RTS			; 9B45	$60
L39B46:
	LDY #$0C		; 9B46	$A0 $0C
	JSR $989E		; 9B48	$20 $9E $98	check event switch
	BEQ L39B51		; 9B4B	$F0 $04
	LDA $7B12		; 9B4D	$AD $12 $7B	$13
	RTS			; 9B50	$60
L39B51:
	LDA $7B13		; 9B51	$AD $13 $7B	$14
	RTS			; 9B54	$60
; End of

; generic npc (dialogue)
	LDA $7B00		; 9B55	$AD $00 $7B
	RTS			; 9B58	$60
; End of

; npc $03: hilda (altair hilda's room)
	LDY #$25		; 9B59	$A0 $25
	JSR $989E		; 9B5B	$20 $9E $98	check event switch
	BEQ L39B64		; 9B5E	$F0 $04
	LDA $7B00		; 9B60	$AD $00 $7B
	RTS			; 9B63	$60
L39B64:
	JSR $F308		; 9B64	$20 $08 $F3	check if any main characters are alive
	BCC L39B6D		; 9B67	$90 $04
	LDA $7B03		; 9B69	$AD $03 $7B
	RTS			; 9B6C	$60
L39B6D:
	LDA $7B02		; 9B6D	$AD $02 $7B
	STA $6C			; 9B70	$85 $6C
	LDA $7B01		; 9B72	$AD $01 $7B
	RTS			; 9B75	$60
; End of

; npc $04: hilda (camp)
	LDY #$17		; 9B76	$A0 $17
	JSR $989E		; 9B78	$20 $9E $98	check event switch
	BEQ L39B87		; 9B7B	$F0 $0A
	LDA $7B01		; 9B7D	$AD $01 $7B
	STA $7B21		; 9B80	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B00		; 9B83	$AD $00 $7B
	RTS			; 9B86	$60
L39B87:
	LDA $7B02		; 9B87	$AD $02 $7B
	RTS			; 9B8A	$60
; End of

; npc $05: hilda (fynn throne room)
	LDA $601B		; 9B8B	$AD $1B $60
	AND #$08		; 9B8E	$29 $08
	BNE L39BBA		; 9B90	$D0 $28		branch if player has white mask
	LDA $7B01		; 9B92	$AD $01 $7B
	STA $7B28		; 9B95	$8D $28 $7B
	LDA $7B02		; 9B98	$AD $02 $7B
	STA $7B29		; 9B9B	$8D $29 $7B
	LDA $7B03		; 9B9E	$AD $03 $7B
	STA $7B2A		; 9BA1	$8D $2A $7B
	LDA $7B04		; 9BA4	$AD $04 $7B
	STA $7B2B		; 9BA7	$8D $2B $7B
	LDA $7B05		; 9BAA	$AD $05 $7B
	STA $7B2E		; 9BAD	$8D $2E $7B
	LDA $7B06		; 9BB0	$AD $06 $7B
	STA $7B2F		; 9BB3	$8D $2F $7B
	LDA $7B00		; 9BB6	$AD $00 $7B
	RTS			; 9BB9	$60
L39BBA:
	LDA $601B		; 9BBA	$AD $1B $60
	AND #$20		; 9BBD	$29 $20
	BNE L39BC5		; 9BBF	$D0 $04		branch if player has crystal rod
	LDA $7B07		; 9BC1	$AD $07 $7B
	RTS			; 9BC4	$60
L39BC5:
	LDY #$19		; 9BC5	$A0 $19
	JSR $989E		; 9BC7	$20 $9E $98	check event switch
	BEQ L39BD0		; 9BCA	$F0 $04
	LDA $7B08		; 9BCC	$AD $08 $7B
	RTS			; 9BCF	$60
L39BD0:
	LDY #$45		; 9BD0	$A0 $45
	JSR $989E		; 9BD2	$20 $9E $98	check event switch
	BEQ L39BE7		; 9BD5	$F0 $10
	LDA $7B0A		; 9BD7	$AD $0A $7B
	STA $7B2A		; 9BDA	$8D $2A $7B
	LDA $7B0B		; 9BDD	$AD $0B $7B
	STA $7B2B		; 9BE0	$8D $2B $7B
	LDA $7B09		; 9BE3	$AD $09 $7B
	RTS			; 9BE6	$60
L39BE7:
	LDY #$46		; 9BE7	$A0 $46
	JSR $989E		; 9BE9	$20 $9E $98	check event switch
	BEQ L39BFE		; 9BEC	$F0 $10
	LDA $7B0D		; 9BEE	$AD $0D $7B
	STA $7B2B		; 9BF1	$8D $2B $7B
	LDA $7B0E		; 9BF4	$AD $0E $7B
	STA $7B2C		; 9BF7	$8D $2C $7B
	LDA $7B0C		; 9BFA	$AD $0C $7B
	RTS			; 9BFD	$60
L39BFE:
	LDY #$29		; 9BFE	$A0 $29
	JSR $989E		; 9C00	$20 $9E $98	check event switch
	BEQ L39C15		; 9C03	$F0 $10
	LDA $7B10		; 9C05	$AD $10 $7B
	STA $7B2B		; 9C08	$8D $2B $7B
	LDA $7B11		; 9C0B	$AD $11 $7B
	STA $7B2C		; 9C0E	$8D $2C $7B
	LDA $7B0F		; 9C11	$AD $0F $7B
	RTS			; 9C14	$60
L39C15:
	LDY #$1D		; 9C15	$A0 $1D
	JSR $989E		; 9C17	$20 $9E $98	check event switch
	BEQ L39C26		; 9C1A	$F0 $0A
	LDA $7B13		; 9C1C	$AD $13 $7B
	STA $7B24		; 9C1F	$8D $24 $7B
	LDA $7B12		; 9C22	$AD $12 $7B
	RTS			; 9C25	$60
L39C26:
	LDA $7B15		; 9C26	$AD $15 $7B
	STA $7B2D		; 9C29	$8D $2D $7B
	LDA $7B14		; 9C2C	$AD $14 $7B
	RTS			; 9C2F	$60
; End of


; generic npc (battle)
	LDY $A0			; 9C30	$A4 $A0
	JSR $9907		; 9C32	$20 $07 $99	hide npc
	LDA $7B01		; 9C35	$AD $01 $7B	
	JSR $98E1		; 9C38	$20 $E1 $98	set battle id
	LDA $7B00		; 9C3B	$AD $00 $7B
	RTS			; 9C3E	$60
; End of

; npc $07: cid (poft)
	LDY #$51		; 9C3F	$A0 $51
	JSR $989E		; 9C41	$20 $9E $98	check event switch
	BNE L39C56		; 9C44	$D0 $10
	LDA $7B01		; 9C46	$AD $01 $7B
	STA $7B23		; 9C49	$8D $23 $7B
	LDA $7B02		; 9C4C	$AD $02 $7B
	STA $7B25		; 9C4F	$8D $25 $7B
	LDA $7B00		; 9C52	$AD $00 $7B
	RTS			; 9C55	$60
L39C56:
	LDY #$01		; 9C56	$A0 $01
	JSR $989E		; 9C58	$20 $9E $98	check event switch
	BEQ L39C73		; 9C5B	$F0 $16
	LDA $7B04		; 9C5D	$AD $04 $7B
	STA $7B23		; 9C60	$8D $23 $7B
	LDA $7B05		; 9C63	$AD $05 $7B
	STA $7B25		; 9C66	$8D $25 $7B
	LDA $7B06		; 9C69	$AD $06 $7B
	STA $7B27		; 9C6C	$8D $27 $7B
	LDA $7B03		; 9C6F	$AD $03 $7B
	RTS			; 9C72	$60
L39C73:
	LDY #$39		; 9C73	$A0 $39
	JSR $989E		; 9C75	$20 $9E $98	check event switch
	BEQ L39C7E		; 9C78	$F0 $04
	LDA $7B07		; 9C7A	$AD $07 $7B
	RTS			; 9C7D	$60
L39C7E:
	LDA $7B08		; 9C7E	$AD $08 $7B
	RTS			; 9C81	$60
; End of

; npc $08: minwu (altair throne room)
	LDY #$50		; 9C82	$A0 $50		$604A.0
	JSR $989E		; 9C84	$20 $9E $98	check event switch
	BNE L39C93		; 9C87	$D0 $0A
	LDA $7B01		; 9C89	$AD $01 $7B	$32: "Ah!You know the password..."
	STA $7B21		; 9C8C	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B00		; 9C8F	$AD $00 $7B	$31: "Minwu:Proceed to Fynn..."
	RTS			; 9C92	$60
L39C93:
	LDA #$02		; 9C93	$A9 $02		item $02: Canoe
	JSR $9873		; 9C95	$20 $73 $98	add item to inventory
	BCS L39CAE		; 9C98	$B0 $14		branch if inventory is full
	LDY #$08		; 9C9A	$A0 $08
	JSR $9907		; 9C9C	$20 $07 $99	hide npc
	LDA #$04		; 9C9F	$A9 $04		minwu
	STA $61			; 9CA1	$85 $61
	JSR $C018		; 9CA3	$20 $18 $C0	load guest character properties
	LDA #$4A		; 9CA6	$A9 $4A		play song $0A
	STA $E0			; 9CA8	$85 $E0
	LDA $7B03		; 9CAA	$AD $03 $7B	$33: "Minwu:Take my canoe and..."
	RTS			; 9CAD	$60
L39CAE:
	LDA $7B02		; 9CAE	$AD $02 $7B	$FC: "Can't hold any more."
	RTS			; 9CB1	$60
; End of

; npc $09: minwu (altair king's room)
	LDY #$01		; 9CB2	$A0 $01
	JSR $989E		; 9CB4	$20 $9E $98	check event switch
	BEQ L39CD5		; 9CB7	$F0 $1C
	LDA $7B01		; 9CB9	$AD $01 $7B
	STA $7B23		; 9CBC	$8D $23 $7B
	LDA $7B02		; 9CBF	$AD $02 $7B
	STA $7B25		; 9CC2	$8D $25 $7B
	LDA $7B03		; 9CC5	$AD $03 $7B
	STA $7B26		; 9CC8	$8D $26 $7B
	LDA $7B04		; 9CCB	$AD $04 $7B
	STA $7B27		; 9CCE	$8D $27 $7B
	LDA $7B00		; 9CD1	$AD $00 $7B
	RTS			; 9CD4	$60
L39CD5:
	LDA $7B06		; 9CD5	$AD $06 $7B
	STA $7B23		; 9CD8	$8D $23 $7B
	LDA $7B05		; 9CDB	$AD $05 $7B
	RTS			; 9CDE	$60
; End of

; npc $0A: minwu (sealed tower)
	LDA $7B01		; 9CDF	$AD $01 $7B
	STA $6C			; 9CE2	$85 $6C
	LDA $7B00		; 9CE4	$AD $00 $7B
	RTS			; 9CE7	$60
; End of

; npc $0B: gordon (altair exterior)
	LDY #$C3		; 9CE8	$A0 $C3
	JSR $989E		; 9CEA	$20 $9E $98	check event switch
	BNE L39D0B		; 9CED	$D0 $1C
	LDA $7B01		; 9CEF	$AD $01 $7B
	STA $7B21		; 9CF2	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B02		; 9CF5	$AD $02 $7B
	STA $7B22		; 9CF8	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B03		; 9CFB	$AD $03 $7B
	STA $7B23		; 9CFE	$8D $23 $7B
	LDA $7B05		; 9D01	$AD $05 $7B
	STA $7B31		; 9D04	$8D $31 $7B
	LDA $7B00		; 9D07	$AD $00 $7B
	RTS			; 9D0A	$60
L39D0B:
	LDA $7B06		; 9D0B	$AD $06 $7B
	STA $7B23		; 9D0E	$8D $23 $7B
	LDA $7B04		; 9D11	$AD $04 $7B
	RTS			; 9D14	$60
; End of

; npc $0C: gordon (kashuan keep)
	LDY #$0C		; 9D15	$A0 $0C
	JSR $9907		; 9D17	$20 $07 $99	hide npc
	LDA #$06		; 9D1A	$A9 $06		gordon
	STA $61			; 9D1C	$85 $61
	JSR $C018		; 9D1E	$20 $18 $C0	load guest character properties
	LDA #$4A		; 9D21	$A9 $4A		play song $0A
	STA $E0			; 9D23	$85 $E0
	LDA $7B00		; 9D25	$AD $00 $7B
	RTS			; 9D28	$60
; End of

; npc $0D: gordon (altair throne room)
	LDY #$25		; 9D29	$A0 $25
	JSR $989E		; 9D2B	$20 $9E $98	check event switch
	BEQ L39D4B		; 9D2E	$F0 $1B
	LDA $601B		; 9D30	$AD $1B $60
	AND #$04		; 9D33	$29 $04
	BNE L39D47		; 9D35	$D0 $10		branch if player has wyvern egg
	LDA $7B01		; 9D37	$AD $01 $7B
	STA $7B2A		; 9D3A	$8D $2A $7B
	LDA $7B02		; 9D3D	$AD $02 $7B
	STA $7B2B		; 9D40	$8D $2B $7B
	LDA $7B00		; 9D43	$AD $00 $7B
	RTS			; 9D46	$60
L39D47:
	LDA $7B03		; 9D47	$AD $03 $7B
	RTS			; 9D4A	$60
L39D4B:
	LDY #$03		; 9D4B	$A0 $03
	JSR $989E		; 9D4D	$20 $9E $98	check event switch
	BEQ L39D56		; 9D50	$F0 $04
	LDA $7B04		; 9D52	$AD $04 $7B
	RTS			; 9D55	$60
L39D56:
	LDA $7B06		; 9D56	$AD $06 $7B
	STA $7B2B		; 9D59	$8D $2B $7B
	LDA $7B05		; 9D5C	$AD $05 $7B
	RTS			; 9D5F	$60
; End of

; npc $0E: gordon (camp)
	LDA $7B00		; 9D60	$AD $00 $7B
	RTS			; 9D63	$60
; End of

; npc $0F: gordon (fynn throne room)
	LDA $601B		; 9D64	$AD $1B $60
	AND #$08		; 9D67	$29 $08
	BNE L39D81		; 9D69	$D0 $16		branch if player has white mask
	LDA $7B01		; 9D6B	$AD $01 $7B
	STA $7B28		; 9D6E	$8D $28 $7B
	LDA $7B02		; 9D71	$AD $02 $7B
	STA $7B29		; 9D74	$8D $29 $7B
	LDA $7B03		; 9D77	$AD $03 $7B
	STA $7B2F		; 9D7A	$8D $2F $7B
	LDA $7B00		; 9D7D	$AD $00 $7B
	RTS			; 9D80	$60
L39D81:
	LDY #$19		; 9D81	$A0 $19
	JSR $989E		; 9D83	$20 $9E $98	check event switch
	BEQ L39D8C		; 9D86	$F0 $04
	LDA $7B04		; 9D88	$AD $04 $7B
	RTS			; 9D8B	$60
L39D8C:
	LDY #$45		; 9D8C	$A0 $45
	JSR $989E		; 9D8E	$20 $9E $98	check event switch
	BEQ L39D97		; 9D91	$F0 $04
	LDA $7B05		; 9D93	$AD $05 $7B
	RTS			; 9D96	$60
L39D97:
	LDY #$46		; 9D97	$A0 $46
	JSR $989E		; 9D99	$20 $9E $98	check event switch
	BEQ L39DA8		; 9D9C	$F0 $0A
	LDA $7B07		; 9D9E	$AD $07 $7B
	STA $7B2C		; 9DA1	$8D $2C $7B
	LDA $7B06		; 9DA4	$AD $06 $7B
	RTS			; 9DA7	$60
L39DA8:
	LDY #$29		; 9DA8	$A0 $29
	JSR $989E		; 9DAA	$20 $9E $98	check event switch
	BEQ L39DB3		; 9DAD	$F0 $04
	LDA $7B08		; 9DAF	$AD $08 $7B
	RTS			; 9DB2	$60
L39DB3:
	LDY #$1D		; 9DB3	$A0 $1D
	JSR $989E		; 9DB5	$20 $9E $98	check event switch
	BEQ L39DC4		; 9DB8	$F0 $0A
	LDA $7B0A		; 9DBA	$AD $0A $7B
	STA $7B24		; 9DBD	$8D $24 $7B
	LDA $7B09		; 9DC0	$AD $09 $7B
	RTS			; 9DC3	$60
L39DC4:
	LDA $7B0C		; 9DC4	$AD $0C $7B
	STA $7B2D		; 9DC7	$8D $2D $7B
	LDA $7B0B		; 9DCA	$AD $0B $7B
	RTS			; 9DCD	$60
; End of

; npc $10: paul (altair)
	LDA $7B01		; 9DCE	$AD $01 $7B
	STA $7B21		; 9DD1	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B00		; 9DD4	$AD $00 $7B
	RTS			; 9DD7	$60
; End of

; npc $11: paul (semitt falls)
	LDY #$33		; 9DD8	$A0 $33
	JSR $9907		; 9DDA	$20 $07 $99	hide npc
	LDY #$33		; 9DDD	$A0 $33
	JSR $9907		; 9DDF	$20 $07 $99	hide npc
	LDY #$33		; 9DE2	$A0 $33
	JSR $9907		; 9DE4	$20 $07 $99	hide npc
	LDY #$33		; 9DE7	$A0 $33
	JSR $9907		; 9DE9	$20 $07 $99	hide npc
	LDY #$11		; 9DEC	$A0 $11
	JSR $9907		; 9DEE	$20 $07 $99	hide npc
	LDY #$21		; 9DF1	$A0 $21
	JSR $9907		; 9DF3	$20 $07 $99	hide npc
	LDY #$22		; 9DF6	$A0 $22
	JSR $98C7		; 9DF8	$20 $C7 $98	set event switch and show npc
	LDY #$84		; 9DFB	$A0 $84
	JSR $98B1		; 9DFD	$20 $B1 $98	set event switch
	LDY #$85		; 9E00	$A0 $85
	JSR $98B1		; 9E02	$20 $B1 $98	set event switch
	LDY #$86		; 9E05	$A0 $86
	JSR $98B1		; 9E07	$20 $B1 $98	set event switch
	LDY #$87		; 9E0A	$A0 $87
	JSR $98B1		; 9E0C	$20 $B1 $98	set event switch
	LDA $7B00		; 9E0F	$AD $00 $7B
	RTS			; 9E12	$60
; End of

; npc $12: paul (fynn)
	LDY #$41		; 9E13	$A0 $41
	JSR $989E		; 9E15	$20 $9E $98	check event switch
	BEQ L39E24		; 9E18	$F0 $0A
	LDA $7B07		; 9E1A	$AD $07 $7B	
	STA $7B2F		; 9E1D	$8D $2F $7B	
	LDA $7B00		; 9E20	$AD $00 $7B	
	RTS			; 9E23	$60
L39E24:
	LDY #$29		; 9E24	$A0 $29
	JSR $989E		; 9E26	$20 $9E $98	check event switch
	BEQ L39E35		; 9E29	$F0 $0A
	LDA $7B02		; 9E2B	$AD $02 $7B	
	STA $7B2C		; 9E2E	$8D $2C $7B	
	LDA $7B01		; 9E31	$AD $01 $7B	
	RTS			; 9E34	$60
L39E35:
	LDY #$26		; 9E35	$A0 $26
	JSR $989E		; 9E37	$20 $9E $98	check event switch
	BEQ L39E40		; 9E3A	$F0 $04
	LDA $7B03		; 9E3C	$AD $03 $7B	
	RTS			; 9E3F	$60
L39E40:
	LDY #$1D		; 9E40	$A0 $1D
	JSR $989E		; 9E42	$20 $9E $98	check event switch
	BEQ L39E51		; 9E45	$F0 $0A
	LDA $7B05		; 9E47	$AD $05 $7B
	STA $7B24		; 9E4A	$8D $24 $7B
	LDA $7B04		; 9E4D	$AD $04 $7B
	RTS			; 9E50	$60
L39E51:
	LDA $7B06		; 9E51	$AD $06 $7B
	RTS			; 9E54	$60
; End of

; npc $13: josef
	LDY #$21		; 9E55	$A0 $21
	JSR $989E		; 9E57	$20 $9E $98	check event switch
	BEQ L39E78		; 9E5A	$F0 $1C
	LDA $7B01		; 9E5C	$AD $01 $7B
	STA $7B21		; 9E5F	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B02		; 9E62	$AD $02 $7B
	STA $7B22		; 9E65	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B03		; 9E68	$AD $03 $7B
	STA $7B23		; 9E6B	$8D $23 $7B
	LDA $7B04		; 9E6E	$AD $04 $7B
	STA $7B25		; 9E71	$8D $25 $7B
	LDA $7B00		; 9E74	$AD $00 $7B
	RTS			; 9E77	$60
L39E78:
	LDA $7B06		; 9E78	$AD $06 $7B
	STA $7B22		; 9E7B	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B07		; 9E7E	$AD $07 $7B
	STA $7B23		; 9E81	$8D $23 $7B
	LDA $7B08		; 9E84	$AD $08 $7B
	STA $7B25		; 9E87	$8D $25 $7B
	LDA $7B09		; 9E8A	$AD $09 $7B
	STA $7B34		; 9E8D	$8D $34 $7B	response to key item 4 (mythril)
	LDA $7B0A		; 9E90	$AD $0A $7B
	STA $7B26		; 9E93	$8D $26 $7B
	LDA $7B05		; 9E96	$AD $05 $7B
	RTS			; 9E99	$60
; End of

; npc $14: 
	LDY #$14		; 9E9A	$A0 $14
	JSR $9907		; 9E9C	$20 $07 $99	hide npc
	LDA #$01		; 9E9F	$A9 $01
	STA $6000		; 9EA1	$8D $00 $60
	LDA $7B00		; 9EA4	$AD $00 $7B
	RTS			; 9EA7	$60
; End of

; npc $15: 
	LDA $7B01		; 9EA8	$AD $01 $7B
	RTS			; 9EAB	$60
; End of

; unused (was leila, altair ???)
	LDY #$52		; 9EAC	$A0 $52
	JSR $989E		; 9EAE	$20 $9E $98	check event switch
	BEQ L39EC2		; 9EB1	$F0 $0F
	LDY #$52		; 9EB3	$A0 $52
	JSR $98EF		; 9EB5	$20 $EF $98
	LDA $7B01		; 9EB8	$AD $01 $7B
	JSR $98E1		; 9EBB	$20 $E1 $98	set battle id
	LDA $7B00		; 9EBE	$AD $00 $7B
	RTS			; 9EC1	$60
L39EC2:
	LDY #$15		; 9EC2	$A0 $15
	JSR $9907		; 9EC4	$20 $07 $99	hide npc
	JSR $97FF		; 9EC7	$20 $FF $97
	LDA #$07		; 9ECA	$A9 $07		leila
	STA $61			; 9ECC	$85 $61
	JSR $C018		; 9ECE	$20 $18 $C0	load guest character properties
	LDA #$4A		; 9ED1	$A9 $4A		play song $0A
	STA $E0			; 9ED3	$85 $E0
	LDA #$40		; 9ED5	$A9 $40
	STA $44			; 9ED7	$85 $44
	LDA $7B02		; 9ED9	$AD $02 $7B
	RTS			; 9EDC	$60
; End of

; npc $17: leila (fynn castle 1f)
	LDY #$17		; 9EDD	$A0 $17
	JSR $9907		; 9EDF	$20 $07 $99	hide npc
	JSR $9821		; 9EE2	$20 $21 $98
	LDA #$4A		; 9EE5	$A9 $4A		play song $0A
	STA $E0			; 9EE7	$85 $E0
	LDA $7B00		; 9EE9	$AD $00 $7B
	RTS			; 9EEC	$60
; End of

; npc $18: leila (fynn throne room)
	LDY #$45		; 9EED	$A0 $45
	JSR $989E		; 9EEF	$20 $9E $98	check event switch
	BEQ L39EF8		; 9EF2	$F0 $04
	LDA $7B00		; 9EF4	$AD $00 $7B
	RTS			; 9EF7	$60
L39EF8:
	LDY #$29		; 9EF8	$A0 $29
	JSR $989E		; 9EFA	$20 $9E $98	check event switch
	BEQ L39F03		; 9EFD	$F0 $04
	LDA $7B01		; 9EFF	$AD $01 $7B
	RTS			; 9F02	$60
L39F03:
	LDY #$1D		; 9F03	$A0 $1D
	JSR $989E		; 9F05	$20 $9E $98	check event switch
	BEQ L39F14		; 9F08	$F0 $0A
	LDA $7B03		; 9F0A	$AD $03 $7B
	STA $7B24		; 9F0D	$8D $24 $7B
	LDA $7B02		; 9F10	$AD $02 $7B
	RTS			; 9F13	$60
L39F14:
	LDA $7B05		; 9F14	$AD $05 $7B
	STA $7B2D		; 9F17	$8D $2D $7B
	LDA $7B04		; 9F1A	$AD $04 $7B
	RTS			; 9F1D	$60
; End of

; npc $19: ricard (leviathan)
	LDA $7B01		; 9F1E	$AD $01 $7B
	STA $7B28		; 9F21	$8D $28 $7B
	LDA $7B02		; 9F24	$AD $02 $7B
	STA $7B29		; 9F27	$8D $29 $7B
	LDA $7B03		; 9F2A	$AD $03 $7B
	STA $7B2B		; 9F2D	$8D $2B $7B
	LDA $7B04		; 9F30	$AD $04 $7B
	STA $7B2A		; 9F33	$8D $2A $7B
	LDA $7B05		; 9F36	$AD $05 $7B
	STA $7B3D		; 9F39	$8D $3D $7B
	LDA $7B00		; 9F3C	$AD $00 $7B
	RTS			; 9F3F	$60
; End of

; npc $1A: dark knight (bafsk)
	LDA $7B00		; 9F40	$AD $00 $7B
	RTS			; 9F43	$60
; End of

; generic npc (do event)
L39F44:
	LDA $7B01		; 9F44	$AD $01 $7B
	STA $6C			; 9F47	$85 $6C
	LDA $7B00		; 9F49	$AD $00 $7B
	RTS			; 9F4C	$60
; End of

; npc $3E: 
	JSR $F308		; 9F4D	$20 $08 $F3	check if any main characters are alive
	BCC L39F44		; 9F50	$90 $F2
L39F52:
	LDA $7B02		; 9F52	$AD $02 $7B
	RTS			; 9F55	$60
; End of

; npc $1C: 
	LDA $7B00		; 9F56	$AD $00 $7B
	RTS			; 9F59	$60
; End of

; npc $1D: dark knight (palamecia)
	JSR $F308		; 9F5A	$20 $08 $F3	check if any main characters are alive
	BCS L39F52		; 9F5D	$B0 $F3
	JMP $9F44		; 9F5F	$4C $44 $9F
; End of

; hide current npc
	LDY $A0			; 9F62	$A4 $A0
	JSR $9907		; 9F64	$20 $07 $99	hide npc
	LDA $7B00		; 9F67	$AD $00 $7B
	RTS			; 9F6A	$60
; End of

; npc $20: king (altair)
	LDY #$50		; 9F6B	$A0 $50
	JSR $989E		; 9F6D	$20 $9E $98	check event switch
	BNE L39F76		; 9F70	$D0 $04
	LDA $7B00		; 9F72	$AD $00 $7B
	RTS			; 9F75	$60
L39F76:
	LDY #$09		; 9F76	$A0 $09
	JSR $989E		; 9F78	$20 $9E $98	check event switch
	BNE L39F93		; 9F7B	$D0 $16
	LDA $7B02		; 9F7D	$AD $02 $7B
	STA $7B21		; 9F80	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B03		; 9F83	$AD $03 $7B
	STA $7B22		; 9F86	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B04		; 9F89	$AD $04 $7B
	STA $7B23		; 9F8C	$8D $23 $7B
	LDA $7B01		; 9F8F	$AD $01 $7B
	RTS			; 9F92	$60
L39F93:
	LDY #$01		; 9F93	$A0 $01
	JSR $989E		; 9F95	$20 $9E $98	check event switch
	BEQ L39FB0		; 9F98	$F0 $16
	LDA $7B06		; 9F9A	$AD $06 $7B
	STA $7B25		; 9F9D	$8D $25 $7B
	LDA $7B07		; 9FA0	$AD $07 $7B
	STA $7B26		; 9FA3	$8D $26 $7B
	LDA $7B08		; 9FA6	$AD $08 $7B
	STA $7B27		; 9FA9	$8D $27 $7B
	LDA $7B05		; 9FAC	$AD $05 $7B
	RTS			; 9FAF	$60
L39FB0:
	LDA $7B09		; 9FB0	$AD $09 $7B
	RTS			; 9FB3	$60
; End of

; npc $22: nelly (salamand)
	LDY #$13		; 9FB4	$A0 $13
	JSR $989E		; 9FB6	$20 $9E $98	check event switch
	BEQ L39FBF		; 9FB9	$F0 $04
	LDA $7B00		; 9FBB	$AD $00 $7B
	RTS			; 9FBE	$60
L39FBF:
	LDY #$37		; 9FBF	$A0 $37
	JSR $989E		; 9FC1	$20 $9E $98	check event switch
	BNE L39FCA		; 9FC4	$D0 $04
	LDA $7B01		; 9FC6	$AD $01 $7B
	RTS			; 9FC9	$60
L39FCA:
	LDA $7B02		; 9FCA	$AD $02 $7B
	RTS			; 9FCD	$60
; End of

; npc $25: wyvern (deist)
	LDA #$02		; 9FCE	$A9 $02
	AND $601B		; 9FD0	$2D $1B $60
	BNE L39FE5		; 9FD3	$D0 $10
	LDA $7B01		; 9FD5	$AD $01 $7B
	STA $7B2A		; 9FD8	$8D $2A $7B
	LDA $7B02		; 9FDB	$AD $02 $7B
	STA $7B2B		; 9FDE	$8D $2B $7B
	LDA $7B00		; 9FE1	$AD $00 $7B
	RTS			; 9FE4	$60
L39FE5:
	LDA #$04		; 9FE5	$A9 $04
	AND $601B		; 9FE7	$2D $1B $60
	BEQ L39FF0		; 9FEA	$F0 $04
	LDA $7B07		; 9FEC	$AD $07 $7B
	RTS			; 9FEF	$60
L39FF0:
	JSR $9863		; 9FF0	$20 $63 $98	find first empty inventory slot
	BCC L39FF9		; 9FF3	$90 $04
	LDA $7B03		; 9FF5	$AD $03 $7B
	RTS			; 9FF8	$60
L39FF9:
	LDA $7B05		; 9FF9	$AD $05 $7B
	STA $7B2A		; 9FFC	$8D $2A $7B
	LDA $7B06		; 9FFF	$AD $06 $7B
	STA $7B2B		; A002	$8D $2B $7B
	LDA $7B04		; A005	$AD $04 $7B
	RTS			; A008	$60
; End of


; npc $26: cid (paul's house)
	LDA #$04		; A009	$A9 $04
	STA $6004		; A00B	$8D $04 $60
	LDA $7B01		; A00E	$AD $01 $7B
	STA $6C			; A011	$85 $6C
	LDA $7B00		; A013	$AD $00 $7B
	RTS			; A016	$60
; End of

; npc $27: cid (dreadnought)
	LDY #$1C		; A017	$A0 $1C
	JSR $98C7		; A019	$20 $C7 $98	set event switch and show npc
	LDY #$02		; A01C	$A0 $02
	JSR $9907		; A01E	$20 $07 $99	hide npc
	JMP $9F62		; A021	$4C $62 $9F	hide current npc
; End of

; npc $2B: goddess bell sign
	LDA #$06		; A024	$A9 $06
	JSR $9873		; A026	$20 $73 $98	add item to inventory
	BCC L3A02F		; A029	$90 $04
	LDA $7B00		; A02B	$AD $00 $7B
	RTS			; A02E	$60
L3A02F:
	LDY #$24		; A02F	$A0 $24
	JSR $98C7		; A031	$20 $C7 $98	set event switch and show npc
	LDY #$2B		; A034	$A0 $2B
	JSR $9907		; A036	$20 $07 $99	hide npc
	LDA #$47		; A039	$A9 $47		play song $07
	STA $E0			; A03B	$85 $E0
	LDA $7B01		; A03D	$AD $01 $7B
	RTS			; A040	$60
; End of

; npc $2E: fynn throne room secret passage
	LDA $7B01		; A041	$AD $01 $7B
	STA $7B2F		; A044	$8D $2F $7B
	LDA $7B00		; A047	$AD $00 $7B
	RTS			; A04A	$60
; End of

; npc $30: 
	LDA $7B01		; A04B	$AD $01 $7B
	STA $7B21		; A04E	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B00		; A051	$AD $00 $7B
	RTS			; A054	$60
; End of

; npc $31: scott
	JSR $9863		; A055	$20 $63 $98	find first empty inventory slot
	BCC L3A05E		; A058	$90 $04
	LDA $7B00		; A05A	$AD $00 $7B
	RTS      		; A05D	$60
L3A05E:
	LDA $7B02		; A05E	$AD $02 $7B
	STA $7B21		; A061	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B01		; A064	$AD $01 $7B
	RTS			; A067	$60
; End of

; npc $32: dreadnought guard
	LDA $7B01		; A068	$AD $01 $7B	$CC: "Welcome aboard."
	STA $7B33		; A06B	$8D $33 $7B	response to key item 3 (Pass)
	LDA $7B02		; A06E	$AD $02 $7B	$CD: "Rebel curs!"
	STA $7B21		; A071	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B00		; A074	$AD $00 $7B	$CB: "Guard:What do you want?"
	RTS			; A077	$60
; End of

; npc $33: 
	LDA $7B00		; A078	$AD $00 $7B	$E8: "Slave:Help!"
	RTS			; A07B	$60
; End of

; npc $34: tobul the blacksmith
	LDY #$C3		; A07C	$A0 $C3
	JSR $989E		; A07E	$20 $9E $98	check event switch
	BNE L3A099		; A081	$D0 $16
	LDA $7B01		; A083	$AD $01 $7B	$9F: "Or am I? I'm Tobul,the best blacksmith around!""
	STA $7B21		; A086	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B02		; A089	$AD $02 $7B	$A0: "If I had some Mythril,I could make finer equipment."
	STA $7B22		; A08C	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B03		; A08F	$AD $03 $7B	$A1: "That's Mythril!I'll start making new equipment!"
	STA $7B34		; A092	$8D $34 $7B	response to key item 4 (mythril)
	LDA $7B00		; A095	$AD $00 $7B	$9E: "Tobul:I'm just a batty old man…"
	RTS			; A098	$60
L3A099:
	LDA $7B04		; A099	$AD $04 $7B	$A2: "No time to talk. There's work to be done!"
	RTS			; A09C	$60
; End of

; npc $35: rebel spy (bafsk)
	LDY #$23		; A09D	$A0 $23
	JSR $989E		; A09F	$20 $9E $98	check event switch
	BNE L3A0B4		; A0A2	$D0 $10
	LDA $7B01		; A0A4	$AD $01 $7B	$C7: "Fools!If the Dark Knight sees ..."
	STA $7B21		; A0A7	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B02		; A0AA	$AD $02 $7B	$C7: "Fools!If the Dark Knight sees ..."
	STA $7B23		; A0AD	$8D $23 $7B	response to keyword 3 (dreadnought)
	LDA $7B00		; A0B0	$AD $00 $7B	$C7: "Fools!If the Dark Knight sees ..."
	RTS			; A0B3	$60
L3A0B4:
	LDA $7B04		; A0B4	$AD $04 $7B	$C9: "You're one of us! I had to keep ..."
	STA $7B21		; A0B7	$8D $21 $7B	response to keyword 1 (wild rose)
	LDA $7B05		; A0BA	$AD $05 $7B	$CA: "So you want to destroy the Dreadnought..."
	STA $7B23		; A0BD	$8D $23 $7B	response to keyword 3 (dreadnought)
	LDA $7B03		; A0C0	$AD $03 $7B	$C8: "We can goof off more with lazy Borghen ..."
	RTS			; A0C3	$60
; End of

; npc $36: 
	LDY #$13		; A0C4	$A0 $13
	JSR $989E		; A0C6	$20 $9E $98	check event switch
	BEQ L3A0CF		; A0C9	$F0 $04
	LDA $7B00		; A0CB	$AD $00 $7B
	RTS      		; A0CE	$60
L3A0CF:
	LDY #$36 		; A0CF	$A0 $36
	JSR $9907		; A0D1	$20 $07 $99	hide npc
	LDA $7B01		; A0D4	$AD $01 $7B
	RTS			; A0D7	$60
; End of

; npc $38: sunfire holder
	JSR $9863		; A0D8	$20 $63 $98	find first empty inventory slot
	BCC L3A0E1		; A0DB	$90 $04
	LDA $7B00		; A0DD	$AD $00 $7B
	RTS			; A0E0	$60
L3A0E1:
	LDA $7B02		; A0E1	$AD $02 $7B
	STA $7B37		; A0E4	$8D $37 $7B
	LDA $7B01		; A0E7	$AD $01 $7B
	RTS			; A0EA	$60
; End of

; npc $39: 
	LDY #$02		; A0EB	$A0 $02
	JSR $989E		; A0ED	$20 $9E $98	check event switch
	BEQ L3A0F6		; A0F0	$F0 $04
	LDA $7B00		; A0F2	$AD $00 $7B
	RTS			; A0F5	$60
L3A0F6:
	LDA $7B02		; A0F6	$AD $02 $7B
	STA $7B38		; A0F9	$8D $38 $7B
	LDA $7B01		; A0FC	$AD $01 $7B
	RTS			; A0FF	$60
; End of

; npc $3A: 
	LDA #$09		; A100	$A9 $09
	JSR $9873		; A102	$20 $73 $98	add item to inventory
	BCC L3A10B		; A105	$90 $04
	LDA $7B00		; A107	$AD $00 $7B
	RTS      		; A10A	$60
L3A10B:
	LDY #$3A 		; A10B	$A0 $3A
	JSR $9907		; A10D	$20 $07 $99	hide npc
	LDA #$47 		; A110	$A9 $47		play song $07
	STA $E0  		; A112	$85 $E0
	LDA $7B01		; A114	$AD $01 $7B
	RTS			; A117	$60
; End of

; npc $3B: 
	LDY #$25		; A118	$A0 $25
	JSR $989E		; A11A	$20 $9E $98	check event switch
	BEQ L3A129		; A11D	$F0 $0A
	LDA $7B01		; A11F	$AD $01 $7B
	STA $7B3A		; A122	$8D $3A $7B
	LDA $7B00		; A125	$AD $00 $7B
	RTS			; A128	$60
L3A129:
	LDA $7B02		; A129	$AD $02 $7B
	RTS			; A12C	$60
; End of

; npc $3C,$5F: dreadnought captains, imperial guards (fynn)
	LDA $7B01		; A12D	$AD $01 $7B
	JSR $98E1		; A130	$20 $E1 $98	set battle id
	LDA $7B00		; A133	$AD $00 $7B
	RTS			; A136	$60
; End of

; npc $3F: gottos
	LDY #$3F		; A137	$A0 $3F
	JSR $9907		; A139	$20 $07 $99	hide npc
	LDA $6012		; A13C	$AD $12 $60
	EOR #$11		; A13F	$49 $11
	STA $6012		; A141	$8D $12 $60
	LDY #$5F		; A144	$A0 $5F
	JSR $98EF		; A146	$20 $EF $98
	LDY #$05		; A149	$A0 $05
	JSR $98C7		; A14B	$20 $C7 $98	set event switch and show npc
	LDY #$0F		; A14E	$A0 $0F
	JSR $98C7		; A150	$20 $C7 $98	set event switch and show npc
	LDY #$12		; A153	$A0 $12
	JSR $98B1		; A155	$20 $B1 $98	set event switch
	LDY #$92		; A158	$A0 $92
	JSR $98C7		; A15A	$20 $C7 $98	set event switch and show npc
	LDY #$93		; A15D	$A0 $93
	JSR $98C7		; A15F	$20 $C7 $98	set event switch and show npc
	LDY #$94		; A162	$A0 $94
	JSR $98C7		; A164	$20 $C7 $98	set event switch and show npc
	LDY #$95		; A167	$A0 $95
	JSR $98C7		; A169	$20 $C7 $98	set event switch and show npc
	LDA $6052		; A16C	$AD $52 $60
	ORA #$C0		; A16F	$09 $C0
	STA $6052		; A171	$8D $52 $60
	LDA #$FF		; A174	$A9 $FF
	STA $6053		; A176	$8D $53 $60
	STA $6054		; A179	$8D $54 $60
	LDA $6055		; A17C	$AD $55 $60
	ORA #$03		; A17F	$09 $03
	STA $6055		; A181	$8D $55 $60
	LDA $605A		; A184	$AD $5A $60
	ORA #$0E		; A187	$09 $0E
	STA $605A		; A189	$8D $5A $60
	LDA $7B01		; A18C	$AD $01 $7B
	STA $6C			; A18F	$85 $6C
	LDA $7B00		; A191	$AD $00 $7B
	RTS			; A194	$60
; End of

; npc $40: doppelganger
	LDY #$59		; A195	$A0 59
	JSR $989E		; A197	$20 9E 98	check event switch
	BEQ L3A1A5		; A19A	$F0 09
	LDA $7B01		; A19C	$AD 01 7B
	STA $6C			; A19F	$85 6C
	LDA $7B00		; A1A1	$AD 00 7B
	RTS			; A1A4	$60
L3A1A5:
	LDA $7B03		; A1A5	$AD 03 7B
	STA $7B3C		; A1A8	$8D 3C 7B
	LDA $7B02		; A1AB	$AD 02 7B
	RTS			; A1AE	$60
; End of

; npc $41: mysidian orb 1
	LDA #$10		; A1AF	$A9 $10
	BNE L3A1BD		; A1B1	$D0 $0A
; npc $42: mysidian orb 2
	LDA #$11		; A1B3	$A9 $11
	BNE L3A1BD		; A1B5	$D0 $06
; npc $43: mysidian orb 3
	LDA #$14		; A1B7	$A9 $14
	BNE L3A1BD		; A1B9	$D0 $02
; npc $44: mysidian orb 4
	LDA #$13		; A1BB	$A9 $13    
L3A1BD:
	STA $80			; A1BD	$85 $80
	LDA $F0			; A1BF	$A5 $F0
	AND #$C0		; A1C1	$29 $C0
	ORA $80			; A1C3	$05 $80
	TAX			; A1C5	$AA
	LDA $6100,X		; A1C6	$BD $00 $61
	CLC			; A1C9	$18
	ADC #$0A		; A1CA	$69 $0A
	CMP #$64		; A1CC	$C9 $64
	BCC L3A1D2		; A1CE	$90 $02
	LDA #$63		; A1D0	$A9 $63
L3A1D2:
	STA $6100,X		; A1D2	$9D $00 $61
	LDA $6110,X		; A1D5	$BD $10 $61
	CLC			; A1D8	$18
	ADC #$0A		; A1D9	$69 $0A
	CMP #$64		; A1DB	$C9 $64
	BCC L3A1E1		; A1DD	$90 $02
	LDA #$63		; A1DF	$A9 $63
L3A1E1:
	STA $6110,X		; A1E1	$9D $10 $61
	LDY $A0			; A1E4	$A4 $A0
	JSR $9907		; A1E6	$20 $07 $99	hide npc
	LDA $7B00		; A1E9	$AD $00 $7B
	RTS			; A1EC	$60
; End of

; npc $45: mysidian orb 5
	LDA #$BF		; A1ED	$A9 $BF
	JSR $9873		; A1EF	$20 $73 $98	add item to inventory
	BCC L3A1F8		; A1F2	$90 $04
	LDA $7B00		; A1F4	$AD $00 $7B
	RTS			; A1F7	$60
L3A1F8:
	LDA $7B02		; A1F8	$AD $02 $7B
	STA $6C			; A1FB	$85 $6C
	LDA $7B01		; A1FD	$AD $01 $7B
	RTS			; A200	$60
; End of


; npc $46: fynn castle mirror
	LDY #$45		; A201	$A0 $45
	JSR $989E		; A203	$20 $9E $98	check event switch
	BEQ L3A212		; A206	$F0 $0A
	LDA $7B01		; A208	$AD $01 $7B
	STA $7B39		; A20B	$8D $39 $7B
	LDA $7B00		; A20E	$AD $00 $7B
	RTS			; A211	$60
L3A212:
	JSR $9863		; A212	$20 $63 $98	find first empty inventory slot
	BCC L3A21B		; A215	$90 $04
	LDA $7B02		; A217	$AD $02 $7B
	RTS			; A21A	$60
L3A21B:
	LDA $7B04		; A21B	$AD $04 $7B
	STA $7B39		; A21E	$8D $39 $7B
	LDA $7B03		; A221	$AD $03 $7B
	RTS			; A224	$60
; End of

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

; npc $4E: mysidia bookshelf
	LDA $7B01		; A23A	$AD $01 $7B
	STA $7B22		; A23D	$8D $22 $7B	response to keyword 2 (mythril)
	LDA $7B02		; A240	$AD $02 $7B
	STA $7B24		; A243	$8D $24 $7B
	LDA $7B03		; A246	$AD $03 $7B
	STA $7B25		; A249	$8D $25 $7B
	LDA $7B04		; A24C	$AD $04 $7B
	STA $7B26		; A24F	$8D $26 $7B
	LDA $7B05		; A252	$AD $05 $7B
	STA $7B27		; A255	$8D $27 $7B
	LDA $7B06		; A258	$AD $06 $7B
	STA $7B28		; A25B	$8D $28 $7B
	LDA $7B07		; A25E	$AD $07 $7B
	STA $7B29		; A261	$8D $29 $7B
	LDA $7B08		; A264	$AD $08 $7B
	STA $7B2A		; A267	$8D $2A $7B
	LDA $7B09		; A26A	$AD $09 $7B
	STA $7B2B		; A26D	$8D $2B $7B
	LDA $7B0A		; A270	$AD $0A $7B
	STA $7B2E		; A273	$8D $2E $7B
	LDA $7B0B		; A276	$AD $0B $7B
	STA $7B2D		; A279	$8D $2D $7B
	LDA $7B00		; A27C	$AD $00 $7B
	RTS			; A27F	$60
; End of

; npc $54: kashuan keep door
	LDA $7B01		; A280	$AD $01 $7B
	STA $7B36		; A283	$8D $36 $7B
	LDA $7B00		; A286	$AD $00 $7B
	RTS			; A289	$60
; End of

; npc $55: deist npc 1
	LDY #$56		; A28A	$A0 $56
	JSR $98C7		; A28C	$20 $C7 $98	set event switch and show npc
	JMP $9F62		; A28F	$4C $62 $9F	hide current npc
; End of

; npc $56: 
	LDY #$57		; A292	$A0 $57
	JSR $98C7		; A294	$20 $C7 $98	set event switch and show npc
	LDY #$58		; A297	$A0 $58
	JSR $98C7		; A299	$20 $C7 $98	set event switch and show npc
	JMP $9F62		; A29C	$4C $62 $9F	hide current npc
; End of

; npc $57,$58: dragoon child/mother (deist 2F)
	LDA $601B		; A29F	$AD $1B $60
	AND #$02		; A2A2	$29 $02
	BNE L3A2B6		; A2A4	$D0 $10
	LDA $7B01		; A2A6	$AD $01 $7B
	STA $7B2A		; A2A9	$8D $2A $7B
	LDA $7B02		; A2AC	$AD $02 $7B
	STA $7B2B		; A2AF	$8D $2B $7B
	LDA $7B00		; A2B2	$AD $00 $7B
	RTS			; A2B5	$60
L3A2B6:
	LDY #$25		; A2B6	$A0 $25
	JSR $989E		; A2B8	$20 $9E $98	check event switch
	BEQ L3A2C1		; A2BB	$F0 $04
	LDA $7B03		; A2BD	$AD $03 $7B
	RTS			; A2C0	$60
L3A2C1:
	LDY #$19		; A2C1	$A0 $19
	JSR $989E		; A2C3	$20 $9E $98	check event switch
	BEQ L3A2CC		; A2C6	$F0 $04
	LDA $7B04		; A2C8	$AD $04 $7B
	RTS			; A2CB	$60
L3A2CC:
	LDY #$1D		; A2CC	$A0 $1D
	JSR $989E		; A2CE	$20 $9E $98	check event switch
	BEQ L3A2D7		; A2D1	$F0 $04
	LDA $7B05		; A2D3	$AD $05 $7B
	RTS			; A2D6	$60
L3A2D7:
	LDA $A0			; A2D7	$A5 $A0
	CMP #$58		; A2D9	$C9 $58
	BEQ L3A2E1		; A2DB	$F0 $04
	LDA $7B06		; A2DD	$AD $06 $7B
	RTS			; A2E0	$60
L3A2E1:
	JSR $9863		; A2E1	$20 $63 $98	find first empty inventory slot
	BCC L3A2EA		; A2E4	$90 $04
	LDA $7B06		; A2E6	$AD $06 $7B
	RTS			; A2E9	$60
L3A2EA:
	LDA $7B08		; A2EA	$AD $08 $7B
	STA $7B2A		; A2ED	$8D $2A $7B
	LDA $7B07		; A2F0	$AD $07 $7B
	RTS			; A2F3	$60
; End of

; npc $59: 
	LDA $7B01		; A2F4	$AD $01 $7B
	STA $7B3B		; A2F7	$8D $3B $7B
	LDA $7B00		; A2FA	$AD $00 $7B
	RTS			; A2FD	$60
; End of

; npc $5E: 
	LDA $7B01		; A2FE	$AD $01 $7B
	STA $7B26		; A301	$8D $26 $7B
	LDA $7B00		; A304	$AD $00 $7B
	RTS			; A307	$60
; End of

; ret	: A = text ID
	LDY #$50		; A308	$A0 $50
	JSR $989E		; A30A	$20 $9E $98	check event switch
	BNE L3A313		; A30D	$D0 $04
	LDA $7B00		; A30F	$AD $00 $7B	text ID
	RTS			; A312	$60
L3A313:
	LDY #$C3		; A313	$A0 $C3
	JSR $989E		; A315	$20 $9E $98	check event switch
	BNE L3A31E		; A318	$D0 $04
	LDA $7B01		; A31A	$AD $01 $7B	
	RTS			; A31D	$60
L3A31E:
	LDY #$51		; A31E	$A0 $51
	JSR $989E		; A320	$20 $9E $98	check event switch
	BNE L3A329		; A323	$D0 $04
	LDA $7B02		; A325	$AD $02 $7B	
	RTS			; A328	$60
L3A329:
	LDY #$38		; A329	$A0 $38
	JSR $989E		; A32B	$20 $9E $98	check event switch
	BEQ L3A334		; A32E	$F0 $04
	LDA $7B03		; A330	$AD $03 $7B	
	RTS			; A333	$60
L3A334:
	LDY #$39		; A334	$A0 $39
	JSR $989E		; A336	$20 $9E $98	check event switch
	BEQ L3A33F		; A339	$F0 $04
	LDA $7B04		; A33B	$AD $04 $7B	
	RTS			; A33E	$60
L3A33F:
	LDY #$20		; A33F	$A0 $20
	JSR $989E		; A341	$20 $9E $98	check event switch
	BEQ L3A34A		; A344	$F0 $04
	LDA $7B05		; A346	$AD $05 $7B	
	RTS			; A349	$60
L3A34A:
	LDY #$25		; A34A	$A0 $25
	JSR $989E		; A34C	$20 $9E $98	check event switch
	BEQ L3A355		; A34F	$F0 $04
	LDA $7B06		; A351	$AD $06 $7B	
	RTS			; A354	$60
L3A355:
	LDY #$03		; A355	$A0 $03
	JSR $989E		; A357	$20 $9E $98	check event switch
	BEQ L3A360		; A35A	$F0 $04
	LDA $7B07		; A35C	$AD $07 $7B	
	RTS			; A35F	$60
L3A360:
	LDY #$04		; A360	$A0 $04
	JSR $989E		; A362	$20 $9E $98	check event switch
	BNE L3A36B		; A365	$D0 $04
	LDA $7B08		; A367	$AD $08 $7B	
	RTS			; A36A	$60
L3A36B:
	LDY #$05		; A36B	$A0 $05
	JSR $989E		; A36D	$20 $9E $98	check event switch
	BNE L3A376		; A370	$D0 $04
	LDA $7B09		; A372	$AD $09 $7B
	RTS			; A375	$60
L3A376:
	LDA $7B0A		; A376	$AD $0A $7B
	RTS			; A379	$60
; End of

; npc $80,$81: 
	LDA $7B00		; A37A	$AD $00 $7B
	RTS			; A37D	$60
; End of

; npc $82-$87: salamand npcs
	LDY #$33		; A37E	$A0 $33
	JSR $989E		; A380	$20 $9E $98	check event switch
	BEQ L3A389		; A383	$F0 $04
	LDA $7B00		; A385	$AD $00 $7B
	RTS			; A388	$60
L3A389:
	LDY #$2B		; A389	$A0 $2B
	JSR $989E		; A38B	$20 $9E $98	check event switch
	BEQ L3A394		; A38E	$F0 $04
	LDA $7B01		; A390	$AD $01 $7B
	RTS			; A393	$60
L3A394:
	LDA $7B02		; A394	$AD $02 $7B
	RTS			; A397	$60
; End of

; npc $88-$8F: bafsk npcs
	LDY #$1A		; A398	$A0 $1A
	JSR $989E		; A39A	$20 $9E $98	check event switch
	BEQ L3A3A3		; A39D	$F0 $04
	LDA $7B00		; A39F	$AD $00 $7B
	RTS			; A3A2	$60
L3A3A3:
	LDY #$23		; A3A3	$A0 $23
	JSR $989E		; A3A5	$20 $9E $98	check event switch
	BEQ L3A3AE		; A3A8	$F0 $04
	LDA $7B01		; A3AA	$AD $01 $7B
	RTS			; A3AD	$60
L3A3AE:
	LDY #$51		; A3AE	$A0 $51
	JSR $989E		; A3B0	$20 $9E $98	check event switch
	BEQ L3A3C0		; A3B3	$F0 $0B
	LDY #$39		; A3B5	$A0 $39
	JSR $989E		; A3B7	$20 $9E $98	check event switch
	BEQ L3A3C0		; A3BA	$F0 $04
	LDA $7B02		; A3BC	$AD $02 $7B
	RTS			; A3BF	$60
L3A3C0:
	LDA $7B03		; A3C0	$AD $03 $7B
	RTS			; A3C3	$60
; End of

; generic npc (dialogue)
	LDA $7B00		; A3C4	$AD $00 $7B
	RTS			; A3C7	$60
; End of

; generic npc
	LDY #$41		; A3C8	$A0 $41
	JSR $989E		; A3CA	$20 $9E $98	check event switch
	BEQ L3A3D3		; A3CD	$F0 $04
	LDA $7B00		; A3CF	$AD $00 $7B
	RTS			; A3D2	$60
L3A3D3:
	LDY #$29		; A3D3	$A0 $29
	JSR $989E		; A3D5	$20 $9E $98	check event switch
	BEQ L3A3DE		; A3D8	$F0 $04
	LDA $7B01		; A3DA	$AD $01 $7B
	RTS			; A3DD	$60
L3A3DE:
	LDY #$1D		; A3DE	$A0 $1D
	JSR $989E		; A3E0	$20 $9E $98	check event switch
	BEQ L3A3E9		; A3E3	$F0 $04
	LDA $7B02		; A3E5	$AD $02 $7B
	RTS			; A3E8	$60
L3A3E9:
	LDA $7B03		; A3E9	$AD $03 $7B
	RTS			; A3EC	$60
; End of

; generic npc (dialogue)
	LDA $7B00		; A3ED	$AD $00 $7B
	RTS			; A3F0	$60
; End of

; generic npc
	LDY #$41		; A3F1	$A0 $41
	JSR $989E		; A3F3	$20 $9E $98	check event switch
	BEQ L3A3FC		; A3F6	$F0 $04
	LDA $7B00		; A3F8	$AD $00 $7B
	RTS			; A3FB	$60
L3A3FC:
	LDA $7B01		; A3FC	$AD $01 $7B
	RTS			; A3FF	$60
; End of

; bit mask for switches
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A400
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A408
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A410
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A418
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A420
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A428
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A430
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A438
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A440
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A448
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A450
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A458
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A460
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A468
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A470
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A478
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A480
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A488
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A490
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A498
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4A0
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4A8
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4B0
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4B8
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4C0
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4C8
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4D0
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4D8
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4E0
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4E8
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4F0
.byte $01,$02,$04,$08,$10,$20,$40,$80	; A4F8

; byte offset for switches
.byte $00,$00,$00,$00,$00,$00,$00,$00	; A500
.byte $01,$01,$01,$01,$01,$01,$01,$01	; A508
.byte $02,$02,$02,$02,$02,$02,$02,$02	; A510
.byte $03,$03,$03,$03,$03,$03,$03,$03	; A518
.byte $04,$04,$04,$04,$04,$04,$04,$04	; A520
.byte $05,$05,$05,$05,$05,$05,$05,$05	; A528
.byte $06,$06,$06,$06,$06,$06,$06,$06	; A530
.byte $07,$07,$07,$07,$07,$07,$07,$07	; A538
.byte $08,$08,$08,$08,$08,$08,$08,$08	; A540
.byte $09,$09,$09,$09,$09,$09,$09,$09	; A548
.byte $0A,$0A,$0A,$0A,$0A,$0A,$0A,$0A	; A550
.byte $0B,$0B,$0B,$0B,$0B,$0B,$0B,$0B	; A558
.byte $0C,$0C,$0C,$0C,$0C,$0C,$0C,$0C	; A560
.byte $0D,$0D,$0D,$0D,$0D,$0D,$0D,$0D	; A568
.byte $0E,$0E,$0E,$0E,$0E,$0E,$0E,$0E	; A570
.byte $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F	; A578
.byte $10,$10,$10,$10,$10,$10,$10,$10	; A580
.byte $11,$11,$11,$11,$11,$11,$11,$11	; A588
.byte $12,$12,$12,$12,$12,$12,$12,$12	; A590
.byte $13,$13,$13,$13,$13,$13,$13,$13	; A598
.byte $14,$14,$14,$14,$14,$14,$14,$14	; A5A0
.byte $15,$15,$15,$15,$15,$15,$15,$15	; A5A8
.byte $16,$16,$16,$16,$16,$16,$16,$16	; A5B0
.byte $17,$17,$17,$17,$17,$17,$17,$17	; A5B8
.byte $18,$18,$18,$18,$18,$18,$18,$18	; A5C0
.byte $19,$19,$19,$19,$19,$19,$19,$19	; A5C8
.byte $1A,$1A,$1A,$1A,$1A,$1A,$1A,$1A	; A5D0
.byte $1B,$1B,$1B,$1B,$1B,$1B,$1B,$1B	; A5D8
.byte $1C,$1C,$1C,$1C,$1C,$1C,$1C,$1C	; A5E0
.byte $1D,$1D,$1D,$1D,$1D,$1D,$1D,$1D	; A5E8
.byte $1E,$1E,$1E,$1E,$1E,$1E,$1E,$1E	; A5F0
.byte $1F,$1F,$1F,$1F,$1F,$1F,$1F,$1F	; A5F8



;----------------------------------------------------------------------



; Name	:
; Marks	: check if character can be cured
; clear carry if can be cured
	LDA $6101,X		; A600	$BD $01 $61
	AND #$C0		; A603	$29 $C0
	BNE L3A619		; A605	$D0 $12		can't cure if dead or stone
	LDA $6109,X		; A607	$BD $09 $61
	CMP $610B,X		; A60A	$DD $0B $61
	BCC L3A617		; A60D	$90 $08
	LDA $6108,X		; A60F	$BD $08 $61
	CMP $610A,X		; A612	$DD $0A $61
	BCS L3A619		; A615	$B0 $02		can't cure if at full hp
L3A617:
	CLC			; A617	$18
	RTS			; A618	$60
L3A619:
	SEC			; A619	$38
	RTS			; A61A	$60
; End of

; Name	:
; Marks	:
	LDA $79F0		; A61B	$AD $F0 $79
	CLC			; A61E	$18
	ADC #$04		; A61F	$69 $04
	CMP $79F1		; A621	$CD $F1 $79
	BCS L3A669		; A624	$B0 $43
	LDX $6E			; A626	$A6 $6E
	JSR $A600		; A628	$20 $00 $A6
	BCC L3A632		; A62B	$90 $05
	JSR $DE67		; A62D	$20 $67 $DE	play error sound effect
	SEC			; A630	$38
	RTS			; A631	$60
L3A632:
	LDA #$28		; A632	$A9 $28
	STA $87			; A634	$85 $87
	LDX $6E			; A636	$A6 $6E
	LDA $6235,X		; A638	$BD $35 $62
	BMI L3A667		; A63B	$30 $2A
	LDA $6101,X		; A63D	$BD $01 $61
	AND #$C0		; A640	$29 $C0
	BNE L3A667		; A642	$D0 $23
	LDA $87			; A644	$A5 $87
	JSR $A7A3		; A646	$20 $A3 $A7	A += (0..A)
	STA $80			; A649	$85 $80
	LDA $08			; A64B	$A5 $08
	ASL			; A64D	$0A
	ORA $0A			; A64E	$05 $0A
	TAX			; A650	$AA
	LDA $6210,X		; A651	$BD $10 $62
	CLC			; A654	$18
	ADC #$01		; A655	$69 $01
	STA $81			; A657	$85 $81
	JSR $A7B3		; A659	$20 $B3 $A7	multiply (8-bit)
	LDA $82			; A65C	$A5 $82
	STA $80			; A65E	$85 $80
	LDA $83			; A660	$A5 $83
	STA $81			; A662	$85 $81
	JSR $A91F		; A664	$20 $1F $A9
L3A667:
	CLC			; A667	$18
	RTS			; A668	$60
L3A669:
	LDX #$00		; A669	$A2 $00
	JSR $A600		; A66B	$20 $00 $A6
	BCC L3A68F		; A66E	$90 $1F
	LDX #$40		; A670	$A2 $40
	JSR $A600		; A672	$20 $00 $A6
	BCC L3A68F		; A675	$90 $18
	LDX #$80		; A677	$A2 $80
	JSR $A600		; A679	$20 $00 $A6
	BCC L3A68F		; A67C	$90 $11
	LDA $62F5		; A67E	$AD $F5 $62
	BMI L3A68A		; A681	$30 $07
	LDX #$C0 		; A683	$A2 $C0
	JSR $A600		; A685	$20 $00 $A6
	BCC L3A68F		; A688	$90 $05
L3A68A:
	JSR $DE67		; A68A	$20 $67 $DE	play error sound effect
	SEC			; A68D	$38
	RTS			; A68E	$60
L3A68F:
	LDA #$00		; A68F	$A9 $00
	STA $6E			; A691	$85 $6E
L3A693:
	LDA #$0A		; A693	$A9 $0A
	STA $87			; A695	$85 $87
	JSR $A636		; A697	$20 $36 $A6
	LDA $6E			; A69A	$A5 $6E
	CLC			; A69C	$18
	ADC #$40		; A69D	$69 $40
	STA $6E			; A69F	$85 $6E
	BNE L3A693		; A6A1	$D0 $F0
	CLC			; A6A3	$18
	RTS			; A6A4	$60
; End of

; Name	:
; Marks	:
	LDA #$80		; A6A5	$A9 $80
	STA $87			; A6A7	$85 $87
	LDA $79F0		; A6A9	$AD $F0 $79
	CLC			; A6AC	$18
	ADC #$04		; A6AD	$69 $04
	CMP $79F1		; A6AF	$CD $F1 $79
	BCS L3A6BC		; A6B2	$B0 $08
	JSR $A734		; A6B4	$20 $34 $A7
	JSR $A80E		; A6B7	$20 $0E $A8
	CLC			; A6BA	$18
	RTS			; A6BB	$60
L3A6BC:
	JSR $A75B		; A6BC	$20 $5B $A7
	LDA #$00		; A6BF	$A9 $00
	JSR $A6D0		; A6C1	$20 $D0 $A6
	LDA #$40		; A6C4	$A9 $40
	JSR $A6D0		; A6C6	$20 $D0 $A6
	LDA #$80		; A6C9	$A9 $80
	JSR $A6D0		; A6CB	$20 $D0 $A6
	LDA #$C0		; A6CE	$A9 $C0
	STA $6E			; A6D0	$85 $6E
	TAX			; A6D2	$AA
	LDA $6235,X		; A6D3	$BD $35 $62
	BMI L3A6F2		; A6D6	$30 $1A
	LDA $6101,X		; A6D8	$BD $01 $61
	AND $87			; A6DB	$25 $87
	BEQ L3A6F2		; A6DD	$F0 $13
	LDA $87			; A6DF	$A5 $87
	EOR #$FF		; A6E1	$49 $FF
	AND $6101,X		; A6E3	$3D $01 $61
	STA $6101,X		; A6E6	$9D $01 $61
	JSR $A80E		; A6E9	$20 $0E $A8
	LSR $6109,X		; A6EC	$5E $09 $61
	ROR $6108,X		; A6EF	$7E $08 $61
L3A6F2:
	CLC			; A6F2	$18
	RTS			; A6F3	$60
	LDA $08			; A6F4	$A5 $08
	ASL			; A6F6	$0A
	ORA $0A			; A6F7	$05 $0A
	TAX			; A6F9	$AA
	LDA $6210,X		; A6FA	$BD $10 $62
	TAX			; A6FD	$AA
	INX			; A6FE	$E8
	LDA $79F0		; A6FF	$AD $F0 $79
	CLC			; A702	$18
	ADC #$04		; A703	$69 $04
	CMP $79F1		; A705	$CD $F1 $79
	BCS L3A715		; A708	$B0 $0B
	INX			; A70A	$E8
	LDA $A722,X		; A70B	$BD $22 $A7
	STA $87			; A70E	$85 $87
	JSR $A734		; A710	$20 $34 $A7
	CLC			; A713	$18
	RTS			; A714	$60
L3A715:
	LDA $A722,X		; A715	$BD $22 $A7
	STA $87			; A718	$85 $87
	JSR $A75B		; A71A	$20 $5B $A7
	JSR $A77F		; A71D	$20 $7F $A7
	CLC			; A720	$18
	RTS			; A721	$60
; End of

; A722 - data block = ??
.byte $00,$02,$06,$0E		; A722
.byte $1E,$3E,$7E		; A726
.byte $FE,$FE,$FE		; A729
.byte $FE,$FE,$FE		; A72C
.byte $FE,$FE,$FE		; A72F
.byte $FE,$FE			; A732

; Name	:
; Marks	:
	LDX $6E			; A734	$A6 $6E
	LDA $6101,X		; A736	$BD $01 $61
	AND $87			; A739	$25 $87
	BNE L3A744		; A73B	$D0 $07
	JSR $DE67		; A73D	$20 $67 $DE	play error sound effect
	PLA			; A740	$68
	PLA			; A741	$68
	SEC			; A742	$38
	RTS			; A743	$60
L3A744:
	LDA $87			; A744	$A5 $87
	AND $6101,X		; A746	$3D $01 $61
	BPL L3A750		; A749	$10 $05
	LDA #$01		; A74B	$A9 $01
	STA $6108,X		; A74D	$9D $08 $61
L3A750:
	LDA $87			; A750	$A5 $87
	EOR #$FF		; A752	$49 $FF
	AND $6101,X		; A754	$3D $01 $61
	STA $6101,X		; A757	$9D $01 $61
	RTS			; A75A	$60
; End of

; Name	:
; Marks	:
	LDA $6101		; A75B	$AD $01 $61
	ORA $6141		; A75E	$0D $41 $61
	ORA $6181		; A761	$0D $81 $61
	LDX $62F5		; A764	$AE $F5 $62
	BMI L3A76C		; A767	$30 $03
	ORA $61C1		; A769	$0D $C1 $61
L3A76C:
	AND $87			; A76C	$25 $87
	BNE L3A776		; A76E	$D0 $06
	JSR $DE67		; A770	$20 $67 DEplay error sound effect
	PLA			; A773	$68
	PLA			; A774	$68
	SEC			; A775	$38
L3A776:
	RTS			; A776	$60
; End of

; Name	:
; Marks	:
L3A777:
	LDA $6101,X		; A777	$BD $01 $61
	AND $87			; A77A	$25 $87
	BNE L3A744		; A77C	$D0 $C6
	RTS			; A77E	$60
; End of

; Name	:
; Marks	:
	LDX #$00		; A77F	$A2 $00
	JSR $A777		; A781	$20 $77 $A7
	LDX #$40		; A784	$A2 $40
	JSR $A777		; A786	$20 $77 $A7
	LDX #$80		; A789	$A2 $80
	JSR $A777		; A78B	$20 $77 $A7
	LDX #$C0		; A78E	$A2 $C0
	LDA $62F5		; A790	$AD $F5 $62
	BPL L3A777		; A793	$10 $E2     
	RTS			; A795	$60
; End of

; Marks	: A = (0..A)
	STA $80			; A796	$85 $80
	JSR $C5AD		; A798	$20 $AD $C5	get random number
	STA $81			; A79B	$85 $81
	JSR $A7B3		; A79D	$20 $B3 $A7	multiply (8-bit)
	LDA $83			; A7A0	$A5 $83
	RTS			; A7A2	$60
; End of

; Name	:
; Marks	: A += (0..A)
	TAY 			; A7A3	$A8
	STA $80			; A7A4	$85 $80
	JSR $C5AD		; A7A6	$20 $AD $C5	get random number
	STA $81			; A7A9	$85 $81
	JSR $A7B3		; A7AB	$20 $B3 $A7	multiply (8-bit)
	TYA			; A7AE	$98
	CLC			; A7AF	$18
	ADC $83			; A7B0	$65 $83
	RTS			; A7B2	$60
; End of

; Name	:
; Marks	: multiply (8-bit)
; +$82 = $80 * $81
	LDA #$00		; A7B3	$A9 $00
	STA $82			; A7B5	$85 $82
	STA $83			; A7B7	$85 $83
	STA $84			; A7B9	$85 $84
L3A7BB:
	LSR $80			; A7BB	$46 $80
	BCC L3A7CC		; A7BD	$90 $0D
	LDA $82			; A7BF	$A5 $82
	CLC			; A7C1	$18
	ADC $81			; A7C2	$65 $81
	STA $82			; A7C4	$85 $82
	LDA $83			; A7C6	$A5 $83
	ADC $84			; A7C8	$65 $84
	STA $83			; A7CA	$85 $83
L3A7CC:
	ASL $81			; A7CC	$06 $81
	ROL $84			; A7CE	$26 $84
	LDA $80			; A7D0	$A5 $80
	BNE L3A7BB		; A7D2	$D0 $E7
	RTS			; A7D4	$60
; End of

; Name	:
; Marks	:
	LDA #$00		; A7D5	$A9 $00
	STA $82			; A7D7	$85 $82
	STA $83			; A7D9	$85 $83
	LDA #$00		; A7DB	$A9 $00
	LDX #$08		; A7DD	$A2 $08
L3A7DF:
	ASL $82			; A7DF	$06 $82
	ROL $83			; A7E1	$26 $83
	ASL $81			; A7E3	$06 $81
	ROL			; A7E5	$2A
	CMP $84			; A7E6	$C5 $84
	BCC L3A7F2		; A7E8	$90 $08
	SBC $84			; A7EA	$E5 $84
	INC $82			; A7EC	$E6 $82
	BNE L3A7F2		; A7EE	$D0 $02
	INC $83			; A7F0	$E6 $83
L3A7F2:
	DEX			; A7F2	$CA
	BNE L3A7DF		; A7F3	$D0 $EA
	LDX #$08		; A7F5	$A2 $08
L3A7F7:
	ASL $82			; A7F7	$06 $82
	ROL $83			; A7F9	$26 $83
	ASL $80			; A7FB	$06 $80
	ROL			; A7FD	$2A
	CMP $84			; A7FE	$C5 $84
	BCC L3A80A		; A800	$90 $08
	SBC $84			; A802	$E5 $84
	INC $82			; A804	$E6 $82
	BNE L3A80A		; A806	$D0 $02
	INC $83			; A808	$E6 $83
L3A80A:
	DEX			; A80A	$CA
	BNE L3A7F7		; A80B	$D0 $EA
	RTS			; A80D	$60
; End of

; Name	:
; Marks	:
	LDX $6E			; A80E	$A6 $6E
	LDA $08			; A810	$A5 $08
	ASL			; A812	$0A
	ORA $0A			; A813	$05 $0A
	TAY			; A815	$A8
	LDA $6210,Y		; A816	$B9 $10 $62
	EOR #$0F		; A819	$49 $0F
	CLC			; A81B	$18
	ADC #$01		; A81C	$69 $01
	STA $84			; A81E	$85 $84
	LDA $610A,X		; A820	$BD $0A $61
	STA $80			; A823	$85 $80
	LDA $610B,X		; A825	$BD $0B $61
	STA $81			; A828	$85 $81
	JSR $A7D5		; A82A	$20 $D5 $A7
	LDX $6E			; A82D	$A6 $6E
	LDA $82			; A82F	$A5 $82
	STA $6108,X		; A831	$9D $08 $61
	LDA $83			; A834	$A5 $83
	STA $6109,X		; A836	$9D $09 $61
	RTS			; A839	$60
; End of

; Name	:
; Marks	:
	LDX $6E			; A83A	$A6 $6E
	LDA $08			; A83C	$A5 $08
	ASL			; A83E	$0A
	ORA $0A			; A83F	$05 $0A
	TAY			; A841	$A8
	LDA $6210,Y		; A842	$B9 $10 $62
	EOR #$0F		; A845	$49 $0F
	CLC			; A847	$18
	ADC #$01		; A848	$69 $01
	STA $84			; A84A	$85 $84
	LDA $6108,X		; A84C	$BD $08 $61
	STA $80			; A84F	$85 $80
	LDA $6109,X		; A851	$BD $09 $61
	STA $81			; A854	$85 $81
	JSR $A7D5		; A856	$20 $D5 $A7
	LDA $82			; A859	$A5 $82
	ORA $83			; A85B	$05 $83
	BNE L3A861		; A85D	$D0 $02
	INC $82			; A85F	$E6 $82
L3A861:
	LDX $6E			; A861	$A6 $6E
	LDA $82			; A863	$A5 $82
	STA $6108,X		; A865	$9D $08 $61
	LDA $83			; A868	$A5 $83
	STA $6109,X		; A86A	$9D $09 $61
	RTS			; A86D	$60
; End of

; Name	:
; Marks	:
	JSR $AAAE		; A86E	$20 $AE $AA
	LDA $80			; A871	$A5 $80
	CMP $81			; A873	$C5 $81
	BEQ L3A8A6		; A875	$F0 $2F
	LDA $81			; A877	$A5 $81
	CMP #$20		; A879	$C9 $20
	BNE L3A892		; A87B	$D0 $15
	LDX $80			; A87D	$A6 $80
	LDA $6060,X		; A87F	$BD $60 $60
	CMP #$10		; A882	$C9 $10
	BCS L3A88B		; A884	$B0 $05
L3A886:
	JSR $DE67		; A886	$20 $67 $DE	play error sound effect
	CLC			; A889	$18
	RTS			; A88A	$60
L3A88B:
	LDA #$00		; A88B	$A9 $00
	STA $6060,X		; A88D	$9D $60 $60
	CLC			; A890	$18
	RTS			; A891	$60
L3A892:
	LDX $80			; A892	$A6 $80
	LDA $6060,X		; A894	$BD $60 $60
	PHA			; A897	$48
	LDY $81			; A898	$A4 $81
	LDA $6060,Y		; A89A	$B9 $60 $60
	STA $6060,X		; A89D	$9D $60 $60
	PLA			; A8A0	$68
	STA $6060,Y		; A8A1	$99 $60 $60
	CLC			; A8A4	$18
	RTS			; A8A5	$60
L3A8A6:
	TAX			; A8A6	$AA
	LDA $6060,X		; A8A7	$BD $60 $60
	CMP #$10		; A8AA	$C9 $10
	BCC L3A886		; A8AC	$90 $D8
	CMP #$1C		; A8AE	$C9 $1C
	BCC L3A8BD		; A8B0	$90 $0B
	CMP #$98		; A8B2	$C9 $98
	BCC L3A886		; A8B4	$90 $D0
	CMP #$C0		; A8B6	$C9 $C0
	BCS L3A886		; A8B8	$B0 $CC
	JMP $AA4F		; A8BA	$4C $4F $AA
L3A8BD:
	STX $0A			; A8BD	$86 $0A
	SEC			; A8BF	$38
	SBC #$10		; A8C0	$E9 $10
	STA $08			; A8C2	$85 $08
	CMP #$0B		; A8C4	$C9 $0B
	BNE L3A8CD		; A8C6	$D0 $05
	LDA $2D			; A8C8	$A5 $2D
	LSR			; A8CA	$4A
	BCS L3A886		; A8CB	$B0 $B9
L3A8CD:
	LDA $08			; A8CD	$A5 $08
	CLC			; A8CF	$18
	ADC #$2B		; A8D0	$69 $2B
	JSR $A901		; A8D2	$20 $01 $A9
	LDA $08			; A8D5	$A5 $08
	CMP #$0B		; A8D7	$C9 $0B
	BEQ L3A8E0		; A8D9	$F0 $05
L3A8DB:
	JSR $AE5E		; A8DB	$20 $5E $AE
	BCS L3A8FF		; A8DE	$B0 $1F
L3A8E0:
	JSR $A9AA		; A8E0	$20 $AA $A9
	BCS L3A8DB		; A8E3	$B0 $F6
	JSR $B396		; A8E5	$20 $96 $B3
	LDA $08			; A8E8	$A5 $08
	CMP #$0B		; A8EA	$C9 $0B
	BEQ L3A8F1		; A8EC	$F0 $03
	JSR $EE60		; A8EE	$20 $60 $EE
L3A8F1:
	LDA #$42		; A8F1	$A9 $42		play song $02
	STA $E0			; A8F3	$85 $E0
	JSR $ADC6		; A8F5	$20 $C6 $AD
	LDX $0A			; A8F8	$A6 $0A
	LDA #$00		; A8FA	$A9 $00
	STA $6060,X		; A8FC	$9D $60 $60
L3A8FF:
	SEC			; A8FF	$38
	RTS			; A900	$60
	PHA			; A901	$48
	LDA #$00		; A902	$A9 $00
	STA $A2			; A904	$85 $A2
	JSR $B380		; A906	$20 $80 $B3	close menu
	JSR $B396		; A909	$20 $96 $B3
	LDX #$10		; A90C	$A2 $10
	JSR $B486		; A90E	$20 $86 $B4
	PLA      		; A911	$68
	JSR $B3DF		; A912	$20 $DF $B3	load menu text
	LDA #$00		; A915	$A9 $00
	STA $79F0		; A917	$8D $F0 $79
	RTS			; A91A	$60
	LDA #$00		; A91B	$A9 $00
	STA $81			; A91D	$85 $81
	LDA $80			; A91F	$A5 $80
	LDX $6E			; A921	$A6 $6E
	CLC			; A923	$18
	ADC $6108,X		; A924	$7D $08 $61
	STA $6108,X		; A927	$9D $08 $61
	LDA $6109,X		; A92A	$BD $09 $61
	ADC $81			; A92D	$65 $81
	STA $6109,X		; A92F	$9D $09 $61
	LDA $6109,X		; A932	$BD $09 $61
	CMP $610B,X		; A935	$DD $0B $61
	BCC L3A953		; A938	$90 $19
	BEQ L3A93E		; A93A	$F0 $02
	BCS L3A946		; A93C	$B0 $08
L3A93E:
	LDA $6108,X		; A93E	$BD $08 $61
	CMP $610A,X		; A941	$DD $0A $61
	BCC L3A953		; A944	$90 $0D
L3A946:
	LDA $610A,X		; A946	$BD $0A $61
	STA $6108,X		; A949	$9D $08 $61
	LDA $610B,X		; A94C	$BD $0B $61
	STA $6109,X		; A94F	$9D $09 $61
	CLC			; A952	$18
L3A953:
	RTS			; A953	$60
	LDX $6E			; A954	$A6 $6E
	CLC			; A956	$18
	ADC $610C,X		; A957	$7D $0C $61
	STA $610C,X		; A95A	$9D $0C $61
	LDA $610D,X		; A95D	$BD $0D $61
	ADC #$00		; A960	$69 $00
	STA $610D,X		; A962	$9D $0D $61
	LDA $610D,X		; A965	$BD $0D $61
	CMP $610F,X		; A968	$DD $0F $61
	BCC L3A986		; A96B	$90 $19
	BEQ L3A971		; A96D	$F0 $02
	BCS L3A979		; A96F	$B0 $08
L3A971:
	LDA $610C,X		; A971	$BD $0C $61
	CMP $610E,X		; A974	$DD $0E $61
	BCC L3A986		; A977	$90 $0D
L3A979:
	LDA $610E,X		; A979	$BD $0E $61
	STA $610C,X		; A97C	$9D $0C $61
	LDA $610F,X		; A97F	$BD $0F $61
	STA $610D,X		; A982	$9D $0D $61
	CLC			; A985	$18
L3A986:
	RTS			; A986	$60
L3A987:
	STA $80			; A987	$85 $80
	AND $6101,X		; A989	$3D $01 $61
	BNE L3A993		; A98C	$D0 $05
L3A98E:
	JSR $DE67		; A98E	$20 $67 $DE	play error sound effect
	SEC			; A991	$38
	RTS			; A992	$60
L3A993:
	LDA $80			; A993	$A5 $80
	EOR #$FF		; A995	$49 $FF
	AND $6101,X		; A997	$3D $01 $61
	STA $6101,X		; A99A	$9D $01 $61
	LDA $80			; A99D	$A5 $80
	AND #$80		; A99F	$29 $80
	BEQ L3A9A8		; A9A1	$F0 $05
	LDA #$01		; A9A3	$A9 $01
	STA $6108,X		; A9A5	$9D $08 $61
L3A9A8:
	CLC			; A9A8	$18
	RTS			; A9A9	$60
	LDX $6E			; A9AA	$A6 $6E
	LDA $08			; A9AC	$A5 $08
	BNE L3A9C1		; A9AE	$D0 $11
	LDA $6101,X		; A9B0	$BD $01 $61
	AND #$C0		; A9B3	$29 $C0
	BNE L3A98E		; A9B5	$D0 $D7
	LDA #$1E		; A9B7	$A9 $1E
	JSR $A7A3		; A9B9	$20 $A3 $A7	A += (0..A)
	STA $80			; A9BC	$85 $80
	JMP $A91B		; A9BE	$4C $1B $A9
L3A9C1:
	CMP #$01		; A9C1	$C9 $01
	BNE L3A9C9		; A9C3	$D0 $04
	LDA #$04		; A9C5	$A9 $04
	BNE L3A987		; A9C7	$D0 $BE
L3A9C9:
	CMP #$02		; A9C9	$C9 $02
	BNE L3A9D1		; A9CB	$D0 $04
	LDA #$40		; A9CD	$A9 $40
	BNE L3A987		; A9CF	$D0 $B6
L3A9D1:
	CMP #$03		; A9D1	$C9 $03
	BNE L3A9D9		; A9D3	$D0 $04
	LDA #$08		; A9D5	$A9 $08
	BNE L3A987		; A9D7	$D0 $AE
L3A9D9:
	CMP #$04		; A9D9	$C9 $04
	BNE L3A9E1		; A9DB	$D0 $04
	LDA #$20		; A9DD	$A9 $20
	BNE L3A987		; A9DF	$D0 $A6
L3A9E1:
	CMP #$05		; A9E1	$C9 $05
	BNE L3A9E9		; A9E3	$D0 $04
	LDA #$10		; A9E5	$A9 $10
	BNE L3A987		; A9E7	$D0 $9E
L3A9E9:
	CMP #$06		; A9E9	$C9 $06
	BNE L3A9F1		; A9EB	$D0 $04
	LDA #$02		; A9ED	$A9 $02
	BNE L3A987		; A9EF	$D0 $96
L3A9F1:
	CMP #$07		; A9F1	$C9 $07
	BNE L3A9F9		; A9F3	$D0 $04
	LDA #$80		; A9F5	$A9 $80
	BNE L3A987		; A9F7	$D0 $8E
L3A9F9:
	CMP #$08		; A9F9	$C9 $08
	BNE L3AA0A		; A9FB	$D0 $0D
	LDA $6101,X		; A9FD	$BD $01 $61
	AND #$C0		; AA00	$29 $C0
	BNE L3AA4A		; AA02	$D0 $46
	JSR $A979		; AA04	$20 $79 $A9
	JMP $A946		; AA07	$4C $46 $A9
L3AA0A:
	CMP #$09		; AA0A	$C9 $09
	BNE L3AA1D		; AA0C	$D0 $0F
	LDA $6101,X		; AA0E	$BD $01 $61
	AND #$C0		; AA11	$29 $C0
	BNE L3AA4A		; AA13	$D0 $35
	LDA #$14		; AA15	$A9 $14
	JSR $A7A3		; AA17	$20 $A3 $A7	A += (0..A)
	JMP $A954		; AA1A	$4C $54 $A9
L3AA1D:
	CMP #$0A		; AA1D	$C9 $0A
	BNE L3AA32		; AA1F	$D0 $11
	LDA $6101,X		; AA21	$BD $01 $61
	AND #$C0		; AA24	$29 $C0
	BNE L3AA4A		; AA26	$D0 $22
	LDA #$64		; AA28	$A9 $64
	JSR $A7A3		; AA2A	$20 $A3 $A7	A += (0..A)
	STA $80			; AA2D	$85 $80
	JMP $A91B		; AA2F	$4C $1B $A9
L3AA32:
	LDX #$00		; AA32	$A2 $00
L3AA34:
	LDA $6101,X		; AA34	$BD $01 $61
	AND #$C0		; AA37	$29 $C0
	BNE L3AA41		; AA39	$D0 $06
	JSR $A979		; AA3B	$20 $79 $A9
	JSR $A946		; AA3E	$20 $46 $A9
L3AA41:
	TXA			; AA41	$8A
	CLC			; AA42	$18
	ADC #$40		; AA43	$69 $40
	TAX			; AA45	$AA
	BNE L3AA34		; AA46	$D0 $EC
	CLC			; AA48	$18
	RTS			; AA49	$60
L3AA4A:
	JSR $DE67		; AA4A	$20 $67 $DE	play error sound effect
	SEC			; AA4D	$38
	RTS			; AA4E	$60
	SEC			; AA4F	$38
	SBC #$98		; AA50	$E9 $98
	STA $08			; AA52	$85 $08
	CLC			; AA54	$18
	ADC #$C0		; AA55	$69 $C0
	STA $09			; AA57	$85 $09
	STX $0A			; AA59	$86 $0A
	LDA #$3C		; AA5B	$A9 $3C
	JSR $A901		; AA5D	$20 $01 $A9
	JSR $AE5E		; AA60	$20 $5E $AE
	BCS L3AAAC		; AA63	$B0 $47
	LDX $6E			; AA65	$A6 $6E
	LDA $6101,X		; AA67	$BD $01 $61
	AND #$F0		; AA6A	$29 $F0
	BEQ L3AA73		; AA6C	$F0 $05
	LDA #$4D		; AA6E	$A9 $4D
	JMP $AA7C		; AA70	$4C $7C $AA
L3AA73:
	LDA $09			; AA73	$A5 $09
	JSR $AABD		; AA75	$20 $BD $AA
	BCC L3AA8C		; AA78	$90 $12
	LDA #$3D		; AA7A	$A9 $3D
	JSR $ADC3		; AA7C	$20 $C3 $AD
	LDX #$10		; AA7F	$A2 $10
	JSR $B486		; AA81	$20 $86 $B4
	LDA #$3C		; AA84	$A9 $3C
	JSR $B3DF		; AA86	$20 $DF $B3	load menu text
	JMP $AA60		; AA89	$4C $60 $AA
L3AA8C:
	JSR $AACE		; AA8C	$20 $CE $AA
	BCC L3AA96		; AA8F	$90 $05
	LDA #$3E		; AA91	$A9 $3E
	JMP $AA7C		; AA93	$4C $7C $AA
L3AA96:
	LDA #$42		; AA96	$A9 $42		play song $02
	STA $E0			; AA98	$85 $E0
	LDA $09			; AA9A	$A5 $09
	STA $6130,X		; AA9C	$9D $30 $61
	LDA #$00		; AA9F	$A9 $00
	LDX $0A			; AAA1	$A6 $0A
	STA $6060,X		; AAA3	$9D $60 $60
	JSR $AF4A		; AAA6	$20 $4A $AF
	JSR $ADE9		; AAA9	$20 $E9 $AD
L3AAAC:
	SEC			; AAAC	$38
	RTS			; AAAD	$60
	LDA $78F0		; AAAE	$AD $F0 $78
	LSR			; AAB1	$4A
	LSR			; AAB2	$4A
	STA $80			; AAB3	$85 $80
	LDA $79F0		; AAB5	$AD $F0 $79
	LSR			; AAB8	$4A
	LSR			; AAB9	$4A
	STA $81			; AABA	$85 $81
	RTS			; AABC	$60
	LDX $6E			; AABD	$A6 $6E
	LDY #$10		; AABF	$A0 $10
L3AAC1:
	CMP $6130,X		; AAC1	$DD $30 $61
	BEQ L3AACC		; AAC4	$F0 $06
	INX			; AAC6	$E8
	DEY			; AAC7	$88
	BNE L3AAC1		; AAC8	$D0 $F7
	CLC			; AACA	$18
	RTS			; AACB	$60
L3AACC:
	SEC			; AACC	$38
	RTS			; AACD	$60
	LDX $6E			; AACE	$A6 $6E
	LDY #$10		; AAD0	$A0 $10
L3AAD2:
	LDA $6130,X		; AAD2	$BD $30 $61
	BEQ L3AADD		; AAD5	$F0 $06
	INX			; AAD7	$E8
	DEY			; AAD8	$88
	BNE L3AAD2		; AAD9	$D0 $F7
	SEC			; AADB	$38
	RTS			; AADC	$60
L3AADD:
	CLC			; AADD	$18
	RTS			; AADE	$60
	JSR $AAAE		; AADF	$20 $AE $AA
	LDA $80			; AAE2	$A5 $80
	CMP $81			; AAE4	$C5 $81
	BEQ L3AB4A		; AAE6	$F0 $62
	LDA $81			; AAE8	$A5 $81
	CMP #$10		; AAEA	$C9 $10
	BCC L3AB08		; AAEC	$90 $1A
	LDA $6E			; AAEE	$A5 $6E
	ORA $80			; AAF0	$05 $80
	TAX			; AAF2	$AA
	LDA #$00		; AAF3	$A9 $00
	STA $6130,X		; AAF5	$9D $30 $61
	LDA $80			; AAF8	$A5 $80
	ASL			; AAFA	$0A
	ORA $6E			; AAFB	$05 $6E
	TAX			; AAFD	$AA
	LDA #$00		; AAFE	$A9 $00
	STA $6210,X		; AB00	$9D $10 $62
	STA $6211,X		; AB03	$9D $11 $62
	CLC			; AB06	$18
	RTS			; AB07	$60
L3AB08:
	LDA $6E			; AB08	$A5 $6E
	ORA $80			; AB0A	$05 $80
	TAX			; AB0C	$AA
	LDA $6E			; AB0D	$A5 $6E
	ORA $81			; AB0F	$05 $81
	TAY			; AB11	$A8
	LDA $6130,X		; AB12	$BD $30 $61
	PHA			; AB15	$48
	LDA $6130,Y		; AB16	$B9 $30 $61
	STA $6130,X		; AB19	$9D $30 $61
	PLA			; AB1C	$68
	STA $6130,Y		; AB1D	$99 $30 $61
	LDA $80			; AB20	$A5 $80
	ASL			; AB22	$0A
	ORA $6E			; AB23	$05 $6E
	TAX			; AB25	$AA
	LDA $81			; AB26	$A5 $81
	ASL			; AB28	$0A
	ORA $6E			; AB29	$05 $6E
	TAY			; AB2B	$A8
	LDA $6210,X		; AB2C	$BD $10 $62
	PHA			; AB2F	$48
	LDA $6210,Y		; AB30	$B9 $10 $62
	STA $6210,X		; AB33	$9D $10 $62
	PLA			; AB36	$68
	STA $6210,Y		; AB37	$99 $10 $62
	LDA $6211,X		; AB3A	$BD $11 $62
	PHA			; AB3D	$48
	LDA $6211,Y		; AB3E	$B9 $11 $62
	STA $6211,X		; AB41	$9D $11 $62
	PLA			; AB44	$68
	STA $6211,Y		; AB45	$99 $11 $62
	CLC			; AB48	$18
	RTS			; AB49	$60
L3AB4A:
	LDA $6E			; AB4A	$A5 $6E
	ORA $80			; AB4C	$05 $80
	TAX			; AB4E	$AA
	LDA $6130,X		; AB4F	$BD $30 $61
	BEQ L3AB70		; AB52	$F0 $1C
	STA $82			; AB54	$85 $82
	LDX $6E			; AB56	$A6 $6E
	LDA $80			; AB58	$A5 $80
	ASL			; AB5A	$0A
	ORA $6E			; AB5B	$05 $6E
	TAY			; AB5D	$A8
	LDA $6210,Y		; AB5E	$B9 $10 $62
	CLC			; AB61	$18
	ADC #$01		; AB62	$69 $01
	CMP $610C,X		; AB64	$DD $0C $61
	BCC L3AB75		; AB67	$90 $0C
	BEQ L3AB75		; AB69	$F0 $0A
	LDA $610D,X		; AB6B	$BD $0D $61
	BNE L3AB75		; AB6E	$D0 $05
L3AB70:
	JSR $DE67		; AB70	$20 $67 $DE	play error sound effect
	CLC			; AB73	$18
	RTS			; AB74	$60
L3AB75:
	LDA $82			; AB75	$A5 $82
	CMP #$D0		; AB77	$C9 $D0
	BNE L3AB9A		; AB79	$D0 $1F
	LDA $2D			; AB7B	$A5 $2D
	LSR			; AB7D	$4A
	BCC L3AB70		; AB7E	$90 $F0
	LDA $19			; AB80	$A5 $19
	BEQ L3ABDB		; AB82	$F0 $57
L3AB84:
	LDA #$47		; AB84	$A9 $47
	JSR $ADB6		; AB86	$20 $B6 $AD
	JSR $ADE9		; AB89	$20 $E9 $AD
	JSR $EE60		; AB8C	$20 $60 $EE
	LDX #$0B		; AB8F	$A2 $0B
	JSR $B486		; AB91	$20 $86 $B4
	LDA #$01		; AB94	$A9 $01
	STA $A2			; AB96	$85 $A2
	CLC			; AB98	$18
	RTS			; AB99	$60
L3AB9A:
	CMP #$D4		; AB9A	$C9 $D4
	BNE L3ABA1		; AB9C	$D0 $03
	JMP $AC16		; AB9E	$4C $16 $AC
L3ABA1:
	CMP #$D5		; ABA1	$C9 $D5
	BNE L3ABA8		; ABA3	$D0 $03
	JMP $AC2F		; ABA5	$4C $2F $AC
L3ABA8:
	CMP #$D7		; ABA8	$C9 $D7
	BNE L3ABAF		; ABAA	$D0 $03
	JMP $AC43		; ABAC	$4C $43 $AC
L3ABAF:
	CMP #$E6		; ABAF	$C9 $E6
	BNE L3AB70		; ABB1	$D0 $BD
	LDA $2D			; ABB3	$A5 $2D
	LSR			; ABB5	$4A
	BCC L3AB70		; ABB6	$90 $B8
	LDA $19			; ABB8	$A5 $19
	BNE L3AB84		; ABBA	$D0 $C8
	JSR $AC6B		; ABBC	$20 $6B $AC
	JSR $AC85		; ABBF	$20 $85 $AC
	LDA #$3B		; ABC2	$A9 $3B
	JSR $ADB6		; ABC4	$20 $B6 $AD
	JSR $ADE9		; ABC7	$20 $E9 $AD
	JSR $A83A		; ABCA	$20 $3A $A8
	JSR $B380		; ABCD	$20 $80 $B3	close menu
	LDA #$00		; ABD0	$A9 $00
	STA $2001		; ABD2	$8D $01 $20
	STA $4015		; ABD5	$8D $15 $40
	JMP $C0B8		; ABD8	$4C $B8 $C0	world map main
L3ABDB:
	LDA $80			; ABDB	$A5 $80
	ASL			; ABDD	$0A
	ORA $6E			; ABDE	$05 $6E
	TAY			; ABE0	$A8
	LDA $6210,Y		; ABE1	$B9 $10 $62
	PHA			; ABE4	$48
	JSR $AC85		; ABE5	$20 $85 $AC
	PLA			; ABE8	$68
	TAY			; ABE9	$A8
	TSX			; ABEA	$BA
	TXA			; ABEB	$8A
	CLC			; ABEC	$18
	ADC #$08		; ABED	$69 $08
	CMP #$FB		; ABEF	$C9 $FB
	BCS L3AC00		; ABF1	$B0 $0D
	DEY			; ABF3	$88
	BMI L3AC00		; ABF4	$30 $0A
L3ABF6:
	CLC			; ABF6	$18
	ADC #$05		; ABF7	$69 $05
	CMP #$FB		; ABF9	$C9 $FB
	BCS L3AC00		; ABFB	$B0 $03
	DEY			; ABFD	$88
	BPL L3ABF6		; ABFE	$10 $F6
L3AC00:
	TAX			; AC00	$AA
	TXS			; AC01	$9A
	LDA #$37		; AC02	$A9 $37
	JSR $ADB6		; AC04	$20 $B6 $AD
	JSR $ADE9		; AC07	$20 $E9 $AD
	JSR $B380		; AC0A	$20 $80 $B3	close menu
	LDA #$00		; AC0D	$A9 $00
	STA $2001		; AC0F	$8D $01 $20
	STA $4015		; AC12	$8D $15 $40
	RTS			; AC15	$60
	JSR $AC6B		; AC16	$20 $6B $AC
	LDA #$38		; AC19	$A9 $38
	JSR $A901		; AC1B	$20 $01 $A9
L3AC1E:
	JSR $AE08		; AC1E	$20 $08 $AE
	BCS L3AC2A		; AC21	$B0 $07
	JSR $A61B		; AC23	$20 $1B $A6
	BCC L3AC57		; AC26	$90 $2F
	BCS L3AC1E		; AC28	$B0 $F4
L3AC2A:
	JSR $AC78		; AC2A	$20 $78 $AC
	SEC			; AC2D	$38
	RTS			; AC2E	$60
	JSR $AC6B		; AC2F	$20 $6B $AC
	LDA #$39		; AC32	$A9 $39
	JSR $A901		; AC34	$20 $01 $A9
L3AC37:
	JSR $AE08		; AC37	$20 $08 $AE
	BCS L3AC2A		; AC3A	$B0 $EE
	JSR $A6A5		; AC3C	$20 $A5 $A6
	BCC L3AC57		; AC3F	$90 $16
	BCS L3AC37		; AC41	$B0 $F4
	JSR $AC6B		; AC43	$20 $6B $AC
	LDA #$3A		; AC46	$A9 $3A
	JSR $A901		; AC48	$20 $01 $A9
L3AC4B:
	JSR $AE08		; AC4B	$20 $08 $AE
	BCS L3AC2A		; AC4E	$B0 $DA
	JSR $A6F4		; AC50	$20 $F4 $A6
	BCC L3AC57		; AC53	$90 $02
	BCS L3AC4B		; AC55	$B0 $F4
L3AC57:
	JSR $AC78		; AC57	$20 $78 $AC
	JSR $AC85		; AC5A	$20 $85 $AC
	JSR $EE60		; AC5D	$20 $60 $EE
	JSR $B396		; AC60	$20 $96 $B3
	JSR $ADC6		; AC63	$20 $C6 $AD
	JSR $AC78		; AC66	$20 $78 $AC
	SEC			; AC69	$38
	RTS			; AC6A	$60
; End of

; Name	:
; Marks	:
	LDA $80			; AC6B	$A5 $80
	STA $08			; AC6D	$85 $08
	LDA $9E			; AC6F	$A5 $9E
	STA $09			; AC71	$85 $09
	LDA $6E			; AC73	$A5 $6E
	STA $0A			; AC75	$85 $0A
	RTS			; AC77	$60
; End of

; Name	:
; Marks	:
	LDA $08			; AC78	$A5 $08
	STA $80			; AC7A	$85 $80
	LDA $09			; AC7C	$A5 $09
	STA $9E			; AC7E	$85 $9E
	LDA $0A			; AC80	$A5 $0A
	STA $6E			; AC82	$85 $6E
	RTS			; AC84	$60
; End of

; Name	:
; Marks	:
	LDA #$42		; AC85	$A9 $42		play song $02
	STA $E0			; AC87	$85 $E0
	LDX $6E			; AC89	$A6 $6E
	LDA $80			; AC8B	$A5 $80
	ASL			; AC8D	$0A
	ORA $6E			; AC8E	$05 $6E
	TAY			; AC90	$A8
	LDA $610C,X		; AC91	$BD $0C $61
	CLC			; AC94	$18
	SBC $6210,Y		; AC95	$F9 $10 $62
	STA $610C,X		; AC98	$9D $0C $61
	LDA $610D,X		; AC9B	$BD $0D $61
	SBC #$00		; AC9E	$E9 $00
	STA $610D,X		; ACA0	$9D $0D $61
	LDA $6211,Y		; ACA3	$B9 $11 $62
	CLC			; ACA6	$18
	ADC #$02		; ACA7	$69 $02
	CMP #$64		; ACA9	$C9 $64
	BCS L3ACB1		; ACAB	$B0 $04
	STA $6211,Y		; ACAD	$99 $11 $62
	RTS			; ACB0	$60
L3ACB1:
	LDA $6210,Y		; ACB1	$B9 $10 $62
	CLC			; ACB4	$18
	ADC #$01		; ACB5	$69 $01
	CMP #$10		; ACB7	$C9 $10
	BCS L3ACC3		; ACB9	$B0 $08
	STA $6210,Y		; ACBB	$99 $10 $62
	LDA #$00		; ACBE	$A9 $00
	STA $6211,Y		; ACC0	$99 $11 $62
L3ACC3:
	RTS			; ACC3	$60
; End of



;----------------------------------------------------------------------



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
	JSR $ADA2		; AD0D	$20 $A2 AD
	JSR $8EB6		; AD10	$20 $B6 8E	init player input
	LDA #$01		; AD13	$A9 $01
	STA $A2			; AD15	$85 $A2
L3AD17:
	JSR $B401		; AD17	$20 $01 $B4	wait for vblank (update cursors)
	JSR $8800		; AD1A	$20 $00 $88	draw portraits
	LDA #$04		; AD1D	$A9 $04
	JSR $96C5		; AD1F	$20 $C5 $96	get cursor 1 position
	LDA $25			; AD22	$A5 $25
	BNE L3AD8C		; AD24	$D0 $66		branch if B button pressed
	LDA $24			; AD26	$A5 $24
	BEQ L3AD17		; AD28	$F0 $ED		branch if A button is not pressed
	JSR $905E		; AD2A	$20 $5E $90	cursor sound effect (confirm)
	LDA $78F0		; AD2D	$AD $F0 $78	cursor position
; item
	BNE L3AD38		; AD30	$D0 $06
	JSR $AEC5		; AD32	$20 $C5 $AE	item menu
	JMP $AD00		; AD35	$4C $00 $AD
; magic
L3AD38:
	CMP #$04		; AD38	$C9 $04
	BNE L3AD47		; AD3A	$D0 $0B
	JSR $AE59		; AD3C	$20 $59 $AE	character select
	BCS L3AD17		; AD3F	$B0 $D6
	JSR $AF93		; AD41	$20 $93 $AF	magic menu
	JMP $AD00		; AD44	$4C $00 $AD
; equip
L3AD47:
	CMP #$08		; AD47	$C9 $08
	BNE L3AD56		; AD49	$D0 $0B
	JSR $AE59		; AD4B	$20 $59 $AE	character select
	BCS L3AD17		; AD4E	$B0 $C7
	JSR $B015		; AD50	$20 $15 $B0	equip menu
	JMP $AD00		; AD53	$4C $00 $AD
; stats
L3AD56:
	CMP #$0C		; AD56	$C9 $0C
	BNE L3AD65		; AD58	$D0 $0B
	JSR $AE59		; AD5A	$20 $59 $AE	character select
	BCS L3AD17		; AD5D	$B0 $B8
	JSR $B1B1		; AD5F	$20 $B1 $B1	stats menu
	JMP $AD00		; AD62	$4C $00 $AD
; save
L3AD65:
	LDA $2D			; AD65	$A5 $2D
	LSR			; AD67	$4A
	BCC L3AD79		; AD68	$90 $0F		branch if on the world map
	LDA #$40		; AD6A	$A9 $40
	JSR $ADC3		; AD6C	$20 $C3 $AD
	LDA #$01		; AD6F	$A9 $01
	STA $A2			; AD71	$85 $A2
	JSR $ADA2		; AD73	$20 $A2 $AD
	JMP $AD17		; AD76	$4C $17 $AD
L3AD79:
	JSR $B1D7		; AD79	$20 $D7 $B1	save menu
	JSR $EE60		; AD7C	$20 $60 $EE
	JSR $8EB6		; AD7F	$20 $B6 $8E	init player input
	JSR $ADA2		; AD82	$20 $A2 $AD
	LDA #$01		; AD85	$A9 $01
	STA $A2			; AD87	$85 $A2
	JMP $AD17		; AD89	$4C $17 $AD
; close menu
L3AD8C:
	JSR $B380		; AD8C	$20 $80 $B3	close menu
	LDA #$00		; AD8F	$A9 $00
	STA $2001		; AD91	$8D $01 $20
	STA $4015		; AD94	$8D $15 $40
	STA $24			; AD97	$85 $24
	STA $25			; AD99	$85 $25
	STA $22			; AD9B	$85 $22
	STA $23			; AD9D	$85 $23
	STA $47			; AD9F	$85 $47
	RTS			; ADA1	$60
; End of

; Name	:
; Marks	:
	LDX #$05		; ADA2	$A2 $05
	JSR $B486		; ADA4	$20 $86 $B4
	LDA #$1C		; ADA7	$A9 $1C
	JSR $B3DF		; ADA9	$20 $DF $B3	load menu text
	LDX #$04		; ADAC	$A2 $04
	JSR $B486		; ADAE	$20 $86 $B4
	LDA #$1B		; ADB1	$A9 $1B
	JMP $B3DF		; ADB3	$4C $DF $B3	load menu text
; End of

; Name	:
; Marks	:
	PHA 			; ADB6	$48
	JSR $EE60		; ADB7	$20 $60 $EE
	LDX #$10		; ADBA	$A2 $10
	JSR $B486		; ADBC	$20 $86 $B4
	PLA			; ADBF	$68
	JMP $B3DF		; ADC0	$4C $DF $B3	load menu text
; End of

; Name	:
; Marks	:
	JSR $ADB6		; ADC3	$20 $B6 $AD
	LDA #$00		; ADC6	$A9 $00
	STA $A2			; ADC8	$85 $A2
	STA $A3			; ADCA	$85 $A3
	STA $A4			; ADCC	$85 $A4
	LDA #$00		; ADCE	$A9 $00
	STA $24			; ADD0	$85 $24
	STA $25			; ADD2	$85 $25
L3ADD4:
	JSR $B401		; ADD4	$20 $01 $B4	wait for vblank (update cursors)
	JSR $8800		; ADD7	$20 $00 $88	draw portraits
	JSR $DB5C		; ADDA	$20 $5C $DB	update joypad input
	LDA $24			; ADDD	$A5 $24
	ORA $25			; ADDF	$05 $25
	BEQ L3ADD4		; ADE1	$F0 $F1
	JSR $905E		; ADE3	$20 $5E $90	cursor sound effect (confirm)
	JMP $EE60		; ADE6	$4C $60 $EE
; End of

; Name	:
; Marks	:
	LDA #$00		; ADE9	$A9 $00
	STA $A2			; ADEB	$85 $A2
	STA $A3			; ADED	$85 $A3
	STA $A4			; ADEF	$85 $A4
	STA $24			; ADF1	$85 $24
	STA $25			; ADF3	$85 $25
L3ADF5:
	JSR $B401		; ADF5	$20 $01 $B4	wait for vblank (update cursors)
	JSR $B36A		; ADF8	$20 $6A $B3
	JSR $DB5C		; ADFB	$20 $5C $DB	update joypad input
	LDA $24			; ADFE	$A5 $24
	ORA $25			; AE00	$05 $25
	BEQ L3ADF5		; AE02	$F0 $F1
	JSR $905E		; AE04	$20 $5E $90	cursor sound effect (confirm)
	RTS			; AE07	$60
	LDA #$00		; AE08	$A9 $00
	STA $79F0		; AE0A	$8D $F0 $79
	LDX #$0F		; AE0D	$A2 $0F
L3AE0F:
	LDA $AEAA,X		; AE0F	$BD $AA $AE
	STA $7900,X		; AE12	$9D $00 $79
	DEX			; AE15	$CA
	BPL L3AE0F		; AE16	$10 $F7
	LDA #$14		; AE18	$A9 $14
	LDX $62F5		; AE1A	$AE $F5 $62
	BPL L3AE21		; AE1D	$10 $02
	LDA #$10		; AE1F	$A9 $10
L3AE21:
	STA $79F1		; AE21	$8D $F1 $79
	LDA #$01		; AE24	$A9 $01
	STA $A3			; AE26	$85 $A3
L3AE28:
	JSR $B418		; AE28	$20 $18 $B4
	JSR $8800		; AE2B	$20 $00 $88	draw portraits
	LDA #$08		; AE2E	$A9 $08
	JSR $96F9		; AE30	$20 $F9 $96	update cursor 2 position
	LDA $25			; AE33	$A5 $25
	BNE L3AE50		; AE35	$D0 $19
	LDA $24			; AE37	$A5 $24
	BEQ L3AE28		; AE39	$F0 $ED
	JSR $905E		; AE3B	$20 $5E $90	cursor sound effect (confirm)
	LDA $79F0		; AE3E	$AD $F0 $79
	LSR			; AE41	$4A
	LSR			; AE42	$4A
	ORA #$10		; AE43	$09 $10
	STA $9E			; AE45	$85 $9E
	LSR			; AE47	$4A
	ROR			; AE48	$6A
	ROR			; AE49	$6A
	AND #$C0		; AE4A	$29 $C0
	STA $6E			; AE4C	$85 $6E
	CLC			; AE4E	$18
	RTS			; AE4F	$60
L3AE50:
	LDA #$00		; AE50	$A9 $00
	STA $A3			; AE52	$85 $A3
	JSR $905E		; AE54	$20 $5E $90	cursor sound effect (confirm)
	SEC			; AE57	$38
	RTS			; AE58	$60
; End of

; Name	:
; Marks	: character select (main menu)
	LDA #$00		; AE59	$A9 $00
	STA $79F0		; AE5B	$8D $F0 $79
	LDX #$0F		; AE5E	$A2 $0F
L3AE60:
	LDA $AEAA,X		; AE60	$BD $AA $AE
	STA $7900,X		; AE63	$9D $00 $79
	DEX			; AE66	$CA
	BPL L3AE60		; AE67	$10 $F7
	LDA #$10		; AE69	$A9 $10
	LDX $62F5		; AE6B	$AE $F5 $62
	BPL L3AE72		; AE6E	$10 $02
	LDA #$0C		; AE70	$A9 $0C
L3AE72:
	STA $79F1		; AE72	$8D $F1 $79
	LDA #$01		; AE75	$A9 $01
	STA $A3			; AE77	$85 $A3
L3AE79:
	JSR $B401		; AE79	$20 $01 $B4	wait for vblank (update cursors)
	JSR $8800		; AE7C	$20 $00 $88	draw portraits
	LDA #$08		; AE7F	$A9 $08
	JSR $96F9		; AE81	$20 $F9 $96	update cursor 2 position
	LDA $25			; AE84	$A5 $25
	BNE L3AEA1		; AE86	$D0 $19
	LDA $24			; AE88	$A5 $24
	BEQ L3AE79		; AE8A	$F0 $ED
	JSR $905E		; AE8C	$20 $5E $90	cursor sound effect (confirm)
	LDA $79F0		; AE8F	$AD $F0 $79
	LSR			; AE92	$4A
	LSR			; AE93	$4A
	ORA #$10		; AE94	$09 $10
	STA $9E			; AE96	$85 $9E
	LSR			; AE98	$4A
	ROR			; AE99	$6A
	ROR			; AE9A	$6A
	AND #$C0		; AE9B	$29 $C0
	STA $6E			; AE9D	$85 $6E
	CLC			; AE9F	$18
	RTS			; AEA0	$60
L3AEA1:
	LDA #$00		; AEA1	$A9 $00
	STA $A3			; AEA3	$85 $A3
	JSR $905E		; AEA5	$20 $5E $90	cursor sound effect (confirm)
	SEC			; AEA8	$38
	RTS			; AEA9	$60
; End of

; $AEAA - data block =
.byte $06,$03,$00,$00		; AEAA 
.byte $14,$03,$00,$00		; AEAE 
.byte $08,$0D,$00,$00		; AEB2 
.byte $16,$0D,$00,$00		; AEB6 

; close menu
L3AEBA:
	JSR $905E		; AEBA	$20 $5E $90	cursor sound effect (confirm)
	LDA #$00		; AEBD	$A9 $00
	STA $78F0		; AEBF	$8D $F0 $78
	JMP $B380		; AEC2	$4C $80 $B3	close menu
; Name	:
; Marks	:
L3AEC5:
	JSR $905E		; AEC5	$20 $5E $90	cursor sound effect (confirm)
	JSR $B380		; AEC8	$20 $80 $B3	close menu
	LDA #$00		; AECB	$A9 $00
	STA $A3			; AECD	$85 $A3
	STA $A4			; AECF	$85 $A4
	LDA #$01		; AED1	$A9 $01
	STA $A2			; AED3	$85 $A2
	LDA #$00		; AED5	$A9 $00
	STA $7AF0		; AED7	$8D $F0 $7A
	LDX #$07		; AEDA	$A2 $07
	JSR $B486		; AEDC	$20 $86 $B4
	LDA #$25		; AEDF	$A9 $25
	JSR $B3DF		; AEE1	$20 $DF $B3	load menu text
	LDX #$06		; AEE4	$A2 $06
	JSR $B486		; AEE6	$20 $86 $B4
	LDA #$1F		; AEE9	$A9 $1F
	JSR $B3DF		; AEEB	$20 $DF $B3	load menu text
	JSR $B314		; AEEE	$20 $14 $B3
	JSR $B33F		; AEF1	$20 $3F $B3
L3AEF4:
	JSR $B401		; AEF4	$20 $01 $B4	wait for vblank (update cursors)
	LDA #$0C		; AEF7	$A9 $0C
	JSR $96C5		; AEF9	$20 $C5 $96	get cursor 1 position
	LDA $25			; AEFC	$A5 $25
	BNE L3AEBA		; AEFE	$D0 $BA
	LDA $24			; AF00	$A5 $24
	BEQ L3AEF4		; AF02	$F0 $F0
	JSR $905E		; AF04	$20 $5E $90	cursor sound effect (confirm)
	LDA #$01		; AF07	$A9 $01
	STA $A3			; AF09	$85 $A3
	LDA $78F0		; AF0B	$AD $F0 $78
	STA $79F0		; AF0E	$8D $F0 $79
L3AF11:
	JSR $B401		; AF11	$20 $01 $B4	wait for vblank (update cursors)
	LDA #$0C		; AF14	$A9 $0C
	JSR $96F9		; AF16	$20 $F9 $96	update cursor 2 position
	LDA $25			; AF19	$A5 $25
	BEQ L3AF27		; AF1B	$F0 $0A
	JSR $905E		; AF1D	$20 $5E $90	cursor sound effect (confirm)
	LDA #$00		; AF20	$A9 $00
	STA $A3			; AF22	$85 $A3
	JMP $AEF4		; AF24	$4C $F4 $AE
L3AF27:
	LDA $24			; AF27	$A5 $24
	BEQ L3AF11		; AF29	$F0 $E6
	JSR $905E		; AF2B	$20 $5E $90	cursor sound effect (confirm)
	LDA #$00		; AF2E	$A9 $00
	STA $A3			; AF30	$85 $A3
	JSR $A86E		; AF32	$20 $6E $A8
	BCS L3AEC5		; AF35	$B0 $8E
	LDX #$07		; AF37	$A2 $07
	JSR $B451		; AF39	$20 $51 $B4
	LDA #$25		; AF3C	$A9 $25
	JSR $B3DF		; AF3E	$20 $DF $B3	load menu text
	JSR $B33F		; AF41	$20 $3F $B3
	JSR $B314		; AF44	$20 $14 $B3
	JMP $AEF4		; AF47	$4C $F4 $AE
; End of

; Name	:
; Marks	:
	JSR $905E		; AF4A	$20 $5E $90	cursor sound effect (confirm)
	JSR $B380		; AF4D	$20 $80 $B3	close menu
	LDA #$00		; AF50	$A9 $00
	STA $A3			; AF52	$85 $A3
	STA $A4			; AF54	$85 $A4
	LDA #$01		; AF56	$A9 $01
	STA $A2			; AF58	$85 $A2
	LDA #$00		; AF5A	$A9 $00
	STA $7AF0		; AF5C	$8D $F0 $7A
	LDX #$08		; AF5F	$A2 $08
	JSR $B486		; AF61	$20 $86 $B4
	LDA #$20		; AF64	$A9 $20
	JSR $B3CD		; AF66	$20 $CD $B3
	LDX #$09		; AF69	$A2 $09
	JSR $B486		; AF6B	$20 $86 $B4
	LDA #$1D		; AF6E	$A9 $1D
	JSR $B3DF		; AF70	$20 $DF $B3	load menu text
	LDX #$0A		; AF73	$A2 $0A
	JSR $B486		; AF75	$20 $86 $B4
	LDA #$21		; AF78	$A9 $21
	JSR $B3CD		; AF7A	$20 $CD $B3
	LDX #$0B		; AF7D	$A2 $0B
	JSR $B486		; AF7F	$20 $86 $B4
	LDA #$26		; AF82	$A9 $26
	JSR $B3CD		; AF84	$20 $CD $B3
	RTS			; AF87	$60
; End of


; close menu
L3AF88:
	JSR $905E		; AF88	$20 $5E $90	cursor sound effect (confirm)
	LDA #$04		; AF8B	$A9 $04
	STA $78F0		; AF8D	$8D $F0 $78
	JMP $B380		; AF90	$4C $80 $B3	close menu
; Name	:
; Marks	: magic menu
; subroutine starts at 0E/AF93
; starts here
	JSR $AF4A		; AF93	$20 $4A $AF
	JSR $B314		; AF96	$20 $14 $B3
	JSR $B33F		; AF99	$20 $3F $B3
	LDA #$00		; AF9C	$A9 $00
	STA $78F0		; AF9E	$8D $F0 $78
L3AFA1:
	JSR $B401		; AFA1	$20 $01 $B4	wait for vblank (update cursors)
	JSR $B36A		; AFA4	$20 $6A $B3
	LDA #$08		; AFA7	$A9 $08
	JSR $96C5		; AFA9	$20 $C5 $96	get cursor 1 position
	LDA $25			; AFAC	$A5 $25
	BNE L3AF88		; AFAE	$D0 $D8
	LDA $24			; AFB0	$A5 $24
	BEQ L3AFA1		; AFB2	$F0 $ED
	JSR $905E		; AFB4	$20 $5E $90	cursor sound effect (confirm)
	LDA #$01		; AFB7	$A9 $01
	STA $A3			; AFB9	$85 $A3
	LDA $78F0		; AFBB	$AD $F0 $78
	STA $79F0		; AFBE	$8D $F0 $79
L3AFC1:
	JSR $B401		; AFC1	$20 $01 $B4	wait for vblank (update cursors)
	JSR $B36A		; AFC4	$20 $6A $B3
	LDA #$08		; AFC7	$A9 $08
	JSR $96F9		; AFC9	$20 $F9 $96	update cursor 2 position
	LDA $25			; AFCC	$A5 $25
	BEQ L3AFDA		; AFCE	$F0 $0A
	JSR $905E		; AFD0	$20 $5E $90	cursor sound effect (confirm)
	LDA #$00		; AFD3	$A9 $00
	STA $A3			; AFD5	$85 $A3
	JMP $AFA1		; AFD7	$4C $A1 $AF
L3AFDA:
	LDA $24			; AFDA	$A5 $24
	BEQ L3AFC1		; AFDC	$F0 $E3
	LDX $6E			; AFDE	$A6 $6E
	LDA $6101,X		; AFE0	$BD $01 $61
	AND #$D0		; AFE3	$29 $D0
	BEQ L3AFED		; AFE5	$F0 $06
	JSR $DE67		; AFE7	$20 $67 $DE	play error sound effect
	JMP $AFD0		; AFEA	$4C $D0 $AF
L3AFED:
	JSR $905E		; AFED	$20 $5E $90	cursor sound effect (confirm)
	LDA #$00		; AFF0	$A9 $00
	STA $A3			; AFF2	$85 $A3
	JSR $AADF		; AFF4	$20 $DF $AA
	BCC L3AFFC		; AFF7	$90 $03
	JMP $AF93		; AFF9	$4C $93 $AF
L3AFFC:
	LDX #$0B		; AFFC	$A2 $0B
	JSR $B451		; AFFE	$20 $51 $B4
	LDA #$26		; B001	$A9 $26
	JSR $B3CD		; B003	$20 $CD $B3
	JSR $B33F		; B006	$20 $3F $B3
	JSR $B314		; B009	$20 $14 $B3
	JMP $AFA1		; B00C	$4C $A1 $AF
; End of

L3B00F:
	JSR $905E		; B00F	$20 $5E $90	cursor sound effect (confirm)
	JMP $B380		; B012	$4C $80 $B3	close menu
; Name	:
; Marks	: equip menu
; subroutine starts at 0E/B015
; starts here
	JSR $905E		; B015	$20 $5E $90	cursor sound effect (confirm)
	JSR $B380		; B018	$20 $80 $B3	close menu
	LDA #$00		; B01B	$A9 $00
	STA $A4			; B01D	$85 $A4
	STA $A2			; B01F	$85 $A2
	LDA #$01		; B021	$A9 $01
	STA $A3			; B023	$85 $A3
	LDA #$00		; B025	$A9 $00
	STA $7AF0		; B027	$8D $F0 $7A
	STA $79F0		; B02A	$8D $F0 $79
	LDX #$08		; B02D	$A2 $08
	JSR $B486		; B02F	$20 $86 $B4
	LDA #$22		; B032	$A9 $22
	JSR $B3CD		; B034	$20 $CD $B3
	LDX #$09		; B037	$A2 $09
	JSR $B486		; B039	$20 $86 $B4
	LDA #$1D		; B03C	$A9 $1D
	JSR $B3DF		; B03E	$20 $DF $B3	load menu text
	LDX #$0A		; B041	$A2 $0A
	JSR $B486		; B043	$20 $86 $B4
	LDA #$23		; B046	$A9 $23
	JSR $B3CD		; B048	$20 $CD $B3
	LDX #$0C		; B04B	$A2 $0C
	JSR $B486		; B04D	$20 $86 $B4
	LDA #$24		; B050	$A9 $24
	JSR $B3CD		; B052	$20 $CD $B3
	LDX #$0D		; B055	$A2 $0D
	JSR $B486		; B057	$20 $86 $B4
	LDA #$25		; B05A	$A9 $25
	JSR $B3F0		; B05C	$20 $F0 $B3	load menu text
	JSR $94EB		; B05F	$20 $EB $94	save dialogue window variables
L3B062:
	JSR $B401		; B062	$20 $01 $B4	wait for vblank (update cursors)
	JSR $B36A		; B065	$20 $6A $B3
	LDA #$04		; B068	$A9 $04
	JSR $96F9		; B06A	$20 $F9 $96	update cursor 2 position
	LDA $25			; B06D	$A5 $25
	BNE L3B00F		; B06F	$D0 $9E
	LDA $24			; B071	$A5 $24
	BEQ L3B062		; B073	$F0 $ED
	JSR $905E		; B075	$20 $5E $90	cursor sound effect (confirm)
	LDA #$01		; B078	$A9 $01
	STA $A4			; B07A	$85 $A4
L3B07C:
	JSR $B401		; B07C	$20 $01 $B4	wait for vblank (update cursors)
	JSR $B36A		; B07F	$20 $6A $B3
	LDA #$0C		; B082	$A9 $0C
	JSR $972D		; B084	$20 $2D $97	update cursor 3 position
	LDA $25			; B087	$A5 $25
	BEQ L3B095		; B089	$F0 $0A
	JSR $905E		; B08B	$20 $5E $90	cursor sound effect (confirm)
	LDA #$00		; B08E	$A9 $00
	STA $A4			; B090	$85 $A4
	JMP $B062		; B092	$4C $62 $B0
L3B095:
	LDA $24			; B095	$A5 $24
	BEQ L3B07C		; B097	$F0 $E3
	JSR $905E		; B099	$20 $5E $90	cursor sound effect (confirm)
	JSR $B0CB		; B09C	$20 $CB $B0
	LDA $9E			; B09F	$A5 $9E
	AND #$03		; B0A1	$29 $03
	JSR $FA03		; B0A3	$20 $03 $FA	update character equipment
	LDX #$0A		; B0A6	$A2 $0A
	JSR $B451		; B0A8	$20 $51 $B4
	LDA #$23		; B0AB	$A9 $23
	JSR $B3CD		; B0AD	$20 $CD $B3
	LDX #$0C		; B0B0	$A2 $0C
	JSR $B451		; B0B2	$20 $51 $B4
	LDA #$24		; B0B5	$A9 $24
	JSR $B3CD		; B0B7	$20 $CD $B3
	JSR $9523		; B0BA	$20 $23 $95	restore dialogue window variables
	LDA $1C			; B0BD	$A5 $1C
	STA $3E			; B0BF	$85 $3E
	LDA $1D			; B0C1	$A5 $1D
	STA $3F			; B0C3	$85 $3F
	JSR $E7AC		; B0C5	$20 $AC $E7
	JMP $B07C		; B0C8	$4C $7C $B0
	LDX $7AF0		; B0CB	$AE $F0 $7A
	LDA $7A02,X		; B0CE	$BD $02 $7A
	CMP #$0F		; B0D1	$C9 $0F
	BNE L3B101		; B0D3	$D0 $2C
	LDA #$00		; B0D5	$A9 $00
	STA $80			; B0D7	$85 $80
	LDA $79F0		; B0D9	$AD $F0 $79
	LSR			; B0DC	$4A
	LSR			; B0DD	$4A
	TAX			; B0DE	$AA
	LDA $6E			; B0DF	$A5 $6E
	ORA $B199,X		; B0E1	$1D $99 $B1
	TAX			; B0E4	$AA
	LDA $6100,X		; B0E5	$BD $00 $61
	CMP #$10		; B0E8	$C9 $10
	BCS L3B0EF		; B0EA	$B0 $03
	JMP $DE67		; B0EC	$4C $67 $DE	play error sound effect
L3B0EF:
	LDA $79F0		; B0EF	$AD $F0 $79
	LSR			; B0F2	$4A
	LSR			; B0F3	$4A
	TAX			; B0F4	$AA
	LDA $6E			; B0F5	$A5 $6E
	ORA $B199,X		; B0F7	$1D $99 $B1
	TAX			; B0FA	$AA
	LDA $80			; B0FB	$A5 $80
	STA $6100,X		; B0FD	$9D $00 $61
	RTS			; B100	$60
L3B101:
	LDA $7A03,X		; B101	$BD $03 $7A
	TAX			; B104	$AA
	STA $82			; B105	$85 $82
	LDA $6060,X		; B107	$BD $60 $60
	STA $80			; B10A	$85 $80
	BEQ L3B12C		; B10C	$F0 $1E
	LDA $79F0		; B10E	$AD $F0 $79
	LSR			; B111	$4A
	LSR			; B112	$4A
	TAX			; B113	$AA
	CMP #$05		; B114	$C9 $05
	BCS L3B146		; B116	$B0 $2E
	LDA $80			; B118	$A5 $80
	CMP $B1A1,X		; B11A	$DD $A1 $B1
	BCC L3B143		; B11D	$90 $24
	CMP $B1A9,X		; B11F	$DD $A9 $B1
	BCS L3B143		; B122	$B0 $1F
	CPX #$00		; B124	$E0 $00
	BEQ L3B160		; B126	$F0 $38
	CPX #$03		; B128	$E0 $03
	BEQ L3B160		; B12A	$F0 $34
L3B12C:
	LDA $79F0		; B12C	$AD $F0 $79
	LSR			; B12F	$4A
	LSR			; B130	$4A
	TAX			; B131	$AA
	LDA $6E			; B132	$A5 $6E
	ORA $B199,X		; B134	$1D $99 $B1
	TAX			; B137	$AA
	LDA $6100,X		; B138	$BD $00 $61
	LDX $82			; B13B	$A6 $82
	STA $6060,X		; B13D	$9D $60 $60
	JMP $B0EF		; B140	$4C $EF $B0
L3B143:
	JMP $DE67		; B143	$4C $67 $DE	play error sound effect
L3B146:
	LDA $80			; B146	$A5 $80
	CMP #$0E		; B148	$C9 $0E
	BCC L3B143		; B14A	$90 $F7
	CMP #$30		; B14C	$C9 $30
	BCC L3B12C		; B14E	$90 $DC
	BEQ L3B143		; B150	$F0 $F1
	CMP #$70		; B152	$C9 $70
	BCC L3B12C		; B154	$90 $D6
	CMP #$98		; B156	$C9 $98
	BCC L3B143		; B158	$90 $E9
	CMP #$C0		; B15A	$C9 $C0
	BCS L3B143		; B15C	$B0 $E5
	BCC L3B12C		; B15E	$90 $CC
L3B160:
	LDY $6E			; B160	$A4 $6E
	CPX #$00		; B162	$E0 $00
	BNE L3B173		; B164	$D0 $0D
	LDA $611C,Y		; B166	$B9 $1C $61
	STA $10			; B169	$85 $10
	LDA $611D,Y		; B16B	$B9 $1D $61
	STA $11			; B16E	$85 $11
	JMP $B17D		; B170	$4C $7D $B1
L3B173:
	LDA $611D,Y		; B173	$B9 $1D $61
	STA $10			; B176	$85 $10
	LDA $611C,Y		; B178	$B9 $1C $61
	STA $11			; B17B	$85 $11
	LDA $10			; B17D	$A5 $10
	ORA $11			; B17F	$05 $11
	BEQ L3B12C		; B181	$F0 $A9
	LDA $11			; B183	$A5 $11
	BEQ L3B12C		; B185	$F0 $A5
	CMP #$68		; B187	$C9 $68
	BCS L3B196		; B189	$B0 $0B
	LDA $80			; B18B	$A5 $80
	CMP #$68		; B18D	$C9 $68
	BCS L3B196		; B18F	$B0 $05
	JMP $B12C		; B191	$4C $2C $B1
	LDA $10			; B194	$A5 $10
L3B196:
	JMP $B143		; B196	$4C $43 $B1
; End of

; $B199 - data block =
.byte $1C,$19,$1B,$1D,$1A,$1E,$1F,$00	; B199
.byte $31,$70,$8E,$31,$7A,$00,$00,$00	; B1A1
.byte $70,$7A,$98,$70,$8E,$00,$00,$00	; B1A9

; Name	:
; Marks	: stats menu
	JSR $905E		; B1B1	$20 $5E $90	cursor sound effect (confirm)
	JSR $B380		; B1B4	$20 $80 $B3	close menu
	LDA #$00		; B1B7	$A9 $00
	STA $A2			; B1B9	$85 $A2
	STA $A3			; B1BB	$85 $A3
	JSR $B36F		; B1BD	$20 $6F $B3
L3B1C0:
	JSR $B401		; B1C0	$20 $01 $B4	wait for vblank (update cursors)
	LDX $6E			; B1C3	$A6 $6E
	JSR $883D		; B1C5	$20 $3D $88
	JSR $DB5C		; B1C8	$20 $5C $DB	update joypad input
	LDA $24			; B1CB	$A5 $24
	ORA $25			; B1CD	$05 $25
	BEQ L3B1C0		; B1CF	$F0 $EF
	JSR $905E		; B1D1	$20 $5E $90	cursor sound effect (confirm)
	JMP $B380		; B1D4	$4C $80 $B3	close menu
; End of

; Name	:
; Marks	: save menu
	JSR $DA8F		; B1D7	$20 $8F $DA
	LDA #$00		; B1DA	$A9 $00
	STA $A2			; B1DC	$85 $A2
	LDA #$01		; B1DE	$A9 $01
	STA $A3			; B1E0	$85 $A3
	LDA #$00		; B1E2	$A9 $00
	STA $79F0		; B1E4	$8D $F0 $79
	JSR $EE60		; B1E7	$20 $60 $EE
	LDX #$10		; B1EA	$A2 $10
	JSR $B486		; B1EC	$20 $86 $B4
	LDA #$29		; B1EF	$A9 $29
	JSR $B3DF		; B1F1	$20 $DF $B3	load menu text
L3B1F4:
	JSR $B401		; B1F4	$20 $01 $B4	wait for vblank (update cursors)
	JSR $8800		; B1F7	$20 $00 $88	draw portraits
	LDA #$04		; B1FA	$A9 $04
	JSR $96F9		; B1FC	$20 $F9 $96	update cursor 2 position
	LDA $25			; B1FF	$A5 $25
	BEQ L3B207		; B201	$F0 $04		branch if B is button not pressed
	JSR $905E		; B203	$20 $5E $90	cursor sound effect (confirm)
	RTS			; B206	$60
L3B207:
	LDA $24			; B207	$A5 $24
	BEQ L3B1F4		; B209	$F0 $E9
	JSR $905E		; B20B	$20 $5E $90	cursor sound effect (confirm)
	LDA $79F0		; B20E	$AD $F0 $79	cursor position
	LSR			; B211	$4A
	LSR			; B212	$4A
	AND #$03		; B213	$29 $03
	PHA			; B215	$48
	JSR $DAC1		; B216	$20 $C1 $DA
	PLA			; B219	$68
	BCS L3B262		; B21A	$B0 $46
	PHA			; B21C	$48
	JSR $B2C3		; B21D	$20 $C3 $B2
	JSR $B380		; B220	$20 $80 $B3	close menu
	JSR $B2F1		; B223	$20 $F1 $B2	reload menu sprite graphics
	JSR $B396		; B226	$20 $96 $B3
	LDX #$10		; B229	$A2 $10
	JSR $B486		; B22B	$20 $86 $B4
	LDA #$28		; B22E	$A9 $28
	JSR $B3DF		; B230	$20 $DF $B3	load menu text
	LDA #$00		; B233	$A9 $00
	STA $79F0		; B235	$8D $F0 $79
L3B238:
	JSR $B401		; B238	$20 $01 $B4	wait for vblank (update cursors)
	JSR $8800		; B23B	$20 $00 $88	draw portraits
	LDA #$04		; B23E	$A9 $04
	JSR $96F9		; B240	$20 $F9 $96	update cursor 2 position
	LDA $25			; B243	$A5 $25
	BNE L3B2B3		; B245	$D0 $6C
	LDA $24			; B247	$A5 $24
	BEQ L3B238		; B249	$F0 $ED
	LDA $79F0		; B24B	$AD $F0 $79
	BNE L3B2B3		; B24E	$D0 $63
	JSR $905E		; B250	$20 $5E $90	cursor sound effect (confirm)
	PLA			; B253	$68
	PHA			; B254	$48
	JSR $B2C3		; B255	$20 $C3 $B2
	JSR $B380		; B258	$20 $80 $B3	close menu
	JSR $B2F1		; B25B	$20 $F1 $B2	reload menu sprite graphics
	JSR $B396		; B25E	$20 $96 $B3
	PLA			; B261	$68
L3B262:
	STA $80			; B262	$85 $80
	ASL			; B264	$0A
	CLC			; B265	$18
	ADC $80			; B266	$65 $80
	ADC #$63		; B268	$69 $63
	STA $81			; B26A	$85 $81
	LDA #$00		; B26C	$A9 $00
	STA $80			; B26E	$85 $80
	STA $82			; B270	$85 $82
	LDA #$60		; B272	$A9 $60
	STA $83			; B274	$85 $83
	LDY #$00		; B276	$A0 $00
	LDX #$03		; B278	$A2 $03
L3B27A:
	LDA ($82),Y		; B27A	$B1 $82
	STA ($80),Y		; B27C	$91 $80
	INY			; B27E	$C8
	BNE L3B27A		; B27F	$D0 $F9
	INC $81			; B281	$E6 $81
	INC $83			; B283	$E6 $83
	DEX			; B285	$CA
	BNE L3B27A		; B286	$D0 $F2
	JSR $EE60		; B288	$20 $60 $EE
	LDX #$10		; B28B	$A2 $10
	JSR $B486		; B28D	$20 $86 $B4
	LDA #$2A		; B290	$A9 $2A
	JSR $B3DF		; B292	$20 $DF $B3	load menu text
	LDA #$00		; B295	$A9 $00
	STA $A2			; B297	$85 $A2
	STA $A3			; B299	$85 $A3
	LDA #$00		; B29B	$A9 $00
	STA $24			; B29D	$85 $24
	STA $25			; B29F	$85 $25
L3B2A1:
	JSR $B401		; B2A1	$20 $01 $B4	wait for vblank (update cursors)
	JSR $8800		; B2A4	$20 $00 $88	draw portraits
	JSR $DB5C		; B2A7	$20 $5C $DB	update joypad input
	LDA $25			; B2AA	$A5 $25
	ORA $24			; B2AC	$05 $24
	BEQ L3B2A1		; B2AE	$F0 $F1
	JMP $905E		; B2B0	$4C $5E $90	cursor sound effect (confirm)
L3B2B3:
	JSR $905E		; B2B3	$20 $5E $90	cursor sound effect (confirm)
	PLA			; B2B6	$68
	JSR $B2C3		; B2B7	$20 $C3 $B2	copy to save slot
	JSR $B380		; B2BA	$20 $80 $B3	close menu
	JSR $B2F1		; B2BD	$20 $F1 $B2	reload menu sprite graphics
	JMP $B396		; B2C0	$4C $96 $B3
; End of

; Name	:
; Marks	: copy to save slot
	STA $80			; B2C3	$85 $80		get pointer to save slot
	ASL			; B2C5	$0A
	CLC			; B2C6	$18
	ADC $80			; B2C7	$65 $80
	ADC #$63		; B2C9	$69 $63		$6300
	STA $81			; B2CB	$85 $81
	LDA #$00		; B2CD	$A9 $00
	STA $80			; B2CF	$85 $80
	STA $82			; B2D1	$85 $82
	LDA #$60		; B2D3	$A9 $60
	STA $83			; B2D5	$85 $83
	LDY #$00		; B2D7	$A0 $00
L3B2D9:
	LDA ($80),Y		; B2D9	$B1 $80		copy 784 bytes
	TAX			; B2DB	$AA
	LDA ($82),Y		; B2DC	$B1 $82
	STA ($80),Y		; B2DE	$91 $80
	TXA			; B2E0	$8A
	STA ($82),Y		; B2E1	$91 $82
	INY			; B2E3	$C8
	BNE L3B2D9		; B2E4	$D0 $F3
	INC $81			; B2E6	$E6 $81
	INC $83			; B2E8	$E6 $83
	LDA $83			; B2EA	$A5 $83
	CMP #$63		; B2EC	$C9 $63
	BCC L3B2D9		; B2EE	$90 $E9
	RTS			; B2F0	$60
; End of

; Name	:
; Marks	: reload menu sprite graphics
	LDA #$00		; B2F1	$A9 $00
	STA $2001		; B2F3	$8D $01 $20
	JSR $E6FA		; B2F6	$20 $FA $E6	load menu sprite graphics
	JSR $FE00		; B2F9	$20 $00 $FE	wait for vblank
	LDA $FF			; B2FC	$A5 $FF
	STA $2000		; B2FE	$8D $00 $20
	LDA #$00		; B301	$A9 $00
	STA $2005		; B303	$8D $05 $20
	STA $2005		; B306	$8D $05 $20
	LDA #$1E		; B309	$A9 $1E
	STA $2001		; B30B	$8D $01 $20
	LDA #$02		; B30E	$A9 $02
	STA $4014		; B310	$8D $14 $40
	RTS			; B313	$60
; End of


; Name	:
; Marks	:
	LDX #$80		; B314	$A2 $80
L3B316:
	LDA $7A00,X		; B316	$BD $00 $7A
	CLC			; B319	$18
	ADC #$01		; B31A	$69 $01
	STA $7900,X		; B31C	$9D $00 $79
	LDA $7A01,X		; B31F	$BD $01 $7A
	STA $7901,X		; B322	$9D $01 $79
	LDA $7A02,X		; B325	$BD $02 $7A
	STA $7902,X		; B328	$9D $02 $79
	LDA $7A03,X		; B32B	$BD $03 $7A
	STA $7903,X		; B32E	$9D $03 $79
	TXA			; B331	$8A
	SEC			; B332	$38
	SBC #$04		; B333	$E9 $04
	TAX			; B335	$AA
	BCS L3B316		; B336	$B0 $DE
	LDA $7AF1		; B338	$AD $F1 $7A
	STA $79F1		; B33B	$8D $F1 $79
	RTS			; B33E	$60
; End of

; Name	:
; Marks	:
	LDX #$80		; B33F	$A2 $80
L3B341:
	LDA $7A00,X		; B341	$BD $00 $7A
	STA $7800,X		; B344	$9D $00 $78
	LDA $7A01,X		; B347	$BD $01 $7A
	STA $7801,X		; B34A	$9D $01 $78
	LDA $7A02,X		; B34D	$BD $02 $7A
	STA $7802,X		; B350	$9D $02 $78
	LDA $7A03,X		; B353	$BD $03 $7A
	STA $7803,X		; B356	$9D $03 $78
	TXA			; B359	$8A
	SEC			; B35A	$38
	SBC #$04		; B35B	$E9 $04
	TAX			; B35D	$AA
	BCS L3B341		; B35E	$B0 $E1
	LDA $7AF1		; B360	$AD $F1 $7A
	SEC			; B363	$38
	SBC #$04		; B364	$E9 $04
	STA $78F1		; B366	$8D $F1 $78
	RTS			; B369	$60
; End of

; Name	:
; Marks	:
	LDX $6E			; B36A	$A6 $6E
	JMP $8833		; B36C	$4C $33 $88	draw portrait

; Name	:
; Marks	:
	LDX #$0F		; B36F	$A2 $0F
	LDA #$27		; B371	$A9 $27
	JSR $B3C8		; B373	$20 $C8 $B3
	LDX #$0E		; B376	$A2 $0E
	JSR $B486		; B378	$20 $86 $B4
	LDA #$1D		; B37B	$A9 $1D
	JMP $B3DF		; B37D	$4C $DF $B3	load menu text
; End of

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
	LDX #$01		; B3A1	$A2 $01
	LDY #$11		; B3A3	$A0 $11
	STY $9E			; B3A5	$84 $9E
	LDA #$1E		; B3A7	$A9 $1E
	JSR $B3C8		; B3A9	$20 $C8 $B3
	LDX #$02		; B3AC	$A2 $02
	LDY #$12		; B3AE	$A0 $12
	STY $9E			; B3B0	$84 $9E
	LDA #$1E		; B3B2	$A9 $1E
	JSR $B3C8		; B3B4	$20 $C8 $B3
	LDA $62F5		; B3B7	$AD $F5 $62
	BMI L3B3C7		; B3BA	$30 $0B		branch if no 4th character
	LDX #$03		; B3BC	$A2 $03
	LDY #$13		; B3BE	$A0 $13
	STY $9E			; B3C0	$84 $9E
	LDA #$1E		; B3C2	$A9 $1E
	JMP $B3C8		; B3C4	$4C $C8 $B3
L3B3C7:
	RTS			; B3C7	$60
; End of

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
;

;----------------------------------------------------------------------

; Name	:
; Marks	: load menu text (multi-page)
	STA $92			; B3DF	$85 $92
	LDA #$84		; B3E1	$A9 $84		BANK 0A/8400
	STA $95			; B3E3	$85 $95
	LDA #$00		; B3E5	$A9 $00
	STA $94			; B3E7	$85 $94
	LDA #$0A		; B3E9	$A9 $0A
	STA $93			; B3EB	$85 $93
	JMP $EA54		; B3ED	$4C $54 $EA	load text (multi-page)
; End of

; Name	:
; A	: text ID
; Marks	: load menu text (single-page)
	STA text_ID		; B3F0	$85 $92
	LDA #$84		; B3F2	$A9 $84		BANK 0A/8400
	STA $95			; B3F4	$85 $95
	LDA #$00		; B3F6	$A9 $00
	STA text_offset		; B3F8	$85 $94
	LDA #$0A		; B3FA	$A9 $0A		text 2 bank
	STA bank_tmp		; B3FC	$85 $93
	JMP $EA8C		; B3FE	$4C $8C $EA	text process ??
; End of

; Name	:
; Marks	: wait for vblank (update cursors)
L3B401:
	JSR $FE00		; B401	$20 $00 $FE	wait for vblank
	LDA #$02		; B404	$A9 $02
	STA $4014		; B406	$8D $14 $40	copy oam data to ppu
	JSR $C74F		; B409	$20 $4F $C7	update sound
	JSR $C46E		; B40C	$20 $6E $C4	clear oam data
	JSR $9652		; B40F	$20 $52 $96	draw cursor sprite 1
	JSR $9663		; B412	$20 $63 $96	draw cursor sprite 2
	JMP $9674		; B415	$4C $74 $96	draw cursor sprite 3
; End of

; Name	:
; Marks	:
	LDA $79F0		; B418	$AD $F0 $79
	CLC			; B41B	$18
	ADC #$04		; B41C	$69 $04
	CMP $79F1		; B41E	$CD $F1 $79
	BNE L3B401		; B421	$D0 $DE
	JSR $FE00		; B423	$20 $00 $FE	wait for vblank
	LDA #$02		; B426	$A9 $02
	STA $4014		; B428	$8D $14 $40
	JSR $C74F		; B42B	$20 $4F $C7	update sound
	JSR $C46E		; B42E	$20 $6E $C4
	INC $F0			; B431	$E6 $F0
	LDA $F0			; B433	$A5 $F0
	AND #$03		; B435	$29 $03
	ASL			; B437	$0A
	ASL			; B438	$0A
	STA $79F0		; B439	$8D $F0 $79
	CLC			; B43C	$18
	ADC #$04		; B43D	$69 $04
	CMP $79F1		; B43F	$CD $F1 $79
	BEQ L3B447		; B442	$F0 $03
	JSR $9663		; B444	$20 $63 $96
L3B447:
	LDA $79F1		; B447	$AD $F1 $79
	SEC			; B44A	$38
	SBC #$04		; B44B	$E9 $04
	STA $79F0		; B44D	$8D $F0 $79
	RTS			; B450	$60
; End of

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
;	  load menu window position
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
; Marks	: open menu window
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



;----------------------------------------------------------------------



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
;	  game load menu
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
	CMP #$02		; B75B	$C9 $02
	BCS L3B76E		; B75D	$B0 $0F
	LDA $78F0		; B75F	$AD $F0 $78
	CMP #$10		; B762	$C9 $10
	BCS L3B77D		; B764	$B0 $17
	ASL			; B766	$0A
	ASL			; B767	$0A
	ASL			; B768	$0A
	ASL			; B769	$0A
	TAX			; B76A	$AA
	JMP $B791		; B76B	$4C $91 $B7
L3B76E:
	LDA $78F0		; B76E	$AD $F0 $78
	CMP #$10		; B771	$C9 $10
	BCS L3B785		; B773	$B0 $10
	ASL			; B775	$0A
	ASL			; B776	$0A
	ASL			; B777	$0A
	ASL			; B778	$0A
	TAX			; B779	$AA
	JMP $B799		; B77A	$4C $99 $B7
L3B77D:
	LDA $08			; B77D	$A5 $08
	CLC			; B77F	$18
	ADC #$01		; B780	$69 $01
	JMP $B78A		; B782	$4C $8A $B7
L3B785:
	LDA $08			; B785	$A5 $08
	SEC			; B787	$38
	SBC #$01		; B788	$E9 $01
	AND #$07		; B78A	$29 $07
	STA $08			; B78C	$85 $08
	JMP $B7A4		; B78E	$4C $A4 $B7
	LDA $6110,X		; B791	$BD $10 $61
	CLC			; B794	$18
	ADC #$01		; B795	$69 $01
	BNE L3B79F		; B797	$D0 $06
	LDA $6110,X		; B799	$BD $10 $61
	SEC			; B79C	$38
	SBC #$01		; B79D	$E9 $01
L3B79F:
	AND #$07		; B79F	$29 $07
	STA $6110,X		; B7A1	$9D $10 $61
	LDA $78F0		; B7A4	$AD $F0 $78
	CMP #$10		; B7A7	$C9 $10
	BCS L3B7E2		; B7A9	$B0 $37
	LSR			; B7AB	$4A
	LSR			; B7AC	$4A
	ORA #$10		; B7AD	$09 $10
	STA $9E			; B7AF	$85 $9E
	JMP $B7EC		; B7B1	$4C $EC $B7
; End of

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

; $B7CE - data block--- ; ??? menu cursor data
.byte $02,$04,$00,$00		; B7CE
.byte $02,$09,$00,$00           ; B7D2
.byte $02,$0E,$00,$00           ; B7D6
.byte $02,$13,$00,$00           ; B7DA
.byte $02,$19,$00,$00           ; B7DE

; Name	:
; Marks	:
L3B7E2:
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


;----------------------------------------------------------------------



; Name	:
; Marks	: Show Title story ??
;	  prophecy
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


;----------------------------------------------------------------------



; Name	:
; Marks	: end credits
	LDA #$0F		; B9DE	$A9 $0F
	STA $03C1		; B9E0	$8D $C1 $03
	LDA #$0E		; B9E3	$A9 $0E
	STA $57			; B9E5	$85 $57
	LDA #$00		; B9E7	$A9 $00
	STA $7000		; B9E9	$8D $00 $70
L3B9EC:
	JSR $BAE0		; B9EC	$20 $E0 $BA
	JSR $BBFA		; B9EF	$20 $FA $BB
	JSR $BA17		; B9F2	$20 $17 $BA
	INC $7000		; B9F5	$EE $00 $70
	JSR $BC2F		; B9F8	$20 $2F $BC
	JSR $BAE0		; B9FB	$20 $E0 $BA
	JSR $BA17		; B9FE	$20 $17 $BA
	JSR $BBFE		; BA01	$20 $FE $BB
	JSR $BC2F		; BA04	$20 $2F $BC
	INC $7000		; BA07	$EE $00 $70
	LDA $7000		; BA0A	$AD $00 $70
	CMP #$12 		; BA0D	$C9 $12
	BCC L3B9EC		; BA0F	$90 $DB
	JSR $BA17		; BA11	$20 $17 $BA
	JMP $BBE2		; BA14	$4C $E2 $BB
; End of

; Name	:
; Marks	:
	LDA #$E0		; BA17	$A9 $E0
	JSR $BA1E		; BA19	$20 $1E $BA
	LDA #$E0		; BA1C	$A9 $E0
L3BA1E:
	PHA			; BA1E	$48
	JSR $FE00		; BA1F	$20 $00 $FE	wait for vblank
	LDA #$0E		; BA22	$A9 $0E
	STA $57			; BA24	$85 $57
	JSR $C74F		; BA26	$20 $4F $C7	update sound
	PLA			; BA29	$68
	SEC			; BA2A	$38
	SBC #$01		; BA2B	$E9 $01
	BNE L3BA1E		; BA2D	$D0 $EF
	RTS			; BA2F	$60
; End of

; Name	:
; Marks	: draw "THE END"
	JSR $C46E		; BA30	$20 $6E $C4
	JSR $BC68		; BA33	$20 $68 $BC
	JSR $FE00		; BA36	$20 $00 $FE	wait for vblank
	LDA #$02		; BA39	$A9 $02
	STA $4014		; BA3B	$8D $14 $40
	JSR $DC30		; BA3E	$20 $30 $DC	copy color palettes to ppu
	BIT $2002		; BA41	$2C $02 $20
	LDA #$22		; BA44	$A9 $22
	STA $2006		; BA46	$8D $06 $20
	LDA #$52		; BA49	$A9 $52
	STA $2006		; BA4B	$8D $06 $20
	LDX #$00		; BA4E	$A2 $00
L3BA50:
	LDA $BA64,X		; BA50	$BD $64 $BA
	STA $2007		; BA53	$8D $07 $20
	INX			; BA56	$E8
	CPX #$07		; BA57	$E0 $07
	BCC L3BA50		; BA59	$90 $F5
	LDA #$00		; BA5B	$A9 $00
	STA $2005		; BA5D	$8D $05 $20
	STA $2005		; BA60	$8D $05 $20
	RTS			; BA63	$60
; End of

; "THE END"
; $BA64
.byte $14,$08,$05,$00,$05,$0E,$04	; BA64

; Name	:
; Marks	: Used on BANK 0F
	LDA $7000		; BA6B	$AD $00 $70
	LSR			; BA6E	$4A
	TAX			; BA6F	$AA
	LDA #$4C		; BA70	$A9 $4C
	STA $40			; BA72	$85 $40
	LDA #$4A		; BA74	$A9 $4A
	STA $41			; BA76	$85 $41
	LDA $BA9D,X		; BA78	$BD $9D $BA
	STA $80			; BA7B	$85 $80
	LDA $BAA6,X		; BA7D	$BD $A6 $BA
	STA $82			; BA80	$85 $82
	JSR $888F		; BA82	$20 $8F $88
	LDA $26			; BA85	$A5 $26
	SEC			; BA87	$38
	SBC #$30		; BA88	$E9 $30
	TAX			; BA8A	$AA
	LDY #$0C		; BA8B	$A0 $0C
L3BA8D:
	LDA $0202,X		; BA8D	$BD $02 $02
	ORA #$20		; BA90	$09 $20
	STA $0202,X		; BA92	$9D $02 $02
	INX			; BA95	$E8
	INX			; BA96	$E8
	INX			; BA97	$E8
	INX			; BA98	$E8
	DEY			; BA99	$88
	BNE L3BA8D		; BA9A	$D0 $F1
	RTS			; BA9C	$60
; End of

; data block
.byte $02,$00,$01,$01,$01,$02,$00,$00,$01	; BA9D
.byte $00,$0C,$18,$24,$30,$3C,$48,$54,$60	; BAA6

; Name	:
; Marks	:
	LDA #$01		; BAAF	$A9 $01
	STA $37			; BAB1	$85 $37
	LDA #$04		; BAB3	$A9 $04
	STA $38			; BAB5	$85 $38
	SEC			; BAB7	$38
	SBC #$01		; BAB8	$E9 $01
	STA $97			; BABA	$85 $97
	LDA #$04		; BABC	$A9 $04
	STA $39			; BABE	$85 $39
	CLC			; BAC0	$18
	ADC #$02		; BAC1	$69 $02
	STA $98			; BAC3	$85 $98
	LDA #$18		; BAC5	$A9 $18
	STA $3C			; BAC7	$85 $3C
	LDA #$18		; BAC9	$A9 $18
	STA $3D			; BACB	$85 $3D
	LDA #$04		; BACD	$A9 $04
	STA $93			; BACF	$85 $93
	LDA #$00		; BAD1	$A9 $00
	STA $3E			; BAD3	$85 $3E
	LDA #$BC		; BAD5	$A9 $BC		BANK 0E/BC00 (epilogue text)
	STA $3F			; BAD7	$85 $3F
	LDA #$0E		; BAD9	$A9 $0E
	STA $57			; BADB	$85 $57
	JMP $EAAC		; BADD	$4C $AC $EA	load next line of text
; End of

; Name	:
; Marks	:
	LDA #$0F		; BAE0	$A9 $0F
	STA $03C1		; BAE2	$8D $C1 $03
	JSR $FE00		; BAE5	$20 $00 $FE	wait for vblank
	JSR $DC30		; BAE8	$20 $30 $DC	copy color palettes to ppu
	JSR $C74F		; BAEB	$20 $4F $C7	update sound
	JSR $BB2A		; BAEE	$20 $2A $BB
	LDA #$00		; BAF1	$A9 $00
	STA $F0			; BAF3	$85 $F0
L3BAF5:
	JSR $FE00		; BAF5	$20 $00 $FE	wait for vblank
	LDA #$02		; BAF8	$A9 $02 $  
	STA $4014		; BAFA	$8D $14 $40
	JSR $DC30		; BAFD	$20 $30 $DC	copy color palettes to ppu
	JSR $C74F		; BB00	$20 $4F $C7	update sound
	INC $F0			; BB03	$E6 $F0
	LDA $F0			; BB05	$A5 $F0
	AND #$03		; BB07	$29 $03
	BNE L3BAF5		; BB09	$D0 $EA
	LDA $03C1		; BB0B	$AD $C1 $03
	CMP #$0F		; BB0E	$C9 $0F
	BNE L3BB1A		; BB10	$D0 $08
	LDA #$00		; BB12	$A9 $00
	STA $03C1		; BB14	$8D $C1 $03
	JMP $BAF5		; BB17	$4C $F5 $BA
L3BB1A:
	CLC			; BB1A	$18
	ADC #$10		; BB1B	$69 $10
	AND #$30		; BB1D	$29 $30
	STA $03C1		; BB1F	$8D $C1 $03
	BNE L3BAF5		; BB22	$D0 $D1
	LDA #$30		; BB24	$A9 $30
	STA $03C1		; BB26	$8D $C1 $03
	RTS			; BB29	$60
	LDA #$4A		; BB2A	$A9 $4A
	STA $54			; BB2C	$85 $54
	LDA #$22		; BB2E	$A9 $22
	STA $55			; BB30	$85 $55
	LDA $7000		; BB32	$AD $00 $70
	ASL			; BB35	$0A
	TAX			; BB36	$AA
	LDA $BE00,X		; BB37	$BD $00 $BE	pointers to end credits text
	STA $3E			; BB3A	$85 $3E
	LDA $BE01,X		; BB3C	$BD $01 $BE
	STA $3F			; BB3F	$85 $3F
	JSR $FE00		; BB41	$20 $00 $FE	wait for vblank
	BIT $2002		; BB44	$2C $02 $20
	LDA $55			; BB47	$A5 $55
	STA $2006		; BB49	$8D $06 $20
	LDA $54			; BB4C	$A5 $54
	STA $2006		; BB4E	$8D $06 $20
	LDY #$00		; BB51	$A0 $00
	LDX #$0F		; BB53	$A2 $0F
L3BB55:
	LDA ($3E),Y		; BB55	$B1 $3E
	BEQ L3BB63		; BB57	$F0 $0A
	CMP #$FF		; BB59	$C9 $FF
	BEQ L3BB76		; BB5B	$F0 $19
	STA $2007		; BB5D	$8D $07 $20
	INY			; BB60	$C8
	BNE L3BB55		; BB61	$D0 $F2
L3BB63:
	JSR $BB92		; BB63	$20 $92 $BB
	LDA #$00		; BB66	$A9 $00
	STA $2005		; BB68	$8D $05 $20
	STA $2005		; BB6B	$8D $05 $20
	LDA #$0E		; BB6E	$A9 $0E
	STA $57			; BB70	$85 $57
	JMP $C74F		; BB72	$4C $4F $C7	update sound
	RTS			; BB75	$60
L3BB76:
	JSR $BB92		; BB76	$20 $92 $BB
	LDA $54			; BB79	$A5 $54
	CLC			; BB7B	$18
	ADC #$40		; BB7C	$69 $40
	STA $54			; BB7E	$85 $54
	LDA $55			; BB80	$A5 $55
	ADC #$00		; BB82	$69 $00
	STA $55			; BB84	$85 $55
	STA $2006		; BB86	$8D $06 $20
	LDA $54			; BB89	$A5 $54
	STA $2006		; BB8B	$8D $06 $20
	INY			; BB8E	$C8
	JMP $BB55		; BB8F	$4C $55 $BB
; End of

; Name	:
; Marks	:
	LDA #$00		; BB92	$A9 $00
	CPX #$80		; BB94	$E0 $80
	BCS L3BBA0		; BB96	$B0 $08
L3BB98:
	STA $2007		; BB98	$8D $07 $20
	DEX			; BB9B	$CA
	BPL L3BB98		; BB9C	$10 $FA
	LDX #$0F		; BB9E	$A2 $0F
L3BBA0:
	RTS			; BBA0	$60
; End of

; Name	:
; Marks	:
	LDA #$00		; BBA1	$A9 $00
	STA $54			; BBA3	$85 $54
	LDA #$22		; BBA5	$A9 $22
	STA $55			; BBA7	$85 $55
L3BBA9:
	JSR $FE00		; BBA9	$20 $00 $FE	wait for vblank
	BIT $2002		; BBAC	$2C $02 $20
	LDA $55			; BBAF	$A5 $55
	STA $2006		; BBB1	$8D $06 $20
	LDA $54			; BBB4	$A5 $54
	STA $2006		; BBB6	$8D $06 $20
	LDX #$20		; BBB9	$A2 $20
	LDA #$00		; BBBB	$A9 $00
L3BBBD:
	STA $2007		; BBBD	$8D $07 $20
	DEX			; BBC0	$CA
	BNE L3BBBD		; BBC1	$D0 $FA
	STA $2005		; BBC3	$8D $05 $20
	STA $2005		; BBC6	$8D $05 $20
	LDA #$0E		; BBC9	$A9 $0E
	STA $57			; BBCB	$85 $57
	JSR $C74F		; BBCD	$20 $4F $C7	update sound
	LDA $54			; BBD0	$A5 $54
	CLC			; BBD2	$18
	ADC #$20		; BBD3	$69 $20
	STA $54			; BBD5	$85 $54
	LDA $55			; BBD7	$A5 $55
	ADC #$00		; BBD9	$69 $00
	STA $55			; BBDB	$85 $55
	CMP #$23		; BBDD	$C9 $23
	BCC L3BBA9		; BBDF	$90 $C8
	RTS			; BBE1	$60
; End of

; Marks	:
	LDA #$30		; BBE2	$A9 $30
	STA $03C1		; BBE4	$8D $C1 $03
	JSR $BBA1		; BBE7	$20 $A1 $BB
	JSR $BA30		; BBEA	$20 $30 $BA	draw "THE END"
	JSR $FE00		; BBED	$20 $00 $FE	wait for vblank
	LDA #$0E		; BBF0	$A9 $0E
	STA $57			; BBF2	$85 $57
	JSR $C74F		; BBF4	$20 $4F $C7	update sound
	JMP $BBED		; BBF7	$4C $ED $BB
; End of

; Name	:
; Marks	:
	LDA #$00		; BBFA	$A9 $00
	BEQ L3BC00		; BBFC	$F0 $02
; $20
	LDA #$01		; BBFE	$A9 $01
L3BC00:
	STA $10			; BC00	$85 $10
	LDA #$00		; BC02	$A9 $00
	STA $F0			; BC04	$85 $F0
L3BC06:
	JSR $C46E		; BC06	$20 $6E $C4
	LDA $F0			; BC09	$A5 $F0
	LSR			; BC0B	$4A
	EOR $10			; BC0C	$45 $10
	AND #$01		; BC0E	$29 $01
	BEQ L3BC15		; BC10	$F0 $03
	JSR $BA6B		; BC12	$20 $6B $BA
L3BC15:
	JSR $BC68		; BC15	$20 $68 $BC
	JSR $FE00		; BC18	$20 $00 $FE	wait for vblank
	LDA #$02		; BC1B	$A9 $02
	STA $4014		; BC1D	$8D $14 $40
	JSR $DC30		; BC20	$20 $30 $DC	copy color palettes to ppu
	JSR $C74F		; BC23	$20 $4F $C7	update sound
	INC $F0			; BC26	$E6 $F0
	LDA $F0			; BC28	$A5 $F0
	CMP #$20		; BC2A	$C9 $20
	BCC L3BC06		; BC2C	$90 $D8
	RTS			; BC2E	$60
	LDA #$00		; BC2F	$A9 $00
	STA $F0			; BC31	$85 $F0
L3BC33:
	LDA $03C1		; BC33	$AD $C1 $03
	CMP #$F0		; BC36	$C9 $F0
	BNE L3BC3F		; BC38	$D0 $05
	LDA #$0F		; BC3A	$A9 $0F
	STA $03C1		; BC3C	$8D $C1 $03
L3BC3F:
	JSR $FE00		; BC3F	$20 $00 $FE	wait for vblank
	LDA #$02		; BC42	$A9 $02
	STA $4014		; BC44	$8D $14 $40
	JSR $DC30		; BC47	$20 $30 $DC	copy color palettes to ppu
	JSR $C74F		; BC4A	$20 $4F $C7	update sound
	INC $F0			; BC4D	$E6 $F0
	LDA $F0			; BC4F	$A5 $F0
	AND #$03		; BC51	$29 $03
	BNE L3BC33		; BC53	$D0 $DE
	LDA $03C1		; BC55	$AD $C1 $03
	SEC			; BC58	$38
	SBC #$10		; BC59	$E9 $10
	STA $03C1		; BC5B	$8D $C1 $03
	CMP #$FF		; BC5E	$C9 $FF
	BNE L3BC33		; BC60	$D0 $D1
	LDA #$0F		; BC62	$A9 $0F
	STA $03C1		; BC64	$8D $C1 $03
	RTS			; BC67	$60
; End of

; Name	:
; Marks	:
	LDX $26			; BC68	$A6 $26
	LDY #$00		; BC6A	$A0 $00
L3BC6C:
	LDA $BC7B,Y		; BC6C	$B9 $7B $BC
	STA $0200,X		; BC6F	$9D $00 $02
	INX			; BC72	$E8
	INY			; BC73	$C8
	CPY #$2C		; BC74	$C0 $2C
	BNE L3BC6C		; BC76	$D0 $F4
	STX $26			; BC78	$86 $26
	RTS			; BC7A	$60
; End of

; portrait sprite data (end credits)
.byte $57,$8A,$23,$48		; BC7B
.byte $57,$8B,$23,$50		; BC7F
.byte $57,$8C,$23,$58		; BC83
.byte $5F,$8D,$23,$48		; BC87
.byte $5F,$8E,$23,$50		; BC8B
.byte $5F,$8F,$23,$58		; BC8F
.byte $5F,$90,$23,$60		; BC93
.byte $67,$91,$23,$48		; BC97
.byte $67,$92,$23,$50		; BC9B
.byte $67,$93,$23,$58		; BC9F
.byte $67,$94,$23,$60		; BCA3

; Name	:
; Marks	: Used on BANK 0F
	BIT $2002		; BCA7	$2C $02 $20
	LDA #$20		; BCAA	$A9 $20
	STA $2006		; BCAC	$8D $06 $20
	LDA #$00		; BCAF	$A9 $00
	STA $2006		; BCB1	$8D $06 $20
	LDX #$00		; BCB4	$A2 $00
	LDA #$00		; BCB6	$A9 $00
L3BCB8:
	STA $2007		; BCB8	$8D $07 $20
	STA $2007		; BCBB	$8D $07 $20
	STA $2007		; BCBE	$8D $07 $20
	STA $2007		; BCC1	$8D $07 $20
	INX			; BCC4	$E8
	BNE L3BCB8		; BCC5	$D0 $F1
	BIT $2002		; BCC7	$2C $02 $20
	LDA #$08		; BCCA	$A9 $08
	STA $80			; BCCC	$85 $80
	LDA #$21		; BCCE	$A9 $21
	STA $81			; BCD0	$85 $81
	LDA #$08		; BCD2	$A9 $08
	STA $82			; BCD4	$85 $82
	LDX #$06		; BCD6	$A2 $06
	LDY #$00		; BCD8	$A0 $00
L3BCDA:
	LDA $81			; BCDA	$A5 $81
	STA $2006		; BCDC	$8D $06 $20
	LDA $80			; BCDF	$A5 $80
	STA $2006		; BCE1	$8D $06 $20
L3BCE4:
	LDA $BD29,Y		; BCE4	$B9 $29 $BD
	STA $2007		; BCE7	$8D $07 $20
	INY			; BCEA	$C8
	DEX			; BCEB	$CA
	BNE L3BCE4		; BCEC	$D0 $F6
	LDX #$06		; BCEE	$A2 $06
	LDA $80			; BCF0	$A5 $80
	CLC			; BCF2	$18
	ADC #$20		; BCF3	$69 $20
	STA $80			; BCF5	$85 $80
	LDA $81			; BCF7	$A5 $81
	ADC #$00		; BCF9	$69 $00
	STA $81			; BCFB	$85 $81
	DEC $82			; BCFD	$C6 $82
	BNE L3BCDA		; BCFF	$D0 $D9
	LDA #$23		; BD01	$A9 $23
	STA $2006		; BD03	$8D $06 $20
	LDA #$D0		; BD06	$A9 $D0
	STA $2006		; BD08	$8D $06 $20
	LDX #$00		; BD0B	$A2 $00
L3BD0D:
	LDA $BD19,X		; BD0D	$BD $19 $BD
	STA $2007		; BD10	$8D $07 $20
	INX			; BD13	$E8
	CPX #$10		; BD14	$E0 $10
	BCC L3BD0D		; BD16	$90 $F5
	RTS			; BD18	$60
; End of

; ??? attributes
.byte $00,$00,$FF,$33,$00,$00,$00,$00,$00,$00,$AF,$23,$00,$00,$00,$00	; BD19

.byte $3E,$23,$24,$25,$26,$3E,$27,$28,$29,$2A,$2B,$2C,$2D,$28,$28,$28	; BD29
.byte $28,$2E,$2F,$28,$28,$28,$28,$30,$31,$32,$28,$28,$28,$33,$3E,$34	; BD39
.byte $35,$36,$37,$3E,$3E,$38,$39,$3A,$3B,$3E,$3E,$3E,$3C,$3D,$3E,$3E	; BD49


; Marks	:
	LDA #$21		; BD59	$A9 $21
	STA $81			; BD5B	$85 $81
	LDA #$08		; BD5D	$A9 $08
	STA $82			; BD5F	$85 $82
	LDX #$06		; BD61	$A2 $06
	LDY #$00		; BD63	$A0 $00
L3BD65:
	LDA $81			; BD65	$A5 $81
	STA $2006		; BD67	$8D $06 $20
	LDA $80			; BD6A	$A5 $80
	STA $2006		; BD6C	$8D $06 $20
	LDA $BDB4,Y		; BD6F	$B9 $B4 $BD
	STA $2007		; BD72	$8D $07 $20
	INY			; BD75	$C8
	DEX			; BD76	$CA
	BNE L3BD65		; BD77	$D0 $EC
	LDX #$06		; BD79	$A2 $06
	LDA $80			; BD7B	$A5 $80
	CLC			; BD7D	$18
	ADC #$20		; BD7E	$69 $20
	STA $80			; BD80	$85 $80
	LDA $81			; BD82	$A5 $81
	ADC #$00		; BD84	$69 $00
	STA $81			; BD86	$85 $81
	DEC $82			; BD88	$C6 $82
	BNE L3BD65		; BD8A	$D0 $D9
	LDA #$23		; BD8C	$A9 $23
	STA $2006		; BD8E	$8D $06 $20
	LDA #$10		; BD91	$A9 $10
	STA $2006		; BD93	$8D $06 $20
	LDX #$10		; BD96	$A2 $10
L3BD98:
	LDA $BDA4,X		; BD98	$BD $A4 $BD
	STA $2007		; BD9B	$8D $07 $20
	INX			; BD9E	$E8
	CPX #$10		; BD9F	$E0 $10
	BCC L3BD98		; BDA1	$90 $F5
	RTS			; BDA3	$60
; End of

; ??? attributes
.byte $FF,$FF,$FF,$FF,$00,$00,$00,$00,$FA,$FA,$FA,$FA,$00,$00,$00,$00	; BDA4

;
.byte $00,$23,$24,$25,$26,$00,$27,$28,$29,$2A,$2B,$2C,$2D,$28,$28,$28	; BDB4
.byte $28,$2E,$2F,$28,$28,$28,$28,$30,$31,$32,$28,$28,$28,$33,$00,$24	; BDC4
.byte $35,$36,$37,$00,$00,$38,$39,$3A,$3B,$00,$00,$00,$3C,$3D,$00,$00	; BDD4
.byte $3A,$3B,$00,$00,$00,$3C,$3D,$00,$00				; BDE4

; Marks	: stale code (now at 0E/B7E4)
	;JSR $BA9D		; BDED	$-- $9D $BA
	;LDA #$4B		; BDEF	$A9 $4B
	;JMP $BE82		; BDF1	$4C $82 $BE
	;LDA $9E			; BDF4	$A5 $9E
	;AND #$03		; BDF6	$29 $03
	;CLC			; BDF8	$18
	;ADC #$11		; BDF9	$69 $11
	;TAX			; BDFB	$AA
	;JSR $BA9D		; BDFC	$20 $9D $BA
	; BDFF	$01 
; End of stale code
; $BDED-$BDFF
.byte $9D,$BA,$A9
.byte $4B,$4C,$82,$BE,$A5,$9E,$29,$03,$18,$69,$11,$AA,$20,$9D,$BA,$01


; pointers to end credits text
;.byte BE24 BE3B BE52 BE74 BE92 BEAF BECA BEDF	; BE00
;.byte BEFA BF13 BF2A BF47 BF66 BF87 BFA6 BFBC	; BE10
;.byte BFD9 BFF5					; BE20

;; [$BE00 :: 0x3BE00]

.byte $24,$BE,$3B,$BE,$52,$BE,$74,$BE,$92,$BE,$AF,$BE,$CA,$BE,$DF,$BE
.byte $FA,$BE,$13,$BF,$2A,$BF,$47,$BF,$66,$BF,$87,$BF,$A6,$BF,$BC,$BF
.byte $D9,$BF,$F5,$BF

; end credits text

; "PROGRAM\n NASIR GE
.byte $10,$12,$0F,$07,$12,$01,$0D,$FF,$18,$0E,$01,$13,$09,$12,$18,$07	; BE24
.byte $05,$02,$05,$0C,$0C,$09,$00	; BE34

;,$"SCENARIO\n,$KENJI,$TERADA"
.byte $13,$03,$05,$0E,$01,$12,$09,$0F,$FF,$18,$0B,$05,$0E,$0A,$09,$18	; BE3B
.byte $14,$05,$12,$01,$04,$01,$00	; BE4B

;,$"CHARACTER,$DESIGN\n,$YOSHITAKA,$AMANO"
.byte $03,$08,$01,$12,$01,$03,$14,$05,$12,$18,$04,$05,$13,$09,$07,$0E	; BE52
.byte $FF,$18,$19,$0F,$13,$08,$09,$14,$01,$0B,$01,$18,$01,$0D,$01,$0E	; BE62
.byte $0F,$00	; BE72

;,$"GAME,$DESIGN\n,$HIROMICHI,$TANAKA"
.byte $07,$01,$0D,$05,$18,$04,$05,$13,$09,$07,$0E,$FF,$18,$08,$09,$12	; BE74
.byte $0F,$0D,$09,$03,$08,$09,$18,$14,$01,$0E,$01,$0B,$01,$00	; BE84

;,$"GAME,$DESIGN\n,$AKITOSHI,$KAWAZU"
.byte $07,$01,$0D,$05,$18,$04,$05,$13,$09,$07,$0E,$FF,$18,$01,$0B,$09	; BE92
.byte $14,$0F,$13,$08,$09,$18,$0B,$01,$17,$01,$1A,$15,$00	; BEA2

;,$"GAME,$DESIGN\n,$KOUICHI,$ISHII"
.byte $07,$01,$0D,$05,$18,$04,$05,$13,$09,$07,$0E,$FF,$18,$0B,$0F,$15	; BEAF
.byte $09,$03,$08,$09,$18,$09,$13,$08,$09,$09,$00	; BEBF

;,$"PROGRAM\n,$NAOKI,$OKABE"
.byte $10,$12,$0F,$07,$12,$01,$0D,$FF,$18,$0E,$01,$0F,$0B,$09,$18,$0F	; BECA
.byte $0B,$01,$02,$05,$00	; BEDA

;,$"PROGRAM\n,$KATSUHISA,$HIGUCHI"
.byte $10,$12,$0F,$07,$12,$01,$0D,$FF,$18,$0B,$01,$14,$13,$15,$08,$09	; BEDF
.byte $13,$01,$18,$08,$09,$07,$15,$03,$08,$09,$00	; BEEF

;,$"GRAPHICS\n,$KAZUKO,$SHIBUYA"
.byte $07,$12,$01,$10,$08,$09,$03,$13,$FF,$18,$0B,$01,$1A,$15,$0B,$0F	; BEFA
.byte $18,$13,$08,$09,$02,$15,$19,$01,$00	; BF0A

;,$"GRAPHICS\n,$RYOKO,$TANAKA"
.byte $07,$12,$01,$10,$08,$09,$03,$13,$FF,$18,$12,$19,$0F,$0B,$0F,$18	; BF13
.byte $14,$01,$0E,$01,$0B,$01,$00	; BF23

;,$"MUSIC,$COMPOSE\n,$NOBUO,$UEMATSU"
.byte $0D,$15,$13,$09,$03,$18,$03,$0F,$0D,$10,$0F,$13,$05,$FF,$18,$0E	; BF2A
.byte $0F,$02,$15,$0F,$18,$15,$05,$0D,$01,$14,$13,$15,$00	; BF3A

;,$"SOUND,$DESIGN\n,$MASANORI,$HOSHINO"
.byte $13,$0F,$15,$0E,$04,$18,$04,$05,$13,$09,$07,$0E,$FF,$18,$0D,$01	; BF47
.byte $13,$01,$0E,$0F,$12,$09,$18,$08,$0F,$13,$08,$09,$0E,$0F,$00	; BF57

;,$"PROGRAM,$ASSIST\n,$HIROSHI,$NAKAMURA"
.byte $10,$12,$0F,$07,$12,$01,$0D,$18,$01,$13,$13,$09,$13,$14,$FF,$18	; BF66
.byte $08,$09,$12,$0F,$13,$08,$09,$18,$0E,$01,$0B,$01,$0D,$15,$12,$01	; BF76
.byte $00	; BF86

;,$"PROGRAM,$ASSIST\n,$TAKEYOSHI,$ITOH"
.byte $10,$12,$0F,$07,$12,$01,$0D,$18,$01,$13,$13,$09,$13,$14,$FF,$18	; BF87
.byte $14,$01,$0B,$05,$19,$0F,$13,$08,$09,$18,$09,$14,$0F,$08,$00	; BF97

;,$"THANKS,$TO\n,$S.KAJITANI"
.byte $14,$08,$01,$0E,$0B,$13,$18,$14,$0F,$FF,$18,$13,$1C,$0B,$01,$0A	; BFA6
.byte $09,$14,$01,$0E,$09,$00	; BFB6

;,$"DIRECTOR\n,$HIRONOBU,$SAKAGUCHI"
.byte $04,$09,$12,$05,$03,$14,$05,$12,$FF,$18,$08,$09,$12,$0F,$0E,$0F	; BFBC
.byte $02,$15,$18,$13,$01,$0B,$01,$07,$15,$03,$08,$09,$00	; BFCC

;,$"PRODUCER\n,$MASAFUMI,$MIYAMOTO"
.byte $10,$12,$0F,$04,$15,$03,$05,$12,$FF,$18,$0D,$01,$13,$01,$06,$15	; BFD9
.byte $0D,$09,$18,$0D,$09,$19,$01,$0D,$0F,$14,$0F,$00	; BFE9

;,$"\n(C)SQUARE"
.byte $FF,$1D,$03,$1F,$13,$11,$15,$01,$12,$05,$00	; BFF5



; ========== MAP/MENU CODE END($8800-$C000) ==========
