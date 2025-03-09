.include "Constants.inc"
.include "variables.inc"
.include "score.inc"

.import Init_Page2			;C46E
.import Get_key				;DBA9
.import Palette_copy			;DC30
.import Init_CHR_RAM			;E491		
.import	Init_icon_tiles			;E6E1
.import Clear_Nametable0		;F321
.import Wait_NMI			;FE00

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
	JMP Sound_test_			; 8000	$4C 

.if 1
; Name	: Sound_proc
; Marks	: update sound
Sound_proc:
	LDA $7F43          		; 36/8003: AD 43 7F   branch if not song $37
	CMP #$37           		; 36/8006: C9 37     
	BNE B8011          		; 36/8008: D0 07     
	LDA #$00           		; 36/800A: A9 00      no sound effect
	STA $7F49          		; 36/800C: 8D 49 7F  
	BEQ B8014          		; 36/800F: F0 03     
B8011:
	;JSR $8B9D          		; 36/8011: 20 9D 8B   update sound effects
B8014:
	JSR $8925          		; 36/8014: 20 25 89   update music
	LDA $4015          		; 36/8017: AD 15 40  
	ORA #$0F           		; 36/801A: 09 0F     
	STA $4015          		; 36/801C: 8D 15 40   enable all channels except dmc
	JSR $8030          		; 36/801F: 20 30 80   update apu (sound effects)
	JSR $80AB          		; 36/8022: 20 AB 80   update apu (music)
	ASL $7F40          		; 36/8025: 0E 40 7F  
	LDA $7F42          		; 36/8028: AD 42 7F   roll "enable music" bit into $7F40
	ASL                		; 36/802B: 0A        
	ROR $7F40          		; 36/802C: 6E 40 7F  
	RTS                		; 36/802F: 60        
; End of Sound_proc(update sound)
.endif

; Name	:
; Marks	:
Sound_test_:
; Name	:
; Marks	: Show Title story ??
		; Disable PPU
	LDA #$00			; B890 $A9 $00
	STA PpuMask_2001		; B892 $8D $01 $20
		; Palette buffer($03C0-$03DF) to set #$0F ??
	LDX #$1F			; B895 $A2 $1F
	LDA #$0F			; B897 $A9 $0F
L3B899:
	STA palette_UBGC,X		; B899 $9D $C0 $03
	DEX				; B89C $CA
	BPL L3B899			; B89D $10 $FA
		; Set some tile(ICONS) and palettes to PPU
		;JSR Init_CHR_RAM		; B89F $20 $91 $E4
		; Init some variables and PPU
	JSR NT0_OAM_init		; B8A2 $20 $06 $B9
	LDA PpuStatus_2002		; B8A5 $Ad $02 $20
	LDA #$20			; B8A5 $A9 $20
	STA PpuAddr_2006		; B8AA $8D $06 $20
	LDA #$00			; B8AD $A9 $00
	STA PpuAddr_2006		; B8AF $8D $06 $20
	LDX #$F0			; B8B2 $A2 $F0
	LDA #$FF			; B8B4 $A9 $FF
		; Fill Nametable0 to #$FF ($2000-$23C0)
L3B8B6:
	STA PpuData_2007		; B8B6 $8D $07 $20
	STA PpuData_2007		; B8B9 $8D $07 $20
	STA PpuData_2007		; B8BC $8D $07 $20
	STA PpuData_2007		; B8BF $8D $07 $20
	DEX				; B8C2
	BNE L3B8B6			; B8C3 $D0 $F1
	LDX #$40			; B8C5 $A2 $40
	LDA #$55			; B8C7 $A9 $55
		; Fill Nametable0 attribute set #$55
L3B8C9:
	STA PpuData_2007		; B8C9 $8D $07 $20
	DEX				; B8CC $CA
	BNE L3B8C9			; B8CD $D0 $FA
	LDA #$02			; B8CF $A9 $02
	STA palette_BG11		; B8D1 $8D $C6 $03
	STA palette_BG12		; B8D4 $8D $C7 $03
	STA palette_BG21		; B8D7 $8D $CA $03
	STA palette_BG22		; B8DA $8D $CB $03
	JSR Wait_NMI			; B8DD $20 $00 $FE
	JSR Palette_copy		; B8E0 $20 $30 $DC
	LDA #$00			; B8E3 $A9 $00
	STA PpuScroll_2005		; B8E5 $8D $05 $20
	STA PpuScroll_2005		; B8E8 $8D $05 $20
		; Show background
	LDA #$0A			; B8E8 $A9 $0A
	STA PpuMask_2001		; B8ED $8D $01 $20
	LDX #$18			; B8F0 $A2 $18
; load tiles
	LDA PpuStatus_2002		; ????  $A9 $02 $20
	LDA #$00			; hide sprites/background
	STA PpuMask_2001		; ????  $8D $01 $20
	JSR Clear_Nametable0		;
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
	LDA #$02			; ????  $A9 $02		copy OAM buffer(200h) to PPU
	STA SpriteDma_4014		; C04B  $8D $14 $40
	LDA #$1A			; Set palettes
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
	JSR Palette_copy		; C04E  $20 $30 $DC
	LDA #$08			; Copy sprites
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
	LDA #$18			; Show sprites/background
	STA PpuMask_2001		; ????  $8D $01 $20
	LDA #$41
	STA $82
	JSR Cursor_init
	LDA #$68
	STA oam_y
	;added for FF3
.if 1
	JSR Init_sound
.endif
	;
MAIN_LOOP:
	JSR Wait_NMI
	LDA #$02			; 811A  $A9 $02		copy OAM buffer(200h) to PPU
	STA SpriteDma_4014		; 811C  $8D $14 $40
	LDA #$00			; ????  $A9 $00
	STA PpuScroll_2005		; ????  $8D $05 $20
	STA PpuScroll_2005		; ????  $8D $05 $20
	JSR Sound_proc			; 80C3	$20 $A9 $DB
; bank 0E test code
		;LDA #$1E
		;STA bank
		;JSR $C74F			; 80C3	$20 $4F $C7
; end of bank 0E test code
	JSR Get_key
	LDA key1p
	BNE Key_proc
	JMP MAIN_LOOP			; LOOP
Key_proc:
	AND #$01			; Right key
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
	LDA #$02			; ????  $A9 $02		copy OAM buffer(200h) to PPU
	STA SpriteDma_4014		; ????  $8D $14 $40
	LDA #$00			; ????  $A9 $00
	STA PpuScroll_2005		; ????  $8D $05 $20
	STA PpuScroll_2005		; ????  $8D $05 $20
	JSR Sound_proc			; ????	$20 $A9 $DB	Init ??
	JSR Get_key
	LDA key1p
	CMP $21
	BEQ WAIT_KEY_REL
	JMP MAIN_LOOP			; LOOP

; Name	: Set_OAM
; X	: OAM number
; Marks	:
Set_OAM:
	LDA oam_y
	STA $0210,X			; Y
	LDA $82
	STA $0211,X			; INDEX
	LDA #$03
	STA $0212,X			; ATTR
	LDA oam_x
	STA $0213,X			; X
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
	STA $0211			; BGM left
	LDA $82
	AND #$0F
	ORA #$80
	STA $0215			; BGM right
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
	STA $0219			; BGM left
	LDA $83
	AND #$0F
	ORA #$80
	STA $021D			; BGM right
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
	STA $0200,X			; Y
	LDA oam_x
	STA $0203,X			; X
	LDA $80
	STA $0201,X			; INDEX
	CLC
	ADC #$01
	STA $80
	LDA #$03
	STA $0202,X			; ATTR
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

; Name	: NT0_OAM_init
; Marks	: PPU enable
;	  Clear nametable0
;	  Variables initialization
;	  PPU init OAM to #$F0
;	  BGM set prelude
NT0_OAM_init:
	LDA #BGM_prelude		; B906 $A9 $41
	STA current_song_ID		; B908 $85 $E0
	JSR Clear_Nametable0		; B90A $20 $21 $F3
	LDA #$88			; B90D $A9 $88
	STA $FF				; B90F $85 $FF
	STA PpuControl_2000		; B911 $8D $00 $20
	LDA #$01			; B914 $A9 $01
	STA $37				; B916 $85 $37
	JSR Get_udlr			; B918 $20 $B6 $8E
	LDA #$00			; B91B $A9 $00
	STA $A2				; B91D $85 $A2
	STA $A3				; B91F $85 $A3
	STA $A4				; B921 $85 $A4
	JSR Init_Page2			; B923 $20 $6E $C4
	JSR Wait_NMI			; B926 $20 $00 $FE
	JSR Wait_NMI			; B929 $20 $00 $FE
	LDA #$02			; B92C $A9 $02
	STA SpriteDma_4014		; B92E $8D $14 $40
	RTS				; B931 $60
; End of NT0_OAM_init

; Name	: Get_udlr
; DEST	: bank($57) = bank #$0E
;	  key udlr($A1)
; Marks	: Init var and bank set to #$0E
Get_udlr:
	LDA #$00			; 8EB6	$A9 $00
	STA a_pressing			; 8EB8	$85 $24
	STA b_pressing			; 8EB8	$85 $25
	STA player_mv_timer		; 8EB8	$85 $47
	STA $A3				; 8EB8	$85 $A3
	STA $A4				; 8EB8	$85 $A4
	JSR Get_key			; 8EC2	$20 $A9 $DB
	LDA key1p			; 8EC5	$A5 $20
	AND #$0F			; 8EC7	$29 $0F
	STA $A1				; 8EC9	$85 $A1			; key udlr
	LDA #$0E			; 8ECB	$A9 $0E
	STA bank			; 8ECD	$85 $57
	RTS				; 8ECF	$60
; End of Get_udlr

; For FF2
.if 0
; ------------------------------------------------------------

; Name	:
; Marks	: Sound processing subroutine
;	  $C0 = Update flag for $4000-$4003
;	  $C1 = Update flag for $4004-$4007
;	  $C2 = Update flag for $4008-$400B
;	  $E0 = Current ID(bit.7=Load previous song??, bit.6=)
;	  $E5 = sound effect counter (mute square 2 music channel)
;	  $6F19,$6F1A,$6F1B,$6F1C = $4000-$4003 temp
;	  $6F1D,$6F1E,$6F1F,$6F20 = $4004-$4007 temp
;	  $6F21,$6F22,$6F23,$6F24 = $4008-$400B temp
;	  $6F00 = tempo
;	  $6F06 = Sum of tempo
Sound_proc:
	LDA #$00			; 9800	$A9 $00
	STA $C0				; 9802	$85 $C0
	STA $C1				; 9804	$85 $C1
	STA $C2				; 9806	$85 $C2
	LDA $E5				; 9808	$A5 $E5		sound effect counter (mute square 2 music channel)
	BEQ L3581A			; 980A	$F0 $0E		branch if sound effects are not playing ??
	DEC $E5				; 980C	$C6 $E5
	BNE L3581A			; 980E	$D0 $0A
	LDA #$30			; 9810	$A9 $30
	STA Sq1Duty_4004		; 9812	$8D $04 $40
	LDA #$00			; 9815	$A9 $00
	STA SQ2_Note_Value		; 9817	$8D $1F $6F
L3581A:
	LDA current_song_ID		; 981A	$A5 $E0
	ASL A				; 981C	$0A
	BCC L35832			; 981D	$90 $13		branch if A.bit7 is 0
	JSR Load_p_song			; 981F	$20 $A9 $98	Load previous sound
	LDA #$00			; 9822	$A9 $00
	STA current_song_ID		; 9824	$85 $E0
	STA $6F1B			; 9826	$8D $1B $6F	Sq0Timer $4002 temp
	STA $6F1F			; 9829	$8D $1F $6F	Sq1Timer $4006 temp
	STA $6F23			; 982C	$8D $23 $6F	$400A temp
	JMP L35863			; 982F	$4C $63 $98
L35832:
	ASL A				; 9832	$0A
	BCC L35863			; 9833	$90 $2E		branch if A.bit6 is 0
	LDA current_song_ID		; 9835	$A5 $E0
	AND #$3F			; 9837	$29 $3F
	STA current_song_ID		; 9839	$85 $E0
	CMP current_BGM_ID		; 983B	$CD $25 $6F
	BEQ L35847			; 983E	$F0 $07
	JSR Save_c_song			; 9840	$20 $8E $98	Backup all data(APU temp)
L382B2_:
	JSR LoadNewBGM			; 9843	$20 $67 $98	Load new BGM
	RTS				; 9846	$60
; End of
L35847:
	CMP #$09			; 9847	$C9 $09		Keyword sound effect
	BEQ L382B2_			; 9849	$F0 $F8		branch if keyword sound effect play
	LDA #$30			; 984B	$A9 $30
	STA Sq0Duty_4000		; 984D	$8D $00 $40
	STA Sq1Duty_4004		; 9850	$8D $04 $40
	LDA #$80			; 9853	$A9 $80
	STA TrgLinear_4008		; 9855	$8D $08 $40
	LDA #$00			; 9858	$A9 $00
	STA $6F1B			; 985A	$8D $1B $6F	tmp sq04002
	STA $6F1F			; 985D	$8D $1F $6F	tmp sq14006
	STA $6F23			; 9860	$8D $23 $6F	tmp trg400A
L35863:
	JSR J990E			; 9863	$20 $0E $99	APU process - $82D2
	RTS				; 9866	$60
; End of

; Name	: LoadNewBGM
; Marks	: Get 6 data(score address)
;	  Load settings(CH0, CH1, TRI)
;	  $6F25 = Current ID
;	  +$B0 = CH0 address
;	  +$B2 = CH1 address
;	  +$B4 = TRI address
;	  $E6 = ??
;	  +C8 = Song score pointer
LoadNewBGM:
	LDA current_song_ID		; 9867	$A5 $E0
	STA current_BGM_ID		; 9869	$8D $25 $6F
	ASL A				; 986C	$0A
	TAX				; 986D	$AA
	LDA Song_p_tbl_L,X		; 986E	$BD $0D $9E
	STA $C8				; 9871	$85 $C8
	LDA Song_p_tbl_H,X		; 9873	$BD $0E $9E
	STA $C9				; 9876	$85 $C9
	LDY #$00			; 9878	$A0 $00
	LDX #$00			; 987A	$A2 $00
LoadNewBGM_set_ch:
	LDA ($C8),Y			; 987C	$B1 $C8
	STA $B0,X			; 987E	$95 $B0
	INY				; 9880	$C8
	INX				; 9881	$E8
	CPX #$06			; 9882	$E0 $06
	BCC LoadNewBGM_set_ch		; 9884	$90 $F6
	JSR J98C4			; 9886	$20 $C4 $98	Init temp
	LDA #$00			; 9889	$A9 $00
	STA $E6				; 988B	$85 $E6
	RTS				; 988D	$60
; End of

; Name	: Save_c_song
; Marks	: Backup all data(Save current song)
;	  $B0-$C1 -> $6F26-$6F37 = backup
;	  $6F00-$6F25 -> $6F38-$6F5D = backup
Save_c_song:
	LDX #$00			; 988E	$A2 $00
Save_c_song_r1:
	LDA SQ0FramePosition,X		; 9890	$B5 $B0
	STA $6F26,X			; 9892	$9D $26 $6F
	INX				; 9895	$E8
	CPX #$12			; 9896	$E0 $12
	BCC Save_c_song_r1		; 9898	$90 $F6
	LDY #$00			; 989A	$A0 $00
Save_c_song_r2:
	LDA song_tempo,Y		; 989C	$B9 $00 $6F
	STA $6F26,X			; 989F	$9D $26 $6F
	INX				; 98A2	$E8
	INY				; 98A3	$C8
	CPY #$26			; 98A4	$C0 $26
	BCC Save_c_song_r2		; 98A6	$90 $F4
	RTS				; 98A8	$60
; End of Save_c_song

; Name	: Load_p_song
; Marks	: Load previous sound after sound effect done
;	  $6F26- = Backuped sound registers(56 bytes ??)
Load_p_song:
	LDX #$00			; 98A9	$A2 $00
Load_p_song_r1:
	LDA $6F26,X			; 98AB	$BD $26 $6F
	STA $B0,X			; 98AE	$95 $B0
	INX				; 98B0	$E8
	CPX #$12			; 98B1	$E0 $12
	BCC Load_p_song_r1		; 98B3	$90 $F6
	LDY #$00			; 98B5	$A0 $00
Load_p_song_r2:
	LDA $6F26,X			; 98B7	$BD $26 $6F
	STA song_tempo,Y		; 98BA	$99 $00 $6F
	INX				; 98BD	$E8
	INY				; 98BE	$C8
	CPY #$26			; 98BF	$C0 $26
	BCC Load_p_song_r2		; 98C1	$90 $F4
	RTS				; 98C3	$60
; End of Load_p_song

; Name	:
; Marks	: Init temp
;	  $B6-$B9 = ??
;	  $BA-$BF = ??
;	  $6F06-$6F09 = tempo_cnt, Sq0tick_cnt, Sq1tick_cnt, Trgtick_cnt
;	  $6F04 = ch volume temp(high nibble)
;	  $6F05 = ??
;	  $6F00 = temp offset base value ??
;	  $-$ -> $6F19-$6F24 = ??
J98C4:
	LDX #$00			; 98C4	$A2 $00
	LDA #$FF			; 98C6	$A9 $FF
L358C8:
	STA $B6,X			; 98C8	$95 $B6
	INX				; 98CA	$E8
	CPX #$04			; 98CB	$E0 $04
	BCC L358C8			; 98CD	$90 $F9
	LDX #$00			; 98CF	$A2 $00
L358D1:
	STA $BA,X			; 98D1	$95 $BA
	INX				; 98D3	$E8
	CPX #$06			; 98D4	$E0 $06
	BCC L358D1			; 98D6	$90 $F9
	LDX #$00			; 98D8	$A2 $00
	LDA #$00			; 98DA	$A9 $00
L358DC:
	STA $6F06,X			; 98DC	$9D $06 $6F	tempo_cnt, Sq0tick_cnt, Sq1tick_cnt, Trgtick_cnt
	INX				; 98DF	$E8
	CPX #$04			; 98E0	$E0 $04
	BCC L358DC			; 98E2	$90 $F8
	LDA #$0F			; 98E4	$A9 $0F
	STA Sq0Vol			; 98E6	$8D $04 $6F
	STA Sq1Vol			; 98E9	$8D $05 $6F
	LDA #$4B			; 98EC	$A9 $4B
	STA song_tempo			; 98EE	$8D $00 $6F
	LDX #$00			; 98F1	$A2 $00
	STX ApuStatus_4015		; 98F3	$8E $15 $40
L358F6:
	LDA D9902,X			; 98F6	$BD $02 $99
	STA $6F19,X			; 98F9	$9D $19 $6F
	INX				; 98FC	$E8
	CPX #$0C			; 98FD	$E0 $0C
	BCC L358F6			; 98FF	$90 $F5
	RTS				; 9901	$60
; End of

;; [$9902 :: 0x35902]
; data - APU temp register initial value
D9902:
.byte $30,$08,$00,$00,$30,$08,$00,$00,$80,$00,$00,$00

; Name	:
; Marks	: APU process
J990E:
	LDA song_tempo			; 990E	$AD $00 $6F
	CLC				; 9911	$18
	ADC tempo_cnt			; 9912	$6D $06 $6F
	STA tempo_cnt			; 9915	$8D $06 $6F	Total tempo
J9918:
	LDA tempo_cnt			; 9918	$AD $06 $6F
	CMP #$4B			; 991B	$C9 $4B
	BCC L3592A			; 991D	$90 $0B
	SBC #$4B			; 991F	$E9 $4B
	STA tempo_cnt			; 9921	$8D $06 $6F
	JSR J9931			; 9924	$20 $31 $99	Check and data process
	JMP J9918			; 9927	$4C $18 $99
L3592A:
	JSR J9B22			; 992A	$20 $22 $9B	Settings parameter process(Volume/Envelope, Timer)
	JSR Update_APU_reg		; 992D	$20 $1F $9C	Update APU registers
	RTS				; 9930	$60
; End of

; Name	:
; Marks	: Check and data process (CH0, CH1, TRI)
;	  $B0,$B1 = CH0
;	  $B2,$B3 = CH1
;	  $B4,$B5 = TRI
;	  +$C3 = CH data address
;	  $C5, $C6, $C7 = temp CH data address position(+1, +2, +4)
;	  $6F07 = CH0 tick/rest count
;	  $6F08 = CH1 tick/rest count
;	  $6F09 = TRI tick/rest count
J9931:
	LDA #$00			; 9931	$A9 $00
	STA $C5				; 9933	$85 $C5
; Set ch address position
L35935:
	LDA $C5				; 9935	$A5 $C5
	TAY				; 9937	$A8
	ASL A				; 9938	$0A
	STA $C6				; 9939	$85 $C6
	TAX				; 993B	$AA
	ASL A				; 993C	$0A
	STA $C7				; 993D	$85 $C7
	LDA $B0,X			; 993F	$B5 $B0
	STA $C3				; 9941	$85 $C3
	LDA $B1,X			; 9943	$B5 $B1
	STA $C4				; 9945	$85 $C4
	CMP #$FF			; 9947	$C9 $FF
	BEQ L35968			; 9949	$F0 $1D		branch if address is 0xFFxx
;exception ??
	LDA $6F07,Y			; 994B	$B9 $07 $6F	ch tick/rest count
	BNE L35963			; 994E	$D0 $13
	LDY #$00			; 9950	$A0 $00
	JSR J9971			; 9952	$20 $71 $99	Data process
	LDX $C6				; 9955	$A6 $C6
	TYA				; 9957	$98		Increase data address(for next data)
	CLC				; 9958	$18
	ADC $C3				; 9959	$65 $C3
	STA $B0,X			; 995B	$95 $B0		////debug - apply ch address count
	LDA #$00			; 995D	$A9 $00
	ADC $C4				; 995F	$65 $C4
	STA $B1,X			; 9961	$95 $B1
;tick/rest count --
L35963:
	LDX $C5				; 9963	$A6 $C5
	DEC $6F07,X			; 9965	$DE $07 $6F	ch tick/rest count
;Next ch
L35968:
	INC $C5				; 9968	$E6 $C5
	LDA $C5				; 996A	$A5 $C5
	CMP #$03			; 996C	$C9 $03
	BCC L35935			; 996E	$90 $C5		branch if ch is not trgger - next ch
	RTS				; 9970	$60
; End of

; Name	:
; Marks	: Data process
J9971:
	LDA ($C3),Y			; 9971	$B1 $C3
	INY				; 9973	$C8
	CMP #$E0			; 9974	$C9 $E0
	BCS L3597C			; 9976	$B0 $04
	JSR J99C8			; 9978	$20 $C8 $99	if A<E0h
	RTS				; 997B	$60
; Enf of
L3597C:
	BNE L35984			; 997C	$D0 $06
	JSR Set_tempo			; 997E	$20 $4C $9A	if A == E0h
	JMP J9971			; 9981	$4C $71 $99	goto Data process
L35984:
	CMP #$F0			; 9984	$C9 $F0
	BCS L3598E			; 9986	$B0 $06
	JSR Set_vol			; 9988	$20 $53 $9A	if A<F0h
	JMP J9971			; 998B	$4C $71 $99	goto Data process
L3598E:
	CMP #$F6			; 998E	$C9 $F6
	BCS L35998			; 9990	$B0 $06
	JSR J9A5B			; 9992	$20 $5B $9A	if A<F6h
L35995:
	JMP J9971			; 9995	$4C $71 $99	goto Data process
L35998:
	BNE L359A0			; 9998	$D0 $06
	JSR J9A63			; 999A	$20 $63 $9A	if A==F6h - Load and Set Setting parameters
	JMP J9971			; 999D	$4C $71 $99	goto Data process
L359A0:
	CMP #$FC			; 99A0	$C9 $FC
	BCS L359AA			; 99A2	$B0 $06
	JSR J9A82			; 99A4	$20 $82 $9A
	JMP J9971			; 99A7	$4C $71 $99	goto Data process
L359AA:
	BNE L359B2			; 99AA	$D0 $06
	JSR J9A95			; 99AC	$20 $95 $9A
	JMP J9971			; 99AF	$4C $71 $99	goto Data process
L359B2:
	CMP #$FE			; 99B2	$C9 $FE		$8467
	BCS L359BC			; 99B4	$B0 $06
	JSR J9AB1			; 99B6	$20 $B1 $9A
	JMP J9971			; 99B9	$4C $71 $99	goto Data process
L359BC:
	BNE L359C4			; 99BC	$D0 $06
	JSR J9ACE			; 99BE	$20 $CE $9A	if A==FEh
	JMP J9971			; 99C1	$4C $71 $99	goto Data process
L359C4:
	JSR Ch_end			; 99C4	$20 $DF $9A	if A==FFh	Reset data ??
	RTS				; 99C7	$60
; End of

; Name	:
; Marks	: Normal data process
;	  $C7 = ??
;	  $C8 = data
J99C8:
	STA $C8				; 99C8	$85 $C8		data
	AND #$0F			; 99CA	$29 $0F
	TAX				; 99CC	$AA
	LDA D9CFD,X			; 99CD	$BD $FD $9C	tick table ??
	LDX $C5				; 99D0	$A6 $C5		CHx1
	STA $6F07,X			; 99D2	$9D $07 $6F	CH tick/rest count
	LDA $C8				; 99D5	$A5 $C8		data
	CMP #$D0			; 99D7	$C9 $D0
	BCC L359DC			; 99D9	$90 $01		branch if A < D0h
	RTS				; 99DB	$60
L359DC:
	CMP #$C0			; 99DC	$C9 $C0
	BCC L359FE			; 99DE	$90 $1E		branch if A < C0h
	LDA #$01			; 99E0	$A9 $01
	STA $C0,X			; 99E2	$95 $C0
	LDX $C7				; 99E4	$A6 $C7
	LDA #$00			; 99E6	$A9 $00
	STA $6F1B,X			; 99E8	$9D $1B $6F	$4002,$4006,$400A
	CPX #$08			; 99EB	$E0 $08
	BEQ L359F8			; 99ED	$F0 $09
	LDA $6F19,X			; 99EF	$BD $19 $6F	$4000,$4004,$4008
	AND #$F0			; 99F2	$29 $F0
	STA $6F19,X			; 99F4	$9D $19 $6F
	RTS				; 99F7	$60
;End of

L359F8:
.byte $A9,$80,$8D,$21,$6F,$60
L359FE:
	CPX #$02			; 99FE	$E0 $02
	BNE L35A07			; 9A00	$D0 $05
	LDA #$FF			; 9A02	$A9 $FF
	STA $6F21			; 9A04	$8D $21 $6F
L35A07:
	LDA #$00			; 9A07	$A9 $00
	STA $6F13,X			; 9A09	$9D $13 $6F
	STA $6F0A,X			; 9A0C	$9D $0A $6F
	STA $6F16,X			; 9A0F	$9D $16 $6F
	STA $6F0D,X			; 9A12	$9D $0D $6F
	LDA #$0F			; 9A15	$A9 $0F
	STA $C0,X			; 9A17	$95 $C0
	LDA $6F01,X			; 9A19	$BD $01 $6F
	ASL A				; 9A1C	$0A
	ASL A				; 9A1D	$0A
	ASL A				; 9A1E	$0A
	STA $C9				; 9A1F	$85 $C9
	LDA $6F01,X			; 9A21	$BD $01 $6F
	ASL A				; 9A24	$0A
	ASL A				; 9A25	$0A
	ADC $C9				; 9A26	$65 $C9
	STA $C9				; 9A28	$85 $C9
	LDA $C8				; 9A2A	$A5 $C8		data
	LSR A				; 9A2C	$4A
	LSR A				; 9A2D	$4A
	LSR A				; 9A2E	$4A
	LSR A				; 9A2F	$4A
	CLC				; 9A30	$18
	ADC $C9				; 9A31	$65 $C9
	ASL A				; 9A33	$0A
	TAX				; 9A34	$AA
	LDA D9C6D,X			; 9A35	$BD $6D $9C
	STA $C8				; 9A38	$85 $C8
	LDA D9C6E,X			; 9A3A	$BD $6E $9C
	STA $C9				; 9A3D	$85 $C9
	LDX $C7				; 9A3F	$A6 $C7
	LDA $C8				; 9A41	$A5 $C8
	STA $6F1B,X			; 9A43	$9D $1B $6F	$4002,$4006,$400A
	LDA $C9				; 9A46	$A5 $C9
	STA $6F1C,X			; 9A48	$9D $1C $6F	$4003,$4007,$400B
	RTS				; 9A4B	$60
; End of

; Name	: Set_tempo
; Marks	: Set tempo
Set_tempo:
	LDA ($C3),Y			; 9A4C	$B1 $C3
	INY				; 9A4E	$C8
	STA song_tempo			; 9A4F	$8D $00 $6F
	RTS				; 9A52	$60
; End of

; Name	: Set_vol
; Marks	: Set volume
;	  $6F04,$6F05,$0F06 = ch volume temp(high nibble : only 1h-Fh)
Set_vol:
	AND #$0F			; 9A53	$29 $0F
	LDX $C5				; 9A55	$A6 $C5
	STA $6F04,X			; 9A57	$9D $04 $6F
	RTS				; 9A5A	$60
; End of

J9A5B:
	AND #$0F			; 9A5B	$29 $0F
	LDX $C5				; 9A5D	$A6 $C5
	STA $6F01,X			; 9A5F	$9D $01 $6F
	RTS				; 9A60	$60
; End of

; Name	:
; Marks	: Load and Set settings (A/B Volume/Envelope)
;	  +$B6,+$B8,+$BA = ??
;	  +$BA =
J9A63:
	LDA ($C3),Y			; 9A63	$B1 $C3
	INY				; 9A65	$C8
	LDX $C7				; 9A66	$A6 $C7		temp CH $4000/$4004/$4008 address
	STA $6F19,X			; 9A68	$9D $19 $6F
	LDX $C6				; 9A6B	$A6 $C6
	LDA ($C3),Y			; 9A6D	$B1 $C3
	INY				; 9A6F	$C8
	STA $B6,X			; 9A70	$95 $B6
	LDA($C3),Y			; 9A72	$B1 $C3
	INY				; 9A74	$C8
	STA $B7,X			; 9A75	$95 $B7
	LDA ($C3),Y			; 9A77	$B1 $C3
	INY				; 9A79	$C8
	STA $BA,X			; 9A7A	$95 $BA
	LDA ($C3),Y			; 9A7C	$B1 $C3
	INY				; 9A7E	$C8
	STA $BB,X			; 9A7F	$95 $BB
	RTS				; 9A81	$60
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
	LDA ($C3),Y			; 9ACE	$B1 $C3
	INY				; 9AD0	$C8
	STA $C8				; 9AD1	$85 $C8
	LDA ($C3),Y			; 9AD3	$B1 $C3
	INY				; 9AD5	$C8
	STA $C4				; 9AD6	$85 $C4
	LDA $C8				; 9AD8	$A5 $C8
	STA $C3				; 9ADA	$85 $C3
	LDY #$00			; 9ADC	$A0 $00
	RTS				; 9ADE	$60
; End of

; Name	: Ch_end
; Marks	: Channel score end
;	  $C5, $C6, $C7 = temp CH data address position(+1, +2, +4)
;	  +$B0 = CH0 address
;	  +$B2 = CH1 address
;	  +$B4 = TRI address
Ch_end:
	LDX $C6				; 9ADF	$A6 $C6
	LDA #$FF			; 9AE1	$A9 $FF
	STA $B6,X			; 9AE3	$95 $B6
	STA $B7,X			; 9AE5	$95 $B7
	STA $BA,X			; 9AE7	$95 $BA
	STA $BB,X			; 9AE9	$95 $BB
	STA $B0,X			; 9AEB	$95 $B0
	STA $B1,X			; 9AED	$95 $B1
	STA $C3				; 9AEF	$85 $C3
	STA $C4				; 9AF1	$85 $C4
	LDY #$00			; 9AF3	$A0 $00
	LDX $C5				; 9AF5	$A6 $C5
	LDA #$01			; 9AF7	$A9 $01
	STA $C0,X			; 9AF9	$95 $C0
	LDX $C7				; 9AFB	$A6 $C7
	LDA #$00			; 9AFD	$A9 $00
	STA $6F1B,X			; 9AFF	$9D $1B $6F	$4002,$4006,$400A
	CPX #$08			; 9B02	$E0 $08
	BEQ Ch_end_tri			; 9B04	$F0 $05		branch if Channel is TRIANGLE
	LDA #$F0			; 9B06	$A9 $F0
	JMP Ch_end_ch01			; 9B08	$4C $0D $9B
; End of
Ch_end_tri:
	LDA #$00			; 9B0B	$A9 $00
Ch_end_ch01:
	STA $6F19,X			; 9B0D	$9D $19 $6F	$4000,$4004,$4008 <- F0h,F0h,00h
	LDA #$FF			; 9B10	$A9 $FF
	LDX #$00			; 9B12	$A2 $00
Ch_end_chk:
	CMP $B0,X			; 9B14	$D5 $B0
	BNE Ch_end_ing			; 9B16	$D0 $09		branch if CH0 address is not FFh
	INX				; 9B18	$E8
	CPX #$06			; 9B19	$E0 $06
	BCC Ch_end_chk			; 9B1B	$90 $F7
	LDA #$80			; 9B1D	$A9 $80
	STA current_song_ID		; 9B1F	$85 $E0
Ch_end_ing:
	RTS				; 9B21	$60
; End of

; Name	:
; Marks	: Settings parameter process
;	  +$C3 = setting A/B ?? address(temp)
;	  $B6,$B7 = CH0 A
;	  $B8,$B9 = CH1 A
;	  $BA,$BB = CH0 B
;	  $BC,$BD = CH1 B
;	  $C5, $C6, $C7 = temp CH data address position(+1, +2, +4)
J9B22:
	LDA #$00			; 9B22	$A9 $00
	STA $C5				; 9B24	$85 $C5
L35B26:
	LDA $C5				; 9B26	$A5 $C5
	ASL A				; 9B28	$0A
	STA $C6				; 9B29	$85 $C6
	TAX				; 9B2B	$AA
	ASL A				; 9B2C	$0A
	STA $C7				; 9B2D	$85 $C7
	TAY				; 9B2F	$A8
	LDA $6F1B,Y			; 9B30	$B9 $1B $6F	$4002,$4006,$400A temp - ch timer
	BEQ L35B4D			; 9B33	$F0 $18		branch if ch timer is 0
	LDA $B6,X			; 9B35	$B5 $B6
	STA $C3				; 9B37	$85 $C3
	LDA $B7,X			; 9B39	$B5 $B7
	STA $C4				; 9B3B	$85 $C4
	JSR J9B56			; 9B3D	$20 $56 $9B	Settings parameter A process(Volume/Envelope)
	LDX $C6				; 9B40	$A6 $C6
	LDA $BA,X			; 9B42	$B5 $BA
	STA $C3				; 9B44	$85 $C3
	LDA $BB,X			; 9B46	$B5 $BB
	STA $C4				; 9B48	$85 $C4
	JSR J9BB6			; 9B4A	$20 $B6 $9B	Settings parameter B process(Timer)
L35B4D:
	INC $C5				; 9B4D	$E6 $C5
	LDA $C5				; 9B4F	$A5 $C5
	CMP #$03			; 9B51	$C9 $03
	BCC L35B26			; 9B53	$90 $D1		branch if ch is not trgger - next ch
	RTS				; 9B55	$60
; End of

; Name	:
; Marks	: Settings parameter A process
;	  +$C3 = setting A address
;	  $6F0A,$6F0B,$6F0C = loop count(update cycle), CH0, CH1, TRI(H->L)
;	  $6F13,$6F14,$6F15(??) = ch setting A address position
;	  $C5, $C7 = CH data address position(+1, +4)
;	  $C8 = temp value
;	  parameter A data = XXXX YYYY(move parameter A point address back)
;	    case 0000 YYYY(go back YYYY step)
;	    case XXXX YYYY(XXXX = loop count - length($6F0A,$6F0B,$6F0C,
;		 YYYY = volume low nibble)
;	  $C0 = update flag, bit0 ??
J9B56:
	LDA $C4				; 9B56	$A5 $C4
	CMP #$FF			; 9B58	$C9 $FF
	BNE L35B5D			; 9B5A	$D0 $01		branch if address is not 0xFFxx
	RTS				; 9B5C	$60
; End of
L35B5D:
	LDX $C5				; 9B5D	$A6 $C5
	LDA $6F0A,X			; 9B5F	$BD $0A $6F	loop count
	BNE L35BB2			; 9B62	$D0 $4E
J9B64:
	LDY $6F13,X			; 9B64	$BC $13 $6F
	LDA ($C3),Y			; 9B67	$B1 $C3
	AND #$F0			; 9B69	$29 $F0
	BNE L35B81			; 9B6B	$D0 $14		branch if data(high nibble) is exist
	LDA ($C3),Y			; 9B6D	$B1 $C3
	AND #$0F			; 9B6F	$29 $0F
	BEQ L35BB2			; 9B71	$F0 $3F		branch if data(all bit) is empty
	STA $C8				; 9B73	$85 $C8
	LDA $6F13,X			; 9B75	$BD $13 $6F
	SEC				; 9B78	$38
	SBC $C8				; 9B79	$E5 $C8
	STA $6F13,X			; 9B7B	$9D $13 $6F
	JMP J9B64			; 9B7E	$4C $64 $9B
L35B81:
	LSR A				; 9B81	$4A
	LSR A				; 9B82	$4A
	LSR A				; 9B83	$4A
	LSR A				; 9B84	$4A
	STA $6F0A,X			; 9B85	$9D $0A $6F	loop count
	INC $6F13,X			; 9B88	$FE $13 $6F	increase ch setting A address position
	LDA $6F04,X			; 9B8B	$BD $04 $6F	ch volume temp(high nibble)
	ASL A				; 9B8E	$0A
	ASL A				; 9B8F	$0A
	ASL A				; 9B90	$0A
	ASL A				; 9B91	$0A
	STA $C8				; 9B92	$85 $C8
	LDA ($C3),Y			; 9B94	$B1 $C3
	AND #$0F			; 9B96	$29 $0F
	ORA $C8				; 9B98	$05 $C8
	TAY				; 9B9A	$A8
	LDA D9D0D,Y			; 9B9B	$B9 $0D $9D	table(volume/envelope ??)
	STA $C8				; 9B9E	$85 $C8
	LDY $C7				; 9BA0	$A4 $C7		CH data address +4
	LDA $6F19,Y			; 9BA2	$B9 $19 $6F	$4000,$4004,$4008 temp
	AND #$F0			; 9BA5	$29 $F0
	ORA $C8				; 9BA7	$05 $C8
	STA $6F19,Y			; 9BA9	$99 $19 $6F	update volume($4000,$4004,$4008)
	LDA #$01			; 9BAC	$A9 $01
	ORA $C0,X			; 9BAE	$15 $C0
	STA $C0,X			; 9BB0	$95 $C0
L35BB2:
	DEC $6F0A,X			; 9BB2	$DE $0A $6F	loop count
	RTS				; 9BB5	$60
; End of

; Name	:
; Marks	: Settings parameter B process
;	  +$C3 = setting A address
;	  $6F0D,$6F0E,$6F0F = loop count(update cycle), CH0, CH1, TRI(H->L)
;	  $6F16,$6F17,$6F18(??) = ch setting B address position
;	  $C5, $C7 = CH data address position(+1, +4)
;	  parameter B data = XXXX YYYY(move parameter B point address back)
;	    case 0000 PYYY(go back PYYY step)
;	    case XXXX PYYY(XXXX = loop count - length($6F0D,$6F0E,$6F0F,
;		 P = positive/negative(1=minus,0=plus)
;		 YYY = timer relative value
;	  $C0 = update flag, bit2 ??
J9BB6:
	LDA $C4				; 9BB6	$A5 $C4
	CMP #$FF			; 9BB8	$C9 $FF
	BNE L35BBD			; 9BBA	$D0 $01		branch if address is not 0xFFxx
	RTS				; 9BBC	$60
L35BBD:
	LDX $C5				; 9BBD	$A6 $C5
	LDA $6F0D,X			; 9BBF	$BD $0D $6F	loop count
	BNE L35C1B			; 9BC2	$D0 $57
J9BC4:
	LDY $6F16,X			; 9BC4	$BC $16 $6F
	LDA ($C3),Y			; 9BC7	$B1 $C3
	AND #$F0			; 9BC9	$29 $F0		branch if data(high nibble) is exist
	BNE L35BE1			; 9BCB	$D0 $14
	LDA ($C3),Y			; 9BCD	$B1 $C3
	AND #$0F			; 9BCF	$29 $0F
	BEQ L35C1B			; 9BD1	$F0 $48		branch if data(all bit) is empty
	STA $C8				; 9BD3	$85 $C8
	LDA $6F16,X			; 9BD5	$BD $16 $6F
	SEC				; 9BD8	$38
	SBC $C8				; 9BD9	$E5 $C8
	STA $6F16,X			; 9BDB	$9D $16 $6F
	JMP J9BC4			; 9BDE	$4C $C4 $9B
L35BE1:
	LSR A				; 9BE1	$4A
	LSR A				; 9BE2	$4A
	LSR A				; 9BE3	$4A
	LSR A				; 9BE4	$4A
	STA $6F0D,X			; 9BE5	$9D $0D $6F	loop count
	INC $6F16,X			; 9BE8	$FE $16 $6F	increase ch setting B address position
	LDA ($C3),Y			; 9BEB	$B1 $C3
	AND #$0F			; 9BED	$29 $0F
	STA $C8				; 9BEF	$85 $C8
	LDY $C7				; 9BF1	$A4 $C7
	AND #$08			; 9BF3	$29 $08
	BNE L35C02			; 9BF5	$D0 $0B		branch if bit3 = 1
	LDA $6F1B,Y			; 9BF7	$B9 $1B $6F	$4002,$4006,$400A temp(Timer low)
	CLC				; 9BFA	$18
	ADC $C8				; 9BFB	$65 $C8
	BCS L35C1B			; 9BFD	$B0 $1C		branch if sum is > FFh
	JMP J9C12			; 9BFF	$4C $12 $9C
L35C02:
	LDA $C8				; 9C02	$A5 $C8
	AND #$07			; 9C04	$29 $07
	STA $C8				; 9C06	$85 $C8
	LDA $6F1B,Y			; 9C08	$B9 $1B $6F	$4002,$4006,$400A temp(Timer low)
	SEC				; 9C0B	$38
	SBC $C8				; 9C0C	$E5 $C8
	BEQ L35C1B			; 9C0E	$F0 $0B		branch if result of subtract is 0
	BCC L35C1B			; 9C10	$90 $09		branch if result of subtract is minus
J9C12:
	STA $6F1B,Y			; 9C12	$99 $1B $6F	$4002,$4006,$400A temp(Timer low)
	LDA #$04			; 9C15	$A9 $04
	ORA $C0,X			; 9C17	$15 $C0
	STA $C0,X			; 9C19	$95 $C0
L35C1B:
	DEC $6F0D,X			; 9C1B	$DE $0D $6F	loop count
	RTS				; 9C1E	$60
; End of

; Name	: Update_APU_reg
; Marks	: Update APU register
;	  $C0,$C1 = update flag
;	   bit2
;	   bit0
;	  $E5 =
;	  $E6 =
;	  $E7 =
Update_APU_reg:
	LDA ApuStatus_4015		; 9C1F	$AD $15 $40
	ORA #$0F			; 9C22	$09 $0F
	STA ApuStatus_4015		; 9C24	$8D $15 $40
	LDA $E6				; 9C27	$A5 $E6
	STA $E7				; 9C29	$85 $E7
	LDX #$00			; 9C2B	$A2 $00
	LDY #$00			; 9C2D	$A0 $00
Update_APU_reg_loop:
	LSR $E7				; 9C2F	$46 $E7
	BCS Update_APU_reg_next		; 9C31	$B0 $30
	CPX #$01			; 9C33	$E0 $01
	BNE Update_APU_reg_chk0		; 9C35	$D0 $04
	LDA $E5				; 9C37	$A5 $E5
	BNE Update_APU_reg_next		; 9C39	$D0 $28
Update_APU_reg_chk0:
	LSR $C0,X			; 9C3B	$56 $C0		bit 7654 3210 - bit 3, 2,1,0 is updated(If Set)
	BCC Update_APU_reg_chk1		; 9C3D	$90 $06
	LDA $6F19,Y			; 9C3F	$B9 $19 $6F	$4000,$4004,$4008 temp
	STA Sq0Duty_4000,Y		; 9C42	$99 $00 $40
Update_APU_reg_chk1:
	LSR $C0,X			; 9C45	$56 $C0
	BCC Update_APU_reg_chk2		; 9C47	$90 $06
	LDA $6F1A,Y			; 9C49	$B9 $1A $6F	$4001,$4005,$4009 temp
	STA Sq0Sweep_4001,Y		; 9C4C	$99 $01 $40
Update_APU_reg_chk2:
	LSR $C0,X			; 9C4F	$56 $C0
	BCC Update_APU_reg_chk3		; 9C51	$90 $06
	LDA $6F1B,Y			; 9C53	$B9 $1B $6F	$4002,$4006,$400A temp
	STA Sq0Timer_4002,Y		; 9C56	$99 $02 $40
Update_APU_reg_chk3:
	LSR $C0,X			; 9C59	$56 $C0
	BCC Update_APU_reg_next		; 9C5B	$90 $06
	LDA $6F1C,Y			; 9C5D	$B9 $1C $6F	$4003,$4007,$400B temp
	STA Sq0Length_4003,Y		; 9C60	$99 $03 $40
Update_APU_reg_next:
	INY				; 9C63	$C8
	INY				; 9C64	$C8
	INY				; 9C65	$C8
	INY				; 9C66	$C8
	INX				; 9C67	$E8
	CPX #$03			; 9C68	$E0 $03
	BCC Update_APU_reg_loop		; 9C6A	$90 $C3
	RTS				; 9C6C	$60
; End of



; ================================================== End of code ==================================================
.else
; Name	: Init_sound
; Marks	:
Init_sound:
	LDA #$00			; 36/81C3: A9 00     
	STA $4015                       ; 36/81C5: 8D 15 40  
	STA $4003                       ; 36/81C8: 8D 03 40  
	STA $4007                       ; 36/81CB: 8D 07 40  
	STA $400B                       ; 36/81CE: 8D 0B 40  
	STA $400F                       ; 36/81D1: 8D 0F 40  
	STA $7F42                       ; 36/81D4: 8D 42 7F  
	STA $7F40                       ; 36/81D7: 8D 40 7F  
	STA $7F49                       ; 36/81DA: 8D 49 7F  
	LDX #$06                        ; 36/81DD: A2 06     
B81DF:
	STA $7F4A,X                     ; 36/81DF: 9D 4A 7F  
	DEX                             ; 36/81E2: CA        
	BPL B81DF                       ; 36/81E3: 10 FA     
	RTS                             ; 36/81E5: 60        
; End of Init_sound

; Name	: UpdateChScript
; Marks	: update channel script
UpdateChScript:
	LDX $D0				; 36/81E6: A6 D0     
	LDA $7F4A,X     		; 36/81E8: BD 4A 7F  
	BPL B820A       		; 36/81EB: 10 1D        ; branch if channel is disabled
	LDA $7F5F,X     		; 36/81ED: BD 5F 7F  
	BNE B81F5       		; 36/81F0: D0 03     
	JSR ExeSoundCmd       		; 36/81F2: 20 0B 82     ; execute sound command
B81F5:
	LDX $D0         		; 36/81F5: A6 D0     
	DEC $7F5F,X     		; 36/81F7: DE 5F 7F  
	LDA $7F97,X     		; 36/81FA: BD 97 7F  
	BNE B8207       		; 36/81FD: D0 08     
	LDA $7F9E,X     		; 36/81FF: BD 9E 7F  
	BEQ B820A       		; 36/8202: F0 06     
	DEC $7F9E,X     		; 36/8204: DE 9E 7F  
B8207:
	DEC $7F97,X     		; 36/8207: DE 97 7F
B820A:
	RTS             		; 36/820A: 60
; End of UpdateChScript

; Name	: ExeSoundCmd
; Marks	: execute sound command
ExeSoundCmd:
	LDA $7F51,X        		; 36/820B: BD 51 7F  ; script pointer
	STA $D3            		; 36/820E: 85 D3     
	LDA $7F58,X        		; 36/8210: BD 58 7F  
	STA $D4            		; 36/8213: 85 D4     
	LDY #$00           		; 36/8215: A0 00     
ExeSndCmd:
	LDA ($D3),Y        		; 36/8217: B1 D3     ; get command
	INY                		; 36/8219: C8        
	CMP #$E0           		; 36/821A: C9 E0     
	BCC PlayNote          		; 36/821C: 90 51     ; branch if a note
	SBC #$E0           		; 36/821E: E9 E0     
	ASL                		; 36/8220: 0A        
	TAX                		; 36/8221: AA        
	LDA SndCmdTbl,X        		; 36/8222: BD 2F 82  
	STA $D8            		; 36/8225: 85 D8     
	LDA SndCmdTbl+1,X      		; 36/8227: BD 30 82  
	STA $D9            		; 36/822A: 85 D9     
	JMP ($00D8)        		; 36/822C: 6C D8 00  
; End of ExeSoundCmd

; sound commands $E0-$FF
SndCmdTbl:
.word SndCmdE0, SndCmdE1, SndCmdE2, SndCmdE3, SndCmdE4, SndCmdE5, SndCmdE6, SndCmdE7
.word SndCmdE8, SndCmdE9, SndCmdEA, SndCmdEB, SndCmdEC, SndCmdED, SndCmdEE, SndCmdEF
.word SndCmdF0, SndCmdF1, SndCmdF2, SndCmdF3, SndCmdF4, SndCmdF5, SndCmdF6, SndCmdF7
.word SndCmdF8, SndCmdF9, SndCmdFA, SndCmdFB, SndCmdFC, SndCmdFD, SndCmdFE, SndCmdFF
;36/822F: 8353 835C 8366 8370 837A 8384 838E 8398 ; $E0
;36/823F: 83A2 83AC 83B6 83C0 83CA 83D4 83DE 83E8
;36/824F: 83F2 83FC 8406 8410 841A 8424 843A 8450 ; $F0
;36/825F: 8466 8471 8485 8499 84AF 84D0 84F0 84FF

; Name	: PlayNote
; Marks	: sound command $00-$DF: play note
PlayNote:
	STA $D5				; 36/826F: 85 D5     
	LDX $D0         		; 36/8271: A6 D0     
	TYA             		; 36/8273: 98        
	CLC             		; 36/8274: 18        
	ADC $D3         		; 36/8275: 65 D3     
	STA $D3         		; 36/8277: 85 D3     
	STA $7F51,X     		; 36/8279: 9D 51 7F  
	LDA $D4         		; 36/827C: A5 D4     
	ADC #$00        		; 36/827E: 69 00     
	STA $D4         		; 36/8280: 85 D4     
	STA $7F58,X     		; 36/8282: 9D 58 7F  
	LDA $D5         		; 36/8285: A5 D5     
	AND #$0F        		; 36/8287: 29 0F     
	TAY             		; 36/8289: A8        
	LDA $8805,Y     		; 36/828A: B9 05 88     ; note duration
	STA $7F5F,X     		; 36/828D: 9D 5F 7F  
	LDA $D5         		; 36/8290: A5 D5     
	CMP #$D0        		; 36/8292: C9 D0     
	BCS B82E9       		; 36/8294: B0 53        ; branch if a tie
	CMP #$C0        		; 36/8296: C9 C0     
	BCS B8307       		; 36/8298: B0 6D        ; branch if a rest
	LDA $7F4A,X     		; 36/829A: BD 4A 7F  
	ORA #$01        		; 36/829D: 09 01        ; key on
	AND #$FD        		; 36/829F: 29 FD     
	STA $7F4A,X     		; 36/82A1: 9D 4A 7F  
	LDA #$00        		; 36/82A4: A9 00     
	STA $7FBA,X     		; 36/82A6: 9D BA 7F  
	STA $7FC8,X     		; 36/82A9: 9D C8 7F  
	STA $7FDD,X     		; 36/82AC: 9D DD 7F  
	STA $7FF9,X     		; 36/82AF: 9D F9 7F  
	STA $7FF2,X     		; 36/82B2: 9D F2 7F  
	LDA $D1         		; 36/82B5: A5 D1     
	BEQ B8310       		; 36/82B7: F0 57        ; dmc doesn't have any of this stuff
	CMP #$02        		; 36/82B9: C9 02     
	BEQ B82C6       		; 36/82BB: F0 09        ; triangle channel doesn't have decay
	JSR $831D       		; 36/82BD: 20 1D 83     ; init decay counter
	LDA $D1         		; 36/82C0: A5 D1     
	CMP #$01        		; 36/82C2: C9 01     
	BEQ B82EA       		; 36/82C4: F0 24        ; branch if noise channel
B82C6:
	LDA $7F66,X     		; 36/82C6: BD 66 7F     ; octave
	ASL             		; 36/82C9: 0A        
	ASL             		; 36/82CA: 0A        
	STA $D6         		; 36/82CB: 85 D6     
	ASL             		; 36/82CD: 0A        
	ADC $D6         		; 36/82CE: 65 D6     
	STA $D6         		; 36/82D0: 85 D6     
	LDA $D5         		; 36/82D2: A5 D5        ; pitch + octave * 12
	LSR             		; 36/82D4: 4A        
	LSR             		; 36/82D5: 4A        
	LSR             		; 36/82D6: 4A        
	LSR             		; 36/82D7: 4A        
	CLC             		; 36/82D8: 18        
	ADC $D6         		; 36/82D9: 65 D6     
	ASL             		; 36/82DB: 0A        
	TAY             		; 36/82DC: A8        
	LDA $872D,Y     		; 36/82DD: B9 2D 87     ; frequency table
	STA $7F6D,X     		; 36/82E0: 9D 6D 7F  
	LDA $872E,Y     		; 36/82E3: B9 2E 87  
	STA $7F74,X     		; 36/82E6: 9D 74 7F  
B82E9:
	RTS             		; 36/82E9: 60        
; noise
B82EA:
	LDA $7F66,X        		; 36/82EA: BD 66 7F  ; octave
	ASL                		; 36/82ED: 0A        
	ASL                		; 36/82EE: 0A        
	STA $D6            		; 36/82EF: 85 D6     
	ASL                		; 36/82F1: 0A        
	ADC $D6            		; 36/82F2: 65 D6     
	STA $D6            		; 36/82F4: 85 D6     
	LDA $D5            		; 36/82F6: A5 D5     
	LSR                		; 36/82F8: 4A        
	LSR                		; 36/82F9: 4A        
	LSR                		; 36/82FA: 4A        
	LSR                		; 36/82FB: 4A        
	CLC                		; 36/82FC: 18        
	ADC $D6            		; 36/82FD: 65 D6     
	TAY                		; 36/82FF: A8        
	LDA $87BD,Y        		; 36/8300: B9 BD 87  ; noise table
	STA $7F6D,X        		; 36/8303: 9D 6D 7F  
	RTS                		; 36/8306: 60        
B8307:
	LDA $7F4A,X        		; 36/8307: BD 4A 7F  
	ORA #$02           		; 36/830A: 09 02     ; key off
	STA $7F4A,X        		; 36/830C: 9D 4A 7F  
	RTS                		; 36/830F: 60        
; dmc
B8310:
	LDA $7F44			; 36/8310: AD 44 7F  
	CMP #$05        		; 36/8313: C9 05     
	BCC B831C       		; 36/8315: 90 05     
	LDA #$FF        		; 36/8317: A9 FF        ; set dmc direct load (causes a pop sound)
	STA $4011       		; 36/8319: 8D 11 40  
B831C:
	RTS             		; 36/831C: 60        
; End of PlayNote

; Name	: InitDecayC
; Marks	: init decay counter
InitDecayC:
	LDA $D5				; 36/831D: A5 D5     
	AND #$0F        		; 36/831F: 29 0F     
	TAX             		; 36/8321: AA        
	LDA $8815,X     		; 36/8322: BD 15 88     ; decay duration
	STA $D8         		; 36/8325: 85 D8     
	LDY #$00        		; 36/8327: A0 00     
	STY $D9         		; 36/8329: 84 D9     
B832B:
	LDA ($D3),Y     		; 36/832B: B1 D3        ; add tie duration
	INY             		; 36/832D: C8        
	CMP #$D0        		; 36/832E: C9 D0     
	BCC B8346       		; 36/8330: 90 14     
	CMP #$E0        		; 36/8332: C9 E0     
	BCS B8346       		; 36/8334: B0 10     
	AND #$0F        		; 36/8336: 29 0F     
	TAX             		; 36/8338: AA        
	LDA $8815,X     		; 36/8339: BD 15 88  
	ADC $D8         		; 36/833C: 65 D8     
	STA $D8         		; 36/833E: 85 D8     
	BCC B832B       		; 36/8340: 90 E9     
	INC $D9         		; 36/8342: E6 D9     
	BCS B832B       		; 36/8344: B0 E5     
B8346:
	LDX $D0         		; 36/8346: A6 D0     
	LDA $D8         		; 36/8348: A5 D8     
	STA $7F97,X     		; 36/834A: 9D 97 7F     ; decay counter
	LDA $D9         		; 36/834D: A5 D9     
	STA $7F9E,X     		; 36/834F: 9D 9E 7F  
	RTS             		; 36/8352: 60        
; End of InitDecayC

; Name	: SndCmdE0
; Marks	: sound command $E0: set tempo
SndCmdE0:
	LDA ($D3),Y			; 36/8353: B1 D3     
	INY                             ; 36/8355: C8        
	STA $7F45                       ; 36/8356: 8D 45 7F  
	JMP ExeSndCmd                   ; 36/8359: 4C 17 82  

; Name	: SndCmdE1
; Marks	: sound command $E1: set volume to 2
SndCmdE1:
	LDX $D0				; 36/835C: A6 D0     
	LDA #$02                        ; 36/835E: A9 02     
	STA $7F90,X                     ; 36/8360: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/8363: 4C 17 82  

; Name	: SndCmdE2
; Marks	: sound command $E2:set volume to 3
SndCmdE2:
	LDX $D0				; 36/8366: A6 D0     
	LDA #$03                        ; 36/8368: A9 03     
	STA $7F90,X                     ; 36/836A: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/836D: 4C 17 82  

; Name	: SndCmdE3
; Marks	: sound command $E3: set volume to 4
SndCmdE3:
	LDX $D0				; 36/8370: A6 D0     
	LDA #$04                        ; 36/8372: A9 04     
	STA $7F90,X                     ; 36/8374: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/8377: 4C 17 82  

; Name	: SndCmdE4
; Marks	: sound command $E4: set volume to 5
SndCmdE4:
	LDX $D0				; 36/837A: A6 D0     
	LDA #$05                        ; 36/837C: A9 05     
	STA $7F90,X                     ; 36/837E: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/8381: 4C 17 82  

; Name	: SndCmdE5
; Marks	: sound command $E5: set volume to 6
SndCmdE5:
	LDX $D0				; 36/8384: A6 D0     
	LDA #$06                        ; 36/8386: A9 06     
	STA $7F90,X                     ; 36/8388: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/838B: 4C 17 82  

; Name	: SndCmdE6
; Marks	: sound command $E6: set volume to 7
SndCmdE6:
	LDX $D0				; 36/838E: A6 D0     
	LDA #$07                        ; 36/8390: A9 07     
	STA $7F90,X                     ; 36/8392: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/8395: 4C 17 82  

; Name	: SndCmdE7
; Marks	: sound command $E7: set volume to 8
SndCmdE7:
	LDX $D0				; 36/8398: A6 D0     
	LDA #$08                        ; 36/839A: A9 08     
	STA $7F90,X                     ; 36/839C: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/839F: 4C 17 82  

; Name	: SndCmdE8
; Marks	: sound command $E8: set volume to 9
SndCmdE8:
	LDX $D0				; 36/83A2: A6 D0     
	LDA #$09                        ; 36/83A4: A9 09     
	STA $7F90,X                     ; 36/83A6: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83A9: 4C 17 82  

; Name	: SndCmdE9
; Marks	: sound command $E9: set volume to 10
SndCmdE9:
	LDX $D0				; 36/83AC: A6 D0     
	LDA #$0A                        ; 36/83AE: A9 0A     
	STA $7F90,X                     ; 36/83B0: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83B3: 4C 17 82  

; Name	: SndCmdEA
; Marks	: sound command $EA: set volume to 11
SndCmdEA:
	LDX $D0				; 36/83B6: A6 D0     
	LDA #$0B                        ; 36/83B8: A9 0B     
	STA $7F90,X                     ; 36/83BA: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83BD: 4C 17 82  

; Name	: SndCmdEB
; Marks	: sound command $EB: set volume to 12
SndCmdEB:
	LDX $D0				; 36/83C0: A6 D0     
	LDA #$0C                        ; 36/83C2: A9 0C     
	STA $7F90,X                     ; 36/83C4: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83C7: 4C 17 82  

; Name	: SndCmdEC
; Marks	: sound command $EC: set volume to 13
SndCmdEC:
	LDX $D0				; 36/83CA: A6 D0     
	LDA #$0D                        ; 36/83CC: A9 0D     
	STA $7F90,X                     ; 36/83CE: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83D1: 4C 17 82  

; Name	: SndCmdED
; Marks	: sound command $ED: set volume to 14
SndCmdED:
	LDX $D0				; 36/83D4: A6 D0     
	LDA #$0E                        ; 36/83D6: A9 0E     
	STA $7F90,X                     ; 36/83D8: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83DB: 4C 17 82  

; Name	: SndCmdEE
; Marks	: sound command $EE: set volume to 15
SndCmdEE:
	LDX $D0				; 36/83DE: A6 D0     
	LDA #$0F                        ; 36/83E0: A9 0F     
	STA $7F90,X                     ; 36/83E2: 9D 90 7F  
	JMP ExeSndCmd                   ; 36/83E5: 4C 17 82  

; Name	: SndCmdEF
; Marks	: sound command $EF: set octave to 0
SndCmdEF:
	LDX $D0				; 36/83E8: A6 D0     
	LDA #$00                        ; 36/83EA: A9 00     
	STA $7F66,X                     ; 36/83EC: 9D 66 7F  
	JMP ExeSndCmd                   ; 36/83EF: 4C 17 82  

; Name	: SndCmdF0
; Marks	: sound command $F0: set octave to 1
SndCmdF0:
	LDX $D0				; 36/83F2: A6 D0     
	LDA #$01                        ; 36/83F4: A9 01     
	STA $7F66,X                     ; 36/83F6: 9D 66 7F  
	JMP ExeSndCmd                   ; 36/83F9: 4C 17 82  

; Name	: SndCmdF1
; Marks	: sound command $F1: set octave to 2
SndCmdF1:
	LDX $D0				; 36/83FC: A6 D0     
	LDA #$02                        ; 36/83FE: A9 02     
	STA $7F66,X                     ; 36/8400: 9D 66 7F  
	JMP ExeSndCmd                   ; 36/8403: 4C 17 82  

; Name	: SndCmdF2
; Marks	: sound command $F2: set octave to 3
SndCmdF2:
	LDX $D0				; 36/8406: A6 D0     
	LDA #$03                        ; 36/8408: A9 03     
	STA $7F66,X                     ; 36/840A: 9D 66 7F  
	JMP ExeSndCmd                   ; 36/840D: 4C 17 82  

; Name	: SndCmdF3
; Marks	: sound command $F3: set octave to 4
SndCmdF3:
	LDX $D0				; 36/8410: A6 D0     
	LDA #$04                        ; 36/8412: A9 04     
	STA $7F66,X                     ; 36/8414: 9D 66 7F  
	JMP ExeSndCmd                   ; 36/8417: 4C 17 82  

; Name	: SndCmdF4
; Marks	: sound command $F4: set octave to 5
SndCmdF4:
	LDX $D0				; 36/841A: A6 D0     
	LDA #$05                        ; 36/841C: A9 05     
	STA $7F66,X                     ; 36/841E: 9D 66 7F  
	JMP ExeSndCmd                   ; 36/8421: 4C 17 82  

; Name	: SndCmdF5
; Marks	: sound command $F5: set envelopes (1/8 duty cycle)
;	  b1: volume envelope
;	  b2: pitch envelope
SndCmdF5:
	LDX $D0				; 36/8424: A6 D0     
	LDA #$30                        ; 36/8426: A9 30     
	STA $7F89,X                     ; 36/8428: 9D 89 7F  
	LDA ($D3),Y                     ; 36/842B: B1 D3     
	INY                             ; 36/842D: C8        
	STA $7FC1,X                     ; 36/842E: 9D C1 7F  
	LDA ($D3),Y                     ; 36/8431: B1 D3     
	INY                             ; 36/8433: C8        
	STA $7FEB,X                     ; 36/8434: 9D EB 7F  
	JMP ExeSndCmd                   ; 36/8437: 4C 17 82  

; Name	: SndCmdF6
; Marks	: sound command $F6: set envelopes (1/4 duty cycle)
SndCmdF6:
	LDX $D0				; 36/843A: A6 D0     
	LDA #$70                        ; 36/843C: A9 70     
	STA $7F89,X                     ; 36/843E: 9D 89 7F  
	LDA ($D3),Y                     ; 36/8441: B1 D3     
	INY                             ; 36/8443: C8        
	STA $7FC1,X                     ; 36/8444: 9D C1 7F  
	LDA ($D3),Y                     ; 36/8447: B1 D3     
	INY                             ; 36/8449: C8        
	STA $7FEB,X                     ; 36/844A: 9D EB 7F  
	JMP ExeSndCmd                   ; 36/844D: 4C 17 82  

; Name	: SndCmdF7
; Marks	: sound command $F7: set envelopes (1/2 duty cycle)
SndCmdF7:
	LDX $D0				; 36/8450: A6 D0     
	LDA #$B0                        ; 36/8452: A9 B0     
	STA $7F89,X                     ; 36/8454: 9D 89 7F  
	LDA ($D3),Y                     ; 36/8457: B1 D3     
	INY                             ; 36/8459: C8        
	STA $7FC1,X                     ; 36/845A: 9D C1 7F  
	LDA ($D3),Y                     ; 36/845D: B1 D3     
	INY                             ; 36/845F: C8        
	STA $7FEB,X                     ; 36/8460: 9D EB 7F  
	JMP ExeSndCmd                   ; 36/8463: 4C 17 82  

; Name	: SndCmdF8
; Marks	: sound command $F8: set sweep
SndCmdF8:
	LDX $D0				; 36/8466: A6 D0     
	LDA ($D3),Y                     ; 36/8468: B1 D3     
	INY                             ; 36/846A: C8        
	STA $7F82,X                     ; 36/846B: 9D 82 7F  
	JMP ExeSndCmd                   ; 36/846E: 4C 17 82  

; Name	: SndCmdF9
; Marks	: sound command $F9: hi-hat preset
SndCmdF9:
	LDX $D0				; 36/8471: A6 D0     
	LDA #$04        		; 36/8473: A9 04        ; set octave to 4
	STA $7F66,X     		; 36/8475: 9D 66 7F  
	LDA #$00        		; 36/8478: A9 00        ; volume envelope 0
	STA $7FC1,X     		; 36/847A: 9D C1 7F  
	LDA #$08        		; 36/847D: A9 08        ; set channel volume to 8
	STA $7F90,X     		; 36/847F: 9D 90 7F  
	JMP ExeSndCmd   		; 36/8482: 4C 17 82  

; Name	: SndCmdFA
; Marks	: sound command $FA: snare drum preset
SndCmdFA:
	LDX $D0				; 36/8485: A6 D0     
	LDA #$05        		; 36/8487: A9 05        ; set octave to 5
	STA $7F66,X     		; 36/8489: 9D 66 7F  
	LDA #$01        		; 36/848C: A9 01        ; volume envelope 1
	STA $7FC1,X     		; 36/848E: 9D C1 7F  
	LDA #$0F        		; 36/8491: A9 0F        ; set channel volume to 15
	STA $7F90,X     		; 36/8493: 9D 90 7F  
	JMP ExeSndCmd   		; 36/8496: 4C 17 82  

; Name	: SndCmdFB
; Marks	: sound command $FB: repeat start
;	  b1: repeat count
SndCmdFB:
	LDA ($D3),Y			; 36/8499: B1 D3     
	INY             		; 36/849B: C8        
	LDX $D0         		; 36/849C: A6 D0     
	INC $7FA5,X     		; 36/849E: FE A5 7F     ; increment repeat depth
	BNE B84A9       		; 36/84A1: D0 06     
	STA $7FAC,X     		; 36/84A3: 9D AC 7F  
	JMP ExeSndCmd   		; 36/84A6: 4C 17 82  
B84A9:
	STA $7FB3,X     		; 36/84A9: 9D B3 7F  
	JMP ExeSndCmd   		; 36/84AC: 4C 17 82  

; Name	: SndCmdFC
; Marks	: sound command $FC: repeat end
;	  +b1: repeat address
SndCmdFC:
	LDX $D0				; 36/84AF: A6 D0     
	LDA $7FA5,X     		; 36/84B1: BD A5 7F  
	BNE B84C3       		; 36/84B4: D0 0D     
	DEC $7FAC,X     		; 36/84B6: DE AC 7F  
	BNE SndCmdFE       		; 36/84B9: D0 35        ; branch if looping
	INY             		; 36/84BB: C8           ; skip over repeat address
	INY             		; 36/84BC: C8        
	DEC $7FA5,X     		; 36/84BD: DE A5 7F  
	JMP ExeSndCmd   		; 36/84C0: 4C 17 82  
B84C3:
	DEC $7FB3,X     		; 36/84C3: DE B3 7F  
	BNE SndCmdFE       		; 36/84C6: D0 28     
	INY             		; 36/84C8: C8        
	INY             		; 36/84C9: C8        
	DEC $7FA5,X     		; 36/84CA: DE A5 7F  
	JMP ExeSndCmd   		; 36/84CD: 4C 17 82  

; Name	: SndCmdFD
; Marks	: sound command $FD: volta repeat
;	  +b1: repeat address
SndCmdFD:
	LDX $D0				; 36/84D0: A6 D0     
	LDA $7FA5,X                     ; 36/84D2: BD A5 7F  
	BNE B84E2                       ; 36/84D5: D0 0B     
	LDA $7FAC,X                     ; 36/84D7: BD AC 7F  
	LSR                             ; 36/84DA: 4A        
	BCS B84ED                       ; 36/84DB: B0 10     
	INY                             ; 36/84DD: C8        
	INY                             ; 36/84DE: C8        
	JMP ExeSndCmd                   ; 36/84DF: 4C 17 82  
B84E2:
	LDA $7FB3,X                     ; 36/84E2: BD B3 7F  
	LSR                             ; 36/84E5: 4A        
	BCS B84ED                       ; 36/84E6: B0 05     
	INY                             ; 36/84E8: C8        
	INY                             ; 36/84E9: C8        
	JMP ExeSndCmd                   ; 36/84EA: 4C 17 82  
B84ED:
	DEC $7FA5,X                     ; 36/84ED: DE A5 7F  
; fallthrough
; Name	: SndCmdFE
; Marks	: sound command $FE: jump
;	  +b1: jump address
SndCmdFE:
	LDA ($D3),Y			; 36/84F0: B1 D3             ; get jump address
	INY             		; 36/84F2: C8        
	TAX             		; 36/84F3: AA        
	LDA ($D3),Y     		; 36/84F4: B1 D3     
	STA $D4         		; 36/84F6: 85 D4     
	STX $D3         		; 36/84F8: 86 D3     
	LDY #$00        		; 36/84FA: A0 00     
	JMP ExeSndCmd   		; 36/84FC: 4C 17 82  

; Name	: SndCmdFF
; Marks	: sound command $FF: end of script
SndCmdFF:
	LDX $D0				; 36/84FF: A6 D0     
	LDA $7F4A,X     		; 36/8501: BD 4A 7F     ; disable channel
	AND #$7F        		; 36/8504: 29 7F     
	STA $7F4A,X     		; 36/8506: 9D 4A 7F  
	LDA $D1         		; 36/8509: A5 D1     
	BEQ B8559       		; 36/850B: F0 4C        ; branch if dmc
	CMP #$03        		; 36/850D: C9 03     
	BEQ B8520       		; 36/850F: F0 0F        ; branch if pulse 2
	CMP #$02        		; 36/8511: C9 02     
	BEQ B853A       		; 36/8513: F0 25        ; branch if triangle
	CMP #$01        		; 36/8515: C9 01     
	BEQ B8541       		; 36/8517: F0 28        ; branch if noise
	LDA #$30        		; 36/8519: A9 30     
	STA $4000       		; 36/851B: 8D 00 40  
	BNE B8559       		; 36/851E: D0 39     
B8520:
	LDA $D2         		; 36/8520: A5 D2     
	BEQ B852E       		; 36/8522: F0 0A     
	LDA $7F4B       		; 36/8524: AD 4B 7F  
	ORA #$02        		; 36/8527: 09 02     
	STA $7F4B       		; 36/8529: 8D 4B 7F  
	BNE B8533       		; 36/852C: D0 05     
B852E:
	LDA $7F4F       		; 36/852E: AD 4F 7F  
	BMI B8559       		; 36/8531: 30 26     
B8533:
	LDA #$30        		; 36/8533: A9 30     
	STA $4004       		; 36/8535: 8D 04 40  
	BNE B8559       		; 36/8538: D0 1F     
B853A:
	LDA #$80        		; 36/853A: A9 80     
	STA $4008       		; 36/853C: 8D 08 40  
	BNE B8559       		; 36/853F: D0 18     
B8541:
	LDA $D2         		; 36/8541: A5 D2     
	BEQ B854F       		; 36/8543: F0 0A     
	LDA $7F4D       		; 36/8545: AD 4D 7F  
	ORA #$02        		; 36/8548: 09 02     
	STA $7F4D       		; 36/854A: 8D 4D 7F  
	BNE B8554       		; 36/854D: D0 05     
B854F:
	LDA $7F50       		; 36/854F: AD 50 7F  
	BMI B8559       		; 36/8552: 30 05     
B8554:
	LDA #$30        		; 36/8554: A9 30     
	STA $400C       		; 36/8556: 8D 0C 40  
B8559:
	LDA $D2         		; 36/8559: A5 D2     
	BNE B856D       		; 36/855B: D0 10        ; branch if sound effect
	LDX #$04        		; 36/855D: A2 04     
B855F:
	LDA $7F4A,X     		; 36/855F: BD 4A 7F  
	BMI B857C       		; 36/8562: 30 18        ; return if any music channels active
	DEX             		; 36/8564: CA        
	BPL B855F       		; 36/8565: 10 F8     
	LDA #$00        		; 36/8567: A9 00     
	STA $7F42       		; 36/8569: 8D 42 7F     ; disable music
	RTS             		; 36/856C: 60        
B856D:
	LDA $7F4F       		; 36/856D: AD 4F 7F     ; return if any sound effect channels active
	BMI B857C       		; 36/8570: 30 0A     
	LDA $7F50       		; 36/8572: AD 50 7F  
	BMI B857C       		; 36/8575: 30 05     
	LDA #$00        		; 36/8577: A9 00        ; no sound effect
	STA $7F49       		; 36/8579: 8D 49 7F  
B857C:
	RTS             		; 36/857C: 60        
.endif

; Name	: UpdateChEnv
; Marks	: update channel envelopes
UpdateChEnv:
	LDX $D0				; 36/857D: A6 D0     
	LDA $7F4A,X     		; 36/857F: BD 4A 7F  
	BPL B8594       		; 36/8582: 10 10        ; return if channel is disabled
	AND #$02        		; 36/8584: 29 02     
	BNE B858F       		; 36/8586: D0 07        ; branch if key off
	JSR UpdateVolEnv       		; 36/8588: 20 95 85     ; update volume envelope
	JSR UpdatePitEnv       		; 36/858B: 20 D5 86     ; update pitch envelope
	RTS             		; 36/858E: 60        
B858F:
	LDA #$00        		; 36/858F: A9 00     
	STA $7F7B,X     		; 36/8591: 9D 7B 7F     ; volume
B8594:
	RTS             		; 36/8594: 60        
; End of UpdateChEnv

; Name	: UpdateVolEnv
; Marks	: update volume envelope
UpdateVolEnv:
	LDX $D0				; 36/8595: A6 D0     
	LDA $7FBA,X     		; 36/8597: BD BA 7F     ; envelope state
	CMP #$03        		; 36/859A: C9 03     
	BCS B85EE       		; 36/859C: B0 50        ; branch if key off
	CMP #$01        		; 36/859E: C9 01     
	BNE B85B4       		; 36/85A0: D0 12        ; branch if not decay
	LDA $7F97,X     		; 36/85A2: BD 97 7F  
	BNE B85B4       		; 36/85A5: D0 0D        ; branch if still decaying
	LDA $7F9E,X     		; 36/85A7: BD 9E 7F  
	BNE B85B4       		; 36/85AA: D0 08     
	INC $7FBA,X     		; 36/85AC: FE BA 7F     ; increment envelope state (to release)
	LDA #$00        		; 36/85AF: A9 00     
	STA $7FC8,X     		; 36/85B1: 9D C8 7F     ; reset envelope data offset
B85B4:
	LDA $7FC1,X     		; 36/85B4: BD C1 7F  
	ASL             		; 36/85B7: 0A        
	BCS B85E1       		; 36/85B8: B0 27     
	TAY             		; 36/85BA: A8        
	LDA $9A7C,Y     		; 36/85BB: B9 7C 9A     ; pointers to volume envelope data
	STA $D6         		; 36/85BE: 85 D6     
	LDA $9A7D,Y     		; 36/85C0: B9 7D 9A  
	STA $D7         		; 36/85C3: 85 D7     
	LDA $7FBA,X     		; 36/85C5: BD BA 7F     ; envelope state
	ASL             		; 36/85C8: 0A        
	TAX             		; 36/85C9: AA        
	TAY             		; 36/85CA: A8        
	LDA ($D6),Y     		; 36/85CB: B1 D6     
	INY             		; 36/85CD: C8        
	STA $D8         		; 36/85CE: 85 D8     
	LDA ($D6),Y     		; 36/85D0: B1 D6     
	STA $D9         		; 36/85D2: 85 D9     
	LDA $85F4,X     		; 36/85D4: BD F4 85     ; envelope state jump table
	STA $D6         		; 36/85D7: 85 D6     
	LDA $85F5,X     		; 36/85D9: BD F5 85  
	STA $D7         		; 36/85DC: 85 D7     
	JMP ($00D6)     		; 36/85DE: 6C D6 00  
B85E1:
	LDA $7F44       		; 36/85E1: AD 44 7F  
	CMP #$05        		; 36/85E4: C9 05     
	BCC B85EE       		; 36/85E6: 90 06     
	LDA #$FF        		; 36/85E8: A9 FF     
	STA $7F7B,X     		; 36/85EA: 9D 7B 7F     ; volume
	RTS             		; 36/85ED: 60        
B85EE:
	LDA #$00        		; 36/85EE: A9 00     
	STA $7F7B,X     		; 36/85F0: 9D 7B 7F     ; volume
	RTS             		; 36/85F3: 60        
; End of UpdateVolEnv

; Name	: UpdatePitEnv
; Marks	: update pitch envelope
UpdatePitEnv:
	LDX $D0				; 36/86D5: A6 D0     
	LDA $7FEB,X     		; 36/86D7: BD EB 7F  
	ASL             		; 36/86DA: 0A        
	BCS B872C       		; 36/86DB: B0 4F     
	TAY             		; 36/86DD: A8        
	LDA $9EAB,Y     		; 36/86DE: B9 AB 9E     ; pointers to pitch envelope data
	STA $D8         		; 36/86E1: 85 D8     
	LDA $9EAC,Y     		; 36/86E3: B9 AC 9E  
	STA $D9         		; 36/86E6: 85 D9     
	LDA $7FF9,X     		; 36/86E8: BD F9 7F     ; pitch envelope counter
	BNE B8729       		; 36/86EB: D0 3C     
	LDY $7FF2,X     		; 36/86ED: BC F2 7F     ; pitch envelope data offset
	LDA ($D8),Y     		; 36/86F0: B1 D8     
	BEQ B872C       		; 36/86F2: F0 38        ; pitch envelope is terminated
	BPL B86FD       		; 36/86F4: 10 07     
	CLC             		; 36/86F6: 18        
	ADC $7FF2,X     		; 36/86F7: 7D F2 7F     ; "subtract" from data offset
	TAY             		; 36/86FA: A8        
	LDA ($D8),Y     		; 36/86FB: B1 D8     
B86FD:
	STA $7FF9,X     		; 36/86FD: 9D F9 7F     ; reset counter
	INY             		; 36/8700: C8        
	INY             		; 36/8701: C8        
	TYA             		; 36/8702: 98        
	STA $7FF2,X     		; 36/8703: 9D F2 7F     ; set data offset for next frame
	DEY             		; 36/8706: 88        
	LDA ($D8),Y     		; 36/8707: B1 D8        ; get pitch envelope frequency offset
	BMI B871B       		; 36/8709: 30 10     
	CLC             		; 36/870B: 18        
	ADC $7F6D,X     		; 36/870C: 7D 6D 7F     ; frequency lo
	STA $7F6D,X     		; 36/870F: 9D 6D 7F  
	BCC B8729       		; 36/8712: 90 15     
	LDA #$FF        		; 36/8714: A9 FF        ; max 255
	STA $7F6D,X     		; 36/8716: 9D 6D 7F  
	BNE B8729       		; 36/8719: D0 0E     
B871B:
	CLC             		; 36/871B: 18        
	ADC $7F6D,X     		; 36/871C: 7D 6D 7F  
	STA $7F6D,X     		; 36/871F: 9D 6D 7F  
	BCS B8729       		; 36/8722: B0 05     
	LDA #$00        		; 36/8724: A9 00        ; min 0
	STA $7F6D,X     		; 36/8726: 9D 6D 7F  
B8729:
	DEC $7FF9,X     		; 36/8729: DE F9 7F  
B872C:
	RTS             		; 36/872C: 60        
; End of UpdatePitEnv

; Name	: UpdateMusic
; Marks	: update music
	;JSR $899F          		; 36/8925: 20 9F 89   switch to song bank
	LDA $7F42          		; 36/8928: AD 42 7F  
	TAX                		; 36/892B: AA        
	AND #$01           		; 36/892C: 29 01     
	BEQ B895D          		; 36/892E: F0 2D      branch if not playing a new song
	LDA $7F40          		; 36/8930: AD 40 7F  
	BPL B8949          		; 36/8933: 10 14     
	AND #$7F           		; 36/8935: 29 7F     
	CMP $7F43          		; 36/8937: CD 43 7F  
	BEQ B8956          		; 36/893A: F0 1A     
	CMP #$37           		; 36/893C: C9 37     
	BNE B8949          		; 36/893E: D0 09     
	STA $7F43          		; 36/8940: 8D 43 7F  
	;JSR $899F          		; 36/8943: 20 9F 89   switch to song bank
	JMP B8956          		; 36/8946: 4C 56 89  
B8949:
	STA $7F41          		; 36/8949: 8D 41 7F  
	LDA $7F43          		; 36/894C: AD 43 7F  
	STA $7F40          		; 36/894F: 8D 40 7F  
	JSR InitSong          		; 36/8952: 20 C3 89   init song
	RTS                		; 36/8955: 60        
B8956:
	LDA #$80           		; 36/8956: A9 80     
	STA $7F42          		; 36/8958: 8D 42 7F  
	BMI B899B          		; 36/895B: 30 3E     
B895D:
	TXA                		; 36/895D: 8A        
	AND #$02           		; 36/895E: 29 02     
	BEQ B8977          		; 36/8960: F0 15      branch if not resuming music
	LDA $7F41          		; 36/8962: AD 41 7F  
	STA $7F40          		; 36/8965: 8D 40 7F  
	STA $7F43          		; 36/8968: 8D 43 7F  
	LDA #$01           		; 36/896B: A9 01      play new song
	STA $7F42          		; 36/896D: 8D 42 7F  
	;JSR $899F          		; 36/8970: 20 9F 89   switch to song bank
	JSR InitSong          		; 36/8973: 20 C3 89   init song
	RTS                		; 36/8976: 60        
B8977:
	TXA                		; 36/8977: 8A        
	AND #$04           		; 36/8978: 29 04     
	BEQ B897F          		; 36/897A: F0 03      branch if not stopping music
	JSR SetVolT			; 36/897C: 20 A7 8A   set volume for stopping music
B897F:
	LDA $7F42          		; 36/897F: AD 42 7F  
	AND #$20           		; 36/8982: 29 20     
	BEQ B898C          		; 36/8984: F0 06      branch if not fading in
	JSR UpdateFadeIn      		; 36/8986: 20 F0 8A   update fade in
	JMP B8996          		; 36/8989: 4C 96 89  
B898C:
	LDA $7F42          		; 36/898C: AD 42 7F  
	AND #$40           		; 36/898F: 29 40     
	BEQ B8996          		; 36/8991: F0 03      branch if not fading out
	JSR UpdateFadeOut      		; 36/8993: 20 11 8B   update fade out
B8996:
	LDA $7F42          		; 36/8996: AD 42 7F  
	BPL B899E          		; 36/8999: 10 03     
B899B:
	JSR UpdateMusicCh      		; 36/899B: 20 2D 8B   update music channels
B899E:
	RTS                		; 36/899E: 60        
; End of UpdateMusic

; Name	: InitSong
; Marks	: init song
InitSong:
	JSR SilenceMusicCh     		; 36/89C3: 20 C0 8A   silence music channels
	LDX #$04           		; 36/89C6: A2 04     
B89C8:
	LDA #$00           		; 36/89C8: A9 00     
	STA $7F4A,X        		; 36/89CA: 9D 4A 7F   channel flags
	STA $7F5F,X        		; 36/89CD: 9D 5F 7F   tick counter
	STA $7F7B,X        		; 36/89D0: 9D 7B 7F   volume
	LDA #$08           		; 36/89D3: A9 08     
	STA $7F82,X        		; 36/89D5: 9D 82 7F   sweep
	LDA #$30           		; 36/89D8: A9 30     
	STA $7F89,X        		; 36/89DA: 9D 89 7F   duty cycle
	LDA #$0F           		; 36/89DD: A9 0F     
	STA $7F90,X        		; 36/89DF: 9D 90 7F   channel volume
	LDA #$FF           		; 36/89E2: A9 FF     
	STA $7FC1,X        		; 36/89E4: 9D C1 7F  
	STA $7FEB,X        		; 36/89E7: 9D EB 7F  
	STA $7FA5,X        		; 36/89EA: 9D A5 7F  
	STA $7FBA,X        		; 36/89ED: 9D BA 7F  
	DEX                		; 36/89F0: CA         next channel
	BPL B89C8          		; 36/89F1: 10 D5     
	LDA #$96           		; 36/89F3: A9 96     
	STA $7F45          		; 36/89F5: 8D 45 7F   tempo 150
	LDA #$00           		; 36/89F8: A9 00     
	STA $7F46          		; 36/89FA: 8D 46 7F   reset tempo counter
	STA $7F47          		; 36/89FD: 8D 47 7F  
	LDA $7F43          		; 36/8A00: AD 43 7F   song id
	CMP #$19           		; 36/8A03: C9 19     
	BCC B8A0E          		; 36/8A05: 90 07     
	CMP #$2B           		; 36/8A07: C9 2B     
	BCS B8A1D          		; 36/8A09: B0 12     
; songs $19-$2A
	SEC 				; 36/8A0B: 38        
	SBC #$19                        ; 36/8A0C: E9 19     
; songs $00-$18
B8A0E:
	ASL 				; 36/8A0E: 0A        
	TAX                             ; 36/8A0F: AA        
	LDA $A000,X                     ; 36/8A10: BD 00 A0  
	STA $D8                         ; 36/8A13: 85 D8     
	LDA $A001,X                     ; 36/8A15: BD 01 A0  
	STA $D9                         ; 36/8A18: 85 D9     
	JMP B8A57                       ; 36/8A1A: 4C 57 8A  
; songs $2B-36
B8A1D:
	CMP #$37			; 36/8A1D: C9 37     
	BCS B8A33                       ; 36/8A1F: B0 12     
	SEC                             ; 36/8A21: 38        
	SBC #$2B                        ; 36/8A22: E9 2B     
	ASL                             ; 36/8A24: 0A        
	TAX                             ; 36/8A25: AA        
	LDA $8C77,X                     ; 36/8A26: BD 77 8C  
	STA $D8                         ; 36/8A29: 85 D8     
	LDA $8C78,X                     ; 36/8A2B: BD 78 8C  
	STA $D9                         ; 36/8A2E: 85 D9     
	JMP B8A57                       ; 36/8A30: 4C 57 8A  
; songs $37-$3A
B8A33:
	CMP #$3B			; 36/8A33: C9 3B     
	BCS B8A49                       ; 36/8A35: B0 12     
	SEC                             ; 36/8A37: 38        
	SBC #$37                        ; 36/8A38: E9 37     
	ASL                             ; 36/8A3A: 0A        
	TAX                             ; 36/8A3B: AA        
	LDA $B3AE,X                     ; 36/8A3C: BD AE B3	pointers to songs $37-$3A
	STA $D8                         ; 36/8A3F: 85 D8     
	LDA $B3AF,X                     ; 36/8A41: BD AF B3  
	STA $D9                         ; 36/8A44: 85 D9     
	JMP B8A57                       ; 36/8A46: 4C 57 8A  
; songs $3B-$40
B8A49:
	SBC #$3B			; 36/8A49: E9 3B     
	ASL             		; 36/8A4B: 0A        
	TAX             		; 36/8A4C: AA        
	LDA $B400,X     		; 36/8A4D: BD 00 B4	pointers to songs $3B-$40
	STA $D8         		; 36/8A50: 85 D8     
	LDA $B401,X     		; 36/8A52: BD 01 B4  
	STA $D9         		; 36/8A55: 85 D9     
B8A57:
	LDX #$04        		; 36/8A57: A2 04     
	LDY #$09        		; 36/8A59: A0 09     
B8A5B:
	LDA ($D8),Y     		; 36/8A5B: B1 D8     
	STA $7F58,X     		; 36/8A5D: 9D 58 7F  
	DEY             		; 36/8A60: 88        
	LDA ($D8),Y     		; 36/8A61: B1 D8     
	STA $7F51,X     		; 36/8A63: 9D 51 7F  
	DEY             		; 36/8A66: 88        
	DEX             		; 36/8A67: CA        
	BPL B8A5B       		; 36/8A68: 10 F1     
	LDX #$04        		; 36/8A6A: A2 04     
B8A6C:
	LDA #$FF        		; 36/8A6C: A9 FF        ; channel disabled if pointer = $FFFF
	CMP $7F51,X     		; 36/8A6E: DD 51 7F  
	BNE B8A78       		; 36/8A71: D0 05     
	CMP $7F58,X     		; 36/8A73: DD 58 7F  
	BEQ B8A80       		; 36/8A76: F0 08     
B8A78:
	LDA $7F4A,X     		; 36/8A78: BD 4A 7F  
	ORA #$80        		; 36/8A7B: 09 80     
	STA $7F4A,X     		; 36/8A7D: 9D 4A 7F     ; channel enabled
B8A80:
	DEX             		; 36/8A80: CA        
	BPL B8A6C       		; 36/8A81: 10 E9     
	JSR SetVolS       		; 36/8A83: 20 87 8A     ; set volume for starting music
	RTS             		; 36/8A86: 60        
; End of InitSong

; Name	: SetVolS
; Marks	: set volume for starting music
SetVolS:
	LDA $7F42			; 36/8A87: AD 42 7F  
	AND #$08        		; 36/8A8A: 29 08     
	BNE B8A99       		; 36/8A8C: D0 0B     
	LDA #$80        		; 36/8A8E: A9 80        ; no fade in
	STA $7F42       		; 36/8A90: 8D 42 7F  
	LDA #$0F        		; 36/8A93: A9 0F        ; full volume
	STA $7F44       		; 36/8A95: 8D 44 7F  
	RTS             		; 36/8A98: 60        
B8A99:
	LDA #$A0        		; 36/8A99: A9 A0        ; fade in
	STA $7F42       		; 36/8A9B: 8D 42 7F  
	LDA #$00        		; 36/8A9E: A9 00        ; zero volume
	STA $7F44       		; 36/8AA0: 8D 44 7F  
	STA $7F48       		; 36/8AA3: 8D 48 7F     ; reset fade counter
	RTS             		; 36/8AA6: 60        
; End of SetVolS

; Name	: SetVolT
; Marks	: set volume for stopping music
SetVolT:
	LDA $7F42			; 36/8AA7: AD 42 7F  
	AND #$08        		; 36/8AAA: 29 08     
	BNE B8AB5       		; 36/8AAC: D0 07     
	STA $7F42       		; 36/8AAE: 8D 42 7F  
	JSR SilenceMusicCh    		; 36/8AB1: 20 C0 8A     ; silence music channels
	RTS             		; 36/8AB4: 60        
B8AB5:
	LDA #$C0        		; 36/8AB5: A9 C0        ; fade out
	STA $7F42       		; 36/8AB7: 8D 42 7F  
	LDA #$00        		; 36/8ABA: A9 00        ; reset fade counter
	STA $7F48       		; 36/8ABC: 8D 48 7F  
	RTS             		; 36/8ABF: 60        
; End of SetVolT

; Name	: SilenceMusicCh
; Marks	: silence music channels
SilenceMusicCh:
	LDX #$03			; 36/8AC0: A2 03     
B8AC2:
	LDA $7F4A,X     		; 36/8AC2: BD 4A 7F  
	BPL B8AEC       		; 36/8AC5: 10 25        ; branch if channel disabled
	CPX #$01        		; 36/8AC7: E0 01     
	BNE B8AD2       		; 36/8AC9: D0 07        ; branch if not pulse 2
	LDA $7F4F       		; 36/8ACB: AD 4F 7F  
	BMI B8AEC       		; 36/8ACE: 30 1C        ; branch if pulse 2 sound effect active
	BPL B8ADB       		; 36/8AD0: 10 09     
B8AD2:
	CPX #$03        		; 36/8AD2: E0 03     
	BNE B8ADB       		; 36/8AD4: D0 05        ; branch if not noise
	LDA $7F50       		; 36/8AD6: AD 50 7F  
	BMI B8AEC       		; 36/8AD9: 30 11        ; branch if noise sound effect active
B8ADB:
	TXA             		; 36/8ADB: 8A        
	ASL             		; 36/8ADC: 0A        
	ASL             		; 36/8ADD: 0A        
	TAY             		; 36/8ADE: A8        
	CPX #$02        		; 36/8ADF: E0 02     
	BNE B8AE7       		; 36/8AE1: D0 04        ; branch if not triangle
	LDA #$80        		; 36/8AE3: A9 80        ; halt triangle
	BNE B8AE9       		; 36/8AE5: D0 02     
B8AE7:
	LDA #$30        		; 36/8AE7: A9 30        ; halt pulse/noise
B8AE9:
	STA $4000,Y     		; 36/8AE9: 99 00 40  
B8AEC:
	DEX             		; 36/8AEC: CA        
	BPL B8AC2       		; 36/8AED: 10 D3     
	RTS             		; 36/8AEF: 60        
; End of SilenceMusicCh

; Name	: UpdateFadeIn
; [ update fade in ]
UpdateFadeIn:
	LDA $7F48			; 36/8AF0: AD 48 7F  
	BNE B8B0D       		; 36/8AF3: D0 18     
	INC $7F44       		; 36/8AF5: EE 44 7F     ; increment song volume
	LDA $7F44       		; 36/8AF8: AD 44 7F  
	CMP #$0F        		; 36/8AFB: C9 0F     
	BCC B8B08       		; 36/8AFD: 90 09     
	LDA $7F42       		; 36/8AFF: AD 42 7F     ; disable fade in
	AND #$DF        		; 36/8B02: 29 DF     
	STA $7F42       		; 36/8B04: 8D 42 7F  
	RTS             		; 36/8B07: 60        
B8B08:
	LDA #$10        		; 36/8B08: A9 10        ; reset fade in counter
	STA $7F48       		; 36/8B0A: 8D 48 7F  
B8B0D:
	DEC $7F48       		; 36/8B0D: CE 48 7F  
	RTS             		; 36/8B10: 60        
; End of UpdateFadeIn

; [ update fade out ]
; Name	: UpdateFadeOut
UpdateFadeOut:
	LDA $7F48			; 36/8B11: AD 48 7F  
	BNE B8B29       		; 36/8B14: D0 13     
	DEC $7F44       		; 36/8B16: CE 44 7F     ; decrement song volume
	BNE B8B24       		; 36/8B19: D0 09     
	LDA #$00        		; 36/8B1B: A9 00     
	STA $7F42       		; 36/8B1D: 8D 42 7F  
	JSR SilenceMusicCh     		; 36/8B20: 20 C0 8A     ; silence music channels
	RTS             		; 36/8B23: 60        
B8B24:
	LDA #$10        		; 36/8B24: A9 10        ; reset fade in counter
	STA $7F48       		; 36/8B26: 8D 48 7F  
B8B29:
	DEC $7F48       		; 36/8B29: CE 48 7F  
	RTS             		; 36/8B2C: 60        
; End of UpdateFadeOut

; Name	: UpdateMusicCh
; Marks	: update music channels
UpdateMusicCh:
	LDA #$00			; 36/8B2D: A9 00     
	STA $D2         		; 36/8B2F: 85 D2     
	LDA $7F45       		; 36/8B31: AD 45 7F     ; tempo
	CLC             		; 36/8B34: 18        
	ADC $7F46       		; 36/8B35: 6D 46 7F  
	STA $7F46       		; 36/8B38: 8D 46 7F     ; tempo counter
	BCC B8B40       		; 36/8B3B: 90 03     
	INC $7F47       		; 36/8B3D: EE 47 7F  
B8B40:
	LDA $7F46       		; 36/8B40: AD 46 7F  
	SEC             		; 36/8B43: 38        
	SBC #$96        		; 36/8B44: E9 96     
	TAY             		; 36/8B46: A8        
	LDA $7F47       		; 36/8B47: AD 47 7F  
	SBC #$00        		; 36/8B4A: E9 00     
	BCC B8B86       		; 36/8B4C: 90 38        ; branch if no tick
	STA $7F47       		; 36/8B4E: 8D 47 7F  
	STY $7F46       		; 36/8B51: 8C 46 7F  
	LDA #$04        		; 36/8B54: A9 04        ; 4/0 (dmc)
	STA $D0         		; 36/8B56: 85 D0     
	LDA #$00        		; 36/8B58: A9 00     
	STA $D1         		; 36/8B5A: 85 D1     
	JSR UpdateChScript    		; 36/8B5C: 20 E6 81     ; update channel script
	DEC $D0         		; 36/8B5F: C6 D0        ; 3/1 (noise)
	LDA #$01        		; 36/8B61: A9 01     
	STA $D1         		; 36/8B63: 85 D1     
	JSR UpdateChScript    		; 36/8B65: 20 E6 81     ; update channel script
	DEC $D0         		; 36/8B68: C6 D0        ; 2/2 (triangle)
	LDA #$02        		; 36/8B6A: A9 02     
	STA $D1         		; 36/8B6C: 85 D1     
	JSR UpdateChScript     		; 36/8B6E: 20 E6 81     ; update channel script
	DEC $D0         		; 36/8B71: C6 D0        ; 1/3 (pulse 2)
	LDA #$03        		; 36/8B73: A9 03     
	STA $D1         		; 36/8B75: 85 D1     
	JSR UpdateChScript     		; 36/8B77: 20 E6 81     ; update channel script
	DEC $D0         		; 36/8B7A: C6 D0        ; 0/4 (pulse 1)
	LDA #$04        		; 36/8B7C: A9 04     
	STA $D1         		; 36/8B7E: 85 D1     
	JSR UpdateChScript     		; 36/8B80: 20 E6 81     ; update channel script
	JMP $8B40       		; 36/8B83: 4C 40 8B  
B8B86:
	LDA #$00        		; 36/8B86: A9 00     
	STA $D0         		; 36/8B88: 85 D0     
	JSR UpdateChEnv       		; 36/8B8A: 20 7D 85     ; update channel envelopes
	INC $D0         		; 36/8B8D: E6 D0     
	JSR UpdateChEnv       		; 36/8B8F: 20 7D 85     ; update channel envelopes
	INC $D0         		; 36/8B92: E6 D0     
	JSR UpdateChEnv       		; 36/8B94: 20 7D 85     ; update channel envelopes
	INC $D0         		; 36/8B97: E6 D0     
	JSR UpdateChEnv       		; 36/8B99: 20 7D 85     ; update channel envelopes
	RTS             		; 36/8B9C: 60        
; End of UpdateMusicCh



; ==================================================
; Convert from FF1
;
; 0. rest.
; $Cx -> $Dy oo
; $Cx = $Cx ooo
;
; 0. tick
; $F8,$?? -> $Cx ??
; $F8,$?? -> $Dx ?? <-
;
; 1. octave
;      $d8, $d9, $da, $db	<- FF1
; $F0, $F1, $F2, $F3, $F4, $F5
;
; 2. repeat
; D0h = Infinite loop -> FDh(FF2)
; D1h-D7h = loop count -> F7h-FBh(FF2)
; $Dx -> $Fy
;
; 3. Envelop pattern select
; FF1 -> FF2
; $Ex -> comment
;
; 4. Play a note. Score(Beat is differ)
; 00h-BFh
; FF1           -> FF2(Beat)
; 0		-> 1(3/2)
; 1             -> 2(1/2)
; 3		-> 5(1/4)
; 5 5		-> 8(1/8)
; 7 7 7 7	-> B(1/16)
; 99999999	-> D(1/32)
; C		-> E(1/48)
; 4		-> 6(3/16)
;
; 5. Tempo select
; FF1     -> FF2
; F9h-FEh -> E0h,(tempo value)





; ==================================================
; chocobo (FF3 version) - good
; octave +1

BGM_FF3_CHOCOBO:
.word BGM_FF3_CHOCOBO_CH0		; .byte $8B,$AA
.word AB3D		; .byte $3D,$AB
.word AB81		; .byte $81,$AB
;.byte $FF,$FF
;.byte $FF,$FF

BGM_FF3_CHOCOBO_CH0:		; CH0
.byte $F6,$30,$15,$BD,$CB,$BE		; added from ff2 chocobo
;.byte $E0,$9B	tempo - original
;.byte $E0,$46		; tempo
.byte $E0,$4D		; tempo more fast - half of original
;.byte $F5,$03,$07
;.byte $EB
AA91:
.byte $C0,$C1,$C6
.byte $F2,$BE,$F3,$0E,$1E
;.byte $FB		; loop counter 5
;.byte $02
.byte $F8		; loop counter 2
AA9B:
.byte $2B,$C6,$F2,$BB,$CB		; AA90
.byte $7B,$CB,$48,$F3,$2B,$CB,$F2,$BB,$CB,$7B,$CB,$BB,$C6,$7B,$C6,$B3
.byte $9B,$CB,$7B,$CB,$7B,$9B,$7B,$CB,$5B,$CB,$73,$5B,$CB
.byte $FD		; repeat
.word AAD3		; .byte $D3,$AA
.byte $7B,$CB,$7B,$BB,$F3,$2B,$CB,$4B,$CB,$55
.byte $D6
.byte $F2,$BE,$F3,$0E,$1E
.byte $FC		; repeat
.word AA9B		; .byte $9B,$AA
AAD3:
.byte $F2
.byte $7B,$CB,$7B,$BB,$F3,$2B,$CB,$4B,$CB,$55
.byte $D6
.byte $0E,$2E,$3E
;.byte $FB		; loop counter 5
;.byte $02
.byte $F8		; loop counter 2
AAE4:
.byte $4B,$C6,$0B,$CB,$F2,$9B,$CB,$68,$9B,$CB,$F3,$0B
.byte $CB,$4B,$CB,$2B,$C6,$7B,$C6,$23,$F2,$BB,$CB
.byte $FD		; repeat
.word AB22		; .byte $22,$AB
.byte $F3,$0B		; AAF0
.byte $C6,$F2,$9B,$CB,$6B,$CB,$28,$6B,$CB,$9B,$CB,$F3,$0B,$CB,$F2,$BB		; AB00
.byte $CB,$BB,$F3,$0B,$F2,$BB,$CB,$9B,$CB,$B5
.byte $D6
.byte $F3,$0E,$2E,$3E
.byte $FC		; repeat
.word AAE4		; .byte $E4,$AA
AB22:
.byte $F2,$9B,$CB,$9B,$BB,$9B,$CB,$7B,$CB,$93,$7B,$CB,$9B,$CB
.byte $9B,$BB,$F3,$0B,$CB,$2B,$CB,$4B,$C6,$65
.byte $FE		; repeat
.word AA91		; $91,$AA

AB3D:		; CH1
;.byte $F5,$03,$07
;.byte $E8
;.byte $F6,$70,$15,$BD,$FF,$FF		; too simple/matt
.byte $F6,$30,$15,$BD,$CB,$BE		; added from ff2 chocobo
.byte $EB
AB41:
.byte $FB		;.byte $FB,$05		; loop counter 5
AB43:
.byte $C5
.byte $F2,$2B,$C6,$C8,$0B,$C6,$0B,$C6,$2B,$C6,$2B,$C6
.byte $C8,$0B,$C6
.byte $FC		; repeat
.word AB43		; .byte $43,$AB
.byte $F9		; .byte $FB,$03		; loop counter 3
AB58:
.byte $C5,$0B,$C6,$C8,$0B,$C6,$0B,$C6
.byte $2B,$C6,$2B,$C6,$2B,$C6,$2B,$CB
.byte $FC		; repeat
.word AB58		; .byte $58,$AB
.byte $C8,$0B,$C6,$0B,$C6
.byte $0B,$C6,$0B,$C6,$0B,$CB,$4B,$CB,$BB,$CB,$9B,$C6
.byte $F3,$05
.byte $FE		; repeat
.word AB41		; .byte $41,$AB

AB81:		; TRI
.byte $FB		; .byte $FB,$05		; loop counter 5
AB83:
.byte $F2,$7B,$C6,$BB,$CB,$7B,$CB,$58,$9B,$C6,$9B,$CB,$78
.byte $BB,$CB,$78,$BB,$CB,$5B,$C6,$9B,$CB,$5B,$CB
.byte $FC		; repeat
.word AB83		; .byte $83,$AB
.byte $F8		; .byte $FB,$02		; loop counter 2 AB90
ABA0:
.byte $0B,$C6,$7B,$CB,$0B,$CB,$28,$9B,$C6,$9B,$CB,$78,$BB,$CB,$78,$BB		; ABA0
.byte $CB,$68,$BB,$CB,$28,$BB,$CB
.byte $FD		; repeat
.word ABD4		; .byte $D4,$AB
.byte $0B,$C6,$7B,$CB,$0B,$CB
.byte $28,$9B,$C6,$9B,$CB,$78,$BB,$CB,$78,$BB,$CB,$58,$BB,$CB,$28,$BB
.byte $CB
.byte $FC		; repeat
.word ABA0		; .byte $A0,$AB
ABD4:
.byte $58,$9B,$CB,$48,$9B,$CB,$28,$9B,$CB,$08,$9B,$CB		; ABD0
.byte $F1,$98,$F2,$4B,$CB,$9B,$CB,$7B,$CB,$6B,$C6,$25
.byte $FE		; repeat
.word AB81		; .byte $81,$AB
; ==================================================



.if 0
; ==================================================
; Final Fantasy 2 Chocobo ORIGINAL
BGM_CHOCOBO:
.word BGM_CHOCOBO_CH0
.word BGM_CHOCOBO_CH1
.word BGM_CHOCOBO_TRI

; CH0		----------
BGM_CHOCOBO_CH0:
.byte SET_P3
.byte D18ICV00
.word VPBD15
.word APBECB
.byte TEMPO,$46
.byte OT2,C1_48,OT3,D1_48,DH1_48					; 1/16
BGM_CHOCOBO_CH0_R1:
.byte R1_16,X3_16							; 1/4
.byte OT2,C1_8,S1_16,X1_16						; 1/4
.byte M1_8,OT3,R1_16,X1_16						; 1/4
.byte OT2,C1_16,X1_16,S1_16,X1_16					; 1/4
.byte C1_16,X3_16,S1_16,X3_16,C3_8,L1_8					; 1
.byte S1_16,X1_16,S1_16,L1_16,S1_16,X1_16,F1_16,X1_16,S3_8,F1_8		; 1
.byte S1_16,X1_16,S1_16,C1_16,OT3,R1_16,X1_16,M1_16,X1_16		; 1/2
.byte F3_8,X1_16,OT2,C1_48,OT3,D1_48,DH1_48				; 1/2
.byte REPEAT
.word BGM_CHOCOBO_CH0_R1

; CH1		----------
BGM_CHOCOBO_CH1:
.byte SET_P3
.byte D14ICV00
.word VPBD15
.byte $FF,$FF
.byte VOL11
.byte X1_16
BGM_CHOCOBO_CH1_R1:
.byte X1_8,OT2,R1_16,X3_16,R1_16,X3_16,D1_16,X3_16,D1_16,X1_16		; 1
.byte REPEAT
.word BGM_CHOCOBO_CH1_R1

; TRI		----------
BGM_CHOCOBO_TRI:
.byte X1_16
BGM_CHOCOBO_TRI_R1:
.byte OT2,S1_16,X1_16,C1_16,X3_16,C1_16,X1_16,F1_16,X1_16,L1_16,X3_16,L1_16,X1_16
.byte REPEAT
.word BGM_CHOCOBO_TRI_R1
.endif



.if 0
; ==================================================
; TEST D - CHOCOBO FF3 XXXXX une OOOOO
BGM_FF39:
.word S09_CH0_ABF9		; $F9,$AB
.word S09_CH1_AC7E		; $7E,$AC
.word S09_TRI_ACD8		; $D8,$AC
;.byte $FF,$FF
;.byte $FF,$FF

S09_CH0_ABF9:
.byte $E0,$89
.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $E0,$89,$F6,$02,$07,$EB
S09_CH0_ABFF:
.byte $F8			; repeat 2.byte $FB,$02		; ABFF
.byte $C9,$CE,$F1,$AF,$BB,$C8,$CD,$CE,$AF,$BB,$C8,$CD,$CE,$AF,$BB		; AC00
.byte $CB,$C5,$FC,$01,$AC
.byte $F8			; repeat 2 $FB,$02
S09_CH0_AC17:
.byte $F1,$8B,$6B,$4B,$6B,$8B,$CB,$9B,$CB
.byte $F2,$16,$F1,$BB,$F2,$1B,$CB,$3B,$CB,$48,$7B,$7B,$7B,$CB,$7B,$CB
.byte $72,$88,$6B,$4B,$38,$1B,$F1,$BB,$F2,$4B,$4B,$3B,$1B,$F1,$BB,$9B
.byte $8B,$6B,$7B,$CB,$F2,$4B,$0B,$F1,$BB,$9B,$7B,$5B,$46,$F8,$8D,$4B
.byte $F8,$08,$4B,$C6
.byte $FC
.word S09_CH0_AC17		; $17,$AC
.byte $F3,$4B,$CB,$4B,$CB,$2B,$CB,$0B,$CB
.byte $F2,$B5,$9B,$CB,$7B,$CB,$55,$3B,$CB,$15,$F1,$BB,$CB,$91,$F3,$1B
.byte $F2,$BB,$9B,$7B,$5C,$3C,$1C,$F1,$BC,$9C,$7C
.byte $FE
.word S09_CH0_ABFF		; $FF,$AB

S09_CH1_AC7E:
.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $F6,$02
;.byte $FF,$E8
S09_CH1_AC82:
.byte $F8			; repeat 2 .byte $FB,$02
S09_CH1_AC84:
.byte $C8,$F1,$8B,$C6,$8B,$C6,$8B,$CB,$C5
.byte $FC
.word S09_CH1_AC84		; $84,$AC
.byte $F8			; repeat 2 .byte $FB,$02
.byte $C8,$F0,$BB,$CB,$C3,$BB,$CB,$C3,$F1,$0B,$CB,$C3,$0B,$CB		; AC90
.byte $C3,$F0,$BB,$CB,$C3,$BB,$CB,$C5,$F1,$4B,$CB,$4B,$CB,$3B,$CB,$2B
.byte $CB,$16,$F8,$8D,$1B,$F8,$08,$F2,$1B,$CB,$C8,$FC,$92,$AC,$F2,$8B
.byte $CB,$8B,$CB,$6B,$CB,$4B,$CB,$35,$1B,$CB,$F1,$BB,$CB,$95,$7B,$CB
.byte $55,$3B,$CB,$15,$D0
.byte $FE
.word S09_CH1_AC82		; $82,$AC

S09_TRI_ACD8:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $F8			; repeat 2 .byte $FB,$02
S09_TRI_ACDA:
.byte $F1,$48,$C8,$F0,$B8,$C8
.byte $F1,$48,$C5,$F0,$BB,$CB
.byte $FC
.word S09_TRI_ACDA		; $DA,$AC
.byte $F8			; repeat 2 .byte $FB,$02
S09_TRI_ACEB:
.byte $F1,$48,$C8,$F0,$B8
.byte $C8,$F1,$48,$C5,$F0,$BB,$CB,$F1,$08,$C8,$F0,$78,$C8,$F1,$08,$C5
.byte $2B,$CB,$48,$C8,$F0,$B8,$C8,$F1,$48,$C5,$F0,$BB,$CB,$F1,$0B,$CB		; AD00
.byte $0B,$CB,$F0,$BB,$CB,$AB,$CB,$96,$F5;,$FF,$08
S09_TRI_AD1B:
.byte $9B,$F5;,$FF,$FF,$9B
.byte $CB,$C8
.byte $FC
.word S09_TRI_ACEB		; $EB,$AC
.byte $C0,$F0,$58,$F1,$08,$78,$F0,$88,$F1,$18,$68
.byte $75,$D2,$C2
.byte $FE
.word S09_TRI_ACD8		; $D8,$AC
.endif



.if 0
; ==================================================
; TEST C - MATOYA (initial version - deprecated)
;
; $Cx -> $Dy oo
; $Cx = $Cx xx
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
BGM_8385:			; SQ channel 0
;;.byte $fb - tempo
;.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $F6,$B0,$6A,$BD,$C7,$BE
.byte $F6,$30,$6A,$BD,$C4,$BE
;.byte $F6,$30,$6A,$BD,$FF,$FF
.byte $E0,$61				; tempo
S8386:
.byte $DA;.byte $f8,$08			; tick
.byte $ec				; volume ?? envelope pattern select
.byte $f2,$b7
.byte $f3,$27,$67
.byte $f2,$b7
.byte $f3,$75,$67,$47,$25,$47,$27
.byte $DA;.byte $f8,$08
.byte $ee				; volume
.byte $13

.byte $DA;.byte $f8,$08
.byte $ec				; volume
.byte $27,$67,$97,$27,$b5,$97,$77,$65,$77,$67,$45

.byte $67,$77
.byte $DA;.byte $f8,$08			; tick
.byte $ee				; volume
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
.byte $DA;.byte $f8,$08			; tick
.byte $ee				; volume
.byte $f3,$20
.byte $c5
.byte $D4;.byte $f8,$04			; tick
.byte $e8				; volume e1

.byte $29,$19
.byte $f2,$b9
.byte $f3,$19
.byte $DA;.byte $f8,$08			; tick
.byte $ee				; volume
.byte $20
.byte $c5

.byte $D4;.byte $f8,$04			; tick
.byte $e8				; volume e1
.byte $69,$49,$29,$49
.byte $DA;.byte $f8,$08			; tick
.byte $ee				; volume
.byte $60
.byte $c5

.byte $D4;.byte $f8,$04			; tick
.byte $e8				; volume e1
.byte $99,$79,$69,$79
.byte $DA;.byte $f8,$08			; tick
.byte $ee				; volume
.byte $90

.byte $D4;.byte $f8,$04			; tick
.byte $e8				; volume e1
.byte $69,$49,$29,$19,$49,$29,$19
.byte $f2,$a9,$FE
.word S8386		; ,$86,$83

BGM_841C:			; SQ channel 1
;;.byte $fb
;.byte $F6,$30,$15,$BD,$CB,$BE
;.byte $F6,$30,$C7,$BE,$15,$BD
.byte $F6,$30,$15,$BD,$FF,$FF
.byte $E0,$61				; tempo
S841D:
.byte $DA;.byte $f8,$07,		; tick
.byte $ee				; volume e2

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
.byte $F9				; repeat count - 3
REP_84CA:
.byte $DA;.byte $f8,$08
.byte $ee
.byte $65,$25,$75,$25,$97,$97,$27,$97,$75,$45
.byte $FC		; .byte $d2		; ,$ca,$84		; 84d7
.word REP_84CA
.byte $65,$25,$75,$25,$97,$97,$27,$97,$65,$45
.byte $FE				; repeat to 
.word S841D		; ,$1d,$84

BGM_84E7:			; TRIANGLE
;;.byte $fb
;.byte $F6,$FF,$FF,$FF,$CB,$BE
.byte $E0,$4A				; tempo
S84E8:
;.byte $f8,$08
.byte $ec				; volume
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
.byte $FC		; .byte $d2,$83,$85		; 85ad
.word REP_8583
.byte $27,$99,$c9,$c7,$99,$c9,$27,$b9,$c9,$c7,$b9,$c9,$27,$f3,$19,$c9
.byte $c7,$19,$c9,$f2,$67,$f3,$19,$c9,$f2,$67,$f3,$19,$c9,$FE
.word S84E8		; $e8,$84
.endif



.if 1
; ==================================================
; FF1 No.09
FF1_09:
.word FF1_09_CH0
.byte $FF,$FF
.byte $FF,$FF
;.word FF1_09_CH1
;.word FF1_09_TRI

FF1_09_CH0:
.byte SET_P3
.byte D18ICV00
.word VPBD6A
.word APBEC4
.byte TEMPO,$2B
.byte VOL15
;.byte fb
;.byte f8 03
;.byte e0
;.byte d9 29c9 29c9 59c9 29c9 
FF1_09_CH0_S:
.byte BACK_2
FF1_09_CH0_R1:
.byte OT2,R1_32,X1_32,R1_32,X1_32,F1_32,X1_32,R1_32,X1_32
;00001100: 09c9 f807 45 25 f803 29c9 59c9 29c9 49c9  
.byte D1_32,X1_32,M1_8,R1_8, R1_32,X1_32,F1_32,X1_32,R1_32,X1_32,M1_32,X1_32
;00001110: f807 75 f8 03 79 c9 d1 f790 f805   17 29 c9 59  
.byte S1_8,S1_32,X1_32
.byte BACK_N
.word FF1_09_CH0_R1
.byte DH1_16,R1_32,X1_32,F1_32
;00001120: c999   c9 f8 08ee da 21 c7 f803 e0 d9 bc da 0c  
.byte X1_32,L1_32,X1_32,OT3,R1_2,X1_16,OT2,C1_48,OT3,D1_48
;00001130: d9 bc 99 c9      b9    c9 f805 da07    d9  b9    c9    99   c9     79  
.byte OT2,C1_48,L1_32,X1_32,C1_32,X1_32, OT3,D1_16,OT2,C1_32,X1_32,L1_32,X1_32,S1_32
;00001140: c957   79    c9    99    c9    59    c9 f808 ee 21 f805 e0 17  
.byte X1_32,F1_16,S1_32,X1_32,L1_32,X1_32,F1_32,X1_32, R1_2, DH1_16
;00001150: 29c9   59   c9     99    c9 f808 ee da 21 f803e0 c7d9  
.byte R1_32,X1_32,F1_32,X1_32,L1_32,X1_32,OT3,R1_2,X1_16,OT2
;00001160: bcda 0cd9 bc         99    c9    b9    c9 f805da 07    d9  99    c9  
.byte C1_48,OT3,D1_48,OT2,C1_48,L1_32,X1_32,C1_32,X1_32,OT3,D1_16,OT2,L1_32,X1_32
;00001170: 59c9 99c9          da  47    59    c9    49   c9     09c9 f808 ee 21  
.byte F1_32,X1_32,L1_32,X1_32,OT3,M1_16,F1_32,X1_32,M1_32,X1_32,D1_32,X1_32,R1_2
;00001180: f805 e0 07 d9 97 5797  b7   da 07      d9 b7 97 f808  
.byte D1_16,OT2,L1_16,F1_16,L1_16,C1_16,OT3,D1_16,OT2,C1_16,L1_16
;00001190: b4 f808 b9 b9 f808 b4 f808 b9 b9 f805 da07  
.byte C3_16,C1_32,C1_32,C3_16,C1_32,C1_32,OT3,D1_16
;000011a0: d997 57    97    b7   da   07   d9   b7    97 f808 da 24 f808  
.byte OT2,L1_16,F1_16,L1_16,C1_16,OT3,D1_16,OT2,C1_16,L1_16,OT3,R3_16
;000011b0: 2929 f808 da 24 f808 2929 f805 37  07     d9  87  
.byte R1_32,R1_32,OT3,R3_16,R1_32,R1_32,RH1_16,D1_16,OT2,SH1_16
;000011c0: da07 27    37     27    07 f808 d9 a4 f808 a9 a9 f808  
.byte OT3,D1_16,R1_16,RH1_16,R1_16,D1_16,OT2,LH3_16,LH1_32,LH1_32
;000011d0: d9a4 f808 a9a9 f805 da  37 07  d9 87 da 07 27  
.byte OT2,LH3_16,LH1_32,LH1_32,OT3,RH1_16,D1_16,OT2,SH1_16,OT3,D1_16,R1_16
;000011e0: 37 27 07 f808 54 f808 59 59 f808 54 f808 59  
.byte RH1_16,R1_16,D1_16,F3_16,F1_32,F1_32,F3_16,F1_32
;000011f0: 59
.byte F1_32
.byte REPEAT
.word FF1_09_CH0_S
;.byte d0 f490

.if 0
FF1_09_CH1:
;.byte fb
;.byte f8 05
;.byte e1
.byte d899 c999 c9c4 f805  Y...............
;00001200: 75f8 0599 c9c3 79c9 f805 75f8 0579 c9d1  u.....y...u..y..
;00001210: f891 f808 ee93 f803 e1c7 5779 c999 c9f8  ..........Wy....
;00001220: 08ee b3f8 03e1 c777 99c9 b9c9 f808 eed9  .......w........
;00001230: 03f8 03e1 c7d8 97b9 c9d9 09c9 f808 eed8  ................
;00001240: b3f8 03e1 c777 99c9 b9c9 d112 92f8 05d9  .....w..........
;00001250: 57c7 07c7 d897 c7d9 07c7 5727 5727 5727  W.........W'W'W'
;00001260: 5727 d14d 9287 c737 c707 c737 c787 5787  W'.M...7...7..W.
;00001270: 5787 5787 57d1 6592
.byte REPEAT
.word FF1_09_CH1
;.byte d0 f5 91

FF1_09_TRI:
;.byte fb
;.byte f8 08
;.byte ec
.byte da
;00001280: 29c9 29c9 c405 29c9 c309 c9d9 b5b9 c9d1  ).)...).........
;00001290: 7f92 da29 c929 c959 c959 c929 c9c5 09c9  ...).).Y.Y.)....
;000012a0: 29c9 29c9 79c9 79c9 29c9 c509 c929 c929  ).).y.y.)....).)
;000012b0: c999 c999 c929 c9c5 09c9 29c9 29c9 79c9  .....)....).).y.
;000012c0: 79c9 29c9 c509 c9d1 9292 d959 c959 c9da  y.)........Y.Y..
;000012d0: 59c9 59c6 d959 c9da 59c9 09c9 d974 79c9  Y.Y..Y..Y....ty.
;000012e0: 7479 c9d1 ca92 89c9 89c9 da89 c989 c6d9  ty..............
;000012f0: 89c9 da89 c939 c9d9 a4a9 c9a4 a9c9 d1e6  .....9..........
;00001300: 92
.byte REPEAT
.word FF1_09_TRI
;.byte d0 7c92
.endif
.endif



; ==================================================
; FF1 No22
.if 0
;00001ae0: 7392 fffb f808 e1d8 acd8 2c5c acd9 2c5c  s.........,\..,\
;00001af0: acda 2c5c acdb 2c5c acff fbf8 08e2 c7d8  ..,\..,\........
;00001b00: acd8 2c5c acd9 2c5c acda 2c5c acdb 2c5c  ..,\..,\..,\..,\
;00001b10: acff fbf8 08ec c7c7 d8cc ccd9 cccc ccda  ................
;00001b20: cccc ccdb cccc ccdc cccc fffc f807 e0da  ................
.endif



; ==================================================
; FF1 No.23 Effect
;
FF1_23:
.word FF1_23_CH0
.word FF1_23_CH1
.word FF1_23_TRI
FF1_23_CH0:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte VOL15
.byte TEMPO,$4B			; temp
;.byte fc
;.byte f8 07
;.byte e0
;.byte da 79 b9 db 39 79 b9 ff
.byte OT3,S1_8,C1_8,OT4,LH1_8,S1_8,C1_8,$FF
FF1_23_CH1:
.byte $F6,$30,$15,$BD,$CB,$BE
;.byte fc
;.byte f807
;.byte e1
;.byte d9 b9 da 39 79 b9 db 39 ff
.byte OT1,C1_8,OT2,LH1_8,S1_8,C1_8,OT3,LH1_8,$FF
FF1_23_TRI:
.byte $F6,$FF,$FF,$FF,$CB,$BE
;.byte fc
;f8 08
;e0
;.byte c9 c9 c9 c9 c9 $ff
.byte X1_8,X1_8,X1_8,X1_8,X1_8,$FF



; ==================================================
; TEST B
; A1D2 - real address - dungeon
A1D2:
.word A1DC				; $DC $A1
.word A324				; $24 $A3
.word A401				; $01,$A4
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
.byte $FB,$02,$EB,$FB,$09,$F1,$7E,$F2,$7E,$FC,$15,$A2,$FB,$03,$F2,$2E		; A210
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
.byte $D8,$D2,$35,$F2,$2E,$5E,$AE,$F3,$2B,$D8,$D2,$C5,$FC,$E4,$A2,$F2		; A300
.byte $3E,$5E,$8E,$F3,$0B,$D8,$D2,$75,$F2,$5E,$AE,$F3,$2E,$5B,$D8,$D2
.byte $C5,$FE
.word A210				; $10,$A2
A324:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $E0,$46
.byte $F2
.byte $BE
.byte $F3,$0E,$1E		; end of copy data
.byte $F5,$02,$FF,$E1,$F0,$7B,$9B,$AB,$F1,$2B,$E2,$F0		; A320
.byte $AB,$9B,$7B,$9B,$E3,$AB,$F1,$2B,$F0,$AB,$9B,$E4,$7B,$9B,$AB,$F1
.byte $2B,$E5,$F0,$7B,$9B,$AB,$F1,$3B,$E6,$F0,$AB,$9B,$7B,$9B,$E7,$AB
.byte $F1,$3B,$F0,$AB,$9B,$E8,$7B,$9B,$AB,$F1,$3B,$E9
A35C:
.byte $FB,$02,$FB,$02
.byte $F0,$7B,$9B,$AB,$F1,$2B,$F0,$AB,$9B,$FC,$60,$A3,$7B,$9B,$AB,$F1		; A360
.byte $2B,$FB,$02,$F0,$7B,$9B,$AB,$F1,$3B,$F0,$AB,$9B,$FC,$73,$A3,$7B
.byte $9B,$AB,$F1,$3B,$FB,$02,$F0,$7B,$9B,$AB,$F1,$4B,$F0,$AB,$9B,$FC
.byte $86,$A3,$7B,$9B,$AB,$F1,$4B,$FB,$02,$F0,$7B,$9B,$AB,$F1,$3B,$F0
.byte $AB,$9B,$FC,$99,$A3,$7B,$9B,$AB,$F1,$3B,$FC,$5E,$A3,$FB,$02,$FB
.byte $02,$F0,$7B,$8B,$F1,$0B,$3B,$0B,$F0,$8B,$FC,$B1,$A3,$7B,$8B,$F1
.byte $0B,$3B,$FB,$02,$F0,$7B,$8B,$F1,$2B,$5B,$2B,$F0,$8B,$FC,$C4,$A3
.byte $7B,$8B,$F1,$2B,$5B,$FB,$02,$F0,$7B,$8B,$F1,$3B,$7B,$3B,$F0,$8B
.byte $FC,$D7,$A3,$7B,$8B,$F1,$3B,$7B,$FB,$02,$F0,$7B,$8B,$F1,$2B,$5B		; A3E0
.byte $2B,$F0,$8B,$FC,$EA,$A3,$7B,$8B,$F1,$2B,$5B,$FC,$AF,$A3,$FE
.word A35C				; $5C,$A3
A401:
.byte $F6,$30,$15,$BD,$CB,$BE
.byte $E0,$46
.byte $F2
.byte $BE
.byte $F3,$0E,$1E		; end of copy data
.byte $C0,$C0
A403:
.byte $FB,$02,$F1,$23,$DB,$CB,$23,$DB,$CB,$33,$DB,$CB,$36		; A400
.byte $DD,$CD,$3C,$CC,$3C,$CC,$3C,$CC,$43,$DB,$CB,$46,$DD,$CD,$4C,$CC
.byte $4C,$CC,$4C,$CC,$33,$DB,$CB,$33,$DB,$CB,$FC,$05,$A4,$FB,$02,$F0
.byte $51,$F1,$05,$F0,$51,$F1,$25,$F0,$51,$F1,$35,$F0,$51,$C5,$FC,$2F		; A430
.byte $A4,$FE
.word A403				; $03,$A4



; ==================================================
; TEST A
; A07C - real address is $8722 - FF3 prelude
; octave = -1 (EFh -> F0h, F4h -> F5h)

.if 0
A07C:
.word A086		; A07C	$86 $A0 - $8728
.word A1CA		; A07E	$CA $A1 - $886C
.byte $FF,$FF;,$FF,$FF,$FF,$FF
A086:
;.byte $F7,$02,$FF,$EB	original code
;.byte $F6,$30,$15,$BD,$CB,$BE
.byte $F6,$B0,$37,$BD,$FF,$FF
.byte $EB
A08A:
.byte $E0,$28		; .byte $E0,$51			; tempo
.byte $F1,$0B
.byte $E0,$29		; .byte $E0,$53		; A080
.byte $2B
.byte $E0,$2A		; .byte $E0,$55
.byte $4B
.byte $E0,$2B		; .byte $E0,$57
.byte $7B
.byte $E0,$2C		; .byte $E0,$59
.byte $F2,$0B
.byte $E0,$2D		; .byte $E0,$5B
.byte $2B
.byte $E0,$2E		; .byte $E0,$5D		; A090
.byte $4B
.byte $E0,$2F		; .byte $E0,$5F

.byte $7B
.byte $F3,$0B,$2B,$4B,$7B
.byte $F4,$0B,$2B,$4B,$7B

.byte $F8		; .byte $FB,$02		repeat - 2
A0B0:
.byte $F5,$0B
.byte $F4,$7B,$4B,$2B,$0B
.byte $F3,$7B,$4B,$2B,$0B
.byte $F2,$7B,$4B,$2B,$0B
.byte $F1,$7B,$4B,$2B
.byte $F0		; .byte $EF
.byte $9B,$BB
.byte $F1,$0B,$4B,$9B,$BB
.byte $F2,$0B,$4B,$9B,$BB
.byte $F3,$0B,$4B,$9B,$BB
.byte $F4,$0B,$4B,$9B,$4B,$0B
.byte $F3,$BB,$9B,$4B,$0B
.byte $F2,$BB,$9B,$4B,$0B
.byte $F1,$BB,$9B,$4B,$0B
.byte $F0		; .byte $EF
.byte $BB
.byte $FD		; repeat
.word A108		; $08,$A1
.byte $F1,$0B,$2B,$4B,$7B
.byte $F2,$0B,$2B,$4B,$7B
.byte $F3,$0B,$2B,$4B,$7B
.byte $F4,$0B,$2B,$4B,$7B
.byte $FC		; repeat
.word A0B0		; .byte $B0,$A0
A108:
.byte $9B
.byte $F1,$0B,$5B,$7B,$9B
.byte $F2,$0B		; A100
.byte $5B,$7B,$9B
.byte $F3,$0B,$5B,$7B,$9B
.byte $F4,$0B,$5B,$7B,$9B,$7B,$5B,$0B
.byte $F3,$9B,$7B,$5B,$0B
.byte $F2,$9B,$7B,$5B,$0B
.byte $F1,$9B,$7B,$5B,$0B
.byte $F0		; .byte $EF
.byte $BB
.byte $F1,$2B,$7B,$9B,$BB
.byte $F2,$2B,$7B,$9B,$BB
.byte $F3,$2B,$7B,$9B,$BB
.byte $F4,$2B,$7B,$9B,$BB,$9B,$7B,$2B
.byte $F3,$BB,$9B,$7B,$2B
.byte $F2,$BB,$9B,$7B,$2B
.byte $F1,$BB,$9B,$7B,$2B
.byte $F0		; .byte $EF
.byte $8B
.byte $F1,$0B,$3B,$7B,$8B
.byte $F2,$0B,$3B,$7B,$8B
.byte $F3,$0B,$3B,$7B,$8B
.byte $F4,$0B,$3B,$7B,$8B,$7B,$3B,$0B
.byte $F3,$8B,$7B,$3B,$0B
.byte $F2,$8B,$7B,$3B,$0B
.byte $F1,$8B,$7B,$3B,$0B
.byte $F0		; .byte $EF
.byte $AB
.byte $F1,$2B,$5B,$9B,$AB
.byte $F2,$2B,$5B,$9B,$AB
.byte $F3,$2B,$5B,$9B,$AB
.byte $F4,$2B,$5B,$9B
.byte $E0,$2F		; .byte $E0,$5E
.byte $AB
.byte $E0,$2E		; .byte $E0,$5D
.byte $9B
.byte $E0,$2E		;.byte $E0,$5C
.byte $5B
.byte $E0,$2D		;.byte $E0,$5B
.byte $2B
.byte $E0,$2D		;.byte $E0,$5A
.byte $F3,$AB
.byte $E0,$2C		;.byte $E0,$59
.byte $9B
.byte $E0,$2C		;.byte $E0,$58
.byte $5B
.byte $E0,$2B		;.byte $E0,$57
.byte $2B
.byte $E0,$2A		;.byte $E0,$55
.byte $F2		; A1A0
.byte $AB
.byte $E0,$29		;.byte $E0,$53
.byte $9B
.byte $E0,$28		;.byte $E0,$51
.byte $5B
.byte $E0,$27		;.byte $E0,$4F
.byte $2B
.byte $E0,$26		;.byte $E0,$4C
.byte $F1,$AB
.byte $E0,$24		;.byte $E0,$49
.byte $9B
.byte $E0,$23		;.byte $E0,$46
.byte $5B
.byte $E0,$21		;.byte $E0,$43
.byte $2B
.byte $FE		; repeat
.word A08A		; A1C8	$8A $A0
A1CA:
;.byte $F7,$02,$00	original
.byte $F6,$B0,$37,$BD,$FF,$FF
.byte $E5
.byte $CA
.byte $FE		; repeat
.word A08A		; A1D0	$8A $A0
.endif





; ==================================================
; TEST B
; Pitch example
;	  XYh ~ XYh: X = pitch, Y = length(0=longest, F=shortest)
;	   0Yh=C, 2Yh=D, 4Yh=E, 5Yh=F, 7Yh=G, 9Yh=A, BYh=B
;	   X0h=1, X1h=3/4
;	   X2h=1/2,  X3h=3/8,  X4h=1/3
;	   X5h=1/4,  X6h=3/16, X7h=1/6
;	   X8h=1/8,  X9h=3/32, XAh=1/12
;	   XBh=1/16,           XCh=1/24
;	   XDh=1/32,           XEh=1/48, XFh=1/96
;	  C0h ~ CFh: Cut ?? Reset ??
;	  D0h ~ DFh: rest length(Delay 0=longest, F=shortest)
;	  E0h: tempo counter rate(next 1 byte) - lower(Slow) < 4Bh(base) < (Fast)
;	  E1h ~ EFh: volume !!
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
;		APBED6:
;		APBEDD:
;		APBEE0:
;		APBEE4:
;		APBEEE:
;		APBEF9:
;	  F7h,F8h,F9h,FAh,FBh: loop counter(?, 2, 3, 4. 5)
;	  FCh: repeat - if loop count is exist
;	  FDh: repeat - ??
;	  FEh: repeat
;	  FFh: stop
.if 1
BGM_TEST:
.word TESTB_CH1_S
.byte $FF,$FF
;.word TESTB_CH2_S
.byte $FF,$FF		; A080	- Triangle

TESTB_CH1_S:
.byte SET_P3		;$F6			; Settings (3 parameters)
.byte D12ICV15		;.byte $BF		; DDLC VVVV(Duty/Constant/Volume,envelope) APU $4000,$4004, Envelope(0=
;.byte D12ICV00

;.word VPBD04		; short
;.word VPBD15		; short
;.word VPBD26		; short
;.word VPBD37		; short
;		VPBD43:o
;.word VPBD6A		; normal
;.word VPBD99		; normal vibration
.word VPBDD2		; long
;		VPBE01:o
;.word VPBE66		; normal		BEC7
;.word VPBE87		; long vibration	BEC7,BEE0
;.byte $FF,$FF
;.byte $37,$BD

;.word APBEAF				; mysteriuos
;.word APBEC4
;		APBEC7:*
;		APBECB:*
;.word APBEDD
;		APBEE0:
;		APBEE4:
;		APBEF9:
.byte $FF,$FF

.byte VOL15					;.byte $EF					; Set volume (E1h-EFh)
.byte TEMPO, $4B				;.byte $E0,$4B					; Set tempo

BGM_TEST_S:

.byte OT3,R1_16,DH1_16,OT2,C1_16,OT3,DH1_16
.byte R1,R1_2,R1_4
.byte FH1_16,M1_16,R1_16,M1_16						; 4
.byte FH1,FH1_2,FH1_4
.byte L1_16,S1_16,FH1_16,S1_32,X1_32					; 2
.byte REPEAT
.word BGM_TEST_S

.if 1
.byte $F2
;     C   D   E   F   G   A   B
.byte $00,$20,$40,$50,$70,$90,$B0
.byte $F3					; Octave 1
;     C
.byte $00
.byte $F2
;     C   D   E   F   G   A   B
.byte $00,$20,$40,$50,$80,$90,$B0
.byte $F3					; Octave 1
;     C
.byte $00,$00
.byte $F2
;     C   D   E   F   G   A   B
.byte $00,$20,$40,$50,$60,$90,$B0
.byte $F3					; Octave 1
;     C
.byte $00,$00,$00
.byte REPEAT
.word BGM_TEST_S
.else
.byte $F0					; Octave 0
.byte $CF
.byte $02,$C2,$22,$C2,$42,$C2,$52,$C2,$72,$C2,$92,$C2,$B2,$C2
.byte $F1					; Octave 1
;     C
.byte $00,$00
.byte $F0					; Octave 0
.byte $CF
.byte $05,$C5,$05,$C5,$25,$C5,$25,$C5,$45,$C5,$45,$C5,$55,$C5,$55,$C5,$75,$C5,$75,$C5,$95,$C5,$95,$C5,$B5,$C5,$B5,$C5
.byte $F1					; Octave 1
;     C
.byte $00,$00,$00
.byte $F0					; Octave 0
.byte $CF
.byte $08,$C8,$08,$C8,$08,$C8,$08,$C8
.byte $28,$C8,$28,$C8,$28,$C8,$28,$C8
.byte $48,$C8,$48,$C8,$48,$C8,$48,$C8
.byte $58,$C8,$58,$C8,$58,$C8,$58,$C8
.byte $78,$C8,$78,$C8,$78,$C8,$78,$C8
.byte $98,$C8,$98,$C8,$98,$C8,$98,$C8
.byte $B8,$C8,$B8,$C8,$B8,$C8,$B8,$C8
.byte $F1					; Octave 1
;     C
.byte $00,$00,$00,$00
.byte $CF
.endif

.if 0
.byte $CF
;     C   D   E   F   G   A   B
.byte $00,$20,$40,$50,$70,$90,$B0
.byte $F1					; Octave 1
;     C
.byte $00
.byte $F0					; Octave 0
.byte $04,$24,$44,$54,$74,$94,$B4
.byte $F1					; Octave 1
.byte $04
.byte $F0					; Octave 0
.byte $08,$28,$48,$58,$78,$98,$B8
.byte $F1					; Octave 1
.byte $08,$08,$08,$08
.byte $F0					; Octave 0
.byte $0C,$2C,$4C,$5C,$7C,$9C,$BC
.byte $F1					; Octave 1
.byte $0C,$0C,$0C,$0C
.byte $0C,$0C,$0C,$0C
.byte $F0
.endif

;$10,$30,$60,$80,$A0,$C0
.byte REPEAT
.word BGM_TEST_S
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
.byte $F8		; .byte $FB,$02		repeat - 2
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
.byte REPEAT
.word BGM_TEST_S

.else



.if 0
; ==================================================
; TEST C - MATOYA(Mod - playable)
;
;0		-> 1(3/4)
;3		-> 5(1/4)
;5 5		-> 8(1/8)
;7 7 7 7	-> B(1/16)
;99999999	-> D(1/32)
;C		-> E(1/48)
;4		-> 6(3/16)
A07C:
.word MATOYA_CH0
;.byte $FF,$FF
.word MATOYA_CH1
;.byte $FF,$FF
.word MATOYA_TRI
MATOYA_CH0:			; SQ channel 0
.byte $F6,$3F				; Settings
;.word VPBD6A
.word VPBD37
.word APBEC4
;.byte $E0,$61				; tempo
.byte $E0,$26				; tempo
.byte $EF				; volume
MATOYA_CH0_S:
;.byte $D8				; tick(Delay) - must be speed
;.byte $EC				; envelope pattern select
.byte $F2,$BB, $F3,$2B,$6B, $F2,$BB
.byte $F3,$78,$6B,$4B
.byte $28,$4B,$2B
;.byte $D8				; tick
;.byte $EE				; envelope pattern select
.byte $15
;.byte $D8				; tick

;.byte $EC				; envelope pattern select
.byte $2B,$6B,$9B,$2B
.byte $B8,$9B,$7B
.byte $68,$7B,$6B
.byte $48,$6B,$7B

;.byte $D8				; tick
;.byte $EE				; envelope pattern select
.byte $95
.byte $18,$48
.byte $2E
.byte $DE				;.byte $CC
.byte $1E
.byte $DE				;.byte $CC
.byte $2E
.byte $DE				;.byte $CC
.byte $F2,$B5

.byte $F3,$7B,$9B
.byte $B5
.byte $28,$78
.byte $6E
.byte $DE				;.byte $CC
.byte $7E
.byte $DE				;.byte $CC
.byte $6E
.byte $DE				;.byte $CC
.byte $45
.byte $9B,$BB

.byte $F4,$15
.byte $DB				;.byte $C7
.byte $F3,$9B,$BB
.byte $F4,$1B
.byte $4D,$2D,$1D,$2D
.byte $F3,$B6

.byte $9B,$7B,$6B
.byte $45
.byte $DB				;.byte $C7
.byte $0B,$2B,$4B
.byte $25
.byte $18
.byte $F2,$98
;.byte $D8				; tick
;.byte $EE				; envelope pattern select
.byte $F3,$21
.byte $C8				;.byte $C5
;.byte $D4				; tick
;.byte $E1				; envelope pattern select

.byte $2D,$1D
.byte $F2,$BD
.byte $F3,$1D
;.byte $D8				; tick
;.byte $EE				; envelope pattern select
.byte $21
.byte $C8				;.byte $C5

;.byte $D4				; tick
;.byte $E8				; envelope pattern select
.byte $6D,$4D,$2D,$4D
;.byte $D8				; tick
;.byte $E1				; envelope pattern select
.byte $61
.byte $C8				;.byte $C5

;.byte $D4				; tick
;.byte $E8				; envelope pattern select
.byte $9D,$7D,$6D,$7D
;.byte $D8				; tick
;.byte $E1				; envelope pattern select
.byte $91

;.byte $D4				; tick
;.byte $E1				; envelope pattern select
.byte $6D,$4D,$2D,$1D,$4D,$2D,$1D
.byte $F2,$AD
.byte $FE				; Repeat
.word MATOYA_CH0_S

MATOYA_CH1:			; SQ channel 1
.byte $F6,$3F
;.word VPBD15
.word VPBD37
.word APBEC4
;.byte $FF,$FF
;.byte $E0,$61				; tempo
.byte $E0,$26				; tempo
.byte $EC				; volume

MATOYA_CH1_S:
;.byte $DA				; tick
;.byte $EE				; volume e2

.byte $F1,$BD,$DD
.byte $F2,$6D,$DD
.byte $F1,$BD,$DD
.byte $F2,$6D,$DD

.byte $F1,$BD,$DD
.byte $F2,$7D,$DD
.byte $F1,$BD,$DD
.byte $F2,$7D,$DD
.byte $F1,$BD,$DD
.byte $F2,$7D,$DD
.byte $F1,$BD,$DD
.byte $F2,$7D,$DD

.byte $1D,$DD,$9D,$DD
.byte $1D,$DD,$9D,$DD

.byte $2D,$DD,$9D,$DD
.byte $2D,$DD,$9D,$DD

.byte $2D,$DD,$BD,$DD
.byte $2D,$DD,$BD,$DD
.byte $2D,$DD,$BD,$DD
.byte $2D,$DD,$BD,$DD

.byte $1D,$DD,$9D,$DD
.byte $1D,$DD,$9D,$DD

.byte $9D,$DD,$9D,$DD,$D8
.byte $9D,$DD,$9D,$DD,$D8

.byte $6D,$DD,$6D,$DD,$D8
.byte $6D,$DD,$6D,$DD,$D8

.byte $BD,$DD,$BD,$DD,$D8
.byte $BD,$DD,$BD,$DD,$D8

.byte $F3
.byte $1D,$DD,$1D,$DD,$D8
.byte $1D,$DD,$1D,$DD,$D8

.byte $F2
.byte $9D,$DD,$9D,$DD,$D8
.byte $9D,$DD,$9D,$DD,$D8
.byte $6D,$DD,$6D,$DD,$D8
.byte $6D,$DD,$6D,$DD,$D8

.byte $4D,$DD,$7D,$DD
.byte $4D,$DD,$7D,$DD
.byte $4D,$DD,$7D,$DD
.byte $4D,$DD,$7D,$DD
.byte $4D,$DD,$7D,$DD
.byte $4D,$DD,$7D,$DD

.byte $9D,$7D,$6D,$4D,$6D,$4D,$2D,$1D
.byte $F9				; Set repeat count as 3
MATOYA_CH1_R:
;.byte $DA				; tick
;.byte $EE				; volume
.byte $68,$28
.byte $78,$28
.byte $9B,$9B,$2B,$9B
.byte $78,$48
.byte $FC				; Repeat 3
.word MATOYA_CH1_R
.byte $68,$28
.byte $78,$28
.byte $9B,$9B,$2B,$9B
.byte $68,$48
.byte $FE				; Repeat
.word MATOYA_CH1_S

MATOYA_TRI:			; TRIANGLE
;.byte $F6,$3F
;.word VPBD15
;.word APBEC4
.byte $E0,$26				; tempo
.byte $EC				; volume
MATOYA_TRI_S:
;.byte $EC				; volume
.byte $F1,$B5
.byte $F2,$45
.byte $75
.byte $98,$78
.byte $25
.byte $75
.byte $B5
.byte $9B,$4D,$CD,$1D,$CD,$F1,$9D,$CD
.byte $CB,$6B,$F2,$1D,$CD,$6D,$CD
.byte $CB,$F1,$6D,$CD,$F2,$6B,$1D,$CD
.byte $CB,$F1,$BB,$F2,$6D,$CD,$BD,$CD
.byte $CB,$F1,$BD,$CD,$F2,$BB,$6D,$CD
.byte $CB,$F1,$7B,$F2,$2D,$CD,$7D,$CD
.byte $CB,$F1,$7D,$CD,$F2,$7B,$2D,$CD
.byte $CB,$F1,$9B,$F2,$4D,$CD,$9D,$CD
.byte $CB,$F1,$9D,$CD,$F2,$9B,$4D,$CD
.byte $CB,$F1,$6B,$F2,$1D,$CD,$6D,$CD
.byte $CB,$F1,$6D,$CD,$F2,$6B,$1D,$CD
.byte $CB,$F1,$BB,$F2,$6D,$CD,$BD,$CD
.byte $CB,$F1,$BD,$CD,$F2,$BB,$6D,$CD
.byte $0B,$F3,$0D,$CD,$F2,$0B,$F3,$0D,$CD
.byte $F2,$0B,$F3,$0D,$CD,$F2,$0B,$F3,$0D,$CD
.byte $F1,$9B,$F2,$9D,$CD,$F1,$9B,$F2,$9D,$CD
.byte $F1,$9B,$F2,$9D,$CD,$F1,$9B,$F2,$9D,$CD
.byte $F9				; Set repeat count as 2 x 3 o
MATOYA_TRI_R:
.byte $2B,$9D,$CD,$CB,$9D,$CD
.byte $2B,$BD,$CD,$CB,$BD,$CD
.byte $2B,$F3,$1D,$CD,$CB,$1D,$CD
.byte $F2,$2B,$BD,$CD,$CB,$BD,$CD
.byte $FC				; Repeat
.word MATOYA_TRI_R
.byte $2B,$9D,$CD,$CB,$9D,$CD
.byte $2B,$BD,$CD,$CB,$BD,$CD
.byte $2B,$F3,$1D,$CD,$CB,$1D,$CD
.byte $F2,$6B,$F3,$1D,$CD,$F2,$6B,$F3,$1D,$CD
.byte $FE				; Repeat
.word MATOYA_TRI_S
.endif
.endif

; ==================================================
; TEST C 2 - MATOYA(Mod - playable modified)
;
;0		-> 1(3/2) o
;3		-> 2(1/2) o <- 5
;4		-> 3(3/8)
;5 5		-> 5(1/4) o <- 8
;7 7 7 7	-> 8(1/8) o <- B
;99999999	-> B(1/16) o <- D
;C		-> A(1/24) o <- E
;4		-> 6(3/16)
FF1_10_MATOYA:
.word FF1_10_CH0
;.byte $FF,$FF
.word MATOYA_CH1
.byte $FF,$FF
;.word MATOYA_TRI

FF1_10_CH0:			; SQ channel 0
.byte SET_P3
.byte D18ICV15
;.word VPBD6A
;.word VPBD37
;.word APBEC7
;.word APBEDD
;.word APBEE4
;.byte $FF,$FF
.word APBF09

;.word APBEC4
;.word APBEC7
;.word APBEDD
;.word APBEE4
;.word APBED6
.word APBF00
;.word APBEAF - fluctuate
;.byte $FF,$FF
.byte TEMPO,$4B
.byte VOL15
FF1_10_CH0_S:
;.byte $D8				; tick(Delay) - must be speed
;.byte $EC				; envelope pattern select
.byte OT2,C1_8,OT3,R1_8,FH1_8,OT2,C1_8,OT3,S1_4,FH1_8,M1_8		; 1
.byte R1_4,M1_8,R1_8
;.byte $D8				; tick F8 08
;.byte $EE				; envelope pattern select
.byte DH1_2								; 2
;.byte $D8				; tick F8 08

;.byte $EC				; envelope pattern select
.byte R1_8,FH1_8,L1_8,R1_8,C1_4,L1_8,S1_8				; 3
.byte FH1_4,S1_8,FH1_8,M1_4,FH1_8,S1_8					; 4

;.byte $D8				; tick F8 08
;.byte $EE				; envelope pattern select
.byte L1_2,DH1_4,M1_4								; 1
.byte R1_24,X1_24,DH1_24,X1_24,R1_24,X1_24,OT2,C1_2,OT3,S1_8,L1_8		; 2
.byte C1_2,R1_4,S1_4								; 3
.byte FH1_24,X1_24,S1_24,X1_24,FH1_24,X1_24,M1_2,L1_8,C1_8			; 4

.byte OT4,DH1_2,X1_8
;.byte $DB				;.byte $C7 A1_8 del
.byte OT3,L1_8,C1_8,OT4,DH1_8						; 1
.byte M1_16,R1_16,DH1_16,R1_16,OT3,C3_8,L1_8,S1_8,FH1_8			; 2
.byte M1_2,X1_8
;.byte $DB				;.byte $C7 del
.byte D1_8,R1_8,M1_8							; 3
.byte R1_2,DH1_4,OT2,L1_4						; 4

;.byte $D8				; tick F8 08
;.byte $EE				; envelope pattern select
;;;.byte OT3,R1,R1_2,X1_4
.byte OT3,R1,A1_2,X1_4
;;$21			; 1 + 3/4
;.byte $C8				;.byte $C5
;.byte $D4				; tick
;.byte $E1				; envelope pattern select
.byte R1_16,DH1_16,OT2,C1_16,OT3,DH1_16					; 2
;.byte $D8				; tick
;.byte $EE				; envelope pattern select
;;.byte $21				; 1 + 3/4
;;.byte $C8				;.byte $C5
;;;.byte R1,R1_2,X1_4
.byte R1,A1_2,X1_4

;.byte $D4				; tick
;.byte $E8				; envelope pattern select
.byte FH1_16,M1_16,R1_16,M1_16						; 4
;.byte $D8				; tick
;.byte $E1				; envelope pattern select
;;.byte $61				; 1 + 3/4				; 1
;;;.byte FH1,FH1_2,X1_4
.byte FH1,A1_2,X1_4
;;.byte $C8				;.byte $C5

;.byte $D4				; tick
;.byte $E8				; envelope pattern select
.byte L1_16,S1_16,FH1_16,S1_16						; 2
;.byte $D8				; tick
;.byte $E1				; envelope pattern select
;;;.byte L1,L1_2
.byte L1,A1_2
;;$91				; 1 + 1/2

;.byte $D4				; tick
;.byte $E1				; envelope pattern select
.byte FH1_16,M1_16,R1_16,DH1_16,M1_16,R1_16,DH1_16,OT2,LH1_16
.byte REPEAT
.word FF1_10_CH0_S

MATOYA_CH1:			; SQ channel 1
.byte SET_P3
.byte D18ICV15
;.word VPBD15
.word VPBD37
.word APBEC4
;.byte $FF,$FF
;.byte $E0,$61				; tempo
;.byte TEMPO,$4B				; tempo
;.byte $EC				; volume
.byte VOL15

MATOYA_CH1_S:
;.byte $DA				; tick
;.byte $EE				; volume e2

;C9 -> X1_16
.byte OT1,C1_16,X1_16
.byte OT2,FH1_16,X1_16
.byte OT1,C1_16,X1_16
.byte OT2,FH1_16,X1_16
.byte OT1,C1_16,X1_16
.byte OT2,S1_16,X1_16
.byte OT1,C1_16,X1_16
.byte OT2,S1_16,X1_16			; 1

.byte OT1,C1_16,X1_16
.byte OT2,S1_16,X1_16
.byte OT1,C1_16,X1_16
.byte OT2,S1_16,X1_16
.byte DH1_16,X1_16,L1_16,X1_16
.byte DH1_16,X1_16,L1_16,X1_16		; 2

.byte R1_16,X1_16,L1_16,X1_16
.byte R1_16,X1_16,L1_16,X1_16
.byte R1_16,X1_16,C1_16,X1_16
.byte R1_16,X1_16,C1_16,X1_16		; 3

.byte R1_16,X1_16,C1_16,X1_16
.byte R1_16,X1_16,C1_16,X1_16
.byte DH1_16,X1_16,L1_16,X1_16
.byte DH1_16,X1_16,L1_16,X1_16		; 4

.byte L1_16,X1_16,L1_16,X1_16,X1_4,L1_16,X1_16,L1_16,X1_16,X1_4			; 1

.byte FH1_16,X1_16,FH1_16,X1_16,X1_4,FH1_16,X1_16,FH1_16,X1_16,X1_4		; 2

.byte C1_16,X1_16,C1_16,X1_16,X1_4,C1_16,X1_16,C1_16,X1_16,X1_4			; 3

.byte OT3
.byte DH1_16,X1_16,DH1_16,X1_16,X1_4,DH1_16,X1_16,DH1_16,X1_16,X1_4		; 4

.byte OT2
.byte L1_16,X1_16,L1_16,X1_16,X1_4,L1_16,X1_16,L1_16,X1_16,X1_4			; 1

.byte FH1_16,X1_16,FH1_16,X1_16,X1_4,FH1_16,X1_16,FH1_16,X1_16,X1_4		; 2

.byte M1_16,X1_16,S1_16,X1_16,M1_16,X1_16,S1_16,X1_16				; 3

.byte M1_16,X1_16,S1_16,X1_16,M1_16,X1_16,S1_16,X1_16				; 4

.byte M1_16,X1_16,S1_16,X1_16,M1_16,X1_16,S1_16,X1_16				; 1

.byte L1_16,S1_16,FH1_16,M1_16,FH1_16,M1_16,R1_16,DH1_16
.byte BACK_3				; Set repeat count as 3
MATOYA_CH1_R:
;.byte $DA				; tick $F8,$08
;.byte $EE				; volume
.byte FH1_4,R1_4								; 1

.byte S1_4,R1_4,L1_8,L1_8,R1_8,L1_8						; 2
.byte S1_4,M1_4									; 3 1/2
.byte BACK_N				; Repeat 3
.word MATOYA_CH1_R
.byte FH1_4,R1_4,S1_4,R1_4				; 3
.byte L1_8,L1_8,R1_8,L1_8,FH1_4,M1_4			; 4
.byte REPEAT
.word MATOYA_CH1_S

MATOYA_TRI:			; TRIANGLE
.byte SET_P3
.byte D18ICV15
.byte $FF,$FF
;.word VPBD15
.word APBEC4
MATOYA_TRI_S:
;.byte $EC				; volume
.byte OT1,$B5
.byte OT2,$45
.byte $75
.byte $98,$78
.byte $25
.byte $75
.byte $B5
.byte $9B,$4D,$CD,$1D,$CD,OT1,$9D,$CD
.byte $CB,$6B,OT2,$1D,$CD,$6D,$CD
.byte $CB,OT1,$6D,$CD,OT2,$6B,$1D,$CD
.byte $CB,OT1,$BB,OT2,$6D,$CD,$BD,$CD
.byte $CB,OT1,$BD,$CD,OT2,$BB,$6D,$CD
.byte $CB,OT1,$7B,OT2,$2D,$CD,$7D,$CD
.byte $CB,OT1,$7D,$CD,OT2,$7B,$2D,$CD
.byte $CB,OT1,$9B,OT2,$4D,$CD,$9D,$CD
.byte $CB,OT1,$9D,$CD,OT2,$9B,$4D,$CD
.byte $CB,OT1,$6B,OT2,$1D,$CD,$6D,$CD
.byte $CB,OT1,$6D,$CD,OT2,$6B,$1D,$CD
.byte $CB,OT1,$BB,OT2,$6D,$CD,$BD,$CD
.byte $CB,OT1,$BD,$CD,OT2,$BB,$6D,$CD
.byte $0B,OT3,$0D,$CD,OT2,$0B,OT3,$0D,$CD
.byte OT2,$0B,OT3,$0D,$CD,OT2,$0B,OT3,$0D,$CD
.byte OT1,$9B,OT2,$9D,$CD,OT1,$9B,OT2,$9D,$CD
.byte OT1,$9B,OT2,$9D,$CD,OT1,$9B,OT2,$9D,$CD
.byte BACK_3				; Set repeat count as 2 x 3 o
MATOYA_TRI_R:
.byte $2B,$9D,$CD,$CB,$9D,$CD
.byte $2B,$BD,$CD,$CB,$BD,$CD
.byte $2B,OT3,$1D,$CD,$CB,$1D,$CD
.byte OT2,$2B,$BD,$CD,$CB,$BD,$CD
.byte BACK_N				; Repeat
.word MATOYA_TRI_R
.byte $2B,$9D,$CD,$CB,$9D,$CD
.byte $2B,$BD,$CD,$CB,$BD,$CD
.byte $2B,OT3,$1D,$CD,$CB,$1D,$CD
.byte OT2,$6B,OT3,$1D,$CD,OT2,$6B,OT3,$1D,$CD
.byte REPEAT				; Repeat
.word MATOYA_TRI_S



; ==================================================
; TEST D - Final Fantasy IX : The place i'll return to someday : ORIGINAL
FF9_BGM:
;.byte $FF,$FF
;.byte $FF,$FF
.word FF9_CH1
.word FF9_CH2
.word FF9_TRI
;.byte $FF,$FF

FF9_CH1:
.byte SET_P3
.byte D12ICV15
.word VPBD43		;.word VPBD37
.word APBEC7
.byte VOL15
.byte TEMPO,$4B

FF9_CH1_S:
.byte OT2,R3_8,M1_8,F1_4,S1_4
.byte L3_4,C1_8,OT3,D1_8
.byte OT2,C1_4,L1_4,S3_8,L1_8
.byte F1_4,M1_4,R1_4,D1_4

.byte OT2,R3_8,M1_8,F1_4,S1_4
.byte L3_4,C1_8,OT3,D1_8
.byte OT2,C1_4,L1_4,L1_4,SH1_4
.byte L3_4,X1_4

.byte R3_8,M1_8,F1_4,S1_4
.byte L3_4,C1_8,OT3,D1_8
.byte OT2,C1_4,L1_4,S3_8,L1_8
.byte F1_4,M1_4,R1_4,D1_4

.byte F3_8,F1_8,S1_8,F1_8,M1_8,R1_8
.byte D1_4,L1_4,M3_8,S1_8
.byte F1_4,M1_4,M1_4,M1_4
.byte R3_4,X1_4
;
.byte OT4,R1_2,OT3,L1_4,OT4,R1_4
.byte D3_8,OT3,C1_8,L1_4,S1_4
.byte L1_4,F1_8,S1_8,L1_4,C1_4
.byte OT4,D1_2,D1_4,X1_4

.byte R1_2,OT3,L1_4,OT4,R1_4
.byte D3_8,OT3,C1_8,L1_4,S1_4
.byte F1_4,L1_4,M1_4,R1_8,DH1_8
.byte R1_2,R1_4,X1_4

.byte OT4,R1_2,OT3,L1_4,OT4,R1_4
.byte D3_8,OT3,C1_8,L1_4,S1_4
.byte L1_4,F1_8,S1_8,L1_4,C1_4
.byte OT4,D1_2,D1_4,X1_4

.byte R1_2,OT3,L1_4,OT4,R1_4
.byte D3_8,OT3,C1_8,L1_4,S1_4
.byte F1_4,L1_4,M1_4,R1_8,DH1_8
.byte R3_4,X1_4


.byte $FE		; Repeat
.word FF9_CH1_S

FF9_CH2:
.byte SET_P3
.byte D12ICV15
.word VPBD43		;.word VPBD37
.word APBEC7
.byte VOL15
.byte TEMPO, $4B

FF9_CH2_S:
.byte OT2,X1_2,R1_4,D1_4
.byte X1_8,D1_8,R1_8,M1_8,F1_4,R1_8,M1_8
.byte R1_4,D1_4,OT1,C1_4,OT2,R1_4
.byte R1_4,D1_4,OT1,L1_4,X1_4

.byte X1_2,D1_2
.byte R1_2,D1_4,R1_8,D1_8
.byte OT1,C1_4,OT2,D1_4,R1_4,M1_4
.byte D1_4,R1_4,M1_2

.byte X1_2,R1_4,D1_4
.byte X1_8,D1_8,R1_8,M1_8,F1_4,R1_8,M1_8
.byte R1_4,D1_4,OT1,C1_4,OT2,R1_4
.byte R1_4,D1_4,OT1,L1_4,X1_4

.byte L1_4,OT2,D1_4,R1_4,OT1,C1_4
.byte L1_4,L1_4,OT2,D1_4,OT1,C1_4
.byte L1_4,OT2,D1_2,DH1_4
.byte OT1,C1_4,L1_2,X1_4
;
.byte OT2,R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_2,M1_4
.byte D1_2,M1_4,X1_4

.byte R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_4,OT1,C1_2
.byte L1_2,L1_4,X1_4

.byte OT2,R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_2,M1_4
.byte D1_2,M1_4,X1_4

.byte R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_4,OT1,C1_2
.byte L3_4,X1_4

.byte $FE		; Repeat
.word FF9_CH2_S

FF9_TRI:
.byte SET_P3
.byte D12ICV15
.byte $FF,$FF
;.word VPBD43		;.word VPBD37
.word APBEC7
.byte VOL15
.byte TEMPO,$4B
FF9_TRI_R0:
.byte X1_2,OT2,L1_4,S1_4
.byte L1_2,OT3,D1_4,OT2,C1_8,OT3,D1_8
.byte OT2,C1_4,L1_4,S1_4,L1_4
.byte L1_2,F1_2

.byte L3_4,S1_4
.byte L3_8,F1_8,L1_4,S1_8,L1_8
.byte S1_4,L1_2,C1_4
.byte L1_4,L1_8,C1_8,OT3,DH1_2

.byte OT2,X1_2,L1_4,S1_4
.byte L1_2,OT3,D1_4,OT2,C1_4,OT3,D1_4
.byte OT2,C1_4,L1_4,S1_4,L1_4
.byte L1_2,F1_2

.byte F1_4,L1_4,C1_4,S1_4
.byte F1_4,F1_4,L1_4,S1_4
.byte F1_4,L1_4,S1_4,L1_4
.byte L1_4,L1_8,S1_8,FH1_4,X1_4

.byte L1_2,L1_4,L1_4
.byte L1_2,L1_4,S1_4
.byte L1_2,L1_4,SH1_4
.byte L1_2,L1_4,X1_4

.byte L1_2,L1_4,L1_4
.byte L1_2,L1_4,S1_4
.byte L1_2,S1_4,L1_8,S1_8
.byte L1_2,L1_4,X1_4

.byte L1_2,L1_4,L1_4
.byte L1_2,L1_4,S1_4
.byte L1_2,L1_4,SH1_4
.byte L1_2,L1_4,X1_4

.byte L1_2,L1_4,L1_4
.byte L1_2,L1_4,S1_4
.byte L1_2,S1_4,L1_8,S1_8
.byte FH1_2,X1_2

.byte REPEAT
.word FF9_TRI_R0



; ==================================================
; TEST E - Final Fantasy IX : The place i'll return to someday (ver 2)
FF92_BGM:
.word FF92_CH1
.word FF92_CH2
;.byte $FF,$FF
;.byte $FF,$FF
.word FF92_TRI

FF92_CH1:
.byte SET_P3
.byte D12ICV15
.word VPBD43		;.word VPBD37
.word APBEC7
.byte VOL15
.byte TEMPO,$4B

FF92_CH1_S:
.byte $FA					; Repeat 4
FF92_CH1_R1:
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte $FC
.word FF92_CH1_R1

.byte OT2,R1_32,X3_32,R1_8,R1_8,M1_8,F1_4,S1_4
.byte X1_4,L3_32,X1_32,L3_32,X1_32,L1_4,C1_8,OT3,D1_32,X3_32
.byte OT2,C3_32,X1_32,C3_32,X1_32,L3_32,X1_32,L3_32,X1_32,S3_8,L1_8
.byte F3_32,X1_32,F3_32,X1_32,M3_32,X1_32,M3_32,X1_32,R3_32,X1_32,R3_32,X1_32,D3_32,X1_32,D3_32,X1_32

.byte OT2,R1_32,X3_32,R1_8,R1_8,M1_8,F1_4,S1_4
.byte X1_4,L3_32,X1_32,L3_32,X1_32,L1_4,C1_8,OT3,D1_32,X3_32
.byte OT2,C3_32,X1_32,C3_32,X1_32,L3_32,X1_32,L3_32,X1_32,L1_4,SH1_4
.byte L3_32,X1_32,L3_32,X1_32,SH3_32,X1_32,SH3_32,X1_32,L3_32,X1_32,L3_32,X1_32,SH3_32,X1_32,SH3_32,X1_32

.byte R1_32,X3_32,R1_8,R1_8,M1_8,F1_4,S1_4
.byte X1_4,L3_32,X1_32,L3_32,X1_32,L1_4,C1_8,OT3,D1_32,X3_32
.byte OT2,C3_32,X1_32,C3_32,X1_32,L3_32,X1_32,L3_32,X1_32,S3_8,L1_8
.byte F3_32,X1_32,F3_32,X1_32,M3_32,X1_32,M3_32,X1_32,R3_32,X1_32,R3_32,X1_32,D3_32,X1_32,D3_32,X1_32

.byte F3_32,X1_32,F3_16,F1_16,F3_32,X1_32,S1_8,F1_8,M1_8,R1_8
.byte D1_32,X3_32,D1_32,X1_32,D1_32,X1_32,L1_8,L1_8,M3_8,S1_8
.byte F3_32,X1_32,F3_32,X1_32,M3_32,X1_32,M3_32,X1_32,M3_32,X1_32,M3_32,X1_32,M3_32,X1_32,M3_32,X1_32
.byte R1_2,X1_32,R3_32,X1_8,X1_4
;
.byte OT4,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,R1_32,X3_32,R1_32,X3_32,OT3,L3_32,X1_32,L3_32,X1_32,OT4,R3_32,X1_32,R3_32,X1_32
.byte X1_8,D3_32,X1_32,D3_32,X1_32,OT3,C1_8,L3_32,X1_32,L3_32,X1_32,S1_8,X1_8
.byte L3_32,X1_32,L3_32,X1_32,F1_8,S1_8,L3_32,X1_32,L3_32,X1_32,C3_32,X1_32,C3_32,X1_32
.byte OT4,D1_16,X1_16,D1_16,X1_16,D1_16,X1_16,D1_16,X1_16,D1_4,X1_4

.byte R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,R1_32,X3_32,R1_32,X3_32,OT3,L3_32,X1_32,L3_32,X1_32,OT4,R3_32,X1_32,R3_32,X1_32
.byte X1_8,D3_32,X1_32,D3_32,X1_32,OT3,C1_8,L3_32,X1_32,L3_32,X1_32,S1_8,X1_8
.byte F3_32,X1_32,F3_32,X1_32,L3_32,X1_32,L3_32,X1_32,M3_32,X1_32,M3_32,X1_32,R1_8,DH1_8
.byte R3_4,X1_4

.byte OT4,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,R1_32,X3_32,R1_32,X3_32,OT3,L3_32,X1_32,L3_32,X1_32,OT4,R3_32,X1_32,R3_32,X1_32
.byte X1_8,D3_32,X1_32,D3_32,X1_32,OT3,C1_8,L3_32,X1_32,L3_32,X1_32,S1_8,X1_8
.byte L3_32,X1_32,L3_32,X1_32,F1_8,S1_8,L3_32,X1_32,L3_32,X1_32,C3_32,X1_32,C3_32,X1_32
.byte OT4,D1_16,X1_16,D1_16,X1_16,D1_16,X1_16,D1_16,X1_16,D1_4,X1_4

.byte R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,R1_32,X3_32,R1_32,X3_32,OT3,L3_32,X1_32,L3_32,X1_32,OT4,R3_32,X1_32,R3_32,X1_32
.byte X1_8,D3_32,X1_32,D3_32,X1_32,OT3,C1_8,L3_32,X1_32,L3_32,X1_32,S1_8,X1_8
.byte F3_32,X1_32,F3_32,X1_32,L3_32,X1_32,L3_32,X1_32,M3_32,X1_32,M3_32,X1_32,R1_8,DH1_8
.byte R3_4,X1_4
;
.byte F3_32,X1_32,F3_32,X1_32,L3_32,X1_32,L3_32,X1_32,M3_32,X1_32,M3_32,X1_32,R1_8,DH1_8
.byte R3_4,X1_4

.byte F3_32,X1_32,F3_32,X1_32,L3_32,X1_32,L1_8,L1_2
.byte L1_16,X3_16,L1_16,X3_16,M3_32,X1_32,M3_32,X1_32,R1_8,DH1_8
.byte R3_4,X1_4

.byte REPEAT
.word FF92_CH1_S

FF92_CH2:
.byte SET_P3
.byte D12ICV15
.word VPBD43		;.word VPBD37
.word APBEC7
.byte VOL7
.byte TEMPO, $4B

FF92_CH2_S:
.byte X1,X1

.byte OT2,X1_2,R1_4,D1_4
.byte X1_8,D1_8,R1_8,M1_8,F1_4,R1_8,M1_8
.byte R1_4,D1_4,OT1,C1_4,OT2,R1_4
.byte R1_4,D1_4,OT1,L1_4,X1_4

.byte X1_2,D1_2
.byte R1_2,D1_4,R1_8,D1_8
.byte OT1,C1_4,OT2,D1_4,R1_4,M1_4
.byte D1_4,R1_4,M1_2

.byte X1_2,R1_4,D1_4
.byte X1_8,D1_8,R1_8,M1_8,F1_4,R1_8,M1_8
.byte R1_4,D1_4,OT1,C1_4,OT2,R1_4
.byte R1_4,D1_4,OT1,L1_4,X1_4

.byte L1_4,OT2,D1_4,R1_4,OT1,C1_4
.byte L1_4,L1_4,OT2,D1_4,OT1,C1_4
.byte L1_4,OT2,D1_2,DH1_4
.byte OT1,C1_4,L1_2,X1_4
;
.byte OT2,R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_2,M1_4
.byte D1_2,M1_4,X1_4

.byte R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_4,OT1,C1_2
.byte L1_2,L1_4,X1_4

.byte OT2,R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_2,M1_4
.byte D1_2,M1_4,X1_4

.byte R1_2,D1_4,R1_4
.byte D1_4,R1_2,OT1,C1_4
.byte OT2,D1_4,R1_4,OT1,C1_2
.byte L3_4,X1_4
;
.byte OT2,D1_4,R1_4,OT1,C1_2
.byte L3_4,X1_4

.byte OT2,D1_4,R3_4
.byte A1_2,OT1,C1_2
.byte L3_4,X1_4

.byte REPEAT
.word FF92_CH2_S

FF92_TRI:
.byte VOL7
.byte TEMPO, $4B
FF92_TRI_S:
.byte $FB					; Repeat - 5(14x5=70)
FF92_TRI_R0:
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte $FC
.word FF92_TRI_R0
.byte $F9					; Repeat - 3(73)
FF92_TRI_R1:
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte $FC
.word FF92_TRI_R1
.byte X1_2,X1					; 76
.byte $F8					; Repeat - 2(78)
FF92_TRI_R2:
.byte OT2,R1_32,X3_32,R1_32,X1_32,R1_32,X1_32,OT1,L3_32,X1_32,L3_32,X1_32
.byte $FC
.word FF92_TRI_R2
.byte REPEAT
.word FF92_TRI_S



; ==================================================
; Final Fantasy 2 Airship ORIGINAL
BGM_AIRSHIP:
.word BGM_AIRSHIP_CH0
.word BGM_AIRSHIP_CH1
;.byte $FF,$FF
.word BGM_AIRSHIP_TRI
BGM_AIRSHIP_CH0:
.byte SET_P3
.byte D14ICV00
;.word VPBD43
;.word VPBD04
.word VPBD43
;.word APBEC7
;.byte $FF,$FF
.word APBEC7
.byte VOL15
.byte TEMPO,$4B

;C->LH
BGM_AIRSHIP_CH0_R0:
.byte OT2,L1_2,OT3,D1_2
.byte OT2,LH1_2,L1_2
.byte OT3,R1_4,OT2,S1_2,L1_4
.byte S1_2,S1_8,C1_8,OT3,R1_8,F1_8

.byte M3_4,D1_8,R1_8
.byte M1_4,L1_2,S1_4
.byte F1
.byte X1_2,X1_8,R1_8,R1_8,M1_8

.byte F1_4,OT2,LH1_4,X1_8,OT3,D1_8,R1_4
.byte R1_2,OT2,LH1_4,OT3,R1_4
.byte D3_8,OT2,L1_8,L1_2
.byte X1_2,X1_8,OT3,R1_8,R1_8,M1_8

.byte F1_4,OT2,LH1_4,X1_8,OT3,D1_8,R1_4
.byte R1_2,M1_4,F1_4
.byte M1
.byte D1
.byte REPEAT
.word BGM_AIRSHIP_CH0_R0

BGM_AIRSHIP_CH1:
.byte SET_P3
.byte D18ICV00
;.word VPBD04		; short
;.word VPBD43
;.word VPBD43
;.word VPBE01
;.word VPBD6A
.word VPBD43
;.word APBEC7
;.word APBEC7
;.byte $FF,$FF
.word APBEC7
.byte VOL15
;.byte TEMPO,$4B
BGM_AIRSHIP_CH1_R0:
.byte OT1,L1_16,OT2,D1_16,R1_16,M1_16,F1_16,M1_16,R1_16,D1_16,OT1,S1_16,OT2,D1_16,R1_16,M1_16,S1_16,M1_16,R1_16,D1_16
.byte OT1,LH1_16,OT2,D1_16,R1_16,M1_16,F1_16,M1_16,R1_16,D1_16,OT1,L1_16,OT2,D1_16,R1_16,M1_16,F1_16,M1_16,R1_16,D1_16
.byte R1_2,D1_2
.byte OT1,C1_2,X1_2

.byte OT2,S1_8,M1_8,S1_8,M1_8,S1_8,M1_8,S1_8,M1_8
.byte S1_8,M1_8,S1_8,M1_8,S1_8,M1_8,S1_8,M1_8
.byte R1_8,OT1,L1_8,OT2,F1_8,OT1,L1_8,OT2,DH1_8,OT1,L1_8,OT2,F1_8,OT1,L1_8
.byte OT2,D1_8,OT1,L1_8,OT2,F1_8,OT1,L1_8,C1_8,L1_8,OT2,F1_8,OT1,L1_8

.byte OT2,F1_2,M1_2
.byte R1_2,F1_2
.byte M1_2,R1_2
.byte D1_2,M1_2

.byte R1_2,D1_2
.byte OT1,LH1_2,OT2,R1_2
.byte D1_4,DH1_4,R1_4,RH1_4
.byte M1_4,F1_4,FH1_4,S1_4

.byte REPEAT
.word BGM_AIRSHIP_CH1_R0

BGM_AIRSHIP_TRI:
;.byte SET_P3
;.byte $FF
;.byte $FF,$FF
;.word APBEE4
BGM_AIRSHIP_TRI_R0:
.if 0 ; octave is little high
.byte OT3,F1_16,X1_16,F1_16,X1_16,X1_8,F1_8,M1_16,X1_16,M1_16,X1_16,X1_8,M1_8
.byte R1_16,X1_16,R1_16,X1_16,X1_8,R1_8,D1_16,X1_16,D1_16,X1_16,X1_8,D1_8
.byte OT2,C1_8,OT3,S1_8,OT2,C1_8,OT3,S1_8,D1_8,S1_8,D1_8,S1_8
.byte DH1_8,S1_8,DH1_8,S1_8,R1_8,S1_8,R1_8,S1_8

.byte D1_8,S1_8,D1_8,S1_8,D1_8,S1_8,D1_8,S1_8
.byte DH1_8,L1_8,DH1_8,L1_8,DH1_8,L1_8,DH1_8,L1_8
.byte R1_16,X1_16,R1_16,X1_16,X1_8,R1_16,X1_16,DH1_16,X1_16,DH1_16,X1_16,X1_8,DH1_16,X1_16
.byte D1_16,X1_16,D1_16,X1_16,X1_8,D1_16,X1_16,OT2,C1_16,X1_16,C1_16,X1_16,X1_8,C1_16,X1_16

.byte LH1_8,OT3,LH1_8,OT2,LH1_8,OT3,LH1_8,OT2,LH1_8,OT3,LH1_8,OT2,LH1_8,OT3,LH1_8
.byte OT2,LH1_8,OT3,LH1_8,OT2,LH1_8,OT3,LH1_8,OT2,LH1_8,OT3,LH1_8,OT2,LH1_8,OT3,LH1_8
.byte OT2,L1_8,OT3,L1_8,OT2,L1_8,OT3,L1_8,OT2,L1_8,OT3,L1_8,OT2,L1_8,OT3,L1_8
.byte OT2,L1_8,OT3,L1_8,OT2,L1_8,OT3,L1_8,OT2,L1_8,OT3,L1_8,OT2,L1_8,OT3,L1_8

.byte OT2,S1_8,OT3,S1_8,OT2,S1_8,OT3,S1_8,OT2,S1_8,OT3,S1_8,OT2,S1_8,OT3,S1_8
.byte OT2,S1_8,OT3,S1_8,OT2,S1_8,OT3,S1_8,OT2,S1_8,OT3,S1_8,OT2,S1_8,OT3,S1_8
.byte D1_8,S1_8,D1_8,S1_8,D1_8,S1_8,D1_8,S1_8
.byte D1_8,S1_8,D1_8,S1_8,D1_8,S1_8,D1_8,S1_8
.endif
.byte OT2,F1_16,X1_16,F1_16,X1_16,X1_8,F1_8,M1_16,X1_16,M1_16,X1_16,X1_8,M1_8
.byte R1_16,X1_16,R1_16,X1_16,X1_8,R1_8,D1_16,X1_16,D1_16,X1_16,X1_8,D1_8
.byte OT1,C1_8,OT2,S1_8,OT1,C1_8,OT2,S1_8,D1_8,S1_8,D1_8,S1_8
.byte DH1_8,S1_8,DH1_8,S1_8,R1_8,S1_8,R1_8,S1_8

.byte D1_8,S1_8,D1_8,S1_8,D1_8,S1_8,D1_8,S1_8
.byte DH1_8,L1_8,DH1_8,L1_8,DH1_8,L1_8,DH1_8,L1_8
.byte R1_16,X1_16,R1_16,X1_16,X1_8,R1_16,X1_16,DH1_16,X1_16,DH1_16,X1_16,X1_8,DH1_16,X1_16
.byte D1_16,X1_16,D1_16,X1_16,X1_8,D1_16,X1_16,OT1,C1_16,X1_16,C1_16,X1_16,X1_8,C1_16,X1_16

.byte LH1_8,OT2,LH1_8,OT1,LH1_8,OT2,LH1_8,OT1,LH1_8,OT2,LH1_8,OT1,LH1_8,OT2,LH1_8
.byte OT1,LH1_8,OT2,LH1_8,OT1,LH1_8,OT2,LH1_8,OT1,LH1_8,OT2,LH1_8,OT1,LH1_8,OT2,LH1_8
.byte OT1,L1_8,OT2,L1_8,OT1,L1_8,OT2,L1_8,OT1,L1_8,OT2,L1_8,OT1,L1_8,OT2,L1_8
.byte OT1,L1_8,OT2,L1_8,OT1,L1_8,OT2,L1_8,OT1,L1_8,OT2,L1_8,OT1,L1_8,OT2,L1_8

.byte OT1,S1_8,OT2,S1_8,OT1,S1_8,OT2,S1_8,OT1,S1_8,OT2,S1_8,OT1,S1_8,OT2,S1_8
.byte OT1,S1_8,OT2,S1_8,OT1,S1_8,OT2,S1_8,OT1,S1_8,OT2,S1_8,OT1,S1_8,OT2,S1_8
.byte D1_8,S1_8,D1_8,S1_8,D1_8,S1_8,D1_8,S1_8
.byte D1_8,S1_8,D1_8,S1_8,D1_8,S1_8,D1_8,S1_8

.byte REPEAT
.word BGM_AIRSHIP_TRI_R0





.if 0
;==================================================
; Final Fantasy 2 Main thema(Field) ORIGINAL
;
BGM_FIELD:
.word S9FFB_CH0					; 9FF2	$F8 $9F
.word SA04B_CH1					; 9FF4	$4B $A0
.word SA056_TRI					; 9FF6	$56 $A0

S9FFB_CH0:
.byte SET_P3
.byte D12ICV00
.word VPBD43
.word APBEC7
BGM9FF2_CH0_R0:
.byte TEMPO,$34
.byte OT1,L1_24,C1_24,OT2,D1_24,R1_32,M1_32,FH1_32,SH1_32		; 1/4
BGM9FF2_CH0_R1:
.byte BACK_2					; Repeat - 2
BGM9FF2_CH0_R2:
.byte OT2,L3_4					; 3/4
.byte OT3,M1_4,OT2,C3_4
.byte M1_4,OT3,D1_4,OT2,C1_4,L1_4
.byte C1_4,S1_2,M1_2				; 1 + 1/4	= 4 + 1/4
.byte JUMP_Z					; A019	Repeat
.word BGM9FF2_CH0_R3				; A01A	$2E $A0
.byte F1_2,A1_8,F1_8				; 3/4		= 5
.byte L1_8,OT3,D1_8,M1_4,R1_4,S1_4
.byte F1_4,RH3_4
.byte OT2,C1_4,OT3,M1				; 1 + 1/4	= 8 + 1/4
.byte BACK_N					; A02B	Repeat
.word BGM9FF2_CH0_R2
BGM9FF2_CH0_R3:
.byte OT2,F1_2,A1_8,F1_8,S1_8,L1_8
.byte OT3,D1_4,OT2,LH1_4,L1_4,SH1_4
.byte L3_8,C1_8,OT3,D3_8,R1_8
.byte M3_4,OT1,C1_24,OT2,D1_24,R1_24,M1_24,FH1_24,SH1_24		; = total = 12 + 1/4
.byte REPEAT
.word BGM9FF2_CH0_R1

SA04B_CH1:
.byte SET_P3
.byte D12ICV00
.word VPBD43
.word APBEE0
.byte VOL9
.byte X1_8
.byte REPEAT
.word BGM9FF2_CH0_R0

SA056_TRI:
;$A056
.byte SET_P3
.byte $FF
.byte $FF,$FF
.word APBEE4
.byte X1_4
BGM9FF2_TRI_R0:
.byte BACK_2					; repeat - 2
BGM9FF2_TRI_R1:
.byte OT2,L1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16,OT2,L1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16
.byte OT2,S1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16,OT2,S1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16
.byte OT2,F1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16,OT2,F1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16
.byte OT2,M1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16,OT2,M1_16,X1_16,OT3,DH1_16,X1_16,R1_16,X1_16,DH1_16,X1_16
.byte JUMP_Z					; repeat
.word BGM9FF2_TRI_R2
.byte OT2,R1_16,X1_16,C1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16,OT2,D1_16,X1_16,L1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16
.byte OT1,C1_16,X1_16,OT2,C1_16,X1_16,OT3,R1_16,X1_16,F1_16,X1_16,OT1,LH1_16,X1_16,OT3,D1_16,X1_16,R1_16,X1_16,F1_16,X1_16
.byte OT2,RH1_16,X1_16,L1_16,X1_16,LH1_16,X1_16,OT3,RH1_16,X1_16,OT1,C1_16,X1_16,OT2,FH1_16,X1_16,C1_16,X1_16,OT3,RH1_16,X1_16
.byte OT2,M1_16,X1_16,L1_16,X1_16,C1_16,X1_16,OT3,M1_16,X1_16,R1_16,X1_16,OT2,C1_16,X1_16,SH1_16,X1_16,M1_16,X1_16
.byte BACK_N					; repeat
.word BGM9FF2_TRI_R1
BGM9FF2_TRI_R2:
.byte OT2,R1_16,X1_16,C1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16,OT2,D1_16,X1_16,L1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16
.byte OT1,LH1_16,X1_16,OT2,L1_16,X1_16,OT3,R1_16,X1_16,F1_16,X1_16,OT1,C1_16,X1_16,OT2,L1_16,X1_16,C1_16,X1_16,OT3,M1_16,X1_16
.byte TEMPO,$33
.byte OT2,L1_16,X1_16,C1_16,X1_16
.byte TEMPO,$32
.byte OT3,M1_16,X1_16,F1_16,X1_16
.byte TEMPO,$31
.byte OT2
.byte F1_16,X1_16,L1_16,X1_16
.byte TEMPO,$30
.byte C1_16,X1_16,OT3,F1_16,X1_16		; 1
.byte TEMPO,$2F
.byte OT2,M1_16,X1_16
.byte TEMPO,$2E
.byte L1_16,X1_16
.byte TEMPO,$2C
.byte C1_16,X1_16
.byte TEMPO,$28
.byte OT3,R1_16,X1_16				; 1/2
.byte TEMPO,$23
.byte M1_4
.byte TEMPO,$34
.byte M1_16,X1_16,R1_16,X1_16,A1_8,X1_8					; 2/2
.byte REPEAT
.word BGM9FF2_TRI_R0
.endif

.if 0
;==================================================
; Final Fantasy 2 Main thema(Field) EXTEND ONLY
;
BGM_FIELD:
;.word S9FFB_CH0					; 9FF2	$F8 $9F
;.word SA04B_CH1					; 9FF4	$4B $A0
.byte $FF,$FF
.byte $FF,$FF
.word SA056_TRI					; 9FF6	$56 $A0

S9FFB_CH0:
.byte SET_P3
.byte D12ICV00
.word VPBD43
.word APBEC7

;temp extended part
TEMP_R0:
.byte TEMPO,$34
.byte OT3,M3_4,OT2,R1_4					; 1
.byte S3_4,S1_16,SH1_16,LH1_16,OT3,D1_16
.byte OT2,S3_4,S1_16,SH1_16,LH1_16,OT3,D1_16
.byte R1_4,D1_4,R1_4,RH1_4
.byte OT2,LH3_8,LH1_24,L1_24,SH1_24,S1_2		; 5
.byte SH1_2,SH1_8,SH1_8,OT3,D1_8,RH1_8
.byte S1_4,F1_4,LH1_4,SH1_4
.byte FH3_4,R1_4
.byte S3_4,F1_24,RH1_24,R1_24,D1_24,OT2,LH1_24,SH1_24		; 9
.byte S3_4,S1_16,SH1_16,LH1_16,OT3,D1_16
.byte OT2,S3_4,S1_16,SH1_16,LH1_16,OT3,D1_16
.byte R1_4,D1_4,R1_4,RH1_4
.byte OT2,LH3_8,LH1_24,L1_24,SH1_24,S1_2		; 13
.byte SH1_2,SH1_8,SH1_8,OT3,D1_8,RH1_8
.byte RH1_4,DH1_4,D1_4,OT2,C1_4
.byte OT3,D3_8,R1_8,RH3_8,F1_8
.byte S1						; 17
.byte REPEAT
.word TEMP_R0
;

BGM9FF2_CH0_R0:
.byte TEMPO,$34
FF2_MAIN_CH0_NEW:
.byte OT1,L1_24,C1_24,OT2,D1_24,R1_32,M1_32,FH1_32,SH1_32		; 1/4
BGM9FF2_CH0_R1:
.byte BACK_2					; Repeat - 2
BGM9FF2_CH0_R2:
.byte OT2,L3_4					; 3/4
.byte OT3,M1_4,OT2,C3_4
.byte M1_4,OT3,D1_4,OT2,C1_4,L1_4
.byte C1_4,S1_2,M1_2				; 1 + 1/4	= 4 + 1/4
.byte JUMP_Z					; A019	Repeat
.word BGM9FF2_CH0_R3				; A01A	$2E $A0
.byte F1_2,A1_8,F1_8				; 3/4		= 5
.byte L1_8,OT3,D1_8,M1_4,R1_4,S1_4
.byte F1_4,RH3_4
.byte OT2,C1_4,OT3,M1				; 1 + 1/4	= 8 + 1/4
.byte BACK_N					; A02B	Repeat
.word BGM9FF2_CH0_R2
BGM9FF2_CH0_R3:
.byte OT2,F1_2,A1_8,F1_8,S1_8,L1_8
.byte OT3,D1_4,OT2,LH1_4,L1_4,SH1_4
.byte L3_8,C1_8,OT3,D3_8,R1_8
.byte M3_4					; 3/4
;OT1,C1_24,OT2,D1_24,R1_24,M1_24,FH1_24,SH1_24		; = total = 12 + 1/4 , commented

.byte REPEAT
.word BGM9FF2_CH0_R1

SA04B_CH1:
.byte SET_P3
.byte D12ICV00
.word VPBD43
.word APBEE0
.byte VOL9
.byte X1_8

;temp extended part
.byte REPEAT
.word TEMP_R0
;

.byte REPEAT
.word BGM9FF2_CH0_R0

SA056_TRI:
;$A056
.byte SET_P3
.byte $FF
.byte $FF,$FF
.word APBEE4
.byte TEMPO,$34					; temp variable
.byte VOL15					; temp variable
;.byte X1_4					; temp comment

;temp ;M->RH,C->LH,L->SH
TEMP_TRI_R0:
.byte OT2,M1_16,X1_16,L1_16,X1_16,C1_16,X1_16,OT3,R1_16,X1_16
.byte OT2,C1_16,X1_16,SH1_16,X1_16,M1_16,X1_16,R1_16,X1_16		; 1
.byte D1_8,S1_8,OT3,R1_16,RH1_16,D1_8,S1_8,OT2,SH1_16,LH1_16,OT3,RH1_8,S1_8
.byte OT1,LH1_8,OT2,LH1_8,OT3,F1_16,S1_16,OT2,LH1_8,OT3,R1_8,OT2,SH1_16,LH1_16,OT3,R1_8,F1_8		; 3
.byte OT2,SH1_8,OT3,RH1_8,S1_16,SH1_16,RH1_8,OT4,D1_8,OT3,LH1_8,SH1_8,RH1_8
.byte OT2,S1_8,OT3,R1_8,F1_16,S1_16,R1_8,LH1_8,R1_8,S1_8,LH1_8
.byte OT2,F1_8,OT3,D1_8,F1_8,S1_8,OT2,RH1_8,OT3,D1_8,F1_8,SH1_8
.byte OT2,R1_8,OT3,R1_8,F1_8,SH1_8,OT2,DH1_8,OT3,RH1_8,F1_8,SH1_8					; 7
.byte OT2,FH1_8,OT3,D1_8,DH1_8,FH1_8,OT2,R1_8,L1_8,OT3,R1_8,F1_8
.byte OT2,S1_8,OT3,R1_8,S1_8,OT4,R1_8,D1_8,OT3,C1_16,OT4,D1_16,OT3,S1_8,R1_8
.byte OT2,D1_8,S1_8,OT3,R1_16,RH1_16,D1_8,S1_8,OT2,SH1_16,LH1_16,OT3,RH1_8,S1_8				; 10
.byte OT1,LH1_8,OT2,LH1_8,OT3,F1_16,S1_16,OT2,LH1_8,OT3,R1_8,OT2,SH1_16,LH1_16,OT3,R1_8,F1_8
.byte OT2,SH1_8,OT3,RH1_8,S1_16,SH1_16,RH1_8,OT4,D1_8,OT3,LH1_8,SH1_8,RH1_8
.byte OT2,S1_8,OT3,R1_8,F1_16,S1_16,R1_8,LH1_8,R1_8,S1_8,LH1_8						; 13
.byte OT2,F1_8,OT3,D1_8,F1_8,S1_8,OT2,RH1_8,OT3,D1_8,F1_8,SH1_8
.byte OT2,R1_8,OT3,R1_8,F1_8,SH1_8,OT2,DH1_8,OT3,RH1_8,F1_8,SH1_8
.byte OT2,D1_8,OT3,D1_8,RH1_8,S1_8,OT2,SH1_8,OT3,RH1_8,SH1_8,OT4,D1_8					; 16
.byte OT2,S1_8,OT3,R1_8,OT4,D1_8,R1_8,OT3,S1_2								; 17
;(S1_2),R1_2,OT2,S1_2;removed for that cannot be played simultaneously
.byte REPEAT
.word TEMP_TRI_R0
;


BGM9FF2_TRI_R0:
.byte BACK_2					; repeat - 2
BGM9FF2_TRI_R1:
.byte OT2,L1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16,OT2,L1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16
.byte OT2,S1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16,OT2,S1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16
.byte OT2,F1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16,OT2,F1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16
.byte OT2,M1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16,OT2,M1_16,X1_16,OT3,DH1_16,X1_16,R1_16,X1_16,DH1_16,X1_16
.byte JUMP_Z					; repeat
.word BGM9FF2_TRI_R2
.byte OT2,R1_16,X1_16,C1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16,OT2,D1_16,X1_16,L1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16
.byte OT1,C1_16,X1_16,OT2,C1_16,X1_16,OT3,R1_16,X1_16,F1_16,X1_16,OT1,LH1_16,X1_16,OT3,D1_16,X1_16,R1_16,X1_16,F1_16,X1_16
.byte OT2,RH1_16,X1_16,L1_16,X1_16,LH1_16,X1_16,OT3,RH1_16,X1_16,OT1,C1_16,X1_16,OT2,FH1_16,X1_16,C1_16,X1_16,OT3,RH1_16,X1_16
.byte OT2,M1_16,X1_16,L1_16,X1_16,C1_16,X1_16,OT3,M1_16,X1_16,R1_16,X1_16,OT2,C1_16,X1_16,SH1_16,X1_16,M1_16,X1_16
.byte BACK_N					; repeat
.word BGM9FF2_TRI_R1
BGM9FF2_TRI_R2:
.byte OT2,R1_16,X1_16,C1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16,OT2,D1_16,X1_16,L1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16
.byte OT1,LH1_16,X1_16,OT2,L1_16,X1_16,OT3,R1_16,X1_16,F1_16,X1_16,OT1,C1_16,X1_16,OT2,L1_16,X1_16,C1_16,X1_16,OT3,M1_16,X1_16
.byte TEMPO,$33
.byte OT2,L1_16,X1_16,C1_16,X1_16
.byte TEMPO,$32
.byte OT3,M1_16,X1_16,F1_16,X1_16
.byte TEMPO,$31
.byte OT2
.byte F1_16,X1_16,L1_16,X1_16
.byte TEMPO,$30
.byte C1_16,X1_16,OT3,F1_16,X1_16		; 1
.byte TEMPO,$2F
.byte OT2,M1_16,X1_16
.byte TEMPO,$2E
.byte L1_16,X1_16
.byte TEMPO,$2C
.byte C1_16,X1_16
.byte TEMPO,$28
.byte OT3,R1_16,X1_16				; 1/2
.byte TEMPO,$23
;.byte M1_4				commented
.byte OT2,C1_16,X1_16,SH1_16,X1_16		; added
.byte TEMPO,$34
.byte M1_16,X1_16,R1_16,X1_16
;.byte A1_8,X1_8					; 2/2	commented

.byte REPEAT
.word BGM9FF2_TRI_R0
.endif





;==================================================
; Final Fantasy 2 Main thema(Field) SR
;
BGM_FIELD:
.word BGM_FIELD_CH0
.word BGM_FIELD_CH1
.word BGM_FIELD_TRI

BGM_FIELD_CH0:
.byte SET_P3
.byte D12ICV00
.word VPBD43
.word APBEC7
BGM_FIELD_CH0_R0:
.byte TEMPO,$34
FF2_FIELD_CH0_NEW:
.byte OT1,L1_24,C1_24,OT2,D1_24,R1_32,M1_32,FH1_32,SH1_32		; 1/4
.byte BACK_2					; Repeat - 2
BGM_FIELD_CH0_R2:
.byte OT2,L3_4					; 3/4
.byte OT3,M1_4,OT2,C3_4
.byte M1_4,OT3,D1_4,OT2,C1_4,L1_4
.byte C1_4,S1_2,M1_2				; 1 + 1/4	= 4 + 1/4
.byte JUMP_Z					; Repeat
.word BGM_FIELD_CH0_R3
.byte F1_2,A1_8,F1_8				; 3/4		= 5
.byte L1_8,OT3,D1_8,M1_4,R1_4,S1_4
.byte F1_4,RH3_4
.byte OT2,C1_4,OT3,M1				; 1 + 1/4	= 8 + 1/4
.byte BACK_N					; Repeat
.word BGM_FIELD_CH0_R2
BGM_FIELD_CH0_R3:
.byte OT2,F1_2,A1_8,F1_8,S1_8,L1_8
.byte OT3,D1_4,OT2,LH1_4,L1_4,SH1_4
.byte L3_8,C1_8,OT3,D3_8,R1_8
.byte M3_4					; 3/4
.byte OT2,R1_4					; 1 -> 1/4
.byte BACK_2					; Repeat - 2
FF2_FIELD_CH0_NEW_R0:
.byte S3_4,S1_16,SH1_16,LH1_16,OT3,D1_16
.byte OT2,S3_4,S1_16,SH1_16,LH1_16,OT3,D1_16
.byte R1_4,D1_4,R1_4,RH1_4
.byte OT2,LH3_8,LH1_24,L1_24,SH1_24,S1_2		; 5
.byte SH1_2,SH1_8,SH1_8,OT3,D1_8,RH1_8
.byte JUMP_Z
.word FF2_FIELD_CH0_NEW_R1
.byte S1_4,F1_4,LH1_4,SH1_4
.byte FH3_4,R1_4
.byte S3_4,F1_24,RH1_24,R1_24,D1_24,OT2,LH1_24,SH1_24		; 9
.byte BACK_N					; Repeat
.word FF2_FIELD_CH0_NEW_R0
FF2_FIELD_CH0_NEW_R1:
.byte RH1_4,DH1_4,D1_4,OT2,C1_4
.byte OT3,D3_8,R1_8,RH3_8,F1_8
.byte S3_4						; total minus is 3/4 + 1/4
.byte REPEAT
.word FF2_FIELD_CH0_NEW

BGM_FIELD_CH1:
.byte SET_P3
.byte D12ICV00
.word VPBD43
.word APBEE0
.byte VOL9
.byte X1_8
.byte REPEAT
.word BGM_FIELD_CH0_R0

BGM_FIELD_TRI:
.byte SET_P3
.byte $FF
.byte $FF,$FF
.word APBEE4
.byte X1_4					; temp comment
BGM_FIELD_TRI_R0:
.byte BACK_2					; repeat - 2
BGM_FIELD_TRI_R1:
.byte OT2,L1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16,OT2,L1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16
.byte OT2,S1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16,OT2,S1_16,X1_16,OT3,M1_16,X1_16,F1_16,X1_16,M1_16,X1_16
.byte OT2,F1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16,OT2,F1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16
.byte OT2,M1_16,X1_16,OT3,R1_16,X1_16,M1_16,X1_16,R1_16,X1_16,OT2,M1_16,X1_16,OT3,DH1_16,X1_16,R1_16,X1_16,DH1_16,X1_16
.byte JUMP_Z					; repeat
.word BGM_FIELD_TRI_R2
.byte OT2,R1_16,X1_16,C1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16,OT2,D1_16,X1_16,L1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16
.byte OT1,C1_16,X1_16,OT2,C1_16,X1_16,OT3,R1_16,X1_16,F1_16,X1_16,OT1,LH1_16,X1_16,OT3,D1_16,X1_16,R1_16,X1_16,F1_16,X1_16
.byte OT2,RH1_16,X1_16,L1_16,X1_16,LH1_16,X1_16,OT3,RH1_16,X1_16,OT1,C1_16,X1_16,OT2,FH1_16,X1_16,C1_16,X1_16,OT3,RH1_16,X1_16
.byte OT2,M1_16,X1_16,L1_16,X1_16,C1_16,X1_16,OT3,M1_16,X1_16,R1_16,X1_16,OT2,C1_16,X1_16,SH1_16,X1_16,M1_16,X1_16
.byte BACK_N					; repeat
.word BGM_FIELD_TRI_R1
BGM_FIELD_TRI_R2:
.byte OT2,R1_16,X1_16,C1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16,OT2,D1_16,X1_16,L1_16,X1_16,OT3,D1_16,X1_16,M1_16,X1_16
.byte OT1,LH1_16,X1_16,OT2,L1_16,X1_16,OT3,R1_16,X1_16,F1_16,X1_16,OT1,C1_16,X1_16,OT2,L1_16,X1_16,C1_16,X1_16,OT3,M1_16,X1_16
.byte TEMPO,$33
.byte OT2,L1_16,X1_16,C1_16,X1_16
.byte TEMPO,$32
.byte OT3,M1_16,X1_16,F1_16,X1_16
.byte TEMPO,$31
.byte OT2
.byte F1_16,X1_16,L1_16,X1_16
.byte TEMPO,$30
.byte C1_16,X1_16,OT3,F1_16,X1_16		; 1
.byte TEMPO,$2F
.byte OT2,M1_16,X1_16
.byte TEMPO,$2E
.byte L1_16,X1_16
.byte TEMPO,$2C
.byte C1_16,X1_16
.byte TEMPO,$28
.byte OT3,R1_16,X1_16				; 1/2
.byte TEMPO,$23
.byte OT2,C1_16,X1_16,SH1_16,X1_16		; added
.byte M1_16,X1_16,R1_16,X1_16
.byte TEMPO,$34
.byte BACK_2					; Repeat - 2
BGM_FIELD_TRI_NEW_R0:
.byte D1_8,S1_8,OT3,R1_16,RH1_16,D1_8,S1_8,OT2,SH1_16,LH1_16,OT3,RH1_8,S1_8
.byte OT1,LH1_8,OT2,LH1_8,OT3,F1_16,S1_16,OT2,LH1_8,OT3,R1_8,OT2,SH1_16,LH1_16,OT3,R1_8,F1_8		; 3
.byte OT2,SH1_8,OT3,RH1_8,S1_16,SH1_16,RH1_8,OT4,D1_8,OT3,LH1_8,SH1_8,RH1_8
.byte OT2,S1_8,OT3,R1_8,F1_16,S1_16,R1_8,LH1_8,R1_8,S1_8,LH1_8
.byte OT2,F1_8,OT3,D1_8,F1_8,S1_8,OT2,RH1_8,OT3,D1_8,F1_8,SH1_8
.byte OT2,R1_8,OT3,R1_8,F1_8,SH1_8,OT2,DH1_8,OT3,RH1_8,F1_8,SH1_8					; 7
.byte JUMP_Z					; Repeat if count is not exist
.word BGM_FIELD_TRI_NEW_R1
.byte OT2,FH1_8,OT3,D1_8,DH1_8,FH1_8,OT2,R1_8,L1_8,OT3,R1_8,F1_8
.byte OT2,S1_8,OT3,R1_8,S1_8,OT4,R1_8,D1_8,OT3,C1_16,OT4,D1_16,OT3,S1_8,R1_8
.byte BACK_N					; Repeat if count is exist
.word BGM_FIELD_TRI_NEW_R0
BGM_FIELD_TRI_NEW_R1:
.byte TEMPO,$33,OT2,D1_8,OT3,D1_8,TEMPO,$32,RH1_8,S1_8		; 16 added
.byte TEMPO,$31,OT2,SH1_8,OT3,RH1_8,TEMPO,$30,SH1_8,OT4,D1_8					; 16 added
.byte TEMPO,$2F,OT2,S1_8,TEMPO,$2E,OT3,R1_8		; added
.byte TEMPO,$2C,OT4,D1_8,TEMPO,$28,R1_8,OT3,TEMPO,$23,S1_4,TEMPO,$34,X1_4			; 17 added
.byte REPEAT
.word BGM_FIELD_TRI_R0



; ==================================================
; FF1L Main theme







.segment "DATA_SND"
;pitch table(timer) - 0-71
;$4002,$4006,$400A / $4003,$4007,$400B
;$4002 = TTTT TTTT
;$4003 = LLLL LTTT
D9C6D:
.byte $AB
D9C6E:
.byte $06
.byte $4D,$06
.byte $F3,$05
.byte $9D,$05
.byte $4C,$05
.byte $01,$05
.byte $B8,$04
.byte $74,$04
.byte $34,$04
.byte $F7,$03
.byte $BE,$03		; 10
.byte $88,$03
.byte $55,$03
.byte $26,$03
.byte $F9,$02
.byte $CE,$02
.byte $A6,$02
.byte $80,$02
.byte $5C,$02
.byte $3A,$02
.byte $19,$02		; 20
.byte $FB,$01
.byte $DE,$01
.byte $C4,$01
.byte $AA,$01
.byte $93,$01
.byte $7C,$01
.byte $67,$01
.byte $52,$01
.byte $3F,$01
.byte $2D,$01		; 30
.byte $1C,$01
.byte $0C,$01
.byte $FD,$00
.byte $EF,$00
.byte $E1,$00
.byte $D5,$00
.byte $C9,$00
.byte $BE,$00
.byte $B3,$00
.byte $A9,$00		; 40
.byte $9F,$00
.byte $96,$00
.byte $8E,$00
.byte $86,$00
.byte $7E,$00
.byte $77,$00
.byte $70,$00
.byte $6A,$00
.byte $64,$00
.byte $5E,$00		; 50
.byte $59,$00
.byte $54,$00
.byte $4F,$00
.byte $4B,$00
.byte $46,$00
.byte $42,$00
.byte $3E,$00
.byte $3B,$00
.byte $38,$00
.byte $34,$00		; 60
.byte $31,$00
.byte $2F,$00
.byte $2C,$00
.byte $29,$00
.byte $27,$00
.byte $25,$00
.byte $23,$00
.byte $21,$00
.byte $1F,$00
.byte $1D,$00		; 70
.byte $1B,$00		; 71

D9CFD:
;       0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F
.byte $60,$48,$30,$24,$20,$18,$12,$10,$0C,$09,$08,$06,$04,$03,$02,$01

; READ ADDR = $863B 256 bytes = volume/envelope table ??
D9D0D:
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01
.byte $00,$00,$00,$00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$01,$01,$02
.byte $00,$00,$00,$00,$00,$01,$01,$01,$01,$01,$02,$02,$02,$02,$02,$03
.byte $00,$00,$00,$00,$01,$01,$01,$01,$02,$02,$02,$02,$03,$03,$03,$04
.byte $00,$00,$00,$01,$01,$01,$02,$02,$02,$03,$03,$03,$04,$04,$04,$05
.byte $00,$00,$00,$01,$01,$02,$02,$02,$03,$03,$04,$04,$04,$05,$05,$06
.byte $00,$00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07
.byte $00,$00,$01,$01,$02,$02,$03,$03,$04,$04,$05,$05,$06,$06,$07,$08
.byte $00,$00,$01,$01,$02,$03,$03,$04,$04,$05,$06,$06,$07,$07,$08,$09
.byte $00,$00,$01,$02,$02,$03,$04,$04,$05,$06,$06,$07,$08,$08,$09,$0A
.byte $00,$00,$01,$02,$02,$03,$04,$05,$05,$06,$07,$08,$08,$09,$0A,$0B
.byte $00,$00,$01,$02,$03,$04,$04,$05,$06,$07,$08,$08,$09,$0A,$0B,$0C
.byte $00,$00,$01,$02,$03,$04,$05,$06,$06,$07,$08,$09,$0A,$0B,$0C,$0D
.byte $00,$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E
.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A,$0B,$0C,$0D,$0E,$0F

;; ========== pointers to song data (31 items) ($9E0D-$9E4A) START ==========
;; [$9E0D :: 0x35E0D]
;00 - Silence
Song_p_tbl_L:
.byte $4B
Song_p_tbl_H:
.byte $9E
;01 - title prelude
.byte $51,$9E
;02 - Suprise
;.byte $62,$9F
.word BGM_AIRSHIP
;03 - Chocobo
.word FF92_BGM
;.byte $87,$9F
;04 - Main thema
.word FF9_BGM
;.byte $F2,$9F
;05 - Main thema
;.word BGM_TEST
.word FF1_10_MATOYA
;.word FF1_09
;.word A1D2		; 9E19	$F2 $9F
;.word BGM_0009
;.word BGM_FF39
;.word BGM_CHOCOBO
;06 - Main thema
.word BGM_FIELD
;.word BGM_FF3_CHOCOBO
;07 - Victory
.byte $67,$A1
;08 - Item get
.byte $C4,$A1
;09 - Keyword get
.byte $0D,$A2
;10(0A) - Company joined
.byte $55,$A2
;11(0B) - Pandemonium
.byte $A0,$A2
;12(0C) - Catle
.byte $65,$A4
;13(0D) - Crystal tower
.byte $EB,$A5
;14(0E) - Airplane
.byte $BA,$A7
;15(0F) - Dungeon
.byte $9B,$A9
;16(10) - Town
.byte $0B,$AB
;17(11) - Rebel army
.byte $5A,$AC
;18(12) - Battle
.byte $5A,$AD
;19(13) - Final battle
.byte $30,$B0
;20(14) - Fall sound
.byte $10,$B5
;21(15) - Battle win
.byte $2A,$B5
;22(16) - Game over
.byte $4A,$B6
;23(17) - Lamia
.byte $D5,$B6
;24(18) - Survive
.byte $4D,$B7
;25(19) - First meet
.byte $85,$B7
;26(1A) - Escape
.byte $26,$B8
;27(1B) - Celebrate
.byte $A0,$B8
;28(1C) - Warning
.byte $80,$B9
;29(1D) - Ending
.byte $E1,$B9
;30(1E) - Laser
.byte $E2,$BC
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
; It cannot be placed at address 0xFFxx
; XXXX YYYY
; if XXXX = 0, YYYY != 0 move the point address back by YYYY
; if XXXX != 0, YYYY is low value(volume ??)
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
.byte $3A,$32,$3B,$34,$3C,$02
APBED6:
.byte $F0,$49,$41,$49,$32,$3A,$02
APBEDD:
.byte $49,$41,$02
APBEE0:
.byte $F9,$49,$41,$02
APBEE4:
.byte $49,$42,$4A,$42,$4A,$42,$4B,$44,$4C,$02
APBEEE:
.byte $F0,$49
.byte $42,$4A,$42,$4A,$42,$4B,$44,$4C,$02
APBEF9:
.byte $FA,$00,$11,$01,$13,$11,$01
;; ========== volume/pitch envelope data ($BD04-$BEFF) END ==========
APBF00:
.byte $F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$07
APBF09:
.byte $FF,$FF,$FF,$FF,$FF,$FF,$05

.if 0
[format]
script pointer 5ch (10 bytes)
00h-DFh : note
E0h b1 : tempo
E1h-EFh : vol
F0h-F4h : oct
F5h b1 b2 : set env 1/8(duty), b1 = volume envelope table number, b2 = pitch envelope table number
F6h b1 b2 : set env 1/4(duty), b1 = volume envelope table number, b2 = pitch envelope table number
F7h b1 b2 : set env 1/2(duty), b1 = volume envelope table number, b2 = pitch envelope table number
F8h b1 : sweep
F9h : hi-hat preset
FAh : snare drum preset
FBh b1 : repeat start
FCh : repeat end
FDh : volta repeat
FEh : jump
FFh : end of script

[register]
$D0 : channel number reverse(4->0)
$D1 : channel number(0->4)
;$D2 : sound effect ignore song volume ??
+$D3 : script pointer
+$D6 : volume envelope pointer
+$D8 : pitch envelope pointer
$7F42 : if 4 stop music(no fade out), if 1 play new song, if Ch fade out music, if 0h disable music, if 80h may be keep going on, if A0h fade in
$7F43 : play song id
$7F45 : tempo
+$7F46 : tempo count
$7F49 : sound effect no
$7F4A-$7F4E : channel disable()
$7F51-$7F55 : script pointer each channel(Low)
$7F58-$7F5C : script pointer each channel(High)
$7F5F-$7F63 : frame count
$7F66-$7F6A : channel octave(0-5)
$7F7B-$7F7F : volume
$7F97-$7F9B : decay counter
;$7F89-$7F8D : channel duty ??
$7F90-$7F94 : channel volume
;$7F9E-$7FA2 : ??
;$7FBA- : envelope state ??
$7FC1-$7FC5 : volume number
;$7FC8- : envelope data offset ??
$7FEB-$7FBF : pitch number
$7FE4-$7FE8 : volume envelope value
$7FF2-$7FF6 : pitch envelope data offset
$7FF9-$7FFD : pitch envelope counter


;$00-$18
A032	;32 A0 - $00 = sleeping
A07C	;7C A0 - $01 = prelude
A1D2	;D2 A1 - $02 = crystal dungeon
A444	;44 A4 - $03 = area wreck
A56A	;6A A5 - $04 = bards song
A685	;85 A6 - $05 = castle
A7F6	;F6 A7 - $06 = village of amur
A97C	;7C A9 - $07 = victory
AA81	;81 AA - $08 = chocobo
ABEF	;EF AB - $09 = light 4 warriors
AD36	;36 AD - $0A = airship(Go above the Clouds!)
AEB9	;B9 AE - $0B = village of minimun
B042	;42 B0 - $0C = mystery castle(sasun castle before, agas castle before)
B16C	;6C B1 - $0D = forest
B2B8	;B8 B2 - $0E = warning(area arow in water crystal dungeon)
B323	;23 B3 - $0F = dungeon of under water
B452	;52 B4 - $10 = village of ancient people
B58B	;8B B5 - $11 = village of gysahl
B6A8	;A8 B6 - $12 = town of dastar
B92A	;2A B9
BA6D	;6D BA
BC54	;54 BC
BE23	;23 BE
BF3D	;3D BF
BF81	;81 BF

----------
;A032 - $00
3C A0 5F A0 67 A0 FF FF FF FF 
F7 04 07 EC
E0 5A C5 F2 08 F1 A8 F2 38 18 F1 88 58 E0 56 48
E0 52 F2 08 E0 4E F1 78 E0 4A A8 E0 46 92 FF F7
04 09 E8 CB FE 40 A0 F1 18 88 F2 08 C8 F1 68 A8
F2 18 C8 F1 08 78 F2 08 C8 F1 52 FF

----------
;A07C - $01 - prelude
86 A0 CA A1 FF FF FF FF FF FF 
;A086 - CH0
F7 02 FF EB E0 51 F0 0B E0 53
2B E0 55 4B E0 57 7B E0 59 F1 0B E0 5B 2B E0 5D
4B E0 5F 7B F2 0B 2B 4B 7B F3 0B 2B 4B 7B FB 02
F4 0B F3 7B 4B 2B 0B F2 7B 4B 2B 0B F1 7B 4B 2B
0B F0 7B 4B 2B EF 9B BB F0 0B 4B 9B BB F1 0B 4B
9B BB F2 0B 4B 9B BB F3 0B 4B 9B 4B 0B F2 BB 9B
4B 0B F1 BB 9B 4B 0B F0 BB 9B 4B 0B EF BB FD 08
A1 F0 0B 2B 4B 7B F1 0B 2B 4B 7B F2 0B 2B 4B 7B

F3 0B 2B 4B 7B FC B0 A0 9B F0 0B 5B 7B 9B F1 0B
5B 7B 9B F2 0B 5B 7B 9B F3 0B 5B 7B 9B 7B 5B 0B
F2 9B 7B 5B 0B F1 9B 7B 5B 0B F0 9B 7B 5B 0B EF
BB F0 2B 7B 9B BB F1 2B 7B 9B BB F2 2B 7B 9B BB
F3 2B 7B 9B BB 9B 7B 2B F2 BB 9B 7B 2B F1 BB 9B
7B 2B F0 BB 9B 7B 2B EF 8B F0 0B 3B 7B 8B F1 0B
3B 7B 8B F2 0B 3B 7B 8B F3 0B 3B 7B 8B 7B 3B 0B
F2 8B 7B 3B 0B F1 8B 7B 3B 0B F0 8B 7B 3B 0B EF
AB F0 2B 5B 9B AB F1 2B 5B 9B AB F2 2B 5B 9B AB
F3 2B 5B 9B E0 5E AB E0 5D 9B E0 5C 5B E0 5B 2B
E0 5A F2 AB E0 59 9B E0 58 5B E0 57 2B E0 55 F1
AB E0 53 9B E0 51 5B E0 4F 2B E0 4C F0 AB E0 49
9B E0 46 5B E0 43 2B FE 8A A0 
;A1CA - CH1
F7 02 00 E5 CA FE
8A A0

----------
;A1D2 - $02
DC A1 24 A3 01 A4 FF FF FF FF 
F6 03 FF E0
5A E2 F0 AB F1 0B 2B 5B E3 2B 0B F0 AB F1 0B E4
2B 5B 2B 0B E5 F0 AB F1 0B 2B 5B E6 3B 5B 7B AB

E7 7B 5B 3B 5B E8 7B AB F2 0B 2B E9 3B 5B 7B AB
FB 02 EB FB 09 F1 7E F2 7E FC 15 A2 FB 03 F2 2E
F3 2E FC 1E A2 FB 06 F2 0E F3 0E FC 27 A2 FB 03
F1 AE F2 AE FC 30 A2 FB 03 F1 9E F2 9E FC 39 A2
FB 0A F1 7E F2 7E FC 42 A2 EA F1 7E F2 7E E9 F1
7E F2 7E E8 F1 7E F2 7E E7 F1 7E F2 7E E6 F1 7E
F2 7E E5 F1 7E F2 7E E4 F1 7E F2 7E E3 F1 7E F2
7E EC 7A 9A AA EB FB 0A 4E F3 4E F2 FC 78 A2 EA

4E F3 4E E9 F2 4E F3 4E E8 F2 4E F3 4E E7 F2 4E
F3 4E E6 F2 4E F3 4E E5 F2 4E F3 4E E4 F2 4E F3
4E E3 F2 4E F3 4E F2 EC 7A 9A AA EB FB 0A F2 3E
F3 3E FC AE A2 EA F2 3E F3 3E E9 F2 3E F3 3E E8
F2 3E F3 3E E7 F2 3E F3 3E E6 F2 3E F3 3E E5 F2
3E F3 3E E4 F2 3E F3 3E E3 F2 3E F3 3E C5 FC 12
A2 EB FB 02 F2 5E 8E F3 0E 5B D5 38 25 35 F2 2E
5E 8E F3 0B D8 D2 F2 A5 FD 0F A3 3E 5E 8E F3 0B
;$A300
D8 D2 35 F2 2E 5E AE F3 2B D8 D2 C5 FC E4 A2 F2
3E 5E 8E F3 0B D8 D2 75 F2 5E AE F3 2E 5B D8 D2
C5 FE 10 A2 F5 02 FF E1 F0 7B 9B AB F1 2B E2 F0
AB 9B 7B 9B E3 AB F1 2B F0 AB 9B E4 7B 9B AB F1
2B E5 F0 7B 9B AB F1 3B E6 F0 AB 9B 7B 9B E7 AB
F1 3B F0 AB 9B E8 7B 9B AB F1 3B E9 FB 02 FB 02
F0 7B 9B AB F1 2B F0 AB 9B FC 60 A3 7B 9B AB F1
2B FB 02 F0 7B 9B AB F1 3B F0 AB 9B FC 73 A3 7B

9B AB F1 3B FB 02 F0 7B 9B AB F1 4B F0 AB 9B FC
86 A3 7B 9B AB F1 4B FB 02 F0 7B 9B AB F1 3B F0
AB 9B FC 99 A3 7B 9B AB F1 3B FC 5E A3 FB 02 FB
02 F0 7B 8B F1 0B 3B 0B F0 8B FC B1 A3 7B 8B F1
0B 3B FB 02 F0 7B 8B F1 2B 5B 2B F0 8B FC C4 A3
7B 8B F1 2B 5B FB 02 F0 7B 8B F1 3B 7B 3B F0 8B
FC D7 A3 7B 8B F1 3B 7B FB 02 F0 7B 8B F1 2B 5B
2B F0 8B FC EA A3 7B 8B F1 2B 5B FC AF A3 FE 5C
;$A400
A3 C0 C0 FB 02 F1 23 DB CB 23 DB CB 33 DB CB 36
DD CD 3C CC 3C CC 3C CC 43 DB CB 46 DD CD 4C CC
4C CC 4C CC 33 DB CB 33 DB CB FC 05 A4 FB 02 F0
51 F1 05 F0 51 F1 25 F0 51 F1 35 F0 51 C5 FC 2F
A4 FE 03 A4

----------
;A444 - $03 - area wreck
4E A4 A6 A4 AE A4 FF FF FF FF 
;A44E - CH0
F7 04
01 EB FB 02 F2 45 B3 98 F3 25 F2 72 C6 CD CE 7F
58 48 58 F3 08 FD 74 A4 C6 CD CE F2 5F 48 28 48
B8 FC 54 A4 F3 05 F2 95 55 22 45 41 C2 C8 2E 4E

5E 7E 9E BE F3 05 03 08 F2 B5 B3 B8 B5 98 58 08
28 55 42 F3 05 03 28 45 43 78 95 95 98 78 92 98
78 91 D1 FE 52 A4 
;A4A6 - CH1
F7 04 02 E5 CC FE 52 A4 
;A4AE - TRI
F5 FF
03 F1 E0 50 FB 02 58 F2 08 58 98 58 08 F1 48 B8
F2 48 78 48 F1 B8 28 98 F2 28 58 28 F1 98 FD DC
A4 08 78 F2 08 48 08 F1 78 FC B6 A4 F0 A8 F1 58
98 F2 28 58 98 F0 88 F1 28 58 88 F2 08 58 F1 08
78 F2 08 48 08 F1 78 08 78 F2 08 48 78 B8 FB 02

F1 98 F2 08 48 98 F3 08 48 F1 78 F2 08 48 78 B8
F3 48 FD 2A A5 F1 58 F2 08 58 98 F3 08 58 F1 08
78 F2 48 28 08 F1 B8 FC 00 A5 F1 A8 F2 28 58 98
F3 28 58 F1 78 A8 F2 28 78 A8 F3 28 E0 4F F1 98
E0 4E F2 48 E0 4D 98 E0 4C F3 18 E0 4B F2 98 E0
4A 48 E0 48 F3 18 E0 46 F2 98 E0 44 48 E0 41 18
E0 3E F1 98 E0 3A 48 FE B2 A4

----------
;A56A - $04
74 A5 41 A6 FF FF FF FF FF FF 
;A574 - CH0
F7 05 FF FB 02 E6 E0 50 F2 0A E0 55

F1 4A E0 5A 7A E8 E0 5F F2 0A E0 64 F1 4A E0 69
7A EA E0 6E F2 2A F1 4A 8A EC E0 73 F2 2A F1 4A
8A EE E0 78 F2 4A F1 4A 9A EC E0 82 F2 0A F1 0A
4A EA 9A 4A 0A E8 E0 78 F2 0A E0 6E F1 4A E0 64
9A E6 E0 50 F2 7A E0 55 F1 BA E0 5A F2 0A E8 E0
5F 5A E0 64 F1 9A E0 69 F2 0A EA E0 6E 4A F1 7A
BA EC E0 73 F2 2A F1 5A 7A FD 0D A6 EE E0 78 F2
4A F1 7A BA EC E0 82 F2 0A F1 5A 9A EA BA 4A 7A
;A600
E8 E0 78 9A E0 6E 2A E0 64 5A FC 79 A5 EE E0 73
F2 0A F1 5A 7A EC F2 0A F1 4A 7A EA E0 6E F2 0A
F1 2A 5A E8 E0 64 BA E0 50 2A E0 3C 5A F7 0D FF
E0 64 CB E0 5A E6 4B E0 50 E4 7B E0 46 E2 F2 05
FF 
;A641 - CH1
F7 06 FF FB 02 E5 F1 08 F2 E2 03 E7 F0 B7 F1
E3 BA D5 E9 F0 95 DA F1 E4 97 D2 E5 F0 58 F1 E2
53 E7 F0 77 F1 E3 7A D5 FD 75 A6 E9 05 DA F2 E4
07 D2 FC 46 A6 F1 E9 05 DA F2 E4 07 D5 F1 75 F7

0D FF E3 01 FF

----------
;A685 - $05 - piecefull castle
8F A6 00 A7 74 A7 FF FF FF FF 
;A68F - CH0
E0
7A F5 07 FF ED F1 BA 9A 7A 65 D7 6A B5 15 22 DB
CB 28 68 98 F2 25 D7 2A 25 17 F1 BA F2 45 D7 F1
9A 98 C8 95 BA CA 4A 45 D8 48 68 78 6B 4B 6B 7B
92 2A 6A 9A F2 2A CA F1 BA B5 D8 B8 F2 18 28 1B
F1 BB F2 1B 2B 45 D5 F1 95 F2 65 D7 6A 15 45 25
D7 1A F1 B8 F2 28 18 F1 B8 98 68 F2 28 F1 68 92
D1 C5 78 48 F2 18 F1 48 72 D1 BA 9A 7A FE 99 A6
;A700
;A700 - CH1
F5 07 FF C5 E9 F1 25 D7 2A 75 F0 95 B2 DB CB 68
98 F1 28 45 D7 4A 85 25 15 D7 1A 18 C8 35 7A CA
F0 BA B5 D8 F1 28 18 F0 B8 95 F1 2B 1B 2B 4B 65
F0 9A 9A F1 2A BA CA 6A 65 D8 68 48 28 15 1B F0
BB F1 1B 2B 45 15 65 85 A5 F2 15 F1 B5 6A CA 6A
62 F0 91 F2 EB 2A 2A 4A 65 E7 2A 2A 4A 65 E3 2A
2A 4A E9 F0 91 F2 EB 1A 1A 2A 45 E7 1A 1A 2A 45
C5 FE 04 A7 
;A774 - TRI
C5 F1 27 CA 27 CA 17 CA 17 CA F0 B7

CA B7 CA 97 CA 97 CA 87 CA 87 CA F1 47 CA 47 CA
F0 97 CA F1 97 CA 77 CA 67 CA 45 DB CB 48 75 F0
B5 F1 25 DB CB 28 65 F0 95 B5 DB CB B8 F1 25 65
95 DB CB 98 45 F0 95 F1 65 45 15 F0 A5 B5 F1 BA
CA BC CC B2 27 CA F0 97 CA F1 27 CA F0 97 CA F1
27 CA F0 97 CA F1 27 CA F0 97 CA F1 17 CA F0 97
CA F1 17 CA F0 97 CA F1 17 CA F0 97 CA F1 17 CA
F0 97 CA FE 75 A7

----------
;A7F6 - $06
00 A8 61 A8 BF A8 FF FF FF FF
;A800
F7 04 01 EB FB 02 F1 B3 F2 08 25 F1 B5 F2 23 48
55 48 28 FD 25 A8 28 08 F1 73 78 98 F2 08 F1 B2
95 D5 FC 06 A8 F2 28 08 F1 72 48 78 71 C5 F2 23
F1 BB F2 1B 25 65 48 F1 B8 B1 F2 23 F1 BB F2 1B
25 65 42 D8 48 28 08 25 F1 B5 D6 BB F2 0B F1 BB
9B 7B B8 98 92 98 B8 98 78 42 38 78 71 C5 FE 04
A8 F7 04 02 E5 CB FB 02 F1 B3 F2 08 25 F1 B5 F2
23 48 55 48 28 FD 86 A8 28 08 F1 73 78 98 F2 08

F1 B2 92 FC 68 A8 F2 28 08 F1 72 48 78 71 C6 F5
08 01 E7 63 2B 4B 65 B5 72 D8 78 68 48 63 2B 4B
65 B5 72 D8 78 68 48 B5 72 78 28 55 51 48 F0 78
F1 08 F0 B8 98 78 78 98 B2 F1 05 25 FE 61 A8 FB
02 E0 44 F0 78 F1 28 78 28 B8 28 78 5B 4B 28 98
F2 58 F1 98 F2 98 F1 98 F2 58 F1 98 08 78 F2 08
28 48 F1 78 F2 08 F1 08 FD 02 A9 F0 78 F1 28 78
B8 E0 43 F2 28 E0 42 F1 98 E0 41 68 E0 40 28 FC
;A900
C1 A8 F0 78 F1 28 B8 F2 08 E0 43 28 E0 42 08 E0
41 F1 B8 E0 40 78 E0 44 F0 B8 F1 28 68 B8 F2 28
F1 B8 68 28 48 78 B8 78 F2 48 F1 78 B8 78 F0 B8
F1 28 68 B8 F2 28 F1 B8 68 28 08 78 F2 08 F1 78
F2 48 F1 78 F2 08 F1 78 F0 78 B8 F1 28 78 B8 28
78 B8 28 58 98 B8 F2 28 F1 B8 98 58 01 38 08 E0
44 F0 78 E0 43 F1 28 E0 42 78 E0 41 28 E0 40 98
E0 3F 28 E0 3E B8 E0 3D 28 FE BF A8

----------
;A97C - $07
86 A9 D6 A9 1F AA 5F AA 6E AA 
07_CH0_A986:
E0 91 
F6 09 FF 
EB 
EF 3C 7C AC
F0 3C 7C AC F1 3C 7C AC F2 3C 7C AC F3 3C CC 3C
CC 3C CC 
F6 03 05 
35 F2 B5 F3 15 3A CA 1A 31 
07_CH0_A9AF_R:
FB 02 
07_CH0_A9B1_R:
F1 A5 85 A5 88 F2 18 D8 18 05 18 05 08 
FD CB A9 
F1 A5 85 75 88 58 D0 
FC B1 A9 
07_CH0_A9CB_R:
F1 A5 85 A5 F2
18 38 D0 
FE AF A9 
07_CH1_A9D6:
F6 09 FF E5 CA EF 3C 7C AC F0
3C 7C AC F1 3C 7C AC F2 3C E8 F2 7C CC 7C CC 7C
CC F6 03 05 75 35 55 7A CA 5A 71 F1 FB 02 75 55
;AA00
75 58 58 D8 58 35 58 35 38 FD 15 AA 75 55 35 58
18 D0 FC FE A9 75 55 35 18 F0 B8 D0 FE FB A9 
07_TRI_AA1F:
C2
F2 3C CC F1 AC CC 7C CC 35 65 85 3A CA 3C CC 36
CB 36 CB 36 CB FB 03 FB 04 38 AB CB FC 39 AA FB
04 18 8B CB FC 41 AA FC 37 AA FB 04 38 AB CB FC
4C AA FB 04 F0 B8 F1 6B CB FC 54 AA FE 35 AA 
07_NO_AA5F:
C2
C0 C0 F9 08 0B 0B FA 08 F9 0B 0B FE 63 AA 
07_DMC_AA6E:
C2 C0
C0 02 08 03 03 08 02 02 08 03 03 05 05 08 FE 71

AA

----------
;AA81 - $08
8B AA 3D AB 81 AB FF FF FF FF 
E0 9B F5 03 07
EB C0 C1 C6 F1 BE F2 0E 1E FB 02 2B C6 F1 BB CB
7B CB 48 F2 2B CB F1 BB CB 7B CB BB C6 7B C6 B3
9B CB 7B CB 7B 9B 7B CB 5B CB 73 5B CB FD D3 AA
7B CB 7B BB F2 2B CB 4B CB 55 D6 F1 BE F2 0E 1E
FC 9B AA F1 7B CB 7B BB F2 2B CB 4B CB 55 D6 0E
2E 3E FB 02 4B C6 0B CB F1 9B CB 68 9B CB F2 0B
CB 4B CB 2B C6 7B C6 23 F1 BB CB FD 22 AB F2 0B
;AB00
C6 F1 9B CB 6B CB 28 6B CB 9B CB F2 0B CB F1 BB
CB BB F2 0B F1 BB CB 9B CB B5 D6 F2 0E 2E 3E FC
E4 AA F1 9B CB 9B BB 9B CB 7B CB 93 7B CB 9B CB
9B BB F2 0B CB 2B CB 4B C6 65 FE 91 AA F5 03 07
E8 FB 05 C5 F1 2B C6 C8 0B C6 0B C6 2B C6 2B C6
C8 0B C6 FC 43 AB FB 03 C5 0B C6 C8 0B C6 0B C6
2B C6 2B C6 2B C6 2B CB FC 58 AB C8 0B C6 0B C6
0B C6 0B C6 0B CB 4B CB BB CB 9B C6 F2 05 FE 41

AB FB 05 F1 7B C6 BB CB 7B CB 58 9B C6 9B CB 78
BB CB 78 BB CB 5B C6 9B CB 5B CB FC 83 AB FB 02
0B C6 7B CB 0B CB 28 9B C6 9B CB 78 BB CB 78 BB
CB 68 BB CB 28 BB CB FD D4 AB 0B C6 7B CB 0B CB
28 9B C6 9B CB 78 BB CB 78 BB CB 58 BB CB 28 BB
CB FC A0 AB 58 9B CB 48 9B CB 28 9B CB 08 9B CB
F0 98 F1 4B CB 9B CB 7B CB 6B C6 25 FE 81 AB

----------
;ABEF - $09
F9 AB 7E AC D8 AC FF FF FF FF 
E0 89 F6 02 07 EB FB
;AC00
02 C9 CE F1 AF BB C8 CD CE AF BB C8 CD CE AF BB
CB C5 FC 01 AC FB 02 F1 8B 6B 4B 6B 8B CB 9B CB
F2 16 F1 BB F2 1B CB 3B CB 48 7B 7B 7B CB 7B CB
72 88 6B 4B 38 1B F1 BB F2 4B 4B 3B 1B F1 BB 9B
8B 6B 7B CB F2 4B 0B F1 BB 9B 7B 5B 46 F8 8D 4B
F8 08 4B C6 FC 17 AC F3 4B CB 4B CB 2B CB 0B CB
F2 B5 9B CB 7B CB 55 3B CB 15 F1 BB CB 91 F3 1B
F2 BB 9B 7B 5C 3C 1C F1 BC 9C 7C FE FF AB F6 02

FF E8 FB 02 C8 F1 8B C6 8B C6 8B CB C5 FC 84 AC
FB 02 C8 F0 BB CB C3 BB CB C3 F1 0B CB C3 0B CB
C3 F0 BB CB C3 BB CB C5 F1 4B CB 4B CB 3B CB 2B
CB 16 F8 8D 1B F8 08 F2 1B CB C8 FC 92 AC F2 8B
CB 8B CB 6B CB 4B CB 35 1B CB F1 BB CB 95 7B CB
55 3B CB 15 D0 FE 82 AC FB 02 F1 48 C8 F0 B8 C8
F1 48 C5 F0 BB CB FC DA AC FB 02 F1 48 C8 F0 B8
C8 F1 48 C5 F0 BB CB F1 08 C8 F0 78 C8 F1 08 C5
;AD00
2B CB 48 C8 F0 B8 C8 F1 48 C5 F0 BB CB F1 0B CB
0B CB F0 BB CB AB CB 96 F5 FF 08 9B F5 FF FF 9B
CB C8 FC EB AC C0 F0 58 F1 08 78 F0 88 F1 18 68
75 D2 C2 FE D8 AC

----------
;AD36 - $0A = airship(Go above the Clouds!)
40 AD A4 AD 40 AE FF FF FF FF
;AD40 - CH0
E0 A2 
F5 09 FF 
E8 F1 FB 0A 08 FC 49 AD F6 07 07
EB F8 9E F0 01 F8 08 F2 02 D8 F1 B8 F2 08 28 45
05 F1 95 F2 05 F1 70 D2 C2 F2 02 D8 F1 B8 F2 08
28 45 05 55 95 70 D2 C5 F1 7D 9D BD F2 0D 2D 4D

5D 7D 92 D8 88 98 B8 F3 03 F2 78 D2 52 D8 48 58
78 93 48 D2 22 D8 18 28 48 55 25 65 95 72 92 A2
B2 FE 57 AD 
;ADA4 - CH1
F5 09 FF 
E8 F1 58 58 58 48 48 48 48
48 28 28 28 48 48 48 48 48 F5 09 FF FB 02 F1 58
58 58 48 48 48 48 48 28 28 28 48 48 48 48 48 FC
BE AD 58 58 58 FB 08 48 FC D7 AD 58 58 58 58 58
48 48 48 28 28 28 28 28 58 58 58 48 48 48 48 48
F5 03 07 53 F2 05 58 48 28 4B CB 5B 4B 2B CB 4B
;AE00
2B 0B CB 2B 0B F1 BB CB F2 0B F1 BB 53 95 88 98
B8 F2 0B CB 2B 0B F1 BB CB F2 0B F1 BB 9B CB BB
9B 7B CB 9B 7B 53 A5 98 A8 F2 08 25 F1 A5 95 65
B3 AB BB F2 03 F1 BB F2 0B 13 0B 1B 22 FE B9 AD
;AE40 - TRI
C0 C5 F2 08 F1 78 48 78 28 78 FB 20 F1 08 F2 0B
CB FC 4C AE FB 04 F1 58 F2 0B CB FC 56 AE FB 04
F1 08 F2 0B CB FC 60 AE FB 04 F1 28 9B CB FC 6A
AE FB 04 F0 98 F1 9B CB FC 73 AE FB 04 F0 A8 F1

AB CB FC 7D AE F0 A8 F1 AB CB F0 A8 F1 AB CB F0
98 F1 9B CB F0 98 F1 9B CB 75 F2 7B CB F1 55 F2
5B CB F1 58 F2 5B CB F1 45 F2 4B CB F1 25 F2 2B
CB F1 28 F2 2B CB FE 4A AE

----------
;AEB9 - $0B
C3 AE 5A AF D6 AF FF FF FF FF 
E0 60 EB F6 02 FF F2 0B F1 AB FB 02 98
F2 0B CB 2B CB 5B CB 4B 5B 4B 5B 4B CB 2B CB 0B
CB 0B 2B 0B CB F1 7B CB 93 7B 9B AB CB AB CB AB
9B 7B 5B 73 7B 9B FD 0C AF AB CB F2 0B CB F1 AB
;AF00
9B 7B 5B 75 C8 F2 0B F1 AB FC CF AE AB CB F2 0B
CB F1 AB 9B 7B 5B 75 C5 F7 0A 06 F2 55 26 5B 4B
5B 7B 4B 0B C6 F1 AB F2 0B 2B CB F1 7B 9B AB CB
9B CB AB CB BB CB F2 0B CB 55 26 5B 4B 5B 7B 4B
0B CB 2B 4B 5B 4B 2B 0B F1 AB 9B 7B 5B 4B CB C5
F6 02 FF F2 0B F1 AB FE CD AE F5 02 FF E8 C8 FB
02 F1 58 6B 7B 88 9B AB F2 0B F1 AB 9B 8B 78 58
4B 5B 78 0B 2B 48 58 4B 3B 2B 3B 4B 5B 78 F2 28

F1 58 F2 28 F1 48 48 0B 2B 4B 5B FD 9F AF 78 F2
28 F1 58 F2 28 F1 48 48 0B 2B 4B 7B FC 61 AF 78
F2 28 F1 58 F2 28 F1 48 48 45 25 56 AB 7B 9B AB
7B 45 7B 9B A8 4B 5B 78 58 78 88 98 25 56 AB 7B
9B AB 7B 48 5B 7B F2 2B 0B F1 AB 9B 7B 5B 4B 2B
0B C6 75 FE 5F AF C8 FB 02 FB 04 F1 58 F2 0B CB
F1 08 F2 0B CB FC DB AF FB 02 F1 78 F2 2B CB F1
58 F2 2B CB F1 48 F2 0B CB F1 08 F2 0B CB FC EA
;B000
AF FC D9 AF FB 02 F0 A8 F1 AB C6 AB CB 08 F2 0B
C6 0B CB FD 2C B0 F1 28 F2 2B CB F1 48 F2 4B CB
F1 5B CB 4B CB 2B CB 0B CB FC 06 B0 F0 7B F1 7B
F0 9B F1 9B F0 AB F1 AB F0 BB F1 BB 0B C6 A5 FE
D7 AF

----------
;B042 - $0C
4C B0 BA B0 14 B1 FF FF FF FF 
E0 8C EB F6
03 07 FB 02 C0 C4 CD F1 E4 8F E7 9B CB C2 FC 54
B0 C8 E7 1F EB 29 DE 48 58 98 F2 08 48 28 03 08
08 F1 78 98 A8 90 D2 C2 C8 F2 1F 29 DE 48 58 98

F3 08 48 28 03 08 08 F2 78 98 A8 90 D2 C2 F6 08
06 FB 02 F2 73 58 43 58 45 F1 9B F6 02 07 E8 C6
F3 4B C6 F2 95 EB F5 08 06 78 58 48 58 48 28 18
48 F1 91 C5 FC 93 B0 FE 4F B0 F6 03 07 E8 FB 02
C0 C4 CD F1 E2 6F E4 7B CB C2 FC C0 B0 E8 C0 F5
0A 06 C0 53 23 45 53 33 15 20 F7 0A 06 C0 F2 53
23 45 53 33 15 E6 FB 02 F2 22 F1 A2 F2 15 F1 1B
F6 02 07 C6 F3 1B C6 F2 15 F7 0A 06 22 F1 A5 75
;B100
FD 08 B1 41 C5 FC E8 B0 78 58 48 58 48 28 18 F0
98 FE BA B0 FB 02 F1 28 C3 98 C8 F0 98 C8 F1 38
C3 98 C8 F0 98 C8 FC 16 B1 FB 04 F1 28 C3 98 C8
F0 98 C8 F1 38 C3 98 C8 F0 98 C8 FC 2B B1 FB 02
FB 02 A8 C5 F1 59 DE 9F A3 F0 AB CB FD 5B B1 9B
CB 9B C6 F1 48 95 F0 95 FC 42 B1 9B CB 9B C7 CF
F1 3F 48 F0 98 C3 FC 40 B1 FE 14 B1

----------
;B16C - $0D
76 B1 FA B1 5B B2 FF FF FF FF 
E0 50 F6 0B 05 E6 F2 3E 4E 5E

F2 FB 02 EB 65 DB E6 2E 3E 4E EB 55 DB E6 3E 4E
5E EB 65 DB E6 5E 6E 7E EB 85 DB E6 3E 4E 5E EB
62 DB E6 F1 BE F2 0E 1E EB 2A E6 F1 9E AE FD BC
B1 EB B2 D6 E6 F2 3E 4E 5E FC 83 B1 F1 EB B2 D6
E6 F2 8E 9E AE EB B5 DB E6 7E 8E 9E EB A5 DB E6
8E 9E AE EB B5 DB E6 AE BE F3 0E EB F3 15 DB E6
F2 8E 9E AE EB B2 DB E6 4E 5E 6E EB 7A E6 2E 3E
EB 42 D6 E6 3E 4E 5E FE 80 B1 F7 03 FF E4 C5 FB
;B200
02 EF B8 F0 68 B8 EF B8 F0 78 F1 18 EF B8 F0 68
B8 EF B8 F0 88 F1 28 EF B8 F0 68 B8 EF B8 F0 58
B8 EF B8 F0 88 F1 28 EF B8 F0 78 F1 18 FC 01 B2
F0 48 B8 F1 48 F0 48 F1 08 68 F0 48 B8 F1 48 F0
48 F1 18 78 F0 48 B8 F1 48 F0 48 A8 F1 48 F0 48
F1 18 78 F0 48 F1 08 68 FE FF B1 CB FB 02 F0 B8
F1 68 B8 F0 B8 F1 78 F2 18 F0 B8 F1 68 B8 F0 B8
F1 88 F2 28 F0 B8 F1 68 B8 F0 B8 F1 58 B8 F0 B8

F1 88 F2 28 F0 B8 F1 78 F2 18 FC 5E B2 F1 48 B8
F2 48 F1 48 F2 08 68 F1 48 B8 F2 48 F1 48 F2 18
78 F1 48 B8 F2 48 F1 48 A8 F2 48 F1 48 F2 18 78
F1 48 F2 08 68 FE 5C B2

----------
;B2B8 - $0E
C2 B2 E9 B2 0E B3 FF FF FF FF 
E0 B4 F6 03 FF EB F1 78 88 98 A5 A8 B8 F2
08 15 18 28 38 45 48 F2 78 88 98 A5 A8 B8 F3 08
15 18 28 38 45 48 FE C8 B2 F6 03 FF E8 F1 48 58
68 75 78 88 98 A5 A8 B8 F2 08 15 18 F2 48 58 68
;B300
75 78 88 98 A5 A8 B8 F3 08 15 18 FE ED B2 F5 FF
07 FB 05 F1 1B CB 1B CB F2 18 FC 13 B3 F1 1B CB
FE 11 B3

----------
;B323 - $0F
2D B3 70 B3 03 B4 FF FF FF FF 
E0 55 F6
0B 07 EB FB 02 C5 F2 7F 69 DE 48 38 48 7F 69 DE
48 3B C8 F1 BB F2 02 3B C8 F1 BB F2 00 FC 35 B3
FB 02 F1 B8 F2 B8 98 B8 F3 08 F2 B8 68 78 93 68
B5 95 7B C8 1B 32 7B C8 1B 30 FC 52 B3 FE 33 B3
F5 03 07 FB 02 E8 F0 9B F1 0B 4B 6B E6 F0 9B F1

0B 4B 6B E4 F0 9B F1 0B 4B 6B E2 F0 9B F1 0B 4B
6B E8 F0 BB F1 1B 3B 7B 0B 2B 4B 8B E6 0B 2B 4B
8B E8 F0 BB F1 1B 3B 7B E8 0B 2B 4B 8B E6 0B 2B
4B 8B E4 0B 2B 4B 8B E2 0B 2B 4B 8B FC 75 B3 E8
63 5B 4B 33 2C 1C 0C F0 B3 B8 F1 15 35 FB 03 F1
7B C8 F0 BB F1 5B C8 F0 BB FC CF B3 F1 7B C8 F0
BB F1 5B C6 63 5B 4B 33 2C 1C 0C F0 B3 B8 F1 15
35 FB 04 F1 7B C8 F0 BB F1 5B C8 F0 BB FC F3 B3
;B400
FE 73 B3 FB 0B F0 9B CB 9B CB C5 FC 05 B4 9B CB
9B CB F1 BD 9D 7D 6D 4C 2C 0C F0 B3 F1 18 33 48
68 48 38 18 F0 B5 95 FB 07 F1 1B CB 7B CB FC 29
B4 BD 9D 7D 6D 4C 2C 0C F0 B3 F1 18 33 48 68 48
38 18 F0 B5 95 FB 08 F1 1B CB 7B CB FC 47 B4 FE
03 B4

----------
;B452 - $10
5C B4 B2 B4 02 B5 FF FF FF FF 
F6 0B 07 EB
FB 02 F2 13 F1 98 45 68 88 98 F2 18 68 38 45 F1
B5 FD 83 B4 F2 23 F1 98 88 48 F2 28 08 12 F1 B2

FC 62 B4 F2 23 4B 2B 18 F1 68 88 B8 B2 92 F6 0C
07 EC 93 88 95 B5 F2 10 F1 93 88 95 B5 F2 10 13
08 15 35 42 F1 B2 F2 42 D8 28 18 F1 B8 92 82 FE
5C B4 F6 0B 07 E8 FB 02 F1 45 28 18 F0 B5 F1 25
18 68 98 B8 88 68 45 FD DA B4 68 48 28 18 F0 B5
F1 68 38 45 95 85 25 FC B8 B4 58 98 78 58 45 25
55 48 28 12 F5 08 06 E5 FB 02 F2 51 75 92 D8 88
68 48 FC EA B4 91 B8 98 80 72 D8 68 48 28 40 FE
;B500
B2 B4 E0 50 FB 02 F1 92 82 62 42 FD 17 B5 23 D9
CD 22 92 42 FC 06 B5 B2 42 F2 25 E0 4E 18 F1 B8
E0 4C 95 E0 4A F0 95 E0 50 F1 28 58 98 F2 28 58
28 F1 98 58 F0 98 F1 48 98 F2 18 48 18 F1 98 48
F0 B8 F1 58 B8 F2 28 58 28 F1 B8 58 F0 98 F1 48
98 F2 18 48 18 F1 98 48 68 98 F2 18 68 98 68 38
F1 B8 48 88 B8 F2 48 88 48 F1 B8 88 78 B8 F2 28
78 B5 75 F1 48 B8 E0 4E F2 28 48 E0 4C 88 E0 4A

48 E0 48 F1 B8 E0 46 88 FE 02 B5

----------
;B58B - $11
95 B5 08 B6 6A B6 FF FF FF FF 
E0 6E F6 02 FF EB FB 02 F3 0B C6
F2 7B C6 66 9B 7B CB 2B CB FD BF B5 6B CB 6B 7B
9B 7B 6B 2B 08 4B CB 2B CB F1 9B CB FC 9D B5 F2
6B CB 6B 7B 9B 7B 6B 2B 08 4B CB 2B C6 FB 02 F2
9B C6 2B C6 F3 2B 4B 2B 4B 2B CB F2 9B CB FD F1
B5 F3 28 0B F2 BB 9B BB F3 0B 1B C5 2B C6 FC CF
B5 F3 2B 4B 2B CB 0B 2B 0B CB F2 BB F3 0B F2 BB
;B600
CB 9B BB 9B CB FE 9B B5 F5 02 FF E8 FB 02 C8 F1
4B 6B 7B CB 2B CB F2 2B 4B 2B 4B 2B CB F1 9B CB
C8 9B BB F2 0B F1 BB 9B 6B C8 4B 7B 6B C6 FC 0E
B6 FB 02 F1 C8 6B 7B C8 9B BB F2 0B F1 BB F2 0B
F1 BB F2 0B CB 2B CB FD 57 B6 68 4B 2B 0B 2B 4B
5B C5 6B C6 FC 33 B6 6B 7B 6B CB 4B 6B 4B CB 2B
4B 2B CB 0B 2B 0B CB FE 0C B6 FB 08 F1 08 C8 78
C8 FC 6D B6 FB 02 F1 28 C8 98 C8 28 C8 98 C8 FD

95 B6 28 C8 98 C8 2B CB F2 2B CB F1 6B F2 1B 8B
F3 3B FC 76 B6 F2 28 F1 2B CB F2 08 F1 4B CB B8
6B CB 98 2B CB FE 6A B6

----------
;B6A8 - $12
B2 B6 7D B7 79 B8 FF FF FF FF 
F7 04 07 EB F2 25 F1 A8 F2 0B 2B 05 F1 98
F2 08 F1 A8 98 78 A8 92 F2 55 18 3B 5B 35 08 38
18 08 F1 A8 F2 18 02 FB 02 F2 95 58 7B 9B 78 4B
CB 45 5B 4B 2B CB F1 AB F2 0B 2B 5B 48 F1 9B CB
C5 FC D9 B6 FB 02 AB F2 0B 2B 4B 7B 5B 4B 2B 18
;B700
9B CB F1 95 FD 18 B7 F2 2B 4B 5B 4B 2B 0B F1 AB
F2 0B F1 95 C5 FC F6 B6 F2 2B 4B 5B 9B 7B 5B 4B
2B 48 F1 BB F2 2B 15 F6 02 FF E3 2D 4D 2D 4D E4
2D 4D 2D 4D E5 2D 4D 2D 4D E6 2D 4D 2D 4D E7 2D
4D 2D 4D E8 2D 4D 2D 4D E9 2D 4D 2D 4D EA 2D 4D
2D 4D EB 0D 4D 0D 4D EA 0D 4D 0D 4D E9 0D 4D 0D
4D E8 0D 4D 0D 4D E7 0D 4D 0D 4D E6 0D 4D 0D 4D
E5 0D 4D 0D 4D E4 0D 4D 0D 4D FE B2 B6 E0 41 F6

04 07 E8 F1 AB 9B 7B 5B 2B 7B 9B AB 9B 7B 5B 3B
0B 5B 7B 9B 7B 5B 3B 2B 0B 2B 4B 7B E0 3F 68 E0
3D 48 E0 3B 28 E0 39 68 E0 41 F2 1B 0B F1 AB 8B
5B AB F2 0B 1B 0B F1 AB 8B 6B 3B 8B AB F2 0B F1
AB 8B 6B 5B 3B 5B 7B AB E0 3F 98 E0 3D 78 E0 3B
58 E0 39 98 E0 40 FB 02 F2 55 28 4B 5B 48 0B CB
05 2B 0B F1 AB CB 7B 9B AB F2 2B 18 F1 4B CB C5
FC D8 B7 FB 02 7B 9B AB F2 0B 4B 2B 0B F1 AB 98
;B800
7B CB 45 FD 15 B8 AB F2 0B 2B 0B F1 AB 9B 7B 9B
45 C5 FC F5 B7 AB F2 0B 2B 5B 4B 2B 0B F1 AB B8
88 95 E0 3F F6 02 FF E1 5D 9D 5D 9D 5D 9D 5D 9D
E2 5D 9D 5D 9D E3 5D 9D 5D 9D E4 5D 9D 5D 9D E5
5D 9D 5D 9D E6 5D 9D 5D 9D E7 5D 9D 5D 9D E8 6D
9D 6D 9D E7 6D 9D 6D 9D E6 6D 9D 6D 9D E5 6D 9D
6D 9D E4 6D 9D 6D 9D E3 6D 9D 6D 9D E2 6D 9D 6D
9D E1 6D 9D 6D 9D FE 7D B7 F1 72 52 35 45 22 A2

82 65 75 52 FB 02 F1 2D CD 2D CD 9D CD 9D CD C5
0D CD 0D CD 7D CD 7D CD C5 F0 AD CD AD CD F1 5D
CD 5D CD C5 F0 CB 9D CD F1 4D CD 4D CD F1 9D CD
9D CD F0 9D CD 9D CD FC 86 B8 FB 02 F0 7D CD 7D
CD F1 2D CD 2D CD C5 F0 9D CD 9D CD F1 4D CD 4D
CD C5 FD F6 B8 F0 AD CD AD CD F1 5D CD 5D CD C5
F0 9D CD 9D CD F1 4D CD 4D CD F1 CB 9D CD F0 9D
CD 9D CD FC BC B8 F0 AD CD AD CD F1 5D CD 5D CD
;B900
C5 4D CD 4D CD 8D CD 8D CD 9D C9 F0 98 F1 2B CB
9B CB F2 23 F1 2D CD 2D CD C5 F1 2B CB 9B CB F2
03 F1 2D CD 2D CD C5 FE 79 B8

----------
;B92A - $13
34 B9 B2 B9 35 BA FF FF FF FF 
F7 04 07 E0 5A E4 F0 28 E0 57 E5 68
E0 54 E6 98 E0 51 E7 F1 18 E0 4E E8 28 E0 4B E9
68 E0 48 EA 98 E0 45 EB F2 18 F6 03 07 F2 25 18
F1 B8 F2 15 F1 95 B5 98 78 95 65 FB 03 5B 1B F2
1B F1 1B F2 2B F1 1B F2 1B F1 1B 6B 1B F2 1B F1

1B F2 2B F1 1B F2 1B F1 1B FC 6D B9 B8 F2 28 68
B8 82 95 88 68 48 F1 B8 F2 48 88 F6 0D 07 61 F6
03 07 68 88 95 B8 98 88 68 48 88 F6 0D 07 60 FE
5A B9 F7 04 09 CC E1 F0 28 68 E2 98 E3 F1 18 E4
28 E5 68 E6 98 E7 F2 1A F5 03 07 E0 5A F1 B5 75
95 15 75 45 65 F0 95 E3 FB 03 F3 1B CB F2 5B CB
8B CB 5B CB F3 1B CB F2 6B CB 9B CB 6B CB FC DA
B9 E7 E0 58 F1 28 E0 56 98 E0 54 88 E0 52 68 E0
;BA00
4E 52 E0 5A 28 48 68 98 88 68 45 98 F2 18 F1 88
F2 18 F1 68 F2 18 F1 68 48 28 48 68 98 88 68 45
E0 58 68 E0 55 18 E0 52 F0 B8 E0 4F F1 18 E0 4C
F0 A2 FE CB B9 C0 F1 75 D9 CD 78 62 45 D9 CD 48
22 FB 03 15 D9 CD 19 CD 13 D9 CD FC 43 BA F0 B5
F1 25 12 25 D9 CD 28 45 D9 CD 48 62 D8 D9 CD 68
48 25 D9 CD 28 45 D9 CD 48 60 FE 36 BA

----------
;BA6D - $14
77 BA 0C BB AD BB FF FF FF FF 
F5 03 FF EB E0 46 F2 88 38

48 68 75 68 48 42 32 05 45 33 F1 B8 F2 45 75 62
45 75 63 38 95 E0 42 F3 05 E0 3E F2 B8 E0 3A 98
E0 36 88 E0 32 68 E0 43 F6 08 07 FB 02 F1 B8 F2
48 68 F1 B8 F2 95 88 68 48 3B 4B 68 48 45 35 18
68 88 18 B5 98 88 FD D3 BA 68 5B 8B 68 18 85 65
FC AD BA 68 5B 8B 68 18 85 68 6D 8D 9D BD F3 13
18 F2 B3 88 98 9B 8B 68 58 68 88 98 B8 F3 23 28
13 F2 98 B8 BB F3 0B F2 B8 BB F3 0B E0 41 F2 B8
;BB00
E0 3F 98 E0 3D 88 E0 3B 68 FE A6 BA F5 02 FF E8
F1 B5 78 9B BB F2 08 F1 B8 98 78 65 4B 6B 7B 9B
BB CB 6B 7B 98 38 48 4B 2B 48 78 68 6B 4B 65 F2
08 F1 0B 2B 4B 6B 7B 9B B8 68 38 F0 B8 F1 75 48
78 F0 B8 BB F1 1B 35 48 68 78 48 38 18 F0 B8 98
F6 08 07 FB 02 F0 B3 F1 1B 3B 48 18 38 68 18 3B
4B 68 8B AB B8 68 38 F0 B8 F1 65 58 6B 8B 98 68
58 B8 95 A5 B2 FC 55 BB 4B CB 9B 8B 98 48 4B CB

BB 9B 8B 6B 4B 8B F2 2B F1 9B 68 8B 1B 3B 5B 68
F0 BB F1 1B 2B 4B 68 75 DB 7B 9B BB 95 DB 9B 7B
6B 48 4B 2B 0B 2B 48 35 48 68 FE 50 BB F1 45 05
F0 95 F1 25 F0 B5 F1 65 B5 F0 B5 F2 08 F1 0B 2B
4B 6B 7B 9B BB CB 6B CB 3B CB F0 BB CB F1 4B CB
4B 2B 48 08 6B CB 6B 4B 65 F1 0B 2B 4B 6B 78 6B
4B 3B 4B 6B 7B 98 B8 F2 05 F1 95 65 F0 B5 F1 45
35 15 F0 B5 95 A5 B2 F1 95 85 65 55 65 45 35 F0
;BC00
B5 F1 45 35 15 05 15 F0 A5 B2 F1 95 85 65 55 65
45 35 F0 B5 F1 98 F0 9B BB F1 1B 3B 4B 6B 89 CD
8B 6B 8B CB 4B CB 68 28 18 BB 8B 68 48 28 18 F0
BB CB F1 BB 9B B8 78 6B CB F2 1B CB F1 9B CB F0
9B BB F1 0B CB F2 0B CB F1 4B 6B 78 68 38 F0 B8
98 FE EE BB

----------
;BC54 - $15
5E BC B5 BC 60 BD FF FF FF FF 
F6 0F
01 EB FB 02 F2 63 D5 48 93 23 13 D5 F1 B8 F2 43
F1 B3 98 B8 98 F2 41 F1 73 68 78 68 F2 11 F1 B8

F2 18 28 FC 64 BC 68 78 68 91 23 18 28 18 41 F1
B3 F2 18 28 18 61 13 18 48 28 F1 B1 93 78 98 78
F2 21 F1 73 68 78 68 F2 11 F1 65 78 91 43 B3 91
D2 C5 FE 62 BC F7 05 FF E3 C6 FB 02 F0 FB 02 28
78 B8 F1 28 F0 B8 78 FC BF BC FB 02 48 78 B8 F1
18 F0 B8 78 FC CC BC FB 02 48 78 98 F1 18 F0 98
78 FC D9 BC FB 02 28 68 98 F1 18 F0 98 68 FC E6
BC FC BC BC FB 02 78 B8 F1 48 68 48 F0 B8 FC F6
;BD00
BC FB 02 78 B8 F1 18 78 18 F0 B8 FC 03 BD FB 02
F0 68 F1 18 48 98 48 18 FC 10 BD FB 02 F0 68 B8
F1 28 68 28 F0 B8 FC 1D BD FB 02 78 B8 F1 28 48
28 F0 B8 FC 2B BD FB 02 68 98 F1 18 48 18 F0 98
FC 38 BD FB 02 48 78 B8 F1 28 F0 B8 78 FC 45 BD
FB 02 48 78 B8 F1 18 F0 B8 78 FC 52 BD FE BA BC
E0 70 FB 02 F1 FB 02 28 78 B8 F2 28 F1 B8 78 FC
67 BD FB 02 48 78 B8 F2 18 F1 B8 78 FC 74 BD FB

02 48 78 98 F2 18 F1 98 78 FC 81 BD FB 02 28 68
98 F2 18 F1 98 68 FC 8E BD FC 64 BD FB 02 78 B8
F2 48 68 48 F1 B8 FC 9E BD FB 02 78 B8 F2 18 78
18 F1 B8 FC AB BD FB 02 F1 68 F2 18 48 98 48 18
FC B8 BD FB 02 F1 68 B8 F2 28 68 28 F1 B8 FC C5
BD FB 02 78 B8 F2 28 48 28 F1 B8 FC D3 BD FB 02
68 98 F2 18 48 18 F1 98 FC E0 BD FB 02 48 78 B8
F2 28 F1 B8 78 FC ED BD E0 70 48 E0 6E 78 E0 6C
;BE00
B8 E0 6A F2 18 E0 68 F1 B8 E0 66 78 E0 64 48 E0
62 78 E0 60 B8 E0 5E F2 18 E0 5C F1 B8 E0 5A 78
FE 60 BD

----------
;BE23 - $16
2D BE 9F BE CD BE FF FF FF FF 
E0 7D F6
02 FF EB FB 02 F1 5B CB 2B CB 1B CB 4B CB 5B CB
2B CB 7B CB 4B CB FC 35 BE F5 07 07 FB 02 95 2A
5A 9A 82 95 2A 5A F2 0A F1 B2 FD 6C BE 95 5A 9A
F2 2A 08 F1 B8 98 88 91 C5 FC 4E BE 95 5A 9A F2
2A 08 F1 B8 98 B8 F2 01 F5 0F 01 F1 95 FB 02 F2

41 0A F1 9A F2 0A 21 F1 95 F2 01 0A F1 9A F2 0A
FD 99 BE F1 B1 95 FC 7F BE F1 B1 C5 FE 49 BE F6
11 07 EC FB 08 EF 2B C6 FC A6 BE EB EF FB 04 21
F0 0E 1E 2E D6 EF 20 FC AF BE FB 20 EF EB 2B E7
CB F0 2D CD E3 2D CD FC BC BE FE AB BE F0 FB 10
9B CB FC D0 BE FB 02 F2 FB 02 55 F1 95 BA 8A BA
F2 4A F1 BA F2 4A FC DA BE 55 25 05 45 FD FF BE
55 F1 95 BA 8A BA F2 4A F1 BA F2 4A FC D7 BE 55
;BF00
F1 95 BA F2 0A 2A 4A 5A 7A FB 02 95 55 2A F1 9A
F2 2A 5A 2A 5A 75 45 F1 BA 7A BA F2 4A F1 BA F2
4A 55 25 F1 9A 5A 9A F2 2A F1 9A F2 2A 45 05 F1
BA F2 0A 2A 4A 5A 7A FC 0B BF FE D5 BE

----------
;BF3D - $17
47 BF 63 BF 74 BF FF FF FF FF 
E0 7D F5 07 07 EB F1 7D 9D
AD F2 05 0C CC 0C CC 0C CC E0 76 15 E0 6F 35 E0
68 51 FF F5 07 07 C9 E8 F1 55 9C CC 7C CC 5C CC
55 75 91 FF C9 F1 95 F2 0A F1 AA 9A 85 35 52 D8

FF

----------
;BF81 - $18
8B BF B8 BF DC BF FF FF FF FF 
F5 07 07 EB E0
87 F2 0C CC 0C CC 0C CC 02 D8 F1 7B 7B F2 0B CB
4B CB 2B CB F1 AB CB F2 2B CB 9B CB 7B CB 4B CB
7B CB F3 0B CB F2 A0 FF F5 07 07 E8 C5 F1 4C CC
4C CC 4C CC 43 0B 2B 4B CB 7B CB 28 2B 4B 5B CB
2B CB 48 4B 5B 7B CB F2 4B CB 20 FF C5 C5 F1 7C
CC 7C CC 7C CC 78 4B 5B 7B CB F2 0B CB F1 A5 55
F2 08 F1 0B 2B 4B CB 5B CB F0 A1 D8 FF 00 00 00

;$19-$2A
A024	;24 A0
A125	;25 A1
A1D2	;D2 A1
A2A7	;A7 A2 - $1C = dance ver 1
A332	;32 A3
A46F	;6F A4
A748	;48 A7
A92B	;2B A9
AC7F	;7F AC
AD97	;97 AD
AF00	;00 AF - $23 = The invincible
B0A5	;A5 B0
B236	;36 B2
B40B	;0B B4
B585	;85 B5
B717	;17 B7
BA9A	;9A BA
BCC0	;C0 BC

----------
;A024 - $19
2E A0 90 A0 E5 A0 FF FF FF FF 
F6 02 
FF EB E0 78 F2 58 4B 4B 4B CB 5B CB 7B CB 7B CB 
5B CB 7B CB E0 73 85 E0 6E 7B 5B 3B 7B E0 5A 55 
D6 E0 78 1E 2E 3E F2 4A CA 2A 0A CA F1 7A 65 D7 
4C 6C 7A C7 2A C7 7A C4 C5 F2 0A 0A C4 0A 0A C4 
0A 0A C4 0A 0A C7 F1 7A 7A 7A 7A 9A AA BA C7 C5 

2A 2A 2A 2A 4A 6A 7A C7 C6 F2 1E 2E 3E FE 56 A0 
F6 02 FF E7 F1 78 7B 7B 7B CB 7B CB 8B CB 8B CB 
8B CB 8B CB A5 75 92 F1 7A C7 4A C7 02 F0 BA C7 
F1 0A C7 F0 BA C4 F1 6A FB 02 5A CA BA BA CA 5A 
3A CA BA BA FD CC A0 CA 3A FC BA A0 C7 2A 2A 2A 
2A 1A 0A F0 BA C7 C5 BA BA BA BA F1 0A 2A F0 BA 
C7 C5 FE A7 A0 F2 05 F1 75 F2 15 F1 85 F2 35 F1 
A8 78 52 0A C4 0A 2A C4 2A 7A C7 2A C7 7A C4 6A 
;A100
5A C4 5A 3A C4 3A 5A C4 5A 3A C4 3A 7C CC 7C CC 
7C CC 7A 9A AA B8 C3 2C CC 2C CC 2C CC 2A 4A 6A 
78 C3 FE F3 A0

----------
;A125 - $1A
2F A1 75 A1 AB A1 FF FF FF FF 
F6 
02 FF EB E0 BE C0 C0 FB 02 F2 38 48 38 48 08 F1 
78 98 78 F2 08 08 F1 98 F2 05 F1 78 98 F2 08 C5 
F3 48 C8 38 45 38 48 48 38 48 D2 FC 39 A1 F2 18 
28 18 28 F1 B8 75 F2 35 38 28 08 F1 98 78 98 F2 
08 D0 FE 36 A1 F6 02 FF E7 FB 0C F0 78 78 98 98 

FC 7B A1 FB 04 F1 08 08 28 28 FC 85 A1 FB 04 F0 
78 78 98 98 FC 8F A1 F1 28 28 48 48 28 28 48 48 
08 08 28 28 08 08 28 48 FE 79 A1 F1 FB 30 09 CD 
FC AE A1 FB 10 59 CD FC B5 A1 FB 10 09 CD FC BC 
A1 FB 08 79 CD FC C3 A1 FB 08 59 CD FC CA A1 FE 
AC A1

----------
;A1D2 - $1B
DC A1 3A A2 68 A2 FF FF FF FF 
F6 02 07 EB 
E0 A5 F1 95 F2 16 2B 48 18 28 48 25 66 7B 98 68 
78 98 C8 BB CB B5 C8 9B CB 95 C8 8B C6 6B C6 4B 
;A200
C6 2B CB FB 02 F1 98 F2 08 18 48 78 78 68 48 38 
48 96 F1 BD F2 0D 18 48 75 F3 15 F2 B5 95 75 FD 
29 A2 65 45 25 15 FC 05 A2 F2 6B 4B 2B 1B 0B CB 
1B CB F1 9B C6 F2 95 FE 03 A2 F6 02 07 E8 C0 C0 
C8 F2 AB CB A5 C8 8B CB 85 C8 4B C6 2B C6 1B C6 
F1 BB CB FB 07 C8 F1 4B C6 4B C6 2B C6 2B CB FC 
55 A2 C1 F2 15 FE 53 A2 F0 95 F1 16 2B 48 18 28 
48 25 66 7B 98 68 78 98 48 F3 4B CB 48 F2 48 F1 

28 F3 2B CB 28 F1 28 F2 15 F1 85 95 B5 FB 07 98 
F2 1B CB F1 98 F2 1B CB F1 78 BB CB 78 BB CB FC 
8F A2 C1 95 FE 8D A2

----------
;A2A7 - $1C = dance ver 1
B1 A2 ED A2 1E A3 FF FF FF FF 
;A2B1 - CH0
F7 0A 07 EC E0 6E C0 C8 F1 9B CB 9B CB 9B CB 
96 8D 9D BB CB 9B CB 8B CB BB CB BB CB BB CB B6 
9D BD F2 1B CB F1 BB CB 9B CB F2 FB 02 1B CB 6B 
CB 5B CB 12 D8 FC DD A2 C8 5B C6 65 FF 
;A2ED - CH1
F6 13 FF 
E7 C0 C8 F1 68 68 68 66 5D 6D 88 68 58 88 88 88 
;A300
86 6D 8D 98 88 68 FB 02 68 98 88 58 F2 88 F3 1B 
F2 BB 9B 8B 68 F1 FC 08 A3 C8 F1 B5 95 FF 
;A31E - TRI
FB 14 
F1 6B CB F2 1B CB FC 20 A3 F1 68 C8 F2 1B C6 F1 
65 FF

----------
;A332 - $1D
3C A3 7C A3 E3 A3 FF FF FF FF 
E0 5A F6 03 
07 E8 FB 02 F3 43 28 15 F2 B5 F3 23 08 F2 B5 95 
88 C8 83 68 88 98 8B C8 6B 81 FC 44 A3 F5 08 07 
C5 E8 45 EB 5B C6 C2 EB 45 E8 2B C6 C2 E8 45 EB 
5B C6 C2 ED 85 EE BB C6 C2 FE 3E A3 FB 02 F5 03 

07 E6 F2 53 68 72 33 48 52 F5 02 FF E4 4B C8 2B 
4B C8 0B 2B C8 0B 2B C8 F1 AB F2 0B C6 4B C6 0B 
C6 2B C6 FC 7E A3 FB 02 F5 05 07 F0 E1 4B 5B E2 
4B 5B E3 4B 5B E4 4B 5B E5 4B 5B E6 4B 5B E7 4B 
5B E8 4B 5B E9 4B 5B E8 4B 5B E7 4B 5B E6 4B 5B 
E5 4B 5B E4 4B 5B E3 4B 5B E2 4B 5B FC AC A3 C5 
FE 7C A3 FB 02 F2 5B CB 8B CB 5B CB 8B CB 4B CB 
7B CB 4B CB 7B CB 3B CB 6B CB 3B CB 6B CB 2B CB 
;A400
5B CB 2B CB 5B CB 0B CB 8B CB 0B CB 8B CB F1 AB 
CB F2 6B CB F1 AB CB F2 6B CB FD 38 A4 F1 8B CB 
F2 4B CB F1 8B CB F2 4B CB F1 8B CB F2 4B CB F1 
8B CB F2 4B CB FC E5 A3 E0 58 F1 8B CB F2 4B CB 
E0 56 F1 8B CB F2 4B CB E0 54 F1 8B CB F2 4B CB 
E0 52 F1 8B CB F2 4B CB E0 5A C5 85 9B C6 C2 85 
6B C6 C2 85 9B C6 C2 F3 05 3B C6 C2 FE E3 A3

----------
;A46F - $1E
79 A4 F9 A4 3D A6 FF FF FF FF 
E0 78 F5 02 FF E3 C6 

F1 FB 02 2B 7B 2B 4B 0B F0 9B CB F1 9B F2 0B F1 
4B BB 4B 7B FD 9D A4 9B CB 9B FC 83 A4 F7 0E 01 
EB FB 02 F2 21 75 41 05 25 41 D0 21 45 01 25 FD 
B8 A4 F1 B0 D0 FC A3 A4 F1 B0 D2 C8 BB F2 0B 2B 
4B 6B 8B FB 02 92 D8 48 48 78 95 F3 05 F2 B5 75 
92 D8 45 28 FD E9 A4 42 45 75 73 28 D8 28 28 48 
55 55 45 25 40 80 FC C5 A4 40 92 D8 98 78 58 45 
25 05 25 40 D1 C5 FE A1 A4 F5 02 FF E8 FB 02 F1 
;A500
2B 7B 2B 4B 0B F0 9B CB F1 9B F2 0B F1 4B BB 4B 
7B 9B CB 9B FC FF A4 FB 06 2B 7B 2B 4B 0B F0 9B 
CB F1 9B F2 0B F1 4B BB 4B 7B 9B CB 9B FC 19 A5 
FB 02 2B 7B 2B 4B F0 BB 7B CB F1 9B BB 4B 9B 4B 
7B BB CB BB FC 32 A5 FB 06 2B 7B 2B 4B 0B F0 9B 
CB F1 9B F2 0B F1 4B BB 4B 7B 9B CB 9B FC 49 A5 
4B 7B 4B 6B 2B F0 BB CB F1 9B BB 4B 9B 4B 7B 9B 
CB 9B 4B 8B 4B 6B 2B F0 BB CB F1 9B BB 4B 9B 4B 

8B BB CB BB FB 02 4B 9B BB F2 0B F1 BB 9B CB 4B 
F2 06 F1 B6 98 4B 9B BB F2 0B F1 BB 9B CB 4B 96 
96 F2 08 F1 4B 7B 9B BB 9B 7B CB 4B B6 96 78 4B 
7B 9B BB 9B 7B CB 4B 76 76 B8 FD F4 A5 4B 5B 9B 
F2 0B F1 BB 9B CB 5B F2 06 F1 B6 98 4B 5B 9B F2 
0B F1 BB 9B CB 5B 96 96 F2 08 F1 4B 6B 8B BB 9B 
8B CB 4B B6 96 88 2B 4B 8B BB 9B 8B CB 4B 86 86 
B8 FC 86 A5 FB 02 F1 2B 7B 2B 4B 0B F0 9B CB F1 
;A600
9B F2 2B F1 5B F2 0B F1 5B AB F2 0B CB 0B FC F6 
A5 F1 2B 6B 4B 6B 2B F0 BB CB F1 BB F2 2B F1 6B 
F2 1B F1 6B 9B BB CB BB 4B 8B 6B 8B 2B F0 BB CB 
F1 8B BB 4B 9B 4B 8B BB CB BB FE 17 A5 C0 C0 FB 
02 F1 0D CD 0D CD C5 0D CD 0D CD C8 F0 78 F1 4B 
CB F0 78 F1 0D CD 0D CD C5 0D CD 0D CD C2 F0 9D 
CD 9D CD C5 9D CD 9D CD C8 98 F1 4B CB F0 78 9D 
CD 9D CD C5 9D CD 9D CD C2 F1 5D CD 5D CD C5 5D 

CD 5D CD C8 0B CB F0 95 F1 5D CD 5D CD C5 5D CD 
5D CD C2 4D CD 4D CD C5 4D CD 4D CD C8 F0 B8 F1 
6B CB F0 B8 F1 4D CD 4D CD C5 4D CD 4D CD C2 FC 
41 A6 FB 02 5D CD 5D CD C5 5D CD 5D CD C5 05 5D 
CD 5D CD C5 5D CD 5D CD C8 08 F2 08 F1 08 4D CD 
4D CD C5 4D CD 4D CD C5 F0 B5 F1 4D CD 4D CD C5 
4D CD 4D CD C8 F0 B8 F1 B8 F0 B8 FD 20 A7 F1 2D 
CD 2D CD C5 2D CD 2D CD C8 95 58 2D CD 2D CD C5 
;A700
2D CD 2D CD C8 28 55 1D CD 1D CD C5 1D CD 1D CD 
C8 15 28 4D CD 4D CD C5 4D CD 4D CD C2 FC B4 A6 
F0 FB 02 AD CD AD CD C5 AD CD AD CD C2 FC 23 A7 
BD CD BD CD C5 BD CD BD CD C2 F1 4D CD 4D CD C5 
4D CD 4D CD C2 FE 3F A6

----------
;A748 - $1F
52 A7 CD A7 27 A8 FF FF FF FF 
E0 4C EB F7 04 01 F1 B8 F2 88 68 48 38 48 
F1 88 F2 18 F1 B5 B5 65 F2 15 F1 B3 B8 65 F2 18 
F1 B8 95 42 48 68 73 78 98 78 68 78 B2 85 A8 B8 

A5 F2 45 35 45 61 C5 83 88 F1 B5 F2 35 42 35 15 
F1 B2 D8 B8 F2 18 38 35 45 F1 85 95 B0 C8 88 98 
88 F2 18 F1 B8 98 88 88 98 61 C8 98 B8 98 F2 48 
F1 98 B8 98 82 D8 B8 F2 48 88 31 C8 18 48 18 18 
F1 98 98 68 68 48 42 62 40 C0 FE 58 A7 F6 03 FF 
E7 F1 85 95 B2 60 60 35 C1 43 48 68 43 85 65 42 
65 85 A5 F2 15 45 38 18 F1 B5 95 B3 B8 85 65 92 
B5 95 80 81 45 80 C5 65 55 38 58 60 C8 63 45 65 
;A800
48 F0 88 98 B8 F1 18 38 48 58 63 DB 7E 8E 9E A2 
95 65 45 15 08 F0 B8 98 F1 08 F0 B8 F1 18 38 F0 
B8 F1 40 C0 FE D1 A7 F1 48 B8 F2 48 F1 B8 F2 48 
F1 B8 F2 48 F1 B8 38 B8 F2 38 F1 B8 F2 38 F1 B8 
F2 38 F1 B8 28 B8 F2 28 F1 B8 F2 28 F1 B8 F2 28 
F1 B8 18 98 F2 18 F1 98 F2 18 F1 98 F2 18 F1 98 
08 78 F2 08 F1 78 F2 08 F1 78 F2 08 F1 78 F0 B8 
F1 88 B8 88 B8 88 B8 88 F0 A8 F1 68 A8 68 A8 68 

A8 68 F0 B8 F1 68 B8 68 F0 98 F1 68 98 68 48 B8 
F2 48 F1 B8 F2 48 F1 B8 F2 48 F1 B8 68 F2 18 48 
18 48 18 48 18 F1 38 88 F2 38 F1 88 F2 38 F1 88 
F2 38 F1 88 18 88 F2 18 F1 88 F2 18 F1 88 F2 18 
F1 98 38 88 F2 38 F1 88 F2 38 F1 88 F2 38 F1 88 
28 88 F2 28 F1 88 18 88 F2 18 F1 88 18 98 F2 18 
F1 98 F2 18 F1 98 F2 18 F1 98 08 98 F2 08 F1 98 
F2 08 F1 98 F2 08 F1 98 45 35 15 F0 B5 A2 F1 65 
;A900
15 F2 65 45 15 F1 95 52 F0 B5 F1 35 48 B8 F2 48 
F1 B8 F2 68 F1 B8 F2 48 F1 B8 48 B8 F2 48 F1 B8 
F2 68 F1 B8 F2 48 F1 B8 FE 27 A8 

----------
;A92B - $20
35 A9 BF A9 E1 AA A6 AB 38 AC 
E0 9E EB F5 09 FF F0 5C 8C BC F1 
2C 5C 8C BC F2 2C 5C 8C BC F3 2C C0 C0 F5 12 07 
FB 02 F1 91 B5 F2 01 25 45 95 75 45 68 2B CB C1 
55 05 F1 95 F2 55 FD 7C A9 45 F1 B5 85 F2 45 25 
05 F1 95 F2 05 F1 BB C6 C1 FC 52 A9 F2 45 F1 B5 

85 B5 90 D1 C5 FB 02 F2 22 42 52 22 FD A3 A9 08 
28 48 F1 98 B8 F2 08 C8 08 48 F1 98 B8 F2 08 D2 
FC 87 A9 F1 9B CB BB CB F2 05 F1 BB CB F2 0B CB 
25 0B CB 2B CB 45 28 48 58 98 80 40 FE 50 A9 F5 
09 FF E5 CA F0 5C 8C BC F1 2C 5C 8C BC F2 2C 5C 
8C BC F3 2C C7 C1 F6 10 FF F8 85 EB C2 C8 F1 4B 
4B F0 9B 9B 2B 2B F5 13 FF F8 08 E8 FB 02 F1 08 
48 08 48 28 68 28 68 48 88 48 88 58 88 58 88 7B 
;AA00
4B 0B 4B 9B 4B 0B 4B BB 7B 2B 7B F2 0B F1 7B 4B 
7B F5 09 FF 98 6B CB 9B BB F2 0B 2B 0B F1 BB 9B 
7B 6B 4B 28 9B CB 9B CB C5 F0 9C AC BC F1 0C 2C 
4C 55 8B CB 8B CB C5 F0 8C 9C BC F1 0C 2C 3C 45 
FD 64 AA 5B CB 2B CB 5B CB 2B CB 5B CB 2B CB 5B 
CB 2B CB 4B CB 98 8B CB 58 4B CB 08 F0 BB CB F1 
48 FC EE A9 F5 13 FF 48 58 28 58 08 58 28 58 48 
58 28 58 08 58 28 58 FB 02 F1 58 98 58 98 58 98 

58 98 88 B8 88 B8 88 B8 88 B8 FD AD AA F5 09 FF 
98 48 08 F0 98 F1 88 48 08 F0 88 F1 78 48 08 F0 
78 F1 68 48 08 F0 68 F5 13 FF FC 79 AA F1 08 48 
08 48 28 88 28 88 48 78 48 78 58 98 58 98 B8 48 
88 48 BB F0 BB F1 2B 6B BB 9B 8B 4B F2 08 F1 48 
78 48 F2 2B F1 4B 8B BB F2 2B 0B F1 BB 8B FE EC 
A9 C2 FB 02 F0 FB 06 9B CB FC E7 AA 7B CB 7B CB 
FC E5 AA FB 02 FB 04 F0 98 F1 9B CB FC F7 AA FB 
;AB00
04 F0 88 F1 8B CB FC 01 AB F0 78 F1 7B CB F0 98 
F1 9B CB F0 B8 F1 BB CB 08 F2 0B CB F1 2B CB 2B 
CB C1 5B CB 5B C6 0B CB 52 4B CB 4B C6 F0 BB CB 
F1 42 FD 4D AB B8 F0 B5 F1 05 25 58 4B CB F2 38 
4B CB F1 A8 BB CB 78 8B CB 48 FC F5 AA F0 FB 02 
FB 06 9B CB FC 52 AB 7B CB 7B CB FC 50 AB FB 02 
B2 D8 F2 28 08 F1 B8 42 D8 28 08 F0 B8 FD 7D AB 
FB 04 9B CB 9B CB C5 FC 72 AB FC 60 AB 9B CB 9B 

C6 F1 9B CB F0 BB CB BB CB F1 88 F0 BB CB F1 0B 
CB 0B C6 7B CB 2B CB 2B CB B8 F0 BB CB F1 42 22 
02 F0 B2 FE F3 AA F5 01 FF EF EB C2 C0 C2 C8 9B 
9B 9B 9B 9B 9B FB 02 FB 06 F9 05 FA 05 FC B9 AB 
08 08 C1 FB 02 F9 05 05 05 FA 05 FC C5 AB F9 05 
FA 05 F9 05 FA 05 FD DE AB 05 C1 FC B7 AB F9 05 
FA 05 F9 05 FA 05 FB 02 F9 05 FA 05 F9 05 FA 05 
F9 05 FA 05 F9 08 FA 08 08 08 FD 14 AC FB 02 F9 
;AC00
08 08 C8 FA 08 F9 08 0B 0B FA 08 F9 0B 0B FC FF 
AB FC E8 AB FB 02 F9 08 0B 0B FA 08 F9 0B 0B 08 
0B 0B FA 08 F9 0B 0B FC 16 AC 05 05 05 05 05 05 
08 FA 08 08 08 FE B5 AB C2 05 05 05 05 05 05 08 
0B 06 08 FB 02 FB 03 02 08 03 FC 47 AC C0 FB 03 
03 05 05 08 FC 50 AC 00 FC 45 AC FB 02 03 08 03 
05 05 08 02 FD 71 AC FB 04 08 03 FC 69 AC FC 5D 
AC FB 03 02 08 03 FC 73 AC 03 08 02 FE 43 AC

----------
;AC7F - $21
89 AC DE AC 5B AD FF FF FF FF 
E0 80 F5 07 07 EB C0 
C0 F1 92 D8 68 78 98 FB 02 25 F2 25 65 25 F5 09 
FF 4B C8 0B F5 07 07 02 2B 0B F1 BB F2 0B F1 91 
9B 7B 6B 7B F5 09 FF 9B C8 2B F5 07 07 21 D5 F2 
25 65 25 F5 09 FF 7B C8 4B F5 07 07 42 D8 4B 6B 
72 B2 92 D8 F1 68 78 98 FC 99 AC FE 97 AC F5 02 
FF FB 04 F0 E9 9B CB E3 7B CB E9 BB CB E3 7B CB 
FC E3 AC FB 04 F0 E9 9B CB E3 7B CB E9 BB CB E3 
;AD00
7B CB E9 9B CB E3 9B BB 9B 7B 6B 7B E9 9B CB E3 
7B CB E9 BB CB E3 7B CB E9 9B CB F1 EB 28 F0 E9 
9B CB F1 EB 28 F0 E9 9B CB E3 7B CB E9 BB CB E3 
7B CB E9 9B CB E3 9B BB 9B 7B 6B 7B E9 9B CB E3 
7B CB E9 BB CB E3 7B CB E9 9B CB F1 EB 48 F0 E9 
9B CB F1 EB 48 FC F5 AC FE F3 AC FB 08 F1 0B C6 
FC 5D AD FB 04 F1 2B C6 2B C6 2B C6 2B C6 2B C6 
2B C6 2B CB F0 98 F1 2B CB F0 98 F1 0B C6 0B C6 

0B C6 0B C6 0B C6 0B C6 0B CB F0 98 F1 0B CB F0 
98 FC 65 AD FE 63 AD

----------
;AD97 - $22
A1 AD 05 AE 5D AE FF FF FF FF 
E0 93 F6 03 07 EB C8 C0 F2 43 28 D2 63 43 F1 
9B BB F2 1B 2B 4B C6 4B C6 22 6B CB 65 48 D2 F1 
FB 02 92 D8 B8 F2 18 28 45 68 48 25 F1 85 68 98 
F2 28 68 88 98 88 68 42 D8 18 68 48 23 F1 98 85 
F2 28 08 13 F1 95 65 48 38 68 98 F2 15 18 F1 B8 
98 FD FB AD B5 48 48 D2 FC C2 AD B8 F2 15 25 48 
;AE00
68 88 FE A9 AD F6 03 07 E7 C8 C0 F2 13 F1 B8 D2 
F2 23 13 F1 6B 8B 9B BB F2 1B C6 1B C6 F1 B2 F2 
2B CB 25 18 D2 FB 02 F1 12 22 42 25 55 28 48 68 
98 B2 88 98 88 68 45 28 48 63 48 25 85 43 35 25 
18 F0 38 65 95 B5 F1 18 FD 54 AE F0 88 98 A8 B8 
D2 FC 27 AE 28 15 F0 B5 98 85 FE 0B AE F1 9B CB 
FB 02 F0 9B CB 9B C6 F1 9B CB FC 62 AE FB 05 F0 
9B CB 9B C6 F1 9B CB FC 6F AE F0 98 F2 28 F1 98 

78 68 48 28 15 28 38 48 FB 02 F0 98 F1 4B CB F0 
98 F1 4B CB F0 98 F1 6B CB F0 98 F1 6B CB F0 98 
F1 8B CB F0 98 F1 8B CB F0 B8 F1 8B CB 18 8B CB 
28 9B CB 28 9B CB 48 BB CB 48 BB CB 18 8B CB 18 
8B CB 68 48 28 18 F0 B8 F1 BB CB F0 B8 F1 BB CB 
48 BB CB 48 BB CB F0 98 F1 48 98 65 28 48 68 F0 
B8 F1 15 35 65 98 FD F6 AE 48 68 78 85 F0 B8 F1 
48 F0 B8 FC 8A AE F1 B8 95 85 68 48 28 FE 6D AE 

----------
;AF00 - $23 = The invincible
0A AF 8B AF 2E B0 FF FF FF FF 
;AF0A - CH0
E0 9B EB 
F5 04 07 
F2 22 F1 73 DC BC F2 4C 72 65 45 28 48 68 20 D3 
C5 22 F1 A3 DC F2 2C 7C A2 95 75 58 78 98 55 08 
25 40 F5 02 FF E8 F1 1B 4B 9B F2 1B F1 4B 9B F2 
1B 4B F1 9B F2 1B 4B 9B 1B 4B 9B F3 1B FB 02 F6 
12 07 EB F2 62 11 15 15 65 FD 66 AF 4B 2B 1B 2B 
F1 B0 C1 FC 53 AF 4B 2B 1B 2B 70 C1 92 11 65 75 
95 7B 6B 4B 6B 21 D2 25 45 62 21 25 45 65 7B 6B 

4B 6B 22 6B 4B 2B 6B 40 FE 0D AF 
;AF8B - CH1
E8 
F5 02 FF 
FB 
04 F0 BB CB F1 2B CB 1B CB 2B CB FC 91 AF FB 04 
6B CB 2B CB 1B CB 2B CB FC A0 AF FB 06 5B CB 4B 
CB 2B CB 4B CB FC AD AF FB 02 7B CB 5B CB 4B CB 
5B CB FC BA AF F0 4B 9B F1 1B 4B F0 9B F1 1B 4B 
9B 1B 4B 9B F2 1B F1 4B 9B F2 1B 4B F5 03 07 FB 
02 F0 A3 B8 F1 13 28 43 68 73 48 F0 B3 F1 18 23 
48 63 78 93 B8 FC E1 AF 13 28 43 68 73 98 B3 F2 
;B000
18 4B 2B 1B 2B F1 B2 BB 9B 7B 9B 68 6B 4B 6B 7B 
6B 4B 2B 4B 2B 1B F0 BB F1 1B F0 BB 9B F1 82 62 
42 22 13 28 43 68 73 98 B3 F2 18 FE 8C AF 
;B02E - TRI
FB 08 
F1 7B CB FC 30 B0 FB 08 4B CB FC 38 B0 FB 08 F0 
BB CB FC 3F B0 BB CB BB CB F1 1B CB 1B CB 2B CB 
2B CB 6B CB 6B CB FB 08 F0 AB CB FC 58 B0 FB 08 
F1 7B CB FC 60 B0 FB 08 2B CB FC 68 B0 FB 08 0B 
CB FC 6F B0 FB 08 F0 9B CB FC 76 B0 F1 FB 03 FB 

08 6B CB 18 FC 81 B0 FB 08 7B CB 28 FC 89 B0 FC 
7F B0 FB 08 8B CB 48 FC 94 B0 FB 08 9B CB 48 FC 
9C B0 FE 2E B0

----------
;B0A5 - $24
AF B0 63 B1 01 B2 FF FF FF FF 
E0 
69 F7 08 07 EB FB 02 F1 08 58 68 F2 08 F1 68 58 
38 88 98 F2 38 F1 98 88 68 B8 F2 08 68 08 F1 B8 
98 F2 28 38 98 38 28 FC B7 B0 E0 82 F6 02 FF E9 
FB 10 F2 3D F3 3D FC E2 B0 FB 10 F2 2D F3 2D FC 
EB B0 FB 10 F2 1D F3 1D FC F4 B0 FB 10 F2 0D F3 
;B100
0D FC FD B0 FB 10 F2 3D F3 3D FC 06 B1 FB 10 F2 
2D F3 2D FC 0F B1 FB 10 F2 1D F3 1D FC 18 B1 FB 
10 F2 0D F3 0D FC 21 B1 FB 02 F6 02 FF FB 04 F2 
EE 88 F1 E8 8B CB FC 2F B1 F6 04 07 ED F0 7C BC 
F1 0C 7C 8C F2 2C BC 2C F1 8C 7C 2C F0 9C 8C F1 
0C 1C 8C F2 0C 1C 8C 1C 0C F1 8C 1C 0C FC 2A B1 
FE DC B0 F6 02 FF E8 FB 02 F0 68 68 68 68 68 6C 
7C 8C 98 98 98 98 98 9C AC BC F1 08 08 08 08 08 

0C 1C 2C 38 38 38 38 38 3E 2E 1E 0E F0 BE AE FC 
69 B1 F6 02 FF FB 02 F1 5B CB 3B CB 0B CB 3B CB 
5B CB 3B CB 0B CB 1B CB 3B CB 5B CB 3B CB 0B CB 
1B CB 3B CB 5B CB 3B CB 0B CB 1B CB 3B CB 5B CB 
3B CB 0B CB 3B CB 5B CB 3B CB 0B CB 1B CB 3B CB 
5B CB 3B CB 0B CB 3B CB FC 97 B1 FB 02 F6 02 FF 
E5 F2 FB 04 0E 1E 0E 1E 0E 1E C8 FC E4 B1 E8 F6 
0B 07 FD FB B1 F0 22 02 FC DD B1 F0 22 32 FE 92 
;B200
B1 FB 02 F1 01 31 61 95 DB CB 98 68 38 FC 03 B2 
FB 10 0B CB 3B CB 5B CB 3B CB FC 12 B2 FB 02 FB 
04 68 C8 FC 21 B2 75 F2 28 F1 78 58 F2 15 F1 58 
FC 1F B2 FE 10 B2

----------
;B236 - $25
40 B2 B4 B2 64 B3 FF FF FF FF 
E0 99 F6 0A 01 EB F0 BC F1 0C 2C 4C 6C 8C FB 02 
F1 92 F2 42 25 05 F1 B5 95 73 78 95 B5 90 F6 02 
07 E9 C5 F3 0B F2 9B 5B 0B BB 7B 4B F1 BB F2 9B 
5B 0B F1 9B F6 0A 01 EB F2 42 72 65 75 65 25 40 

C1 F1 BC F2 0C 2C 4C 6C 8C 91 95 42 72 52 45 25 
42 02 22 45 25 F1 92 F2 02 25 45 22 F1 91 F2 05 
22 45 25 F1 92 F2 02 F1 B1 8C 9C BC F2 1C 2C 3C 
40 FE 50 B2 F6 03 07 E8 C5 F1 48 08 F0 98 F1 08 
48 98 48 08 98 58 28 F0 98 F1 58 28 F0 98 F1 28 
48 F0 B8 78 B8 F1 48 F0 B8 F1 48 78 58 08 F0 98 
F1 08 58 08 F0 98 F1 08 58 08 98 08 78 08 58 08 
48 08 F0 78 F1 08 48 08 F0 78 F1 08 68 28 F0 98 
;B300
F1 28 68 28 F0 98 F1 28 48 F0 B8 98 F1 98 48 F0 
B8 F1 98 48 88 48 F0 B8 F1 88 48 F0 B8 F1 48 88 
52 D8 28 48 58 72 D8 48 58 78 92 D8 58 78 98 B5 
95 75 45 FB 02 58 28 48 28 58 28 48 28 48 08 28 
08 48 08 28 08 FC 35 B3 FB 04 58 28 48 28 FC 4A 
B3 68 38 48 38 68 38 48 38 88 28 48 28 98 28 B8 
28 FE B9 B2 C5 F0 90 F1 20 40 50 D5 55 45 25 01 
45 22 62 4B CB 4B CB C5 4B CB 4B CB C5 4B CB 4B 

CB F0 BB CB BB CB F1 2B CB 2B CB 4B CB 4B CB FB 
04 5B CB 08 FC 91 B3 FB 04 F1 4B CB F0 B8 FC 99 
B3 FB 04 F1 2B CB F0 98 FC A3 B3 FB 04 F1 0B CB 
78 FC AD B3 FB 04 2B CB 98 FC B6 B3 FB 04 F0 9B 
CB F1 98 FC BE B3 FB 04 F0 AB CB F1 A8 FC C8 B3 
FB 04 5B CB 08 FC D2 B3 FB 04 F0 BB CB F1 B8 FC 
DA B3 FB 04 F0 AB CB F1 A8 FC E4 B3 FB 04 F0 9B 
CB F1 98 FC EE B3 FB 03 F1 4B CB F0 B8 FC F8 B3 
;B400
F1 8C 6C 4C 2C 0C F0 BC FE 65 B3

----------
;B40B - $26
15 B4 C9 B4 42 B5 FF FF FF FF 
E0 55 F5 02 FF F2 EE 58 EC 58 EA 
58 E8 58 E6 58 E4 58 EE 48 EC 48 EA 48 E8 48 E6 
48 E4 48 EE 78 EC 78 EA 78 E8 78 E6 78 E4 78 EE 
28 EC 28 EA 28 E8 28 E6 28 E4 28 F6 0A 01 EB FB 
02 F1 BF 9E DD 7B 5B 7B 9B BB F2 2F 0E DD F1 BB 
9B BB F2 0B 2B 5F 4E DD 2B 0B 2B 4B 5B 9F 7E DD 
5B 4B 5B 7B 9B BB 7B 4B F3 0B F2 BB 7B 4B 2B 0B 

5B 4E 5E 4E 0B F1 BB 7B 4B F2 0B F1 BB 7B 4B 2B 
0B 5B 4E 5E 4E 0B FC 51 B4 F2 2B 0B F1 AB 9B AB 
F2 0B 21 C6 2B 4B 5B 7B 5B 4B 2B 4B 5B 71 C6 4B 
5B 7B 5B 4B 2B 0B 2B 4B 78 2B CB 2B CB AB 9B 7B 
5B 4B 5B E0 3C 73 FE 15 B4 F5 02 FF F2 EB 28 E9 
28 E7 28 E5 28 E3 28 E1 28 EB 08 E9 08 E7 08 E5 
08 E3 08 E1 08 EB 48 E9 48 E7 48 E5 48 E3 48 E1 
48 F1 EB A8 E9 A8 E7 A8 E5 A8 E3 A8 E1 A8 F5 0F 
;B500
07 E8 FB 02 F1 23 53 93 F2 23 03 F1 73 F2 43 73 
FC 04 B5 F7 0A 01 F1 51 9B 7B 5B 4B 5B 7B 93 A1 
F2 0B F1 AB 9B 7B 9B AB F2 03 F1 9B 7B 5B 4B 5B 
7B B8 7B CB 7B CB F2 2B 0B F1 AB 9B 7B 9B A3 FE 
C9 B4 C0 C0 C0 FB 02 F1 28 98 D2 58 F2 08 D2 F1 
48 F2 08 D2 F1 08 78 D2 FC 47 B5 F0 A8 F1 58 A8 
F2 23 F0 A3 D5 F1 58 F0 78 F1 28 78 A3 08 78 F2 
08 43 F1 58 98 F2 08 F1 78 28 F0 B8 A8 F1 58 A8 

F2 03 FE 42 B5

----------
;B585 - $27
8F B5 E6 B5 75 B6 FF FF FF FF 
E0 
8A F5 12 07 EB FB 02 C5 F2 2B CB 4B CB 55 25 75 
58 48 55 25 C5 F1 AB CB F2 0B CB 25 F1 A5 FD BC 
B5 C5 F2 2B CB 4B CB 55 25 FC 97 B5 F2 C5 5B CB 
7B CB 95 55 FB 02 C5 4B CB 5B CB 75 95 A5 98 78 
45 95 FD DD B5 75 58 20 D3 C5 FC C6 B5 72 D8 78 
98 78 40 FE 95 B5 F6 02 FF E7 FB 02 FB 04 F1 9B 
5B 4B 5B FC EE B5 FB 02 BB 5B 4B 5B FC F8 B5 9B 
;B600
5B 4B 5B 9B 5B 7B 4B FB 03 5B 2B 0B 2B FC 09 B6 
5B 2B 7B 4B FB 04 9B 5B 4B 5B FC 16 B6 FC EC B5 
FB 02 F1 43 2C 3C 4C 53 4C 5C 6C 73 9C AC BC F2 
05 F1 75 FD 68 B6 5B 2B 7B 2B 9B 2B 5B 2B 4B 0B 
5B 0B 7B 0B 4B 0B 2B F0 AB F1 4B F0 AB F1 5B F0 
AB F1 2B F0 AB F1 5B F0 BB F1 7B F0 BB F1 9B F0 
BB F1 5B F0 BB FC 22 B6 A5 98 75 58 38 28 15 25 
45 95 FE EA B5 FB 02 FB 04 F1 2B CB F0 9B CB FC 

79 B6 FB 02 F1 2B CB F0 BB CB FC 84 B6 F1 2B CB 
F0 9B CB F1 2B CB 0B CB FB 03 F0 AB CB F1 5B CB 
FC 9A B6 F0 AB CB F1 0B CB FD BA B6 FB 04 F1 2B 
CB F0 9B CB FC AE B6 FC 77 B6 FB 04 5B CB 0B CB 
FC BC B6 FB 02 F1 FB 04 0B CB 7D CD 7D CD FC C8 
B6 FB 04 F1 4B CB F0 A8 FC D3 B6 FD FF B6 F1 2B 
CB 2B CB C8 2B CB 0B CB 0B CB C8 0B CB F0 AB CB 
AB CB C8 AB CB BB CB BB CB C8 BB CB FC C5 B6 FB 
;B700
04 F1 3B CB F0 A8 FC 01 B7 FB 04 F0 9B CB F1 4B 
CB FC 0B B7 FE 75 B6

----------
;B717 - $28
21 B7 51 B8 27 B9 BA B9 66 BA 
E0 A3 F6 13 FF E8 FB 08 F1 9E 4E F0 9E FC 29 
B7 FB 08 F2 0E F1 7E 0E FC 33 B7 FB 08 F1 BE 6E 
F0 BE FC 3D B7 FB 08 F2 2E F1 9E 2E FC 47 B7 FB 
08 F2 0E F1 7E 0E FC 51 B7 FB 08 F2 4E F1 BE 4E 
FC 5B B7 FB 08 F2 2E F1 9E 2E FC 65 B7 FB 08 F2 
5E 0E F1 5E FC 6F B7 FB 08 F1 9E 4E F0 9E FC 79 

B7 FB 08 F2 0E F1 7E 0E FC 83 B7 FB 08 F1 BE 6E 
F0 BE FC 8D B7 FB 08 F2 2E F1 9E 2E FC 97 B7 FB 
04 F2 0E F1 7E 0E FC A1 B7 FB 04 F2 4E F1 BE 4E 
FC AB B7 FB 04 F2 2E F1 9E 2E FC B5 B7 FB 04 F2 
5E 0E F1 5E FC BF B7 FB 04 F2 4E F1 BE 4E FC C9 
B7 FB 04 F2 9E 4E F1 9E FC D3 B7 FB 04 F2 8E 3E 
F1 8E FC DD B7 FB 04 F2 BE 6E F1 BE FC E7 B7 F6 
12 07 EB FB 02 F1 BE F2 0C DB F1 88 98 F2 08 48 
;B800
78 6C 7C 6C 28 7E 5C DB 48 38 48 D2 FC F5 B7 FB 
02 8E 9C DB 48 58 98 BE F3 0C DB F2 B5 88 A8 9B 
AD 9D 88 98 D2 FC 11 B8 88 C5 85 48 68 88 95 75 
55 45 23 05 28 05 F1 B0 F2 28 C5 25 F1 B8 F2 08 
28 45 25 05 45 58 C5 55 38 68 B8 93 88 D2 FE 23 
B7 F6 10 FF F8 85 ED C2 F1 45 F0 95 C5 95 22 C2 
F1 45 F0 95 F6 13 FF F1 4C EC 4C EB 4C EA 4C E9 
4A ED F0 9C EC 9C EB 9C EA 9C E9 9A ED F6 10 FF 

F1 47 F0 97 27 C2 F1 45 F0 95 C5 95 22 C5 F1 45 
C5 45 F8 08 F5 02 07 E8 F0 BB F1 0B 2B 4B 0B 2B 
4B 5B 2B 4B 5B 8B 4B 6B 8B BB FB 08 4B 0B 2B F0 
BB F1 0B F0 BB F1 0B 2B FC AC B8 FB 08 9B 5B 7B 
4B 5B 4B 5B 7B FC BD B8 B8 C5 F2 45 28 08 F1 B8 
F2 5B 0B F1 9B CB F2 4B 1B F1 AB CB F2 2B F1 9B 
5B CB F2 0B F1 7B 4B CB 53 68 D2 73 88 D2 98 58 
78 95 98 58 B8 F2 08 F1 98 B8 78 98 48 98 F2 08 
;B900
F1 98 AB BB F2 08 25 08 F1 B8 F2 38 1E 2C DB 0B 
F1 BB BE F2 0C DB F1 BB 9B AE BC BB 9B 8B 3E 4C 
2B F0 BB 8B FE 51 B8 FB 38 F0 9B CB FC 2A B9 95 
F1 98 85 58 48 28 FB 04 F0 98 C5 95 F1 08 28 48 
FC 38 B9 FB 04 F1 28 C5 25 F0 98 F1 08 18 FC 45 
B9 FB 04 F1 4B CB F0 B8 FC 53 B9 F1 55 75 98 58 
48 08 F0 B5 F1 BB CB 05 F2 0B CB F1 08 F2 0B CB 
F1 25 F2 2B CB F1 45 F2 4B CB F1 48 F2 4B CB F1 

5B CB 08 5B CB 08 5B CB 08 5B CB 08 F0 98 F1 9B 
CB F0 B8 F1 BB CB 08 F2 0B CB F0 98 F1 9B CB 58 
4B 2B 08 F0 B5 F1 BB CB F0 B8 F1 BB CB 48 F0 B8 
F1 08 28 48 68 88 48 FE 27 B9 F9 02 F5 01 FF EF 
ED 95 95 F9 05 F5 01 FF EF ED 95 92 F9 02 F5 01 
FF EF ED 95 95 9C EC 9C EB 9C EA 9C E9 9A ED 9C 
EC 9C EB 9C EA 9C E9 9A ED 97 97 97 F9 02 F5 01 
FF EF ED 95 95 F9 05 F5 01 FF EF ED 95 92 FB 02 
;BA00
F9 05 F5 01 FF EF ED 95 FC 00 BA FB 02 F9 05 FA 
05 FC 0D BA FB 08 F9 05 FA 08 F9 05 08 FA 08 F9 
08 FC 16 BA FB 02 F9 05 08 FA 05 F9 08 FA 08 F9 
08 05 FA 05 F9 05 FA 05 F9 08 08 FA 08 F9 08 08 
FA 08 F9 08 08 FD 5C BA FA 08 F9 08 FA 08 F9 08 
FA 08 F9 08 FA 0B 0B F9 08 FC 26 BA 05 05 08 FA 
08 08 08 FE BA B9 FB 03 01 05 00 FC 68 BA FB 08 
05 FC 70 BA FB 08 03 02 08 FC 76 BA FB 02 03 08 

D2 03 05 05 08 03 08 D2 FD 94 BA C8 05 08 08 05 
08 FC 7E BA 03 08 02 FE 66 BA

----------
;BA9A - $29
A4 BA 02 BB 22 BC FF FF FF FF 
E0 A0 EB F7 0A 01 FB 02 F1 B1 D8 F2 
1E 2E 4E 6E 8E AE B0 92 42 D0 F1 B1 D8 F2 1D 2D 
4D 6D 70 FD CC BA 62 12 D0 FC AC BA 60 D1 F6 12 
01 1C 2C 4C 6C 7C 9C F2 B0 72 B2 F3 18 28 15 F2 
92 D0 90 62 92 75 68 28 D2 D2 25 45 60 45 25 15 
F1 95 B0 C2 F2 25 45 60 45 25 15 F1 95 B0 A0 FE 
;BB00
A7 BA F6 02 FF E8 FB 08 F0 BA F1 2A 6A FC 08 BB 
FB 04 1A 4A 9A FC 12 BB F0 9A F1 1A 4A 1A 4A 9A 
F2 1A F1 9A 4A 9A 4A 1A FB 08 F0 BA F1 2A 7A FC 
2A BB FB 04 F0 9A F1 1A 6A FC 34 BB FB 04 F0 AA 
F1 1A 6A FC 3E BB FB 08 F0 BA F1 2A 6A FC 48 BB 
FB 04 1A 4A 9A FC 52 BB F0 9A F1 1A 4A 1A 4A 9A 
F2 1A F1 9A 4A 9A 4A 1A FB 08 F0 BA F1 2A 7A FC 
6A BB FB 04 F0 9A F1 1A 6A FC 74 BB FB 04 F0 AA 

F1 1A 6A FC 7E BB FB 04 BB CB 78 8F 9E D9 78 FC 
88 BB FB 04 F2 1B CB F1 98 AF BE D9 98 FC 94 BB 
FB 04 9B CB 68 7F 8E D9 68 FC A2 BB FB 03 BB CB 
78 8F 9E D9 78 FC AE BB BB 7B 2B 7B F2 1B F1 9B 
4B 9B FB 02 B8 28 68 28 B8 28 68 28 98 18 48 18 
98 18 48 18 FD FC BB 78 F0 B8 F1 28 F0 B8 F1 78 
F0 B8 F1 28 F0 B8 F1 78 F0 B8 F1 28 F0 B8 F1 7B 
2B F0 BB F1 2B 9B 4B 1B 4B FC C4 BB 78 F0 B8 F1 
;BC00
48 F0 B8 F1 78 F0 B8 F1 48 F0 B8 F1 68 F0 A8 F1 
18 68 AB 1B 6B AB F2 1C F1 6C AC F2 1C 6C AC FE 
06 BB FB 02 F0 B0 D0 90 D0 F1 70 D0 60 FD 39 BC 
42 D8 28 18 F0 A8 FC 24 BC F1 45 25 15 F0 A5 FB 
04 F1 7B CB 7B C6 28 FC 41 BC FB 04 9B CB 9B C6 
48 FC 4C BC FB 04 6B CB 6B C6 18 FC 56 BC FB 03 
7B CB 7B C6 28 FC 60 BC 7B CB 28 9B CB 18 FB 04 
F0 B8 F1 6B CB FC 70 BC FB 04 F0 98 F1 4B CB FC 

7A BC FB 07 78 2B CB FC 84 BC 98 4B CB FB 04 F0 
B8 F1 6B CB FC 8F BC FB 04 F0 98 F1 4B CB FC 99 
BC 0B CB 0B C6 0B CB 0B CB 0B C6 0B CB 6B CB 6B 
CB 4B CB 4B CB 2B CB 2B CB 1B CB 1B CB FE 22 BC 

----------
;BCC0 - $2A
CA BC 8B BD 98 BE 61 BF B7 BF 
E0 A5 CB F6 02 FF 
EB FB 02 C8 F2 38 4B CB 0B CB F1 9B CB 8B CB 9B 
CB F2 0B CB 48 7B CB 6B CB 2B CB 5B CB 45 0B CB 
FC D3 BC FB 02 C8 88 9B CB 5B CB 2B CB 1B CB 2B 
;BD00
CB 5B CB 98 F3 0B CB F2 BB CB 7B CB AB CB 95 5B 
CB FC F5 BC F7 0A 05 F3 45 05 F2 95 55 45 05 F1 
95 55 45 05 F0 95 55 4A 5A 8A F1 0A 4A 5A 8A F2 
0A 4A 5A 8A F3 0A F6 02 FF F1 28 58 28 58 98 88 
C8 58 28 58 98 88 58 88 F2 08 F1 B8 98 F2 08 F1 
98 F2 08 48 38 C8 08 F1 98 F2 08 78 68 28 58 F3 
08 F2 B8 F5 12 07 EC FB 02 91 D8 9B BB 92 72 92 
72 D0 FD 80 BD 51 D8 5B 7B 52 22 40 80 FC 69 BD 
91 D8 9B AB 92 72 90 80 FE CD BC F6 02 FF E8 CD 
CE F1 2F FB 02 38 FB 07 0B CB FC 98 BD 08 2B CB 
4B CB 6B CB 7B CB 95 FD B1 BD AB CC CF 2F FC 95 
BD AB CC CF 7F FB 02 88 FB 07 5B CB FC BA BD 58 
7B CB 9B CB BB CB F2 0B CB 25 3B CC CF F1 7F FC 
B7 BD F7 0A 05 F2 95 55 45 05 F1 95 55 45 05 F0 
95 55 45 05 0A 2A 5A 8A F1 0A 2A 5A 8A F2 0A 2A 
5A 8A F6 10 FF F8 85 EB F1 FB 03 C5 48 48 C5 45 
FC FB BD C5 45 4B 4B F0 98 9B 9B 28 E8 F8 08 F6 
02 FF FB 02 FB 02 F2 08 F1 7C 8C 9C F2 28 F1 98 
F2 08 F1 98 F2 28 F1 98 FC 16 BE FB 02 B8 7C 9C 
AC B8 78 98 78 B8 78 FC 2D BE FD 63 BE FB 02 98 
3C 4C 5C B8 58 98 58 B8 58 FC 3F BE 78 2C 3C 4C 
98 48 78 48 98 48 88 2C 3C 4C 88 48 98 48 B8 48 
FC 14 BE 98 28 58 28 98 28 58 28 F2 08 F1 28 78 
28 F2 08 F1 28 78 28 F2 28 F1 48 98 48 F2 28 F1 
48 98 48 F2 28 F1 B8 88 58 4B 6B 8B 9B BB F2 0B 
2B 4D DE F1 2F FE 93 BD CB FB 20 F0 9B CB FC 9B 
BE FB 20 F1 2B CB FC A3 BE F0 91 F1 2C 3C 4C D8 
90 F0 9B CB 9B CB C5 9B CB 9B CB C5 85 F1 25 55 
85 28 58 28 58 98 88 C8 58 28 58 98 88 58 88 F2 
08 F1 B8 98 F2 08 F1 98 F2 08 48 38 C8 08 F1 98 
F2 08 78 68 28 58 F3 08 F2 B8 FB 02 FB 04 F1 5B 
CB 5B CB F0 BB CB F1 0B CB FC EE BE FB 04 4B CB 
4B CB 2B CB 3B CB FC FE BE FD 33 BF FB 04 2B CB 
2B CB 0B CB 1B CB FC 0E BF FB 08 0B CB FC 1B BF 
4B CB 4B CB 4B CB 6B CB 6B CB 6B CB 8B CB 8B CB 
FC EC BE FB 02 F0 AB CB AB CB F1 5B CB AB CB FC 
35 BF FB 02 3B CB 3B CB 7B CB AB CB FC 44 BF FB 
04 4B CB 4B CB F0 BB CB F1 2B CB FC 51 BF FE 99 
BE CB F9 FB 20 05 FC 65 BF FB 03 F9 05 05 05 FA 
05 FC 6B BF FB 02 F9 08 0B 0B FA 08 F9 0B 0B FC 
76 BF FB 03 F9 05 F5 01 FF EF EB 98 98 F9 05 F5 
01 FF EF EB 95 FC 84 BF F9 05 F5 01 FF EF EB 95 
9B 9B 98 9B 9B 98 FB 20 F9 08 0B 0B FA 08 F9 0B 
0B FC A8 BF FE 62 BF CB FB 20 05 FC BA BF FB 04 
03 08 02 FC C0 BF FB 08 08 03 FC C8 BF FB 40 05 
FC CF BF FE B8 BF 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

;$2B-$36
8C8F	;8F 8C
8CD2	;D2 8C
8D1A	;1A 8D
8DA2	;A2 8D
8F76	;76 8F
9128	;28 91
9148	;48 91
919C	;9C 91
91C3	;C3 91
9201	;01 92
9220	;20 92
924A	;4A 92

----------
;8C8F - $2B
99 8C B5 8C C9 8C FF FF FF FF 
F6 02 FF EB E0 5A F1
48 78 F2 08 48 78 28 98 58 E0 55 78 38 E0 50 08
38 E0 4B 72 FF F6 02 FF E8 F0 78 F1 08 48 98 A8
78 58 28 05 38 08 F0 B2 FF F1 05 55 35 A5 85 55
72 FF

----------
;8CD2 - $2C
DC 8C F6 8C 13 8D FF FF FF FF 
E0 89 F7 0A
01 EC F1 B5 2A 7A BA F2 25 F1 B5 E0 83 F2 75 E0
71 5A 3A 0A 22 FF F6 0B 07 E7 F1 7A 2A 0A F0 B5
;8D00
F1 5A 2A 5A 7A 2A F0 BA F1 0A 3A 7A 8A AA F2 0A
F1 B2 FF F1 72 52 85 55 72 FF

----------
;8D1A - $2D
24 8D 57 8D 84 8D FF FF FF FF 
E0 BE EB F7 12 07 F0 AB BB AB BB A1
D2 F2 4B 5B 4B 5B 45 FB 04 F6 12 07 F2 A8 78 48
18 F1 A8 78 48 18 F3 08 F2 98 68 38 08 F1 98 68
38 FC 39 8D FE 27 8D EB F7 12 07 C2 F1 4B 5B 4B
5B 45 D0 FB 04 F6 12 07 F2 48 18 F1 A8 78 48 18
F0 A8 78 F2 68 38 08 F1 98 68 38 08 F0 98 FC 65

8D FE 58 8D C0 F2 AB BB AB BB A1 FB 04 F1 18 C5
18 C8 18 C8 18 08 C5 08 C8 08 C8 08 FC 8D 8D FE
84 8D

----------
;8DA2 - $2E
AC 8D 21 8E D4 8E FF FF FF FF 
E0 87 F6 12
07 EB FB 02 F1 71 95 A1 F2 05 15 F1 95 B5 F2 35
15 F1 95 F2 35 F1 B5 FC B4 8D F2 10 C0 F1 61 85
91 F2 05 F1 B5 85 95 F2 05 F1 B5 85 95 F2 05 F1
B1 F2 05 21 45 55 25 45 75 55 45 25 05 FB 02 22
F1 75 BA F2 2A 5A FD 00 8E 4A CA 0A 01 FC EF 8D
;8E00
4A CA 0A 02 0A 4A 7A 6A CA 2A 22 F1 BA F2 2A 6A
4A CA 0A 02 F1 9A F2 0A 4A 32 02 F1 B2 92 FE B2
8D F6 02 FF E7 FB 02 F1 45 F0 9A AA BA 7A CA 7A
F1 45 65 F0 8A 9A AA 6A CA 6A F1 65 45 4A 4A 4A
35 65 45 4A 4A 4A 65 35 FC 27 8E F5 09 FF FB 02
5A 3A 1A 0A 1A 3A F0 AA F1 0A 1A F0 8A F1 1A 3A
FC 50 8E F6 02 FF F0 9A BA F1 1A 3A 1A F0 BA 9A
BA F1 1A 3A 1A F0 BA F1 0A 2A 4A 5A 4A 2A 0A 2A

4A 5A 4A 2A 8A 6A 4A 25 6A 4A 2A 05 8A 6A 4A 25
5A 4A 2A 05 75 F0 BA F1 0A 2A 75 45 65 F0 BA F1
1A 2A 65 25 F2 25 F1 95 75 4A 7A AA 95 75 55 45
FB 02 F0 B5 F1 05 25 55 05 25 45 75 FC B2 8E 25
45 55 65 75 45 05 F0 B5 93 B8 F1 03 28 33 48 65
35 FE 25 8E FB 02 F1 48 C8 F0 B5 F1 48 C8 F0 B5
F1 38 C8 F0 A5 F1 38 C8 F0 A5 95 F1 9A 4A 1A F0
BA CA BA CA F1 B7 F0 95 F1 9A 4A 1A F0 BA CA BA
;8F00
CA F1 B7 FC D6 8E FB 02 17 CA 17 CA 1A CA 1A CA
1A CA FC 08 8F 68 C8 15 68 C8 15 58 C8 05 58 C8
05 47 CA 47 CA 2A CA 2A CA 27 47 CA 47 CA 5A CA
5A CA 57 78 C8 25 78 C8 F0 B5 F1 68 C8 25 68 C8
F0 B5 F1 58 C8 F0 B5 F1 18 C8 95 25 45 55 65 FB
04 75 DA CA 7C CC 75 D7 CA FC 51 8F 27 CA 27 CA
27 CA 27 CA 07 CA 07 CA 07 CA 07 CA F0 B1 F1 35
62 F0 B2 FE D4 8E

----------
;8F76 - $2F
80 8F E6 8F 43 90 FF FF FF FF

E0 6E F7 0E 01 EB F1 BD F2 1D 3D 4D 6C 7C 9C FB
02 B0 D2 98 78 68 B8 40 D2 68 78 68 28 F1 B2 F2
B5 95 F3 22 F2 B5 95 FD B8 8F B0 C1 F1 BD F2 1D
3D 4D 6C 7C 9C FC 91 8F 72 95 75 61 F1 B5 F2 72
55 45 32 F1 B2 F2 52 45 25 11 F1 95 F2 42 35 15
05 F1 85 F2 05 15 30 F1 B2 D8 C8 BD F2 1D 3D 4D
6C 7C 9C FE 8F 8F F7 0E 02 E5 CB F1 BD F2 1D 3D
4D 6C 7C 9C FB 02 B0 D2 98 78 68 B8 40 D2 68 78
;9000
68 28 F1 B2 F2 B5 95 F3 22 F2 B5 95 FD 1D 90 B0
C1 F1 BD F2 1D 3D 4D 6C 7C 9C FC F6 8F 72 95 75
61 C6 E6 F1 A2 95 75 60 92 75 55 40 82 65 45 35
05 35 45 60 31 CB E5 F1 BD F2 1D 3D 4D 6C 7C 9C
FE F4 8F C5 FB 02 F1 48 B8 F2 48 68 78 B8 F3 48
78 F1 28 98 F2 28 48 68 98 F3 28 68 F1 08 78 F2
08 28 48 78 F3 08 48 F1 28 98 F2 28 48 68 98 F3
28 68 F1 08 78 F2 08 28 48 78 F3 08 48 FD A7 90

F0 B8 F1 68 B8 F2 18 28 68 B8 F3 28 F0 98 F1 48
98 B8 F2 08 48 98 F3 08 F0 B8 F1 68 B8 F2 18 38
68 B8 F3 38 FC 46 90 F1 58 98 F2 08 58 78 98 F3
08 58 F0 A8 F1 58 A8 F2 08 28 58 A8 F3 28 F0 B8
F1 68 B8 F2 18 38 68 B8 F3 38 F0 A8 F1 58 A8 F2
28 58 28 F1 A8 58 F0 B8 F1 68 B8 F2 38 68 38 F1
B8 68 28 98 F2 28 58 98 58 28 F1 98 F0 98 F1 48
98 F2 18 48 18 F1 98 48 18 88 F2 18 48 88 48 18
;9100
F1 88 F0 88 F1 38 88 F2 08 38 08 F1 88 38 F0 B8
F1 68 B8 F2 38 68 38 F1 B8 68 F2 B8 68 38 F1 B8
98 68 38 F0 B8 FE 44 90

----------
;9128 - $30
32 91 3B 91 FF FF 40 91 FF FF 
F6 1A FF F8 C4 F4 90 D5 FF E7 C6 FE 32 91
F5 1B FF F0 C0 C2 09 FF

----------
;9148 - $31
52 91 6B 91 82 91 8C 91 FF FF 
F5 19 FF F8 8F F2 E6 04 E7 04 E8 04 E9 04
EA 04 EB 04 EC 04 ED 04 EE 04 FF F5 19 FF F8 8F
F2 E7 14 E8 14 E9 14 EA 14 EB 14 EC 14 ED 14 EE

14 FF F4 C2 04 C2 0B C7 02 C2 04 FF F5 16 FF F0
20 10 00 EF 55 92 F5 0B FF 90 D0 FF

----------
;919C - $32
A6 91 B4 91 FF FF B9 91 FF FF 
F7 1D 0B F4 48 AB 06 48 AB 06
48 AB 06 FF CC E7 FE A6 91 F5 15 FF EF B5 95 75
A5 85 FF

----------
;91C3 - $33
CD 91 DA 91 E5 91 F0 91 FF FF 
F6 1E 0C
F4 CE 58 C9 53 CE 58 C9 53 FF F6 1E 0C F3 EB 13
DB C5 13 DB FF F5 FF 0C F4 CC 25 24 CC 25 24 FF
F5 14 FF EF FB 02 89 89 69 69 49 A9 99 FC F6 91
;9200
FF

----------
;9201 - $34
0B 92 15 92 FF FF FF FF FF FF 
F7 1C FF F8 B5
F2 54 43 32 FF F7 1C FF F8 B5 F1 14 03 F0 B2 FF

----------
;9220 - $35
2A 92 2C 92 FF FF 3D 92 FF FF 
EB C9 F5 24 FF F8
B5 F1 2A F2 25 F1 2A F2 25 C1 FE 31 92 EA F5 1A
FF F0 0B EF 6D 2A C8 FE 41 92

----------
;924A - $36
54 92 BD 92 FF FF FF FF FF FF 
E0 5F EB F6 02 FF FB 02 F0 5B 8B BB
F1 3B 5B 8B BB F2 3B 5B 8B BB F3 3B F3 5B 8B BB
F4 3B F0 2B 6B 8B F1 1B 2B 6B 8B BB F2 2B 6B 8B
F3 1B 2B 6B 8B BB FC 5C 92 FB 02 F0 9B F1 0B 4B
6B 9B F2 0B 4B 6B 9B F3 0B 4B 6B F3 9B F4 0B 4B
6B F0 8B BB F1 2B 6B 8B BB F2 2B 6B 8B BB F3 2B
6B F3 8B BB F4 2B 6B FC 8B 92 FE 5A 92 F6 02 00
E5 C8 FE 5A 92

;$37-$3A
B3B6	;B6 B3
B876	;76 B8
BA82	;82 BA
BABF	;BF BA

----------
;B3B6 - $37
C0 B3 C8 B4 F9 B6 FF FF FF FF
E8 F5 02 07 E0 91 F1 BB F2 1B F1 BB CB BB F2 1B
F1 BB CB BB F2 1B 2B 1B 2B 4B 2B 1B F1 BB CB BB
F2 1B F1 BB CB BB F2 1B F1 BB CB BB F2 1B 2B 1B
2B 4B 2B 1B F1 BB 9B BB F2 1B F1 BB CB BB F2 1B
;B400
2B 1B 2B 4B 2B 1B F1 BB CB BB F2 1B F1 BB CB BB
F2 1B F1 BB F2 1B 2B 1B F1 BB 9B BB F2 1B EC F5
04 07 F2 92 22 F3 22 15 F2 B5 98 B8 F3 18 F2 98
D2 D1 C5 92 52 F3 52 45 25 08 28 48 05 F2 78 95
B0 C0 F6 0A 07 F3 22 F2 92 F3 45 25 05 F2 B5 F3
02 F2 72 D1 C5 F3 02 F2 72 F3 25 05 F2 B5 95 B2
72 D2 F7 0A 07 75 95 A2 32 F3 75 55 35 25 12 F2
92 F3 92 F2 95 A5 F3 02 F2 72 F3 75 55 35 25 12

F2 92 F3 92 F5 07 07 F2 65 75 92 D8 68 28 18 05
B2 95 70 D2 45 65 72 D8 28 08 F1 A8 95 F2 92 75
63 28 62 D1 C5 63 28 62 D2 65 85 93 68 92 D1 C5
93 58 92 D2 95 B5 F3 03 F2 98 F3 02 D2 F2 75 95
B0 D1 C5 C0 C0 FE 1F B4 E8 F5 02 07 F1 7B 9B 7B
CB 7B 9B 7B CB 7B 9B BB 9B BB F2 1B F1 BB 9B 7B
CB 7B 9B 7B CB 7B 9B 7B CB 7B 9B BB 9B BB F2 1B
F1 BB 9B 7B 6B 7B 9B 7B CB 7B 9B BB 9B BB F2 1B
;B500
F1 BB 9B 7B CB 7B 9B 7B CB 7B 9B 7B 9B BB 9B 7B
6B 7B 9B F5 02 07 F1 6B 7B 6B CB 6B 7B 6B CB 6B
CB 6B 7B 9B 7B 6B 4B 6B 4B 6B 7B 6B CB 6B 7B 6B
CB 6B 7B 6B 4B 6B 7B 9B BB 9B CB 9B BB 9B CB 9B
CB 9B BB F2 1B F1 BB 9B 8B 9B 6B 9B F2 1B 6B F1
9B F2 1B 6B 9C 6C 1C F1 9C 6C 1C F2 6C 1C F1 9C
6C 1C F0 9C F1 9B BB 9B CB 9B BB 9B CB 9B CB 9B
BB F2 0B F1 BB 9B 7B 9B 7B 9B BB 9B CB 9B BB 9B

CB 9B BB 9B 7B 9B BB F2 0B 2B 0B CB 0B 2B 0B CB
0B CB 0B 2B 4B 2B 0B F1 9B BB F2 0B F1 BB CB BB
F2 0B F1 BB CB BB CB BB F2 0B 2B 0B F1 BB 9B BB
2B 6B BB F2 2B F1 6B BB F2 2B 6B F1 BB F2 2B 6B
BB 2B 6B BB F1 93 78 53 48 25 45 55 75 4B 5B 4B
CB 4B CB 4B 5B 4B 6B 7B 9B BB F2 0B 2B 4B 5B 7B
5B CB 5B CB 5B 7B 9B 7B 5B 4B 2B 1B F1 BB 9B 73
58 33 28 05 25 35 55 2B 4B 2B CB 1B 2B 1B CB F0
;B600
BB F1 1B F0 BB 9B BB F1 1B 2B 4B F2 2B 4B 2B CB
1B 2B 1B CB F1 BB F2 1B F1 BB 9B BB F2 1B 2B 4B
F5 0A 07 F0 FB 04 7B AB 9B AB FC 26 B6 F1 AB F2
3B F1 AB 7B AB F2 2B F1 AB 7B AB F2 0B F1 AB 7B
AB 7B 3B 7B 55 35 15 F0 B5 9B F1 1B 3B 7B 9B F2
1B 3B 7B 92 F0 FB 04 7B AB 9B AB FC 57 B6 F1 AB
F2 3B F1 AB 7B AB F2 2B F1 AB 7B AB F2 0B F1 AB
7B AB 7B 3B 7B 55 35 15 F0 B5 9B F1 1B 3B 7B 9B

F2 1B 3B 7B 92 F1 62 D8 08 28 48 65 25 45 65 F2
22 D8 F1 B8 78 68 45 B2 25 A2 D8 28 38 48 12 45
75 90 D2 F0 6B 7B 9B AB BB F1 1B 2B 4B 60 D2 45
25 10 D2 F0 9B BB F1 1B 2B 4B 6B 7B 8B 90 D2 75
55 40 D2 45 65 FB 04 2B 7B 9B BB FC C7 B6 FB 04
2B 5B 8B BB FC D0 B6 FB 04 F1 4B 9B BB F2 1B FC
D9 B6 4B 1B F1 AB 7B F2 1B F1 AB 7B 4B AB 7B 4B
1B 7B 4B 1B F0 AB FE 13 B5 C0 C0 C0 C0 F1 FB 08
;B700
2B CB FC 00 B7 F0 FB 08 BB CB FC 08 B7 F1 FB 08
6B CB FC 10 B7 F2 1B F1 9B F2 1B 6B 9B 1B 6B 9B
F3 1C F2 9C 6C 1C F1 9C 6C F2 9C 6C 1C F1 9C 6C
1C FB 08 5B CB FC 33 B7 FB 08 2B CB FC 3A B7 FB
08 9B CB FC 41 B7 FB 08 7B CB FC 48 B7 FB 08 6B
CB FC 4F B7 FB 04 5B CB 0B CB FC 56 B7 FB 04 7B
CB 2B CB FC 5F B7 05 F2 05 F1 B5 F0 B5 A5 F1 A5
95 F0 95 F1 FB 04 3B CB 7B CB FC 76 B7 FB 04 5B

CB 0B CB FC 7F B7 FB 08 7B CB 2B CB FC 88 B7 FB
08 3B 2B 3B 7B FC 91 B7 FB 08 3B 1B 3B 7B FC 9A
B7 FB 08 3B 2B 3B 7B FC A3 B7 FB 08 3B 1B 3B 7B
FC AC B7 FB 04 F1 2B CB F0 9B CB FC B5 B7 F1 FB
04 9B CB 4B CB FC C1 B7 FB 0C 7B CB 2B CB FC CA
B7 FB 04 9B CB 4B CB FC D3 B7 FB 02 2B CB F0 9B
CB F1 1B 2B 6B 9B FC DC B7 2B CB F0 9B CB F1 1B
2B 6B 9B 2B CB F0 9B CB F1 6B CB 2B CB FB 04 F0
;B800
BB CB F1 6B CB 2B 6B BB F2 1B FC FF B7 F1 FB 02
6B CB 1B CB F0 9B F1 9B 6B 8B FC 10 B8 6B CB 1B
CB F0 9B F1 9B 6B 8B 6B CB 1B CB 6B CB 1B CB FB
04 5B CB 0B CB F0 9B F1 9B 5B 7B FC 31 B8 FB 04
F0 9B CB F1 4B CB 0B 4B 9B F2 0B FC 40 B8 F1 FB
04 7B CB 2B CB FC 51 B8 FB 04 8B CB 2B CB FC 5A
B8 FB 04 9B CB 4B CB FC 63 B8 FB 04 AB CB 4B CB
FC 6C B8 FE FD B6

----------
;B876 - $38
80 B8 13 B9 D8 B9 FF FF FF FF

E0 6C EB C0 C0 F6 0A 07 FB 02 F1 52 F2 23 0D F1
BD AD 9D 80 72 F2 43 2D 1D 0D F1 BD A0 FC 8A B8
F6 0B 07 FB 02 F1 95 F2 96 9B 7B 9B AB CB 98 48
98 7C 9C 7C 58 48 78 5C 7C 5C 4B 2B 4B 5B FC A5
B8 F6 07 07 1B CB 1B CB 1B 2B 4B F1 9B F2 4B C8
F1 9B F2 45 D6 1B 9B C8 4B 92 2B CB 2B CB 2B 4B
5B F1 9B F2 5B C8 F1 9B F2 55 D6 2B 9B C8 5B 92
F7 04 07 15 25 45 25 F1 A8 F2 08 28 15 F1 B8 F2
;B900
15 F3 15 25 45 25 F2 A8 F3 08 28 15 F2 B8 F3 15
FE 85 B8 F5 0B 07 E7 FB 02 F1 2B CB 3B 0B 2B CB
AB CB 2B CB 8B CB 0B CB 6B 1B FC 19 B9 FB 02 F0
9B BB 9B BB 9B CB 9B BB 9B BB 9B 8B 9B BB F1 0B
F0 BB F1 0B 2B 0B CB 0B 2B 0B F0 BB F1 0B 2B 3B
2B 0B F0 BB F1 0B 2B F0 BB F1 0B F0 BB F1 0B F0
BB CB BB F1 0B F0 BB F1 0B F0 BB 9B BB F1 0B 2B
0B 2B 3B 2B CB 2B 3B 2B 0B 2B 3B 5B 3B 2B 0B 2B

3B FC 2F B9 FB 02 F0 45 F2 46 4B C8 F1 5B CB 48
08 1B 4B 98 2B 5B 98 4B 7B 98 5B 7B 9B 5B FC 86
B9 FB 10 F1 4B CB 5B CB FC A3 B9 FB 02 F1 4B CB
1B CB 5B CB 2B CB 7B CB 4B CB 5B CB 2B CB 2B F0
AB F1 4B 0B 5B 2B 4B 1B 4B 1B 2B F0 BB F1 4B 1B
4B 1B FC AD B9 FE 2D B9 FB 02 F1 7B CB 5B CB 7B
CB 5B CB 7B CB 5B CB 7B CB 3B CB FC DA B9 FB 08
F1 29 CD FC F0 B9 FB 08 F1 59 CD FC F8 B9 FB 08
;BA00
F1 49 CD FC 00 BA FB 08 F1 79 CD FC 08 BA FB 08
F1 29 CD FC 10 BA FB 08 F1 59 CD FC 18 BA FB 08
F1 49 CD FC 20 BA FB 08 F1 79 CD FC 28 BA FB 02
F0 95 F3 28 DD CD 2B C8 F1 AB CB 98 48 F0 98 F1
9B CB F0 A8 F1 AB CB 08 F2 0B CB F1 28 F2 2B CB
FC 30 BA FB 0B F1 99 CD FC 55 BA 78 58 48 28 18
FB 0B F1 A9 CD FC 62 BA 98 78 58 48 28 FB 02 F0
95 A5 F1 05 F0 A5 78 98 A8 95 78 95 FC 6F BA FE

EE B9

----------
;BA82 - $39
FF FF 8C BA A4 BA FF FF FF FF 
F5 03 07 E8
C5 F1 2B C6 C8 0B C6 0B CB C8 2B C6 2B C6 C8 0B
C6 FE 90 BA F1 7B C6 BB CB 7B CB 58 9B C6 9B CB
78 BB CB 78 BB CB 5B C6 9B CB 5B CB FE A5 BA

----------
;BABF - $3A
C9 BA E9 BA FF FF FF FF FF FF 
E0 FA F5 0B FF EB F1
98 78 C5 F2 05 05 F1 98 78 C5 F2 05 05 F1 98 78
C5 B5 C5 B5 C5 F2 05 05 FF F5 0B FF EB C5 F1 05
45 45 C5 05 45 45 C5 F0 75 F1 55 F0 95 F1 55 05
45 45 FF 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00

;$3B-$40
B40C	;0C B4
BCC7	;C7 BC
BE7F	;7F BE
BF14	;14 BF
BFA5	;A5 BF
BFB4	;B4 BF

----------
;$B40C - $3B
16 B4 7D B5 91 B9 7A BB FF FF 
F7 0E 01 E0 82 EC FB 0C C0 FC
1E B4 FB 03 C5 F2 65 45 25 15 F1 B5 A5 B5 F2 42
F1 72 D1 C5 C5 F2 45 25 15 F1 B5 95 85 95 F2 22
F1 62 D1 C5 42 D8 48 68 78 95 75 65 45 62 92 D1
C5 F2 42 D8 48 68 78 95 75 65 45 62 B2 D2 15 25
42 F1 92 D2 F2 15 45 62 12 D2 15 65 72 B2 D5 75
95 B5 90 D1 C5 FC 24 B4 C5 F2 65 45 25 15 F1 B5

A5 B5 F2 42 F1 72 D1 C5 C5 F2 45 25 15 F1 B5 95
85 95 F2 22 F1 62 D1 C5 42 D8 48 68 78 95 75 65
45 62 92 D1 C5 F2 42 D8 48 68 78 95 75 65 45 62
B2 D2 15 25 42 F1 92 D2 F2 15 45 62 12 D2 15 65
72 B2 D5 75 95 B5 F2 92 F3 12 D5 F2 95 B5 F3 15
F2 B0 D1 BA BA BA 90 D1 9A 9A 9A 70 D1 7A 7A 7A
90 D1 E0 7D 9A E0 78 9A E0 73 9A B0 D0 E0 5A F1
35 65 B5 65 E0 58 85 E0 56 B5 E0 46 F2 42 D0 E0
;B500
6E EA F2 2B 4B 6B 7B 6B 7B 9B BB F3 1B F2 BB 9B
7B 9B 7B 6B 4B 2B 4B 6B 7B 9B BB F3 1B 2B 4B 2B
1B F2 BB 9B 7B 6B 4B F1 BB F2 2B 4B 6B 7B 9B BB
F3 1B 2B F2 BB 8B 6B 4B 2B F1 BB F2 2B E0 6C 4B
E0 6A 6B E0 68 7B E0 66 9B E0 64 6B E0 62 7B E0
60 9B E0 5E BB E0 5C F3 1B E0 5A F2 BB E0 58 9B
E0 56 7B E0 54 6B E0 52 4B E0 50 2B E0 4E 1B E0
55 EC F2 70 E0 50 62 E0 4B 42 60 D0 FF F6 0B 07

E2 F0 2B 4B 6B 9B F1 2B 4B 6B 9B E3 F2 2B 4B 6B
9B F3 2B 4B 6B 9B E4 F4 2B F3 9B 6B 4B 2B F2 9B
6B 4B E5 2B F1 9B 6B 4B 2B F0 9B 6B 4B E6 EF BB
F0 1B 2B 6B BB F1 1B 2B 6B E7 BB F2 1B 2B 6B BB
F3 1B 2B 6B E8 BB 6B 2B 1B F2 BB 6B 2B 1B E9 F1
BB 6B 2B 1B F0 BB 6B 2B 1B EA 2B 4B 6B 9B F1 2B
4B 6B 9B F2 2B 4B 6B 9B F3 2B 4B 6B 9B E9 F4 2B
F3 9B 6B 4B 2B F2 9B 6B 4B 2B F1 9B 6B 4B 2B F0
;B600
9B 6B 4B E8 EF BB F0 1B 2B 6B BB F1 1B 2B 6B BB
F2 1B 2B 6B BB F3 1B 2B 6B E7 BB 6B 2B 1B F2 BB
6B 2B 1B F1 BB 6B 2B 1B F0 BB 6B 2B 1B E6 2B 4B
6B 9B F1 2B 4B 6B 9B E5 F2 2B 4B 6B 9B F3 2B 4B
6B 9B E4 F4 2B F3 9B 6B 4B 2B F2 9B 6B 4B E3 2B
F1 9B 6B 4B 2B F0 9B 6B 4B E2 2B 4B 6B 9B F1 2B
4B 6B 9B E1 F2 2B 4B 6B 9B F3 2B 4B 6B 9B F4 2B
F3 9B 6B 4B 2B F2 9B 6B 4B 2B F1 9B 6B 4B 2B F0

9B 6B 4B EA FB 03 F0 9B CB 95 9B CB 9B CB 95 9B
CB BB CB B5 BB CB BB CB B5 BB CB F1 1B CB 15 1B
CB 1B CB 15 1B CB F0 9B 4B 9B F1 1B 4B 1B 4B 9B
F2 1C F1 9C 4C 9C 4C 1C 4C 1C F0 9C F1 1C F0 9C
4C BB CB B5 BB CB BB CB B5 BB CB F1 1B CB 15 1B
CB 1B CB 15 1B CB 2B CB 25 2B CB 2B CB 25 2B CB
F0 BB 6B BB F1 2B 6B 2B 6B BB F2 2C F1 BC 6C BC
6C 2C 6C 2C F0 BC F1 2C F0 BC 6C C8 BB F1 4B 7B
;B700
4B 7B BB F2 45 C5 C5 F0 95 B5 F1 15 F0 68 98 F1
18 28 48 18 48 78 68 28 F0 B8 F1 68 48 F0 98 B8
F1 38 C8 F0 BB F1 4B 7B 4B 7B BB F2 45 C5 C5 F0
95 B5 F1 15 28 F0 68 B8 F1 28 48 F0 98 F1 18 48
68 F0 B8 F1 28 68 95 85 FB 04 4B 6B 4B CB 2B 1B
F0 BB F1 1B FC 4A B7 FB 04 F1 6B 7B 6B CB 4B 2B
1B F0 AB FC 59 B7 F1 FB 04 7B CB 1B 2B F0 BB F1
1B 2B 6B FC 69 B7 FB 02 9B 4B 2B 4B 1B 4B F0 BB

F1 4B FC 78 B7 98 F0 95 BB F1 1B 2B 4B 6B 7B 9B
BB F2 1B 4B FC 86 B6 F0 9B CB 95 9B CB 9B CB 95
9B CB BB CB B5 BB CB BB CB B5 BB CB F1 1B CB 15
1B CB 1B CB 15 1B CB F0 9B 4B 9B F1 1B 4B 1B 4B
9B F2 1C F1 9C 4C 9C 4C 1C 4C 1C F0 9C F1 1C F0
9C 4C BB CB B5 BB CB BB CB B5 BB CB F1 1B CB 15
1B CB 1B CB 15 1B CB 2B CB 25 2B CB 2B CB 25 2B
CB F0 BB 6B BB F1 2B 6B 2B 6B BB F2 2C F1 BC 6C
;B800
BC 6C 2C 6C 2C F0 BC F1 2C F0 BC 6C C8 BB F1 4B
7B 4B 7B BB F2 45 C5 C5 F0 95 B5 F1 15 F0 68 98
F1 18 28 48 18 48 78 68 28 F0 B8 F1 68 48 F0 98
B8 F1 38 C8 F0 BB F1 4B 7B 4B 7B BB F2 45 C5 C5
F0 95 B5 F1 15 28 F0 68 B8 F1 28 48 F0 98 F1 18
48 68 F0 B8 F1 28 68 95 85 FB 04 4B 6B 4B CB 2B
1B F0 BB F1 1B FC 5B B8 FB 04 F1 6B 7B 6B CB 4B
2B 1B F0 AB FC 6A B8 F1 FB 04 7B CB 1B 2B F0 BB

F1 1B 2B 6B FC 7A B8 FB 04 9B 4B 2B 4B 1B 4B F0
BB F1 4B FC 89 B8 FB 02 F2 3B 4B 3B CB 3B CB 3B
4B 3B 4B 3B CB 3B 4B 3B F1 BB FC 98 B8 FB 02 F2
1B 3B 1B CB 1B CB 1B 3B 1B 3B 1B CB 1B 3B 1B F1
9B FC AF B8 FB 02 F1 BB F2 1B F1 BB CB BB CB BB
F2 1B F1 BB F2 1B F1 BB CB BB F2 1B F1 BB 7B FC
C6 B8 F2 1B 2B 1B CB 1B CB 1B 2B 1B 2B 1B CB 1B
2B 1B F1 9B F2 1B 2B 1B CB 1B CB 1B 2B 1B 2B 1B
;B900
CB 4A 4A 4A F7 0E 01 E0 76 30 D2 E0 74 1B E0 72
F1 BB E0 70 AB E0 6E 8B E0 6C 6B E0 6A 4B E0 68
3B E0 66 1B F0 68 88 A8 B8 F1 38 18 F0 B8 68 B8
F1 18 38 48 72 D0 E9 6B 7B 9B BB 9B BB F2 1B 2B
4B 2B 1B F1 BB F2 1B F1 BB 9B 7B BB F2 1B 2B 4B
6B 7B 9B BB F3 1B F2 BB 9B 7B 6B 4B 2B 1B F1 7B
BB F2 1B 2B 4B 6B 7B 9B 8B 6B 4B 2B F1 BB 8B 6B
8B 9B F2 2B 4B 6B 2B 4B 6B 7B 9B 7B 6B 4B 2B 1B

F1 BB 9B EA 95 75 95 B5 F2 15 F1 75 95 75 90 D0
FF FB 0C C0 FC 93 B9 FB 03 F1 FB 02 C8 2B CB 68
2B CB FC 9C B9 FB 02 C8 5B CB 88 5B CB FC A7 B9
FB 02 C8 4B CB 98 4B CB FC B2 B9 1B F0 9B F1 1B
4B 9B 4B 9B F2 1B 4C 1C F1 9C F2 1C F1 9C 4C 9C
4C 1C 4C 1C F0 9C F1 FB 02 C8 4B CB 78 4B CB FC
D9 B9 FB 02 C8 4B CB 98 4B CB FC E4 B9 FB 02 C8
6B CB B8 6B CB FC EF B9 2B F0 BB F1 2B 6B BB 6B
;BA00
BB F2 2B 6C 2C F1 BC F2 2C F1 BC 6C BC 6C 2C 6C
2C F0 BC C8 F1 78 48 28 15 C5 C5 45 25 15 22 12
F0 B2 92 C8 F1 78 48 28 15 C5 C5 45 25 15 F0 B2
F1 12 22 65 55 FB 08 9B CB 4B CB FC 37 BA FB 08
6B CB 1B CB FC 40 BA FB 08 7B CB 2B CB FC 49 BA
FB 04 9B CB 4B CB FC 52 BA F0 95 F1 75 65 45 FC
99 B9 F1 FB 02 C8 2B CB 68 2B CB FC 65 BA FB 02
C8 5B CB 88 5B CB FC 70 BA FB 02 C8 4B CB 98 4B

CB FC 7B BA 1B F0 9B F1 1B 4B 9B 4B 9B F2 1B 4C
1C F1 9C F2 1C F1 9C 4C 9C 4C 1C 4C 1C F0 9C F1
FB 02 C8 4B CB 78 4B CB FC A2 BA FB 02 C8 4B CB
98 4B CB FC AD BA FB 02 C8 6B CB B8 6B CB FC B8
BA 2B F0 BB F1 2B 6B BB 6B BB F2 2B 6C 2C F1 BC
F2 2C F1 BC 6C BC 6C 2C 6C 2C F0 BC C8 F1 78 48
28 15 C5 C5 45 25 15 22 12 F0 B2 92 C8 F1 78 48
28 15 C5 C5 45 25 15 F0 B2 F1 12 22 65 55 FB 08
;BB00
9B CB 4B CB FC 00 BB FB 08 6B CB 1B CB FC 09 BB
FB 08 7B CB 2B CB FC 12 BB FB 08 9B CB 4B CB FC
1B BB 60 D2 D6 CB 6C CC 6C CC 6C CC 40 D2 D6 CB
4C CC 4C CC 4C CC 20 D2 D6 CB 2C CC 2C CC 2C CC
10 D2 D6 CB 1C CC 1C CC 1C CC F0 B0 D1 D6 CB B2
92 F1 42 F2 42 E0 5A 15 E0 55 F1 B5 E0 50 95 E0
4B 75 95 F2 25 45 F1 95 F2 72 65 45 25 18 28 45
26 CB 22 12 20 F1 92 42 20 FF FB 08 C0 FC 7C BB

FA E6 A8 A8 E4 AB E6 AB E4 AB AB E6 A8 A8 AC E5
AC E4 AC E3 AC E2 AC E1 AC E8 A8 A8 E6 AB E8 AB
E6 AB AB E8 A8 A8 AC E7 AC E6 AC E5 AC E4 AC E3
AC EA A8 A8 E8 AB EA AB E8 AB AB EA A8 A8 AC E9
AC E8 AC E7 AC E6 AC E5 AC EC A8 A8 EA AB EC AB
EA AB AB EC A8 A8 AC EA AC E8 AC E6 AC E4 AC E2
AC FB 04 FB 08 EE A8 A8 EC AB EE AB EC AB AB EE
A8 A8 AC EC AC EA AC E8 AC E6 AC E4 AC FC E5 BB
;BC00
E7 A8 E8 AB E9 AB EA AB EB AB EC AB ED AB EE A5
C5 C5 A5 A5 A5 FB 02 EE A8 A8 EC AB EE AB EC AB
AB EE A8 A8 AC EC AC EA AC E8 AC E6 AC E4 AC FC
17 BC E7 A8 E8 AB E9 AB EA AB EB AB EC AB ED AB
EE A5 C5 C5 A5 A5 A5 FB 02 EE A8 A8 EC AB EE AB
EC AB AB EE A8 A8 AC EC AC EA AC E8 AC E6 AC E4
AC FC 49 BC FB 1F EE A8 EB AB AB FC 66 BC EE AB
AB AB AB FC E3 BB FB 04 F5 27 FF EF 40 FA E2 AB

E3 AB E4 AB E5 AB E6 AB E7 AB E8 AB E9 AB EA AB
EB AB EC AB ED AB EE AA AA AA FC 78 BC F5 27 FF
EF 40 C0 C0 C0 C0 FB 04 EF 42 FA E7 AB E8 AB E9
AB EA AB EB AB EC AB ED AB EE AB F5 27 FF FC A8
BC EF 40 42 42 40 FF

----------
;BCC7 - $3C
D1 BC 58 BD FF FF FF FF FF FF 
E0 50 C0 C0 EB F7 04 07 F1 65 95 F2 25 F1 95
B5 F2 25 72 65 28 F1 98 88 B8 F2 28 68 40 43 48
65 45 22 F1 B2 F2 43 48 65 45 22 72 C8 68 48 28
;BD00
18 28 F1 88 B8 90 C8 F2 98 78 68 48 68 08 48 31
48 68 73 F1 B8 B5 F2 48 68 73 F1 A8 A5 F2 75 C8
68 48 28 18 F1 B8 A8 B8 F2 42 F1 72 C8 F2 48 28
18 F1 B8 98 88 98 F2 22 F1 62 C8 F2 28 18 F1 B8
98 78 68 78 C8 B8 98 78 68 48 38 48 21 D8 1B F0
BB F1 11 25 20 D0 D0 FF F5 02 FF E1 F0 28 98 E2
F1 68 48 E3 98 48 E4 68 28 E5 F0 28 98 E6 F1 68
48 E7 98 48 E8 68 28 E9 F0 28 68 98 F1 28 F0 08

68 98 F1 28 EF 78 F0 78 B8 F1 28 EF A8 F0 78 A8
F1 28 F0 28 68 98 F1 28 F0 28 88 B8 F1 28 EF 98
F0 48 98 F1 18 48 18 F0 98 78 48 B8 F1 48 78 F0
68 F1 18 68 A8 EF B8 F0 B8 F1 28 68 B8 68 28 F0
B8 EF 98 F0 98 F1 18 48 EF A8 F0 A8 F1 18 48 EF
B8 F0 68 B8 F1 28 EF A8 F0 78 A8 F1 48 F0 28 98
F1 28 68 88 58 28 F0 B8 98 18 48 98 F1 1A F0 9A
F1 1A 4A 1A F0 9A 68 F1 18 68 98 F2 08 F1 98 68
;BE00
48 EF B8 F0 68 B8 F1 38 6A 3A F0 BA 98 38 48 78
B8 F1 48 72 F0 28 78 A8 F1 28 72 F0 28 98 F1 28
68 88 58 28 F0 B8 98 18 48 98 F1 1A F0 9A F1 1A
4A 1A F0 9A 48 78 B8 F1 48 78 48 18 F0 98 EF B8
F0 28 68 B8 F1 28 18 F0 B8 68 71 75 41 45 EF 98
F0 48 78 48 98 48 78 48 EF 98 F0 48 78 48 98 48
78 48 28 E0 4E 68 E0 4C 98 E0 4A 68 E0 48 F1 28
E0 46 F0 68 E0 44 98 E0 42 68 E0 40 20 D0 FF

----------
;BE7F - $3D
89 BE B4 BE 00 BF FF FF FF FF 
F6 0B 07 E9 F1 0B 1B
3B 4B 0B 1B 3B 4B 3B 4B 6B 7B 3B 4B 6B 7B 6B 7B
9B AB 6B 7B 9B AB 9B AB F2 0B 1B F1 9B AB F2 0B
1B FE 8D BE EB F5 0B 07 FB 02 F2 0B F1 BB AB 9B
F2 0B F1 BB AB 9B F2 3B 2B 1B 0B 3B 2B 1B 0B 6B
5B 4B 3B 6B 5B 4B 3B 9B 8B 7B 6B 9B 8B 7B 6B FC
BA BE ED F5 0A 07 FB 02 F2 0E 5E 7E F3 0B D1 F2
0C 5C 7C F3 0B C8 F2 7B F3 01 FC E8 BE FE B4 BE
;BF00
F1 08 18 08 18 38 48 38 48 68 78 68 78 98 A8 98
A8 FE 01 BF

----------
;BF14 - $3E
1E BF 69 BF 71 BF FF FF FF FF 
E0 46
F7 04 06 EB F3 0A 1A 3A F2 6A 7A 9A 0A 1A 3A F1
6A 7A 9A F3 0A 1A 3A F2 6A 7A 9A 0A 1A 3A F1 6A
7A 9A F1 2A F0 BA F1 5A 2A 8A 5A BA 8A F2 2A F1
BA F2 5A 2A F1 2A F0 BA F1 5A 2A 8A 5A BA 8A F2
2A F1 BA F2 5A 2A FE 24 BF F7 04 03 E7 C9 FE 24
BF F1 02 37 6A 9A 7A 6A 02 37 6A 9A 7A 6A F0 B5

D7 F1 2A 55 AF BF DE DC AF BF DE DC AF BF DE DC
F0 B5 D7 F1 2A 55 AF BF DE DC AF BF DE DC AF BF
DE DC FE 71 BF

----------
;BFA5 - $3F
AF BF 69 BF 71 BF FF FF FF FF 
E0
78 FE 20 BF

----------
;BFB4 - $40
BE BF FF FF FF FF FF FF FF FF 
E0 78
F5 0B FF EB F2 48 38 48 38 46 F1 95 DB C2 F2 48
38 48 38 48 F1 B2 F2 28 05 F1 B3 C8 F2 28 08 F1
95 D5 FF 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



;Volume envelope Address (41)
9ACE	;CE 9A - $00
9ADB	;DB 9A - $01
9AED	;ED 9A - $02
9B0E	;0E 9B - $03
9B55	;55 9B - $04
9B83	;83 9B - $05
9BA0	;A0 9B - $06
9BAA	;AA 9B - $07
9BC9	;C9 9B - $08
9BE8	;E8 9B - $09
9C0A	;0A 9C - $0A
9B18	;18 9B - $0B
9B73	;73 9B - $0C
9B22	;22 9B - $0D
9B7B	;7B 9B - $0E
9C24	;24 9C - $0F
9C40	;40 9C - $10
9C00	;00 9C - $11
9C56	;56 9C - $12
9C72	;72 9C - $13
9C82	;82 9C - $14
9C91	;91 9C - $15
9C9B	;9B 9C - $16
9CA5	;A5 9C - $17
9D3A	;3A 9D - $18
9DC5	;C5 9D - $19
9E23	;23 9E - $1A
9E40	;40 9E - $1B
9CD7	;D7 9C - $1C
9C4A	;4A 9C - $1D
9E51	;51 9E - $1E
9D80	;80 9D - $1F
9CF3	;F3 9C - $20
9D16	;16 9D - $21
9CBF	;BF 9C - $22
9CEB	;EB 9C - $23
9DF4	;F4 9D - $24
9E6F	;6F 9E - $25
9E31	;31 9E - $26
9B28	;28 9B - $27
9E7D	;7D 9E - $28

; Attack : volumes(low nibble) : if -(negative) is attack terminate(to decay)
; Decay/Release : 1st : volume envelope rate, 
;		  2nd : 0 = terminate, + = count, - = loop back to ..
;		  3rd : + = vol up, - = vol down(if 2nd is not terminate(0) ) - 2nd, 3rd repeat
;		  [volume envelope rate], [count or terminate], [volume], [count or terminate], [volume], ...

----------
;9ACE - $00
.word VE_9AD4				; D4 9A
.word VE_9AD9				; D9 9A
.word VE_9AD9				; D9 9A
VE_9AD4:
0F 09 03 00 FF 
VE_9AD9:
00 00

----------
;9ADB - $01
.word VE_9AE1				; E1 9A
.word VE_9AEB				; EB 9A
.word VE_9AEB				; EB 9A
VE_9AE1:
0F 0C 09 07 05 03 02 01 00 FF 
VE_9AEB:
00 00

----------
;9AED - $02
.word VE_9AF3				; F3 9A
.word VE_9B0A				; 0A 9B
.word VE_9B0C				; 0C 9B
VE_9AF3:
0F 0F 0E 0E 0D 0D 0C 0C 0B 0B 0A 0A 09
09 08 08 08 07 07 07 07 06 FF
VE_9B0A:
14 00
VE_9B0C:
1E 00

----------
;9B0E - $03
.word VE_9AF3				; F3 9A
.word VE_9B14				; 14 9B
.word VE_9B16				; 16 9B
VE_9B14:
0A 00
VE_9B16:
14 00

----------
;9B18 - $0B
.word VE_9AF3				; F3 9A
.word VE_9B1E				; 1E 9B
.word VE_9B20				; 20 9B
VE_9B1E:
05 00
VE_9B20:
0A 00

----------
;9B22 - $0D
.word VE_9AF3				; F3 9A
.word VE_9B14				; 14 9B
.word VE_9B20				; 20 9B

----------
;9B28 - $27
.word VE_9B2E				; 2E 9B
.word VE_9B53				; 53 9B
.word VE_9B53				; 53 9B
VE_9B2E:
0F 0F
0E 0E 0D 0D 0C 0C 0B 0B 0A 0A 09 09 08 08 08 07
07 07 06 06 06 06 05 05 05 05 05 04 04 04 04 04
04 03 FF
VE_9B53:
05 00

----------
;9B55 - $04
.word VE_9B5B				; 5B 9B
.word VE_9B6B				; 6B 9B
.word VE_9B71				; 71 9B
VE_9B5B:
05 06 07 08 09
09 0A 0A 0B 0B 0C 0C 0D 0D 0F FF
VE_9B6B:
05 02 00 02 FF
FC
VE_9B71:
32 00

----------
;9B73 - $0C
.word VE_9B5B				; 5B 9B
.word VE_9B79				; 79 9B
.word VE_9B71				; 71 9B
VE_9B79:
05 00

----------
;9B7B - $0E
.word VE_9B5B				; 5B 9B
.word VE_9B79				; 79 9B
.word VE_9B81				; 81 9B
VE_9B81:
19 00

----------
;9B83 - $05
.word VE_9B89				; 89 9B
.word VE_9B9C				; 9C 9B
.word VE_9B9E				; 9E 9B
VE_9B89:
0B 0C 0D 0E 0F 0E 0D
0C 0B 0A 09 08 07 07 06 06 06 05 FF
VE_9B9C:
0A 00
VE_9B9E:
05 00

----------
;9BA0 - $06
.word VE_9B89				; 89 9B
.word VE_9BA6				; A6 9B
.word VE_9BA8				; A8 9B
VE_9BA6:
05 00
VE_9BA8:
02 00

----------
;9BAA - $07
.word VE_9BB0				; B0 9B
.word VE_9BBB				; BB 9B
.word VE_9BC7				; C7 9B
VE_9BB0:
0F 06 08 09 0A 0B 0C 0D 0E 0F FF
VE_9BBB:
05 01 00 02 FF
02 FE 02 FF 01 00 F6
VE_9BC7:
43 00

----------
;9BC9 - $08
.word VE_9BCF				; CF 9B
.word VE_9BDE				; DE 9B
.word VE_9BE6				; E6 9B
VE_9BCF:
05
06 07 08 09 09 0A 0A 0B 0B 0D 0D 0F 0F FF
VE_9BDE:
05 01
00 02 FF 01 00 FA 
VE_9BE6:
32 00

----------
;9BE8 - $09
.word VE_9BEE				; EE 9B
.word VE_9BFC				; FC 9B
.word VE_9BFE				; FE 9B
VE_9BEE:
0F 0E
0D 0C 0B 0A 09 08 08 07 07 07 06 FF 
VE_9BFC:
19 00
VE_9BFE:
1E 00

----------
;9C00 - $11
.word VE_9BEE				; EE 9B
.word VE_9C06				; 06 9C
.word VE_9C08				; 08 9C
VE_9C06:
05 00
VE_9C08:
0A 00

----------
;9C0A - $0A
.word VE_9C10				; 10 9C
.word VE_9C16				; 16 9C
.word VE_9C1C				; 1C 9C
VE_9C10:
07 09 0B 0D 0F FF 
VE_9C16:
05 02 00 02 FF FC 
VE_9C1C:
32 02 00 02
FE 02 01 FA

----------
;9C24 - $0F
.word VE_9C2A				; 2A 9C
.word VE_9C38				; 38 9C
.word VE_9C3E				; 3E 9C
VE_9C2A:
03 03 05 05 07 07
09 09 0B 0B 0D 0D 0F FF
VE_9C38:
05 02 00 02 FF FC
VE_9C3E:
1E 00

----------
;9C40 - $10
.word VE_9C46				; 46 9C
.word VE_9C48				; 48 9C
.word VE_9C48				; 48 9C
VE_9C46:
0F FF
VE_9C48:
64 00

----------
;9C4A - $1D
.word VE_9C46				; 46 9C
.word VE_9C50				; 50 9C
.word VE_9C50				; 50 9C
VE_9C50:
64 01 FA 01 00 FC

----------
;9C56 - $12
.word VE_9C5C				; 5C 9C
.word VE_9C64				; 64 9C
.word VE_9C70				; 70 9C
VE_9C5C:
0F 0F 0E 0E
0D 0D 0C FF
VE_9C64:
00 01 00 02 FF 02 FE 02 FF 01 00 F6
VE_9C70:
32 00

----------
;9C72 - $13
.word VE_9C78				; 78 9C
.word VE_9C80				; 80 9C
.word VE_9C80				; 80 9C
VE_9C78:
0F 0D 0B 09 07 05 04 FF
VE_9C80:
00 00

----------
;9C82 - $14
.word VE_9C88				; 88 9C
.word VE_9C8F				; 8F 9C
.word VE_9C8F				; 8F 9C
VE_9C88:
0F 0C 09 06 03 00 FF
VE_9C8F:
00
00

----------
;9C91 - $15
.word VE_9C97				; 97 9C
.word VE_9C99				; 99 9C
.word VE_9C99				; 99 9C
VE_9C97:
0F FF
VE_9C99:
21 00

----------
;9C9B - $16
.word VE_9CA1				; A1 9C
.word VE_9CA3				; A3 9C
.word VE_9CA3				; A3 9C
VE_9CA1:
0F FF
VE_9CA3:
00 00

----------
;9CA5 - $17
.word VE_9CAB				; AB 9C
.word VE_9CBB				; BB 9C
.word VE_9CBD				; BD 9C 
VE_9CAB:
01 02 03 04 05
06 07 08 09 0A 0B 0C 0D 0E 0F FF
VE_9CBB:
00 00
VE_9CBD:
64 00

----------
;9CBF - $22
.word VE_9CC5				; C5 9C
.word VE_9CD5				; D5 9C
.word VE_9CD5				; D5 9C
VE_9CC5:
08 00 09 00 0A 00 0B 00 0C 00 0D
00 0E 00 0F FF
VE_9CD5:
64 00

----------
;9CD7 - $1C
.word VE_9CAB				; AB 9C
.word VE_9CDD				; DD 9C
.word VE_9CBD				; BD 9C
VE_9CDD:
00 01 FD
01 FA 01 F7 01 FA 01 FD 01 00 F4

----------
;9CEB - $23
.word VE_9CAB				; AB 9C
.word VE_9CF1				; F1 9C
.word VE_9CF1				; F1 9C 
VE_9CF1:
64 00

----------
;9CF3 - $20
.word VE_9CF9				; F9 9C
.word VE_9D0A				; 0A 9D
.word VE_9D10				; 10 9D
VE_9CF9:
00 02 00 04 00 06 00
08 00 0A 00 0C 00 0E 00 0F FF
VE_9D0A:
00 01 F1 01 00 FC
VE_9D10:
64 01 F1 01 00 FC

----------
;9D16 - $21
.word VE_9D1C				; 1C 9D
.word VE_9D2C				; 2C 9D
.word VE_9D34				; 34 9D
VE_9D1C:
01 00 03 00
05 00 07 00 09 00 0B 00 0D 00 0F FF
VE_9D2C:
00 01 F1 01
F1 01 00 FC
VE_9D34:
64 01 F1 01 00 FC

----------
;9D3A - $18
.word VE_9D40				; 40 9D
.word VE_9D7E				; 7E 9D
.word VE_9D7E				; 7E 9D
VE_9D40:
01 01 01 01 02 02 02 02 03 03 03 03 04 04 04 04
05 05 05 05 06 06 06 06 07 07 07 07 08 08 08 08
09 09 09 09 0A 0A 0A 0A 0B 0B 0B 0B 0C 0C 0C 0C
0D 0D 0D 0D 0E 0E 0E 0E 0F 0F 0F 0F 00 FF
VE_9D7E:
00 00

----------
;9D80 - $1F
.word VE_9D86				; 86 9D
.word VE_9DC3				; C3 9D
.word VE_9DC3				; C3 9D
VE_9D86:
01 00 01 00 02 00 02 00 03 00
03 00 04 00 04 00 05 00 05 00 06 00 06 00 07 00
07 00 08 00 08 00 09 00 09 00 0A 00 0A 00 0B 00
0B 00 0C 00 0C 00 0D 00 0D 00 0E 00 0E 00 0F 00
0F 00 FF
VE_9DC3:
00 00

----------
;9DC5 - $19
.word VE_9DCB				; CB 9D
.word VE_9DF2				; F2 9D
.word VE_9DF2				; F2 9D
VE_9DCB:
01 03 05 07 07
07 07 07 07 07 07 09 0B 0D 0F 0F 0F 0F 0F 0F 0F
0F 0F 0D 0B 09 07 07 07 07 07 07 07 07 05 03 01
00 FF
VE_9DF2:
00 00

----------
;9DF4 - $24
.word VE_9DFA				; FA 9D
.word VE_9E21				; 21 9E
.word VE_9E21				; 21 9E
VE_9DFA:
01 00 05 00 07 00
07 00 07 00 07 00 0B 00 0F 00 0F 00 0F 00 0F 00
0F 00 0B 00 07 00 07 00 07 00 07 00 05 00 01 00
FF
VE_9E21:
00 00

----------
;9E23 - $1A
.word VE_9E29				; 29 9E
.word VE_9E2F				; 2F 9E
.word VE_9E2F				; 2F 9E
VE_9E29:
03 06 09 0C 0F FF
VE_9E2F:
00
00

----------
;9E31 - $26
.word VE_9E37				; 37 9E
.word VE_9E3E				; 3E 9E
.word VE_9E3E				; 3E 9E
VE_9E37:
03 06 09 0C 0F 00 FF
VE_9E3E:
00 00

----------
;9E40 - $1B
.word VE_9E46				; 46 9E
.word VE_9E4F				; 4F 9E
.word VE_9E4F				; 4F 9E
VE_9E46:
0F 0F 03 03 06 09 0C 0F FF
VE_9E4F:
21
00

----------
;9E51 - $1E
.word VE_9E57				; 57 9E
.word VE_9E5D				; 5D 9E
.word VE_9E6B				; 6B 9E
VE_9E57:
03 06 09 0C 0F FF
VE_9E5D:
00 01 FE
01 FC 01 FA 01 FC 01 FE 01 00
VE_9E6B:
F4 64 01 FF FE

----------
;9E6F - $25
.word VE_9E75				; 75 9E
.word VE_9E77				; 77 9E
.word VE_9E77				; 77 9E
VE_9E75:
0F FF
VE_9E77:
00 01 F1 01 00 FC

----------
;9E7D - $28
.word VE_9E83				; 83 9E
.word VE_9EA9				; A9 9E
.word VE_9EA9				; A9 9E 
VE_9E83:
07 07 09 0B 0D 0F 0F 0F 0F 0A 05 0A 0F
0A 05 00 05 0A 0F 0A 05 00 00 05 0A 0F 0A 05 00
00 00 05 0A 0F 0A 05 00 FF
VE_9EA9:
00 00
;9EAA
----------

;Pitch envelop address (16)
9ECB	;CB 9E - $00
9ED0	;D0 9E - $01
9ED7	;D7 9E - $02
9EDE	;DE 9E - $03
9EE3	;E3 9E - $04
9EE6	;E6 9E - $05
9EED	;ED 9E - $06
9EF4	;F4 9E - $07
9EFB	;FB 9E - $08
9EFE	;FE 9E - $09
9F05	;05 9F - $0A
9F24	;24 9F - $0B
9F2F	;2F 9F - $0C
9F7A	;7A 9F - $0D
9F8D	;8D 9F - $0E
9FA2	;A2 9F - $0F

; plus : count, pitch +,- [byte1, byte2]
; minus : count back [byte]
; zero : stop [byte]

;9ECB - $00
04 FF 04 01 FC
;9ED0 - $01
32 00 06 FF 06 01 FC
;9ED7 - $02
32 FF 06 01 06 FF FC
;9EDE - $03
06 FF 06 01 FC
;9EE3 - $04
01 FF 00
;9EE6 - $05
10 00 06 FF 06 01 FC
;9EED - $06
06 00 06 FF 06 01 FC
;9EF4 - $07
18 00 06 FF 06 01 FC
;9EFB - $08
04 FF FE
;9EFE - $09
18 FF 06 FF 06 01 FC
;9F05 - $0A
01 FF 01 FE 01 FE 01 FE 01 02 01 02 01 02 01 02 01 02 01 02 01 02 01 FE 01 FE 01 FE 01 FE E4
;9F24 - $0B
01 00 01 FF 01 01 01 01 01 FF F8
;9F2F - $0C
01
07 01 FE 01 FE 01 FE 01 FE 01 FE 01 FE 01 FE 01
FE 01 01 01 01 01 01 01 FF 01 FF 01 FF 01 01 01
01 01 01 01 FF 01 FF 01 FF 01 01 01 01 01 01 01
FF 01 FF 01 FF 01 02 01 02 01 02 01 02 01 02 01
02 01 02 01 FE 01 FE 01 FE 00
;9F7A - $0D
01 01 01 02 01 02 01 02 02 02 01 FE 01 FE 01 FE 01 FF EE
;9F8D - $0E
01 07 01 FD 01 FD 01 FD 01 FD 02 FE 02 01 02 01 02 FF 02 FF F8 
;9FA2 - $0F
01 F9 01 07 02 07 01 FE 01 FD 01 FD 01 FD
01 FD 01 02 01 02 01 02 01 FE 01 FE 01 FE 01 02
01 02 01 02 01 FE 01 FE 01 FE 01 02 01 02 01 02
01 FE 01 FE 01 FE 01 02 01 02 01 02 01 02 01 02
01 02 01 02 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
.endif
