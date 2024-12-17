.include "Constants.inc"
.include "variables.inc"

.import Init_Page2		;C46E
.import Get_key			;DBA9
.import Palette_copy		;DC30
.import Init_CHR_RAM		;E491		
.import	Init_icon_tiles		;E6E1
.import Clear_Nametable0	;F321
.import Wait_NMI		;FE00

.segment "BANK_1E"


; to do - key press process is too fast - OK
; to do - cursor are not visible
; to do - sound effect

; music test code

; 05BA00h-05Bfffh : 1.5K - sound effect code/data
; 0B9306h-0B934Fh : 49B - battle song
; 0D9800h-0DBEFFh : 9.75K - music code/data

;; [$8000 :: 0x78000] Music code
; Name	: Sound_test
; Marks	:
Sound_test:
	JMP Sound_test_		; 8000	$4C 

; Name	:
; Marks	:
Sound_test_:
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
	;JSR Init_CHR_RAM	; B89F $20 $91 $E4
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
; load tiles
	LDA PpuStatus_2002	; ????  $A9 $02 $20
	LDA #$00		; hide sprites/background
	STA PpuMask_2001	; ????  $8D $01 $20
	JSR Clear_Nametable0	;
	LDA #$6C
	STA oam_y
	LDA #$78
	STA oam_x
	LDA #$84
	STA $82
	LDX #$00
	JSR Set_OAM
	LDA oam_x
	CLC
	ADC #$08
	STA oam_x
	INX
	INX
	INX
	INX
	LDA #$81
	STA $82
	JSR Set_OAM
	LDA oam_y
	CLC
	ADC #$10
	STA oam_y
	LDA oam_x
	SEC
	SBC #$08
	STA oam_x
	INX
	INX
	INX
	INX
	LDA #$80
	STA $82
	JSR Set_OAM
	LDA oam_x
	CLC
	ADC #$08
	STA oam_x
	INX
	INX
	INX
	INX
	JSR Set_OAM
	JSR Wait_NMI
	LDA #$02		; ????  $A9 $02		copy OAM buffer(200h) to PPU
	STA SpriteDma_4014	; C04B  $8D $14 $40
	LDA #$1A		; Set palettes
	STA $03C1
	LDA #$10
	STA $03C2
	LDA #$30
	STA $03C3
	LDA #$16
	STA $03DD
	LDA #$26
	STA $03DE
	LDA #$39
	STA $03DF
	JSR Palette_copy	; C04E  $20 $30 $DC
	LDA #$08		; Copy sprites
	STA $81
	LDA #$00
	STA $00
	LDX #$00
	LDA $81
	STA PpuAddr_2006
	LDA $80
	STA PpuAddr_2006
COPY_SPRITE:
	LDA PpuData_2007
	STA $0400,X
	INX
	BNE COPY_SPRITE
	LDA #$18; Set sprites
	STA $81
	LDA #$00
	STA $00
	LDX #$00
	LDA $81
	STA PpuAddr_2006
	LDA $80
	STA PpuAddr_2006
SET_SPRITE:
	LDA $0400,X
	STA PpuData_2007
	INX
	BNE SET_SPRITE
	LDA #$18		; Show sprites/background
	STA PpuMask_2001	; ????  $8D $01 $20
	LDA #$41
	STA $82
	JSR Cursor_init
	LDA #$68
	STA oam_y
MAIN_LOOP:
	JSR Wait_NMI
	LDA #$02		; 811A  $A9 $02		copy OAM buffer(200h) to PPU
	STA SpriteDma_4014	; 811C  $8D $14 $40
	LDA #$00		; ????  $A9 $00
	STA PpuScroll_2005	; ????  $8D $05 $20
	STA PpuScroll_2005	; ????  $8D $05 $20
	JSR Sound_proc		; 80C3	$20 $A9 $DB
; bank 0E test code
	;LDA #$1E
	;STA bank
	;JSR $C74F		; 80C3	$20 $4F $C7
; end of bank 0E test code
	JSR Get_key
	LDA key1p
	BNE Key_proc
	JMP MAIN_LOOP		; LOOP
Key_proc:
	AND #$01		; Right key
	BEQ Key_proc_L
	LDA oam_y
	CMP #$68
	BNE EFFECT_PROC_R
	LDA $82
	CLC
	ADC #$01
	STA $82
	JSR Set_OAM_AS_BGM
EFFECT_PROC_R:
Key_proc_L:
	LDA key1p
	AND #$02
	BEQ Key_proc_D
	LDA oam_y
	CMP #$68
	BNE EFFECT_PROC_L
	LDA $82
	SEC
	SBC #$01
	STA $82
	JSR Set_OAM_AS_BGM
EFFECT_PROC_L:
Key_proc_D:
	LDA key1p
	AND #$04
	BEQ Key_proc_U
	LDA oam_y
	CLC
	ADC #$10
	CMP #$80
	BCC Key_D
	LDA #$68
Key_D:
	STA oam_y
	JSR Cursor_set
	LDA oam_y
	SEC
	SBC #$10
	STA oam_y
Key_proc_U:
	LDA key1p
	AND #$08
	BEQ Key_proc_A
	LDA oam_y
	SEC
	SBC #$10
	CMP #$60
	BCS Key_U
	LDA #$78
Key_U:
	STA oam_y
	JSR Cursor_set
	LDA oam_y
	SEC
	SBC #$10
	STA oam_y
Key_proc_A:
	LDA key1p
	AND #$80
	BEQ Key_proc_B
	LDA oam_y
	CMP #$68
	BNE PROC_A_EFFECT
	LDA $82
	STA current_song_ID
PROC_A_EFFECT:
Key_proc_B:
	LDA key1p
	AND #$40
	BEQ TO_MAIN_LOOP
	LDA #$00
	STA current_song_ID
TO_MAIN_LOOP:
	LDA key1p
	STA $21
WAIT_KEY_REL:
	JSR Wait_NMI
	LDA #$02		; ????  $A9 $02		copy OAM buffer(200h) to PPU
	STA SpriteDma_4014	; ????  $8D $14 $40
	LDA #$00		; ????  $A9 $00
	STA PpuScroll_2005	; ????  $8D $05 $20
	STA PpuScroll_2005	; ????  $8D $05 $20
	JSR Sound_proc		; ????	$20 $A9 $DB
	JSR Get_key
	LDA key1p
	CMP $21
	BEQ WAIT_KEY_REL
	JMP MAIN_LOOP		; LOOP

; Name	: Set_OAM
; X	: OAM number
; Marks	:
Set_OAM:
	LDA oam_y
	STA $0210,X		; Y
	LDA $82
	STA $0211,X		; INDEX
	LDA #$03
	STA $0212,X		; ATTR
	LDA oam_x
	STA $0213,X		; X
	RTS
; End of Set_OAM

; Name	:
; Marks	:
Set_OAM_AS_BGM:
	LDA $82
	LSR A
	LSR A
	LSR A
	LSR A
	ORA #$80
	STA $0211		; BGM left
	LDA $82
	AND #$0F
	ORA #$80
	STA $0215		; BGM right
	RTS
; End of Set_OAM_AS_BGM

; Name	:
; Marks	:
Set_OAM_AS_EFFECT:
	LDA $83
	LSR A
	LSR A
	LSR A
	LSR A
	ORA #$80
	STA $0219		; BGM left
	LDA $83
	AND #$0F
	ORA #$80
	STA $021D		; BGM right
	RTS
; End of Set_OAM_AS_EFFECT

; Name	: Cursor_init
; Marks	: cursor sprite in $0200-$020F
Cursor_init:
	LDA #$68
	STA oam_y
Cursor_set:
	LDX #$0C
	LDA #$60
	STA oam_x
	LDA #$FC
	STA $80
Cursor_loop:
	LDA oam_y
	STA $0200,X		; Y
	LDA oam_x
	STA $0203,X		; X
	LDA $80
	STA $0201,X		; INDEX
	CLC
	ADC #$01
	STA $80
	LDA #$03
	STA $0202,X		; ATTR
	LDA oam_x
	CLC
	ADC #$08
	STA oam_x
	AND #$08
	BNE SKIP_INY
	LDA oam_x
	SEC
	SBC #$10
	STA oam_x
	LDA oam_y
	CLC
	ADC #$08
	STA oam_y
SKIP_INY:
	TXA
	SEC
	SBC #$04
	TAX
	BPL Cursor_loop
	RTS
; End of Cursor_init

; ------------------------------------------------------------

; Name	:
; Marks	: Sound ??
Sound_proc:
	LDA #$00		; 9800	$A9 $00		$826F
	STA $C0			; 9802	$85 $C0
	STA $C1			; 9804	$85 $C1
	STA $C2			; 9806	$85 $C2
	LDA $E5			; 9808	$A5 $E5
	BEQ L3581A		; 980A	$F0 $0E
	DEC $E5			; 980C	$C6 $E5
	BNE L3581A		; 980E	$D0 $0A
	LDA #$30		; 9810	$A9 $30
	STA Sq1Duty_4004	; 9812	$8D $04 $40
	LDA #$00		; 9815	$A9 $00
	STA SQ2_Note_Value	; 9817	$8D $1F $6F
L3581A:
	LDA $E0			; 981A	$A5 $E0
	ASL A			; 981C	$0A
	BCC L35832		; 981D	$90 $13
	JSR J98A9		; 981F	$20 $A9 $98	$828E
	LDA #$00		; 9822	$A9 $00
	STA $E0			; 9824	$85 $E0
	STA $6F1B		; 9826	$8D $1B $6F
	STA $6F1F		; 9829	$8D $1F $6F
	STA $6F23		; 982C	$8D $23 $6F
	JMP L35863		; 982F	$4C $63 $98
L35832:
	ASL A			; 9832	$0A		$82A1
	BCC L35863		; 9833	$90 $2E
	LDA current_song_ID	; 9835	$A5 $E0
	AND #$3F		; 9837	$29 $3F
	STA current_song_ID	; 9839	$85 $E0
	CMP current_BGM_ID	; 983B	$CD $25 $6F
	BEQ L35847		; 983E	$F0 $07
	JSR J988E		; 9840	$20 $8E $98
	JSR J9867		; 9843	$20 $67 $98
	RTS			; 9846	$60
; End of

L35847:
.byte $C9,$09,$F0,$F8,$A9,$30,$8D,$00,$40
.byte $8D,$04,$40,$A9,$80,$8D,$08,$40,$A9,$00,$8D,$1B,$6F,$8D,$1F,$6F
.byte $8D,$23,$6F
L35863:
	JSR J990E		; 9863	$20 $0E $99	$8191
	RTS			; 9866	$60
; End of

; Name	:
; Marks	:
J9867:
	LDA $E0			; 9867	$A5 $E0
	STA $6F25		; 9869	$8D $25 $6F
	ASL A			; 986C	$0A
	TAX			; 986D	$AA
	LDA D9E0D,X		; 986E	$BD $0D $9E
	STA $C8			; 9871	$85 $C8
	LDA D9E0E,X		; 9873	$BD $0E $9E
	STA $C9			; 9876	$85 $C9
	LDY #$00		; 9878	$A0 $00
	LDX #$00		; 987A	$A2 $00
L3587C:
	LDA ($C8),Y		; 987C	$B1 $C8
	STA $B0,X		; 987E	$95 $B0
	INY			; 9880	$C8
	INX			; 9881	$E8
	CPX #$06		; 9882	$E0 $06
	BCC L3587C		; 9884	$90 $F6
	JSR J98C4		; 9886	$20 $C4 $98
	LDA #$00		; 9889	$A9 $00
	STA $E6			; 988B	$85 $E6
	RTS			; 988D	$60
; End of

; Name	:
; Marks	:
J988E:
	LDX #$00		; 988E	$A2 $00
L35890:
	LDA SQ1FramePosition,X	; 9890	$B5 $B0
	STA $6F26,X		; 9892	$9D $26 $6F
	INX			; 9895	$E8
	CPX #$12		; 9896	$E0 $12
	BCC L35890		; 9898	$90 $F6
	LDY #$00		; 989A	$A0 $00
L3589C:
	LDA song_tempo,Y	; 989C	$B9 $00 $6F
	STA $6F26,X		; 989F	$9D $26 $6F
	INX			; 98A2	$E8
	INY			; 98A3	$C8
	CPY #$26		; 98A4	$C0 $26
	BCC L3589C		; 98A6	$90 $F4
	RTS			; 98A8	$60
; End of

J98A9:
	LDX #$00		; 98A9	$A2 $00
L358AB:
	LDA $6F26,X		; 98AB	$BD $26 $6F	$81DA
	STA $B0,X		; 98AE	$95 $B0
	INX			; 98B0	$E8
	CPX #$12		; 98B1	$E0 $12
	BCC L358AB		; 98B3	$90 $F6
	LDY #$00		; 98B5	$A0 $00
L358B7:
	LDA $6F26,X		; 98B7	$BD $26 $6F
	STA $6F00,Y		; 98BA	$99 $00 $6F
	INX			; 98BD	$E8
	INY			; 98BE	$C8
	CPY #$26		; 98BF	$C0 $26
	BCC L358B7		; 98C1	$90 $F4
	RTS			; 98C3	$60
; End of

; Name	:
; Marks	:
J98C4:
	LDX #$00		; 98C4	$A2 $00
	LDA #$FF		; 98C6	$A9 $FF
L358C8:
	STA $B6,X		; 98C8	$95 $B6
	INX			; 98CA	$E8
	CPX #$04		; 98CB	$E0 $04
	BCC L358C8		; 98CD	$90 $F9
	LDX #$00		; 98CF	$A2 $00
L358D1:
	STA $BA,X		; 98D1	$95 $BA
	INX			; 98D3	$E8
	CPX #$06		; 98D4	$E0 $06
	BCC L358D1		; 98D6	$90 $F9
	LDX #$00		; 98D8	$A2 $00
	LDA #$00		; 98DA	$A9 $00
L358DC:
	STA $6F06,X		; 98DC	$9D $06 $6F
	INX			; 98DF	$E8
	CPX #$04		; 98E0	$E0 $04
	BCC L358DC		; 98E2	$90 $F8
	LDA #$0F		; 98E4	$A9 $0F
	STA Sq0Vol		; 98E6	$8D $04 $6F
	STA Sq1Vol		; 98E9	$8D $05 $6F
	LDA #$4B		; 98EC	$A9 $4B
	STA song_tempo		; 98EE	$8D $00 $6F
	LDX #$00		; 98F1	$A2 $00
	STX ApuStatus_4015	; 98F3	$8E $15 $40
L358F6:
	LDA D9902,X		; 98F6	$BD $02 $99
	STA $6F19,X		; 98F9	$9D $19 $6F
	INX			; 98FC	$E8
	CPX #$0C		; 98FD	$E0 $0C
	BCC L358F6		; 98FF	$90 $F5
	RTS			; 9901	$60
; End of

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
	JSR Init_Page2		; B923 $20 $6E $C4
	JSR Wait_NMI		; B926 $20 $00 $FE
	JSR Wait_NMI		; B929 $20 $00 $FE
	LDA #$02		; B92C $A9 $02
	STA SpriteDma_4014	; B92E $8D $14 $40
	RTS			; B931 $60
; End of NT0_OAM_init

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

;; [$9902 :: 0x35902]
; data
D9902:
.byte $30,$08,$00,$00,$30,$08,$00,$00,$80,$00,$00,$00

; Name	:
; Marks	: ??
J990E:
	LDA $6F00		; 990E	$AD $00 $6F	$823C
	CLC			; 9911	$18
	ADC $6F06		; 9912	$6D $06 $6F
	STA $6F06		; 9915	$8D $06 $6F
J9918:
	LDA $6F06		; 9918	$AD $06 $6F
	CMP #$4B		; 991B	$C9 $4B
	BCC L3592A		; 991D	$90 $0B
	SBC #$4B		; 991F	$E9 $4B
	STA $6F06		; 9921	$8D $06 $6F
	JSR J9931		; 9924	$20 $31 $99
	JMP J9918		; 9927	$4C $18 $99	$8255
L3592A:
	JSR J9B22		; 992A	$20 $22 $9B	$8258
	JSR J9C1F		; 992D	$20 $1F $9C	$825B
	RTS			; 9930	$60
; End of

; Name	:
; Marks	:
J9931:
	LDA #$00		; 9931	$A9 $00
	STA $C5			; 9933	$85 $C5
L35935:
	LDA $C5			; 9935	$A5 $C5
	TAY			; 9937	$A8
	ASL A			; 9938	$0A
	STA $C6			; 9939	$85 $C6
	TAX			; 993B	$AA
	ASL A			; 993C	$0A
	STA $C7			; 993D	$85 $C7
	LDA $B0,X		; 993F	$B5 $B0
	STA $C3			; 9941	$85 $C3
	LDA $B1,X		; 9943	$B5 $B1
	STA $C4			; 9945	$85 $C4
	CMP #$FF		; 9947	$C9 $FF
	BEQ L35968		; 9949	$F0 $1D
	LDA $6F07,Y		; 994B	$B9 $07 $6F
	BNE L35963		; 994E	$D0 $13
	LDY #$00		; 9950	$A0 $00
	JSR J9971		; 9952	$20 $71 $99	$827E
	LDX $C6			; 9955	$A6 $C6
	TYA			; 9957	$98
	CLC			; 9958	$18
	ADC $C3			; 9959	$65 $C3
	STA $B0,X		; 995B	$95 $B0		////debug
	LDA #$00		; 995D	$A9 $00
	ADC $C4			; 995F	$65 $C4
	STA $B1,X		; 9961	$95 $B1
L35963:
	LDX $C5			; 9963	$A6 $C5
	DEC $6F07,X		; 9965	$DE $07 $6F
L35968:
	INC $C5			; 9968	$E6 $C5
	LDA $C5			; 996A	$A5 $C5
	CMP #$03		; 996C	$C9 $03
	BCC L35935		; 996E	$90 $C5
	RTS			; 9970	$60
; End of
J9971:
	LDA ($C3),Y		; 9971	$B1 $C3		$8426
	INY			; 9973	$C8
	CMP #$E0		; 9974	$C9 $E0
	BCS L3597C		; 9976	$B0 $04
	JSR J99C8		; 9978	$20 $C8 $99
	RTS			; 997B	$60
; Enf of
L3597C:
	BNE L35984		; 997C	$D0 $06
	JSR J9A4C		; 997E	$20 $4C $9A
	JMP J9971		; 9981	$4C $71 $99
L35984:
	CMP #$F0		; 9984	$C9 $F0
	BCS L3598E		; 9986	$B0 $06
	JSR J9A53		; 9988	$20 $53 $9A	if A<F0h
	JMP J9971		; 998B	$4C $71 $99
L3598E:
	CMP #$F6		; 998E	$C9 $F6
	BCS L35998		; 9990	$B0 $06
	JSR J9A5B		; 9992	$20 $5B $9A
L35995:
	JMP J9971		; 9995	$4C $71 $99
L35998:
	BNE L359A0		; 9998	$D0 $06
	JSR J9A63		; 999A	$20 $63 $9A	if A==F6h
	JMP J9971		; 999D	$4C $71 $99	$8452
L359A0:
	CMP #$FC		; 99A0	$C9 $FC
	BCS L359AA		; 99A2	$B0 $06
	JSR J9A82		; 99A4	$20 $82 $9A
	JMP J9971		; 99A7	$4C $71 $99
L359AA:
	BNE L359B2		; 99AA	$D0 $06
	JSR J9A95		; 99AC	$20 $95 $9A
	JMP J9971		; 99AF	$4C $71 $99
L359B2:
	CMP #$FE		; 99B2	$C9 $FE		$8467
	BCS L359BC		; 99B4	$B0 $06
	JSR J9AB1		; 99B6	$20 $B1 $9A
	JMP J9971		; 99B9	$4C $71 $99
L359BC:
	BNE L359C4		; 99BC	$D0 $06
	JSR J9ACE		; 99BE	$20 $CE $9A
	JMP J9971		; 99C1	$4C $71 $99
L359C4:
	JSR J9ADF		; 99C4	$20 $DF $9A
	RTS			; 99C7	$60
