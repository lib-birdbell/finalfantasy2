;; FE06 start - FE03 end <- begin
L3FE06:
	LDA #$06		; FE06  $A9 $06
    	JSR Swap_PRG		; FE08  $20 $1A $FE
    	LDA #$40		; FE0B  $A9 $40
    	STA $0100		; FE0D  $8D $00 $01
	; How about go to $C025 ??
    	JMP $C000		; FE10  $4C $00 $C0

;; [7FE13-7FE19] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00

; Name	: Swap_PRG
; A	: Swap bank #$00 0 #$0E
; Marks	: bank switch
;	  Example>
;	  Original bank_0E -> $8000 -> bank28, $A000 -> bank29
;	  Set bank_0E(MMC1) to bank_28, bank_29 (MMC3)
Swap_PRG:
	PHA			; FE1A	$48
	PHA			; FE1B	$48
	LDA #$06		; FE1C	$A9 $06
	STA $8000		; FE1E	$8D $00 $80
	PLA			; FE21	$68
	ASL A			; FE22	$0A
	PHA			; FE23	$48
	STA $8001		; FE24	$8D $01 $80
	LDA #$07		; FE27	$A9 $07
	STA $8000		; FE29	$8D $00 $80
	PLA			; FE2C	$68
	ORA #$01		; FE2D	$09 $01
	STA $8001		; FE2F	$8D $01 $80
	CMP #$10		; FE32	$C9 $10
	PLA			; FE34	$68
	RTS			; FE35	$60
; End of Swap_PRG
;; FE35 end - FE36 start -> end



;; FE46 end - FE48 start <- begin
	; PRG RAM enable
	LDA #$80		; FE50	$A9 $80
	STA $A001		; FE52	$8D $01 $A0
	STA $A000		; FE55	$8D $00 $A0
	; IRQ disable
	STA $E000		; FE58	$8D $00 $E0
	; R0 - 0
	LDA #$00		; FE5B	$A9 $00
	STA $8000		; FE5D	$8D $00 $80
	STA $8001		; FE60	$8D $01 $80
	; R1 - 2
	LDA #$01		; FE63	$A9 $01
	STA $8000		; FE65	$8D $00 $80
	ASL A			; FE68	$0A
	STA $8001		; FE69	$8D $01 $80
	; R2, R3, R4, R5 -> 4, 5, 6, 7
L3FE6C:
	STA $8000		; FE6C	$8D $00 $80
	ADC #$02		; FE6F	$69 $02
	STA $8001		; FE71	$8D $01 $80
	SBC #$00		; FE74	$E9 $00
	CMP #$06		; FE76	$C9 $06
	BNE L3FE6C		; FE78	$D0 $FE
;; FE70 end - FE79 start -> end



;; FE94 start - FEBF end <- begin
	JMP L3FE06		; FE95	$4C $06 $FE

;; [7FE98-7FEA0] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00,$00
.byte $00
;; End FE9E - FEA1 start -> end
