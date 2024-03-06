;; FE06 start - FE03 end <- begin
;; [7FE06-7FE0F] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;; [7FE10-7FE19] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00

; Name	: Swap_PRG
; A	: Swap bank #$00 to #$0E as MMC3
; Marks	: bank switch
;	  Example>
;	  Original bank_0E -> $8000 = bank_1C, $A000 = bank_1D
;	  Set bank_0E(MMC1) to bank_1C, bank_1D (MMC3)
;	  Carry flag must remain intact.
Swap_PRG:
	PHA			; FE1A	$48
	LDA #$06		; FE1B	$A9 $06
	STA $8000		; FE1D	$8D $00 $80
	PLA			; FE20	$68
	ASL A			; FE21	$0A
	PHA			; FE22	$48
	STA $8001		; FE23	$8D $01 $80
	LDA #$07		; FE26	$A9 $07
	STA $8000		; FE28	$8D $00 $80
	PLA			; FE2B	$68
	ORA #$01		; FE2C	$09 $01
	STA $8001		; FE2E	$8D $01 $80
	CMP #$10		; FE31	$C9 $10
	LDA #$00		; FE33	$A9 $00
	RTS			; FE35	$60
; End of Swap_PRG
;; FE2D end - FE2E start -> end



;; FE46 end - FE48 start <- begin
	; PRG RAM enable
	LDA #$80		; FE50	$A9 $80
	STA $A001		; FE52	$8D $01 $A0
	STA $A000		; FE55	$8D $00 $A0
	; IRQ disable
	STA $E000		; FE58	$8D $00 $E0
	; R0,R1,R2,R3,R4,R5 -> 0, 2, 4, 5, 6, 7
	LDY #$00		; FE5B	$A0 $00
L7FE5D:
	STY $8000		; FE5D	$8C $00 $80
	LDA CHR_BANK_ARR,Y	; FE60	$B9 $93 $FE
	STA $8001		; FE63	$8D $01 $80
	INY			; FE66	$C8
	CMP #$07		; FE67	$C9 $07
	BNE L7FE5D		; FE69	$D0 $F2
;; FE70 end - FE79 start -> end


;; FE9E end - FEA1 start <- begin
;;[FE93-FE98]
CHR_BANK_ARR:
.byte $00,$02,$04,$05,$06,$07
;;[FE99-FE9F] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00
;;[FEA0] dummy byte
.byte $00
;; End FE9E - FEA1 start -> end