; End of
J99C8:
	STA $C8			; 99C8	$85 $C8
	AND #$0F		; 99CA	$29 $0F
	TAX			; 99CC	$AA
	LDA D9CFD,X		; 99CD	$BD $FD $9C
	LDX $C5			; 99D0	$A6 $C5
	STA $6F07,X		; 99D2	$9D $07 $6F
	LDA $C8			; 99D5	$A5 $C8
	CMP #$D0		; 99D7	$C9 $D0
	BCC L359DC		; 99D9	$90 $01
	RTS			; 99DB	$60
; End of
L359DC:
	CMP #$C0		; 99DC	$C9 $C0
	BCC L359FE		; 99DE	$90 $1E
	LDA #$01		; 99E0	$A9 $01
	STA $C0,X		; 99E2	$95 $C0
	LDX $C7			; 99E4	$A6 $C7
	LDA #$00		; 99E6	$A9 $00
	STA $6F1B,X		; 99E8	$9D $1B $6F
	CPX #$08		; 99EB	$E0 $08
	BEQ L359F8		; 99ED	$F0 $09
	LDA $6F19,X		; 99EF	$BD $19 $6F
	AND #$F0		; 99F2	$29 $F0
	STA $6F19,X		; 99F4	$9D $19 $6F
	RTS			; 99F7	$60
;End of

L359F8:
.byte $A9,$80,$8D,$21,$6F,$60
L359FE:
	CPX #$02		; 99FE	$E0 $02
	BNE L35A07		; 9A00	$D0 $05
	LDA #$FF		; 9A02	$A9 $FF
	STA $6F21		; 9A04	$8D $21 $6F
L35A07:
	LDA #$00		; 9A07	$A9 $00
	STA $6F13,X		; 9A09	$9D $13 $6F
	STA $6F0A,X		; 9A0C	$9D $0A $6F
	STA $6F16,X		; 9A0F	$9D $16 $6F
	STA $6F0D,X		; 9A12	$9D $0D $6F
	LDA #$0F		; 9A15	$A9 $0F
	STA $C0,X		; 9A17	$95 $C0
	LDA $6F01,X		; 9A19	$BD $01 $6F
	ASL A			; 9A1C	$0A
	ASL A			; 9A1D	$0A
	ASL A			; 9A1E	$0A
	STA $C9			; 9A1F	$85 $C9
	LDA $6F01,X		; 9A21	$BD $01 $6F
	ASL A			; 9A24	$0A
	ASL A			; 9A25	$0A
	ADC $C9			; 9A26	$65 $C9
	STA $C9			; 9A28	$85 $C9
	LDA $C8			; 9A2A	$A5 $C8
	LSR A			; 9A2C	$4A
	LSR A			; 9A2D	$4A
	LSR A			; 9A2E	$4A
	LSR A			; 9A2F	$4A
	CLC			; 9A30	$18
	ADC $C9			; 9A31	$65 $C9
	ASL A			; 9A33	$0A
	TAX			; 9A34	$AA
	LDA D9C6D,X		; 9A35	$BD $6D $9C
	STA $C8			; 9A38	$85 $C8
	LDA D9C6E,X		; 9A3A	$BD $6E $9C
	STA $C9			; 9A3D	$85 $C9
	LDX $C7			; 9A3F	$A6 $C7
	LDA $C8			; 9A41	$A5 $C8
	STA $6F1B,X		; 9A43	$9D $1B $6F
	LDA $C9			; 9A46	$A5 $C9
	STA $6F1C,X		; 9A48	$9D $1C $6F
	RTS			; 9A4B	$60
; End of
J9A4C:
	LDA ($C3),Y		; 9A4C	$B1 $C3
	INY			; 9A4E	$C8
	STA $6F00		; 9A4F	$8D $00 $6F
	RTS			; 9A52	$60
; End of
J9A53:
	AND #$0F		; 9A53	$29 $0F
	LDX $C5			; 9A55	$A6 $C5
	STA $6F04,X		; 9A57	$9D $04 $6F
	RTS			; 9A5A	$60
; End of
J9A5B:
	AND #$0F		; 9A5B	$29 $0F
	LDX $C5			; 9A5D	$A6 $C5
	STA $6F01,X		; 9A5F	$9D $01 $6F
	RTS			; 9A60	$60
; End of
J9A63:
	LDA ($C3),Y		; 9A63	$B1 $C3
	INY			; 9A65	$C8
	LDX $C7			; 9A66	$A6 $C7
	STA $6F19,X		; 9A68	$9D $19 $6F
	LDX $C6			; 9A6B	$A6 $C6
	LDA ($C3),Y		; 9A6D	$B1 $C3
	INY			; 9A6F	$C8
	STA $B6,X		; 9A70	$95 $B6
	LDA($C3),Y		; 9A72	$B1 $C3
	INY			; 9A74	$C8
	STA $B7,X		; 9A75	$95 $B7
	LDA ($C3),Y		; 9A77	$B1 $C3
	INY			; 9A79	$C8
	STA $BA,X		; 9A7A	$95 $BA
	LDA ($C3),Y		; 9A7C	$B1 $C3
	INY			; 9A7E	$C8
	STA $BB,X		; 9A7F	$95 $BB
	RTS			; 9A81	$60
; End of
J9A82:
.byte $A6,$C5,$C9,$F8,$90,$06,$E9,$F6,$9D,$10,$6F,$60,$B1,$C3
.byte $C8,$9D,$10,$6F,$60
J9A95:
.byte $B1,$C3,$C8,$85,$C8,$B1,$C3,$C8,$85,$C9,$A6
.byte $C5,$DE,$10,$6F,$F0,$0A,$A5,$C8,$85,$C3,$A5,$C9,$85,$C4,$A0,$00
.byte $60
J9AB1:
.byte $B1,$C3,$C8,$85,$C8,$B1,$C3,$C8,$85,$C9,$A6,$C5,$BD,$10,$6F
.byte $4A,$90,$0A,$A5,$C8,$85,$C3,$A5,$C9,$85,$C4,$A0,$00,$60
; Name	:
; Marks	:
J9ACE:
	LDA ($C3),Y		; 9ACE	$B1 $C3
	INY			; 9AD0	$C8
	STA $C8			; 9AD1	$85 $C8
	LDA ($C3),Y		; 9AD3	$B1 $C3
	INY			; 9AD5	$C8
	STA $C4			; 9AD6	$85 $C4
	LDA $C8			; 9AD8	$A5 $C8
	STA $C3			; 9ADA	$85 $C3
	LDY #$00		; 9ADC	$A0 $00
	RTS			; 9ADE	$60
; End of

; Name	:
; Marks	:
J9ADF:
	LDX $C6			; 9ADF	$A6 $C6
	LDA #$FF		; 9AE1	$A9 $FF
	STA $B6,X		; 9AE3	$95 $B6
	STA $B7,X		; 9AE5	$95 $B7
	STA $BA,X		; 9AE7	$95 $BA
	STA $BB,X		; 9AE9	$95 $BB
	STA $B0,X		; 9AEB	$95 $B0
	STA $B1,X		; 9AED	$95 $B1
	STA $C3			; 9AEF	$85 $C3
	STA $C4			; 9AF1	$85 $C4
	LDY #$00		; 9AF3	$A0 $00
	LDX $C5			; 9AF5	$A6 $C5
	LDA #$01		; 9AF7	$A9 $01
	STA $C0,X		; 9AF9	$95 $C0
	LDX $C7			; 9AFB	$A6 $C7
	LDA #$00		; 9AFD	$A9 $00
	STA $6F1B,X		; 9AFF	$9D $1B $6F
	CPX #$08		; 9B02	$E0 $08
	BEQ L35B0B		; 9B04	$F0 $05
	LDA #$F0		; 9B06	$A9 $F0
	JMP J9B0D		; 9B08	$4C $0D $9B
; End of
L35B0B:
	LDA #$00		; 9B0B	$A9 $00
J9B0D:
	STA $6F19,X		; 9B0D	$9D $19 $6F
	LDA #$FF		; 9B10	$A9 $FF
	LDX #$00		; 9B12	$A2 $00
L35B14:
	CMP $B0,X		; 9B14	$D5 $B0
	BNE L35B21		; 9B16	$D0 $09
	INX			; 9B18	$E8
	CPX #$06		; 9B19	$E0 $06
	BCC L35B14		; 9B1B	$90 $F7
	LDA #$80		; 9B1D	$A9 $80
	STA $E0			; 9B1F	$85 $E0
L35B21:
	RTS			; 9B21	$60
; End of

; Name	:
; Marks	:
J9B22:
	LDA #$00		; 9B22	$A9 $00		$8450
	STA $C5			; 9B24	$85 $C5
L35B26:
	LDA $C5			; 9B26	$A5 $C5
	ASL A			; 9B28	$0A
	STA $C6			; 9B29	$85 $C6
	TAX			; 9B2B	$AA
	ASL A			; 9B2C	$0A
	STA $C7			; 9B2D	$85 $C7
	TAY			; 9B2F	$A8
	LDA $6F1B,Y		; 9B30	$B9 $1B $6F
	BEQ L35B4D		; 9B33	$F0 $18
	LDA $B6,X		; 9B35	$B5 $B6
	STA $C3			; 9B37	$85 $C3
	LDA $B7,X		; 9B39	$B5 $B7
	STA $C4			; 9B3B	$85 $C4
	JSR J9B56		; 9B3D	$20 $56 $9B	$846B
	LDX $C6			; 9B40	$A6 $C6
	LDA $BA,X		; 9B42	$B5 $BA
	STA $C3			; 9B44	$85 $C3
	LDA $BB,X		; 9B46	$B5 $BB
	STA $C4			; 9B48	$85 $C4
	JSR J9BB6		; 9B4A	$20 $B6 $9B	$8478
L35B4D:
	INC $C5			; 9B4D	$E6 $C5
	LDA $C5			; 9B4F	$A5 $C5
	CMP #$03		; 9B51	$C9 $03
	BCC L35B26		; 9B53	$90 $D1
	RTS			; 9B55	$60
; End of
J9B56:
	LDA $C4			; 9B56	$A5 $C4
	CMP #$FF		; 9B58	$C9 $FF
	BNE L35B5D		; 9B5A	$D0 $01
	RTS			; 9B5C	$60
; End of
L35B5D:
	LDX $C5			; 9B5D	$A6 $C5
	LDA $6F0A,X		; 9B5F	$BD $0A $6F
	BNE L35BB2		; 9B62	$D0 $4E
J9B64:
	LDY $6F13,X		; 9B64	$BC $13 $6F
	LDA ($C3),Y		; 9B67	$B1 $C3
	AND #$F0		; 9B69	$29 $F0
	BNE L35B81		; 9B6B	$D0 $14
	LDA ($C3),Y		; 9B6D	$B1 $C3
	AND #$0F		; 9B6F	$29 $0F
	BEQ L35BB2		; 9B71	$F0 $3F
	STA $C8			; 9B73	$85 $C8
	LDA $6F13,X		; 9B75	$BD $13 $6F
	SEC			; 9B78	$38
	SBC $C8			; 9B79	$E5 $C8
	STA $6F13,X		; 9B7B	$9D $13 $6F
	JMP J9B64		; 9B7E	$4C $64 $9B
L35B81:
	LSR A			; 9B81	$4A
	LSR A			; 9B82	$4A
	LSR A			; 9B83	$4A
	LSR A			; 9B84	$4A
	STA $6F0A,X		; 9B85	$9D $0A $6F
	INC $6F13,X		; 9B88	$FE $13 $6F
	LDA $6F04,X		; 9B8B	$BD $04 $6F
	ASL A			; 9B8E	$0A
	ASL A			; 9B8F	$0A
	ASL A			; 9B90	$0A
	ASL A			; 9B91	$0A
	STA $C8			; 9B92	$85 $C8
	LDA ($C3),Y		; 9B94	$B1 $C3
	AND #$0F		; 9B96	$29 $0F
	ORA $C8			; 9B98	$05 $C8
	TAY			; 9B9A	$A8
	LDA D9D0D,Y		; 9B9B	$B9 $0D $9D
	STA $C8			; 9B9E	$85 $C8
	LDY $C7			; 9BA0	$A4 $C7
	LDA $6F19,Y		; 9BA2	$B9 $19 $6F
	AND #$F0		; 9BA5	$29 $F0
	ORA $C8			; 9BA7	$05 $C8
	STA $6F19,Y		; 9BA9	$99 $19 $6F
	LDA #$01		; 9BAC	$A9 $01
	ORA $C0,X		; 9BAE	$15 $C0
	STA $C0,X		; 9BB0	$95 $C0
L35BB2:
	DEC $6F0A,X		; 9BB2	$DE $0A $6F
	RTS			; 9BB5	$60
; End of
J9BB6:
	LDA $C4			; 9BB6	$A5 $C4
	CMP #$FF		; 9BB8	$C9 $FF
	BNE L35BBD		; 9BBA	$D0 $01
	RTS			; 9BBC	$60
L35BBD:
	LDX $C5			; 9BBD	$A6 $C5
	LDA $6F0D,X		; 9BBF	$BD $0D $6F
	BNE L35C1B		; 9BC2	$D0 $57
J9BC4:
	LDY $6F16,X		; 9BC4	$BC $16 $6F
	LDA ($C3),Y		; 9BC7	$B1 $C3
	AND #$F0		; 9BC9	$29 $F0
	BNE L35BE1		; 9BCB	$D0 $14
	LDA ($C3),Y		; 9BCD	$B1 $C3
	AND #$0F		; 9BCF	$29 $0F
	BEQ L35C1B		; 9BD1	$F0 $48
	STA $C8			; 9BD3	$85 $C8
	LDA $6F16,X		; 9BD5	$BD $16 $6F
	SEC			; 9BD8	$38
	SBC $C8			; 9BD9	$E5 $C8
	STA $6F16,X		; 9BDB	$9D $16 $6F
	JMP J9BC4		; 9BDE	$4C $C4 $9B
L35BE1:
	LSR A			; 9BE1	$4A
	LSR A			; 9BE2	$4A
	LSR A			; 9BE3	$4A
	LSR A			; 9BE4	$4A
	STA $6F0D,X		; 9BE5	$9D $0D $6F
	INC $6F16,X		; 9BE8	$FE $16 $6F
	LDA ($C3),Y		; 9BEB	$B1 $C3
	AND #$0F		; 9BED	$29 $0F
	STA $C8			; 9BEF	$85 $C8
	LDY $C7			; 9BF1	$A4 $C7
	AND #$08		; 9BF3	$29 $08
	BNE L35C02		; 9BF5	$D0 $0B
	LDA $6F1B,Y		; 9BF7	$B9 $1B $6F
	CLC			; 9BFA	$18
	ADC $C8			; 9BFB	$65 $C8
	BCS L35C1B		; 9BFD	$B0 $1C
	JMP J9C12		; 9BFF	$4C $12 $9C
L35C02:
	LDA $C8			; 9C02	$A5 $C8
	AND #$07		; 9C04	$29 $07
	STA $C8			; 9C06	$85 $C8
	LDA $6F1B,Y		; 9C08	$B9 $1B $6F
	SEC			; 9C0B	$38
	SBC $C8			; 9C0C	$E5 $C8
	BEQ L35C1B		; 9C0E	$F0 $0B
	BCC L35C1B		; 9C10	$90 $09
J9C12:
	STA $6F1B,Y		; 9C12	$99 $1B $6F
	LDA #$04		; 9C15	$A9 $04
	ORA $C0,X		; 9C17	$15 $C0
	STA $C0,X		; 9C19	$95 $C0
L35C1B:
	DEC $6F0D,X		; 9C1B	$DE $0D $6F
	RTS			; 9C1E	$60
; End of

; Name	:
; Marks	:
J9C1F:
	LDA ApuStatus_4015	; 9C1F	$AD $15 $40	$854D
	ORA #$0F		; 9C22	$09 $0F
	STA ApuStatus_4015	; 9C24	$8D $15 $40
	LDA $E6			; 9C27	$A5 $E6
	STA $E7			; 9C29	$85 $E7
	LDX #$00		; 9C2B	$A2 $00
	LDY #$00		; 9C2D	$A0 $00
L35C2F:
	LSR $E7			; 9C2F	$46 $E7		$855D
	BCS L35C63		; 9C31	$B0 $30
	CPX #$01		; 9C33	$E0 $01
	BNE L35C3B		; 9C35	$D0 $04
	LDA $E5			; 9C37	$A5 $E5
	BNE L35C63		; 9C39	$D0 $28
L35C3B:
	LSR $C0,X		; 9C3B	$56 $C0
	BCC L35C45		; 9C3D	$90 $06
	LDA $6F19,Y		; 9C3F	$B9 $19 $6F
	STA Sq0Duty_4000,Y	; 9C42	$99 $00 $40
L35C45:
	LSR $C0,X		; 9C45	$56 $C0
	BCC L35C4F		; 9C47	$90 $06
	LDA $6F1A,Y		; 9C49	$B9 $1A $6F
	STA Sq0Sweep_4001,Y	; 9C4C	$99 $01 $40
L35C4F:
	LSR $C0,X		; 9C4F	$56 $C0
	BCC L35C59		; 9C51	$90 $06
	LDA $6F1B,Y		; 9C53	$B9 $1B $6F
	STA Sq0Timer_4002,Y	; 9C56	$99 $02 $40
L35C59:
	LSR $C0,X		; 9C59	$56 $C0
	BCC L35C63		; 9C5B	$90 $06
	LDA $6F1C,Y		; 9C5D	$B9 $1C $6F
	STA Sq0Length_4003,Y	; 9C60	$99 $03 $40
L35C63:
	INY			; 9C63	$C8		$8591
	INY			; 9C64	$C8
	INY			; 9C65	$C8
	INY			; 9C66	$C8
	INX			; 9C67	$E8
	CPX #$03		; 9C68	$E0 $03
	BCC L35C2F		; 9C6A	$90 $C3		$8598
	RTS			; 9C6C	$60
; End of



; ==================================================
; TEST F - chocobo FF3 version - good
; octave +1

BGMFF3_CHOCOBO:
.word AA8B	; .byte $8B,$AA
.word AB3D	; .byte $3D,$AB
.word AB81	; .byte $81,$AB
;.byte $FF,$FF
;.byte $FF,$FF

AA8B:	; CH0
.byte $F6,$30,$15,$BD,$CB,$BE	; added from ff2 chocobo
;.byte $E0,$9B	tempo - original
;.byte $E0,$46	; tempo
.byte $E0,$4D	; tempo more fast - half of original
;.byte $F5,$03,$07
;.byte $EB
AA91:
.byte $C0,$C1,$C6
.byte $F2,$BE,$F3,$0E,$1E
;.byte $FB	; loop counter 5
;.byte $02
.byte $F8	; loop counter 2
AA9B:
.byte $2B,$C6,$F2,$BB,$CB	; AA90
.byte $7B,$CB,$48,$F3,$2B,$CB,$F2,$BB,$CB,$7B,$CB,$BB,$C6,$7B,$C6,$B3
.byte $9B,$CB,$7B,$CB,$7B,$9B,$7B,$CB,$5B,$CB,$73,$5B,$CB
.byte $FD	; repeat
.word AAD3	; .byte $D3,$AA
.byte $7B,$CB,$7B,$BB,$F3,$2B,$CB,$4B,$CB,$55
.byte $D6
.byte $F2,$BE,$F3,$0E,$1E
.byte $FC	; repeat
.word AA9B	; .byte $9B,$AA
AAD3:
.byte $F2
.byte $7B,$CB,$7B,$BB,$F3,$2B,$CB,$4B,$CB,$55
.byte $D6
.byte $0E,$2E,$3E
;.byte $FB	; loop counter 5
;.byte $02
.byte $F8	; loop counter 2
AAE4:
.byte $4B,$C6,$0B,$CB,$F2,$9B,$CB,$68,$9B,$CB,$F3,$0B
.byte $CB,$4B,$CB,$2B,$C6,$7B,$C6,$23,$F2,$BB,$CB
.byte $FD	; repeat
.word AB22	; .byte $22,$AB
.byte $F3,$0B	; AAF0
.byte $C6,$F2,$9B,$CB,$6B,$CB,$28,$6B,$CB,$9B,$CB,$F3,$0B,$CB,$F2,$BB	; AB00
.byte $CB,$BB,$F3,$0B,$F2,$BB,$CB,$9B,$CB,$B5
.byte $D6
.byte $F3,$0E,$2E,$3E
.byte $FC	; repeat
.word AAE4	; .byte $E4,$AA
AB22:
.byte $F2,$9B,$CB,$9B,$BB,$9B,$CB,$7B,$CB,$93,$7B,$CB,$9B,$CB
.byte $9B,$BB,$F3,$0B,$CB,$2B,$CB,$4B,$C6,$65
.byte $FE	; repeat
.word AA91	; $91,$AA

