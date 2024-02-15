;; FE06 start - FE03 end <- begin
;; [7FE06-7FE0F] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00
;; [7FE10-7FE19] dummy bytes
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$0

; Name	: Swap_PRG
; A	: Swap bank #$00 0 #$0E
; Marks	: bank switch
;	  Example>
;	  Original bank_0E -> $8000 = bank_1C, $A000 = bank_1D
;	  Set bank_0E(MMC1) to bank_1C, bank_1D (MMC3)
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