AB3D:	; CH1
;.byte $F5,$03,$07
;.byte $E8
;.byte $F6,$70,$15,$BD,$FF,$FF	; too simple/matt
.byte $F6,$30,$15,$BD,$CB,$BE	; added from ff2 chocobo
.byte $EB
AB41:
.byte $FB	;.byte $FB,$05	; loop counter 5
AB43:
.byte $C5
.byte $F2,$2B,$C6,$C8,$0B,$C6,$0B,$C6,$2B,$C6,$2B,$C6
.byte $C8,$0B,$C6
.byte $FC	; repeat
.word AB43	; .byte $43,$AB
.byte $F9	; .byte $FB,$03	; loop counter 3
AB58:
.byte $C5,$0B,$C6,$C8,$0B,$C6,$0B,$C6
.byte $2B,$C6,$2B,$C6,$2B,$C6,$2B,$CB
.byte $FC	; repeat
.word AB58	; .byte $58,$AB
.byte $C8,$0B,$C6,$0B,$C6
.byte $0B,$C6,$0B,$C6,$0B,$CB,$4B,$CB,$BB,$CB,$9B,$C6
.byte $F3,$05
.byte $FE	; repeat
.word AB41	; .byte $41,$AB

AB81:	; TRI
.byte $FB	; .byte $FB,$05	; loop counter 5
AB83:
.byte $F2,$7B,$C6,$BB,$CB,$7B,$CB,$58,$9B,$C6,$9B,$CB,$78
.byte $BB,$CB,$78,$BB,$CB,$5B,$C6,$9B,$CB,$5B,$CB
.byte $FC	; repeat
.word AB83	; .byte $83,$AB
.byte $F8	; .byte $FB,$02	; loop counter 2 AB90
ABA0:
.byte $0B,$C6,$7B,$CB,$0B,$CB,$28,$9B,$C6,$9B,$CB,$78,$BB,$CB,$78,$BB	; ABA0
.byte $CB,$68,$BB,$CB,$28,$BB,$CB
.byte $FD	; repeat
.word ABD4	; .byte $D4,$AB
.byte $0B,$C6,$7B,$CB,$0B,$CB
.byte $28,$9B,$C6,$9B,$CB,$78,$BB,$CB,$78,$BB,$CB,$58,$BB,$CB,$28,$BB
.byte $CB
.byte $FC	; repeat
.word ABA0	; .byte $A0,$AB
ABD4:
.byte $58,$9B,$CB,$48,$9B,$CB,$28,$9B,$CB,$08,$9B,$CB	; ABD0
.byte $F1,$98,$F2,$4B,$CB,$9B,$CB,$7B,$CB,$6B,$C6,$25
.byte $FE	; repeat
.word AB81	; .byte $81,$AB
; ==================================================



; ==================================================
; TEST E - CHOCOBO extension
BGM9F87:
.word BGM9F87_CH0_9F8D	; $8D,$9F
.word BGM9F87_CH1_9FCC	; $CC,$9F
.word BGM9F87_TRI_9FE1	; $E1,$9F

BGM9F87_CH0_9F8D:	; ----------
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $E0,$46
.byte $F2		; tempo
.byte $BE
.byte $F3		; tempo
.byte $0E,$1E
; $9F9A-$9FCB - CH_0
BGM9F87_CH0_9F9A:
.byte $2B,$C6
.byte $F2		; tempo
.byte $B8,$7B,$CB
.byte $48
.byte $F3		; tempo
.byte $2B,$CB
.byte $F2		; tempo
.byte $BB,$CB,$7B,$CB,$BB
.byte $C6,$7B,$C6,$B3,$98,$7B
.byte $CB,$7B,$9B,$7B,$CB,$5B,$CB,$73,$58,$7B,$CB,$7B,$BB
.byte $F3		; tempo
.byte $2B,$CB
.byte $4B,$CB,$53,$CB
.byte $F2		; tempo
.byte $BE
.byte $F3		; tempo
.byte $0E,$1E

.byte $F1,$8B,$6B,$4B,$6B,$8B,$CB,$9B,$CB
.byte $F2,$16,$F1,$BB,$F2,$1B,$CB,$3B,$CB,$48,$7B,$7B,$7B,$CB,$7B,$CB
.byte $72,$88,$6B,$4B,$38,$1B,$F1,$BB,$F2,$4B,$4B,$3B,$1B,$F1,$BB,$9B
.byte $8B,$6B,$7B,$CB,$F2,$4B,$0B,$F1,$BB,$9B,$7B,$5B,$46
;.byte $F8
.byte $8D,$4B
;.byte $F8
.byte $08,$4B,$C6

.byte $FE		; repeat
.word BGM9F87_CH0_9F9A	; ,$9A,$9F

; $9FCC - CH1		; ----------
BGM9F87_CH1_9FCC:
.byte $F6,$70,$15,$BD,$FF,$FF
.byte $EB
.byte $CB
; $9FD4-$9FE0 - CH_1
BGM9F87_CH1_9FD4:
.byte $C8
.byte $F2		; tempo
.byte $2B,$C6,$2B,$C6,$0B,$C6,$0B,$CB
.byte $FE		; repeat
.word BGM9F87_CH1_9FD4	; $D4,$9F

; $9FE1			; ----------
BGM9F87_TRI_9FE1:
.byte $CB
; $9FE2-$9FF1 - TRI
BGM9F87_TRI_9FE2:
.byte $F2		; tempo
.byte $7B,$CB,$BB,$C6,$BB,$CB,$5B,$CB,$9B,$C6,$9B,$CB
.byte $FE		; repeat
.word BGM9F87_TRI_9FE2	; $E2,$9F



; ==================================================
; TEST D - CHOCOBO FF3 XXXXX une OOOOO
BGM_FF39:
.word S09_CH0_ABF9	; $F9,$AB
.word S09_CH1_AC7E	; $7E,$AC
.word S09_TRI_ACD8	; $D8,$AC
;.byte $FF,$FF
;.byte $FF,$FF

S09_CH0_ABF9:
.byte $E0,$89
.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $E0,$89,$F6,$02,$07,$EB
S09_CH0_ABFF:
.byte $F8		; repeat 2.byte $FB,$02	; ABFF
.byte $C9,$CE,$F1,$AF,$BB,$C8,$CD,$CE,$AF,$BB,$C8,$CD,$CE,$AF,$BB	; AC00
.byte $CB,$C5,$FC,$01,$AC
.byte $F8		; repeat 2 $FB,$02
S09_CH0_AC17:
.byte $F1,$8B,$6B,$4B,$6B,$8B,$CB,$9B,$CB
.byte $F2,$16,$F1,$BB,$F2,$1B,$CB,$3B,$CB,$48,$7B,$7B,$7B,$CB,$7B,$CB
.byte $72,$88,$6B,$4B,$38,$1B,$F1,$BB,$F2,$4B,$4B,$3B,$1B,$F1,$BB,$9B
.byte $8B,$6B,$7B,$CB,$F2,$4B,$0B,$F1,$BB,$9B,$7B,$5B,$46,$F8,$8D,$4B
.byte $F8,$08,$4B,$C6
.byte $FC
.word S09_CH0_AC17	; $17,$AC
.byte $F3,$4B,$CB,$4B,$CB,$2B,$CB,$0B,$CB
.byte $F2,$B5,$9B,$CB,$7B,$CB,$55,$3B,$CB,$15,$F1,$BB,$CB,$91,$F3,$1B
.byte $F2,$BB,$9B,$7B,$5C,$3C,$1C,$F1,$BC,$9C,$7C
.byte $FE
.word S09_CH0_ABFF	; $FF,$AB

S09_CH1_AC7E:
.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $F6,$02
;.byte $FF,$E8
S09_CH1_AC82:
.byte $F8		; repeat 2 .byte $FB,$02
S09_CH1_AC84:
.byte $C8,$F1,$8B,$C6,$8B,$C6,$8B,$CB,$C5
.byte $FC
.word S09_CH1_AC84	; $84,$AC
.byte $F8		; repeat 2 .byte $FB,$02
.byte $C8,$F0,$BB,$CB,$C3,$BB,$CB,$C3,$F1,$0B,$CB,$C3,$0B,$CB	; AC90
.byte $C3,$F0,$BB,$CB,$C3,$BB,$CB,$C5,$F1,$4B,$CB,$4B,$CB,$3B,$CB,$2B
.byte $CB,$16,$F8,$8D,$1B,$F8,$08,$F2,$1B,$CB,$C8,$FC,$92,$AC,$F2,$8B
.byte $CB,$8B,$CB,$6B,$CB,$4B,$CB,$35,$1B,$CB,$F1,$BB,$CB,$95,$7B,$CB
.byte $55,$3B,$CB,$15,$D0
.byte $FE
.word S09_CH1_AC82	; $82,$AC

S09_TRI_ACD8:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $F8		; repeat 2 .byte $FB,$02
S09_TRI_ACDA:
.byte $F1,$48,$C8,$F0,$B8,$C8
.byte $F1,$48,$C5,$F0,$BB,$CB
.byte $FC
.word S09_TRI_ACDA	; $DA,$AC
.byte $F8		; repeat 2 .byte $FB,$02
S09_TRI_ACEB:
.byte $F1,$48,$C8,$F0,$B8
.byte $C8,$F1,$48,$C5,$F0,$BB,$CB,$F1,$08,$C8,$F0,$78,$C8,$F1,$08,$C5
.byte $2B,$CB,$48,$C8,$F0,$B8,$C8,$F1,$48,$C5,$F0,$BB,$CB,$F1,$0B,$CB	; AD00
.byte $0B,$CB,$F0,$BB,$CB,$AB,$CB,$96,$F5;,$FF,$08
S09_TRI_AD1B:
.byte $9B,$F5;,$FF,$FF,$9B
.byte $CB,$C8
.byte $FC
.word S09_TRI_ACEB	; $EB,$AC
.byte $C0,$F0,$58,$F1,$08,$78,$F0,$88,$F1,$18,$68
.byte $75,$D2,$C2
.byte $FE
.word S09_TRI_ACD8	; $D8,$AC



; ==================================================
; TEST C - MATOYA
;
; $Cx -> $Dy ??
; $Cx = $Cx ??
;
; tick
; $F8,$?? -> $Cx ??
; $F8,$?? -> $Dx ?? <-
;
; octave
;      $d8, $d9, $da, $db
; $F0, $F1, $F2, $F3, $F4, $F5
;
; repeat
; $Dx -> $Fy

BGM_0009:
.word BGM_8385
;.byte $FF,$FF
.word BGM_841C
;.word BGM_84E7
.byte $FF,$FF
BGM_8385:		; SQ channel 0
;;.byte $fb - tempo
;.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $F6,$B0,$6A,$BD,$C7,$BE
.byte $F6,$30,$6A,$BD,$C4,$BE
;.byte $F6,$30,$6A,$BD,$FF,$FF
.byte $E0,$61			; tempo
S8386:
.byte $DA;.byte $f8,$08		; tick
.byte $ec			; volume ?? envelope pattern select
.byte $f2,$b7
.byte $f3,$27,$67
.byte $f2,$b7
.byte $f3,$75,$67,$47,$25,$47,$27
.byte $DA;.byte $f8,$08
.byte $ee			; volume
.byte $13

.byte $DA;.byte $f8,$08
.byte $ec			; volume
.byte $27,$67,$97,$27,$b5,$97,$77,$65,$77,$67,$45

.byte $67,$77
.byte $DA;.byte $f8,$08		; tick
.byte $ee			; volume
.byte $93,$15,$45,$2c
.byte $cc
.byte $1c
.byte $cc
.byte $2c
.byte $cc
.byte $f2,$b3

.byte $f3,$77,$97,$b3,$25,$75,$6c
.byte $cc
.byte $7c
.byte $cc
.byte $6c
.byte $cc
.byte $43

.byte $97,$b7
.byte $f4,$13
.byte $c7
.byte $f3,$97,$b7
.byte $f4,$17,$49,$29,$19,$29
.byte $f3,$b4

.byte $97,$77,$67,$43
.byte $c7
.byte $07,$27,$47,$23,$15
.byte $f2,$95
.byte $DA;.byte $f8,$08		; tick
.byte $ee			; volume
.byte $f3,$20
.byte $c5
.byte $D4;.byte $f8,$04		; tick
.byte $e8			; volume e1

.byte $29,$19
.byte $f2,$b9
.byte $f3,$19
.byte $DA;.byte $f8,$08		; tick
.byte $ee			; volume
.byte $20
.byte $c5

.byte $D4;.byte $f8,$04		; tick
.byte $e8			; volume e1
.byte $69,$49,$29,$49
.byte $DA;.byte $f8,$08		; tick
.byte $ee			; volume
.byte $60
.byte $c5

.byte $D4;.byte $f8,$04		; tick
.byte $e8			; volume e1
.byte $99,$79,$69,$79
.byte $DA;.byte $f8,$08		; tick
.byte $ee			; volume
.byte $90

.byte $D4;.byte $f8,$04		; tick
.byte $e8			; volume e1
.byte $69,$49,$29,$19,$49,$29,$19
.byte $f2,$a9,$FE
.word S8386	; ,$86,$83

BGM_841C:		; SQ channel 1
;;.byte $fb
;.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $F6,$30,$C7,$BE,$15,$BD
.byte $F6,$30,$15,$BD,$FF,$FF
.byte $E0,$61			; tempo
S841D:
.byte $DA;.byte $f8,$07,	; tick
.byte $ee			; volume e2

.byte $f1,$b9,$c9
.byte $f2,$69,$c9
.byte $f1,$b9,$c9
.byte $f2,$69,$c9

.byte $f1,$b9,$c9
.byte $f2,$79,$c9
.byte $f1,$b9,$c9
.byte $f2,$79,$c9
.byte $f1,$b9,$c9
.byte $f2,$79,$c9
.byte $f1,$b9,$c9
.byte $f2,$79,$c9

.byte $19,$c9,$99,$c9
.byte $19,$c9,$99,$c9

.byte $29,$c9,$99,$c9
.byte $29,$c9,$99,$c9

.byte $29,$c9,$b9,$c9
.byte $29,$c9,$b9,$c9
.byte $29,$c9,$b9,$c9
.byte $29,$c9,$b9,$c9

.byte $19,$c9,$99,$c9
.byte $19,$c9,$99,$c9

.byte $99,$c9,$99,$c9,$c5
.byte $99,$c9,$99,$c9,$c5

.byte $69,$c9,$69,$c9,$c5
.byte $69,$c9,$69,$c9,$c5

.byte $b9,$c9,$b9,$c9,$c5
.byte $b9,$c9,$b9,$c9,$c5

.byte $f3
.byte $19,$c9,$19,$c9,$c5
.byte $19,$c9,$19,$c9,$c5

.byte $f2
.byte $99,$c9,$99,$c9,$c5
.byte $99,$c9,$99,$c9,$c5
.byte $69,$c9,$69,$c9,$c5
.byte $69,$c9,$69,$c9,$c5

.byte $49,$c9,$79,$c9
.byte $49,$c9,$79,$c9
.byte $49,$c9,$79,$c9
.byte $49,$c9,$79,$c9
.byte $49,$c9,$79,$c9
.byte $49,$c9,$79,$c9

.byte $99,$79,$69,$49,$69,$49,$29,$19
.byte $F9			; repeat count - 3
REP_84CA:
.byte $DA;.byte $f8,$08
.byte $ee
.byte $65,$25,$75,$25,$97,$97,$27,$97,$75,$45
.byte $FC	; .byte $d2	; ,$ca,$84	; 84d7
.word REP_84CA
.byte $65,$25,$75,$25,$97,$97,$27,$97,$65,$45
.byte $FE			; repeat to 
.word S841D	; ,$1d,$84

BGM_84E7:		; TRIANGLE
;;.byte $fb
;.byte $F6,$FF,$FF,$FF,$CB,$BE
.byte $E0,$4A			; tempo
S84E8:
;.byte $f8,$08
.byte $ec			; volume
.byte $f1,$b3,$f2,$43,$73
.byte $95,$75,$23,$73,$b3,$97,$49,$c9,$19,$c9,$f1,$99,$c9,$c7,$67,$f2
.byte $19,$c9,$69,$c9,$c7,$f1,$69,$c9,$f2,$67,$19,$c9,$c7,$f1,$b7,$f2
.byte $69,$c9,$b9,$c9,$c7,$f1,$b9,$c9,$f2,$b7,$69,$c9,$c7,$f1,$77,$f2
.byte $29,$c9,$79,$c9,$c7,$f1,$79,$c9,$f2,$77,$29,$c9,$c7,$f1,$97,$f2
.byte $49,$c9,$99,$c9,$c7,$f1,$99,$c9,$f2,$97,$49,$c9,$c7,$f1,$67,$f2
.byte $19,$c9,$69,$c9,$c7,$f1,$69,$c9,$f2,$67,$19,$c9,$c7,$f1,$b7,$f2
.byte $69,$c9,$b9,$c9,$c7,$f1,$b9,$c9,$f2,$b7,$69,$c9,$07,$f3,$09,$c9
.byte $f2,$07,$f3,$09,$c9,$f2,$07,$f3,$09,$c9,$f2,$07,$f3,$09,$c9,$f1
.byte $97,$f2,$99,$c9,$f1,$97,$f2,$99,$c9,$f1,$97,$f2,$99,$c9,$f1,$97
.byte $f2,$99,$c9
.byte $F8
REP_8583:
.byte $27,$99,$c9,$c7,$99,$c9,$27,$b9,$c9,$c7,$b9,$c9,$27
.byte $f3,$19,$c9,$c7,$19,$c9,$f2,$27,$b9,$c9,$c7,$b9,$c9
.byte $FC	; .byte $d2,$83,$85	; 85ad
.word REP_8583
.byte $27,$99,$c9,$c7,$99,$c9,$27,$b9,$c9,$c7,$b9,$c9,$27,$f3,$19,$c9
.byte $c7,$19,$c9,$f2,$67,$f3,$19,$c9,$f2,$67,$f3,$19,$c9,$FE
.word S84E8	; $e8,$84



; ==================================================
; TEST B
; A1D2 - real address - dungeon
A1D2:
.word A1DC			; $DC $A1
.word A324			; $24 $A3
.word A401			; $01,$A4
.byte $FF,$FF,$FF,$FF
A1DC:
;.byte $F6,$03,$FF,$E0	original code
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $E0,$46
.byte $F2
.byte $BE
.byte $F3,$0E,$1E
; A1E0
.byte $5A,$E2,$F0,$AB,$F1,$0B,$2B,$5B,$E3,$2B,$0B,$F0,$AB,$F1,$0B,$E4
.byte $2B,$5B,$2B,$0B,$E5,$F0,$AB,$F1,$0B,$2B,$5B,$E6,$3B,$5B,$7B,$AB
.byte $E7,$7B,$5B,$3B,$5B,$E8,$7B,$AB,$F2,$0B,$2B,$E9,$3B,$5B,$7B,$AB
A210:
.byte $FB,$02,$EB,$FB,$09,$F1,$7E,$F2,$7E,$FC,$15,$A2,$FB,$03,$F2,$2E	; A210
.byte $F3,$2E,$FC,$1E,$A2,$FB,$06,$F2,$0E,$F3,$0E,$FC,$27,$A2,$FB,$03
.byte $F1,$AE,$F2,$AE,$FC,$30,$A2,$FB,$03,$F1,$9E,$F2,$9E,$FC,$39,$A2
.byte $FB,$0A,$F1,$7E,$F2,$7E,$FC,$42,$A2,$EA,$F1,$7E,$F2,$7E,$E9,$F1
.byte $7E,$F2,$7E,$E8,$F1,$7E,$F2,$7E,$E7,$F1,$7E,$F2,$7E,$E6,$F1,$7E
.byte $F2,$7E,$E5,$F1,$7E,$F2,$7E,$E4,$F1,$7E,$F2,$7E,$E3,$F1,$7E,$F2
.byte $7E,$EC,$7A,$9A,$AA,$EB,$FB,$0A,$4E,$F3,$4E,$F2,$FC,$78,$A2,$EA
.byte $4E,$F3,$4E,$E9,$F2,$4E,$F3,$4E,$E8,$F2,$4E,$F3,$4E,$E7,$F2,$4E
.byte $F3,$4E,$E6,$F2,$4E,$F3,$4E,$E5,$F2,$4E,$F3,$4E,$E4,$F2,$4E,$F3
.byte $4E,$E3,$F2,$4E,$F3,$4E,$F2,$EC,$7A,$9A,$AA,$EB,$FB,$0A,$F2,$3E
.byte $F3,$3E,$FC,$AE,$A2,$EA,$F2,$3E,$F3,$3E,$E9,$F2,$3E,$F3,$3E,$E8
.byte $F2,$3E,$F3,$3E,$E7,$F2,$3E,$F3,$3E,$E6,$F2,$3E,$F3,$3E,$E5,$F2
.byte $3E,$F3,$3E,$E4,$F2,$3E,$F3,$3E,$E3,$F2,$3E,$F3,$3E,$C5,$FC,$12
.byte $A2,$EB,$FB,$02,$F2,$5E,$8E,$F3,$0E,$5B,$D5,$38,$25,$35,$F2,$2E
.byte $5E,$8E,$F3,$0B,$D8,$D2,$F2,$A5,$FD,$0F,$A3,$3E,$5E,$8E,$F3,$0B
.byte $D8,$D2,$35,$F2,$2E,$5E,$AE,$F3,$2B,$D8,$D2,$C5,$FC,$E4,$A2,$F2	; A300
.byte $3E,$5E,$8E,$F3,$0B,$D8,$D2,$75,$F2,$5E,$AE,$F3,$2E,$5B,$D8,$D2
.byte $C5,$FE
.word A210			; $10,$A2
A324:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $E0,$46
.byte $F2
.byte $BE
.byte $F3,$0E,$1E	; end of copy data
.byte $F5,$02,$FF,$E1,$F0,$7B,$9B,$AB,$F1,$2B,$E2,$F0	; A320
.byte $AB,$9B,$7B,$9B,$E3,$AB,$F1,$2B,$F0,$AB,$9B,$E4,$7B,$9B,$AB,$F1
.byte $2B,$E5,$F0,$7B,$9B,$AB,$F1,$3B,$E6,$F0,$AB,$9B,$7B,$9B,$E7,$AB
.byte $F1,$3B,$F0,$AB,$9B,$E8,$7B,$9B,$AB,$F1,$3B,$E9
A35C:
.byte $FB,$02,$FB,$02
.byte $F0,$7B,$9B,$AB,$F1,$2B,$F0,$AB,$9B,$FC,$60,$A3,$7B,$9B,$AB,$F1	; A360
.byte $2B,$FB,$02,$F0,$7B,$9B,$AB,$F1,$3B,$F0,$AB,$9B,$FC,$73,$A3,$7B
.byte $9B,$AB,$F1,$3B,$FB,$02,$F0,$7B,$9B,$AB,$F1,$4B,$F0,$AB,$9B,$FC
.byte $86,$A3,$7B,$9B,$AB,$F1,$4B,$FB,$02,$F0,$7B,$9B,$AB,$F1,$3B,$F0
.byte $AB,$9B,$FC,$99,$A3,$7B,$9B,$AB,$F1,$3B,$FC,$5E,$A3,$FB,$02,$FB
.byte $02,$F0,$7B,$8B,$F1,$0B,$3B,$0B,$F0,$8B,$FC,$B1,$A3,$7B,$8B,$F1
.byte $0B,$3B,$FB,$02,$F0,$7B,$8B,$F1,$2B,$5B,$2B,$F0,$8B,$FC,$C4,$A3
.byte $7B,$8B,$F1,$2B,$5B,$FB,$02,$F0,$7B,$8B,$F1,$3B,$7B,$3B,$F0,$8B
.byte $FC,$D7,$A3,$7B,$8B,$F1,$3B,$7B,$FB,$02,$F0,$7B,$8B,$F1,$2B,$5B	; A3E0
.byte $2B,$F0,$8B,$FC,$EA,$A3,$7B,$8B,$F1,$2B,$5B,$FC,$AF,$A3,$FE
.word A35C			; $5C,$A3
A401:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $E0,$46
.byte $F2
.byte $BE
.byte $F3,$0E,$1E	; end of copy data
.byte $C0,$C0
A403:
.byte $FB,$02,$F1,$23,$DB,$CB,$23,$DB,$CB,$33,$DB,$CB,$36	; A400
.byte $DD,$CD,$3C,$CC,$3C,$CC,$3C,$CC,$43,$DB,$CB,$46,$DD,$CD,$4C,$CC
.byte $4C,$CC,$4C,$CC,$33,$DB,$CB,$33,$DB,$CB,$FC,$05,$A4,$FB,$02,$F0
.byte $51,$F1,$05,$F0,$51,$F1,$25,$F0,$51,$F1,$35,$F0,$51,$C5,$FC,$2F	; A430
.byte $A4,$FE
.word A403			; $03,$A4



; ==================================================
; TEST A
; A07C - real address is $8722 - FF3 prelude
; octave = -1 (EFh -> F0h, F4h -> F5h)

.if 0
A07C:
.word A086	; A07C	$86 $A0 - $8728
.word A1CA	; A07E	$CA $A1 - $886C
.byte $FF,$FF;,$FF,$FF,$FF,$FF
A086:
;.byte $F7,$02,$FF,$EB	original code
;.byte $F6,$30,$15,$BD,$CB,$BE
.byte $F6,$B0,$37,$BD,$FF,$FF
.byte $EB
A08A:
.byte $E0,$28	; .byte $E0,$51		; tempo
.byte $F1,$0B
.byte $E0,$29	; .byte $E0,$53	; A080
.byte $2B
.byte $E0,$2A	; .byte $E0,$55
.byte $4B
.byte $E0,$2B	; .byte $E0,$57
.byte $7B
.byte $E0,$2C	; .byte $E0,$59
.byte $F2,$0B
.byte $E0,$2D	; .byte $E0,$5B
.byte $2B
.byte $E0,$2E	; .byte $E0,$5D	; A090
.byte $4B
.byte $E0,$2F	; .byte $E0,$5F

.byte $7B
.byte $F3,$0B,$2B,$4B,$7B
.byte $F4,$0B,$2B,$4B,$7B

.byte $F8	; .byte $FB,$02		repeat - 2
A0B0:
.byte $F5,$0B
.byte $F4,$7B,$4B,$2B,$0B
.byte $F3,$7B,$4B,$2B,$0B
.byte $F2,$7B,$4B,$2B,$0B
.byte $F1,$7B,$4B,$2B
.byte $F0	; .byte $EF
.byte $9B,$BB
.byte $F1,$0B,$4B,$9B,$BB
.byte $F2,$0B,$4B,$9B,$BB
.byte $F3,$0B,$4B,$9B,$BB
.byte $F4,$0B,$4B,$9B,$4B,$0B
.byte $F3,$BB,$9B,$4B,$0B
.byte $F2,$BB,$9B,$4B,$0B
.byte $F1,$BB,$9B,$4B,$0B
.byte $F0	; .byte $EF
.byte $BB
.byte $FD	; repeat
.word A108	; $08,$A1
.byte $F1,$0B,$2B,$4B,$7B
.byte $F2,$0B,$2B,$4B,$7B
.byte $F3,$0B,$2B,$4B,$7B
.byte $F4,$0B,$2B,$4B,$7B
.byte $FC	; repeat
.word A0B0	; .byte $B0,$A0
A108:
.byte $9B
.byte $F1,$0B,$5B,$7B,$9B
.byte $F2,$0B	; A100
.byte $5B,$7B,$9B
.byte $F3,$0B,$5B,$7B,$9B
.byte $F4,$0B,$5B,$7B,$9B,$7B,$5B,$0B
.byte $F3,$9B,$7B,$5B,$0B
.byte $F2,$9B,$7B,$5B,$0B
.byte $F1,$9B,$7B,$5B,$0B
.byte $F0	; .byte $EF
.byte $BB
.byte $F1,$2B,$7B,$9B,$BB
.byte $F2,$2B,$7B,$9B,$BB
.byte $F3,$2B,$7B,$9B,$BB
.byte $F4,$2B,$7B,$9B,$BB,$9B,$7B,$2B
.byte $F3,$BB,$9B,$7B,$2B
.byte $F2,$BB,$9B,$7B,$2B
.byte $F1,$BB,$9B,$7B,$2B
.byte $F0	; .byte $EF
.byte $8B
.byte $F1,$0B,$3B,$7B,$8B
.byte $F2,$0B,$3B,$7B,$8B
.byte $F3,$0B,$3B,$7B,$8B
.byte $F4,$0B,$3B,$7B,$8B,$7B,$3B,$0B
.byte $F3,$8B,$7B,$3B,$0B
.byte $F2,$8B,$7B,$3B,$0B
.byte $F1,$8B,$7B,$3B,$0B
.byte $F0	; .byte $EF
.byte $AB
.byte $F1,$2B,$5B,$9B,$AB
.byte $F2,$2B,$5B,$9B,$AB
.byte $F3,$2B,$5B,$9B,$AB
.byte $F4,$2B,$5B,$9B
.byte $E0,$2F	; .byte $E0,$5E
.byte $AB
.byte $E0,$2E	; .byte $E0,$5D
.byte $9B
.byte $E0,$2E	;.byte $E0,$5C
.byte $5B
.byte $E0,$2D	;.byte $E0,$5B
.byte $2B
.byte $E0,$2D	;.byte $E0,$5A
.byte $F3,$AB
.byte $E0,$2C	;.byte $E0,$59
.byte $9B
.byte $E0,$2C	;.byte $E0,$58
.byte $5B
.byte $E0,$2B	;.byte $E0,$57
.byte $2B
.byte $E0,$2A	;.byte $E0,$55
.byte $F2	; A1A0
.byte $AB
.byte $E0,$29	;.byte $E0,$53
.byte $9B
.byte $E0,$28	;.byte $E0,$51
.byte $5B
.byte $E0,$27	;.byte $E0,$4F
.byte $2B
.byte $E0,$26	;.byte $E0,$4C
.byte $F1,$AB
.byte $E0,$24	;.byte $E0,$49
.byte $9B
.byte $E0,$23	;.byte $E0,$46
.byte $5B
.byte $E0,$21	;.byte $E0,$43
.byte $2B
.byte $FE	; repeat
.word A08A	; A1C8	$8A $A0
A1CA:
;.byte $F7,$02,$00	original
.byte $F6,$B0,$37,$BD,$FF,$FF
.byte $E5
.byte $CA
.byte $FE	; repeat
.word A08A	; A1D0	$8A $A0
.endif



; ==================================================
; TEST B
; Pitch example
;	  XYh ~ XYh: X = pitch, Y = length(0=longest, F=shortest)
;	   0Yh=C, 2Yh=D, 4Yh=E, 6Yh=F, 8Yh=G, 9Yh=A, BYh=B
;	  D0h ~ DFh: rest length(Delay 0=longest, F=shortest)
;	  E0h: tempo counter rate(next 1 byte)
;	  E1h ~ EFh: volume
;	  F0h, F1h, F2h, F3h, F4h, F5h: octave
;	  F6h: $6F19, $B6, $B7, $BA, $BB(next 5 bytes)
;		VPBD04:
;		VPBD15:
;		VPBD26:
;		VPBD37:
;		VPBD43:
;		VPBD6A:
;		VPBD99:
;		VPBDD2:
;		VPBE01:
;		VPBE66:		BEC7
;		VPBE87:		BEC7,BEE0
;		APBEAF:
;		APBEC4:
;		APBEC7:
;		APBECB:
;		APBEDD:
;		APBEF9:
;	  F7h,F8h,F9h,FAh,FBh: loop counter
;	  FCh: repeat - if loop count is exist
;	  FDh: repeat
;	  FEh: repeat
;	  FFh: stop
A07C:
.word A086	; A07C	$86 $A0 - Pulse 1
.byte $FF,$FF	;.word A1CA	; A07E	$CA $A1 - Pulse 2
.byte $FF,$FF	; A080	- Triangle
A086:
.byte $F6				; Settings (3 parameters)
.byte $BF				; DDLC VVVV(Duty/Constant/Volume,envelope) APU $4000,$4004, Envelope(0=
;.word VPBD43
.word VPBE01
;.byte $37,$BD
;.word APBECB
.word APBEC7
;.byte $FF,$FF
.byte $EF				; Set volume (E1h-EFh)
.byte $E0,$28				; Set tempo
A08A:
.byte $F0				; Octave 0
.byte $DF				; rest length (D0h-DFh)
A08C:
;     C   D   E   F   G   A   B
.byte $00,$20,$40,$50,$70,$90,$B0
.byte $F1				; Octave 1
;     C
.byte $00
.byte $F0				; Octave 0
;$10,$30,$60,$80,$A0,$C0
.byte $FE	; repeat
.word A08C	; A1D0	$8A $A0
.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F
.byte $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F
.byte $20,$21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F
.byte $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F
.byte $40,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F
.byte $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F
.byte $60,$61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F
.byte $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F
.byte $80,$81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F
.byte $90,$91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F
.byte $A0,$A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF
.byte $B0,$B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF
.byte $C0,$C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF
.byte $F8	; .byte $FB,$02		repeat - 2
.byte $CF,$CE,$CD,$CC,$CB,$CA,$C9,$C8,$C7,$C6,$C5,$C4,$C3,$C2,$C1,$C0
.byte $BF,$BE,$BD,$BC,$BB,$BA,$B9,$B8,$B7,$B6,$B5,$B4,$B3,$B2,$B1,$B0
.byte $AF,$AE,$AD,$AC,$AB,$AA,$A9,$A8,$A7,$A6,$A5,$A4,$A3,$A2,$A1,$A0
.byte $9F,$9E,$9D,$9C,$9B,$9A,$99,$98,$97,$96,$95,$94,$93,$92,$91,$90
.byte $8F,$8E,$8D,$8C,$8B,$8A,$89,$88,$87,$86,$85,$84,$83,$82,$81,$80
.byte $7F,$7E,$7D,$7C,$7B,$7A,$79,$78,$77,$76,$75,$74,$73,$72,$71,$70
.byte $6F,$6E,$6D,$6C,$6B,$6A,$69,$68,$67,$66,$65,$64,$63,$62,$61,$60
.byte $5F,$5E,$5D,$5C,$5B,$5A,$59,$58,$57,$56,$55,$54,$53,$52,$51,$50
.byte $4F,$4E,$4D,$4C,$4B,$4A,$49,$48,$47,$46,$45,$44,$43,$42,$41,$40
.byte $3F,$3E,$3D,$3C,$3B,$3A,$39,$38,$37,$36,$35,$34,$33,$32,$31,$30
.byte $2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24,$23,$22,$21,$20
.byte $1F,$1E,$1D,$1C,$1B,$1A,$19,$18,$17,$16,$15,$14,$13,$12,$11,$10
.byte $0F,$0E,$0D,$0C,$0B,$0A,$09,$08,$07,$06,$05,$04,$03,$02,$01,$00
.byte $FE	; repeat
.word A08A	; A1D0	$8A $A0





.segment "DATA_SND"
D9C6D:
.byte $AB
D9C6E:
.byte $06,$4D
.byte $06,$F3,$05,$9D,$05,$4C,$05,$01,$05,$B8,$04,$74,$04,$34,$04,$F7
.byte $03,$BE,$03,$88,$03,$55,$03,$26,$03,$F9,$02,$CE,$02,$A6,$02,$80
.byte $02,$5C,$02,$3A,$02,$19,$02,$FB,$01,$DE,$01,$C4,$01,$AA,$01,$93
.byte $01,$7C,$01,$67,$01,$52,$01,$3F,$01,$2D,$01,$1C,$01,$0C,$01,$FD
.byte $00,$EF,$00,$E1,$00,$D5,$00,$C9,$00,$BE,$00,$B3,$00,$A9,$00,$9F
.byte $00,$96,$00,$8E,$00,$86,$00,$7E,$00,$77,$00,$70,$00,$6A,$00,$64
.byte $00,$5E,$00,$59,$00,$54,$00,$4F,$00,$4B,$00,$46,$00,$42,$00,$3E
.byte $00,$3B,$00,$38,$00,$34,$00,$31,$00,$2F,$00,$2C,$00,$29,$00,$27
.byte $00,$25,$00,$23,$00,$21,$00,$1F,$00,$1D,$00,$1B,$00
D9CFD:
.byte $60,$48,$30

;; [$9D00 :: 0x35D00]

.byte $24,$20,$18,$12,$10,$0C,$09,$08,$06,$04,$03,$02,$01
; READ ADDR = $863B
D9D0D:
.byte $00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$00,$00
.byte $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$02,$00,$00,$00
.byte $00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03,$00,$00,$00
.byte $00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$04,$00,$00,$00
.byte $01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05,$00,$00,$00
.byte $01,$01,$02,$02,$02,$03,$03,$04,$04,$04,$05,$05,$06,$00,$00,$00
.byte $01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$00,$00,$01
.byte $01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$08,$00,$00,$01
.byte $01,$02,$03,$03,$04,$04,$05,$06,$06,$07,$07,$08,$09,$00,$00,$01
.byte $02,$02,$03,$04,$04,$05,$06,$06,$07,$08,$08,$09,$0A,$00,$00,$01
.byte $02,$02,$03,$04,$05,$05,$06,$07,$08,$08,$09,$0A,$0B,$00,$00,$01
.byte $02,$03,$04,$04,$05,$06,$07,$08,$08,$09,$0A,$0B,$0C,$00,$00,$01
.byte $02,$03,$04,$05,$06,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$00,$00,$01
.byte $02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$00,$01,$02

;; [$9E00 :: 0x35E00]

; song data ??
.byte $03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F

;; ========== pointers to song data (31 items) ($9E0D-$9E4A) START ==========
;; [$9E0D :: 0x35E0D]
D9E0D:
.byte $4B
D9E0E:
.byte $9E,$51
.byte $9E,$62,$9F,$87,$9F,$F2,$9F
.word A07C	; 9E17	$F2 $9F
;.word A1D2	; 9E19	$F2 $9F
;.word BGM_0009
;.word BGM_FF39
;.word BGM9F87
.word BGMFF3_CHOCOBO
.byte $67,$A1,$C4,$A1,$0D
.byte $A2,$55,$A2,$A0,$A2,$65,$A4,$EB,$A5,$BA,$A7,$9B,$A9,$0B,$AB,$5A
.byte $AC,$5A,$AD,$30,$B0,$10,$B5,$2A,$B5,$4A,$B6,$D5,$B6,$4D,$B7,$85
.byte $B7,$26,$B8,$A0,$B8,$80,$B9,$E1,$B9,$E2,$BC
;; ========== pointers to song data (31 items) ($9E0D-$9E4A) END ==========


;; ========== song data ($9E4B-$BD03) START ==========
;; [$9E4B :: 0x35E4B]
.byte $FF,$FF,$FF,$FF,$FF
.byte $FF,$57,$9E,$57,$9F,$FF,$FF,$F6,$B0,$37,$BD,$FF,$FF,$E0,$32,$F8
.byte $F1,$0B,$2B,$4B,$7B,$F2,$0B,$2B,$4B,$7B,$F3,$0B,$2B,$4B,$7B,$F4
.byte $0B,$2B,$4B,$7B,$F5,$0B,$F4,$7B,$4B,$2B,$0B,$F3,$7B,$4B,$2B,$0B
.byte $F2,$7B,$4B,$2B,$0B,$F1,$7B,$4B,$2B,$F0,$9B,$BB,$F1,$0B,$4B,$9B
.byte $BB,$F2,$0B,$4B,$9B,$BB,$F3,$0B,$4B,$9B,$BB,$F4,$0B,$4B,$9B,$4B
.byte $0B,$F3,$BB,$9B,$4B,$0B,$F2,$BB,$9B,$4B,$0B,$F1,$BB,$9B,$4B,$0B
.byte $F0,$BB,$FC,$60,$9E,$9B,$F1,$0B,$5B,$7B,$9B,$F2,$0B,$5B,$7B,$9B
.byte $F3,$0B,$5B,$7B,$9B,$F4,$0B,$5B,$7B,$9B,$7B,$5B,$0B,$F3,$9B,$7B
.byte $5B,$0B,$F2,$9B,$7B,$5B,$0B,$F1,$9B,$7B,$5B,$0B,$F0,$BB,$F1,$2B
.byte $7B,$9B,$BB,$F2,$2B,$7B,$9B,$BB,$F3,$2B,$7B,$9B,$BB,$F4,$2B,$7B
.byte $9B,$BB,$9B,$7B,$2B,$F3,$BB,$9B,$7B,$2B,$F2,$BB,$9B,$7B,$2B,$F1

;; [$9F00 :: 0x35F00]

.byte $BB,$9B,$7B,$2B,$F0,$8B,$F1,$0B,$3B,$7B,$8B,$F2,$0B,$3B,$7B,$8B
.byte $F3,$0B,$3B,$7B,$8B,$F4,$0B,$3B,$7B,$8B,$7B,$3B,$0B,$F3,$8B,$7B
.byte $3B,$0B,$F2,$8B,$7B,$3B,$0B,$F1,$8B,$7B,$3B,$0B,$F0,$AB,$F1,$2B
.byte $5B,$9B,$AB,$F2,$2B,$5B,$9B,$AB,$F3,$2B,$5B,$9B,$AB,$F4,$2B,$5B
.byte $9B,$AB,$9B,$5B,$2B,$F3,$AB,$9B,$5B,$2B,$F2,$AB,$9B,$5B,$2B,$F1
.byte $AB,$9B,$5B,$2B,$FE,$5F,$9E,$F6,$B0,$37,$BD,$C4,$BE,$E9,$CA,$FE
.byte $5F,$9E,$68,$9F,$7C,$9F,$FF,$FF,$F6,$B0,$37,$BD,$FF,$FF,$E0,$3C
.byte $F2,$0D,$4D,$6D,$9D,$F3,$0D,$6D,$9D,$F4,$0D,$FF,$F6,$B0,$37,$BD
.byte $F9,$BE,$EA,$CB,$FE,$70,$9F,$8D,$9F,$CC,$9F,$E1,$9F,$F6,$30,$15
.byte $BD,$CB,$BE,$E0,$46,$F2,$BE,$F3,$0E,$1E,$2B,$C6,$F2,$B8,$7B,$CB
.byte $48,$F3,$2B,$CB,$F2,$BB,$CB,$7B,$CB,$BB,$C6,$7B,$C6,$B3,$98,$7B
.byte $CB,$7B,$9B,$7B,$CB,$5B,$CB,$73,$58,$7B,$CB,$7B,$BB,$F3,$2B,$CB
.byte $4B,$CB,$53,$CB,$F2,$BE,$F3,$0E,$1E,$FE,$9A,$9F,$F6,$70,$15,$BD
.byte $FF,$FF,$EB,$CB,$C8,$F2,$2B,$C6,$2B,$C6,$0B,$C6,$0B,$CB,$FE,$D4
.byte $9F,$CB,$F2,$7B,$CB,$BB,$C6,$BB,$CB,$5B,$CB,$9B,$C6,$9B,$CB,$FE
.byte $E2,$9F,$F8,$9F,$4B,$A0,$56,$A0,$F6,$B0,$43,$BD,$C7,$BE,$E0,$34

;; [$A000 :: 0x36000]

.byte $F1,$9C,$BC,$F2,$0C,$2D,$4D,$6D,$8D,$F8,$F2,$91,$F3,$45,$F2,$B1
.byte $45,$F3,$05,$F2,$B5,$95,$B5,$72,$42,$FD,$2E,$A0,$52,$D8,$58,$98
.byte $F3,$08,$45,$25,$75,$55,$31,$F2,$B5,$F3,$40,$FC,$0A,$A0,$F2,$52
.byte $D8,$58,$78,$98,$F3,$05,$F2,$A5,$95,$85,$93,$B8,$F3,$03,$28,$41
.byte $F1,$BC,$F2,$0C,$2C,$4C,$6C,$8C,$FE,$09,$A0,$F6,$B0,$43,$BD,$E0
.byte $BE,$E9,$C8,$FE,$FE,$9F,$F6,$FF,$FF,$FF,$E4,$BE,$C5,$F8,$F2,$9B
.byte $CB,$F3,$4B,$CB,$5B,$CB,$4B,$CB,$F2,$9B,$CB,$F3,$4B,$CB,$5B,$CB
.byte $4B,$CB,$F2,$7B,$CB,$F3,$4B,$CB,$5B,$CB,$4B,$CB,$F2,$7B,$CB,$F3
.byte $4B,$CB,$5B,$CB,$4B,$CB,$F2,$5B,$CB,$F3,$2B,$CB,$4B,$CB,$2B,$CB
.byte $F2,$5B,$CB,$F3,$2B,$CB,$4B,$CB,$2B,$CB,$F2,$4B,$CB,$F3,$2B,$CB
.byte $4B,$CB,$2B,$CB,$F2,$4B,$CB,$F3,$1B,$CB,$2B,$CB,$1B,$CB,$FD,$05
.byte $A1,$F2,$2B,$CB,$BB,$CB,$F3,$0B,$CB,$4B,$CB,$F2,$0B,$CB,$9B,$CB
.byte $F3,$0B,$CB,$4B,$CB,$F1,$BB,$CB,$F2,$BB,$CB,$F3,$2B,$CB,$5B,$CB
.byte $F1,$AB,$CB,$F3,$0B,$CB,$2B,$CB,$5B,$CB,$F2,$3B,$CB,$9B,$CB,$AB
.byte $CB,$F3,$3B,$CB,$F1,$BB,$CB,$F2,$6B,$CB,$BB,$CB,$F3,$3B,$CB,$F2
.byte $4B,$CB,$9B,$CB,$BB,$CB,$F3,$4B,$CB,$2B,$CB,$F2,$BB,$CB,$8B,$CB

;; [$A100 :: 0x36100]

.byte $4B,$CB,$FC,$5E,$A0,$F2,$2B,$CB,$BB,$CB,$F3,$0B,$CB,$4B,$CB,$F2
.byte $0B,$CB,$9B,$CB,$F3,$0B,$CB,$4B,$CB,$F1,$AB,$CB,$F2,$9B,$CB,$F3
.byte $2B,$CB,$5B,$CB,$F1,$BB,$CB,$F2,$9B,$CB,$BB,$CB,$F3,$4B,$CB,$E0
.byte $33,$F2,$9B,$CB,$BB,$CB,$E0,$32,$F3,$4B,$CB,$5B,$CB,$E0,$31,$F2
.byte $5B,$CB,$9B,$CB,$E0,$30,$BB,$CB,$F3,$5B,$CB,$E0,$2F,$F2,$4B,$CB
.byte $E0,$2E,$9B,$CB,$E0,$2C,$BB,$CB,$E0,$28,$F3,$2B,$CB,$E0,$23,$45
.byte $E0,$34,$D8,$C8,$FE,$5D,$A0,$6D,$A1,$97,$A1,$B5,$A1,$F6,$70,$15
.byte $BD,$FF,$FF,$E0,$41,$F1,$9D,$F2,$0D,$5D,$9D,$F6,$70,$D2,$BD,$C7
.byte $BE,$F3,$05,$0C,$CC,$E0,$3F,$0C,$CC,$E0,$3E,$0C,$CC,$E0,$3C,$15
.byte $E0,$39,$35,$E0,$37,$51,$FF,$F6,$70,$15,$BD,$FF,$FF,$EC,$F1,$0D
.byte $5D,$9D,$F2,$0D,$F6,$70,$D2,$BD,$C7,$BE,$55,$9C,$CC,$7C,$CC,$5C
.byte $CC,$55,$75,$91,$FF,$C8,$F2,$95,$F3,$0C,$CC,$F2,$AC,$CC,$9C,$CC
.byte $85,$A5,$52,$FF,$CA,$A1,$EB,$A1,$FF,$FF,$F6,$B0,$AF,$BE,$C7,$BE
.byte $E0,$64,$F3,$0D,$1D,$5D,$8D,$C9,$EA,$0D,$1D,$5D,$8D,$C9,$E5,$0D
.byte $1D,$5D,$8D,$C9,$E2,$0D,$1D,$5D,$8D,$C9,$FF,$F6,$B0,$AF,$BE,$E0
.byte $BE,$CB,$CF,$EC,$F3,$0D,$1D,$5D,$8D,$C9,$E8,$0D,$1D,$5D,$8D,$C9

;; [$A200 :: 0x36200]

.byte $E3,$0D,$1D,$5D,$8D,$C9,$E1,$0D,$1D,$5D,$8D,$C9,$FF,$13,$A2,$34
.byte $A2,$FF,$FF,$F6,$70,$15,$BD,$FF,$FF,$E0,$28,$F3,$9C,$F2,$BC,$F3
.byte $1C,$EA,$9C,$F2,$BC,$F3,$1C,$E5,$9C,$F2,$BC,$F3,$1C,$E2,$9C,$F2
.byte $BC,$F3,$1C,$FF,$F6,$70,$15,$BD,$DD,$BE,$CD,$E9,$F3,$9C,$F2,$BC
.byte $F3,$1C,$E6,$9C,$F2,$BC,$F3,$1C,$E3,$9C,$F2,$BC,$F3,$1C,$E1,$9C
.byte $F2,$BC,$F3,$1C,$FF,$5B,$A2,$79,$A2,$99,$A2,$F6,$70,$D2,$BD,$C7
.byte $BE,$E0,$43,$F2,$B5,$2A,$7A,$BA,$F3,$25,$F2,$B5,$E0,$3E,$F3,$75
.byte $E0,$39,$5A,$3A,$0A,$E0,$34,$22,$FF,$F6,$70,$D2,$BD,$C7,$BE,$EA
.byte $F2,$7A,$2A,$0A,$F1,$B5,$F2,$5A,$2A,$5A,$7A,$2A,$F1,$BA,$F2,$0A
.byte $3A,$7A,$8A,$AA,$F3,$0A,$F2,$B2,$FF,$F2,$72,$52,$85,$55,$72,$FF
.byte $A6,$A2,$03,$A3,$E8,$A3,$F6,$B0,$6A,$BD,$C7,$BE,$E0,$46,$F2,$92
.byte $B5,$F3,$05,$22,$45,$55,$43,$08,$F2,$92,$D1,$C9,$7D,$9D,$BD,$F3
.byte $0D,$2D,$45,$D6,$6E,$7E,$8E,$92,$85,$95,$B5,$85,$95,$D6,$7E,$6E
.byte $5E,$42,$D2,$C8,$28,$28,$48,$52,$05,$F2,$95,$85,$F3,$45,$25,$45
.byte $03,$F2,$B8,$92,$D2,$C8,$98,$98,$B8,$F3,$02,$F2,$95,$55,$45,$F3
.byte $25,$05,$F2,$B5,$F3,$01,$28,$08,$F2,$B5,$D6,$F3,$1E,$2E,$3E,$42

;; [$A300 :: 0x36300]

.byte $FE,$AE,$A2,$F6,$70,$15,$BD,$FF,$FF,$EC,$F1,$98,$F2,$48,$28,$48
.byte $08,$48,$F1,$B8,$F2,$48,$F1,$B8,$F2,$78,$58,$78,$48,$78,$28,$78
.byte $F1,$98,$F2,$48,$28,$48,$08,$48,$F1,$B8,$F2,$48,$F1,$98,$F2,$48
.byte $F1,$B8,$F2,$48,$08,$48,$28,$48,$F1,$98,$F2,$48,$28,$48,$08,$48
.byte $F1,$B8,$F2,$48,$F1,$88,$F2,$48,$28,$48,$08,$48,$F1,$B8,$F2,$48
.byte $F1,$78,$F2,$48,$28,$48,$08,$48,$F1,$B8,$F2,$48,$F1,$98,$F2,$68
.byte $F1,$B8,$F2,$68,$08,$68,$28,$68,$C8,$F1,$98,$F2,$0B,$CB,$5B,$C6
.byte $F1,$9B,$CB,$F2,$08,$5B,$CB,$C8,$F1,$88,$BB,$CB,$F2,$4B,$C6,$F1
.byte $8B,$CB,$B8,$F2,$4B,$CB,$C8,$F1,$98,$F2,$0B,$CB,$4B,$C6,$F1,$9B
.byte $CB,$F2,$08,$4B,$CB,$C8,$28,$4B,$CB,$2B,$CB,$6B,$CB,$2B,$CB,$7B
.byte $CB,$2B,$CB,$C8,$F1,$58,$9B,$CB,$F2,$0B,$C6,$F1,$5B,$CB,$98,$F2
.byte $0B,$CB,$C8,$F1,$48,$8B,$CB,$BB,$C6,$4B,$CB,$88,$BB,$CB,$F2,$5B
.byte $CB,$4B,$5B,$2B,$CB,$4B,$5B,$2B,$CB,$4B,$5B,$2B,$CB,$4B,$5B,$6B
.byte $CB,$3B,$0B,$F1,$9B,$BB,$F2,$0B,$3B,$4B,$CB,$2B,$F1,$BB,$8C,$9C
.byte $BC,$F2,$0C,$2C,$4C,$FE,$0A,$A3,$F1,$90,$70,$50,$70,$90,$80,$70
.byte $F2,$20,$F1,$58,$F2,$0B,$C6,$0B,$CB,$F1,$58,$F2,$0B,$C6,$0B,$CB

;; [$A400 :: 0x36400]

.byte $F1,$48,$BB,$C6,$BB,$CB,$48,$BB,$C6,$BB,$CB,$98,$F2,$4B,$C6,$4B
.byte $CB,$F1,$98,$F2,$4B,$C6,$4B,$CB,$28,$05,$F1,$B5,$95,$78,$58,$F2
.byte $0B,$C6,$0B,$CB,$F1,$58,$F2,$0B,$C6,$0B,$CB,$F1,$48,$BB,$C6,$BB
.byte $CB,$48,$BB,$C6,$BB,$CB,$F2,$2B,$CB,$F1,$9B,$CB,$F2,$2B,$CB,$F1
.byte $9B,$CB,$F2,$2B,$CB,$F1,$9B,$CB,$F2,$2B,$CB,$F1,$9B,$CB,$BB,$CB
.byte $6B,$CB,$BB,$CB,$6B,$CB,$F2,$4B,$CB,$F1,$BB,$CB,$F2,$4B,$CB,$F1
.byte $BB,$CB,$FE,$E8,$A3,$6B,$A4,$C9,$A4,$64,$A5,$F6,$B0,$6A,$BD,$C7
.byte $BE,$E0,$44,$F2,$98,$B8,$F3,$08,$48,$25,$F2,$98,$B8,$F3,$05,$F2
.byte $B8,$98,$75,$B5,$90,$C2,$F3,$48,$C8,$78,$CB,$CE,$4E,$5E,$60,$D8
.byte $1E,$2C,$DB,$28,$48,$7E,$5C,$DB,$48,$28,$58,$45,$08,$F2,$98,$D2
.byte $D2,$F3,$08,$C8,$48,$CB,$CE,$0E,$1E,$20,$D8,$F2,$7E,$9C,$DB,$98
.byte $B8,$F3,$2E,$0C,$DB,$F2,$B8,$98,$F3,$08,$F2,$B3,$95,$F3,$28,$08
.byte $F2,$98,$93,$8B,$9B,$B2,$FE,$73,$A4,$ED,$F6,$30,$AF,$BE,$FF,$FF
.byte $F1,$98,$F2,$08,$48,$78,$98,$68,$28,$F1,$B8,$58,$98,$F2,$08,$48
.byte $28,$F1,$B8,$78,$B8,$98,$F2,$48,$58,$48,$F1,$98,$F2,$48,$58,$48
.byte $F1,$98,$F2,$48,$58,$48,$F1,$98,$F2,$48,$58,$48,$F6,$30,$15,$BD

;; [$A500 :: 0x36500]

.byte $FF,$FF,$C8,$25,$3C,$4C,$5C,$6B,$CB,$C8,$9B,$CB,$C8,$F6,$30,$66
.byte $BE,$C7,$BE,$50,$F6,$30,$15,$BD,$FF,$FF,$C8,$05,$1C,$2C,$3C,$4B
.byte $CB,$C8,$7B,$CB,$C8,$F6,$30,$66,$BE,$C7,$BE,$40,$F6,$30,$15,$BD
.byte $FF,$FF,$C8,$25,$3C,$4C,$5C,$6B,$CB,$C8,$9B,$CB,$C8,$F6,$30,$66
.byte $BE,$C7,$BE,$50,$F6,$30,$15,$BD,$FF,$FF,$C8,$35,$3C,$4C,$5C,$68
.byte $C8,$38,$C8,$45,$D8,$F1,$BC,$F2,$0C,$1C,$F6,$30,$66,$BE,$C7,$BE
.byte $22,$FE,$CA,$A4,$F1,$92,$B2,$F2,$02,$22,$4B,$CB,$4B,$CB,$C5,$F1
.byte $9B,$CB,$9B,$CB,$C5,$F2,$4B,$CB,$4B,$CB,$F1,$9B,$CB,$9B,$CB,$C2
.byte $F2,$2B,$CB,$2B,$CB,$9B,$CB,$9B,$CB,$C2,$F1,$AB,$CB,$AB,$CB,$F2
.byte $AB,$CB,$AB,$CB,$C8,$F1,$AB,$CB,$F2,$AB,$CB,$F1,$AB,$CB,$9B,$CB
.byte $9B,$CB,$F2,$9B,$CB,$9B,$CB,$C2,$F1,$9B,$CB,$9B,$CB,$F2,$9B,$CB
.byte $9B,$CB,$C8,$9B,$CB,$F1,$95,$F2,$2B,$CB,$2B,$CB,$9B,$CB,$9B,$CB
.byte $C2,$5B,$CB,$5B,$CB,$F3,$0B,$CB,$0B,$CB,$C2,$F1,$BB,$CB,$BB,$CB
.byte $F2,$BB,$CB,$BB,$CB,$C2,$4B,$CB,$4B,$CB,$BB,$CB,$BB,$CB,$F1,$BB
.byte $CB,$BB,$CB,$F2,$8B,$CB,$8B,$CB,$FE,$64,$A5,$F1,$A5,$A0,$A6,$34
.byte $A7,$E0,$3C,$F8,$F6,$70,$15,$BD,$FF,$FF,$EB,$C8,$F3,$98,$A8,$98

;; [$A600 :: 0x36600]

.byte $EC,$78,$98,$58,$98,$ED,$48,$98,$28,$98,$EE,$18,$98,$F2,$A8,$F3
.byte $98,$EF,$F2,$95,$D6,$9E,$BE,$F3,$0E,$F6,$70,$6A,$BD,$C7,$BE,$15
.byte $D6,$1E,$2E,$3E,$45,$D6,$4E,$5E,$6E,$75,$A5,$FC,$F4,$A5,$F8,$C8
.byte $78,$58,$48,$25,$15,$25,$45,$55,$95,$C8,$78,$58,$48,$25,$15,$20
.byte $FC,$2F,$A6,$F6,$70,$37,$BD,$FF,$FF,$E2,$F1,$4B,$5B,$E3,$8B,$BB
.byte $E4,$F2,$2B,$F1,$BB,$E5,$8B,$5B,$E6,$4B,$5B,$E7,$8B,$BB,$E8,$F2
.byte $2B,$F1,$BB,$E9,$8B,$5B,$EA,$4B,$5B,$EB,$8B,$BB,$EC,$F2,$2B,$F1
.byte $BB,$ED,$8B,$5B,$EC,$4B,$5B,$EB,$8B,$BB,$EA,$F2,$2B,$F1,$BB,$E9
.byte $8B,$5B,$E8,$4B,$5B,$E7,$8B,$BB,$E6,$F2,$2B,$F1,$BB,$E5,$8B,$5B
.byte $E4,$4B,$5B,$E3,$8B,$BB,$E2,$F2,$2B,$F1,$BB,$8B,$5B,$FE,$F3,$A5
.byte $F8,$F6,$70,$15,$BD,$FF,$FF,$CB,$C5,$E8,$F3,$98,$A8,$E9,$98,$78
.byte $98,$5B,$DB,$EA,$98,$48,$98,$28,$EB,$98,$18,$98,$F2,$AB,$F6,$70
.byte $6A,$BD,$C7,$BE,$EC,$15,$D6,$1E,$2E,$3E,$45,$D6,$4E,$5E,$6E,$75
.byte $D6,$7E,$8E,$9E,$A5,$F3,$15,$FC,$A1,$A6,$F9,$F6,$70,$15,$BD,$FF
.byte $FF,$C8,$F2,$A8,$D6,$9E,$8E,$7E,$5B,$CB,$4B,$CB,$2B,$CB,$1B,$CB
.byte $28,$A8,$98,$58,$28,$48,$58,$98,$FC,$E1,$A6,$C8,$A8,$D6,$9E,$8E

;; [$A700 :: 0x36700]

.byte $7E,$5B,$CB,$4B,$CB,$2B,$CB,$1B,$CB,$F6,$70,$6A,$BD,$C7,$BE,$ED
.byte $82,$D6,$8E,$9E,$AE,$B6,$DE,$BE,$AE,$EB,$95,$D6,$8E,$7E,$5E,$42
.byte $E9,$82,$D6,$8E,$9E,$AE,$B6,$DE,$BE,$AE,$E7,$95,$D6,$8E,$7E,$5E
.byte $42,$FE,$A0,$A6,$F8,$F2,$2B,$F3,$5B,$F2,$9B,$F3,$5B,$2B,$5B,$F2
.byte $9B,$F3,$5B,$F2,$2B,$F3,$5B,$F2,$9B,$F3,$5B,$2B,$5B,$F2,$9B,$F3
.byte $5B,$F2,$2B,$F3,$5B,$F2,$9B,$F3,$5B,$2B,$5B,$F2,$9B,$F3,$5B,$F2
.byte $2B,$F3,$5B,$F2,$9B,$F3,$5B,$2B,$5B,$F2,$9B,$F3,$5B,$F2,$18,$98
.byte $F3,$48,$F2,$98,$18,$98,$F3,$48,$F2,$98,$18,$98,$F3,$48,$F2,$98
.byte $18,$98,$F3,$48,$F2,$98,$FC,$35,$A7,$F9,$F1,$78,$F2,$28,$78,$28
.byte $F1,$98,$F2,$48,$98,$48,$F1,$A8,$F2,$58,$A8,$58,$F1,$A8,$F2,$58
.byte $A8,$58,$FC,$8A,$A7,$F1,$78,$F2,$28,$78,$28,$F1,$98,$F2,$48,$98
.byte $48,$20,$F9,$C0,$FC,$B3,$A7,$FE,$34,$A7,$C0,$A7,$5D,$A8,$DA,$A8
.byte $E0,$3F,$CB,$EF,$F6,$70,$D2,$BD,$C7,$BE,$F8,$F2,$A5,$7C,$CC,$7C
.byte $CC,$7C,$CC,$AA,$C7,$F3,$15,$F2,$AC,$CC,$AC,$CC,$AC,$CC,$75,$AA
.byte $C7,$F3,$15,$4A,$6A,$4A,$12,$4A,$7A,$4A,$10,$FC,$CB,$A7,$F8,$F2
.byte $B5,$8C,$CC,$8C,$CC,$8C,$CC,$BA,$C7,$F3,$25,$F2,$BC,$CC,$BC,$CC

;; [$A800 :: 0x36800]

.byte $BC,$CC,$85,$BA,$C7,$F3,$25,$5A,$7A,$5A,$22,$5A,$8A,$5A,$20,$FC
.byte $EF,$A7,$F6,$70,$26,$BD,$C7,$BE,$E0,$49,$F1,$A8,$B8,$F2,$28,$58
.byte $B8,$A8,$C8,$F1,$B8,$F2,$28,$58,$B8,$A5,$B8,$F3,$28,$58,$B8,$A8
.byte $C8,$58,$88,$A8,$C8,$A8,$F4,$28,$F3,$BC,$F4,$2C,$F3,$BC,$A8,$88
.byte $68,$F3,$A3,$D2,$F6,$70,$37,$BD,$FF,$FF,$E0,$3F,$58,$18,$ED,$38
.byte $F2,$B8,$EB,$F3,$18,$F2,$98,$E9,$B8,$78,$FE,$C3,$A7,$CB,$EC,$F6
.byte $70,$D2,$BD,$C7,$BE,$F8,$F2,$15,$F1,$AA,$AA,$AA,$F2,$1A,$C7,$45
.byte $1A,$1A,$1A,$F1,$A5,$F2,$1A,$C7,$45,$7A,$AA,$7A,$42,$7A,$AA,$7A
.byte $40,$FC,$66,$A8,$F8,$25,$0A,$0A,$0A,$2A,$C7,$55,$2A,$2A,$2A,$05
.byte $2A,$C7,$55,$8A,$BA,$8A,$52,$8A,$BA,$8A,$50,$FC,$85,$A8,$F6,$B0
.byte $26,$BD,$C7,$BE,$F1,$58,$68,$C5,$C5,$C5,$C5,$C8,$A5,$B8,$F2,$28
.byte $58,$B8,$A8,$C8,$58,$88,$A8,$C8,$A8,$F3,$28,$F2,$B8,$A8,$88,$68
.byte $23,$D2,$F6,$70,$37,$BD,$C7,$BE,$C8,$F3,$58,$EA,$18,$38,$E8,$F2
.byte $B8,$F3,$18,$E6,$F2,$98,$B8,$FE,$5E,$A8,$F2,$1E,$2E,$3E,$F8,$46
.byte $CB,$46,$CB,$4B,$CB,$4B,$CB,$46,$CB,$4C,$CC,$4C,$CC,$4C,$CC,$46
.byte $CB,$46,$CB,$46,$1E,$2E,$3E,$46,$CB,$46,$CB,$4B,$CB,$4B,$CB,$46

;; [$A900 :: 0x36900]

.byte $CB,$FD,$15,$A9,$4C,$CC,$4C,$CC,$4C,$CC,$46,$CB,$46,$CB,$46,$1E
.byte $2E,$3E,$FC,$DF,$A8,$4C,$CC,$4C,$CC,$4C,$CC,$46,$CB,$46,$CB,$46
.byte $2E,$3E,$4E,$F8,$56,$CB,$56,$CB,$5B,$CB,$5B,$CB,$56,$CB,$5C,$CC
.byte $5C,$CC,$5C,$CC,$56,$CB,$56,$CB,$56,$2E,$3E,$4E,$56,$CB,$56,$CB
.byte $5B,$CB,$5B,$CB,$56,$CB,$FD,$5A,$A9,$5C,$CC,$5C,$CC,$5C,$CC,$56
.byte $CB,$56,$CB,$56,$2E,$3E,$4E,$FC,$24,$A9,$5C,$CC,$5C,$CC,$5C,$CC
.byte $56,$CB,$56,$CB,$56,$1E,$2E,$3E,$F1,$A8,$B8,$C5,$F2,$18,$28,$C5
.byte $C5,$C8,$F1,$A5,$B8,$F2,$28,$58,$B8,$A8,$C8,$58,$88,$A8,$C8,$A8
.byte $F3,$28,$F2,$B8,$A8,$88,$6B,$CB,$63,$D2,$5B,$CB,$5B,$CB,$C8,$5B
.byte $CB,$5B,$CB,$C8,$5B,$CB,$5B,$CB,$FE,$DE,$A8,$A1,$A9,$9A,$AA,$DA
.byte $AA,$E0,$3C,$F8,$F6,$B0,$6A,$BD,$C7,$BE,$ED,$F2,$8E,$EF,$9C,$D6
.byte $D8,$A8,$ED,$BE,$EF,$F3,$0C,$D6,$D8,$18,$ED,$2E,$EF,$3C,$D6,$D8
.byte $18,$ED,$F2,$BE,$EF,$F3,$0C,$D6,$D8,$F2,$A8,$F3,$00,$F6,$30,$15
.byte $BD,$FF,$FF,$EC,$9A,$4A,$3A,$ED,$4A,$3A,$1A,$EE,$3A,$1A,$F2,$9A
.byte $EF,$F2,$BC,$F3,$1C,$4C,$8C,$9C,$F4,$1C,$F6,$B0,$6A,$BD,$C7,$BE
.byte $ED,$F2,$8E,$EF,$9C,$D6,$D8,$A8,$ED,$BE,$EF,$F3,$0C,$D6,$D8,$18

;; [$AA00 :: 0x36a00]

.byte $ED,$F2,$BE,$EF,$F3,$0C,$D6,$D8,$F2,$A8,$ED,$8E,$EF,$9C,$D6,$D8
.byte $78,$90,$F6,$30,$15,$BD,$FF,$FF,$EC,$F3,$98,$E9,$4C,$3C,$2C,$ED
.byte $48,$EA,$3C,$2C,$1C,$EE,$38,$EB,$2C,$1C,$0C,$EF,$18,$EC,$0C,$F2
.byte $BC,$AC,$FC,$A4,$A9,$F6,$70,$66,$BE,$C7,$BE,$EF,$F3,$A5,$EC,$9B
.byte $C6,$EF,$45,$EC,$9B,$C6,$EF,$75,$EC,$5B,$C6,$EF,$15,$EC,$2B,$C6
.byte $EF,$41,$F6,$70,$AF,$BE,$FF,$FF,$EA,$4C,$EB,$5C,$EC,$4C,$ED,$5C
.byte $EE,$4C,$EF,$5C,$F6,$70,$66,$BE,$C7,$BE,$EF,$40,$15,$EC,$2B,$C6
.byte $EF,$45,$EC,$7B,$C6,$EF,$55,$EC,$4B,$C6,$EF,$95,$EC,$7B,$C6,$EF
.byte $40,$F6,$30,$15,$BD,$FF,$FF,$C2,$E9,$9B,$EA,$7B,$EB,$5B,$EC,$4B
.byte $ED,$3B,$EE,$2B,$EF,$1B,$0B,$FE,$A3,$A9,$F6,$B0,$AF,$BE,$FF,$FF
.byte $E8,$C8,$CB,$F7,$0F,$F0,$98,$F1,$48,$98,$F2,$48,$F0,$A8,$F1,$58
.byte $A8,$F2,$58,$FC,$A5,$AA,$F0,$98,$F1,$48,$98,$F2,$48,$F0,$A8,$F1
.byte $58,$AB,$EC,$F7,$08,$F2,$48,$9B,$CB,$AB,$CB,$9B,$CB,$48,$9B,$CB
.byte $AB,$CB,$9B,$CB,$FC,$C5,$AA,$FE,$A0,$AA,$F7,$10,$F1,$98,$F2,$48
.byte $98,$F3,$48,$F1,$A8,$F2,$58,$A8,$F3,$58,$FC,$DC,$AA,$FA,$F2,$98
.byte $4B,$CB,$F1,$95,$F2,$A8,$4B,$CB,$F1,$A5,$F3,$08,$F2,$4B,$CB,$05

;; [$AB00 :: 0x36b00]

.byte $A8,$4B,$CB,$F1,$A5,$FC,$EE,$AA,$FE,$DA,$AA,$11,$AB,$9B,$AB,$25
.byte $AC,$F6,$B0,$6A,$BD,$C7,$BE,$E0,$28,$F2,$58,$78,$F8,$95,$98,$A8
.byte $F3,$05,$28,$48,$55,$05,$98,$78,$58,$48,$FD,$3D,$AB,$55,$25,$08
.byte $F2,$78,$98,$A8,$93,$AB,$9B,$75,$58,$78,$FC,$1D,$AB,$F3,$55,$22
.byte $48,$58,$55,$E0,$26,$D5,$E0,$24,$D5,$F6,$70,$15,$BD,$FF,$FF,$C8
.byte $CB,$E0,$28,$F2,$5E,$8E,$F3,$1E,$53,$58,$38,$F2,$A8,$F3,$08,$18
.byte $02,$F2,$85,$A8,$F3,$08,$15,$38,$18,$03,$F2,$A8,$F3,$02,$D8,$08
.byte $18,$38,$53,$58,$38,$F2,$A8,$F3,$08,$18,$02,$D8,$08,$18,$38,$55
.byte $85,$75,$58,$38,$E0,$25,$55,$E0,$22,$D5,$E0,$1F,$45,$E0,$28,$F6
.byte $B0,$6A,$BD,$C7,$BE,$F2,$58,$78,$FE,$1C,$AB,$F6,$70,$15,$BD,$FF
.byte $FF,$EC,$C5,$F8,$F2,$58,$08,$F1,$A8,$F2,$08,$48,$08,$48,$78,$98
.byte $58,$08,$58,$98,$A8,$98,$78,$FD,$D5,$AB,$58,$28,$F1,$A8,$F2,$28
.byte $48,$08,$F1,$A8,$F2,$08,$58,$08,$F1,$A8,$F2,$08,$48,$08,$F1,$A8
.byte $F2,$08,$FC,$A4,$AB,$58,$28,$F1,$A8,$F2,$28,$08,$48,$78,$A8,$98
.byte $A8,$9C,$AC,$9C,$78,$92,$F8,$88,$58,$18,$08,$F1,$A8,$78,$F2,$75
.byte $88,$A8,$88,$78,$58,$38,$18,$08,$FD,$12,$AC,$F1,$A8,$F2,$18,$58

;; [$AC00 :: 0x36c00]

.byte $88,$78,$48,$08,$78,$88,$58,$08,$F1,$88,$98,$F2,$08,$58,$98,$FC
.byte $E7,$AB,$88,$58,$18,$08,$F1,$A8,$78,$F2,$75,$08,$58,$78,$A8,$F3
.byte $05,$C5,$FE,$A3,$AB,$C5,$F8,$F2,$52,$42,$22,$12,$F1,$A2,$F2,$02
.byte $FD,$38,$AC,$52,$02,$FC,$27,$AC,$52,$F1,$52,$F8,$F2,$12,$32,$F1
.byte $82,$F2,$52,$FD,$50,$AC,$F1,$A2,$F2,$02,$52,$F1,$52,$FC,$3C,$AC
.byte $F2,$12,$32,$02,$F3,$05,$C5,$FE,$26,$AC,$60,$AC,$C7,$AC,$0B,$AD
.byte $F6,$70,$26,$BD,$C7,$BE,$E0,$3C,$F1,$C3,$BA,$F2,$4A,$6A,$F8,$73
.byte $6B,$7B,$95,$25,$B5,$F3,$27,$0A,$F2,$B5,$95,$B5,$F3,$45,$28,$48
.byte $28,$F2,$98,$B1,$B5,$FD,$A8,$AC,$F3,$43,$48,$28,$F2,$98,$B8,$F3
.byte $08,$F2,$B5,$97,$F3,$0A,$F2,$B5,$75,$63,$68,$A5,$6A,$8A,$AA,$B1
.byte $F1,$BA,$F2,$4A,$6A,$FC,$6F,$AC,$F3,$45,$75,$68,$48,$28,$08,$F2
.byte $B5,$97,$F3,$0A,$F2,$B5,$75,$65,$D7,$6A,$B5,$3A,$4A,$6A,$41,$F1
.byte $BA,$F2,$4A,$6A,$FE,$6E,$AC,$F6,$70,$26,$BD,$C7,$BE,$EC,$C5,$C3
.byte $F8,$F1,$B2,$F2,$65,$05,$25,$95,$65,$35,$75,$75,$95,$68,$28,$25
.byte $05,$F1,$B8,$F2,$28,$58,$78,$73,$78,$65,$25,$75,$25,$25,$15,$FD
.byte $FF,$AC,$13,$F1,$B8,$A5,$F2,$15,$43,$38,$35,$C5,$FC,$D1,$AC,$F1

;; [$AD00 :: 0x36d00]

.byte $A5,$D7,$AA,$BA,$C7,$65,$71,$C5,$FE,$D0,$AC,$C5,$C3,$F8,$F2,$42
.byte $25,$65,$76,$CB,$66,$CB,$36,$CB,$F1,$B6,$CB,$F2,$45,$DB,$CB,$48
.byte $65,$DB,$CB,$68,$72,$52,$02,$25,$65,$46,$CB,$66,$CB,$76,$CB,$96
.byte $CB,$FD,$47,$AD,$A6,$CB,$66,$CB,$16,$CB,$66,$CB,$F1,$B6,$CB,$F2
.byte $66,$CB,$B5,$C5,$FC,$0E,$AD,$F2,$05,$45,$3A,$C7,$F1,$B5,$F2,$45
.byte $F1,$BA,$CA,$BA,$F2,$45,$C5,$FE,$0D,$AD,$60,$AD,$5E,$AE,$53,$AF
.byte $F6,$30,$37,$BD,$FF,$FF,$E0,$4B,$F1,$5C,$8C,$BC,$F2,$2C,$5C,$8C
.byte $BC,$F3,$2C,$5C,$8C,$BC,$F4,$2C,$C0,$C0,$F8,$F6,$70,$D2,$BD,$C7
.byte $BE,$F2,$98,$BB,$CB,$F3,$0B,$CB,$2B,$CB,$45,$0B,$CB,$7B,$CB,$65
.byte $26,$DE,$2E,$4E,$5B,$CB,$4B,$CB,$2B,$CB,$0B,$CB,$F2,$B3,$95,$F3
.byte $2B,$CB,$0B,$CB,$F2,$9B,$CB,$98,$85,$8B,$9B,$BB,$C6,$45,$FC,$81
.byte $AD,$F8,$F6,$70,$99,$BD,$C7,$BE,$F2,$55,$95,$F3,$05,$55,$FD,$DA
.byte $AD,$4B,$CB,$4B,$CB,$F6,$30,$37,$BD,$FF,$FF,$4B,$5B,$4B,$2B,$4B
.byte $5B,$4B,$2B,$4B,$5B,$4B,$2B,$FC,$B2,$AD,$F6,$30,$37,$BD,$FF,$FF
.byte $4B,$CB,$4B,$CB,$F2,$4C,$9C,$BC,$F3,$4D,$9D,$BD,$F4,$4D,$2C,$F3
.byte $BC,$8C,$5C,$4C,$2C,$F2,$BB,$8B,$5B,$2B,$C0,$C0,$F8,$F6,$30,$37

;; [$AE00 :: 0x36e00]

.byte $BD,$FF,$FF,$F3,$4D,$9D,$4D,$9D,$4C,$9C,$4C,$9B,$CB,$8B,$CB,$4D
.byte $7D,$4D,$7D,$4C,$7C,$4C,$7B,$CB,$6B,$CB,$2D,$5D,$2D,$5D,$2C,$5C
.byte $2C,$5B,$CB,$4B,$CB,$0D,$3D,$0D,$3D,$0C,$3C,$0C,$3B,$CB,$4B,$CB
.byte $F6,$70,$99,$BD,$C7,$BE,$F2,$98,$A8,$98,$F3,$18,$F2,$98,$A8,$98
.byte $F3,$28,$F2,$98,$A8,$98,$F3,$48,$F2,$98,$A8,$98,$F3,$58,$FC,$FD
.byte $AD,$F2,$95,$B5,$F3,$05,$25,$45,$55,$65,$85,$FE,$7A,$AD,$F6,$30
.byte $37,$BD,$FF,$FF,$E8,$CA,$F1,$5C,$8C,$BC,$F2,$2C,$5C,$8C,$BC,$F3
.byte $2C,$5C,$8C,$BC,$F4,$2C,$CC,$C8,$C1,$C0,$F8,$F6,$30,$04,$BD,$FF
.byte $FF,$EC,$F2,$08,$4B,$CB,$9B,$CB,$8B,$CB,$75,$46,$DE,$4E,$5E,$65
.byte $25,$9B,$CB,$7B,$CB,$5B,$CB,$4B,$CB,$25,$D6,$DE,$2E,$4E,$5B,$CB
.byte $C8,$05,$F1,$B5,$D6,$DE,$BE,$F2,$0E,$2B,$C6,$F1,$85,$FC,$82,$AE
.byte $F8,$F6,$30,$37,$BD,$FF,$FF,$EC,$F1,$98,$BB,$F2,$0B,$F1,$BB,$F2
.byte $0B,$2B,$4B,$28,$4B,$5B,$4B,$5B,$7B,$9B,$FD,$E2,$AE,$8B,$CB,$8B
.byte $C8,$CD,$E8,$F3,$4B,$5B,$4B,$2B,$4B,$5B,$4B,$2B,$4B,$5B,$4D,$FC
.byte $B7,$AE,$F2,$8B,$CB,$8B,$C8,$CD,$E8,$F2,$4C,$9C,$BC,$F3,$4D,$9D
.byte $BD,$F4,$4D,$2C,$F3,$BC,$8C,$5C,$4C,$2C,$F2,$BB,$8B,$2D,$C0,$C0

;; [$AF00 :: 0x36f00]

.byte $F8,$EA,$F6,$B0,$43,$BD,$CB,$BE,$F3,$03,$F2,$BB,$CB,$A3,$9B,$CB
.byte $83,$7B,$CB,$63,$8B,$CB,$F6,$30,$99,$BD,$C7,$BE,$EC,$F1,$98,$A8
.byte $98,$F2,$18,$F1,$98,$A8,$98,$F2,$28,$F1,$98,$A8,$98,$F2,$48,$F1
.byte $98,$A8,$98,$F2,$58,$FC,$02,$AF,$48,$58,$48,$88,$48,$58,$48,$98
.byte $48,$58,$BB,$5B,$2B,$5B,$9B,$6B,$0B,$6B,$8B,$4B,$F1,$BB,$F2,$4B
.byte $FE,$7A,$AE,$C2,$F1,$9B,$CB,$9B,$CB,$9B,$CB,$9B,$CB,$9B,$CB,$9B
.byte $CB,$7B,$CB,$7B,$CB,$9B,$CB,$9B,$CB,$9B,$CB,$9B,$CB,$9B,$CB,$9B
.byte $CB,$7B,$CB,$7B,$CB,$F8,$F1,$98,$F2,$9B,$CB,$F1,$B8,$F2,$BB,$CB
.byte $08,$F3,$0B,$CB,$F2,$28,$F3,$2B,$CB,$F1,$98,$F2,$9B,$CB,$F1,$B8
.byte $F2,$BB,$CB,$08,$F3,$0B,$CB,$F1,$98,$F2,$9B,$CB,$F2,$5B,$CB,$5B
.byte $CB,$5B,$CB,$5B,$CB,$5B,$CB,$5B,$CB,$5B,$CB,$5B,$CB,$4B,$CB,$4B
.byte $CB,$4B,$CB,$4B,$CB,$4B,$CB,$4B,$CB,$4B,$CB,$4B,$CB,$FC,$76,$AF
.byte $F8,$F2,$5B,$CB,$5B,$CB,$4B,$CB,$4B,$CB,$2B,$CB,$2B,$CB,$0B,$CB
.byte $0B,$CB,$F1,$BB,$CB,$BB,$CB,$C1,$FC,$C1,$AF,$98,$A8,$98,$F2,$18
.byte $F1,$98,$A8,$98,$F2,$28,$F1,$98,$A8,$98,$F2,$48,$F1,$98,$A8,$98
.byte $F2,$58,$F8,$F1,$98,$A8,$98,$F2,$18,$F1,$98,$A8,$98,$F2,$28,$F1

;; [$B000 :: 0x37000]

.byte $98,$A8,$98,$F2,$48,$F1,$98,$A8,$98,$F2,$58,$F1,$9B,$CB,$9B,$CB
.byte $C5,$9B,$CB,$9B,$CB,$C5,$9B,$CB,$9B,$CB,$C5,$9B,$CB,$9B,$CB,$C5
.byte $FC,$F3,$AF,$F2,$95,$85,$75,$55,$45,$25,$05,$F1,$B5,$FE,$75,$AF
.byte $36,$B0,$C6,$B1,$A7,$B3,$F6,$30,$99,$BD,$C7,$BE,$E0,$4B,$F2,$3E
.byte $4E,$5E,$F8,$62,$72,$FD,$51,$B0,$82,$93,$DB,$3E,$4E,$5E,$FC,$43
.byte $B0,$82,$93,$9D,$BD,$F3,$0D,$1D,$F8,$F3,$25,$05,$F2,$A5,$95,$FC
.byte $59,$B0,$F6,$30,$37,$BD,$FF,$FF,$F3,$28,$08,$F2,$A8,$98,$F3,$28
.byte $08,$F2,$A8,$98,$F3,$2B,$0B,$F2,$AB,$9B,$F3,$0B,$F2,$AB,$9B,$7B
.byte $AB,$9B,$7B,$6B,$9B,$7B,$6B,$3B,$F6,$70,$99,$BD,$C7,$BE,$F8,$EF
.byte $F2,$1F,$2F,$DC,$D6,$35,$78,$AB,$CB,$F3,$2B,$CB,$0F,$1F,$DC,$DB
.byte $F2,$AB,$CB,$75,$F3,$4F,$5F,$DC,$DB,$4B,$CB,$18,$2B,$CB,$9F,$AF
.byte $DC,$DB,$98,$68,$78,$F4,$38,$28,$F3,$98,$A8,$F4,$58,$F6,$70,$D2
.byte $BD,$C7,$BE,$40,$30,$F6,$70,$99,$BD,$C7,$BE,$F3,$18,$2B,$CB,$ED
.byte $18,$2B,$CB,$EB,$18,$2B,$CB,$E9,$18,$2B,$CB,$FD,$F1,$B0,$E7,$18
.byte $2B,$CB,$E5,$18,$2B,$CB,$E3,$18,$2B,$CB,$E2,$18,$2B,$CB,$FC,$8F
.byte $B0,$E7,$18,$2B,$CB,$E5,$18,$2B,$CB,$E3,$18,$2B,$CB,$EF,$F2,$7C

;; [$B100 :: 0x37100]

.byte $9C,$AC,$F3,$0C,$1C,$2C,$F8,$38,$2B,$CB,$0B,$CB,$F2,$AB,$CB,$98
.byte $AB,$CB,$9B,$CB,$7B,$CB,$65,$25,$F3,$25,$F2,$98,$F3,$08,$FD,$38
.byte $B1,$F2,$A8,$7B,$CB,$F3,$12,$F2,$A8,$7B,$CB,$F3,$21,$F2,$7C,$9C
.byte $AC,$F3,$0C,$1C,$2C,$FC,$07,$B1,$F2,$88,$A8,$F3,$08,$28,$38,$28
.byte $08,$F2,$A8,$95,$65,$F3,$25,$C8,$F6,$30,$37,$BD,$FF,$FF,$F4,$7E
.byte $2E,$F3,$9E,$7E,$2E,$F2,$9E,$F8,$EA,$F2,$98,$88,$78,$68,$58,$48
.byte $38,$28,$FC,$58,$B1,$EF,$38,$68,$98,$F3,$08,$EC,$F2,$38,$68,$98
.byte $F3,$08,$E9,$F2,$38,$68,$98,$F3,$08,$E6,$F2,$38,$68,$98,$F3,$08
.byte $F8,$EA,$F2,$98,$88,$78,$68,$58,$48,$38,$28,$FC,$81,$B1,$EF,$3A
.byte $6A,$9A,$4A,$7A,$AA,$5A,$8A,$BA,$6A,$9A,$F3,$0A,$F2,$7A,$AA,$F3
.byte $1A,$F2,$8A,$BA,$F3,$2A,$F2,$9A,$F3,$0A,$3A,$F2,$AA,$F3,$1A,$4A
.byte $F6,$B0,$66,$BE,$C7,$BE,$52,$42,$35,$05,$22,$32,$22,$05,$F2,$A5
.byte $95,$F3,$25,$FE,$88,$B0,$F6,$70,$87,$BE,$C7,$BE,$EC,$CB,$F8,$F2
.byte $22,$32,$42,$52,$FC,$CF,$B1,$F8,$F6,$30,$37,$BD,$FF,$FF,$2B,$F1
.byte $9B,$6B,$9B,$F2,$4B,$0B,$F1,$7B,$F2,$0B,$5B,$2B,$F1,$AB,$F2,$2B
.byte $6B,$2B,$F1,$9B,$F2,$2B,$FC,$DE,$B1,$6B,$2B,$4B,$0B,$2B,$F1,$AB

;; [$B200 :: 0x37200]

.byte $F2,$0B,$F1,$9B,$F2,$6B,$2B,$4B,$0B,$2B,$F1,$AB,$F2,$0B,$F1,$9B
.byte $F2,$AB,$9B,$7B,$6B,$9B,$7B,$6B,$3B,$7B,$6B,$3B,$2B,$6B,$3B,$2B
.byte $0B,$F8,$F6,$30,$D2,$BD,$C7,$BE,$EC,$F1,$A5,$F2,$05,$25,$35,$C8
.byte $28,$18,$C8,$A8,$98,$C8,$F3,$18,$28,$08,$F2,$A8,$98,$78,$68,$58
.byte $38,$4B,$7B,$4B,$7B,$4B,$7B,$4B,$7B,$4B,$7B,$4B,$7B,$4B,$7B,$4B
.byte $7B,$3B,$6B,$3B,$6B,$3B,$6B,$3B,$6B,$3B,$6B,$3B,$6B,$3B,$6B,$3B
.byte $6B,$18,$2B,$CB,$EA,$18,$2B,$CB,$E8,$18,$2B,$CB,$E6,$18,$2B,$CB
.byte $E4,$18,$2B,$CB,$E3,$18,$2B,$CB,$E2,$18,$2B,$CB,$E1,$18,$2B,$CB
.byte $FC,$28,$B2,$F8,$EC,$78,$5B,$CB,$3B,$CB,$2B,$CB,$08,$2B,$CB,$0B
.byte $CB,$F1,$AB,$CB,$95,$A5,$F2,$05,$35,$FD,$B3,$B2,$2B,$CB,$2B,$CB
.byte $15,$2B,$CB,$2B,$CB,$15,$5B,$CB,$5B,$CB,$45,$9B,$CB,$9B,$CB,$75
.byte $FC,$84,$B2,$3C,$5C,$3C,$5C,$3C,$5C,$3B,$CB,$28,$0C,$2C,$0C,$2C
.byte $0C,$2C,$0B,$CB,$F1,$A8,$F2,$32,$25,$C5,$F8,$F6,$30,$37,$BD,$FF
.byte $FF,$F2,$7B,$F1,$7B,$F2,$6B,$F1,$7B,$F2,$5B,$F1,$7B,$F2,$4B,$F1
.byte $7B,$F2,$3B,$F1,$7B,$F2,$2B,$F1,$7B,$F2,$1B,$F1,$7B,$F2,$0B,$F1
.byte $7B,$FC,$D1,$B2,$B8,$F2,$28,$58,$88,$E9,$F1,$B8,$F2,$28,$58,$88

;; [$B300 :: 0x37300]

.byte $E6,$F1,$B8,$F2,$28,$58,$88,$E3,$F1,$B8,$F2,$28,$58,$88,$F8,$EC
.byte $F2,$7B,$F1,$7B,$F2,$6B,$F1,$7B,$F2,$5B,$F1,$7B,$F2,$4B,$F1,$7B
.byte $F2,$3B,$F1,$7B,$F2,$2B,$F1,$7B,$F2,$1B,$F1,$7B,$F2,$0B,$F1,$7B
.byte $FC,$0F,$B3,$BA,$F2,$2A,$5A,$0A,$3A,$6A,$1A,$4A,$7A,$2A,$5A,$8A
.byte $3A,$6A,$9A,$4A,$7A,$AA,$5A,$8A,$BA,$6A,$9A,$F3,$0A,$F2,$5B,$8B
.byte $F3,$0B,$F2,$8B,$5B,$8B,$F3,$0B,$F2,$8B,$4B,$8B,$F3,$0B,$F2,$8B
.byte $4B,$8B,$F3,$0B,$F2,$8B,$3B,$8B,$AB,$8B,$3B,$8B,$AB,$8B,$2B,$8B
.byte $F3,$0B,$F2,$8B,$2B,$8B,$F3,$0B,$F2,$8B,$3B,$8B,$F3,$0B,$F2,$8B
.byte $3B,$8B,$F3,$0B,$F2,$8B,$2B,$7B,$AB,$7B,$2B,$7B,$AB,$7B,$1B,$4B
.byte $7B,$4B,$F1,$AB,$F2,$4B,$7B,$4B,$F1,$9B,$F2,$0B,$6B,$0B,$F1,$9B
.byte $F2,$0B,$6B,$0B,$FE,$21,$B2,$CB,$F7,$07,$F2,$2B,$CB,$2B,$CB,$2B
.byte $CB,$2B,$CB,$2B,$CB,$2B,$CB,$2B,$CB,$2B,$CB,$FC,$AA,$B3,$65,$35
.byte $05,$F1,$95,$FB,$F1,$78,$F2,$6E,$7C,$DB,$88,$78,$F1,$78,$F2,$6E
.byte $7C,$DB,$88,$78,$FC,$C4,$B3,$F8,$F1,$7D,$CD,$AD,$CD,$7D,$CD,$F2
.byte $0D,$CD,$F1,$7D,$CD,$F2,$2D,$CD,$F1,$7D,$CD,$F2,$4D,$CD,$F1,$7D
.byte $CD,$AD,$CD,$7D,$CD,$F2,$0D,$CD,$F1,$7D,$CD,$F2,$2D,$CD,$F1,$7D

;; [$B400 :: 0x37400]

.byte $CD,$F2,$4D,$CD,$FC,$D8,$B3,$FB,$F1,$78,$F2,$6E,$7C,$DB,$88,$78
.byte $F1,$78,$F2,$6E,$7C,$DB,$88,$78,$FC,$08,$B4,$F8,$F1,$7D,$CD,$AD
.byte $CD,$7D,$CD,$F2,$0D,$CD,$F1,$7D,$CD,$F2,$2D,$CD,$F1,$7D,$CD,$F2
.byte $4D,$CD,$F1,$7D,$CD,$AD,$CD,$7D,$CD,$F2,$0D,$CD,$F1,$7D,$CD,$F2
.byte $2D,$CD,$F1,$7D,$CD,$F2,$4D,$CD,$FC,$1C,$B4,$F8,$0B,$CB,$0B,$CB
.byte $C8,$0B,$CB,$0B,$CB,$0B,$CB,$C8,$0B,$CB,$28,$F1,$98,$F2,$28,$F1
.byte $98,$F2,$28,$F1,$98,$F2,$28,$F1,$98,$FD,$8E,$B4,$78,$F2,$78,$F1
.byte $78,$F2,$78,$F1,$78,$F2,$78,$F1,$78,$F2,$78,$F1,$58,$F2,$58,$F1
.byte $58,$F2,$58,$F1,$58,$F2,$58,$F1,$58,$F2,$58,$FC,$4C,$B4,$F1,$88
.byte $F2,$88,$F1,$88,$F2,$88,$F1,$78,$F2,$78,$F1,$78,$F2,$78,$68,$58
.byte $48,$38,$25,$C5,$F8,$F1,$78,$88,$98,$A8,$B8,$F2,$08,$18,$28,$FC
.byte $A5,$B4,$75,$55,$35,$15,$F1,$B5,$95,$75,$55,$F8,$F1,$78,$88,$98
.byte $A8,$B8,$F2,$08,$18,$28,$FC,$BC,$B4,$F1,$B5,$F2,$05,$15,$25,$35
.byte $45,$55,$65,$5B,$CB,$5B,$CB,$C8,$5B,$CB,$4B,$CB,$4B,$CB,$C8,$4B
.byte $CB,$3B,$CB,$3B,$CB,$C8,$3B,$CB,$2B,$CB,$2B,$CB,$C8,$2B,$CB,$0B
.byte $CB,$0B,$CB,$C8,$0B,$CB,$F1,$AB,$CB,$AB,$CB,$C8,$AB,$CB,$9B,$CB

;; [$B500 :: 0x37500]

.byte $9B,$CB,$C8,$9B,$CB,$F2,$2B,$CB,$2B,$CB,$C8,$2B,$CB,$FE,$C3,$B3
.byte $16,$B5,$21,$B5,$FF,$FF,$E0,$4B,$F6,$B0,$6A,$BD,$FB,$BE,$F4,$B0
.byte $FF,$F6,$B0,$6A,$BD,$FD,$BE,$F4,$B0,$FF,$30,$B5,$96,$B5,$F5,$B5
.byte $F6,$70,$37,$BD,$FF,$FF,$E0,$49,$F0,$3C,$7C,$AC,$F1,$3C,$7C,$AC
.byte $F2,$3C,$7C,$AC,$F3,$3C,$7C,$AC,$F6,$70,$D2,$BD,$C7,$BE,$F4,$3C
.byte $CC,$3C,$CC,$3C,$CC,$35,$F3,$B5,$F4,$15,$3A,$CA,$1A,$31,$F8,$F6
.byte $70,$15,$BD,$FF,$FF,$F2,$A5,$85,$A5,$88,$F3,$18,$D8,$18,$05,$18
.byte $05,$08,$FD,$85,$B5,$F2,$A5,$85,$75,$88,$F6,$70,$43,$BD,$C7,$BE
.byte $58,$D0,$FC,$5F,$B5,$F2,$A5,$85,$A5,$F3,$18,$F6,$70,$43,$BD,$C7
.byte $BE,$38,$D0,$FE,$5E,$B5,$F6,$70,$37,$BD,$FF,$FF,$E9,$CA,$F0,$3C
.byte $7C,$AC,$F1,$3C,$7C,$AC,$F2,$3C,$7C,$AC,$F3,$3C,$F6,$70,$D2,$BD
.byte $C7,$BE,$EC,$7C,$CC,$7C,$CC,$7C,$CC,$75,$35,$55,$7A,$CA,$5A,$71
.byte $F8,$F6,$70,$15,$BD,$FF,$FF,$F2,$75,$55,$75,$58,$58,$D8,$58,$35
.byte $58,$35,$38,$FD,$E5,$B5,$75,$55,$35,$58,$F6,$70,$43,$BD,$C7,$BE
.byte $18,$D0,$FC,$C1,$B5,$75,$55,$35,$18,$F1,$F6,$70,$43,$BD,$C7,$BE
.byte $B8,$D0,$FE,$C0,$B5,$C2,$F3,$3C,$CC,$F2,$AC,$CC,$7C,$CC,$35,$65

;; [$B600 :: 0x37600]

.byte $85,$3A,$CA,$3C,$CC,$36,$CB,$36,$CB,$36,$CB,$F9,$38,$AB,$CB,$38
.byte $AB,$CB,$38,$AB,$CB,$38,$AB,$CB,$18,$8B,$CB,$18,$8B,$CB,$18,$8B
.byte $CB,$18,$8B,$CB,$FC,$0C,$B6,$38,$AB,$CB,$38,$AB,$CB,$38,$AB,$CB
.byte $38,$AB,$CB,$F1,$B8,$F2,$6B,$CB,$F1,$B8,$F2,$6B,$CB,$F1,$B8,$F2
.byte $6B,$CB,$F1,$B8,$F2,$6B,$CB,$FE,$0B,$B6,$50,$B6,$78,$B6,$C4,$B6
.byte $F6,$70,$87,$BE,$C7,$BE,$E0,$32,$F2,$95,$F3,$21,$F2,$95,$F3,$41
.byte $F2,$95,$F3,$51,$78,$98,$75,$22,$28,$48,$52,$75,$55,$45,$55,$45
.byte $05,$20,$D1,$F2,$95,$FE,$5A,$B6,$F6,$70,$AF,$BE,$FF,$FF,$EC,$C5
.byte $F2,$28,$58,$48,$58,$28,$58,$08,$58,$18,$78,$58,$78,$48,$78,$18
.byte $78,$58,$98,$78,$98,$58,$98,$48,$98,$78,$B8,$98,$B8,$78,$B8,$58
.byte $B8,$58,$A8,$98,$A8,$78,$A8,$58,$A8,$48,$A8,$98,$A8,$78,$A8,$48
.byte $A8,$28,$98,$78,$98,$68,$98,$48,$98,$28,$98,$78,$98,$48,$78,$18
.byte $78,$FE,$80,$B6,$C5,$F2,$20,$10,$00,$F1,$B0,$A0,$F2,$00,$20,$D2
.byte $F1,$92,$FE,$C5,$B6,$DB,$B6,$03,$B7,$0F,$B7,$F6,$70,$87,$BE,$C7
.byte $BE,$E0,$2D,$F3,$62,$F2,$B8,$F3,$18,$28,$48,$63,$28,$63,$28,$63
.byte $F2,$B8,$F3,$28,$F2,$B8,$78,$F3,$28,$F2,$B2,$C8,$F3,$48,$28,$18

;; [$B700 :: 0x37700]

.byte $FE,$E3,$B6,$F6,$70,$87,$BE,$E0,$BE,$EA,$CB,$CD,$FE,$E3,$B6,$F8
.byte $F2,$6B,$BB,$F3,$2B,$6B,$FC,$10,$B7,$F8,$F2,$4B,$7B,$BB,$F3,$4B
.byte $FC,$1A,$B7,$F7,$06,$F2,$6B,$BB,$F3,$2B,$6B,$FC,$25,$B7,$F2,$5B
.byte $8B,$BB,$F3,$2B,$F2,$4B,$7B,$AB,$F3,$2B,$F8,$F2,$6B,$BB,$F3,$2B
.byte $6B,$F2,$4B,$7B,$BB,$F3,$4B,$FC,$3B,$B7,$FE,$0F,$B7,$53,$B7,$72
.byte $B7,$7E,$B7,$F6,$30,$37,$BD,$FF,$FF,$E0,$25,$FA,$F3,$4B,$1B,$F2
.byte $9B,$6B,$FC,$5C,$B7,$FA,$F3,$3B,$1B,$F2,$9B,$6B,$FC,$66,$B7,$FE
.byte $5B,$B7,$F6,$30,$37,$BD,$DD,$BE,$EA,$CD,$CF,$FE,$5B,$B7,$F2,$20
.byte $F1,$B0,$FE,$7E,$B7,$8B,$B7,$B1,$B7,$16,$B8,$F6,$70,$6A,$BD,$C7
.byte $BE,$F2,$2F,$DF,$E0,$3C,$F3,$DE,$5E,$6E,$75,$48,$78,$65,$28,$68
.byte $45,$08,$48,$35,$F2,$B5,$F3,$03,$08,$45,$38,$48,$60,$C0,$FE,$AD
.byte $B7,$F6,$70,$15,$BD,$C7,$BE,$EA,$CB,$F1,$BB,$F2,$4B,$7B,$BB,$F1
.byte $BB,$F2,$4B,$7B,$BB,$F1,$9B,$F2,$2B,$6B,$9B,$F1,$9B,$F2,$2B,$6B
.byte $9B,$F1,$7B,$F2,$0B,$4B,$7B,$F1,$7B,$F2,$0B,$4B,$7B,$F1,$6B,$BB
.byte $F2,$3B,$6B,$F1,$6B,$BB,$F2,$3B,$6B,$F1,$4B,$9B,$F2,$0B,$4B,$F1
.byte $4B,$9B,$F2,$0B,$4B,$F1,$7B,$F2,$0B,$4B,$7B,$F1,$7B,$F2,$0B,$4B

;; [$B800 :: 0x37800]

.byte $7B,$E0,$3A,$F1,$68,$E0,$38,$B8,$E0,$36,$F2,$38,$E0,$34,$68,$E0
.byte $32,$B2,$C0,$FE,$12,$B8,$CB,$F2,$42,$22,$02,$F1,$B2,$92,$F2,$02
.byte $F1,$B0,$C0,$FE,$22,$B8,$2C,$B8,$60,$B8,$74,$B8,$F6,$70,$37,$BD
.byte $FF,$FF,$EC,$E0,$55,$F8,$F1,$78,$6B,$5B,$A8,$9B,$8B,$F2,$18,$0B
.byte $F1,$BB,$F2,$48,$3B,$2B,$FC,$36,$B8,$F8,$F1,$98,$8B,$7B,$F2,$08
.byte $F1,$BB,$AB,$F2,$38,$2B,$1B,$68,$5B,$4B,$FC,$4A,$B8,$FE,$35,$B8
.byte $F6,$70,$87,$BE,$C7,$BE,$F2,$A2,$F3,$12,$F2,$70,$F3,$02,$32,$F2
.byte $90,$FE,$66,$B8,$F8,$F2,$1B,$CB,$1B,$CB,$1B,$CB,$1B,$CB,$1B,$CB
.byte $1B,$CB,$1B,$CB,$1B,$CB,$FC,$75,$B8,$F8,$3B,$CB,$3B,$CB,$3B,$CB
.byte $3B,$CB,$3B,$CB,$3B,$CB,$3B,$CB,$3B,$CB,$FC,$8A,$B8,$FE,$74,$B8
.byte $A6,$B8,$E0,$B8,$3F,$B9,$F6,$70,$6A,$BD,$C7,$BE,$E0,$58,$F8,$F3
.byte $75,$B2,$B5,$62,$68,$98,$98,$C8,$98,$C8,$41,$FD,$CC,$B8,$65,$92
.byte $95,$42,$48,$78,$78,$C8,$78,$C8,$21,$FC,$AF,$B8,$F4,$05,$F3,$B3
.byte $68,$95,$73,$48,$48,$48,$48,$C8,$28,$C8,$F2,$75,$C2,$FE,$AE,$B8
.byte $F6,$70,$6A,$BD,$C7,$BE,$EC,$F8,$F2,$B5,$F3,$22,$25,$F2,$92,$98
.byte $F3,$08,$08,$C8,$08,$C8,$2E,$0C,$DB,$F2,$B8,$98,$78,$68,$48,$22

;; [$B900 :: 0x37900]

.byte $35,$42,$65,$78,$B8,$B8,$C8,$B8,$C8,$F3,$0E,$F2,$BC,$DB,$98,$78
.byte $68,$48,$28,$F1,$B5,$F2,$25,$75,$75,$95,$B5,$F3,$05,$F2,$95,$45
.byte $F3,$2E,$0C,$DB,$F2,$B8,$98,$78,$68,$48,$35,$45,$65,$75,$95,$B5
.byte $F3,$08,$08,$08,$C8,$F2,$68,$C8,$C1,$FC,$E8,$B8,$FE,$E7,$B8,$F8
.byte $F2,$73,$C8,$78,$C8,$73,$C8,$78,$C8,$93,$C8,$98,$C8,$93,$C8,$98
.byte $C8,$FD,$67,$B9,$23,$C8,$28,$C8,$23,$C8,$28,$C8,$73,$C8,$78,$C8
.byte $73,$C8,$78,$C8,$FC,$40,$B9,$B3,$C8,$B8,$C8,$43,$C8,$48,$C8,$28
.byte $C8,$28,$C8,$28,$C8,$78,$F1,$B8,$F2,$08,$28,$48,$68,$FE,$3F,$B9
.byte $86,$B9,$B0,$B9,$CC,$B9,$F6,$30,$37,$BD,$FF,$FF,$E0,$3C,$F7,$0C
.byte $F3,$AC,$4C,$FC,$91,$B9,$F7,$0C,$9C,$2C,$FC,$98,$B9,$F7,$0C,$AC
.byte $4C,$FC,$9F,$B9,$F7,$0C,$F4,$0C,$F3,$6C,$FC,$A6,$B9,$FE,$8E,$B9
.byte $F6,$70,$15,$BD,$FF,$FF,$EA,$F2,$0B,$1B,$3B,$4B,$3B,$4B,$6B,$7B
.byte $6B,$7B,$9B,$AB,$9B,$AB,$F3,$0B,$1B,$FE,$B7,$B9,$F2,$0B,$1B,$3B
.byte $4B,$3B,$4B,$6B,$7B,$6B,$7B,$9B,$AB,$9B,$AB,$F3,$0B,$1B,$FE,$CC
.byte $B9,$E7,$B9,$3D,$BB,$78,$BC,$F6,$30,$15,$BD,$FF,$FF,$EC,$E0,$37
.byte $F8,$F3,$28,$F2,$B8,$78,$48,$F3,$28,$F2,$B8,$78,$48,$F3,$28,$F2

;; [$BA00 :: 0x37A00]

.byte $B8,$78,$48,$F3,$28,$F2,$B8,$78,$48,$FD,$27,$BA,$F3,$18,$F2,$B8
.byte $78,$48,$F3,$18,$F2,$B8,$78,$48,$F3,$18,$F2,$B8,$78,$48,$F3,$18
.byte $F2,$B8,$78,$48,$FC,$F1,$B9,$E0,$35,$F3,$18,$E0,$33,$F2,$B8,$E0
.byte $31,$78,$E0,$2F,$48,$E0,$2D,$F3,$18,$E0,$2B,$F2,$B8,$E0,$29,$78
.byte $E0,$27,$48,$E0,$24,$F3,$18,$E0,$22,$F2,$B8,$E0,$20,$78,$E0,$1E
.byte $48,$E0,$1B,$F3,$18,$E0,$19,$F2,$B8,$E0,$16,$78,$E0,$14,$48,$D8
.byte $F6,$70,$43,$BD,$C7,$BE,$EF,$F8,$E0,$2E,$72,$F3,$22,$F2,$B1,$95
.byte $75,$43,$68,$78,$B8,$91,$26,$7E,$F3,$0E,$2E,$43,$48,$68,$78,$98
.byte $68,$22,$48,$28,$08,$F2,$B8,$95,$43,$68,$78,$98,$E0,$2C,$72,$E0
.byte $2A,$62,$E0,$2E,$72,$F3,$22,$F2,$B1,$95,$75,$43,$68,$78,$B8,$91
.byte $26,$7E,$F3,$0E,$2E,$43,$48,$68,$78,$98,$68,$22,$48,$28,$08,$F2
.byte $B8,$95,$58,$78,$E0,$2D,$95,$B8,$F3,$08,$E0,$2B,$22,$E0,$28,$45
.byte $E0,$26,$65,$E0,$2E,$72,$65,$45,$22,$F2,$B2,$F3,$42,$65,$48,$68
.byte $70,$42,$25,$05,$F2,$B5,$98,$F3,$08,$F2,$B5,$95,$E0,$2C,$72,$E0
.byte $2A,$98,$78,$E0,$28,$68,$78,$E0,$25,$B2,$E0,$23,$92,$FC,$68,$BA
.byte $F6,$B0,$43,$BD,$C7,$BE,$EC,$E0,$2E,$71,$F3,$25,$F2,$B2,$95,$85

;; [$BB00 :: 0x37B00]

.byte $98,$B8,$F3,$08,$F2,$B8,$98,$88,$68,$88,$98,$B8,$F3,$08,$F2,$B8
.byte $F3,$08,$28,$48,$68,$E8,$F8,$F3,$72,$92,$B0,$92,$B2,$FD,$29,$BB
.byte $F4,$05,$F3,$95,$65,$95,$FC,$17,$BB,$E0,$2C,$F4,$05,$E0,$2A,$F3
.byte $95,$E0,$28,$65,$E0,$26,$95,$B0,$70,$C0,$FE,$39,$BB,$F6,$30,$15
.byte $BD,$E0,$BE,$E9,$CB,$F8,$F3,$28,$F2,$B8,$78,$48,$F3,$28,$F2,$B8
.byte $78,$48,$F3,$28,$F2,$B8,$78,$48,$F3,$28,$F2,$B8,$78,$48,$F3,$18
.byte $F2,$B8,$78,$48,$F3,$18,$F2,$B8,$78,$48,$FD,$7C,$BB,$F3,$18,$F2
.byte $B8,$78,$48,$F3,$18,$F2,$B8,$78,$48,$FC,$46,$BB,$F3,$18,$F2,$B8
.byte $78,$48,$F3,$18,$F2,$B8,$78,$4B,$D8,$F6,$30,$43,$BD,$C7,$BE,$EA
.byte $F8,$F1,$B2,$98,$B8,$F2,$08,$48,$25,$F1,$B5,$F2,$68,$48,$28,$08
.byte $F1,$B2,$98,$78,$68,$48,$73,$98,$62,$F2,$48,$28,$08,$F1,$B8,$95
.byte $F2,$65,$28,$08,$F1,$B8,$98,$85,$F2,$45,$02,$F1,$92,$F2,$22,$02
.byte $F1,$B2,$98,$B8,$F2,$08,$48,$25,$F1,$B5,$F2,$68,$48,$28,$08,$F1
.byte $B2,$98,$78,$68,$48,$73,$98,$62,$F2,$48,$28,$08,$F1,$B8,$95,$F2
.byte $65,$28,$08,$F1,$B8,$98,$85,$F2,$45,$05,$F1,$98,$B8,$F2,$05,$28
.byte $48,$72,$65,$95,$B2,$72,$62,$72,$78,$68,$48,$28,$38,$48,$68,$98

;; [$BC00 :: 0x37C00]

.byte $78,$98,$B8,$98,$78,$68,$48,$28,$72,$62,$28,$48,$65,$55,$25,$F1
.byte $B5,$F2,$45,$18,$28,$45,$61,$F1,$9C,$BC,$F2,$0C,$2C,$4C,$6C,$FC
.byte $91,$BB,$E5,$F1,$B5,$F2,$25,$F1,$95,$B8,$F2,$08,$F1,$B8,$98,$75
.byte $85,$B5,$F2,$03,$08,$F1,$85,$B5,$95,$48,$78,$62,$EC,$F8,$F2,$71
.byte $F3,$25,$F2,$B2,$95,$85,$98,$B8,$F3,$08,$F2,$B8,$98,$88,$68,$88
.byte $98,$B8,$F3,$08,$F2,$B8,$F3,$08,$28,$48,$68,$FC,$3E,$BC,$E0,$24
.byte $78,$28,$E0,$22,$08,$28,$E0,$20,$F2,$B8,$F3,$28,$E0,$1E,$F2,$98
.byte $F3,$28,$F2,$70,$C0,$FE,$74,$BC,$F6,$FF,$FF,$FF,$DD,$BE,$F8,$F2
.byte $00,$D0,$F1,$90,$D0,$FC,$7F,$BC,$C8,$F8,$F2,$75,$25,$62,$42,$22
.byte $02,$12,$22,$02,$02,$22,$F1,$B2,$F2,$42,$F1,$92,$F2,$45,$15,$20
.byte $75,$25,$62,$42,$22,$02,$12,$22,$02,$02,$22,$F1,$B2,$F2,$42,$52
.byte $42,$22,$05,$65,$72,$02,$F1,$B2,$F2,$42,$02,$F1,$B2,$F2,$40,$00
.byte $75,$65,$52,$42,$F1,$92,$F2,$20,$FC,$8A,$BC,$F9,$72,$62,$52,$42
.byte $F1,$92,$B2,$F2,$02,$22,$FC,$CC,$BC,$72,$25,$05,$F1,$72,$C0,$FE
.byte $DE,$BC,$E8,$BC,$FF,$FF,$FF,$FF,$E0,$4B,$F6,$70,$37,$BD,$FF,$FF
.byte $FA,$F4,$0F,$F3,$BF,$AF,$9F,$8F,$7F,$6F,$5F,$4F,$3F,$2F,$1F,$0F

;; [$BD00 :: 0x37D00]

.byte $FC,$F1,$BC,$FF
;; ========== song data ($9E4B-$BD03) END ==========


;; ========== volume/pitch envelope data ($BD04-$BEFF) START ==========
;; [$BD04 :: 0x37D04]
VPBD04:
.byte $2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26,$25,$24
.byte $23,$22,$21,$10,$00
VPBD15:
.byte $2F,$2E,$2D,$2C,$2B,$2A,$29,$28,$37,$46,$45
.byte $44,$43,$42,$41,$10,$00
VPBD26:
.byte $2F,$2E,$2D,$2C,$2B,$2A,$29,$68,$77,$86
.byte $85,$94,$B3,$D2,$F1,$10,$00
VPBD37:
.byte $2F,$2D,$2B,$29,$27,$55,$94,$B3,$D2
.byte $F1,$10,$00
VPBD43:
.byte $15,$16,$17,$18,$29,$2A,$2B,$2C,$2D,$2F,$2D,$2F,$2D
.byte $2F,$2D,$2F,$2D,$2F,$2D,$2F,$2D,$2F,$2D,$2F,$2D,$4C,$4B,$4A,$59
.byte $58,$57,$66,$65,$64,$73,$72,$71,$10,$00
VPBD6A:
.byte $17,$19,$1B,$1D,$2F,$2E
.byte $2F,$2E,$2F,$2E,$2F,$2E,$2F,$2D,$2B,$2E,$2C,$2A,$2D,$2B,$29,$2C
.byte $2A,$28,$2B,$29,$27,$2A,$28,$26,$29,$27,$25,$28,$26,$24,$27,$25
.byte $23,$26,$24,$22,$25,$23,$21,$10,$00
VPBD99:
.byte $16,$1F,$18,$1F,$1A,$1F,$1B
.byte $1F,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$3B,$39,$37,$35,$33,$31
.byte $10,$00
VPBDD2:
.byte $1F,$16,$18,$19,$1A,$1B,$1C,$1D,$1E,$2F,$2E,$2D,$2E,$2F
.byte $2E,$2D,$2E,$2F,$2E,$2D,$2E,$2F,$2E,$2D,$2E,$2F,$2E,$2D,$2E,$2F
.byte $2E,$2D,$2E,$2F,$2E,$2D,$2E,$2F,$2E,$3B,$39,$37,$35,$33,$31,$10
;; [$BE00 :: 0x37E00]
.byte $00
;??
VPBE01:
.byte $16,$1F,$18,$1F,$1A,$1F,$1B,$1F,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D
.byte $1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$1F,$1D,$1E,$1C,$3B,$39
.byte $37,$35,$33,$31,$10,$00
VPBE66:
.byte $16,$13,$16,$18,$1A,$1C,$1E,$2F,$1D,$1E
.byte $1C,$3F,$1D,$1E,$1C,$FF,$CF,$2E,$2D,$2C,$2B,$2A,$29,$28,$27,$26
.byte $25,$24,$23,$22,$21,$10,$00
VPBE87:
.byte $23,$25,$27,$29,$2B,$2D,$3F,$3C,$3F
.byte $3C,$3F,$3C,$3F,$3B,$3E,$3A,$3D,$39,$3C,$38,$3B,$37,$3A,$36,$39
.byte $35,$38,$34,$37,$33,$36,$32,$35,$31,$34,$33,$32,$31,$10,$00
APBEAF:
.byte $1B
.byte $1C,$1D,$1E,$1F,$1E,$1D,$1C,$1B,$1A,$19,$18,$17,$26,$25,$24,$23
.byte $22,$21,$10,$00
APBEC4:
.byte $40,$F1,$00
APBEC7:
.byte $F0,$49,$41,$02
APBECB:
.byte $70,$39,$32,$3A,$32
.byte $3A,$32,$3B,$34,$3C,$02,$F0,$49,$41,$49,$32,$3A,$02,$49,$41,$02
.byte $F9,$49,$41,$02,$49,$42,$4A,$42,$4A,$42,$4B,$44,$4C,$02
APBEDD:
.byte $F0,$49
.byte $42,$4A,$42,$4A,$42,$4B,$44,$4C,$02
APBEF9:
.byte $FA,$00,$11,$01,$13,$11,$01
;; ========== volume/pitch envelope data ($BD04-$BEFF) END ==========
