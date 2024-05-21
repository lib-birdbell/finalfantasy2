.include "Constants.inc"
.include "variables.inc"

.import Set_IRQ_JMP		;FA2A
.import Wait_NMI_end		;FD46
.import	Wait_MENU_snd		;FD5B

.segment "BANK_0C"

;; [$8000 :: 0x30010]

; ========== armor properties (41 * 6 bytes) ($8000-$80F5) START ==========
; 00: Defense, 01: Evade penalty, 02: Int/Soul penalty
; 03: Elemental defense, 04: Stat boost, 05: Magic defense
; Stat boost -> 00: strength +10, 01: agility +10, 02: 
;	  03: intelligence +10, 04: soul +10
Armor_prop:
.byte $00,$00,$00,$00,$FF,$05	; 8000
.byte $01,$02,$02,$00,$FF,$05	; 8006
.byte $02,$05,$08,$00,$FF,$05	; 800C
.byte $04,$05,$08,$00,$FF,$0A	; 8012
.byte $06,$0D,$18,$00,$00,$0A	; 8018
.byte $0D,$0E,$1A,$80,$FF,$0A	; 801E
.byte $11,$12,$22,$08,$FF,$0A	; 8024
.byte $1E,$1F,$3C,$01,$FF,$0F	; 802A
.byte $0C,$02,$02,$04,$00,$0A	; 8030
.byte $0B,$02,$00,$08,$01,$0F	; 8036
.byte $0A,$00,$00,$FF,$FF,$1A	; 803C
.byte $01,$05,$02,$00,$FF,$05	; 8042
.byte $02,$06,$04,$00,$FF,$05	; 8048
.byte $05,$0E,$14,$00,$FF,$05	; 804E
.byte $0A,$0E,$14,$00,$FF,$0A	; 8054
.byte $0F,$13,$1E,$20,$FF,$0A	; 805A
.byte $16,$1A,$2C,$00,$FF,$0A	; 8060
.byte $1D,$21,$3A,$02,$FF,$0A	; 8066
.byte $24,$28,$48,$80,$FF,$0A	; 806C
.byte $2B,$2F,$56,$08,$FF,$0A	; 8072
.byte $32,$36,$32,$AA,$FF,$0A	; 8078
.byte $4B,$4F,$64,$10,$FF,$0F	; 807E
.byte $05,$05,$01,$00,$FF,$0A	; 8084
.byte $0A,$05,$01,$00,$FF,$0A	; 808A
.byte $0F,$05,$01,$00,$FF,$0A	; 8090
.byte $16,$05,$01,$00,$FF,$0A	; 8096
.byte $2B,$05,$01,$00,$FF,$0A	; 809C
.byte $1E,$05,$00,$55,$04,$1A	; 80A2
.byte $23,$05,$00,$AA,$03,$1A	; 80A8
.byte $19,$05,$01,$40,$00,$0A	; 80AE
.byte $28,$00,$01,$01,$01,$0A	; 80B4
.byte $01,$03,$04,$00,$FF,$05	; 80BA
.byte $03,$08,$18,$00,$FF,$05	; 80C0
.byte $06,$08,$18,$00,$FF,$0A	; 80C6
.byte $0F,$03,$28,$00,$01,$0A	; 80CC
.byte $0F,$11,$3C,$00,$00,$0A	; 80D2
.byte $14,$16,$50,$02,$FF,$0A	; 80D8
.byte $19,$1B,$64,$08,$FF,$0A	; 80DE
.byte $2D,$2F,$64,$04,$FF,$0F	; 80E4
.byte $12,$03,$00,$10,$FF,$1A	; 80EA
.byte $13,$03,$02,$20,$00,$0A	; 80F0
; ========== armor properties (41 * 6 bytes) ($8000-$80F5) END ==========


; ========== weapon properties (64 * 9 bytes) ($80F6-$8335) START ==========
; 00: Type, 01: Accuracy, 02: Attack power, 03: Evade, 04: Int/Soul penalty
; 05: Elemental properties, 06: Added damage to monster type, 07: Attack with, 08: Used as an item
Weapon_prop:
.byte $00,$50,$00,$00,$00,$00,$00,$00,$FF	; 80F6
.byte $01,$00,$01,$04,$46,$00,$00,$00,$FF	; 80FF
.byte $01,$00,$02,$05,$46,$00,$00,$00,$FF	; 8108
.byte $01,$00,$03,$06,$46,$00,$00,$00,$FF	; 8111
.byte $01,$00,$04,$07,$46,$20,$00,$00,$FF	; 811A
.byte $01,$00,$04,$07,$46,$02,$00,$00,$FF	; 8123
.byte $01,$00,$04,$07,$46,$80,$00,$00,$FF	; 812C
.byte $01,$00,$04,$07,$46,$08,$00,$00,$FF	; 8135
.byte $01,$00,$05,$09,$46,$AA,$00,$00,$FF	; 813E
.byte $01,$00,$06,$0A,$46,$55,$00,$00,$FF	; 8147
.byte $02,$4B,$03,$01,$05,$00,$00,$00,$FF	; 8150
.byte $02,$41,$07,$01,$05,$00,$00,$00,$FF	; 8159
.byte $02,$43,$0E,$01,$05,$00,$00,$00,$FF	; 8162
.byte $02,$46,$20,$05,$05,$00,$00,$00,$FF	; 816B
.byte $02,$48,$32,$01,$05,$00,$02,$00,$FF	; 8174
.byte $02,$4B,$45,$01,$05,$00,$00,$10,$FF	; 817D
.byte $02,$50,$56,$01,$05,$00,$10,$00,$FF	; 8186
.byte $03,$46,$04,$01,$05,$00,$00,$00,$FF	; 818F
.byte $03,$3C,$09,$01,$14,$00,$00,$00,$FF	; 8198
.byte $03,$3C,$10,$01,$14,$00,$00,$00,$FF	; 81A1
.byte $03,$3E,$1C,$01,$14,$00,$40,$00,$FF	; 81AA
.byte $03,$40,$28,$01,$05,$00,$00,$00,$4B	; 81B3
.byte $03,$42,$35,$01,$14,$00,$00,$00,$FF	; 81BC
.byte $03,$44,$40,$01,$05,$00,$00,$00,$52	; 81C5
.byte $03,$46,$4E,$01,$05,$00,$80,$20,$FF	; 81CE
.byte $03,$4B,$5A,$01,$05,$00,$00,$00,$FF	; 81D7
.byte $04,$41,$06,$01,$28,$00,$00,$00,$FF	; 81E0
.byte $04,$37,$0B,$01,$28,$00,$00,$00,$FF	; 81E9
.byte $04,$37,$12,$01,$28,$00,$00,$00,$FF	; 81F2
.byte $04,$39,$1E,$01,$28,$00,$02,$00,$FF	; 81FB
.byte $04,$3C,$2A,$01,$28,$00,$01,$00,$FF	; 8204
.byte $04,$3E,$36,$01,$28,$02,$00,$00,$FF	; 820D
.byte $04,$41,$42,$01,$28,$80,$00,$00,$FF	; 8216
.byte $04,$43,$4E,$01,$28,$08,$00,$00,$7C	; 821F
.byte $04,$46,$5A,$01,$28,$00,$20,$00,$46	; 8228
.byte $05,$3C,$08,$01,$32,$00,$00,$00,$FF	; 8231
.byte $05,$32,$0D,$01,$32,$00,$00,$00,$FF	; 823A
.byte $05,$32,$14,$01,$32,$00,$00,$00,$FF	; 8243
.byte $05,$0A,$19,$01,$32,$00,$00,$09,$FF	; 824C
.byte $05,$0A,$1E,$01,$32,$00,$00,$0A,$FF	; 8255
.byte $05,$38,$2A,$01,$32,$00,$01,$00,$FF	; 825E
.byte $05,$00,$00,$00,$64,$00,$00,$04,$FF	; 8267
.byte $05,$3A,$34,$01,$32,$00,$04,$00,$FF	; 8270
.byte $05,$3C,$3F,$01,$32,$02,$00,$00,$FF	; 8279
.byte $05,$3E,$48,$01,$32,$80,$00,$00,$FF	; 8282
.byte $05,$40,$4E,$08,$32,$00,$00,$00,$FF	; 828B
.byte $05,$41,$53,$01,$32,$00,$80,$00,$FF	; 8294
.byte $05,$4B,$64,$01,$1E,$FF,$F8,$00,$FF	; 829D
.byte $05,$5A,$96,$02,$00,$00,$00,$00,$68	; 82A6
.byte $06,$37,$0A,$01,$32,$00,$00,$00,$FF	; 82AF
.byte $06,$2D,$0F,$01,$32,$00,$00,$00,$FF	; 82B8
.byte $06,$2D,$16,$01,$32,$00,$00,$00,$FF	; 82C1
.byte $06,$2D,$1B,$01,$32,$00,$00,$00,$FF	; 82CA
.byte $06,$32,$3A,$01,$32,$00,$08,$00,$FF	; 82D3
.byte $06,$37,$4C,$01,$32,$20,$00,$05,$FF	; 82DC
.byte $06,$3C,$5F,$01,$32,$00,$10,$00,$6F	; 82E5
.byte $07,$32,$01,$00,$46,$00,$00,$00,$FF	; 82EE
.byte $07,$28,$05,$00,$46,$00,$00,$00,$FF	; 82F7
.byte $07,$28,$0D,$00,$46,$00,$00,$00,$FF	; 8300
.byte $07,$00,$19,$00,$46,$00,$00,$03,$FF	; 8309
.byte $07,$2F,$2A,$00,$46,$02,$00,$00,$FF	; 8312
.byte $07,$32,$38,$00,$46,$80,$00,$00,$FF	; 831B
.byte $07,$00,$00,$00,$46,$00,$00,$81,$FF	; 8324
.byte $07,$4B,$5A,$00,$46,$00,$00,$00,$67	; 832D
; ========== weapon properties (64 * 9 bytes) ($80F6-$8335) END ==========


; ========== item/attack properties (135 * 5 bytes) ($8336-$85D8) START ==========
; 00: Spell, 01: Level, 02: Accuracy(replaces Int/soul)
; 03: Targetting = 01= enemy party
;		   02= single enemy target
;		   03= no clue
;		   04= no clude
;		   05= self
;		   06= caster party
; 04: Consumption rate
ItemAttack_prop:
.byte $36,$07,$50,$01,$00		; 8336
.byte $FF,$00,$00,$00,$00		; 833B
.byte $29,$01,$64,$05,$64		; 8340
.byte $2B,$01,$64,$05,$64		; 8345
.byte $2F,$01,$64,$05,$64		; 834A
.byte $2C,$01,$64,$05,$64		; 834F
.byte $2E,$01,$64,$05,$64		; 8354
.byte $2D,$01,$64,$05,$64		; 8359
.byte $2A,$01,$64,$05,$64		; 835E
.byte $30,$01,$64,$05,$64		; 8363
.byte $32,$0F,$64,$05,$64		; 8368
.byte $31,$01,$64,$05,$64		; 836D
.byte $29,$03,$64,$05,$64		; 8372
.byte $FF,$00,$00,$00,$00		; 8377
.byte $40,$0D,$5F,$01,$14		; 837C
.byte $3F,$0A,$5F,$01,$05		; 8381
.byte $42,$03,$5F,$01,$32		; 8386
.byte $17,$10,$64,$06,$0A		; 838B
.byte $37,$10,$5F,$01,$64		; 8390
.byte $33,$00,$64,$05,$64		; 8395
.byte $34,$00,$64,$05,$64		; 839A
.byte $13,$08,$50,$05,$0A		; 839F
.byte $23,$09,$5F,$01,$32		; 83A4
.byte $20,$10,$64,$01,$64		; 83A9
.byte $0A,$08,$5F,$01,$32		; 83AE
.byte $25,$0A,$64,$01,$0A		; 83B3
.byte $35,$06,$64,$05,$64		; 83B8
.byte $39,$10,$64,$01,$64		; 83BD
.byte $08,$10,$64,$01,$64		; 83C2
.byte $1C,$10,$64,$05,$64		; 83C7
.byte $0B,$10,$64,$01,$64		; 83CC
.byte $1D,$10,$64,$05,$64		; 83D1
.byte $01,$05,$3C,$01,$0A		; 83D6
.byte $01,$08,$64,$01,$64		; 83DB
.byte $02,$08,$64,$01,$64		; 83E0
.byte $03,$08,$64,$01,$64		; 83E5
.byte $04,$08,$64,$01,$64		; 83EA
.byte $05,$08,$64,$01,$64		; 83EF
.byte $06,$08,$64,$01,$64		; 83F4
.byte $07,$08,$64,$01,$64		; 83F9
.byte $08,$06,$64,$01,$64		; 83FE
.byte $09,$06,$64,$01,$64		; 8403
.byte $0A,$06,$64,$01,$64		; 8408
.byte $0B,$06,$64,$01,$64		; 840D
.byte $0C,$06,$64,$01,$64		; 8412
.byte $0D,$06,$64,$01,$64		; 8417
.byte $0E,$06,$64,$01,$64		; 841C
.byte $0F,$06,$64,$01,$64		; 8421
.byte $10,$06,$64,$01,$64		; 8426
.byte $11,$06,$64,$01,$64		; 842B
.byte $12,$06,$32,$05,$64		; 8430
.byte $13,$06,$32,$06,$64		; 8435
.byte $14,$06,$32,$05,$64		; 843A
.byte $15,$08,$64,$06,$64		; 843F
.byte $16,$08,$64,$06,$64		; 8444
.byte $17,$08,$64,$06,$64		; 8449
.byte $18,$08,$64,$06,$64		; 844E
.byte $19,$08,$64,$06,$64		; 8453
.byte $1A,$08,$64,$06,$64		; 8458
.byte $1B,$08,$64,$06,$64		; 845D
.byte $1C,$08,$64,$06,$64		; 8462
.byte $1D,$08,$64,$06,$64		; 8467
.byte $1E,$08,$64,$01,$64		; 846C
.byte $1F,$08,$64,$01,$64		; 8471
.byte $20,$08,$64,$01,$64		; 8476
.byte $21,$08,$64,$01,$64		; 847B
.byte $22,$08,$64,$01,$64		; 8480
.byte $23,$08,$64,$01,$64		; 8485
.byte $24,$08,$64,$01,$64		; 848A
.byte $25,$08,$64,$01,$64		; 848F
.byte $26,$08,$64,$01,$64		; 8494
.byte $27,$08,$64,$01,$64		; 8499
.byte $28,$08,$64,$01,$64		; 849E
.byte $01,$0B,$64,$01,$00		; 84A3
.byte $01,$10,$64,$02,$00		; 84A8
.byte $02,$05,$64,$01,$00		; 84Ad
.byte $02,$0A,$64,$01,$00		; 84B2
.byte $03,$05,$64,$01,$00		; 84B7
.byte $24,$04,$3C,$02,$00		; 84BC
.byte $03,$0C,$64,$01,$00		; 84C1
.byte $04,$05,$64,$01,$00		; 84C6
.byte $15,$06,$64,$02,$00		; 84Cb
.byte $04,$10,$64,$02,$00		; 84D0
.byte $05,$08,$64,$01,$00		; 84D5
.byte $05,$10,$64,$02,$00		; 84DA
.byte $06,$08,$3C,$01,$00		; 84DF
.byte $06,$0A,$28,$02,$00		; 84E4
.byte $07,$0A,$64,$01,$00		; 84E9
.byte $07,$10,$64,$02,$00		; 84EE
.byte $08,$04,$46,$01,$00		; 84F3
.byte $09,$10,$64,$02,$00		; 84F8
.byte $0B,$10,$64,$02,$00		; 84FD
.byte $0C,$04,$46,$01,$00		; 8502
.byte $0C,$10,$64,$02,$00		; 8507
.byte $0D,$08,$46,$01,$00		; 850C
.byte $0D,$10,$64,$02,$00		; 8511
.byte $0E,$07,$46,$01,$00		; 8516
.byte $0E,$0A,$4B,$02,$00		; 851B
.byte $0F,$06,$1E,$02,$00		; 8520
.byte $10,$08,$32,$01,$00		; 8525
.byte $10,$10,$32,$02,$00		; 852A
.byte $11,$07,$28,$01,$00		; 852F
.byte $11,$09,$1E,$02,$00		; 8534
.byte $12,$03,$64,$06,$00		; 8539
.byte $13,$0B,$64,$06,$00		; 853E
.byte $19,$08,$64,$06,$00		; 8543
.byte $1A,$03,$32,$05,$00		; 8548
.byte $1A,$08,$32,$05,$00		; 854D
.byte $1A,$10,$32,$05,$00		; 8552
.byte $1E,$10,$64,$01,$00		; 8557
.byte $1F,$07,$3C,$01,$00		; 855C
.byte $22,$06,$28,$01,$00		; 8561
.byte $23,$10,$64,$02,$00		; 8566
.byte $3C,$06,$46,$01,$00		; 856B
.byte $3C,$09,$5A,$02,$00		; 8570
.byte $3D,$01,$32,$02,$00		; 8575
.byte $3D,$03,$3C,$02,$00		; 857A
.byte $3D,$05,$46,$02,$00		; 857F
.byte $3D,$07,$50,$02,$00		; 8584
.byte $43,$01,$2D,$02,$00		; 8589
.byte $44,$09,$4B,$02,$00		; 858E
.byte $36,$10,$64,$01,$00		; 8593
.byte $37,$0D,$64,$01,$00		; 8598
.byte $38,$08,$64,$01,$00		; 859D
.byte $38,$10,$64,$01,$00		; 85A2
.byte $38,$0C,$64,$02,$00		; 85A7
.byte $39,$0D,$64,$01,$00		; 85AC
.byte $3B,$05,$50,$02,$00		; 85B1
.byte $3B,$09,$5A,$02,$00		; 85B6
.byte $3A,$06,$3C,$01,$00		; 85BB
.byte $3A,$0A,$3C,$01,$00		; 85C0
.byte $41,$08,$64,$01,$00		; 85C5
.byte $46,$0A,$64,$01,$00		; 85CA
.byte $45,$0A,$50,$01,$00		; 85CF
.byte $43,$03,$41,$02,$00		; 85D4
; ========== item/attack properties (135 * 5 bytes) ($8336-$85D8) END ==========


; ========== magic properties (70 * 7 bytes) ($85D9-$87C2) START ==========
; 00: Type(
;	00h=
;	01h=direct damage, 02h=healing effect
;	03h=permanent ailment, 04h=temporary ailment
;	05h=reduces attacks
;	06h=adds to hits
;	07h=Raises morale
;	08h=reverses permanent ailment
;	09h=reverses temporary ailment
;	0Ah=Raises defense
;	0Bh=adds element resistance
;	0Ch=adds element
;	0Dh=Lower elemental resistance
;	0Eh=adds to evade
;	0Fh=Raises magic defense
;	10h=ressurection
;	11h=Lose 50% MP
;	12h=HP<->MP
;	13h=drain HP, 14h=drain MP
;	15h=adds attack power
;	16h=cancels low level magic
;	1Ch=Ultima
;	21h=meteo
; 01: Accuracy modifier
; 02: Sepll power (for direct damage)
; 03: Element
;	Bit7=Ice, Bit6=Physical status spells (Paralysis, Blind, etc)
;	Bit5=Poison (Aero, Mist, etc), Bit4=Death spell
;	Bit3=Lightning, Bit2=Mental status spells (Fog, Sleep, etc)
;	Bit1=Fire, Bit0=Dimensiona; stuff (Stop, Warp, Toad, Change, etc)
; 04: Status, used by status ailment spells only
; 05: Palette
; 06: Animation
Magic_prop:
.byte $01,$00,$0A,$02,$00,$10,$00	; 85D9
.byte $01,$00,$0A,$08,$00,$11,$01	; 85E0
.byte $01,$00,$0A,$80,$00,$12,$02	; 85E7
.byte $01,$00,$0A,$20,$00,$13,$03	; 85EE
.byte $13,$00,$0A,$00,$00,$16,$09	; 85F5
.byte $14,$00,$0A,$00,$00,$12,$09	; 85FC
.byte $01,$00,$14,$00,$00,$10,$04	; 8603
.byte $04,$32,$05,$04,$08,$15,$08	; 860A
.byte $04,$28,$05,$40,$40,$18,$08	; 8611
.byte $04,$1E,$05,$01,$40,$14,$08	; 8618
.byte $04,$1E,$05,$04,$80,$17,$08	; 861F
.byte $03,$32,$05,$40,$02,$60,$08	; 8626
.byte $03,$28,$05,$04,$08,$6B,$08	; 862D
.byte $03,$1E,$05,$01,$20,$10,$10	; 8634
.byte $03,$14,$05,$01,$40,$12,$07	; 863B
.byte $03,$0A,$05,$10,$80,$10,$06	; 8642
.byte $03,$0A,$05,$01,$80,$15,$05	; 8649
.byte $15,$32,$05,$00,$00,$17,$0A	; 8650
.byte $06,$32,$00,$00,$00,$18,$0A	; 8657
.byte $0C,$32,$00,$00,$00,$14,$0A	; 865E
.byte $02,$32,$14,$00,$00,$18,$0B	; 8665
.byte $10,$32,$00,$00,$80,$10,$0B	; 866C
.byte $09,$32,$02,$00,$00,$19,$0B	; 8673
.byte $08,$32,$01,$00,$00,$15,$0B	; 867A
.byte $0B,$32,$00,$00,$00,$1A,$0C	; 8681
.byte $0E,$32,$00,$00,$00,$14,$0E	; 8688
.byte $0A,$32,$00,$00,$00,$11,$0E	; 868F
.byte $0F,$32,$00,$00,$00,$12,$0E	; 8696
.byte $16,$32,$00,$00,$00,$15,$0C	; 869D
.byte $0D,$28,$00,$00,$00,$10,$0D	; 86A4
.byte $04,$14,$05,$01,$20,$10,$11	; 86AB
.byte $04,$1E,$05,$40,$10,$15,$08	; 86B2
.byte $11,$28,$05,$04,$00,$19,$08	; 86B9
.byte $03,$14,$05,$04,$10,$10,$08	; 86C0
.byte $05,$1E,$05,$40,$00,$18,$08	; 86C7
.byte $12,$1E,$05,$01,$00,$16,$08	; 86CE
.byte $07,$32,$14,$04,$00,$6D,$08	; 86D5
.byte $01,$00,$0F,$00,$00,$14,$04	; 86DC
.byte $03,$00,$05,$01,$80,$10,$05	; 86E3
.byte $1C,$32,$64,$00,$00,$15,$0F	; 86EA
.byte $02,$64,$1E,$00,$00,$18,$0B	; 86F1
.byte $17,$64,$00,$00,$FD,$12,$0B	; 86F8
.byte $17,$64,$00,$00,$FB,$13,$0B	; 86FF
.byte $17,$64,$00,$00,$F7,$11,$0B	; 8706
.byte $17,$64,$00,$00,$EF,$14,$0B	; 870D
.byte $17,$64,$00,$00,$DF,$15,$0B	; 8714
.byte $17,$64,$00,$00,$BF,$16,$0B	; 871B
.byte $10,$64,$00,$00,$7F,$19,$0B	; 8722
.byte $1E,$64,$14,$00,$00,$17,$0B	; 8729
.byte $1B,$64,$64,$00,$00,$10,$0B	; 8730
.byte $1F,$64,$00,$63,$00,$1A,$0B	; 8737
.byte $1F,$64,$00,$63,$01,$1B,$0B	; 873E
.byte $20,$64,$0A,$00,$00,$1C,$0B	; 8745
.byte $01,$32,$14,$02,$00,$10,$00	; 874C
.byte $01,$32,$14,$80,$00,$12,$02	; 8753
.byte $01,$32,$14,$08,$00,$11,$01	; 875A
.byte $01,$32,$14,$20,$00,$13,$03	; 8761
.byte $03,$32,$00,$01,$40,$12,$07	; 8768
.byte $03,$32,$00,$01,$40,$12,$07	; 876F
.byte $04,$32,$00,$04,$80,$17,$08	; 8776
.byte $1D,$32,$14,$00,$00,$00,$14	; 877D
.byte $00,$00,$00,$FF,$FF,$FF,$FF	; 8784
.byte $18,$32,$14,$01,$04,$10,$12	; 878B
.byte $18,$32,$14,$04,$01,$1B,$02	; 8792
.byte $18,$32,$14,$01,$02,$60,$12	; 8799
.byte $19,$32,$1E,$00,$00,$14,$0B	; 87A0
.byte $21,$1E,$07,$00,$00,$13,$16	; 87A7
.byte $21,$1E,$0F,$00,$00,$6D,$17	; 87AE
.byte $04,$32,$00,$00,$40,$11,$13	; 87B5
.byte $21,$64,$46,$00,$00,$15,$15	; 87BC
; ========== magic properties (70 * 7 bytes) ($85D9-$87C2) END ==========


; ========== monster properties (128 * 10 bytes) ($87C3-$8CC2) START ==========
; 00h= AI Attack pattern
; 01h= HP
; 02h= MP
; 03h= Attack count | Accuracy
; 04h= Strength | Attack type
; 05h= Defense count | Evade
; 06h = Defense | Magic Defense
; 07h= Magic Evade | Monster race
; 08h= Elemental resistance | Elemental weakness
; 09h= Morale | Elemental absorb
Mob_prop:
.byte $FF,$01,$00,$16,$10,$00,$01,$53,$30,$E0	; 87C3
.byte $FF,$03,$00,$16,$1A,$00,$01,$53,$30,$D0	; 87CD
.byte $FF,$01,$00,$15,$1A,$11,$01,$51,$00,$E0	; 87D7
.byte $FF,$04,$00,$15,$25,$11,$11,$51,$00,$D0	; 87E1
.byte $FF,$05,$00,$16,$20,$12,$12,$40,$0A,$D7	; 87EB
.byte $FF,$03,$00,$15,$10,$11,$01,$50,$00,$D0	; 87F5
.byte $FF,$06,$00,$16,$30,$00,$32,$40,$1A,$D7	; 87FF
.byte $FF,$0B,$00,$28,$50,$13,$53,$40,$15,$B0	; 8809
.byte $FF,$0B,$00,$38,$60,$13,$63,$40,$10,$90	; 8813
.byte $FF,$04,$00,$15,$20,$14,$01,$50,$00,$D0	; 881D
.byte $FF,$09,$00,$27,$50,$13,$42,$50,$00,$C0	; 8827
.byte $FF,$0E,$00,$29,$70,$00,$81,$5A,$77,$B0	; 8831
.byte $FF,$09,$00,$27,$50,$00,$52,$5A,$77,$C0	; 883B
.byte $FF,$08,$00,$17,$40,$12,$32,$55,$00,$C0	; 8845
.byte $00,$09,$04,$27,$40,$14,$33,$48,$00,$C0	; 884F
.byte $FF,$0C,$00,$38,$60,$14,$53,$45,$00,$B0	; 8859
.byte $FF,$07,$00,$25,$40,$12,$32,$55,$14,$D0	; 8863
.byte $FF,$0C,$00,$57,$60,$15,$43,$5C,$9A,$B1	; 886D
.byte $FF,$06,$00,$16,$35,$22,$12,$40,$20,$C0	; 8877
.byte $FF,$08,$00,$27,$38,$13,$32,$5B,$00,$C0	; 8881
.byte $FF,$05,$00,$16,$30,$12,$22,$4C,$9A,$D1	; 888B
.byte $01,$10,$0C,$69,$7E,$17,$64,$4E,$9A,$31	; 8895
.byte $FF,$04,$00,$16,$30,$00,$01,$5C,$9A,$D1	; 889F
.byte $FF,$06,$00,$16,$38,$12,$12,$4C,$9A,$D1	; 88A9
.byte $1F,$08,$04,$26,$48,$13,$22,$5C,$9A,$C1	; 88B3
.byte $FF,$0B,$00,$38,$6E,$14,$43,$4C,$9A,$B1	; 88BD
.byte $FF,$05,$00,$16,$36,$12,$22,$4C,$6A,$D1	; 88C7
.byte $FF,$06,$00,$17,$2E,$22,$22,$5D,$AA,$C1	; 88D1
.byte $20,$0C,$08,$39,$4E,$14,$43,$5F,$AA,$A1	; 88DB
.byte $21,$0F,$09,$59,$5E,$16,$53,$5F,$AA,$91	; 88E5
.byte $FF,$0D,$00,$39,$78,$15,$63,$53,$D8,$A0	; 88EF
.byte $FF,$12,$00,$6A,$90,$18,$84,$41,$00,$40	; 88F9
.byte $05,$19,$07,$6C,$90,$17,$85,$40,$00,$70	; 8903
.byte $06,$13,$09,$6A,$95,$19,$86,$66,$E0,$00	; 890D
.byte $07,$10,$07,$49,$80,$15,$73,$59,$00,$A0	; 8917
.byte $08,$11,$09,$5A,$80,$16,$74,$49,$00,$80	; 8921
.byte $09,$14,$0D,$6C,$A0,$18,$95,$49,$00,$00	; 892B
.byte $FF,$0F,$00,$4A,$67,$00,$63,$50,$3D,$A0	; 8935
.byte $FF,$14,$00,$6B,$9C,$17,$95,$80,$9A,$71	; 893F
.byte $FF,$08,$00,$27,$40,$13,$32,$52,$C6,$B0	; 8949
.byte $0A,$0F,$07,$4A,$80,$15,$74,$42,$C0,$86	; 8953
.byte $FF,$09,$00,$27,$50,$15,$32,$51,$00,$C0	; 895D
.byte $FF,$0D,$00,$48,$52,$15,$63,$51,$00,$90	; 8967
.byte $FF,$05,$00,$16,$30,$13,$12,$40,$00,$B0	; 8971
.byte $FF,$07,$00,$27,$40,$14,$32,$50,$00,$B0	; 897B
.byte $02,$0B,$03,$19,$40,$14,$33,$50,$00,$00	; 8985
.byte $03,$1A,$0D,$6D,$C8,$16,$C9,$EC,$9A,$01	; 898F
.byte $FF,$14,$00,$4B,$70,$16,$76,$30,$00,$80	; 8999
.byte $FF,$0C,$00,$3B,$60,$13,$53,$50,$00,$B0	; 89A3
.byte $FF,$0C,$00,$38,$55,$13,$53,$50,$07,$B0	; 89AD
.byte $FF,$0E,$00,$49,$65,$15,$63,$50,$07,$B0	; 89B7
.byte $FF,$0C,$00,$39,$65,$14,$63,$52,$C6,$B0	; 89C1
.byte $0D,$12,$07,$5A,$90,$16,$84,$42,$C6,$80	; 89CB
.byte $FF,$0E,$00,$49,$68,$15,$63,$53,$00,$A0	; 89D5
.byte $FF,$12,$00,$5A,$90,$16,$84,$42,$C6,$80	; 89DF
.byte $FF,$11,$00,$6A,$80,$17,$74,$41,$00,$90	; 89E9
.byte $0E,$09,$07,$28,$50,$15,$43,$4B,$23,$B0	; 89F3
.byte $0F,$0B,$08,$49,$60,$16,$53,$5B,$23,$A0	; 89FD
.byte $FF,$0C,$00,$38,$5F,$14,$63,$51,$17,$A0	; 8A07
.byte $10,$11,$0C,$69,$63,$17,$74,$41,$17,$10	; 8A11
.byte $FF,$0F,$00,$4A,$75,$15,$74,$4B,$20,$80	; 8A1B
.byte $04,$12,$0C,$8A,$90,$19,$76,$66,$00,$00	; 8A25
.byte $13,$0C,$08,$48,$55,$15,$53,$E7,$E0,$80	; 8A2F
.byte $14,$11,$0C,$8A,$86,$17,$76,$67,$80,$2A	; 8A39
.byte $FF,$11,$00,$5A,$78,$16,$74,$42,$C6,$90	; 8A43
.byte $FF,$13,$00,$7A,$8B,$17,$86,$33,$70,$70	; 8A4D
.byte $FF,$15,$00,$8B,$AD,$18,$A5,$83,$00,$10	; 8A57
.byte $15,$11,$09,$6A,$90,$17,$76,$3A,$00,$70	; 8A61
.byte $17,$15,$0C,$8C,$B0,$18,$A5,$86,$07,$1A	; 8A6B
.byte $16,$13,$0A,$7B,$A0,$17,$96,$3A,$0A,$77	; 8A75
.byte $FF,$14,$00,$69,$B5,$00,$86,$34,$40,$55	; 8A7F
.byte $18,$14,$0C,$7C,$A1,$18,$95,$84,$F0,$15	; 8A89
.byte $FF,$19,$00,$6D,$C0,$11,$B4,$57,$00,$00	; 8A93
.byte $19,$15,$0A,$7B,$B0,$18,$66,$34,$00,$30	; 8A9D
.byte $1A,$15,$0D,$8C,$D0,$18,$A5,$84,$30,$0B	; 8AA7
.byte $FF,$02,$01,$15,$1A,$00,$F1,$54,$4D,$D5	; 8AB1
.byte $FF,$05,$01,$16,$35,$00,$F2,$44,$6D,$D5	; 8ABB
.byte $FF,$08,$05,$27,$45,$00,$F2,$54,$A6,$B5	; 8AC5
.byte $FF,$0D,$07,$4A,$65,$00,$F3,$54,$BA,$95	; 8ACF
.byte $1E,$0F,$04,$1A,$50,$16,$64,$47,$00,$AF	; 8AD9
.byte $1D,$01,$06,$18,$40,$14,$33,$47,$00,$EF	; 8AE3
.byte $1C,$03,$07,$18,$50,$14,$43,$47,$00,$EF	; 8AED
.byte $11,$0F,$08,$5A,$6E,$16,$74,$4F,$BA,$71	; 8AF7
.byte $12,$14,$09,$6B,$AE,$18,$A6,$3F,$BA,$31	; 8B01
.byte $0B,$15,$0A,$6A,$90,$17,$74,$40,$00,$00	; 8B0B
.byte $0C,$1B,$0B,$8E,$C4,$1A,$C8,$3F,$A0,$01	; 8B15
.byte $FF,$11,$00,$59,$80,$16,$74,$40,$07,$90	; 8B1F
.byte $FF,$14,$00,$7A,$A0,$18,$95,$40,$07,$00	; 8B29
.byte $22,$15,$0D,$8B,$A8,$19,$A5,$86,$80,$0A	; 8B33
.byte $FF,$12,$00,$69,$85,$17,$86,$30,$00,$00	; 8B3D
.byte $FF,$14,$00,$7A,$A0,$18,$A5,$40,$00,$00	; 8B47
.byte $FF,$15,$00,$8B,$CE,$18,$C5,$86,$9A,$01	; 8B51
.byte $FF,$17,$00,$6D,$B9,$15,$CB,$E6,$AA,$00	; 8B5B
.byte $23,$18,$0B,$7D,$C0,$15,$DB,$E6,$F5,$00	; 8B65
.byte $FF,$19,$00,$8D,$D0,$15,$EB,$E6,$F6,$00	; 8B6F
.byte $FF,$01,$00,$15,$10,$00,$01,$55,$00,$E0	; 8B79
.byte $24,$02,$01,$15,$10,$11,$01,$55,$00,$D0	; 8B83
.byte $25,$04,$02,$16,$20,$11,$12,$45,$00,$D0	; 8B8D
.byte $26,$03,$02,$15,$20,$00,$01,$51,$3C,$D0	; 8B97
.byte $27,$06,$02,$17,$40,$00,$32,$51,$3C,$D0	; 8BA1
.byte $28,$0A,$04,$28,$50,$00,$43,$41,$3C,$C0	; 8BAB
.byte $29,$10,$09,$5A,$80,$00,$74,$41,$3C,$80	; 8BB5
.byte $24,$05,$02,$16,$30,$11,$22,$50,$00,$D0	; 8BBF
.byte $2A,$09,$02,$28,$50,$13,$43,$50,$00,$C0	; 8BC9
.byte $2A,$11,$04,$6A,$80,$16,$74,$50,$00,$B0	; 8BD3
.byte $FF,$18,$00,$9D,$C0,$19,$B4,$60,$00,$40	; 8BDD
.byte $2C,$07,$04,$17,$30,$14,$23,$66,$00,$C0	; 8BE7
.byte $2D,$09,$06,$18,$40,$15,$33,$66,$00,$90	; 8BF1
.byte $2E,$0F,$0A,$19,$60,$18,$54,$66,$00,$50	; 8BFB
.byte $FF,$0A,$00,$28,$55,$13,$43,$4B,$20,$C0	; 8C05
.byte $2F,$13,$0C,$79,$61,$18,$85,$40,$00,$20	; 8C0F
.byte $30,$13,$06,$6B,$99,$17,$96,$36,$00,$50	; 8C19
.byte $31,$15,$0D,$8D,$79,$29,$77,$46,$00,$20	; 8C23
.byte $FF,$11,$00,$3A,$B0,$13,$84,$45,$00,$C0	; 8C2D
.byte $2B,$18,$0B,$6D,$B0,$14,$B4,$55,$07,$7A	; 8C37
.byte $32,$19,$09,$7D,$C0,$15,$C4,$55,$0A,$67	; 8C41
.byte $33,$1A,$0D,$8D,$D0,$16,$D4,$55,$05,$66	; 8C4B
.byte $FF,$17,$00,$3D,$A0,$14,$74,$53,$00,$A0	; 8C55
.byte $FF,$1D,$00,$8E,$D0,$15,$C8,$33,$00,$00	; 8C5F
.byte $16,$1A,$09,$6D,$D0,$19,$C5,$59,$0A,$07	; 8C69
.byte $34,$1B,$0A,$7E,$D0,$19,$D8,$49,$06,$05	; 8C73
.byte $35,$1C,$0B,$8E,$E0,$19,$D8,$49,$05,$06	; 8C7D
.byte $17,$1D,$0E,$8E,$E0,$19,$E8,$49,$07,$0A	; 8C87
.byte $34,$1C,$0B,$AE,$E0,$00,$EB,$E6,$49,$0A	; 8C91
.byte $36,$1D,$0E,$8E,$D5,$1A,$E8,$89,$14,$0E	; 8C9B
.byte $37,$1D,$0E,$8E,$D5,$1A,$E8,$87,$80,$0A	; 8CA5
.byte $38,$1E,$0F,$8E,$DE,$1A,$E8,$87,$E0,$00	; 8CAF
.byte $39,$1F,$0F,$8E,$EE,$1A,$FC,$84,$F0,$02	; 8CB9
; ====== monster properties (128 * 10 bytes) ($87C2-$8CC2) END ==========


; ========== monster hp/mp values (32 * 2 bytes) ($8CC3-$8D02) START ==========
Mob_HMP_tbl:
.byte $00,$00,$06,$00,$0A,$00,$14,$00,$1E,$00,$2D,$00,$3C
.byte $00,$50,$00,$64,$00,$8C,$00,$BE,$00,$F0,$00,$2C,$01,$72,$01,$C2
.byte $01,$1C,$02,$80,$02,$EE,$02,$66,$03,$E8,$03,$74,$04,$0A,$05,$AA
.byte $05,$54,$06,$08,$07,$D0,$07,$C4,$09,$B8,$0B,$AC,$0D,$88,$13,$58
;; [$8D00 :: 0x30D10]
.byte $1B
.byte $10,$27
; ========== monster hp/mp values (32 * 2 bytes) ($8CC3-$8D02) END ==========


; ========== monster stat values (7 * 16 bytes) ($8D03-$8D72) START ==========
; 8D03 Attack count, defense count, magic defense
Mob_stat1_tbl:
.byte $00,$01,$02,$03,$04,$05,$06,$07,$08,$0A,$0C,$0E,$10,$12,$14,$FF
; 8D13 accuracy, evade, gamic evade
Mob_stat2_tbl:
.byte $00,$0A,$14,$1E,$28,$32,$3C,$41,$46,$4B,$50,$55,$5A,$5F,$64,$FF
; 8D23 Strength, defense, morale
Mob_stat3_tbl:
.byte $00,$04,$09,$11,$19,$23,$28,$32,$3C,$46,$55,$64,$78,$96,$B4,$D2
; 8D33 Added effect table
Mob_stat4_tbl:
.byte $00,$81,$41,$11,$09,$05,$03,$82,$42,$0A,$06,$46,$86,$FE,$04,$08
; 8D43 Monster race
Mob_stat5_tbl:
.byte $00,$01,$02,$04,$05,$08,$10,$15,$18,$21,$24,$40,$80,$85,$91,$95
; 8D53 Elemental resistance
Mob_stat6_tbl:
.byte $00,$04,$50,$44,$55,$21,$5D,$28,$80,$C4,$F5,$FD,$22,$0A,$8A,$FF
; 8D63 Elemental weakness/absorb
Mob_stat7_tbl:
.byte $00,$10,$11,$04,$40,$20,$08,$80,$A0,$88,$02,$12,$0A,$82,$AA,$FF
; ========== monster stat values (7 * 16 bytes) ($8D03-$8D72) END ==========


; ========== monster special attacks (58 * 8 bytes) ($8D73-$8F42) START ==========
Mob_AI:
.byte $4E,$4E,$4E,$6B,$5D,$5A,$4E,$4E	; 8D73
.byte $50,$50,$50,$5B,$5B,$5B,$62,$62	; 8D7B
.byte $00,$00,$00,$0D,$0D,$0D,$00,$00	; 8D83
.byte $59,$59,$00,$00,$00,$00,$59,$59	; 8D8B
.byte $4A,$00,$00,$4A,$5F,$5F,$1F,$67	; 8D93
.byte $00,$00,$00,$00,$00,$1B,$34,$34	; 8D9B
.byte $19,$3F,$00,$70,$4D,$00,$70,$4D	; 8DA3
.byte $01,$00,$00,$01,$00,$00,$01,$00	; 8DAB
.byte $01,$00,$00,$01,$00,$82,$01,$82	; 8DB3
.byte $7A,$00,$00,$7A,$83,$83,$7A,$6E	; 8DBB
.byte $7C,$00,$00,$7C,$00,$00,$7C,$00	; 8DC3
.byte $00,$00,$4D,$17,$16,$0B,$6C,$6A	; 8DCB
.byte $00,$00,$5F,$64,$5F,$64,$5F,$64	; 8DD3
.byte $84,$00,$00,$00,$00,$00,$00,$84	; 8DDB
.byte $00,$00,$00,$4F,$4F,$4F,$00,$00	; 8DE3
.byte $00,$00,$00,$4F,$4F,$4F,$70,$70	; 8DEB
.byte $00,$00,$00,$55,$55,$55,$57,$57	; 8DF3
.byte $72,$00,$00,$00,$00,$00,$00,$72	; 8DFB
.byte $73,$50,$00,$1D,$00,$00,$00,$73	; 8E03
.byte $00,$00,$00,$1F,$1F,$1F,$6C,$6C	; 8E0B
.byte $4B,$5B,$00,$4B,$5B,$00,$00,$00	; 8E13
.byte $80,$80,$80,$00,$00,$00,$00,$00	; 8E1B
.byte $13,$00,$00,$13,$00,$00,$00,$13	; 8E23
.byte $7A,$00,$00,$7A,$00,$00,$00,$7A	; 8E2B
.byte $55,$57,$5C,$81,$71,$5B,$6E,$67	; 8E33
.byte $10,$00,$10,$00,$00,$00,$00,$00	; 8E3B
.byte $0F,$00,$0F,$00,$00,$00,$00,$00	; 8E43
.byte $00,$00,$46,$3C,$32,$28,$1E,$14	; 8E4B
.byte $21,$21,$21,$21,$21,$21,$21,$21	; 8E53
.byte $52,$52,$52,$52,$52,$52,$52,$52	; 8E5B
.byte $22,$23,$24,$25,$22,$23,$24,$25	; 8E63
.byte $5D,$00,$00,$00,$00,$00,$00,$00	; 8E6B
.byte $00,$00,$00,$00,$29,$24,$00,$30	; 8E73
.byte $00,$00,$00,$5F,$5B,$53,$00,$6F	; 8E7B
.byte $4B,$00,$00,$00,$00,$00,$00,$4B	; 8E83
.byte $19,$00,$00,$00,$00,$00,$00,$19	; 8E8B
.byte $78,$00,$00,$00,$00,$00,$00,$78	; 8E93
.byte $87,$5A,$00,$00,$5A,$87,$00,$00	; 8E9B
.byte $74,$74,$00,$74,$74,$74,$74,$74	; 8EA3
.byte $75,$75,$00,$75,$75,$75,$75,$75	; 8EAB
.byte $76,$76,$00,$76,$76,$76,$76,$76	; 8EB3
.byte $77,$77,$00,$77,$77,$77,$77,$77	; 8EBB
.byte $87,$00,$00,$00,$00,$00,$00,$87	; 8EC3
.byte $79,$4B,$00,$79,$4B,$00,$00,$00	; 8ECB
.byte $21,$4E,$4C,$51,$5D,$5A,$68,$68	; 8ED3
.byte $26,$22,$24,$2A,$2C,$34,$2E,$31	; 8EDB
.byte $54,$56,$58,$4A,$19,$61,$63,$66	; 8EE3
.byte $00,$86,$86,$00,$00,$00,$00,$00	; 8EEB
.byte $72,$72,$00,$00,$00,$00,$00,$3B	; 8EF3
.byte $73,$73,$00,$00,$00,$00,$00,$6D	; 8EFB
.byte $50,$50,$00,$79,$79,$00,$00,$00	; 8F03
.byte $7E,$7E,$00,$79,$79,$00,$00,$00	; 8F0B
.byte $1C,$00,$00,$1C,$00,$00,$00,$1C	; 8F13
.byte $7D,$00,$00,$7D,$00,$00,$00,$7D	; 8F1B
.byte $7A,$13,$7D,$1C,$1C,$00,$00,$00	; 8F23
.byte $59,$4B,$00,$5B,$5C,$00,$6D,$6E	; 8F2B
.byte $55,$53,$4B,$00,$00,$5E,$65,$00	; 8F33
.byte $00,$85,$59,$00,$71,$60,$6E,$5E	; 8F3B
; ========== monster special attacks (58 * 8 bytes) ($8D73-$8F42) END ==========


; ========== battle main code ($8F43-$BFFF) START ==========
; $8F43- 
	JMP $9028		; 8F43	$4C $28 $90	battle main
; End of

; Name	:
; Marks	:
	JMP $8F5E		; 8F46	$4C $5E $8F	sort values
; End of
	JMP $9868		; 8F49	$4C $68 $98	init battle stats
	JMP $95E7		; 8F4C	$4C $E7 $95	copy text to buffer
;8F4F
	JMP $9250		; 8F4F	$4C $50 $92	open window
	JMP $96E1		; 8F52	$4C $E1 $96	update character/monster pointers
	JMP $9749		; 8F55	$4C $49 $97	convert hex to decimal
;8F58
	JMP $96B5		; 8F58	$4C $B5 $96
	JMP $9D02		; 8F5B	$4C $02 $9D	set positions for 16x16 sprite
;

; Marks	: sort values
;	  $02= index of first value
;	  A= index of last value
;	  $04(ADDR)= pointer to values
;	  $06(ADDR)= pointer to buffer for sorted indices
	PHA			; 8F5E	$48
	SEC			; 8F5F	$38
	SBC $02			; 8F60	$E5 $02
	TAX			; 8F62	$AA
	INX			; 8F63	$E8
	STX $00			; 8F64	$86 $00
	LDY #$01		; 8F66	$A0 $01
	LDX #$00		; 8F68	$A2 $00
L30F6A:
	TXA			; 8F6A	$8A
	STA ($06),Y		; 8F6B	$91 $06		turn order queue ??
	INY			; 8F6D	$C8
	INX			; 8F6E	$E8
	CPX $00			; 8F6F	$E4 $00
	BNE L30F6A		; 8F71	$D0 $F7
	PLA			; 8F73	$68
; Name	:
; Marks	:
	STA $03			; 8F74	$85 $03
	LDA $00			; 8F76	$A5 $00
	PHA			; 8F78	$48
	LDA $01			; 8F79	$A5 $01
	PHA			; 8F7B	$48
	TXA			; 8F7C	$8A
	PHA			; 8F7D	$48
	LDX $02			; 8F7E	$A6 $02
	STX $00			; 8F80	$86 $00
	LDY $03			; 8F82	$A4 $03
	STY $01			; 8F84	$84 $01
	LDY $02			; 8F86	$A4 $02
	LDA ($04),Y		; 8F88	$B1 $04
	STA $08			; 8F8A	$85 $08
L30F8C:
	LDY $03			; 8F8C	$A4 $03
	CPY $02			; 8F8E	$C4 $02
	BCC L30FD8		; 8F90	$90 $46
L30F92:
	LDA ($04),Y		; 8F92	$B1 $04
	CMP $08			; 8F94	$C5 $08
	BCS L30F9B		; 8F96	$B0 $03
	DEY			; 8F98	$88
	BCC L30F92		; 8F99	$90 $F7
L30F9B:
	STY $03			; 8F9B	$84 $03
	LDY $02			; 8F9D	$A4 $02
L30F9F:
	LDA ($04),Y		; 8F9F	$B1 $04
	CMP $08			; 8FA1	$C5 $08
	BEQ L30FAA		; 8FA3	$F0 $05
	BCC L30FAA		; 8FA5	$90 $03
	INY			; 8FA7	$C8
	BCS L30F9F		; 8FA8	$B0 $F5
L30FAA:
	STY $02			; 8FAA	$84 $02
	LDY $03			; 8FAC	$A4 $03
	CPY $02			; 8FAE	$C4 $02
	BCC L30FD8		; 8FB0	$90 $26
	LDA ($04),Y		; 8FB2	$B1 $04
	TAX			; 8FB4	$AA
	LDA ($06),Y		; 8FB5	$B1 $06
	STA $09			; 8FB7	$85 $09
	LDY $02			; 8FB9	$A4 $02
	LDA ($04),Y		; 8FBB	$B1 $04
	LDY $03			; 8FBD	$A4 $03
	STA ($04),Y		; 8FBF	$91 $04
	LDY $02			; 8FC1	$A4 $02
	LDA ($06),Y		; 8FC3	$B1 $06		turn order queue ??
	LDY $03			; 8FC5	$A4 $03
	STA ($06),Y		; 8FC7	$91 $06		turn order queue ??
	LDY $02			; 8FC9	$A4 $02
	LDA $09			; 8FCB	$A5 $09
	STA ($06),Y		; 8FCD	$91 $06
	TXA			; 8FCF	$8A
	STA ($04),Y		; 8FD0	$91 $04
	DEC $03			; 8FD2	$C6 $03
	INC $02			; 8FD4	$E6 $02
	BCS L30F8C		; 8FD6	$B0 $B4
L30FD8:
	LDX $02			; 8FD8	$A6 $02
	CPY $00			; 8FDA	$C4 $00
	BEQ L30FE8		; 8FDC	$F0 $0A
	BCC L30FE8		; 8FDE	$90 $08
	LDA $00			; 8FE0	$A5 $00
	STA $02			; 8FE2	$85 $02
	TYA			; 8FE4	$98
	JSR $8F74		; 8FE5	$20 $74 $8F
L30FE8:
	CPX $01			; 8FE8	$E4 $01
	BCS L30FF3		; 8FEA	$B0 $07
	STX $02			; 8FEC	$86 $02
	LDA $01			; 8FEE	$A5 $01
	JSR $8F74		; 8FF0	$20 $74 $8F
L30FF3:
	PLA			; 8FF3	$68
	TAX			; 8FF4	$AA
	PLA			; 8FF5	$68
	STA $01			; 8FF6	$85 $01
L30FF8:
	PLA			; 8FF8	$68
	STA $00			; 8FF9	$85 $00
	RTS			; 8FFB	$60
; End of

; compare (16-bit): compare $00(ADDR) with $02(ADDR)
	SEC			; 8FFC	$38
	LDA $00			; 8FFD	$A5 $00
	SBC $02			; 8FFF	$E5 $02
	STA $04			; 9001	$85 $04
	LDA $01			; 9003	$A5 $01
	SBC $03			; 9005	$E5 $03
	ORA $04			; 9007	$05 $04
	RTS			; 9009	$60
; End of

; set bit:
	ORA $9020,X		; 900A	$1D $20 $90
	RTS			; 900D	$60
; End of

; Name	:
; Marks	: clear bit
	EOR #$FF		; 900E	$49 $FF
	ORA $9020,X		; 9010	$1D $20 $90
	EOR #$FF		; 9013	$49 $FF
	RTS			; 9015	$60,
; End of

; Name	:
; Marks	: check bit
	PHA			; 9016	$48
	LDA $9020,X		; 9017	$BD $20 $90
	STA $00			; 901A	$85 $00
	PLA			; 901C	$68
	BIT $00			; 901D	$24 $00
	RTS			; 901F	$60
; End of

;9020 - data block = bit masks
.byte $01,$02,$04,$08,$10,$20,$40,$80

; Marks	: battle main
	JSR Wait_MENU_snd	; 9028	$20 $5B $FD
	LDA #$00		; 902B	$A9 $00
	STA cur_char_idx	; 902D	$85 $9E
L3102F:
	JSR Wait_NMI_end	; 902F	$20 $46 $FD
	LDA cur_char_idx	; 9032	$A5 $9E
	ORA #$80		; 9034	$09 $80
	JSR $FAFB		; 9036	$20 $FB $FA
	JSR Wait_MENU_snd	; 9039	$20 $5B $FD
	INC cur_char_idx	; 903C	$E6 $9E
	LDA cur_char_idx	; 903E	$A5 $9E
	CMP #$04		; 9040	$C9 $04
	BNE L3102F		; 9042	$D0 $EB
	JSR $909F		; 9044	$20 $9F $90
	LDA $3A			; 9047	$A5 $3A
	ORA #$01		; 9049	$09 $01
	STA $3A			; 904B	$85 $3A
	JSR $910D		; 904D	$20 $0D $91
	JSR $912A		; 9050	$20 $2A $91
	JSR $981D		; 9053	$20 $1D $98
	JSR $9147		; 9056	$20 $47 $91
	LDY #$20		; 9059	$A0 $20
	JSR $949B		; 905B	$20 $9B $94
	JSR $A35E		; 905E	$20 $5E $A3
	JSR $FAE0		; 9061	$20 $E0 $FA
	JSR $FAD0		; 9064	$20 $D0 $FA
	LDA #$00		; 9067	$A9 $00
	STA $9E			; 9069	$85 $9E
L3106B:
	JSR $982C		; 906B	$20 $2C $98	ppu init ?? - command process loop
	LDA $7CCA		; 906E	$AD $CA $7C	??
	BEQ L31076		; 9071	$F0 $03
	JSR $9B3E		; 9073	$20 $3E $9B
L31076:
	LDY $7B4A		; 9076	$AC $4A $7B	battle type (0=normal,1=surprised,2=first strike)
	BEQ L3107F		; 9079	$F0 $04
	CPY #$01		; 907B	$C0 $01
	BEQ L31099		; 907D	$F0 $1A
L3107F:
	JSR $9187		; 907F	$20 $87 $91	battle command check ??
	LDA cur_char_idx	; 9082	$A5 $9E
	CMP #$04		; 9084	$C9 $04
	BNE L3106B		; 9086	$D0 $E3		loop
	JSR Wait_NMI_end	; 9088	$20 $46 $FD
	LDA #$04		; 908B	$A9 $04
	STA $9E			; 908D	$85 $9E
	JSR $FABC		; 908F	$20 $BC $FA
	LDA #$00		; 9092	$A9 $00
	STA $9E			; 9094	$85 $9E
	JSR Wait_MENU_snd	; 9096	$20 $5B $FD
L31099:
	JSR $981D		; 9099	$20 $1D $98
	JMP $A308		; 909C	$4C $08 $A3
; End of

; Name	:
; Marks	: init battle ram
	LDA #$00		; 909F	$A9 $00
	LDX #$00		; 90A1	$A2 $00
L310A3:
	STA $7CB0,X		; 90A3	$9D $B0 $7C
	INX			; 90A6	$E8
	CPX #$9F		; 90A7	$E0 $9F
	BNE L310A3		; 90A9	$D0 $F8
	LDX #$34		; 90AB	$A2 $34
L310AD:
	STA $44,X		; 90AD	$95 $44
	DEX			; 90AF	$CA
	BPL L310AD		; 90B0	$10 $FB
	LDX #$01		; 90B2	$A2 $01
	STX $7CB2		; 90B4	$8E $B2 $7C
	STX $7CB3		; 90B7	$8E $B3 $7C
	STX $7CCA		; 90BA	$8E $CA $7C
	DEX			; 90BD	$CA
	STX $7CC0		; 90BE	$8E $C0 $7C
	STX $7CC1		; 90C1	$8E $C1 $7C
	DEX			; 90C4	$CA
	STX $7DA4		; 90C5	$8E $A4 $7D
	STX $7DD4		; 90C8	$8E $D4 $7D
	STX $7E04		; 90CB	$8E $04 $7E
	STX $7E34		; 90CE	$8E $34 $7E
	STX $7E64		; 90D1	$8E $64 $7E
	STX $7E94		; 90D4	$8E $94 $7E
	STX $7EC4		; 90D7	$8E $C4 $7E
	STX $7EF4		; 90DA	$8E $F4 $7E
	STX $7F24		; 90DD	$8E $24 $7F
	STX $7F54		; 90E0	$8E $54 $7F
	STX $7F84		; 90E3	$8E $84 $7F
	STX $7FB4		; 90E6	$8E $B4 $7F
	SEC			; 90E9	$38
	LDA #$07		; 90EA	$A9 $07
	SBC $601F		; 90EC	$ED $1F $60
	ASL A			; 90EF	$0A
	ASL A			; 90F0	$0A
	ASL A			; 90F1	$0A
	ASL A			; 90F2	$0A
	STA $AB			; 90F3	$85 $AB
	LDA #$04		; 90F5	$A9 $04
	STA $7CB8		; 90F7	$8D $B8 $7C
	LDA #$00		; 90FA	$A9 $00
.byte $8D,$7C,$00
	;STA $007C		; 90FC	$8D $7C $00
	LDA #$78		; 90FF	$A9 $78
.byte $8D,$7D,$00
	;STA $007D		; 9101	$8D $7D $00
	LDA #$76		; 9104	$A9 $76
	STA $A9			; 9106	$85 $A9
	LDA #$00		; 9108	$A9 $00
	STA $A8			; 910A	$85 $A8
	RTS			; 910C	$60
; End of

; Name	:
; Marks	: draw monster name window
	JSR Wait_NMI_end	; 910D	$20 $46 $FD
	JSR Init_gfx_buf	; 9110	$20 $90 $94
	JSR $9683		; 9113	$20 $83 $96
	LDX #$03		; 9116	$A2 $03
L31118:
	LDA $9126,X		; 9118	$BD $26 $91
	STA $62,X		; 911B	$95 $62
	DEX			; 911D	$CA
	BPL L31118		; 911E	$10 $F8
	JSR Wait_MENU_snd	; 9120	$20 $5B $FD
	JMP $9250		; 9123	$4C $50 $92
; End of

;$9126 - data block = monster name window position data
.byte $00,$13,$09,$1E

; Name	:
; Marks	: draw character stats window
	JSR Wait_NMI_end	; 912A	$20 $46 $FD
	JSR Init_gfx_buf	; 912D	$20 $90 $94
	JSR $94AA		; 9130	$20 $AA $94
	LDX #$03		; 9133	$A2 $03
L31135:
	LDA $9143,X		; 9135	$BD $43 $91
	STA $62,X		; 9138	$95 $62
	DEX			; 913A	$CA
	BPL L31135		; 913B	$10 $F8
	JSR Wait_MENU_snd	; 913D	$20 $5B $FD
	JMP $9250		; 9140	$4C $50 $92
; End of

;$9143 - data block = character stats window position data
.byte $0A,$13,$1F,$1E

; Name	:
; Marks	: draw battle command window
	JSR Wait_NMI_end	; 9147	$20 $46 $FD
	JSR Init_gfx_buf	; 914A	$20 $90 $94
	LDA #$06		; 914D	$A9 $06
	STA $68			; 914F	$85 $68
	LDA #$00		; 9151	$A9 $00
	STA $72			; 9153	$85 $72
	LDA #$07		; 9155	$A9 $07
	STA $73			; 9157	$85 $73
L31159:
	LDA $72			; 9159	$A5 $72
	STA $66			; 915B	$85 $66
	LDA $73			; 915D	$A5 $73
	STA $67			; 915F	$85 $67
	JSR $972F		; 9161	$20 $2F $97
	CLC			; 9164	$18
	LDA $73			; 9165	$A5 $73
	ADC #$0C		; 9167	$69 $0C
	STA $73			; 9169	$85 $73
	INC $72			; 916B	$E6 $72
	LDA $72			; 916D	$A5 $72
	CMP #$04		; 916F	$C9 $04
	BNE L31159		; 9171	$D0 $E6
	LDX #$03		; 9173	$A2 $03
L31175:
	LDA $9183,X		; 9175	$BD $83 $91
	STA $62,X		; 9178	$95 $62
	DEX			; 917A	$CA
	BPL L31175		; 917B	$10 $F8
	JSR Wait_MENU_snd	; 917D	$20 $5B $FD
	JMP $9250		; 9180	$4C $50 $92
; End of

;$9183 - data block = battle command window position data
.byte $20,$13,$27,$1E

; Name	:
; Marks	: get battle command input(check)
	JSR Wait_NMI_end	; 9187	$20 $46 $FD
	LDA cur_char_idx	; 918A	$A5 $9E
	TAX			; 918C	$AA
	LDA #$00		; 918D	$A9 $00
	STA $7FCE,X		; 918F	$9D $CE $7F
	STA $7FD6,X		; 9192	$9D $D6 $7F
	JSR Check_dead_stone	; 9195	$20 $08 $92
	BNE L311D7		; 9198	$D0 $3D
	JSR Check_conf_par_slp	; 919A	$20 $11 $92
	BNE L311D7		; 919D	$D0 $38
	JSR $FABC		; 919F	$20 $BC $FA
	LDA #$01		; 91A2	$A9 $01
	STA $7CE3		; 91A4	$8D $E3 $7C	current character's spell list ??
	STA $7CE7		; 91A7	$8D $E7 $7C
	STA $7CEB		; 91AA	$8D $EB $7C
	STA $7CEF		; 91AD	$8D $EF $7C
	LDA #$BF		; 91B0	$A9 $BF
	STA $67			; 91B2	$85 $67
	LDA #$C5		; 91B4	$A9 $C5
	STA $66			; 91B6	$85 $66		pointer to cursor position data ??
	LDA #$04		; 91B8	$A9 $04
	STA $5C			; 91BA	$85 $5C		number of cusor options ?? - battle command
	LDA #$00		; 91BC	$A9 $00
	STA $5D			; 91BE	$85 $5D
	STA $50			; 91C0	$85 $50
	STA $51			; 91C2	$85 $51
	JSR $FAE4		; 91C4	$20 $E4 $FA	some graphic subroutine ??
	JSR $9BA8		; 91C7	$20 $A8 $9B	battle command ?? - Only A or B
	JSR Wait_NMI_end	; 91CA	$20 $46 $FD
.byte $AD,$34,$00
	;LDA $0034		; 91CD	$AD $34 $00	key rlduseba
	CMP #$01		; 91D0	$C9 $01
	BNE L311DB		; 91D2	$D0 $07
	JSR $9231		; 91D4	$20 $31 $92	key A pressed - 
L311D7:
	INC cur_char_idx	; 91D7	$E6 $9E
	BNE L31207		; 91D9	$D0 $2C
L311DB:
	LDA cur_char_idx	; 91DB	$A5 $9E
	BEQ L31207		; 91DD	$F0 $28
	DEC cur_char_idx	; 91DF	$C6 $9E
	JSR $96E1		; 91E1	$20 $E1 $96	Set some stat address ??
	JSR Check_dead_stone	; 91E4	$20 $08 $92
	BNE L311EE		; 91E7	$D0 $05
	JSR Check_conf_par_slp	; 91E9	$20 $11 $92
	BEQ L31207		; 91EC	$F0 $19
L311EE:
	LDA cur_char_idx	; 91EE	$A5 $9E
	BEQ L31207		; 91F0	$F0 $15
	DEC cur_char_idx	; 91F2	$C6 $9E
	JSR $96E1		; 91F4	$20 $E1 $96	Set some stat address ??
	JSR $9208		; 91F7	$20 $08 $92
	BNE L31201		; 91FA	$D0 $05
	JSR $9211		; 91FC	$20 $11 $92
	BEQ L31207		; 91FF	$F0 $06
L31201:
	LDA $9E			; 9201	$A5 $9E
	BEQ L31207		; 9203	$F0 $02
	DEC $9E			; 9205	$C6 $9E
L31207:
	RTS			; 9207	$60
; End of

; Name	: Check_dead_stone
; Ret	: A (bit7= dead, bit6= stone)
; Marks	: Check if dead or stone
Check_dead_stone:
	JSR $96E1		; 9208	$20 $E1 $96	Set some stat address ??
	JSR Get_stat_status1	; 920B	$20 $6C $AF
	AND #$C0		; 920E	$29 $C0		check only dead and stone
	RTS			; 9210	$60
; End of Check_dead_stone

; Name	: Check_conf_par_slp
; Ret	: A (bit7= confuse, bit6= paralyze, bit3= sleep)
; Marks	: get confused character action
Check_conf_par_slp:
	JSR $96E1		; 9211	$20 $E1 $96	Set some stat address ??
	JSR Get_stat_status2	; 9214	$20 $80 $AF
	PHA			; 9217	$48
	AND #$80		; 9218	$29 $80		check confuse
	BEQ L3122D		; 921A	$F0 $11
	LDX #$00		; 921C	$A2 $00
	LDA #$03		; 921E	$A9 $03
	JSR $FD11		; 9220	$20 $11 $FD
	LDY #$2B		; 9223	$A0 $2B
	STA ($80),Y		; 9225	$91 $80
	LDY #$2A		; 9227	$A0 $2A
	LDA #$00		; 9229	$A9 $00
	STA ($80),Y		; 922B	$91 $80
L3122D:
	PLA			; 922D	$68
	AND #$C8		; 922E	$29 $C8		check confuse/paralyze/sleep
	RTS			; 9230	$60
; End of Check_conf_par_slp

; Name	:
; Marks	: target select
	LDA $54			; 9231	$A5 $54
	ASL A			; 9233	$0A
	CLC			; 9234	$18
	ADC #$F5		; 9235	$69 $F5
	STA $62			; 9237	$85 $62
	LDA #$00		; 9239	$A9 $00
	ADC #$BF		; 923B	$69 $BF
	STA $63			; 923D	$85 $63
	LDY #$00		; 923F	$A0 $00
	LDA ($62),Y		; 9241	$B1 $62
	STA $64			; 9243	$85 $64
	INY			; 9245	$C8
	LDA ($62),Y		; 9246	$B1 $62
	STA $65			; 9248	$85 $65
	JSR $FAE4		; 924A	$20 $E4 $FA
	JMP ($0064)		; 924D	$6C $64 $00
; End of ??
; Marks	: open window
	JSR Wait_NMI_end	; 9250	$20 $46 $FD
	SEC			; 9253	$38
	LDA $64			; 9254	$A5 $64
	SBC $62			; 9256	$E5 $62
	TAX			; 9258	$AA
	INX			; 9259	$E8
	STX $4F			; 925A	$86 $4F
	SEC			; 925C	$38
	LDA $65			; 925D	$A5 $65
	SBC $63			; 925F	$E5 $63
	SBC #$03		; 9261	$E9 $03
	STA $4E			; 9263	$85 $4E
	LDA $62			; 9265	$A5 $62
	CMP #$20		; 9267	$C9 $20
	BCC L31284		; 9269	$90 $19
	LDA #$24		; 926B	$A9 $24		right tilemap
	STA $69			; 926D	$85 $69
	LDA #$00		; 926F	$A9 $00
	STA $68			; 9271	$85 $68
	LDA #$20		; 9273	$A9 $20
	STA $6B			; 9275	$85 $6B
	LDA #$00		; 9277	$A9 $00
	STA $6A			; 9279	$85 $6A
	LDA #$40		; 927B	$A9 $40
	STA $67			; 927D	$85 $67
	JSR $92A1		; 927F	$20 $A1 $92
	BNE L3129B		; 9282	$D0 $17
L31284:
	LDA #$20		; 9284	$A9 $20		left tilemap
	STA $69			; 9286	$85 $69
	LDA #$00		; 9288	$A9 $00
	STA $68			; 928A	$85 $68
	LDA #$24		; 928C	$A9 $24
	STA $6B			; 928E	$85 $6B
	LDA #$00		; 9290	$A9 $00
	STA $6A			; 9292	$85 $6A
	LDA #$20		; 9294	$A9 $20
	STA $67			; 9296	$85 $67
	JSR $92A1		; 9298	$20 $A1 $92
L3129B:
	JSR Wait_MENU_snd	; 929B	$20 $5B $FD
	JMP $930C		; 929E	$4C $0C $93
; End of

; Name	:
; Marks	: calculate window tilemap ppu address
	LDA $62			; 92A1	$A5 $62
	STA $66			; 92A3	$85 $66
	LDA $63			; 92A5	$A5 $63
	BEQ L312BA		; 92A7	$F0 $11
	TAY			; 92A9	$A8
L312AA:
	CLC			; 92AA	$18
	LDA $68			; 92AB	$A5 $68
	ADC #$20		; 92AD	$69 $20
	STA $68			; 92AF	$85 $68
	LDA $69			; 92B1	$A5 $69
	ADC #$00		; 92B3	$69 $00
	STA $69			; 92B5	$85 $69
	DEY			; 92B7	$88
	BNE L312AA		; 92B8	$D0 $F0
L312BA:
	LDA $67			; 92BA	$A5 $67
	CMP #$20		; 92BC	$C9 $20
	BEQ L312C7		; 92BE	$F0 $07
	SEC			; 92C0	$38
	LDA $62			; 92C1	$A5 $62
	SBC #$20		; 92C3	$E9 $20
	STA $66			; 92C5	$85 $66
L312C7:
	CLC			; 92C7	$18
	LDA $68			; 92C8	$A5 $68
	ADC $66			; 92CA	$65 $66
	STA $68			; 92CC	$85 $68
	LDA $69			; 92CE	$A5 $69
	ADC #$00		; 92D0	$69 $00
	STA $69			; 92D2	$85 $69
	LDA $64			; 92D4	$A5 $64
	CMP $67			; 92D6	$C5 $67
	BCS L312E4		; 92D8	$B0 $0A
	LDA $4F			; 92DA	$A5 $4F
	STA $62			; 92DC	$85 $62
	LDA #$00		; 92DE	$A9 $00
	STA $63			; 92E0	$85 $63
	BEQ L31307		; 92E2	$F0 $23
L312E4:
	LDA $63			; 92E4	$A5 $63
	BEQ L312F9		; 92E6	$F0 $11
	TAY			; 92E8	$A8
L312E9:
	CLC			; 92E9	$18
	LDA $6A			; 92EA	$A5 $6A
	ADC #$20		; 92EC	$69 $20
	STA $6A			; 92EE	$85 $6A
	LDA $6B			; 92F0	$A5 $6B
	ADC #$00		; 92F2	$69 $00
	STA $6B			; 92F4	$85 $6B
	DEY			; 92F6	$88
	BNE L312E9		; 92F7	$D0 $F0
L312F9:
	SEC			; 92F9	$38
	LDA $67			; 92FA	$A5 $67
	SBC $62			; 92FC	$E5 $62
	STA $62			; 92FE	$85 $62
	SEC			; 9300	$38
	LDA $4F			; 9301	$A5 $4F
	SBC $62			; 9303	$E5 $62
	STA $63			; 9305	$85 $63
L31307:
	DEC $62			; 9307	$C6 $62
	DEC $62			; 9309	$C6 $62
	RTS			; 930B	$60
; End of

; Marks	: copy window tilemap to ppu
	CLC			; 930C	$18
	LDA $A8			; 930D	$A5 $A8
	ADC $A7			; 930F	$65 $A7
	STA $6C			; 9311	$85 $6C
	LDA $A9			; 9313	$A5 $A9
	ADC #$00		; 9315	$69 $00
	STA $6D			; 9317	$85 $6D
	LDA #$03		; 9319	$A9 $03
	STA $44			; 931B	$85 $44
	JSR Set_IRQ_JMP		; 931D	$20 $2A $FA	Wait NMI
	LDA $44			; 9320	$A5 $44
	CMP #$03		; 9322	$C9 $03		bottom border ??
	BNE L3132E		; 9324	$D0 $08
	JSR $9440		; 9326	$20 $40 $94
	JSR $934A		; 9329	$20 $4A $93
	BNE L31344		; 932C	$D0 $16
L3132E:
	CMP #$02		; 932E	$C9 $02		middle border
	BNE L31337		; 9330	$D0 $05
	JSR $938C		; 9332	$20 $8C $93
	BNE L31344		; 9335	$D0 $0D
L31337:
	CMP #$01		; 9337	$C9 $01		bottom border
	BNE L31341		; 9339	$D0 $06
	JSR $944D		; 933B	$20 $4D $94
	JSR $934A		; 933E	$20 $4A $93
L31341:
	JMP $9A5D		; 9341	$4C $5D $9A
;
L31344:
	JSR $9A5D		; 9344	$20 $5D $9A
	JMP $931D		; 9347	$4C $1D $93
; End of

; Name	:
; Marks	: draw top/bottom border
	JSR $9402		; 934A	$20 $02 $94
	LDA $64			; 934E	$A5 $64
	STA PpuData_2007	; 934F	$8D $07 $20
	LDA $62			; 9352	$A5 $62
	PHA			; 9354	$48
	LDA $63			; 9355	$A5 $63
	BEQ L3135B		; 9357	$F0 $02
	INC $62			; 9359	$E6 $62
L3135B:
	LDA $62			; 935B	$A5 $62
	BEQ L31366		; 935D	$F0 $07
	LDY $62			; 935F	$A4 $62
	LDA $65			; 9361	$A5 $65
	JSR $9B85		; 9363	$20 $85 $9B
L31366:
	LDA $63			; 9366	$A5 $63
	BEQ L3137E		; 9368	$F0 $14
	JSR $9417		; 936A	$20 $17 $94
	LDY $63			; 936D	$A4 $63
	DEY			; 936F	$88
	TYA			; 9370	$98
	BEQ L3137B		; 9371	$F0 $08
	LDY $63			; 9373	$A4 $63
	DEY			; 9375	$88
	LDA $65			; 9376	$A5 $65
	JSR $9B85		; 9378	$20 $85 $9B
L3137B:
	JSR $9432		; 937B	$20 $32 $94
L3137E:
	LDA $67			; 937E	$A5 $67
	STA PpuData_2007	; 9380	$8D $07 $20
	JSR $9424		; 9383	$20 $24 $94
	PLA			; 9386	$68
	STA $62			; 9387	$85 $62
	DEC $44			; 9389	$C6 $44
	RTS			; 938B	$60
; End of

; Name	:
; Marks	: draw text and left/right border
	JSR $9402		; 938C	$20 $02 $94
	LDA #$FA		; 938F	$A9 $FA
	STA PpuData_2007	; 9391	$8D $07 $20
	LDA $62			; 9394	$A5 $62
	PHA			; 9396	$48
	LDY #$00		; 9397	$A0 $00
	LDA $63			; 9399	$A5 $63
	BEQ L3139F		; 939B	$F0 $02
	INC $62			; 939D	$E6 $62
L3139F:
	LDA $62			; 939F	$A5 $62
	BEQ L313AE		; 93A1	$F0 $0B
	LDX $62			; 93A3	$A6 $62
L313A5:
	LDA ($6C),Y		; 93A5	$B1 $6C
	STA PpuData_2007	; 93A7	$8D $07 $20
	INY			; 93AA	$C8
	DEX			; 93AB	$CA
	BNE L313A5		; 93AC	$D0 $F7
L313AE:
	PLA			; 93AE	$68
	STA $62			; 93AF	$85 $62
	LDA $63			; 93B1	$A5 $63
	BEQ L313CD		; 93B3	$F0 $18
	JSR $9417		; 93B5	$20 $17 $94
	LDX $63			; 93B8	$A6 $63
	DEX			; 93BA	$CA
	TXA			; 93BB	$8A
	BEQ L313CA		; 93BC	$F0 $0C
	LDX $63			; 93BE	$A6 $63
	DEX			; 93C0	$CA
L313C1:
	LDA ($6C),Y		; 93C1	$B1 $6C
	STA PpuData_2007	; 93C3	$8D $07 $20
	INY			; 93C6	$C8
	DEX			; 93C7	$CA
	BNE L313C1		; 93C8	$D0 $F7
L313CA:
	JSR $9432		; 93CA	$20 $32 $94
L313CD:
	LDA #$FB		; 93CD	$A9 $FB
	STA PpuData_2007	; 93CF	$8D $07 $20
	JSR $9424		; 93D2	$20 $24 $94
	DEC $4E			; 93D5	$C6 $4E
	BNE L313DB		; 93D7	$D0 $02
	DEC $44			; 93D9	$C6 $44
L313DB:
	LDA $62			; 93DB	$A5 $62
	CMP #$FF		; 93DD	$C9 $FF
	BNE L313E3		; 93DF	$D0 $02
	LDA #$00		; 93E1	$A9 $00
L313E3:
	CLC			; 93E3	$18
	ADC $6C			; 93E4	$65 $6C
	STA $6C			; 93E6	$85 $6C
	LDA $6D			; 93E8	$A5 $6D
	ADC #$00		; 93EA	$69 $00
	STA $6D			; 93EC	$85 $6D
	LDA $63			; 93EE	$A5 $63
	CMP #$08		; 93F0	$C9 $08
	BNE L313F6		; 93F2	$D0 $02
	LDA #$07		; 93F4	$A9 $07
L313F6:
	CLC			; 93F6	$18
	ADC $6C			; 93F7	$65 $6C
	STA $6C			; 93F9	$85 $6C
	LDA $6D			; 93FB	$A5 $6D
	ADC #$00		; 93FD	$69 $00
	STA $6D			; 93FF	$85 $6D
	RTS			; 9401	$60
; End of

; Name	:
; Marks	: set ppu address
	LDA $69			; 9402	$A5 $69
	STA PpuAddr_2006	; 9404	$8D $06 $20
	LDA $68			; 9407	$A5 $68
	STA PpuAddr_2006	; 9409	$8D $06 $20
	LDA #$00		; 940C	$A9 $00
	STA PpuScroll_2005	; 940E	$8D $05 $20
	LDA $37			; 9411	$A5 $37
	STA PpuScroll_2005	; 9413	$8D $05 $20
	RTS			; 9416	$60
; End of

; Name	:
; Marks	: set ppu address (overflow)
	LDA $6B			; 9417	$A5 $6B
	STA PpuAddr_2006	; 9419	$8D $06 $20
	LDA $6A			; 941C	$A5 $6A
	STA PpuAddr_2006	; 941E	$8D $06 $20
	JMP $940C		; 9421	$4C $0C $94
; End of

; Name	:
; Marks	: increment tilemap row
	CLC			; 9424	$18
	LDA $68			; 9425	$A5 $68
	ADC #$20		; 9427	$69 $20
	STA $68			; 9429	$85 $68
	LDA $69			; 942B	$A5 $69
	ADC #$00		; 942D	$69 $00
	STA $69			; 942F	$85 $69
	RTS			; 9431	$60
; End of

; Name	:
; Marks	: increment tilemap row (overflow)
	CLC			; 9432	$18
	LDA $6A			; 9433	$A5 $6A
	ADC #$20		; 9435	$69 $20
	STA $6A			; 9437	$85 $6A
	LDA $6B			; 9439	$A5 $6B
	ADC #$00		; 943B	$69 $00
	STA $6B			; 943D	$85 $6B
	RTS			; 943F	$60
; End of

; Name	:
; Marks	: get top border tiles
	LDA #$F7		; 9440	$A9 $F7
	STA $64			; 9442	$85 $64
	LDA #$F8		; 9444	$A9 $F8
	STA $65			; 9446	$85 $65
	LDA #$F9		; 9448	$A9 $F9
	STA $67			; 944A	$85 $67
	RTS			; 944C	$60
; End of

; Name	:
; Marks	: get bottom border tiles
	LDA #$FC		; 944D	$A9 $FC
	STA $64			; 944F	$85 $64
	LDA #$FD		; 9451	$A9 $FD
	STA $65			; 9453	$85 $65
	LDA #$FE		; 9455	$A9 $FE
	STA $67			; 9457	$85 $67
	RTS			; 9459	$60
; End of

; Marks	: select target 0: fight
	JSR Wait_NMI_end	; 945A	$20 $46 $FD
	JSR $96E1		; 945D	$20 $E1 $96	Set some stat address ??
	LDY #$2A		; 9460	$A0 $2A
	LDA #$00		; 9462	$A9 $00
	STA ($80),Y		; 9464	$91 $80
	LDX cur_char_idx	; 9466	$A6 $9E
	INC $7CF3,X		; 9468	$FE $F3 $7C
	JSR Wait_MENU_snd	; 946B	$20 $5B $FD
	JSR Wait_NMI_end	; 946E	$20,$46 $FD
	JSR $FAC0		; 9471	$20 $C0 $FA
	LDY #$2B		; 9474	$A0 $2B
	LDA ($80),Y		; 9476	$B1 $80
	CMP #$FF		; 9478	$C9 $FF
	BNE L31483		; 947A	$D0 $07
	LDX cur_char_idx	; 947C	$A6 $9E
	DEC $7CF3,X		; 947E	$DE $F3 $7C
	DEC cur_char_idx	; 9481	$C6 $9E
L31483:
	JMP Wait_MENU_snd	; 9483	$4C $5B $FD
;

; Marks	: target select 1: flee
	JSR $96E1		; 9486	$20 $E1 $96
	LDY #$2A		; 9489	$A0 $2A
	LDA #$FE		; 948B	$A9 $FE
	STA ($80),Y		; 948D	$91 $80
	RTS			; 948F	$60
; End of

; Name	: Init_gfx_buf
; Marks	: Clear text buffer
Init_gfx_buf:
	LDY #$00		; 9490	$A0 $00
	LDA #$FF		; 9492	$A9 $FF
L31494:
	STA $7600,Y		; 9494	$99 $00 $76
	INY			; 9497	$C8
	BNE L31494		; 9498	$D0 $FA
	RTS			; 949A	$60
; End of Init_gfx_buf

; Name	:
; Marks	: wait
	TYA			; 949B	$98
	BEQ L314A9		; 949C	$F0 $0B
	STA $7CB9		; 949E	$8D $B9 $7C
L314A1:
	JSR $9A5D		; 94A1	$20 $5D $9A
	DEC $7CB9		; 94A4	$CE $B9 $7C
	BNE L314A1		; 94A7	$D0 $F8
L314A9:
	RTS			; 94A9	$60
; End of

; Name	:
; Marks	: draw character stats text
	JSR $9A63		; 94AA	$20 $63 $9A
	LDA $9E			; 94AD	$A5 $9E
	PHA			; 94AF	$48
	LDA #$C8		; 94B0	$A9 $C8
	STA $7609		; 94B2	$8D $09 $76
	LDA #$C9		; 94B5	$A9 $C9
	STA $760A		; 94B7	$8D $0A $76
	STA $7613		; 94BA	$8D $13 $76
	LDA #$C7		; 94BD	$A9 $C7
	STA $7612		; 94BF	$8D $12 $76
	LDA #$7A		; 94C2	$A9 $7A
	STA $761F		; 94C4	$8D $1F $76
	STA $7647		; 94C7	$8D $47 $76
	STA $766F		; 94CA	$8D $6F $76
	STA $7697		; 94CD	$8D $97 $76
	LDA #$FF		; 94D0	$A9 $FF
	STA $9E			; 94D2	$85 $9E
	LDA #$4A		; 94D4	$A9 $4A
	STA $4E			; 94D6	$85 $4E
	LDA #$7D		; 94D8	$A9 $7D
	STA $4F			; 94DA	$85 $4F
	LDX #$14		; 94DC	$A2 $14
	JSR $94F4		; 94DE	$20 $F4 $94
	LDX #$3C		; 94E1	$A2 $3C
	JSR $94F4		; 94E3	$20 $F4 $94
	LDX #$64		; 94E6	$A2 $64
	JSR $94F4		; 94E8	$20 $F4 $94
	LDX #$8C		; 94EB	$A2 $8C
	JSR $94F4		; 94ED	$20 $F4 $94
	PLA			; 94F0	$68
	STA $9E			; 94F1	$85 $9E
	RTS			; 94F3	$60
; End of

; Name	:
; X	: buffer offset
; Marks	: draw stats for character
	CLC			; 94F4	$18
	LDA $4E			; 94F5	$A5 $4E
	ADC #$30		; 94F7	$69 $30
	STA $4E			; 94F9	$85 $4E
	LDA $4F			; 94FB	$A5 $4F
	ADC #$00		; 94FD	$69 $00
	STA $4F			; 94FF	$85 $4F
	INC $9E			; 9501	$E6 $9E
	TXA			; 9503	$8A
	PHA			; 9504	$48
	STA $44			; 9505	$85 $44
	JSR $96E1		; 9507	$20 $E1 $96
	LDA $9E			; 950A	$A5 $9E
	CMP #$03		; 950C	$C9 $03
	BNE L3151D		; 950E	$D0 $0D
	LDY #$35		; 9410	$A0 $35
	LDA ($7E),Y		; 9412	$B1 $7E
	BPL L3151D		; 9414	$10 $07
	PLA			; 9416	$68
	LDA #$FF		; 9417	$A9 $FF
	STA $7697		; 9419	$8D $97 $76
	RTS			; 941C	$60
; End of
L3151D:
	LDY #$02		; 951D	$A0 $02
	LDX #$00		; 951F	$A2 $00
L31521:
	LDA ($7A),Y		; 9521	$B1 $7A
	STA $7D47,X		; 9523	$9D $47 $7D
	INX			; 9526	$E8
	INY			; 9527	$C8
	CPX #$06		; 9528	$E0 $06
	BNE L31521		; 952A	$D0 $F5
	LDA #$00		; 952C	$A9 $00
	STA $6F			; 952E	$85 $6F
	STA $7D47,X		; 9530	$9D $47 $7D
	LDA #$14		; 9533	$A9 $14
	STA $45			; 9535	$85 $45
	JSR $95E7		; 9537	$20 $E7 $95
	PLA			; 953A	$68
	CLC			; 953B	$18
	ADC #$07		; 953C	$69 $07
	TAX			; 953E	$AA
	LDY #$0A		; 953F	$A0 $0A		draw current HP
	LDA ($4E),Y		; 9541	$B1 $4E
	STA $62			; 9543	$85 $62
	INY			; 9545	$C8
	LDA ($4E),Y		; 9546	$B1 $4E
	STA $63			; 9548	$85 $63
	INY			; 954A	$C8
	TXA			; 954B	$8A
	PHA			; 954C	$48
	JSR $9749		; 954D	$20 $49 $97	convert hex to decimal
	PLA			; 9550	$68
	TAX			; 9551	$AA
	LDA $65			; 9552	$A5 $65
	STA $7600,X		; 9554	$9D $00 $76	copy to buffer
	INX			; 9557	$E8
	LDA $66			; 9558	$A5 $66
	STA $7600,X		; 955A	$9D $00 $76
	INX			; 955D	$E8
	LDA $67			; 955E	$A5 $67
	STA $7600,X		; 9560	$9D $00 $76
	INX			; 9563	$E8
	LDA $68			; 9564	$A5 $68
	STA $7600,X		; 9566	$9D $00 $76
	INX			; 9569	$E8
	INX			; 956A	$E8
	LDY $9E			; 956B	$A4 $9E
	LDA $7BA6,Y		; 956D	$B9 $A6 $7B
	CMP #$F6		; 9570	$C9 $F6	
	BEQ L31595		; 9572	$F0 $21
	STA $64			; 9574	$85 $64		draw status text
	LDA #$84		; 9576	$A9 $84
	STA $63			; 9578	$85 $63
	LDA #$00		; 957A	$A9 $00
	STA $62			; 957C	$85 $62
	LDA #$14		; 957E	$A9 $14
	STA $45			; 9580	$85 $45
	TXA			; 9582	$8A
	PHA			; 9583	$48
	STA $44			; 9584	$85 $44
	JSR $9AB6		; 9586	$20 $B6 $9A
	JSR $95E7		; 9589	$20 $E7 $95	copy text to buffer
	PLA			; 958C	$68
	TAX			; 958D	$AA
	INX			; 958E	$E8
	INX			; 958F	$E8
	INX			; 9590	$E8
	INX			; 9591	$E8
	INX			; 9592	$E8
	BNE L315C1		; 9593	$D0 $2C
L31595:
	LDY #$0E		; 9595	$A0 $0E		draw max HP
	LDA ($4E),Y		; 9597	$B1 $4E
	STA $62			; 9599	$85 $62
	INY			; 959B	$C8
	LDA ($4E),Y		; 959C	$B1 $4E
	STA $63			; 959E	$85 $63
	INY			; 95A0	$C8
	TXA			; 95A1	$8A
	PHA			; 95A2	$48
	JSR $9749		; 95A3	$20 $49 $97	convert hex to decimal
	PLA			; 95A6	$68
	TAX			; 95A7	$AA
	LDA $65			; 95A8	$A5 $65
	STA $7600,X		; 95AA	$9D $00 $76	copy to buffer
	INX			; 95AD	$E8
	LDA $66			; 95AE	$A5 $66
	STA $7600,X		; 95B0	$9D $00 $76
	INX			; 95B3	$E8
	LDA $67			; 95B4	$A5 $67
	STA $7600,X		; 95B6	$9D $00 $76
	INX			; 95B9	$E8
	LDA $68			; 95BA	$A5 $68
	STA $7600,X		; 95BC	$9D $00 $76
	INX			; 95BF	$E8
	INX			; 95C0	$E8
L315C1:
	LDY #$0C		; 95C1	$A0 $0C		draw current MP
	LDA ($4E),Y		; 95C3	$B1 $4E
	STA $62			; 95C5	$85 $62
	INY			; 95C7	$C8
	LDA ($4E),Y		; 95C8	$B1 $4E
	STA $63			; 95CA	$85 $63
	INY			; 95CC	$C8
	TXA			; 95CD	$8A
	PHA			; 95CE	$48
	JSR $9749		; 95CF	$20 $49 $97	convert hex to decimal
	PLA			; 95D2	$68
	TAX			; 95D3	$AA
	LDA $66			; 95D4	$A5 $66
	STA $7600,X		; 95D6	$9D $00 $76	copy to buffer
	INX			; 95D9	$E8
	LDA $67			; 95DA	$A5 $67
	STA $7600,X		; 95DC	$9D $00 $76
	INX			; 95DF	$E8
	LDA $68			; 95E0	$A5 $68
	STA $7600,X		; 95E2	$9D $00 $76
	INX			; 95E5	$E8
	RTS			; 95E6	$60
; End of

; Name	:
; Marks	: copy text to buffer
;	  copy loaded text in $7D47 buffer and add dakuten
;	  the dakuten code was removed in the english translation ??
;	  $44: destination buffer offset
;	  $A8(ADDR): destination buffer address
	CLC			; 95E7	$18
	LDA $A8			; 95E8	$A5 $A8
	ADC $44			; 95EA	$65 $44
	STA $6C			; 95EC	$85 $6C
	LDA $A9			; 95EE	$A5 $A9
	ADC $6F			; 95F0	$65 $6F
	STA $6D			; 95F2	$85 $6D
	LDY #$00		; 95F4	$A0 $00
	LDX #$00		; 95F6	$A2 $00
L315F8:
	LDA $7D47,X		; 95F8	$BD $47 $7D	text buffer
	BEQ L31617		; 95FB	$F0 $1A
	CMP #$6E		; 95FD	$C9 $6E
	BCS L31611		; 95FF	$B0 $10
	STX $DD			; 9601	$86 $DD
	TAX			; 9603	$AA
	LDA $EEDA,X		; 9604	$BD $DA $EE	compressed text ??
	PHA			; 9607	$48
	LDA $EEA7,X		; 9608	$BD $A7 $EE	compressed text ??
	LDX $DD			; 960B	$A6 $DD
	STA ($6C),Y		; 960D	$91 $6C
	INY			; 960F	$C8
	PLA			; 9610	$68
L31611:
	STA ($6C),Y		; 9611	$91 $6C
	INX			; 9613	$E8
	INY			; 9614	$C8
	BNE L315F8		; 9615	$D0 $E1
L31617:
	RTS			; 9617	$60
; End of

;9618 - dakuten(removed)
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF

; Marks	: dakuten character
	PHA			; 964E	$48
	TYA			; 964F	$98
	STA $6B			; 9650	$85 $6B
	PHA			; 9652	$48
	LDA $6C			; 9653	$A5 $6C
	PHA			; 9655	$48
	LDA $6D			; 9656	$A5 $6D
	PHA			; 9658	$48
	SEC			; 9659	$38
	LDA $6C			; 965A	$A5 $6C
	SBC $45			; 965C	$E5 $45
	STA $6C			; 965E	$85 $6C
	LDA $6D			; 9660	$A5 $6D
	SBC #$00		; 9662	$E9 $00
	STA $6D			; 9664	$85 $6D
	CLC			; 9666	$18
	LDA $6C			; 9667	$A5 $6C
	ADC $6B			; 9669	$65 $6B
	STA $6C			; 966B	$85 $6C
	LDA $6D			; 966D	$A5 $6D
	ADC #$00		; 966F	$69 $00
	STA $6D			; 9671	$85 $6D
	LDY #$00		; 9673	$A0 $00
	LDA $6A			; 9675	$A5 $6A
	STA ($6C),Y		; 9677	$91 $6C
	PLA			; 9679	$68
	STA $6D			; 967A	$85 $6D
	PLA			; 967C	$68
	STA $6C			; 967D	$85 $6C
	PLA			; 967F	$68
	TAY			; 9680	$A8
	PLA			; 9681	$68
	RTS			; 9682	$60
; End of

; Name	:
; Marks	: draw monster names
	LDA #$AC		; 9683	$A9 $AC		05/AC44 (monster names)
	STA $63			; 9685	$85 $63
	LDA #$44		; 9687	$A9 $44
	STA $62			; 9689	$85 $62
	LDA #$08		; 968B	$A9 $08
	STA $45			; 968D	$85 $45
	STA $44			; 968F	$85 $44
	LDX #$00		; 9691	$A2 $00
	STX $4B			; 9693	$86 $4B
L31695:
	LDX $4B			; 9695	$A6 $4B
	LDA $7B4E,X		; 9697	$BD $4E $7B
	BMI L316AB		; 969A	$30 $0F
	STA $64			; 969C	$85 $64
	JSR $9AAB		; 969E	$20 $AB $9A
	JSR $95E7		; 96A1	$20 $E7 $95
	CLC			; 96A4	$18
	LDA $44			; 96A5	$A5 $44
	ADC #$10		; 96A7	$69 $10
	STA $44			; 96A9	$85 $44
L316AB:
	LDX $4B			; 96AB	$A6 $4B
	INX			; 96AD	$E8
	STX $4B			; 96AE	$86 $4B
	CPX #$04		; 96B0	$E0 $04
	BNE L31695		; 96B2	$D0 $E1
	RTS			; 96B4	$60
; End of

;96B5 - 
; Marks	: get window position data pointer - unused, same as 05/ABD8
.byte $A5,$62,$48,$A5,$63,$48,$A9,$00,$85,$65,$A5
.byte $64,$0A,$26,$65,$18,$65,$62,$85,$62,$A5,$65,$65,$63,$85,$63,$A0
.byte $00,$B1,$62,$85,$78,$C8,$B1,$62,$85,$79,$68,$A5,$63,$68,$A5,$62
.byte $60

; Name	:
; Marks	: $7A(ADDR) = character properties 1 address $61xx
;	  $7E(ADDR) = character properties 2 address $62xx
;	  $80(ADDR) = character/monster battle stats address $7D7A ??
;	  Set address ??
;	  update character/monster pointers
	TXA			; 96E1	$8A
	PHA			; 96E2	$48
	LDA cur_char_idx	; 96E3	$A5 $9E
	CMP #$04		; 96E5	$C9 $04
	BCS L31705		; 96E7	$B0 $1C
	JSR Get_char_addr	; 96E9	$20 $26 $97
	CLC			; 96EC	$18
	ADC #$00		; 96ED	$69 $00
	STA $7A			; 96EF	$85 $7A
	LDA #$00		; 96F1	$A9 $00
	ADC #$61		; 96F3	$69 $61
	STA $7B			; 96F5	$85 $7B
	JSR Get_char_addr	; 96F7	$20 $26 $97
	CLC			; 96FA	$18
	ADC #$00		; 96FB	$69 $00
	STA $7E			; 96FD	$85 $7E
	LDA #$00		; 96FF	$A9 $00
	ADC #$62		; 9701	$69 $62
	STA $7F			; 9703	$85 $7F
L31705:
	LDA cur_char_idx	; 9705	$A5 $9E
	STA $00			; 9707	$85 $00
	LDA #$30		; 9709	$A9 $30
	STA $02			; 970B	$85 $02
	LDA #$00		; 970D	$A9 $00
	STA $01			; 970F	$85 $01
	STA $03			; 9711	$85 $03
	JSR $FC98		; 9713	$20 $98 $FC	Init ?? calc ??
	CLC			; 9716	$18
	LDA $04			; 9717	$A5 $04
	ADC #$7A		; 9719	$69 $7A
	STA $80			; 971B	$85 $80
	LDA $05			; 971D	$A5 $05
	ADC #$7D		; 971F	$69.$7D
	STA $81			; 9721	$85 $81
	PLA			; 9723	$68
	TAX			; 9724	$AA
	RTS			; 9725	$60
; End of

; Name	: Get_char_addr
; Marks	: current character id to address
;	  00h -> 00h
;	  01h -> 40h
;	  02h -> 80h
;	  03h -> C0h
;	  get character properties offset
Get_char_addr:
	LDA cur_char_idx	; 9726	$A5 $9E
	ASL A			; 9728	$0A
	ASL A			; 9729	$0A
	ASL A			; 972A	$0A
	ASL A			; 972B	$0A
	ASL A			; 972C	$0A
	ASL A			; 972D	$0A
	RTS			; 972E	$60
; End of Get_char_addr

; Name	:
; Marks	: load battle text
;	  $66= text id
;	  $67= tile offset
	LDA #$B2		; 972F	$A9 $B2		05/B295 (battle text)
	STA $63			; 9731	$85 $63
	LDA #$95		; 9733	$A9 $95
	STA $62			; 9735	$85 $62
	LDA $66			; 9737	$A5 $66
	STA $64			; 9739	$85 $64
	JSR $9AAB		; 973B	$20 $AB $9A
	LDA $68			; 973E	$A5 $68
	STA $45			; 9741	$85 $45
	LDA $67			; 9743	$A5 $67
	STA $44			; 9745	$85 $44
	JMP $95E7		; 9747	$4C $E7 $95	copy text to buffer
; End of

; Name	:
; Marks	: convert hex to decimal
	LDA #$10		; 9749	$A9 $10
	STA $70			; 975B	$85 $70
	LDA #$27		; 974D	$A9 $27
	STA $71			; 974F	$85 $71
	JSR $97E9		; 9751	$20 $E9 $97
	LDA $64			; 9754	$A5 $64		menu target h-scroll position ??
	PHA			; 9756	$48
	LDA #$E8		; 9757	$A9 $E8
	STA $70			; 9759	$85 $70
	LDA #$03		; 975B	$A9 $03
	STA $71			; 975D	$85 $71
	JSR $97E9		; 975F	$20 $E9 $97
	LDA $64			; 9762	$A5 $64		menu target h-scroll position ??
	STA $65			; 9764	$85 $65
	LDA #$64		; 9766	$A9 $64
	STA $70			; 9768	$85 $70
	LDA #$00		; 976A	$A9 $00
	STA $71			; 976C	$85 $71
	JSR $97E9		; 976E	$20 $E9 $97
	LDA $64			; 9771	$A5 $64
	STA $66			; 9773	$85 $66
	LDA #$0A		; 9775	$A9 $0A
	STA $70			; 9777	$85 $70
	LDA #$00		; 9779	$A9 $00
	STA $71			; 977B	$85 $71
	JSR $97E9		; 977D	$20 $E9 $97
	LDA $64			; 9780	$A5 $64
	STA $67			; 9782	$85 $67
	LDA $62			; 9784	$A5 $62
	STA $68			; 9786	$85 $68
	PLA			; 9788	$68
	STA $64			; 9789	$85 $64
	LDA $64			; 978B	$A5 $64
	BNE L31795		; 978D	$D0 $06
	LDA #$FF		; 978F	$A9 $FF
	STA $64			; 9791	$85 $64
	BNE L3179C		; 9793	$D0 $07
L31795:
	CLC			; 9795	$18
	LDA $64			; 9796	$A5 $64
	ADC #$80		; 9798	$69 $80
	STA $64			; 979A	$85 $64
L3179C:
	LDA $64			; 979C	$A5 $64
	CMP #$FF		; 979E	$C9 $FF
	BNE L317AC		; 97A0	$D0 $0A
	LDA $65			; 97A2	$A5 $65
	BNE L317AC		; 97A4	$D0 $06
	LDA #$FF		; 97A6	$A9 $FF
	STA $65			; 97A8	$85 $65
	BNE L317B3		; 97AA	$D0 $07
L317AC:
	CLC			; 97AC	$18
	LDA $65			; 97AD	$A5 $65
	ADC #$80		; 97AF	$69 $80
	STA $65			; 97B1	$85 $65
L317B3:
	LDA $65			; 97B3	$A5 $65
	CMP #$FF		; 97B5	$C9 $FF
	BNE L317C3		; 97B7	$D0 $0A
	LDA $66			; 97B9	$A5 $66
	BNE L317C3		; 97BB	$D0 $06
	LDA #$FF		; 97BD	$A9 $FF
	STA $66			; 97BF	$85 $66
	BNE L317CA		; 97C1	$D0 $07
L317C3:
	CLC			; 97C3	$18
	LDA $66			; 97C4	$A5 $66
	ADC #$80		; 97C6	$69 $80
	STA $66			; 97C8	$85 $66
L317CA:
	LDA $66			; 97CA	$A5 $66
	CMP #$FF		; 97CC	$C9 $FF
	BNE L317DA		; 97CE	$D0 $0A
	LDA $67			; 97D0	$A5 $67
	BNE L317DA		; 97D2	$D0 $06
	LDA #$FF		; 97D4	$A9 $FF
	STA $67			; 97D6	$85 $67
	BNE L317E1		; 97D8	$D0 $07
L317DA:
	CLC			; 97DA	$18
	LDA $67			; 97DB	$A5 $67
	ADC #$80		; 97DD	$69 $80
	STA $67			; 97DF	$85 $67
L317E1:
	CLC			; 97E1	$18
	LDA $68			; 97E2	$A5 $68
	ADC #$80		; 97E4	$69 $80
	STA $68			; 97E6	$85 $68
	RTS			; 97E8	$60
; End of

; Name	:
; Marks	: Subject some variables, and check be plus(positive)
;	  divide
	LDX #$00		; 97E9	$A2 $00
L317EB:
	INX			; 97EB	$E8
	SEC			; 97EC	$38
	LDA $62			; 97ED	$A5 $62
	SBC $70			; 97EF	$E5 $70
	STA $62			; 97F1	$85 $62
	LDA $63			; 97F3	$A5 $63
	SBC $71			; 97F5	$E5 $71
	STA $63			; 97F7	$85 $63
	BCS L317EB		; 97F9	$B0 $F0
	DEX			; 97FB	$CA
	STX $64			; 97FC	$86 $64
	CLC			; 97FE	$18
	LDA $62			; 97FF	$A5 $62
	ADC $70			; 9801	$65 $70
	STA $62			; 9803	$85 $62
	LDA $63			; 9805	$A5 $63
	ADC $71			; 9807	$65 $71
	STA $63			; 9809	$85 $63
	RTS			; 989B	$60
; End of

; Name	:
; Marks	: Set PPU OAM
;	  copy oam data to ppu
	JSR Wait_MENU_snd	; 980C	$20 $5B $FD
	JSR $FA2A		; 980F	$20 $2A $FA	wait NMI
	LDA #$00		; 9812	$A9 $00
	STA $2003		; 9814	$8D $03 $20
	LDA #$02		; 9817	$A9 $02
	STA SpriteDma_4014	; 9819	$8D $14 $40
	RTS			; 981C	$60
; End of

; Name	:
; Marks	: scroll menu to default position
	LDA #$00		; 981D	$A9 $00
	STA $64			; 981F	$85 $64
	LDA #$00		; 9821	$A9 $00
	STA $65			; 9823	$85 $65
	LDA #$01		; 9825	$A9 $01
	STA $63			; 9827	$85 $63
	JMP $9AC6		; 9829	$4C $C6 $9A
;

; Name	:
; Marks	: Set $64 = 48h, menu target h-scroll position
;	  $65 = 00h, $63 = 00h
;	  scroll menu to battle command window
	LDA #$48		; 982C	$A9 $48
	STA $64			; 982E	$85 $64		menu target h-scroll position
	LDA #$00		; 9830	$A9 $00
	STA $65			; 9832	$85 $65
	LDA #$00		; 9834	$A9 $00
	STA $63			; 9836	$85 $63
	JMP $9AC6		; 9838	$4C $C6 $9A
; End of

; Name	:
; Marks	:
	LDA #$00		; 983B	$A9 $00
	STA $64			; 983D	$85 $64
	LDA #$01		; 983F	$A9 $01
	STA $65			; 9841	$85 $65
	LDA #$00		; 9843	$A9 $00
	STA $63			; 9845	$85 $63
	JMP $9AC6		; 9847	$4C $C6 $9A
; End of

; Name	:
; Marks	:
	LDA #$48		; 984A	$A9 $48
	STA $64			; 984C	$85 $64
	LDA #$00		; 984E	$A9 $00
	STA $65			; 9850	$85 $65
	LDA #$01		; 9852	$A9 $01
	STA $63			; 9854	$85 $63
	JMP $9AC6		; 9856	$4C $C6 $9A
; End of

;9859
; Marks	:
	LDA #$40		; 9859	$A9 $40
	STA $64			; 985B	$85 $64
	LDA #$01		; 985D	$A9 $01
	STA $65			; 985F	$85 $65
	LDA #$00		; 9861	$A9 $00
	STA $63			; 9863	$85 $63
	JMP $9AC6		; 9865	$4C $C6 $9A

; Marks	: need monster stat value
;	  init battle stats
;	  Mob_HMP_tbl
	LDA #$7D		; 9868	$A9 $7D		character/monster properties(7D7A)
	STA $45			; 986A	$85 $45
	LDA #$7A		; 986C	$A9 $7A
	STA $44			; 986E	$85 $44
	LDX #$0C		; 9870	$A2 $0C
L31872:
	LDY #$00		; 9872	$A0 $00
	LDA #$00		; 9874	$A9 $00
L31876:
	STA ($44),Y		; 9876	$91 $44
	INY			; 9878	$C8
	CPY #$30		; 9879	$C0 $30
	BNE L31876		; 987B	$D0 $F9
	CLC			; 987D	$18
	LDA $44			; 987E	$A5 $44
	ADC #$30		; 9880	$69 $30
	STA $44			; 9882	$85 $44
	LDA $45			; 9884	$A5 $45
	ADC #$00		; 9886	$69 $00
	STA $45			; 9888	$85 $45
	DEX			; 988A	$CA
	BNE L31872		; 988B	$D0 $E5
	LDA #$00		; 988D	$A9 $00
	STA $9E			; 988F	$85 $9E
	JSR $96E1		; 9891	$20 $E1 $96	start of character loop
	LDY #$35		; 9894	$A0 $35
	LDA ($7E),Y		; 9896	$B1 $7E
	EOR #$01		; 9898	$49 $01
	STA ($7E),Y		; 989A	$91 $7E
	LDA #$00		; 989C	$A9 $00
	LDY #$06		; 989E	$A0 $06
	STA ($80),Y		; 98A0	$91 $80
	LDY #$09		; 98A2	$A0 $09
	STA ($80),Y		; 98A4	$91 $80
	LDY #$2D		; 98A6	$A0 $2D
	STA ($80),Y		; 98A8	$91 $80
	LDY #$12		; 98AA	$A0 $12
	STA ($80),Y		; 98AC	$91 $80
	LDY #$13		; 98AE	$A0 $13
	STA ($80),Y		; 98B0	$91 $80
	LDA #$14		; 98B2	$A9 $14
	LDY #$07		; 98B4	$A0 $07
	STA ($80),Y		; 98B6	$91 $80
	LDY #$01		; 98B8	$A0 $01
	LDA ($7A),Y		; 98BA	$B1 $7A
	JSR $9AC1		; 98BC	$20 $C1 $9A	set character status 1
	LDY #$2C		; 98BF	$A0 $2C
	STA ($80),Y		; 98C1	$91 $80
	LDA $9E			; 98C3	$A5 $9E
	CMP #$03		; 98C5	$C9 $03
	BNE L318D8		; 98C7	$D0 $0F
	LDY #$35		; 98C9	$A0 $35
	LDA ($7E),Y		; 98CB	$B1 $7E
	BPL L318D8		; 98CD	$10 $09
	LDA #$80		; 98CF	$A9 $80
	JSR $9AC1		; 98D1	$20 $C1 $9A	set character status 1
	LDY #$2C		; 98D4	$A0 $2C
	STA ($80),Y		; 98D6	$91 $80
L318D8:
	LDY #$08		; 98D8	$A0 $08
	LDA ($7A),Y		; 98DA	$B1 $7A
	LDY #$0A		; 98DC	$A0 $0A
	STA ($80),Y		; 98DE	$91 $80
	LDY #$09		; 98E0	$A0 $09
	LDA ($7A),Y		; 98E2	$B1 $7A
	LDY #$0B		; 98E4	$A0 $0B
	STA ($80),Y		; 98E6	$91 $80
	LDY #$0A		; 98E8	$A0 $0A
	LDA ($7A),Y		; 98EA	$B1 $7A
	LDY #$0E		; 98EC	$A0 $0E
	STA ($80),Y		; 98EE	$91 $80
	LDY #$0B		; 98F0	$A0 $0B
	LDA ($7A),Y		; 98F2	$B1 $7A
	LDY #$0F		; 98F4	$A0 $0F
	STA ($80),Y		; 98F6	$91 $80
	LDY #$0C		; 98F8	$A0 $0C
	LDA ($7A),Y		; 98FA	$B1 $7A
	LDY #$0C		; 98FC	$A0 $0C
	STA ($80),Y		; 98FE	$91 $80
	LDY #$0D		; 9900	$A0 $0D
	LDA ($7A),Y		; 9902	$B1 $7A
	LDY #$0D		; 9904	$A0 $0D
	STA ($80),Y		; 9906	$91 $80
	LDY #$0E		; 9908	$A0 $0E
	LDA ($7A),Y		; 990A	$B1 $7A
	LDY #$10		; 990C	$A0 $10
	STA ($80),Y		; 990E	$91 $80
	LDY #$0F		; 9910	$A0 $0F
	LDA ($7A),Y		; 9912	$B1 $7A
	LDY #$11		; 9914	$A0 $11
	STA ($80),Y		; 9916	$91 $80
	LDA $80			; 9918	$A5 $80
	STA $A1			; 991A	$85 $A1
	LDA $81			; 991C	$A5 $81
	STA $A2			; 991E	$85 $A2
	JSR $AEE0		; 9920	$20 $E0 $AE
	INC $9E			; 9923	$E6 $9E		next character
	LDA $9E			; 9925	$A5 $9E
	CMP #$04		; 9927	$C9 $04
	BEQ L3192E		; 9929	$F0 $03
	JMP $9891		; 992B	$4C $91 $98
L3192E:
	LDA #$7E		; 992E	$A9 $7E
	STA $77			; 9930	$85 $77
	LDA #$3A		; 9932	$A9 $3A
	STA $76			; 9934	$85 $76
	LDA #$00		; 9936	$A9 $00
	STA $9E			; 9938	$85 $9E
	LDA #$00		; 993A	$A9 $00		start of monster loop
	LDX #$00		; 993C	$A2 $00
L3193E:
	STA $44,X		; 993E	$95 $44
	INX			; 9940	$E8
	CPX #$30		; 9941	$E0 $30
	BNE L3193E		; 9943	$D0 $F9
	LDX $9E			; 9945	$A6 $9E
	LDA $7B62,X		; 9947	$BD $62 $7B
	BPL L31953		; 994A	$10 $07
	LDA #$80		; 994C	$A9 $80
	STA $4C			; 994E	$85 $4C
	JMP $9A32		; 9950	$4C $32 $9A
L31953:
	STA $00			; 9953	$85 $00
	LDA #$0A		; 9955	$A9 $0A
	STA $02			; 9957	$85 $02
	LDA #$00		; 9959	$A9 $00
	STA $01			; 995B	$85 $01
	STA $03			; 995D	$85 $03
	JSR $FC98		; 995F	$20 $98 $FC
	LDA $04			; 9962	$A5 $04
	ADC #<Mob_prop
	;ADC #$C3		; 9964	$69 $C3		Mob_prop (monster properties 0C/87C3)
	STA $7A			; 9966	$85 $7A
	LDA $05			; 9968	$A5 $05
	ADC #>Mob_prop
	;ADC #$87		; 996A	$69 $87
	STA $7B			; 996C	$85 $7B
	LDY #$01		; 996E	$A0 $01
	LDA ($7A),Y		; 9970	$B1 $7A
	ASL A			; 9972	$0A
	CLC			; 9973	$18
	ADC #<Mob_HMP_tbl
	;ADC #$C3		; 9974	$69 $C3		Mob_HMP_tbl (monster hp/mp values 0C/8CC3)
	STA $78			; 9976	$85 $78
	LDA #$00		; 9978	$A9 $00
	ADC #>Mob_HMP_tbl
	;ADC #$8C		; 997A	$69 $8C
	STA $79			; 997C	$85 $79
	LDY #$00		; 997E	$A0 $00
	LDA ($78),Y		; 9980	$B1 $78
	STA $4E			; 9982	$85 $4E
	STA $52			; 9984	$85 $52
	INY			; 9986	$C8
	LDA ($78),Y		; 9987	$B1 $78
	STA $4F			; 9989	$85 $4F
	STA $53			; 998B	$85 $53
	LDY #$02		; 998D	$A0 $02
	LDA ($7A),Y		; 998F	$B1 $7A
	ASL A			; 9991	$0A
	CLC			; 9992	$18
	ADC #<Mob_HMP_tbl
	;ADC #$C3		; 9993	$69 $C3		Mob_HMP_tbl (monster hp/mp values 0C/8CC3)
	STA $78			; 9995	$85 $78
	LDA #$00		; 9997	$A9 $00
	ADC #>Mob_HMP_tbl
	;ADC #$8C		; 9999	$69 $8C
	STA $79			; 999B	$85 $79
	LDY #$00		; 999D	$A0 $00
	LDA ($78),Y		; 999F	$B1 $78
	STA $A1			; 99A1	$85 $A1
	STA $50			; 99A3	$85 $50
	STA $54			; 99A5	$85 $54
	INY			; 99A7	$C8
	LDA ($78),Y		; 99A8	$B1 $78
	STA $A2			; 99AA	$85 $A2
	STA $51			; 99AC	$85 $51
	STA $55			; 99AE	$85 $55
	LDY #$03		; 99B0	$A0 $03
	LDA ($7A),Y		; 99B2	$B1 $7A
	JSR $FD07		; 99B4	$20 $07 $FD
	TAY			; 99B7	$A8
	LDA Mob_stat1_tbl,Y	; 99B8	$B9 $03 $8D	monster stat1 value ??
	STA $5C			; 99BB	$85 $5C
	LDA Mob_stat2_tbl,X	; 99BD	$BD $13 $8D	monster stat2 value ??
	STA $5D			; 99C0	$85 $5D
	LDY #$04		; 99C2	$A0 $04
	LDA ($7A),Y		; 99C4	$B1 $7A
	JSR $FD07		; 99C6	$20 $07 $FD
	TAY			; 99C9	$A8
	LDA Mob_stat3_tbl,Y	; 99CA	$B9 $23 $8D	monster stat3 value ??
	STA $5E			; 99CD	$85 $5E
	LDA Mob_stat4_tbl,X	; 99CF	$BD $33 $8D	monster stat4 value ??
	STA $61			; 99D2	$85 $61
	LDY #$05		; 99D4	$A0 $05
	LDA ($7A),Y		; 99D6	$B1 $7A
	JSR $FD07		; 99D8	$20 $07 $FD
	TAY			; 99DB	$A8
	LDA Mob_stat1_tbl,Y	; 99DC	$B9 $03 $8D	monster stat1 value ??
	STA $44			; 99DF	$85 $44
	LDA Mob_stat2_tbl,X	; 99E1	$BD $13 $8D	monster stat2 value ??
	STA $45			; 99E4	$85 $45
	LDY #$06		; 99E6	$A0 $06
	LDA ($7A),Y		; 99E8	$B1 $7A
	JSR $FD07		; 99EA	$20 $07 $FD
	TAY			; 99ED	$A8
	LDA Mob_stat3_tbl,Y	; 99EE	$B9 $23 $8D	monster stat3 value ??
	STA $46			; 99F1	$85 $46
	LDA Mob_stat1_tbl,X	; 99F3	$BD $03 $8D	monster stat1 value ??
	STA $47			; 99F6	$85 $47
	LDY #$07		; 99F8	$A0 $07
	LDA ($7A),Y		; 99FA	$B1 $7A
	JSR $FD07		; 99FC	$20 $07 $FD
	TAY			; 99FF	$A8
	LDA Mob_stat2_tbl,Y	; 9A00	$B9 $13 $8D	monster stat2 value ??
	STA $48			; 9A03	$85 $48
	LDA Mob_stat5_tbl,X	; 9A05	$BD $43 $8D	monster stat5 value ??
	STA $59			; 9A08	$85 $59
	LDY #$08		; 9A0A	$A0 $08
	LDA ($7A),Y		; 9A0C	$B1 $7A
	JSR $FD07		; 9A0E	$20 $07 $FD
	TAY			; 9A11	$A8
	LDA Mob_stat6_tbl,Y	; 9A12	$B9 $53 $8D	monster stat6 value ??
	STA $49			; 9A15	$85 $49
	LDA Mob_stat7_tbl,X	; 9A17	$BD $63 $8D	monster stat7 value ??
	STA $5A			; 9A1A	$85 $5A
	LDY #$09		; 9A1C	$A0 $09
	LDA ($7A),Y		; 9A1E	$B1 $7A
	JSR $FD07		; 9A20	$20 $07 $FD
	TAY			; 9A23	$A8
	LDA Mob_stat3_tbl,Y	; 9A24	$B9 $23 $8D	monster stat3 value ??
	STA $58			; 9A27	$85 $58
	LDA Mob_stat7_tbl,X	; 9A29	$BD $63 $8D	monster stat7 value ??
	STA $5B			; 9A2C	$85 $5B
	LDA #$14		; 9A2E	$A9 $14
	STA $4B			; 9A30	$85 $4B
	LDY #$00		; 9A32	$A0 $00
	LDX #$00		; 9A34	$A2 $00
L31A36:
	LDA $44,X		; 9A36	$B5 $44
	STA ($76),Y		; 9A38	$91 $76
	INY			; 9A3A	$C8
	INX			; 9A3B	$E8
	CPX #$30		; 9A3C	$E0 $30
	BNE L31A36		; 9A3E	$D0 $F6
	CLC			; 9A40	$18		next monster
	LDA $76			; 9A41	$A5 $76
	ADC #$30		; 9A43	$69 $30
	STA $76			; 9A45	$85 $76
	LDA $77			; 9A47	$A5 $77
	ADC #$00		; 9A49	$69 $00
	STA $77			; 9A4B	$85 $77
	INC $9E			; 9A4D	$E6 $9E
	LDA $9E			; 9A4F	$A5 $9E
	CMP #$08		; 9A51	$C9 $08
	BEQ L31A58		; 9A53	$F0 $03
	JMP $993A		; 9A55	$4C $3A $99
L31A58:
	LDA #$00		; 9A58	$A9 $00
	STA $9E			; 9A5A	$85 $9E
	RTS			; 9A5C	$60
; End of

; Name	:
; Marks	:
	JSR $FD46		; 9A5D	$20 $46 $FD
	JMP $FD5B		; 9A60	$4C $5B $FD
; End of

; Name	:
; Marks	:
	JSR $FD5B		; 9A63	$20 $5B $FD
	JMP $FD46		; 9A66	$4C $46 $FD
; End of

; Name	:
; Marks	: set NMI subroutine
;	  init battle nmi jump code
	LDA #$9A		; 9A69	$A9 $9A
	STA $0102		; 9A6B	$8D $02 $01
	LDA #$79		; 9A6E	$A9 $79
	STA $0101		; 9A70	$8D $01 $01
	LDA #$4C		; 9A73	$A9 $4C
	STA $0100		; 9A75	$8D $00 $01
	RTS			; 9A78	$60
; End of

; < NMI routine >
; Marks	: battle nmi
	PHP			; 9A79	$08
	PHA			; 9A7A	$48
	TXA			; 9A7B	$8A
	PHA			; 9A7C	$48
	TYA			; 9A7D	$98
	PHA			; 9A7E	$48
	JSR Wait_NMI_end	; 9A7F	$20 $46 $FD
	JSR Wait_MENU_snd	; 9A82	$20 $5B $FD
	LDA #$00		; 9A85	$A9 $00
	STA $AC			; 9A87	$85 $AC
	PLA			; 9A89	$68
	TAY			; 9A8A	$A8
	PLA			; 9A8B	$68
	TAX			; 9A8C	$AA
	PLA			; 9A8D	$68
	PLP			; 9A8E	$28
	RTI			; 9A8F	$40
; End of

; Name	:
; Marks	: cursor ??
;	  hide cursor sprites
	LDA #$F0		; 9A90	$A9 $F0		Reset OAM_Y[16:23]
	STA $0250		; 9A92	$8D $50 $02
	STA $0254		; 9A95	$8D $54 $02
	STA $0258		; 9A98	$8D $58 $02
	STA $025C		; 9A9B	$8D $5C $02
	STA $0240		; 9A9E	$8D $40 $02
	STA $0244		; 9AA1	$8D $44 $02
	STA $0248		; 9AA4	$8D $48 $02
	STA $024C		; 9AA7	$8D $4C $02
	RTS			; 9AAA	$60
; End of

; Name	:
; Marks	: $62(ADDR)= pointer table address
;	  $64= index
	LDX #$00		; 9AAB	$A2 $00
	STX $6F			; 9AAD	$86 $6F
	STX $AA			; 9AAF	$86 $AA
	LDX #$05		; 9AB1	$A2 $05
	JMP $FD8C		; 9AB3	$4C $8C $FD	load text
; End of

; Name	:
; Marks	: load text (bank 0A)
;	  $62(ADDR)= pointer table address
;	  $64= index
	LDX #$00		; 9AB6	$A2 $00
	STX $6F			; 9AB8	$86 $6F
	STX $AA			; 9ABA	$86 $AA
	LDX #$0A		; 9ABC	$A2 $0A
	JMP $FD8C		; 9ABE	$4C $8C $FD
; End of

; Name	:
; Marks	: set character status 1
	LDY #$08		; 9AC1	$A0 $08
	STA ($80),Y		; 9AC3	$91 $80
	RTS			; 9AC5	$60
; End of

; Name	:
; Marks	: scroll menu
	JSR Wait_NMI_end	; 9AC6	$20 $46 $FD
	JSR $9A90		; 9AC9	$20 $90 $9A	Reset OAM_Y[16:23] cursor ??
	JSR $980C		; 9ACC	$20 $0C $98	set PPU data(OAM)
	LDA $3A			; 9ACF	$A5 $3A		ppu ctrl -> $2000 (menu area)
	AND #$01		; 9AD1	$29 $01		base NT address
	STA NT_addr_menu	; 9AD3	$85 $62		NT address (00h -> $0000, 01h -> $1000)
	JSR Wait_NMI_end	; 9AD5	$20 $46 $FD
	LDA $63			; 9AD8	$A5 $63		Show monster name ??
	BNE L31AFE		; 9ADA	$D0 $22
	CLC			; 9ADC	$18
	LDA PpuScroll_h		; 9ADD	$A5 $38		menu area
	ADC #$20		; 9ADF	$69 $20
	STA PpuScroll_h		; 9AE1	$85 $38		menu area
	LDA NT_addr_menu	; 9AE3	$A5 $62
	ADC #$00		; 9AE5	$69 $00
	STA NT_addr_menu	; 9AE7	$85 $62
	SEC			; 9AE9	$38
	LDA $64			; 9AEA	$A5 $64		menu target h-scroll position
	SBC PpuScroll_h		; 9AEC	$E5 $38
	LDA $65			; 9AEE	$A5 $65
	SBC NT_addr_menu	; 9AF0	$E5 $62
	BCC L31B2B		; 9AF2	$90 $37
	LDA $3A			; 9AF4	$A5 $3A
	AND #$FE		; 9AF6	$29 $FE
	ORA NT_addr_menu	; 9AF8	$05 $62
	STA $3A			; 9AFA	$85 $3A
	BNE L31B25		; 9AFC	$D0,$27
L31AFE:
 	SEC			; 9AFE	$38
	LDA $38			; 9AFF	$A5 $38
	SBC #$20		; 9B01	$E9 $20
	STA $38			; 9B03	$85 $38
	LDA $62			; 9B05	$A5 $62
	SBC #$00		; 9B07	$E9 $00
	STA $62			; 9B09	$85 $62
	LDA $62			; 9B0B	$A5 $62
	BPL L31B15		; 9B0D	$10 $06
	LDA #$00		; 9B0F	$A9 $00
	STA $38			; 9B11	$85 $38
	STA $62			; 9B13	$85 $62
L31B15:
	SEC			; 9B15	$38
	LDA $64			; 9B16	$A5 $64
	SBC $38			; 9B18	$E5 $38
	LDA $65			; 9B1A	$A5 $65
	SBC $62			; 9B1C	$E5 $62
	BCS L31B2B		; 9B1E	$B0 $0B
;; [$9B20 :: 0x31B20]
	JSR PpuCtrl_add_NT	; 9B20	$20 $35 $9B
	BNE L31B25		; 9B23	$D0 $00
L31B25:
	JSR $FD5B		; 9B25	$20 $5B $FD
	JMP $9AD5		; 9B28	$4C $D5 $9A
L31B2B:
	LDA $64			; 9B2B	$A5 $64		menu target h-scroll position
	STA PpuScroll_h		; 9B2D	$85 $38
	JSR PpuCtrl_add_NT	; 9B2F	$20 $35 $9B
	JMP Wait_MENU_snd	; 9B32	$4C $5B $FD
;

; Name	: PpuCtrl_add_NT
; Marks	: apply $62 to ppu ctrl -> $2000 (menu area)
PpuCtrl_add_NT:
	LDA PpuCtrl_menu	; 9B35	$A5 $3A		ppu ctrl -> $2000 (menu area)
	AND #$FE		; 9B37	$29 $FE		base NT set to $2000
	ORA NT_addr_menu	; 9B39	$05 $62
	STA PpuCtrl_menu	; 9B3B	$85 $3A		ppu ctrl -> $2000 (menu area)
	RTS			; 9B3D	$60
; End of PpuCtrl_add_NT

; Name	:
; Marks	:
	JSR $FD46		; 9B3E	$20 $46 $FD
	LDA #$88		; 9B41	$A9 $88
	STA $68			; 9B43	$85 $68
	LDA #$27		; 9B45	$A9 $27
	STA $69			; 9B47	$85 $69
	LDA #$80		; 9B49	$A9 $80
	STA $6A			; 9B4B	$85 $6A
	LDA #$23		; 9B4D	$A9 $23
	STA $6B			; 9B4F	$85 $6B
	LDA #$0A		; 9B51	$A9 $0A
	STA $66			; 9B53	$85 $66
	JSR $FD5B		; 9B55	$20 $5B $FD
	JSR $FA2A		; 9B58	$20 $2A $FA
	JSR $9402		; 9B5B	$20 $02 $94
	LDY #$18		; 9B5E	$A0 $18
	LDA #$FF		; 9B60	$A9 $FF
	JSR $9B85		; 9B62	$20 $85 $9B
	JSR $9417		; 9B65	$20 $17 $94
	LDY #$0A		; 9B68	$A0 $0A
	LDA #$FF		; 9B6A	$A9 $FF
	JSR $9B85		; 9B6C	$20 $85 $9B
	JSR $9B8C		; 9B6F	$20 $8C $9B
	JSR $9B9A		; 9B72	$20 $9A $9B
	DEC $66			; 9B75	$C6 $66
	BEQ L31B7F		; 9B77	$F0 $06
	JSR $FD46		; 9B79	$20 $46 $FD
	JMP $9B55		; 9B7C	$4C $55 $9B
L31B7F:
	LDA #$00		; 9B7F	$A9 $00
	STA $7CCA		; 9B81	$8D $CA $7C
	RTS			; 9B84	$60
; End of

; Name	:
; A	: fill tile
; Y	: count
; Marks	:
L31B85:
	STA PpuData_2007	; 9B85	$8D $07 $20
	DEY			; 9B88	$88
	BNE L31B85		; 9B89	$D0 $FA
	RTS			; 9B8B	$60
; End of

; Name	:
; Marks	:
	SEC			; 9B8C	$38
	LDA $68			; 9B8D	$A5 $68
	SBC #$20		; 9B8F	$E9 $20
	STA $68			; 9B91	$85 $68
	LDA $69			; 9B93	$A5 $69
	SBC #$00		; 9B95	$E9 $00
	STA $69			; 9B97	$85 $69
	RTS			; 9B99	$60
; End of

; Name	:
; Marks	:
	SEC			; 9B9A	$38
	LDA $6A			; 9B9B	$A5 $6A
	SBC #$20		; 9B9D	$E9 $20
	STA $6A			; 9B9F	$85 $6A
	LDA $6B			; 9BA1	$A5 $6B
	SBC #$00		; 9BA3	$E9 $00
	STA $6B			; 9BA5	$85 $6B
	RTS			; 9BA7	$60
; End of

; Name	:
; Marks	: Cursor ??
;	  $64(ADDR) = OAM address(cursor ??)
;	  $66(ADDR) = ??
;	  OAM ??
;	  battle command ??
;	  get battle command input
	JSR Wait_NMI_end	; 9BA8	$20 $46 $FD
	LDA $50			; 9BAB	$A5 $50
	BNE L31BCF		; 9BAD	$D0 $20
	STA $53			; 9BAF	$85 $53
	STA $54			; 9BB1	$85 $54
	LDY #$00		; 9BB3	$A0 $00
	LDA ($66),Y		; 9BB5	$B1 $66		ex> $BFC5
	STA $0247		; 9BB7	$8D $47 $02	OAM_X[11]
	STA $56			; 9BBA	$85 $56		cursor 1 sprite x position(RT)
	INY			; 9BBC	$C8
	LDA ($66),Y		; 9BBD	$B1 $66
	STA $0244		; 9BBF	$8D $44 $02	OAM_Y[11]
	STA $55			; 9BC2	$85 $55		cursor 1 sprite y position(RT)
	LDA #$40		; 9BC4	$A9 $40
	STA $64			; 9BC6	$85 $64
	LDA #$02		; 9BC8	$A9 $02
	STA $65			; 9BCA	$85 $65		$64(ADDR) $0240 is cursor LT
	JSR Move_OAM_XY		; 9BCC	$20 $02 $9D	set cursor OAM x,y position
L31BCF:
	JSR $FAE4		; 9BCF	$20 $E4 $FA	status animation ??
	LDA $7CBA		; 9BD2	$AD $BA $7C
	BEQ L31BDA		; 9BD5	$F0 $03
	JSR $9EF5		; 9BD7	$20 $F5 $9E
L31BDA:
	JSR Wait_NMI_end	; 9BDA	$20 $46 $FD
	JSR $FC34		; 9BDD	$20 $34 $FC	Get key for command ??
	JSR $FAE4		; 9BE0	$20 $E4 $FA	status animation ??
	JSR $9CBF		; 9BE3	$20 $BF $9C	check something($51) ??
.byte $AD,$34,$00
	;LDA $0034		; 9BE6	$AD $34 $00	key - rlduseba
	BEQ L31BDA		; 9BE9	$F0 $EF		loop - battle wait command
	JSR Wait_NMI_end	; 9BEB	$20 $46 $FD
	LDA $5D			; 9BEE	$A5 $5D
	BEQ L31C19		; 9BF0	$F0 $27
.byte $AD,$34,$00
	;LDA $0034		; 9BF2	$AD $34 $00
	CMP #$80		; 9BF5	$C9 $80
	BNE L31C09		; 9BF7	$D0 $10
	INC $53			; 9BF9	$E6 $53		right button
	LDA $53			; 9BFB	$A5 $53
	CMP $5D			; 9BFD	$C5 $5D
	BNE L31C06		; 9BFF	$D0 $05
	LDA #$00		; 9C01	$A9 $00
.byte $8D,$53,$00
	;STA $0053		; 9C03	$8D $53 $00
L31C06:
	JMP $9C6C		; 9C06	$4C $6C $9C
; 
L31C09:
	CMP #$40		; 9C09	$C9 $40		left button
	BNE L31C19		; 9C0B	$D0 $0C
	DEC $53			; 9C0D	$C6 $53
	BPL L31C16		; 9C0F	$10 $05
	LDX $5D			; 9C11	$A6 $5D
	DEX			; 9C13	$CA
	STX $53			; 9C14	$86 $53
L31C16:
	JMP $9C6C		; 9C16	$4C $6C $9C
L31C19:
.byte $AD,$34,$00
	;LDA $0034		; 9C19	$AD $34 $00	check KEY - down button
	CMP #$20		; 9C1C	$C9 $20
	BNE L31C2F		; 9C1E	$D0 $0F
	INC $54			; 9C20	$E6 $54		CASE: key DOWN pressed
	LDA $54			; 9C22	$A5 $54		cursor number(0-4)
	CMP $5C			; 9C24	$C5 $5C		number of cursor options ?? (MAX cursor)
	BNE L31C2C		; 9C26	$D0 $04
	LDA #$00		; 9C28	$A9 $00		reset cursor position ??
	STA $54			; 9C2A	$85 $54
L31C2C:
	JMP $9C6C		; 9C2C	$4C $6C $9C
;
L31C2F:
	CMP #$10		; 9C2F	$C9 $10		up button
	BNE L31C3F		; 9C31	$D0 $0C
	DEC $54			; 9C33	$C6 $54		key UP pressed
	BPL L31C3C		; 9C35	$10 $05
	LDX $5C			; 9C37	$A6 $5C
	DEX			; 9C39	$CA
	STX $54			; 9C3A	$86 $54
L31C3C:
	JMP $9C6C		; 9C3C	$4C $6C $9C
;
L31C3F:
	CMP #$01		; 9C3F	$C9 $01		A button
	BNE L31C5F		; 9C41	$D0 $1C
	LDA #$00		; 9C43	$A9 $00		key A pressed
	LDX $5C			; 9C45	$A6 $5C
	BEQ L31C4F		; 9C47	$F0 $06
L31C49:
	CLC			; 9C49	$18
	ADC $54			; 9C4A	$65 $54
	DEX			; 9C4C	$CA
	BNE L31C49		; 9C4D	$D0 $FA
L31C4F:
	CLC			; 9C4F	$18
	ADC $53			; 9C50	$65 $53
	TAX			; 9C52	$AA
	LDA $7CE3,X		; 9C53	$BD $E3 $7C
	BNE L31C5E		; 9C56	$D0 $06
	JSR Wait_MENU_snd	; 9C58	$20 $5B $FD
	JMP $9BDA		; 9C5B	$4C $DA $9B
L31C5E:
	RTS			; 9C5E	$60
;
L31C5F:
	CMP #$02		; 9C5F	$C9 $02		B button
	BNE L31C66		; 9C61	$D0 $03
	JMP Wait_MENU_snd	; 9C63	$4C $5B $FD	key B pressed
;
L31C66:
	JSR Wait_MENU_snd	; 9C66	$20 $5B $FD
	JMP $9BDA		; 9C69	$4C $DA $9B
;

; Marks	: $66(ADDR) ??, $68(ADDR) ??, $53 = ??
	LDA $66			; 9C6C	$A5 $66		pointer to cursor position data
	STA $68			; 9C6E	$85 $68
	LDA $67			; 9C70	$A5 $67
	STA $69			; 9C72	$85 $69
	LDA $53			; 9C74	$A5 $53
	ASL A			; 9C76	$0A
	STA $44			; 9C77	$85 $44
	LDY $5C			; 9C79	$A4 $5C
	DEY			; 9C7B	$88
L31C7C:
	CLC			; 9C7C	$18
	ADC $44			; 9C7D	$65 $44
	DEY			; 9C7F	$88
	BNE L31C7C		; 9C80	$D0 $FA
	STA $44			; 9C82	$85 $44
	LDA $54			; 9C84	$A5 $54
	ASL A			; 9C86	$0A
	CLC			; 9C87	$18
	ADC $44			; 9C88	$65 $44
	CLC			; 9C8A	$18
	ADC $66			; 9C8B	$65 $66
	STA $68			; 9C8D	$85 $68
	LDA #$00		; 9C8F	$A9 $00
	ADC $67			; 9C91	$65 $67
	STA $69			; 9C93	$85 $69
	LDY #$00		; 9C95	$A0 $00
	LDA ($68),Y		; 9C97	$B1 $68
	STA $0247		; 9C99	$8D $47 $02	OAM_X[17] cursor TR
	STA $56			; 9C9C	$85 $56
	INY			; 9C9E	$C8
	LDA ($68),Y		; 9C9F	$B1 $68
	STA $0244		; 9CA1	$8D $44 $02	OAM_Y[17] cursor TR
	STA $55			; 9CA4	$85 $55
	LDA #$40		; 9CA6	$A9 $40
	STA $64			; 9CA8	$85 $64
	LDA #$02		; 9CAA	$A9 $02
	STA $65			; 9CAC	$85 $65		$0240 OAM[16]
	JSR Move_OAM_XY		; 9CAE	$20 $02 $9D	set cursor OAM X,Y position
	JSR $FAE4		; 9CB1	$20 $E4 $FA
	LDA $7CBA		; 9CB4	$AD $BA $7C
	BEQ L31CBC		; 9CB7	$F0 $03
	JSR $9EF5		; 9CB9	$20 $F5 $9E
L31CBC:
	JMP $9BDA		; 9CBC	$4C $DA $9B
; End of

; Name	:
; Marks	:
	LDA $51			; 9CBF	$A5 $51
	BEQ L31D01		; 9CC1	$F0 $3E
	LDA $7CB2		; 9CC3	$AD $B2 $7C
	BNE L31CFB		; 9CC6	$D0 $33
	LDA $7CB3		; 9CC8	$AD $B3 $7C
	STA $7CB2		; 9CCB	$8D $B2 $7C
	LDA $56			; 9CCE	$A5 $56
	STA $0247		; 9CD0	$8D $47 $02
	LDA $55			; 9CD3	$A5 $55
	STA $0244		; 9CD5	$8D $44 $02
	LDA #$02		; 9CD8	$A9 $02
	STA $65			; 9CDA	$85 $65
	LDA #$40		; 9CDC	$A9 $40
	STA $64			; 9CDE	$85 $64
	JSR Move_OAM_XY		; 9CE0	$20 $02 $9D	set cursor OAM X,Y position
	LDA $58			; 9CE3	$A5 $58
	STA $0257		; 9CE5	$8D $57 $02
	LDA $57			; 9CE8	$A5 $57
	STA $0254		; 9CEA	$8D $54 $02
	LDA #$02		; 9CED	$A9 $02
	STA $65			; 9CEF	$85 $65
	LDA #$50		; 9CF1	$A9 $50
	STA $64			; 9CF3	$85 $64
	JSR $9D02		; 9CF5	$20 $02 $9D
	JMP $9D01		; 9CF8	$4C $01 $9D
L31CFB:
	DEC $7CB2		; 9CFB	$CE $B2 $7C
	JSR $9A90		; 9CFE	$20 $90 $9A
L31D01:
	RTS			; 9D01	$60
; End of

; Name	: Move_OAM_XY
; Marks	: $64(ADDR) = OAM address(pointer to top-right sprite data)
;	  Set OAM position 2 x 2
;	  Base X,Y tile is Right Top(RT)
;	  set position for 16x16 sprite
Move_OAM_XY:
	LDY #$04		; 9D02	$A0 $04
	LDA ($64),Y		; 9D04	$B1 $64		OAM_Y[+1]
	STA $62			; 9D06	$85 $62		Y
	LDY #$07		; 9D08	$A0 $07
	LDA ($64),Y		; 9D0A	$B1 $64		OAM_X[+1]
	STA $63			; 9D0C	$85 $63		X
	LDY #$00		; 9D0E	$A0 $00
	LDA $62			; 9D10	$A5 $62
	STA ($64),Y		; 9D12	$91 $64		OAM_Y[+0]
	INY			; 9D14	$C8
	INY			; 9D15	$C8
	INY			; 9D16	$C8
	SEC			; 9D17	$38
	LDA $63			; 9D18	$A5 $63
	SBC #$08		; 9D1A	$E9 $08
	STA ($64),Y		; 9D1C	$91 $64		OAM_X[+0]
	INY			; 9D1E	$C8
	INY			; 9D1F	$C8
	INY			; 9D20	$C8
	INY			; 9D21	$C8
	INY			; 9D22	$C8
	CLC			; 9D23	$18
	LDA $62			; 9D24	$A5 $62
	ADC #$08		; 9D26	$69 $08
	STA ($64),Y		; 9D28	$91 $64		OAM_Y[+2]
	INY			; 9D2A	$C8
	INY			; 9D2B	$C8
	INY			; 9D2C	$C8
	SEC			; 9D2D	$38
	LDA $63			; 9D2E	$A5 $63
	SBC #$08		; 9D30	$E9 $08
	STA ($64),Y		; 9D32	$91 $64		OAM_X[+2]
	INY			; 9D34	$C8
	CLC			; 9D35	$18
	LDA $62			; 9D36	$A5 $62
	ADC #$08		; 9D38	$69 $08
	STA ($64),Y		; 9D3A	$91 $64		OAM_Y[+3]
	INY			; 9D3C	$C8
	INY			; 9D3D	$C8
	INY			; 9D3E	$C8
	LDA $63			; 9D3F	$A5 $63
	STA ($64),Y		; 9D41	$91 $64		OAM_X[+4]
	RTS			; 9D43	$60
; End of Move_OAM_XY

; Marks	: target select 2: magic
	JSR $FD46		; 9D44	$20 $46 $FD
	JSR $9490		; 9D47	$20 $90 $94
	LDA #$C7		; 9D4A	$A9 $C7
	STA $7601		; 9D4C	$8D $01 $76
	LDA #$C9		; 9D4F	$A9 $C9
	STA $7602		; 9D51	$8D $02 $76
	LDY #$0C		; 9D54	$A0 $0C
	LDA ($80),Y		; 9D56	$B1 $80
	STA $62			; 9D58	$85 $62
	INY			; 9D5A	$C8
	LDA ($80),Y		; 9D5B	$B1 $80
	STA $63			; 9D5D	$85 $63
	JSR $9749		; 9D5F	$20 $49 $97	convert hex to decimal
	LDX #$07		; 9D62	$A2 $07
	LDA $66			; 9D64	$A5 $66
	STA $7600,X		; 9D66	$9D $00 $76
	INX			; 9D69	$E8
	LDA $67			; 9D6A	$A5 $67
	STA $7600,X		; 9D6C	$9D $00 $76
	INX			; 9D6F	$E8
	LDA $68			; 9D70	$A5 $68
	STA $7600,X		; 9D72	$9D $00 $76
	LDY #$10		; 9D75	$A0 $10
	LDA ($80),Y		; 9D77	$B1 $80
	STA $62			; 9D79	$85 $62
	INY			; 9D7B	$C8
	LDA ($80),Y		; 9D7C	$B1 $80
	STA $63			; 9D7E	$85 $63
	JSR $9749		; 9D80	$20 $49 $97	convert hex to decimal
	LDX #$0B		; 9D83	$A2 $0B
	LDA $66			; 9D85	$A5 $66
	STA $7600,X		; 9D87	$9D $00 $76
	INX			; 9D8A	$E8
	LDA $67			; 9D8B	$A5 $67
	STA $7600,X		; 9D8D	$9D $00 $76
	INX			; 9D90	$E8
	LDA $68			; 9D91	$A5 $68
	STA $7600,X		; 9D93	$9D $00 $76
	LDX #$0A		; 9D96	$A2 $0A
	LDA #$7A		; 9D98	$A9 $7A
	STA $7600,X		; 9D9A	$9D $00 $76
	LDA #$07		; 9D9D	$A9 $07		$07: "MP Cost"
	STA $66			; 9D9F	$85 $66
	LDA #$1C		; 9DA1	$A9 $1C
	STA $67			; 9DA3	$85 $67
	JSR $972F		; 9DA5	$20 $2F $97	load battle text
	LDX #$03		; 9DA8	$A2 $03
L31DAA:
	LDA $9F70,X		; 9DAA	$BD $70 $9F	mp window position data
	STA $62,X		; 9DAD	$95 $62
	DEX			; 9DAF	$CA
	BPL L31DAA		; 9DB0	$10 $F8
	JSR $FD5B		; 9DB2	$20 $5B $FD
	JSR $9250		; 9DB5	$20 $50 $92	open window
	JSR $FD46		; 9DB8	$20 $46 $FD
	LDY #$30		; 9DBB	$A0 $30
	LDX #$00		; 9DBD	$A2 $00
	STX $76			; 9DBF	$86 $76
L31DC1:
	LDA ($7A),Y		; 9DC1	$B1 $7A
	INY			; 9DC3	$C8
	STA $7CE3,X		; 9DC4	$9D $E3 $7C
	ORA $76			; 9DC7	$05 $76
	STA $76			; 9DC9	$85 $76
	INX			; 9DCB	$E8
	CPX #$10		; 9DCC	$E0 $10
	BNE L31DC1		; 9DCE	$D0 $F1
	JSR $9490		; 9DD0	$20 $90 $94	clear text buffer
	JSR $9E85		; 9DD3	$20 $85 $9E
	LDX #$03		; 9DD6	$A2 $03
L31DD8:
	LDA $9F74,X		; 9DD8	$BD $74 $9F	magic list window position data
	STA $62,X		; 9DDB	$95 $62
	DEX			; 9DDD	$CA
	BPL L31DD8		; 9DDE	$10 $F8
	JSR $FD5B		; 9DE0	$20 $5B $FD
	JSR $9250		; 9DE3	$20 $50 $92	open window
	LDA #$40		; 9DE6	$A9 $40
	STA $64			; 9DE8	$85 $64
	LDA #$01		; 9DEA	$A9 $01
	STA $65			; 9DEC	$85 $65
	LDA #$00		; 9DEE	$A9 $00
	STA $63			; 9DF0	$85 $63
	JSR $9AC6		; 9DF2	$20 $C6 $9A	scroll menu
	LDA $76			; 9DF5	$A5 $76
	BNE L31E02		; 9DF7	$D0 $09
	DEC $9E			; 9DF9	$C6 $9E
	LDY #$20		; 9DFB	$A0 $20
	JSR $949B		; 9DFD	$20 $9B $94	wait 32 frames
	BEQ L31E76		; 9E00	$F0 $74
L31E02:
	LDA #$BF		; 9E02	$A9 $BF		0C/BFD5 - x,y positin ??
	STA $67			; 9E04	$85 $67
	LDA #$D5		; 9E06	$A9 $D5
	STA $66			; 9E08	$85 $66
	LDA #$04		; 9E0A	$A9 $04
	STA $5C			; 9E0C	$85 $5C
	LDA #$04		; 9E0E	$A9 $04
	STA $5D			; 9E10	$85 $5D
	LDA #$01		; 9E12	$A9 $01
	STA $7CBA		; 9E14	$8D $BA $7C
	JSR $9BA8		; 9E17	$20 $A8 $9B
.byte $AD,$34,$00
	;LDA $0034		; 9E1A	$AD $34 $00
	CMP #$01		; 9E1D	$C9 $01
	BEQ L31E23		; 9E1F	$F0 $02
	BNE L31E74		; 9E21	$D0 $51
L31E23:
	SEC			; 9E23	$38
	LDY #$0C		; 9E24	$A0 $0C
	LDA ($80),Y		; 9E26	$B1 $80
	SBC $77			; 9E28	$E5 $77
	INY			; 9E2A	$C8
	LDA ($80),Y		; 9E2B	$B1 $80
	SBC #$00		; 9E2D	$E9 $00
	BCS L31E33		; 9E2F	$B0 $02
	BCC L31E02		; 9E31	$90 $CF
L31E33:
	JSR $FD46		; 9E33	$20 $46 $FD
	JSR $FAC0		; 9E36	$20 $C0 $FA	choose targets
	JSR $FD5B		; 9E39	$20 $5B $FD
	LDY #$2B		; 9E3C	$A0 $2B
	LDA ($80),Y		; 9E3E	$B1 $80		targets
	CMP #$FF		; 9E40	$C9 $FF
	BNE L31E46		; 9E42	$D0 $02
	BEQ L31E02		; 9E44	$F0 $BC
L31E46:
	LDA $9E			; 9E46	$A5 $9E
	ASL			; 9E48	$0A
	ASL			; 9E49	$0A
	ASL			; 9E4A	$0A
	ASL			; 9E4B	$0A
	STA $00			; 9E4C	$85 $00
	LDA $54			; 9E4E	$A5 $54
	ASL			; 9E50	$0A
	ASL			; 9E51	$0A
	CLC			; 9E52	$18
	ADC $53			; 9E53	$65 $53
	ADC $00			; 9E55	$65 $00
	TAX			; 9E57	$AA
	INC $7CF7,X		; 9E58	$FE $F7 $7C
	LDX $9E			; 9E5B	$A6 $9E
	LDY #$2A		; 9E5D	$A0 $2A
	LDA ($80),Y		; 9E5F	$B1 $80
	CMP #$15		; 9E61	$C9 $15
	BCS L31E6A		; 9E63	$B0 $05
	INC $7D3F,X		; 9E65	$FE $3F $7D
	BNE L31E6D		; 9E68	$D0 $03
L31E6A:
	INC $7D43,X		; 9E6A	$FE $43 $7D
L31E6D:
	LDY #$20		; 9E6D	$A0 $20
	JSR $949B		; 9E6F	$20 $9B $94	wait 32 frames
	BEQ L31E76		; 9E72	$F0 $02
L31E74:
	DEC $9E			; 9E74	$C6 $9E
L31E76:
	JSR $9A90		; 9E76	$20 $90 $9A	hide cursor sprites
	JSR $984A		; 9E79	$20 $4A $98
	JSR $9B3E		; 9E7C	$20 $3E $9B
	LDA #$00		; 9E7F	$A9 $00
	STA $7CBA		; 9E81	$8D $BA $7C
	RTS			; 9E84	$60
; End of

; Name	:
; Marks	:
	JSR $AF6C		; 9E85	$20 $6C $AF	get status 1
	AND #$30		; 9E88	$29 $30
	BNE L31E97		; 9E8A	$D0 $0B
	INY			; 9E8C	$C8
	LDA ($80),Y		; 9E8D	$B1 $80
	AND #$10		; 9E8F	$29 $10
	BNE L31E97		; 9E91	$D0 $04
	LDA $76			; 9E93	$A5 $76
	BNE L31E9A		; 9E95	$D0 $03
L31E97:
	JMP $9EE2		; 9E97	$4C $E2 $9E
; End of
L31E9A:
	LDA #$82		; 9E9A	$A9 $82		string offset $0100 (item names)
	STA $63			; 9E9C	$85 $63
	LDA #$00		; 9E9E	$A9 $00
	STA $62			; 9EA0	$85 $62
	LDA #$04		; 9EA2	$A9 $04
	STA $47			; 9EA4	$85 $47
	LDA #$16		; 9EA6	$A9 $16
	STA $48			; 9EA8	$85 $48
	LDY #$30		; 9EAA	$A0 $30
	TYA			; 9EAC	$98
	PHA			; 9EAD	$48
L31EAE:
	LDA #$04		; 9EAE	$A9 $04
	STA $46			; 9EB0	$85 $46
L31EB2:
	PLA			; 9EB2	$68
	TAY			; 9EB3	$A8
	CLC			; 9EB4	$18
	LDA ($7A),Y		; 9EB5	$B1 $7A		string index
	STA $64			; 9EB7	$85 $64
	INY			; 9EB9	$C8
	TYA			; 9EBA	$98
	PHA			; 9EBB	$48
	LDA #$15		; 9EBC	$A9 $15
	STA $45			; 9EBE	$85 $45
	LDA $48			; 9EC0	$A5 $48
	STA $44			; 9EC2	$85 $44
	JSR $9AB6		; 9EC4	$20 $B6 $9A	load text (bank 0A)
	JSR $95E7		; 9EC7	$20 $E7 $95 	copy text to buffer
	CLC			; 9ECA	$18
	LDA $48			; 9ECB	$A5 $48
	ADC #$05		; 9ECD	$69 $05
	STA $48			; 9ECF	$85 $48
	DEC $46			; 9ED1	$C6 $46
	BNE L31EB2		; 9ED3	$D0 $DD
	CLC			; 9ED5	$18
	LDA $48			; 9ED6	$A5 $48
	ADC #$16		; 9ED8	$69 $16
	STA $48			; 9EDA	$85 $48
	DEC $47			; 9EDC	$C6 $47
	BNE L31EAE		; 9EDE	$D0 $CE
	PLA			; 9EE0	$68
	RTS			; 9EE1	$60
; End of
	LDA #$00		; 9EE2	$A9 $00
	STA $76			; 9EE4	$85 $76
	LDA #$15		; 9EE6	$A9 $15
	STA $68			; 9EE8	$85 $68
	LDA #$08		; 9EEA	$A9 $08		$08: "No Magic."
	STA $66			; 9EEC	$85 $66
	LDA #$58		; 9EEE	$A9 $58
	STA $67			; 9EF0	$85 $67
	JMP $972F		; 9EF2	$4C $2F $97	load battle text
; End of

; Name	:
; Marks	: $7E(ADDR) = ??
;	  $7A(ADDR) = ??
;	  $80(ADDR) = ??
	LDA $62			; 9EF5	$A5 $62
	PHA			; 9EF7	$48
	LDA $63			; 9EF8	$A5 $63
	PHA			; 9EFA	$48
	LDA $64			; 9EFB	$A5 $64
	PHA			; 9EFD	$48
	LDA $65			; 9EFE	$A5 $65
	PHA			; 9F00	$48
	LDA $66			; 9F01	$A5 $66
	PHA			; 9F03	$48
	LDA $67			; 9F04	$A5 $67
	PHA			; 9F06	$48
	LDA $68			; 9F07	$A5 $68
	PHA			; 9F09	$48
	LDA $54			; 9F0A	$A5 $54
	ASL A			; 9F0C	$0A
	ASL A			; 9F0D	$0A
	ASL A			; 9F0E	$0A
	CLC			; 9F0F	$18
	ADC $53			; 9F10	$65 $53
	ADC $53			; 9F12	$65 $53
	ADC #$10		; 9F14	$69 $10
	TAY			; 9F16	$A8
	LDA ($7E),Y		; 9F17	$B1 $7E		ex> $6210 spell levels/exp (16 * 2 bytes)
	TAX			; 9F19	$AA
	INX			; 9F1A	$E8
	STX $77			; 9F1B	$86 $77
	STX $62			; 9F1D	$86 $62
	LDY #$25		; 9F1F	$A0 $25
	TXA			; 9F21	$8A
	STA ($80),Y		; 9F22	$91 $80		character/monster battle stats. spell level ?? ex> $7D9F
	LDA $54			; 9F24	$A5 $54
	ASL A			; 9F26	$0A
	ASL A			; 9F27	$0A
	CLC			; 9F28	$18
	ADC $53			; 9F29	$65 $53
	ADC #$30		; 9F2B	$69 $30
	TAY			; 9F2D	$A8
	LDA ($7A),Y		; 9F2E	$B1 $7A		ex> $6130 spell list
	SEC			; 9F30	$38
	SBC #$BF		; 9F31	$E9 $BF
	LDY #$2A		; 9F33	$A0 $2A
	STA ($80),Y		; 9F35	$91 $80		ex> $7DA4 battle command ??
	LDA #$00		; 9F37	$A9 $00
	STA $63			; 9F39	$85 $63
	JSR $9749		; 9F3B	$20 $49 $97	convert hex to decimal
	LDA #$23		; 9F3E	$A9 $23
	STA PpuAddr_2006	; 9F40	$8D $06 $20
	LDA #$22		; 9F43	$A9 $22
	STA PpuAddr_2006	; 9F45	$8D $06 $20
	LDA #$00		; 9F48	$A9 $00
	STA PpuScroll_2005	; 9F4A	$8D $05 $20
	STA PpuScroll_2005	; 9F4D	$8D $05 $20
	LDA $67			; 9F50	$A5 $67
	STA PpuData_2007	; 9F52	$8D $07 $20
	LDA $68			; 9F55	$A5 $68
	STA PpuData_2007	; 9F57	$8D $07 $20
	PLA			; 9F5A	$68
	STA $68			; 9F5B	$85 $68
	PLA			; 9F5D	$68
	STA $67			; 9F5E	$85 $67
	PLA			; 9F60	$68
	STA $66			; 9F61	$85 $66
	PLA			; 9F63	$68
	STA $65			; 9F64	$85 $65
	PLA			; 9F66	$68
	STA $64			; 9F67	$85 $64
	PLA			; 9F69	$68
	STA $63			; 9F6A	$85 $63
	PLA			; 9F6C	$68
	STA $62			; 9F6D	$85 $62
	RTS			; 9F6F	$60
; End of

;; [$9F70 :: 0x31F70]
;9F70 - data block = mp window position data
.byte $3F,$13,$47,$1E
;9F74 - data block = magic list window position data
.byte $28,$13,$3E,$1E

; Marks	: target select 3: item
	JSR $FD46		; 9F78	$20 $46 $FD
	JSR $96E1		; 9F7B	$20 $E1 $96	update character/monster pointers
	LDX #$00		; 9F7E	$A2 $00
	LDA #$01		; 9F80	$A9 $01
L31F82:
	STA $7CE3,X		; 9F82	$9D $E3 $7C
	INX			; 9F85	$E8
	CPX #$04		; 9F86	$E0 $04
	BNE L31F82		; 9F88	$D0 $F8
	JSR $A020		; 9F8A	$20 $20 $A0	open item window
	JSR $983B		; 9F8D	$20 $3B $98
	LDA #$00		; 9F90	$A9 $00
	STA $50			; 9F92	$85 $50
	STA $61			; 9F94	$85 $61
	LDA #$BF		; 9F96	$A9 $BF		0C/BFCD
	STA $67			; 9F98	$85 $67
	LDA #$CD		; 9F9A	$A9 $CD
	STA $66			; 9F9C	$85 $66
	LDA #$02		; 9F9E	$A9 $02
	STA $5C			; 9FA0	$85 $5C
	LDA #$02		; 9FA2	$A9 $02
	STA $5D			; 9FA4	$85 $5D
	JSR $9BA8		; 9FA6	$20 $A8 $9B
.byte $AD,$34,$00
	;LDA $0034		; 9FA9	$AD $34 $00
	CMP #$01		; 9FAC	$C9 $01
	BEQ L31FB2		; 9FAE	$F0 $02
	BNE L32006		; 9FB0	$D0 $54
L31FB2:
	LDA $51			; 9FB2	$A5 $51
	BNE L31FD5		; 9FB4	$D0 $1F
	LDA $0247		; 9FB6	$AD $47 $02
	STA $56			; 9FB9	$85 $56
	STA $58			; 9FBB	$85 $58
	LDA $0244		; 9FBD	$AD $44 $02
	STA $55			; 9FC0	$85 $55
	STA $57			; 9FC2	$85 $57
	LDA #$01		; 9FC4	$A9 $01
	STA $51			; 9FC6	$85 $51
	STA $50			; 9FC8	$85 $50
	LDA $53			; 9FCA	$A5 $53
	STA $5E			; 9FCC	$85 $5E
	LDA $54			; 9FCE	$A5 $54
	STA $5F			; 9FD0	$85 $5F
	JMP $9F96		; 9FD2	$4C $96 $9F
L31FD5:
	DEC $51			; 9FD5	$C6 $51
	DEC $50			; 9FD7	$C6 $50
	LDA $5E			; 9FD9	$A5 $5E
	CMP $53			; 9FDB	$C5 $53
	BNE L31FF4		; 9FDD	$D0 $15
	LDA $5F			; 9FDF	$A5 $5F
	CMP $54			; 9FE1	$C5 $54
	BNE L31FF4		; 9FE3	$D0 $0F
	JSR $A141		; 9FE5	$20 $41 $A1	use item
	LDA $61			; 9FE8	$A5 $61
	BEQ L31FF2		; 9FEA	$F0 $06
	JSR $A2B7		; 9FEC	$20 $B7 $A2
	JMP $9F96		; 9FEF	$4C $96 $9F
L31FF2:
	BEQ L32016		; 9FF2	$F0 $22
L31FF4:
	JSR $A05B		; 9FF4	$20 $5B $A0
	LDA $61			; 9FF7	$A5 $61
	BEQ L32001		; 9FF9	$F0 $06
	JSR $A2B7		; 9FFB	$20 $B7 $A2
	JMP $9F96		; 9FFE	$4C $96 $9F
L32001:
	DEC $9E			; A001	$C6 $9E
	JMP $A016		; A003	$4C $16 $A0
L32006:
	LDA $51			; A006	$A5 $51
	BEQ L32014		; A008	$F0 $0A
	DEC $51			; A00A	$C6 $51
	DEC $50			; A00C	$C6 $50
	JSR $A2BC		; A00E	$20 $BC $A2
	JMP $9F96		; A011	$4C $96 $9F
L32014:
	DEC $9E			; A014	$C6 $9E
L32016:
	LDA #$00		; A016	$A9 $00
	STA $51			; A018	$85 $51
	JSR $984A		; A01A	$20 $4A $98
	JMP $9B3E		; A01D	$4C $3E $9B
; End of

; Name	:
; Marks	: open item window
	JSR $9490		; A020	$20 $90 $94	clear text buffer
	LDA #$15		; A023	$A9 $15
	STA $68			; A025	$85 $68
	LDA #$04		; A027	$A9 $04		$04: "R.Hand"
	STA $66			; A029	$85 $66
	LDA #$15		; A02B	$A9 $15
	STA $67			; A02D	$85 $67
	JSR $972F		; A02F	$20 $2F $97	load battle text
	LDA #$05		; A032	$A9 $05		$05: "L.Hand"
	STA $66			; A034	$85 $66
	LDA #$69		; A036	$A9 $69
	STA $67			; A038	$85 $67
	JSR $972F		; A03A	$20 $2F $97	load battle text
	LDA #$06		; A03D	$A9 $06		$06: "Items"
	STA $66			; A03F	$85 $66
	LDA #$20		; A041	$A9 $20
	STA $67			; A043	$85 $67
	JSR $972F		; A045	$20 $2F $97
	JSR $A235		; A048	$20 $35 $A2
	LDX #$03		; A04B	$A2 $03
L3204D:
	LDA $A304,X		; A04D	$BD $04 $A3
	STA $62,X		; A050	$95 $62
	DEX			; A052	$CA
	BPL L3204D		; A053	$10 $F8
	JSR $A2BC		; A055	$20 $BC $A2
	JMP $9250		; A058	$4C $50 $92	open window
; End of

; Name	:
; Marks	:
	JSR $FD46		; A05B	$20 $46 $FD
	JSR $A2C2		; A05E	$20 $C2 $A2
	LDA $62			; A061	$A5 $62
	CMP #$02		; A063	$C9 $02
	BCC L32072		; A065	$90 $0B
	LDA $63			; A067	$A5 $63
	CMP #$02		; A069	$C9 $02
	BCC L32072		; A06B	$90 $05
	LDA #$01		; A06D	$A9 $01
	STA $61			; A06F	$85 $61
	RTS			; A071	$60
; End of
L32072:
	SEC			; A072	$38
	LDA $62			; A073	$A5 $62
	SBC $63			; A075	$E5 $63
	BCC L32083		; A077	$90 $0A
	LDA $62			; A079	$A5 $62
	PHA			; A07B	$48
	LDA $63			; A07C	$A5 $63
	STA $62			; A07E	$85 $62
	PLA			; A080	$68
	STA $63			; A081	$85 $63
L32083:
	CLC			; A083	$18
	LDA $62			; A084	$A5 $62
	ADC #$1C		; A086	$69 $1C
	STA $62			; A088	$85 $62
	CLC			; A08A	$18
	LDA $63			; A08B	$A5 $63
	ADC #$1C		; A08D	$69 $1C
	STA $63			; A08F	$85 $63
	LDY $62			; A091	$A4 $62
	LDA ($7A),Y		; A093	$B1 $7A
	STA $64			; A095	$85 $64
	LDY $63			; A097	$A4 $63
	LDA ($7A),Y		; A099	$B1 $7A
	STA $65			; A09B	$85 $65
	LDA $64			; A09D	$A5 $64
	CMP $65			; A09F	$C5 $65
	BNE L320A8		; A0A1	$D0 $05
	LDA #$01		; A0A3	$A9 $01
	STA $61			; A0A5	$85 $61
	RTS			; A0A7	$60
; End of
L320A8:
	LDA $65			; A0A8	$A5 $65
	BEQ L320B5		; A0AA	$F0 $09
	CMP #$30		; A0AC	$C9 $30
	BCS L320B5		; A0AE	$B0 $05
	LDA #$01		; A0B0	$A9 $01
	STA $61			; A0B2	$85 $61
	RTS			; A0B4	$60
; End of
L320B5:
	LDA $63			; A0B5	$A5 $63
	CMP #$1E		; A0B7	$C9 $1E
	BCC L320F4		; A0B9	$90 $39
	LDA $65			; A0BB	$A5 $65
	CMP #$68		; A0BD	$C9 $68
	BCC L320DC		; A0BF	$90 $1B
	LDY #$1C		; A0C1	$A0 $1C
	LDA ($7A),Y		; A0C3	$B1 $7A
	INY			; A0C5	$C8
	ORA ($7A),Y		; A0C6	$11 $7A
	CMP #$30		; A0C8	$C9 $30
	BEQ L320F4		; A0CA	$F0 $28
	LDA $62			; A0CC	$A5 $62
	EOR #$01		; A0CE	$49 $01
	TAY			; A0D0	$A8
	LDA ($7A),Y		; A0D1	$B1 $7A
	CMP #$30		; A0D3	$C9 $30
	BEQ L320F4		; A0D5	$F0 $1D
	LDA #$01		; A0D7	$A9 $01
	STA $61			; A0D9	$85 $61
	RTS			; A0DB	$60
; End of
L320DC:
	LDY $62			; A0DC	$A4 $62
	LDA ($7A),Y		; A0DE	$B1 $7A
	CMP #$68		; A0E0	$C9 $68
	BCS L320F4		; A0E2	$B0 $10
	LDA $62			; A0E4	$A5 $62
	EOR #$01		; A0E6	$49 $01
	TAY			; A0E8	$A8
	LDA ($7A),Y		; A0E9	$B1 $7A
	CMP #$68		; A0EB	$C9 $68
	BCC L320F4		; A0ED	$90 $05
	LDA #$01		; A0EF	$A9 $01
	STA $61			; A0F1	$85 $61
	RTS			; A0F3	$60
; End of
L320F4:
	LDY $62			; A0F4	$A4 $62
	LDA $65			; A0F6	$A5 $65
	STA ($7A),Y		; A0F8	$91 $7A
	LDY $63			; A0FA	$A4 $63
	LDA $64			; A0FC	$A5 $64
	STA ($7A),Y		; A0FE	$91 $7A
	LDY #$1C		; A100	$A0 $1C
	LDA ($7A),Y		; A102	$B1 $7A
	BNE L3210A		; A104	$D0 $04
	LDA #$30		; A106	$A9 $30
	STA ($7A),Y		; A108	$91 $7A
L3210A:
	INY			; A10A	$C8
	LDA ($7A),Y		; A10B	$B1 $7A
	BNE L32113		; A10D	$D0 $04
	LDA #$30		; A10F	$A9 $30
	STA ($7A),Y		; A111	$91 $7A
L32113:
	INY			; A113	$C8
	LDA ($7A),Y		; A114	$B1 $7A
	CMP #$30		; A116	$C9 $30
	BNE L3211E		; A118	$D0 $04
	LDA #$00		; A11A	$A9 $00
	STA ($7A),Y		; A11C	$91 $7A
L3211E:
	INY			; A11E	$C8
	LDA ($7A),Y		; A11F	$B1 $7A
	CMP #$30		; A121	$C9 $30
	BNE L32129		; A123	$D0 $04
	LDA #$00		; A125	$A9 $00
	STA ($7A),Y		; A127	$91 $7A
L32129:
	JSR $FD5B		; A129	$20 $5B $FD
	JSR $FD46		; A12C	$20 $46 $FD
	LDA $9E			; A12F	$A5 $9E
	ORA #$80		; A131	$09 $80
	JSR $FAFB		; A133	$20 $FB $FA	update character equipment
	JSR $9A63		; A136	$20 $63 $9A
	JSR $A020		; A139	$20 $20 $A0	open item window
	LDY #$20		; A13C	$A0 $20
	JMP $949B		; A13E	$4C $9B $94	wait 32 frames
; End of

; Name	:
; Marks	: use item
	JSR $A2C2		; A141	$20 $C2 $A2
	LDA $63			; A144	$A5 $63
	STA $4E			; A146	$85 $4E
	TAX			; A148	$AA
	LDA $7CC2,X		; A149	$BD $C2 $7C	used weapon/item id
	BNE L32153		; A14C	$D0 $05
	LDA #$01		; A14E	$A9 $01
	STA $61			; A150	$85 $61
	RTS			; A152	$60
; End of
L32153:
	PHA			; A153	$48
	JSR $FD46		; A154	$20 $46 $FD
	PLA			; A157	$68
	CMP #$2F		; A158	$C9 $2F
	BCS L32162		; A15A	$B0 $06		branch if not a usable item
	SEC			; A15C	$38
	SBC #$0E		; A15D	$E9 $0E
	JMP $A18F		; A15F	$4C $8F $A1
L32162:
	CMP #$98		; A162	$C9 $98
	BCC L3216C		; A164	$90 $06		branch if a weapon or armor
	SEC			; A166	$38
	SBC #$77		; A167	$E9 $77
	JMP $A18F		; A169	$4C $8F $A1
L3216C:
	SEC			; A16C	$38
	SBC #$30		; A16D	$E9 $30
	STA $00			; A16F	$85 $00
	LDA #$09		; A171	$A9 $09		weapon properties are 9 bytes each
	STA $02			; A173	$85 $02
	LDA #$00		; A175	$A9 $00
	STA $01			; A177	$85 $01
	STA $03			; A179	$85 $03
	JSR $FC98		; A17B	$20 $98 $FC	multiply (16-bit)
	CLC			; A17E	$18
	LDA $04			; A17F	$A5 $04
	;ADC #$F6		; A181	$69 $F6		weapon properties (0C/80F6)
	ADC #<Weapon_prop
	STA $62			; A183	$85 $62
	LDA $05			; A185	$A5 $05
	;ADC #$80		; A187	$69 $80
	ADC #>Weapon_prop
	STA $63			; A189	$85 $63
	LDY #$08		; A18B	$A0 $08
	LDA ($62),Y		; A18D	$B1 $62		get weapon spellcast
	STA $00			; A18F	$85 $00
	LDA #$05		; A191	$A9 $05		item properties are 5 bytes each
	STA $02			; A193	$85 $02
	LDA #$00		; A195	$A9 $00
	STA $01			; A197	$85 $01
	STA $03			; A199	$85 $03
	JSR $FC98		; A19B	$20 $98 $FC
	CLC			; A19E	$18
	LDA $04			; A19F	$A5 $04
	;ADC #$36		; A1A1	$69 $36		ItemAttack_prop (0C/8336)
	ADC #<ItemAttack_prop
	STA $62			; A1A3	$85 $62
	LDA $05			; A1A5	$A5 $05
	;ADC #$83		; A1A7	$69 $83
	ADC #>ItemAttack_prop
	STA $63			; A1A9	$85 $63
	LDY #$00		; A1AB	$A0 $00
	LDA ($62),Y		; A1AD	$B1 $62		item attack
	CMP #$FF		; A1AF	$C9 $FF
	BNE L321B9		; A1B1	$D0 $06
	JSR $FD5B		; A1B3	$20 $5B $FD
	JMP $A208		; A1B6	$4C $08 $A2
L321B9:
	LDY #$2A		; A1B9	$A0 $2A
	STA ($80),Y		; A1BB	$91 $80		set battle command
	LDY #$01		; A1BD	$A0 $01
	LDA ($62),Y		; A1BF	$B1 $62
	LDY #$25		; A1C1	$A0 $25
	STA ($80),Y		; A1C3	$91 $80
	LDY #$02		; A1C5	$A0 $02
	LDA ($62),Y		; A1C7	$B1 $62
	LDY #$26		; A1C9	$A0 $26
	STA ($80),Y		; A1CB	$91 $80
	LDY #$03		; A1CD	$A0 $03
	LDA ($62),Y		; A1CF	$B1 $62
	CMP #$01		; A1D1	$C9 $01
	BNE L321D9		; A1D3	$D0 $04
	LDA #$88		; A1D5	$A9 $88
	BNE L321FC		; A1D7	$D0 $23
L321D9:
	CMP #$05		; A1D9	$C9 $05
	BNE L321E2		; A1DB	$D0 $05
	LDA $9E			; A1DD	$A5 $9E
	JMP $A1FC		; A1DF	$4C $FC $A1
L321E2:
	CMP #$06		; A1E2	$C9 $06
	BNE L321EA		; A1E4	$D0 $04
	LDA #$08		; A1E6	$A9 $08
	BNE L321FC		; A1E8	$D0 $12
L321EA:
	LDX #$00		; A1EA	$A2 $00
	LDA #$0B		; A1EC	$A9 $0B
	JSR $FD11		; A1EE	$20 $11 $FD	random (X..A)
	CMP #$04		; A1F1	$C9 $04
	BCS L321F7		; A1F3	$B0 $02
	BCC L321FC		; A1F5	$90 $05
L321F7:
	SEC			; A1F7	$38
	SBC #$04		; A1F8	$E9 $04
	ORA #$80		; A1FA	$09 $80
L321FC:
	LDY #$2B		; A1FC	$A0 $2B
	STA ($80),Y		; A1FE	$91 $80
	LDY #$2B		; A200	$A0 $2B
	LDA ($80),Y		; A202	$B1 $80
	CMP #$FF		; A204	$C9 $FF
	BNE L3220D		; A206	$D0 $05
	LDA #$01		; A208	$A9 $01
	STA $61			; A20A	$85 $61
	RTS			; A20C	$60
; End of
L3220D:
	LDX #$00		; A20D	$A2 $00
	LDA #$63		; A20F	$A9 $63
	JSR $FD11		; A211	$20 $11 $FD	random (X..A)
	STA $4F			; A214	$85 $4F
	LDY #$04		; A216	$A0 $04
	LDA ($62),Y		; A218	$B1 $62
	SEC			; A21A	$38
	SBC $4F			; A21B	$E5 $4F
	BCC L32228		; A21D	$90 $09
	LDX $4E			; A21F	$A6 $4E
	INX			; A221	$E8
	TXA			; A222	$8A
	LDX $9E			; A223	$A6 $9E
	STA $7FD6,X		; A225	$9D $D6 $7F
L32228:
	LDX $9E			; A228	$A6 $9E
	STA $7FCE,X		; A22A	$9D $CE $7F
	JSR $A2BC		; A22D	$20 $BC $A2
	LDY #$20		; A230	$A0 $20
	JMP $949B		; A232	$4C $9B $94	wait 32 frames
; End of

; Name	:
; Marks	:
	LDA #$82		; A235	$A9 $82		string offset $0100 (item names)
	STA $63			; A237	$85 $63
	LDA #$00		; A239	$A9 $00
	STA $62			; A23B	$85 $62
	LDY #$1C		; A23D	$A0 $1C
	LDX #$00		; A23F	$A2 $00
	LDA ($7A),Y		; A241	$B1 $7A
	STA $64			; A243	$85 $64
	STA $7CC2,X		; A245	$9D $C2 $7C
	INX			; A248	$E8
	TXA			; A249	$8A
	PHA			; A24A	$48
	INY			; A24B	$C8
	TYA			; A24C	$98
	PHA			; A24D	$48
	LDA #$15		; A24E	$A9 $15
	STA $45			; A250	$85 $45
	LDA #$40		; A252	$A9 $40
	STA $44			; A254	$85 $44
	JSR $9AB6		; A256	$20 $B6 $9A	load text (bank 0A)
	JSR $95E7		; A259	$20 $E7 $95	copy text to buffer
	PLA			; A25C	$68
	TAY			; A25D	$A8
	PLA			; A25E	$68
	TAX			; A25F	$AA
	LDA ($7A),Y		; A260	$B1 $7A
	STA $64			; A262	$85 $64
	STA $7CC2,X		; A264	$9D $C2 $7C
	INX			; A267	$E8
	TXA			; A268	$8A
	PHA			; A269	$48
	INY			; A26A	$C8
	TYA			; A26B	$98
	PHA			; A26C	$48
	LDA #$94		; A26D	$A9 $94
	STA $44			; A26F	$85 $44
	JSR $9AB6		; A271	$20 $B6 $9A	load text (bank 0A)
	JSR $95E7		; A274	$20 $E7 $95	copy text to buffer
	PLA			; A277	$68
	TAY			; A278	$A8
	PLA			; A279	$68
	TAX			; A27A	$AA
	LDA ($7A),Y		; A27B	$B1 $7A
	BNE L3228D		; A27D	$D0 $0E
	INY			; A27F	$C8
	LDA ($7A),Y		; A280	$B1 $7A
	DEY			; A282	$88
	STA ($7A),Y		; A283	$91 $7A
	PHA			; A285	$48
	INY			; A286	$C8
	LDA #$00		; A287	$A9 $00
	STA ($7A),Y		; A289	$91 $7A
	DEY			; A28B	$88
	PLA			; A28C	$68
L3228D:
	STA $64			; A28D	$85 $64
	STA $7CC2,X		; A28F	$9D $C2 $7C
	INX			; A292	$E8
	TXA			; A293	$8A
	PHA			; A294	$48
	INY			; A295	$C8
	TYA			; A296	$98
	PHA			; A297	$48
	LDA #$4B		; A298	$A9 $4B
	STA $44			; A29A	$85 $44
	JSR $9AB6		; A29C	$20 $B6 $9A	load text (bank 0A)
	JSR $95E7		; A29F	$20 $E7 $95	copy text to buffer
	PLA			; A2A2	$68
	TAY			; A2A3	$A8
	PLA			; A2A4	$68
	TAX			; A2A5	$AA
	LDA ($7A),Y		; A2A6	$B1 $7A
	STA $64			; A2A8	$85 $64
	STA $7CC2,X		; A2AA	$9D $C2 $7C
	LDA #$75		; A2AD	$A9 $75
	STA $44			; A2AF	$85 $44
	JSR $9AB6		; A2B1	$20 $B6 $9A	load text (bank 0A)
	JMP $95E7		; A2B4	$4C $E7 $95	copy text to buffer
; End of

; Name	:
; Marks	:
	DEC $61			; A2B7	$C6 $61
	JMP $A2BC		; A2B9	$4C $BC $A2
; End of

; Name	:
; Marks	:
	JSR $9A90		; A2BC	$20 $90 $9A	hide cursor sprites
	JMP $FAE4		; A2BF	$4C $E4 $FA	update status animation
; End of

; Name	:
; Marks	:
	LDA $5E			; A2C2	$A5 $5E
	BNE L322D6		; A2C4	$D0 $10
	LDA $5F			; A2C6	$A5 $5F
	BNE L322D0		; A2C8	$D0 $06
	LDA #$00		; A2CA	$A9 $00
	STA $62			; A2CC	$85 $62
	BEQ L322E4		; A2CE	$F0 $14
L322D0:
	LDA #$01		; A2D0	$A9 $01
	STA $62			; A2D2	$85 $62
	BNE L322E4		; A2D4	$D0 $0E
L322D6:
	LDA $5F			; A2D6	$A5 $5F
	BNE L322E0		; A2D8	$D0 $06
	LDA #$02		; A2DA	$A9 $02
	STA $62			; A2DC	$85 $62
	BNE L322E4		; A2DE	$D0 $04
L322E0:
	LDA #$03		; A2E0	$A9 $03
	STA $62			; A2E2	$85 $62
L322E4:
	LDA $53			; A2E4	$A5 $53
	BNE L322F6		; A2E6	$D0 $0E
	LDA $54			; A2E8	$A5 $54
	BNE L322F1		; A2EA	$D0 $05
	LDA #$00		; A2EC	$A9 $00
	STA $63			; A2EE	$85 $63
	RTS			; A2F0	$60
; End of
L322F1:
	LDA #$01		; A2F1	$A9 $01
	STA $63			; A2F3	$85 $63
	RTS			; A2F5	$60
; End of
L322F6:
	LDA $54			; A2F6	$A5 $54
	BNE L322FF		; A2F8	$D0 $05
	LDA #$02		; A2FA	$A9 $02
	STA $63			; A2FC	$85 $63
	RTS			; A2FE	$60
; End of
L322FF:
	LDA #$03		; A2FF	$A9 $03
	STA $63			; A301	$85 $63
	RTS			; A303	$60
; End of

;$A304 - data block = item window positio data
.byte $28,$13,$3E,$1E



; Marks	: do battle round
	JSR $FD46		; A308	$20 $46 $FD
	LDA $7B4A		; A30B	$AD $4A $7B
	BEQ L32352		; A30E	$F0 $42
	JSR $9490		; A310	$20 $90 $94	clear text buffer
	LDX #$09		; A313	$A2 $09		$09: "Preemptive Strike"
	LDY $7B4A		; A315	$AC $4A $7B
	DEY			; A318	$88
	BNE L3231C		; A319	$D0 $01		branch if first strike
	INX			; A31B	$E8		$0A: "Ambushed!"
L3231C:
	STX $64			; A31C	$86 $64
	LDA #$B2		; A31E	$A9 $B2		battle text (05/B295)
	STA $63			; A320	$85 $63
	LDA #$95		; A322	$A9 $95
	STA $62			; A324	$85 $62
	JSR $9AAB		; A326	$20 $AB $9A	load text (bank 05)
	LDA #$10		; A329	$A9 $10
	STA $44			; A32B	$85 $44
	STA $45			; A32D	$85 $45
	LDA #$00		; A32F	$A9 $00
	STA $6F			; A331	$85 $6F
	JSR $95E7		; A333	$20 $E7 $95	copy text to buffer
	JSR $FD5B		; A336	$20 $5B $FD
	LDA #$04		; A339	$A9 $04		bottom window
	STA $64			; A33B	$85 $64
	JSR $FB42		; A33D	$20 $42 $FB	open message window
	LDY #$20		; A340	$A0 $20
	JSR $949B		; A342	$20 $9B $94	wait 32 frames
	JSR $FD46		; A345	$20 $46 $FD
	LDA #$04		; A348	$A9 $04		bottom window
	STA $64			; A34A	$85 $64
	JSR $FB46		; A34C	$20 $46 $FB	close message window
	JSR $FD46		; A34F	$20 $46 $FD
L32352:
	JSR $A68A		; A352	$20 $8A $A6
	JSR $FD5B		; A355	$20 $5B $FD
	JSR $A741		; A358	$20 $41 $A7	do actions
	JMP $905E		; A35B	$4C $5E $90	end of battle loop
; End of

; Name	:
; Marks	: get monster actions
	JSR $9A69		; A35E	$20 $69 $9A	Set NMI subroutine
 	LDA #$00		; A361	$A9 $00
	STA $76			; A363	$85 $76
	LDX #$0F		; A365	$A2 $0F
L32367:
	STA $7FCE,X		; A367	$9D $CE $7F
	DEX			; A36A	$CA
	BPL L32367		; A36B	$10 $FA
	LDA #$7E		; A36D	$A9 $7E		monster battle stats
	STA $45			; A36F	$85 $45
	LDA #$3A		; A371	$A9 $3A
	STA $44			; A373	$85 $44
	JSR $A709		; A375	$20 $09 $A7	get monster status 1
	AND #$C0		; A378	$29 $C0
	BEQ L3237F		; A37A	$F0 $03		branch if not dead or stone
	JSR $A720		; A37C	$20 $20 $A7	do nothing
L3237F:
	JSR $A713		; A37F	$20 $13 $A7	get monster status 2
	AND #$08		; A382	$29 $08
	BNE L3238C		; A384	$D0 $06		branch if asleep
	LDA ($44),Y		; A386	$B1 $44
	AND #$40		; A388	$29 $40
	BEQ L3238F		; A38A	$F0 $03		branch if not paralyzed
L3238C:
	JSR $A720		; A38C	$20 $20 $A7	do nothing
L3238F:
	LDA $7B4B		; A38F	$AD $4B $7B
	BNE L32401		; A392	$D0 $6D
	LDA #$7D		; A394	$A9 $7D		7D7A (character battle stats)
	STA $47			; A396	$85 $47
	LDA #$7A		; A398	$A9 $7A
	STA $46			; A39A	$85 $46
	LDX #$04		; A39C	$A2 $04
	JSR $A63A		; A39E	$20 $3A A6	get current hp sum
	LDA $02			; A3A1	$A5 $02
	STA $00			; A3A3	$85 $00
	LDA $03			; A3A5	$A5 $03
	STA $01			; A3A7	$85 $01
	LDA #$7E		; A3A9	$A9 $7E		7E3A (monster battle stats)
	STA $47			; A3AB	$85 $47
	LDA #$3A		; A3AD	$A9 $3A
	STA $46			; A3AF	$85 $46
	LDX #$08		; A3B1	$A2 $08
	JSR $A63A		; A3B3	$20 $3A $A6	get current hp sum
	SEC			; A3B6	$38
	LDA $00			; A3B7	$A5 $00		$00(ADDR) = character sum - monster sum
	SBC $02			; A3B9	$E5 $02
	STA $00			; A3BB	$85 $00
	LDA $01			; A3BD	$A5 $01
	SBC $03			; A3BF	$E5 $03
	STA $01			; A3C1	$85 $01
	BCS L323CB		; A3C3	$B0 $06		min 0
	LDA #$00		; A3C5	$A9 $00
	STA $00			; A3C7	$85 $00
	STA $01			; A3C9	$85 $01
L323CB:
	LSR $01			; A3CB	$46 $01		divide by 32
	ROR $00			; A3CD	$66 $00
	LSR $01			; A3CF	$46 $01
	ROR $00			; A3D1	$66 $00
	LSR $01			; A3D3	$46 $01
	ROR $00			; A3D5	$66 $00
	LSR $01			; A3D7	$46 $01
	ROR $00			; A3D9	$66 $00
	LSR $01			; A3DB	$46 $01
	ROR $00			; A3DD	$66 $00
	LDY #$14		; A3DF	$A0 $14
	CLC			; A3E1	$18
	LDA ($44),Y		; A3E2	$B1 $44		add to monster fear level
	ADC $00			; A3E4	$65 $00
	STA $00			; A3E6	$85 $00
	SEC			; A3E8	$38
	SBC #$AA		; A3E9	$E9 $AA		subrtact 170
	STA $48			; A3EB	$85 $48
	BCS L323F3		; A3ED	$B0 $04		min 0
	LDA #$00		; A3EF	$A9 $00
	STA $48			; A3F1	$85 $48
L323F3:
	LDX #$01		; A3F3	$A2 $01
	LDA #$64		; A3F5	$A9 $64
	JSR $FD11		; A3F7	$20 $11 $FD	random (X..A)
	CMP $48			; A3FA	$C5 $48
	BCS L32401		; A3FC	$B0 $03		branch if monster doesn't try to run
	JSR $A736		; A3FE	$20 $36 $A7	run away
L32401:
	LDY #$0C		; A401	$A0 $0C
	LDA ($44),Y		; A403	$B1 $44		current mp
	INY			; A405	$C8
	ORA ($44),Y		; A406	$11 $44
	BNE L3240D		; A408	$D0 $03		branch if monster has mp left
	JSR $A72B		; A40A	$20 $2B $A7	fight
L3240D:
	LDX $76			; A40D	$A6 $76
	LDA $7B62,X		; A40F	$BD $62 $7B	monster id
	STA $00			; A412	$85 $00
	LDA #$0A		; A414	$A9 $0A
	STA $02			; A416	$85 $02
	LDA #$00		; A418	$A9 $00
	STA $01			; A41A	$85 $01
	STA $03			; A41C	$85 $03
	JSR $FC98		; A41E	$20 $98 $FC	multiply (16-bit)
	CLC			; A421	$18
	LDA $04			; A422	$A5 $04
	ADC #<Mob_prop
	;ADC #$C3		; A424	$69 $C3		Mob_prop (monster properties 0C/87C3)
	STA $46			; A426	$85 $46
	LDA $05			; A428	$A5 $05
	ADC #>Mob_prop
	;ADC #$87		; A42A	$69 $87
	STA $47			; A42C	$85 $47
	LDY #$00		; A42E	$A0 $00
	LDA ($46),Y		; A430	$B1 $46		monster properties byte 0 (special attack)
	BPL L32437		; A432	$10 $03		branch if monster has a valid special
	JSR $A72B		; A434	$20 $2B $A7
L32437:
	STA $00			; A437	$85 $00
	LDA #$08		; A439	$A9 $08
	STA $02			; A43B	$85 $02
	LDA #$00		; A43D	$A9 $00
	STA $01			; A43F	$85 $01
	STA $03			; A441	$85 $03
	JSR $FC98		; A443	$20 $98 $FC
	CLC			; A446	$18
	LDA $04			; A447	$A5 $04
	ADC #<Mob_AI
	;ADC #$73		; A449	$69 $73		Mob_AI (monster special attacks 0C/8D73)
	STA $46			; A44B	$85 $46
	LDA $05			; A44D	$A5 $05
	ADC #>Mob_AI
	;ADC #$8D		; A44F	$69 $8D
	STA $47			; A451	$85 $47
	LDX #$00		; A453	$A2 $00
	LDA #$63		; A455	$A9 $63
	JSR $FD11		; A457	$20 $11 $FD	random (X..A)
	STA $00			; A45A	$85 $00
	LDY #$07		; A45C	$A0 $07
L3245E:
	LDA $A718,Y		; A45E	$B9 $18 $A7	probalilities for monster special attacks
	CMP $00			; A461	$C5 $00
	BCS L32468		; A463	$B0 $03
	DEY			; A465	$88
	BPL L3245E		; A466	$10 $F6
L32468:
	LDA ($46),Y		; A468	$B1 $46		attack id
	STA $00			; A46A	$85 $00
	BNE L32471		; A46C	$D0 $03		branch if not fight
	JSR $A72B		; A46E	$20 $2B $A7	fight
L32471:
	CMP #$FE		; A471	$C9 $FE
	BNE L32478		; A473	$D0 $03		branch if not run away
	JSR $A736		; A475	$20 $36 $A7	run away
L32478:
	DEC $00			; A478	$C6 $00
	LDA #$05		; A47A	$A9 $05
	STA $02			; A47C	$85 $02
	LDA #$00		; A47E	$A9 $00
	STA $01			; A480	$85 $01
	STA $03			; A482	$85 $03
	JSR $FC98		; A484	$20 $98 $FC	multiply (16-bit)
	CLC			; A487	$18
	LDA $04			; A488	$A5 $04
	ADC #<ItemAttack_prop
	;ADC #$36		; A48A	$69 $36		item/attack properties (0C/8336)
	STA $46			; A48C	$85 $46
	LDA $05			; A48E	$A5 $05
	ADC #>ItemAttack_prop
	;ADC #$83		; A490	$69 $83
	STA $47			; A492	$85 $47
	LDY #$01		; A494	$A0 $01
	LDA ($46),Y		; A496	$B1 $46
	LDY #$25		; A498	$A0 $25
	STA ($44),Y		; A49A	$91 $44		set spell level
	LDY #$02		; A49C	$A0 $02
	LDA ($46),Y		; A49E	$B1 $46
	LDY #$26		; A4A0	$A0 $26
	STA ($44),Y		; A4A2	$91 $44		set mod. spell %
	LDY #$03		; A4A4	$A0 $03
	LDA ($46),Y		; A4A6	$B1 $46
	STA $48			; A4A8	$85 $48
	LDY #$00		; A4AA	$A0 $00
	LDA ($46),Y		; A4AC	$B1 $46
	TYA			; A4AE	$A8
	DEY			; A4AF	$88
	STY $00			; A4B0	$84 $00		magic id
	TYA			; A4B2	$98
	LDX $76			; A4B3	$A6 $76
	STA $7CD3,X		; A4B5	$9D $D3 $7C
	LDA #$07		; A4B8	$A9 $07
	STA $02			; A4BA	$85 $02
	LDA #$00		; A4BC	$A9 $00
	STA $01			; A4BE	$85 $01
	STA $03			; A4C0	$85 $03
	JSR $FC98		; A4C2	$20 $98 $FC	multiply (16-bit)
	CLC			; A4C5	$18
	LDA $04			; A4C6	$A5 $04
	ADC #$D9		; A4C8	$69 $D9		magic properties (0C/85D9)
	STA $46			; A4CA	$85 $46
	LDA $05			; A4CC	$A5 $05
	ADC #$85		; A4CE	$69 $85
	STA $47			; A4D0	$85 $47
	LDY #$00		; A4D2	$A0 $00
	LDA ($46),Y		; A4D4	$B1 $46		battle command
	STA $49			; A4D6	$85 $49
	CMP #$28		; A4D8	$C9 $28
	BCS L324EF		; A4DA	$B0 $13
	JSR $A713		; A4DC	$20 $13 $A7	get monster status 2
	AND #$10		; A4DF	$29 $10
	BNE L324EC		; A4E1	$D0 $09		branch if mute
	JSR $A709		; A4E3	$20 $09 $A7	get monster status 1
	AND #$10		; A4E6	$29 $10
	BNE L324EC		; A4E8	$D0 $02		branch if amnesia
	BNE L324EF		; A4EA	$F0 $03
L324EC:
	JSR $A72B		; A4EC	$20 $2B $A7	fight
L324EF:
	LDY #$02		; A4EF	$A0 $02
	LDA ($46),Y		; A4F1	$B1 $46
	LDY #$27		; A4F3	$A0 $27		set mod. spell power
	STA ($44),Y		; A4F5	$91 $44
	LDY #$03		; A4F7	$A0 $03
	LDA ($46),Y		; A4F9	$B1 $46
	LDY #$28		; A4FB	$A0 $28
	STA ($44),Y		; A4FD	$91 $44		set spell parameters
	LDY #$04		; A4FF	$A0 $04
	LDA ($46),Y		; A501	$B1 $46
	LDY #$29		; A503	$A0 $29
	STA ($44),Y		; A505	$91 $44
	LDY #$05		; A507	$A0 $05
	LDA ($46),Y		; A509	$B1 $46
	LDY #$23		; A50B	$A0 $23
	STA ($44),Y		; A50D	$91 $44		set special effects
	LDY #$06		; A50F	$A0 $06
	LDA ($46),Y		; A511	$B1 $46
	LDY #$24		; A513	$A0 $24
	STA ($44),Y		; A515	$91 $44		set spell % panalty
	LDY #$2A		; A517	$A0 $2A
	LDA $49			; A519	$A5 $49
	STA ($44),Y		; A51B	$91 $44		set battle command
	INY			; A51D	$C8
	LDA $48			; A51E	$A5 $48
	STA ($44),Y		; A520	$91 $44
	JSR $A713		; A522	$20 $13 $A7	get monster status 2
	BPL L3253A		; A525	$10 $13		branch if not confused
	LDX #$00		; A527	$A2 $00		target a random monster
	LDA #$07		; A529	$A9 $07
	JSR $FD11		; A52B	$20 $11 $FD	random (X..A)
	TAX			; A52E	$AA
	LDA $7B62,X		; A52F	$BD $62 $7B
	BMI L32527		; A532	$30 $F3
	TXA			; A534	$8A
	ORA #$80		; A535	$09 $80
L32527:
	JMP $A610		; A537	$4C $10 $A6
L3253A:
	LDY #$2A		; A53A	$A0 $2A
	LDA ($44),Y		; A53C	$B1 $44		battle command
	BNE L32571		; A53E	$D0 $31		branch if not fight
	LDX $76			; A540	$A6 $76
	LDA $7B5A,X		; A542	$BD $5A $7B
	BEQ L3254A		; A545	$F0 $03		branch if in front row
	JSR $A720		; A547	$20 $20 $A7	do nothing
L3254A:
	LDX #$00		; A54A	$A2 $00		target a random character
	LDA #$03		; A54C	$A9 $03
	JSR $FD11		; A54E	$20 $11 $FD	random (X..A)
	STA $9E			; A551	$85 $9E
	JSR $96E1		; A553	$20 $E1 $96	update character/monster pointers
	JSR $AF6C		; A556	$20 $6C $AF	get status 1
	AND #$C0		; A559	$29 $C0
	BEQ L3255F		; A55B	$F0 $02		branch if not dead or stone
	BNE L3254A		; A55D	$D0 $EB
L3255F:
	LDY #$35		; A55F	$A0 $35
	LDA ($7E),Y		; A561	$B1 $7E		character row
	LSR A			; A563	$4A
	BCC L32568		; A564	$90 $02		branch if fornt row
	BCS L3254A		; A566	$B0 $E2		can't target back row characters
L32568:
	LDA $9E			; A568	$A5 $9E
	TAX			; A56A	$AA
	INC $7D37,X		; A56B	$FE $37 $7D	incrment character physical hit counter
	JMP $A610		; A56E	$4C $10 $A6
; End of
L32571:
	LDY #$2B		; A571	$A0 $2B
	LDA ($44),Y		; A573	$B1 $44
	CMP #$01		; A575	$C9 $01
	BNE L3257E		; A577	$D0 $05
	LDA #$08		; A579	$A9 $08
	JMP $A60C		; A57B	$4C $0C $A6
L3257E:
	CMP #$02		; A57E	$C9 $02
	BNE L3259A		; A580	$D0 $18
L32582:
	LDX #$00		; A582	$A2 $00
	LDA #$03		; A584	$A9 $03
	JSR $FD11		; A586	$20 $11 $FD	random (X..A)
	STA $9E			; A589	$85 $9E
	JSR $96E1		; A58B	$20 $E1 $96	update character/monster pointers
	JSR $AF6C		; A58E	$20 $6C $AF
	AND #$C0		; A591	$29 $C0
	BNE L32582		; A593	$D0 $ED
	LDA $9E			; A595	$A5 $9E
	JMP $A60C		; A597	$4C $0C $A6
L3259A:
	CMP #$05		; A59A	$C9 $05
	BNE L325A5		; A59C	$D0 $07
	LDA $76			; A59E	$A5 $76
	ORA #$80		; A5A0	$09 $80
	JMP $A610		; A5A2	$4C $10 $A6
L325A5:
	CMP #$06		; A5A5	$C9 $06
	BNE L325AE		; A5A7	$D0 $05
	LDA #$88		; A5A9	$A9 $88
	JMP $A610		; A5AB	$4C $10 $A6
L325AE:
	CMP #$07		; A5AE	$C9 $07
	BNE L325CD		; A5B0	$D0 $1B
L325B2:
	LDX #$00		; A5B2	$A2 $00
	LDA #$07		; A5B4	$A9 $07
	JSR $FD11		; A5B6	$20 $11 $FD	random (X..A)
	STA $4E			; A5B9	$85 $4E
	LDA #$3A		; A5BB	$A9 $3A
	STA $48			; A5BD	$85 $48
	LDA #$7E		; A5BF	$A9 $7E
	STA $49			; A5C1	$85 $49
	JSR $A668		; A5C3	$20 $68 $A6
	BMI L325B2		; A5C6	$30 $EA
	LDA $4E			; A5C8	$A5 $4E
	JMP $A610		; A5CA	$4C $10 $A6
L325CD:
	LDX #$00		; A5CD	$A2 $00
	LDA #$0B		; A5CF	$A9 $0B
	JSR $FD11		; A5D1	$20 $11 $FD	random (X..A)
	STA $4E			; A5D4	$85 $4E
	CMP #$04		; A5D6	$C9 $04
	BCS L325E9		; A5D8	$B0 $0F
	LDA #$7A		; A5DA	$A9 $7A
	STA $48			; A5DC	$85 $48
	LDA #$7D		; A5DE	$A9 $7D
	STA $49			; A5E0	$85 $49
	JSR $A668		; A5E2	$20 $68 $A6
	BMI L325CD		; A5E5	$30 $E6
	BPL L32607		; A5E7	$10 $1E
L325E9:
	SEC			; A5E9	$38
	SBC #$04		; A5EA	$E9 $04
	STA $4E			; A5EC	$85 $4E
	LDA #$3A		; A5EE	$A9 $3A
	STA $48			; A5F0	$85 $48
	LDA #$7E		; A5F2	$A9 $7E
	STA $49			; A5F4	$85 $49
	JSR $A668		; A5F6	$20 $68 $A6
	BMI L325CD		; A5F9	$30 $D2
	LDA $4E			; A5FB	$A5 $4E
	AND $76			; A5FD	$25 $76
	BNE L325CD		; A5FF	$D0 $CC
	LDA $4E			; A601	$A5 $4E
	ORA #$80		; A603	$09 $80
	STA $4E			; A605	$85 $4E
L32607:
	LDA $4E			; A607	$A5 $4E
	JMP $A610		; A609	$4C $10 $A6
	TAX			; A60C	$AA
	INC $7D3B,X		; A60D	$FE $3B $7D
	LDY #$2B		; A610	$A0 $2B
	STA ($44),Y		; A612	$91 $44
	INC $76			; A614	$E6 $76
	LDA $76			; A616	$A5 $76
	CMP #$08		; A618	$C9 $08
	BEQ L3262C		; A61A	$F0 $10
	CLC			; A61C	$18
	LDA $44			; A61D	$A5 $44
	ADC #$30		; A61F	$69 $30
	STA $44			; A621	$85 $44
	LDA $45			; A623	$A5 $45
	ADC #$00		; A625	$69 $00
	STA $45			; A627	$85 $45
	JMP $A375		; A629	$4C $75 $A3
L3262C:
	LDA #$01		; A62C	$A9 $01
	STA $AC			; A62E	$85 $AC
L32630:
	LDA $AC			; A630	$A5 $AC
	BNE L32630		; A632	$D0 $FC		LOOP Wait NMI IRQ
	JSR $FA2A		; A634	$20 $2A $FA
	JMP $9A5D		; A637	$4C $5D $9A
; End of

; Name	:
; X	: number of characters/monsters to sum
; Marks	: get current hp sum
;	  $02(ADDR) = sum of hp (out)
;	  $46(ADDR) = pointer to character/monster battle stats
	LDA #$00		; A63A	$A9 $00
	STA $02			; A63C	$85 $02
	STA $03			; A63E	$85 $03
L32640:
	JSR $A70E		; A640	$20 $0E $A7	get status 1
	AND #$C0		; A643	$29 $C0
	BNE L32657		; A645	$D0 $10		branch if dead or stone
	LDY #$0A		; A647	$A0 $0A
	CLC			; A649	$18
	LDA ($46),Y		; A64A	$B1 $46		add current hp
	ADC $02			; A64C	$65 $02
	STA $02			; A64E	$85 $02
	INY			; A650	$C8
	LDA ($46),Y		; A651	$B1 $46
	ADC $03			; A653	$65 $03
	STA $03			; A655	$85 $03
L32657:
	CLC			; A657	$18		next character
	LDA $46			; A658	$A5 $46
	ADC #$30		; A65A	$69 $30
	STA $46			; A65C	$85 $46
	LDA $47			; A65E	$A5 $47
	ADC #$00		; A660	$69 $00
	STA $47			; A662	$85 $47
	DEX			; A664	$CA
	BNE L32640		; A665	$D0 $D9
	RTS			; A667	$60
; End of

;A668
	LDA $4E			; A668	$A5 $4E
	STA $00			; A66A	$85 $00
	LDA #$30		; A66C	$A9 $30
	STA $02			; A66E	$85 $02
	LDA #$00		; A670	$A9 $00
	STA $01			; A672	$85 $01
	STA $03			; A674	$85 $03
	JSR $FC98		; A676	$20 $98 $FC	multiply (16-bit)
	CLC			; A679	$18
	LDA $04			; A67A	$A5 $04
	ADC $48			; A67C	$65 $48
	STA $46			; A67E	$85 $46
	LDA $05			; A680	$A5 $05
	ADC $49			; A682	$65 $49
	STA $47			; A684	$85 $47
	JSR $A70E		; A686	$20 $0E $A7	get status 1
	RTS			; A689	$60

; Name	:
; Marks	:
	LDY #$00		; A68A	$A0 $00
	STY $54			; A68C	$84 $54
	STY $9E			; A68E	$84 $9E
	LDX #$00		; A690	$A2 $00
L32692:
	JSR $96E1		; A692	$20 $E1 $96	update character/monster pointers
	LDY #$01		; A695	$A0 $01
	LDA ($80),Y		; A697	$B1 $80
	STA $82,X		; A699	$95 $82
	INX			; A69B	$E8
	INC $9E			; A69C	$E6 $9E
	CPX #$04		; A69E	$E0 $04
	BNE L32692		; A6A0	$D0 $F0
L326A2:
	LDX #$01		; A6A2	$A2 $01
	LDA #$28		; A6A4	$A9 $28
	JSR $FD11		; A6A6	$20 $11 $FD	random (X..A)
	LDX $54			; A6A9	$A6 $54
	STA $48,X		; A6AB	$95 $48
	INC $54			; A6AD	$E6 $54
	CPX #$0C		; A6AF	$E0 $0C
	BNE L326A2		; A6B1	$D0 $EF
	LDX #$00		; A6B3	$A2 $00
	STX $54			; A6B5	$86 $54
L326B7:
	LDX $54			; A6B7	$A6 $54
	CLC			; A6B9	$18
	LDA $48,X		; A6BA	$B5 $48
	ADC $82,X		; A6BC	$75 $82
	STA $48,X		; A6BE	$95 $48
	INC $54			; A6C0	$E6 $54
	LDA $54			; A6C2	$A5 $54
	CMP #$04		; A6C4	$C9 $04
	BNE L326B7		; A6C6	$D0 $EF
	LDA #$7E		; A6C8	$A9 $7E
	STA $55			; A6CA	$85 $55
	LDA #$3A		; A6CC	$A9 $3A
	STA $54			; A6CE	$85 $54
	LDX #$04		; A6D0	$A2 $04
	LDY #$01		; A6D2	$A0 $01
L326D4:
	CLC			; A6D4	$18
	LDA $48,X		; A6D5	$B5 $48
	ADC ($54),Y		; A6D7	$71 $54
	STA $48,X		; A6D9	$95 $48
	INX			; A6DB	$E8
	CLC			; A6DC	$18
	LDA $54			; A6DD	$A5 $54
	ADC #$30		; A6DF	$69 $30
	STA $54			; A6E1	$85 $54
	LDA $55			; A6E3	$A5 $55
	ADC #$00		; A6E5	$69 $00
	STA $55			; A6E7	$85 $55
	CPX #$0C		; A6E9	$E0 $0C
	BNE L326D4		; A6EB	$D0 $E7
	JSR $9A63		; A6ED	$20 $63 $9A
	LDA #$00		; A6F0	$A9 $00
	STA $05			; A6F2	$85 $05
	LDA #$47		; A6F4	$A9 $47
	STA $04			; A6F6	$85 $04
	LDA #$7D		; A6F8	$A9 $7D
	STA $07			; A6FA	$85 $07
	LDA #$5D		; A6FC	$A9 $5D
	STA $06			; A6FE	$85 $06
	LDA #$01		; A700	$A9 $01
	STA $02			; A702	$85 $02
	LDA #$0C		; A704	$A9 $0C
	JMP $8F5E		; A706	$4C $5E $8F	sort values
; End of

; Name	:
; Marks	: get monster status 1
	LDY #$08		; A709	$A0 $08
	LDA ($44),Y		; A70B	$B1 $44
	RTS			; A70D	$60
; End of

; Name	:
; Marks	: get status 1
	LDY #$08		; A70E	$A0 $08
	LDA ($46),Y		; A710	$B1 $46
	RTS			; A712	$60
; End of

; Name	:
; Marks	: get monster status 2
	LDY #$09		; A713	$A0 $09
	LDA ($44),Y		; A715	$B1 $44
	RTS			; A717	$60
; End of

;A718 - data block = probalilities for monster special attacks
.byte $64,$50,$3C,$28,$1E,$14,$0A,$05

; Name	:
; Marks	: do nothing (monster)
	LDY #$2A		; A720	$A0 $2A
	LDA #$FF		; A722	$A9 $FF
	STA ($44),Y		; A724	$91 $44
	PLA			; A726	$68
	PLA			; A727	$68
	JMP $A614		; A728	$4C $14 $A6
; End of

; Name	:
; Marks	: fight (monster)
	LDY #$2A		; A72B	$A0 $2A
	LDA #$00		; A72D	$A9 $00
	STA ($44),Y		; A72F	$91 $44
	PLA			; A731	$68
	PLA			; A732	$68
	JMP $A522		; A733	$4C $22 $A5
; End of

; Name	:
; Marks	: run away (monster)
	LDY #$2A		; A736	$A0 $2A
	LDA #$FE		; A738	$A9 $FE
	STA ($44),Y		; A73A	$91 $44
	PLA			; A73C	$68
	PLA			; A73D	$68
	JMP $A614		; A73E	$4C $14 $A6
; End of

; Name	:
; Marks	: $7E, $9F(ADDR) = battle stats
;	  do action
	LDX #$00		; A741	$A2 $00
	STX turn_order_cnt	; A743	$8E $BB $7C	counter for turn order
	LDX #$00		; A746	$A2 $00		LOOP START turn order ==========
	STX $A6			; A748	$86 $A6
	STX $2B			; A74A	$86 $2B
	STX $7CB7		; A74C	$8E $B7 $7C	monster ran away
	LDX #$00		; A74F	$A2 $00
	STX $7FDE		; A751	$8E $DE $7F
	STX $AD			; A754	$86 $AD
	STX $AE			; A756	$86 $AE
	STX $E4			; A758	$86 $E4
	STX $7CB6		; A75A	$8E $B6 $7C
	LDX #$80		; A75D	$A2 $80
	STX $28			; A75F	$86 $28
	STX $AF			; A761	$86 $AF
	LDX #$08		; A763	$A2 $08
	STX $E3			; A765	$86 $E3
	LDA #$FF		; A767	$A9 $FF		reset battle message queue
	LDX #$13		; A769	$A2 $13
L3276B:
	STA msg_que,X		; A76B	$9D $BA $7F
	DEX			; A76E	$CA
	BPL L3276B		; A76F	$10 $FA		loop
	JSR Wait_MENU_snd	; A771	$20 $5B $FD
	JSR $9A69		; A774	$20 $69 $9A	Set NMI subroutine
	LDX turn_order_cnt	; A777	$AE $BB $7C	counter for turn order
	LDA turn_order_que,X	; A77A	$BD $5E $7D	read turn order from queue
	STA $26			; A77D	$85 $26		turn order temp
	CMP #$04		; A77F	$C9 $04
	BCS L32786		; A781	$B0 $03
	JMP $A7FB		; A783	$4C $FB $A7	player turn
L32786:
	LDX $7B4A		; A786	$AE $4A $7B	enemy turn - battle type
	BEQ L32795		; A789	$F0 $0A
	CPX #$02		; A78B	$E0 $02
	BNE L32795		; A78D	$D0 $06
	JSR $AC93		; A78F	$20 $93 $AC	do nothing this round
	JMP $A98C		; A792	$4C $8C $A9
L32795:
	SEC			; A795	$38
	SBC #$04		; A796	$E9 $04
	STA $00			; A798	$85 $00		enemy index ??
	STA $7CCD		; A79A	$8D $CD $7C
	TAX			; A79D	$AA
	LDA $7B62,X		; A79E	$BD $62 $7B	monster id in each slot
	CMP #$7F		; A7A1	$C9 $7F
	BEQ L327A7		; A7A3	$F0 $02
	ORA #$80		; A7A5	$09 $80
L327A7:
	STA cur_turn_id		; A7A7	$85 $E1
	LDA #$30		; A7A9	$A9 $30
	STA $02			; A7AB	$85 $02
	LDA #$00		; A7AD	$A9 $00
	STA $01			; A7AF	$85 $01
	STA $03			; A7B1	$85 $03
	JSR $FC98		; A7B3	$20 $98 $FC
	CLC			; A7B6	$18
	LDA $04			; A7B7	$A5 $04
	ADC #$3A		; A7B9	$69 $3A		monster battle stats (7E3A)
	STA $9F			; A7BB	$85 $9F
	LDA $05			; A7BD	$A5 $05
	ADC #$7E		; A7BF	$69 $7E
	STA $A0			; A7C1	$85 $A0
	JSR Get_player_status1	; A7C3	$20 $71 $AF
	AND #$80		; A7C6	$29 $80
	BNE L327D1		; A7C8	$D0 $07		branch if dead
	INY			; A7CA	$C8
	LDA ($9F),Y		; A7CB	$B1 $9F		status 2
	AND #$48		; A7CD	$29 $48
	BEQ L327D7		; A7CF	$F0 $06		branch if not paralyzed or asleep
L327D1:
	JSR $AC93		; A7D1	$20 $93 $AC	do nothing this round
	JMP $A98C		; A7D4	$4C $8C $A9
L327D7:
	LDY #$2A		; A7D7	$A0 $2A
	LDA ($9F),Y		; A7D9	$B1 $9F		battle command
	BMI L327E0		; A7DB	$30 $03
	JMP $A8B7		; A7DD	$4C $B7 $A8
L327E0:
	CMP #$FF		; A7E0	$C9 $FF
	BNE L327EA		; A7E2	$D0 $06
	JSR $ACA2		; A7E4	$20 $A2 $AC	show "nothing happend" message
	JMP $A98C		; A7E7	$4C $8C $A9
L327EA:
	LDY #$08		; A7EA	$A0 $08
	LDA #$C0		; A7EC	$A9 $C0		set dead and stone
	STA ($9F),Y		; A7EE	$91 $9F
	LDA #$01		; A7F0	$A9 $01
	STA $7CB6		; A7F2	$8D $B6 $7C
	JSR $ACB1		; A7F5	$20 $B1 $AC
	JMP $A98C		; A7F8	$4C $8C $A9	show "escaped" message
	STA $9E			; A7FB	$85 $9E		player turn routine
	STA cur_turn_id		; A7FD	$85 $E1
	LDX $7B4A		; A7FF	$AE $4A $7B	battle type
	DEX			; A802	$CA
	BNE L3280B		; A803	$D0 $06
	JSR $AC93		; A805	$20 $93 $AC	do nothing this round - surprised(battle type = 01h) ??
	JMP $A98C		; A808	$4C $8C $A9
L3280B:
	JSR $96E1		; A80B	$20 $E1 $96	update character/monster pointers - get char properties ??
	LDA $7A			; A80E	$A5 $7A
	STA $A3			; A810	$85 $A3
	LDA $7B			; A812	$A5 $7B
	STA $A4			; A814	$85 $A4
	LDA $80			; A816	$A5 $80
	STA $9F			; A818	$85 $9F
	LDA $81			; A81A	$A5 $81
	STA $A0			; A81C	$85 $A0
	JSR Get_player_status1	; A81E	$20 $71 $AF
	AND #$C0		; A821	$29 $C0		dead(bit7) / stone(bit6)
	STA $4E			; A823	$85 $4E
	BNE L32830		; A825	$D0 $09		branch if dead or stone
	INY			; A827	$C8
	LDA ($9F),Y		; A828	$B1 $9F		status 2
	AND #$48		; A82A	$29 $48		paralyze / sleep
	STA $4F			; A82C	$85 $4F
	BEQ L3285F		; A82E	$F0 $2F		branch if not asleep or paralyzed
L32830:
	LDA #$FF		; A830	$A9 $FF
	LDY #$2A		; A832	$A0 $2A
	STA ($9F),Y		; A834	$91 $9F		battle command
	LDA $4E			; A836	$A5 $4E
	BNE L32859		; A838	$D0 $1F
	LDA $4F			; A83A	$A5 $4F		case asleep or paralyzed
	LDX #$06		; A83C	$A2 $06
	JSR $9016		; A83E	$20 $16 $90
	BEQ L3284A		; A841	$F0 $07
	LDA #$12		; A843	$A9 $12		$12: "Paralyzed"
	JSR $BF92		; A845	$20 $92 $BF	add to battle message queue
	BNE L3284F		; A848	$D0 $05
L3284A:
	LDA #$11		; A84A	$A9 $11		$11: "Asleep"
	JSR $BF92		; A84C	$20 $92 $BF	add to battle message queue
L3284F:
	JSR $BE7E		; A84F	$20 $7E $BE
	LDX #$00		; A852	$A2 $00
	STA $A6			; A854	$86 $A6
	JMP $A98C		; A856	$4C $8C $A9
L32859:
	JSR $AC93		; A859	$20 $93 $AC	do nothing this round - init ?? - dead or stone
	JMP $A98C		; A85C	$4C $8C $A9
L3285F:
	LDY #$2A		; A85F	$A0 $2A
	LDA ($9F),Y		; A861	$B1 $9F		battle command
	BPL L32892		; A863	$10 $2D
	CMP #$FE		; A865	$C9 $FE
	BNE L3288C		; A867	$D0 $23		branch if not running away
	LDA $7B4B		; A869	$AD $4B $7B
	BNE L32886		; A86C	$D0 $18
	LDX #$00		; A86E	$A2 $00
	LDA #$64		; A870	$A9 $64
	JSR $FD11		; A872	$20 $11 $FD	random (X..A)
	LDY #$01		; A875	$A0 $01
	SBC ($9F),Y		; A877	$F1 $9F		check vs. evade %
	BCS L32886		; A879	$B0 $0B		branch if check failed
	LDA #$01		; A87B	$A9 $01
	STA $7CB7		; A87D	$8D $B7 $7C	ran away
	JSR $ACB1		; A880	$20 $B1 $AC	show "escaped" message
	JMP $A98C		; A883	$4C $8C $A9
L32886:
	JSR $ACC0		; A886	$20 $C0 $AC	show "can't escape" message
	JMP $A98C		; A889	$4C $8C $A9
L3288C:
	JSR $AC93		; A88C	$20 $93 $AC	do nothing this round
	JMP $A98C		; A88F	$4C $8C $A9
L32892:
	BNE L328B7		; A892	$D0 $23
	LDY #$35		; A894	$A0 $35
	LDA ($7E),Y		; A896	$B1 $7E
	LSR A			; A898	$4A
	BCC L328B7		; A899	$90 $1C
	LDY #$2E		; A89B	$A0 $2E
	LDA ($80),Y		; A89D	$B1 $80
	CMP #$07		; A89F	$C9 $07
	BEQ L328B7		; A8A1	$F0 $14
	INY			; A8A3	$C8
	LDA ($80),Y		; A8A4	$B1 $80
	CMP #$07		; A8A6	$C9 $07
	BEQ L328B7		; A8A8	$F0 $0D
	JSR $ACCF		; A8AA	$20 $CF $AC	show "not effective" message
	LDA #$00		; A8AD	$A9 $00
	STA $E4			; A8AF	$85 $E4
	LDA #$FF		; A8B1	$A9 $FF
	LDY #$2A		; A8B3	$A0 $2A
	STA ($9F),Y		; A8B5	$91 $9F
L328B7:
	LDA $A6			; A8B7	$A5 $A6		do attack
	BNE L328D4		; A8B9	$D0 $19
	LDY #$2B		; A8BB	$A0 $2B
	LDA ($9F),Y		; A8BD	$B1 $9F		target m???aiii ??
	AND #$08		; A8BF	$29 $08
	BEQ L328D4		; A8C1	$F0 $11
	LDA ($9F),Y		; A8C3	$B1 $9F		ally target
	PHA			; A8C5	$48
	BMI L328CB		; A8C6	$30 $03
	SEC			; A8C8	$38
	SBC #$04		; A8C9	$E9 $04
L328CB:
	AND #$7F		; A8CB	$29 $7F
	STA $A6			; A8CD	$85 $A6
	PLA			; A8CF	$68
	AND #$80		; A8D0	$29 $80
	STA ($9F),Y		; A8D2	$91 $9F
L328D4:
	LDY #$2B		; A8D4	$A0 $2B		enemy target
	LDA ($9F),Y		; A8D6	$B1 $9F		target
	PHA			; A8D8	$48
	AND #$7F		; A8D9	$29 $7F
	STA $00			; A8DB	$85 $00
	LDA #$30		; A8DD	$A9 $30
	STA $02			; A8DF	$85 $02
	LDA #$00		; A8E1	$A9 $00
	STA $01			; A8E3	$85 $01
	STA $03			; A8E5	$85 $03
	JSR $FC98		; A8E7	$20 $98 $FC	init ?? calc ??
	PLA			; A8EA	$68
	STA $E3			; A8EB	$85 $E3		target
.byte $8D,$27,$00
	;STA $0027		; A8ED	$8D $27 $00	target
	BMI L32901		; A8F0	$30 $0F		branch if a monster
	CLC			; A8F2	$18
	LDA #$7A		; A8F3	$A9 $7A
	ADC $04			; A8F5	$65 $04
	STA $A1			; A8F7	$85 $A1
	LDA #$7D		; A8F9	$A9 $7D
	ADC $05			; A8FB	$65 $05
	STA $A2			; A8FD	$85 $A2
	BNE L32922		; A8FF	$D0 $21
L32901:
	AND #$7F		; A901	$29 $7F
	TAX			; A903	$AA
	LDA $7B6A,X		; A904	$BD $6A $7B	item dropped by each monster
	CMP #$7F		; A907	$C9 $7F
	BEQ L3290D		; A909	$F0 $02
	ORA #$80		; A90B	$09 $80
L3290D:
	STA $E3			; A90D	$85 $E3		target -> item ??
	TXA			; A90F	$8A
	CLC			; A910	$18
	ADC #$04		; A911	$69 $04
	STA $27			; A913	$85 $27		target + 4 ??
	CLC			; A915	$18
	LDA #$3A		; A916	$A9 $3A		monster battle stats (7E3A)
	ADC $04			; A918	$65 $04
	STA $A1			; A91A	$85 $A1
	LDA #$7E		; A91C	$A9 $7E
	ADC $05			; A91E	$65 $05
	STA $A2			; A920	$85 $A2
L32922:
	JSR Get_enemy_status1	; A922	$20 $76 $AF
	AND #$C0		; A925	$29 $C0		dead / stone
	BEQ L32936		; A927	$F0 $0D
	LDA $A6			; A929	$A5 $A6
	BEQ L32933		; A92B	$F0 $06
	JSR $AC93		; A92D	$20 $93 $AC	do nothing this round
	JMP $A98C		; A930	$4C $8C $A9
L32933:
	JSR $ACCF		; A933	$20 $CF $AC	show "not effective" message
L32936:
	LDY #$2A		; A936	$A0 $2A
	LDA ($9F),Y		; A938	$B1 $9F		battle command
	BNE L32946		; A93A	$D0 $0A		branch if not fight
	LDA #$80		; A93C	$A9 $80
	STA $28			; A93E	$85 $28
	JSR $AF85		; A940	$20 $85 $AF	do fight action - status / damage calc ??
	JMP $A98C		; A943	$4C $8C $A9
L32946:
	CMP #$FF		; A946	$C9 $FF
	BEQ L3298C		; A948	$F0 $42		branch if no command
	LDA #$00		; A94A	$A9 $00
	STA $28 		; A94C	$85 $28
	JSR $B3C6		; A94E	$20 $C6 $B3	do magic/item action
	LDA $2B			; A951	$A5 $2B
	BNE L32989		; A953	$D0 $34
	LDX $9E			; A955	$A6 $9E
	LDA $7FCE,X		; A957	$BD $CE $7F
	BNE L3297C		; A95A	$D0 $20
	SEC			; A95C	$38
	LDY #$0C		; A95D	$A0 $0C
	LDA ($9F),Y		; A95F	$B1 $9F		attacker's current mp
	LDY #$25		; A961	$A0 $25
	SBC ($9F),Y		; A963	$F1 $9F		sutract spell level
	LDY #$0C		; A965	$A0 $0C
	STA ($9F),Y		; A967	$91 $9F
	INY			; A969	$C8
	LDA ($9F),Y		; A96A	$B1 $9F		subtract from high byte
	SBC #$00		; A96C	$E9 $00
	STA ($9F),Y		; A96E	$91 $9F
	BCS L32989		; A970	$B0 $17
	DEY			; A972	$88
	LDA #$00		; A973	$A9 $00		min zero
	STA ($9F),Y		; A975	$91 $9F
	INY			; A977	$C8
	STA ($9F),Y		; A978	$91 $9F
	BEQ L32989		; A97A	$F0 $0D
L3297C:
	LDA $7FD6,X		; A97C	$BD $D6 $7F
	BEQ L32989		; A97F	$F0 $08
	CLC			; A981	$18
	ADC #$1B		; A982	$69 $1B
	TAY			; A984	$A8
	LDA #$00		; A985	$A9 $00
	STA ($A3),Y		; A987	$91 $A3
L32989:
	JMP $A98C		; A989	$4C $8C $A9
L3298C:
	LDA #$01		; A98C	$A9 $01		attack complete
	STA $AC			; A98E	$85 $AC
L32990:
	LDA $AC			; A990	$A5 $AC
	BNE L32990		; A992	$D0 $FC		LOOP Wait NMI IRQ
	JSR Set_IRQ_JMP		; A994	$20 $2A $FA	Wait NMI
	JSR Wait_NMI_end	; A997	$20 $46 $FD
	LDA #$00		; A99A	$A9 $00		top left window
	STA $4F			; A99C	$85 $4F
	STA $7CCE		; A99E	$8D $CE $7C
	LDA cur_turn_id		; A9A1	$A5 $E1
	CMP #$FF		; A9A3	$C9 $FF
	BNE L329AA		; A9A5	$D0 $03
	JMP $AB93		; A9A7	$4C $93 $AB
L329AA:
	STA $55			; A9AA	$85 $55
	LDA #$08		; A9AC	$A9 $08
	STA $45			; A9AE	$85 $45
	JSR $AC4E		; A9B0	$20 $4E $AC	text process (src name??) ??
	INC $4F			; A9B3	$E6 $4F
	LDA $E3			; A9B5	$A5 $E3
	CMP #$08		; A9B7	$C9 $08
	BNE L329BF		; A9B9	$D0 $04
	LDA #$FF		; A9BB	$A9 $FF
	BNE L329CA		; A9BD	$D0 $0B
L329BF:
	STA $55			; A9BF	$85 $55
	LDA #$08		; A9C1	$A9 $08
	STA $45			; A9C3	$85 $45
	JSR $AC4E		; A9C5	$20 $4E $AC	text process (target name??) ??
	LDA #$01		; A9C8	$A9 $01		middle left window
L329CA:
	STA $7CCF		; A9CA	$8D $CF $7C
	INC $4F			; A9CD	$E6 $4F
	LDY #$2A		; A9CF	$A0 $2A
	LDA ($9F),Y		; A9D1	$B1 $9F		battle command
	CMP #$FE		; A9D3	$C9 $FE
	BEQ L329E6		; A9D5	$F0 $0F
	LDY #$09		; A9D7	$A0 $09
	LDA ($9F),Y		; A9D9	$B1 $9F		status 2
	AND #$48		; A9DB	$29 $48
	BNE L329E6		; A9DD	$D0 $07		branch if paralyzed or asleep
	JSR $FACC		; A9DF	$20 $CC $FA	attack animation - Long loop
	LDA #$01		; A9E2	$A9 $01
	STA $2B			; A9E4	$85 $2B
L329E6:
	LDA $E4			; A9E6	$A5 $E4
	BNE L329EE		; A9E8	$D0 $04
	LDX #$FF		; A9EA	$A2 $FF
	BNE L32A2D		; A9EC	$D0 $3F
L329EE:
	CMP #$64		; A9EE	$C9 $64
	BCC L32A04		; A9F0	$90 $12		branch of not a spell
	SEC			; A9F2	$38
	SBC #$64		; A9F3	$E9 $64
	STA $55			; A9F5	$85 $55
	LDA #$07		; A9F7	$A9 $07
	STA $45			; A9F9	$85 $45
	STA $44			; A9FB	$85 $44
	JSR $ACF3		; A9FD	$20 $F3 $AC	show spell name
	LDX #$02		; AA00	$A2 $02		top right window
	BNE L32A2D		; AA02	$D0 $29
L32A04:
	STA $62			; AA04	$85 $62
	LDA #$00		; AA06	$A9 $00
	STA $63			; AA08	$85 $63
	JSR $9749		; AA0A	$20 $49 $97	convert hex to decimal
	LDX #$00		; AA0D	$A2 $00
	LDA $67			; AA0F	$A5 $67
	STA $7D47,X		; AA11	$9D $47 $7D	text buffer
	INX			; AA14	$E8
	LDA $68			; AA15	$A5 $68
	STA $7D47,X		; AA17	$9D $47 $7D	text buffer
	LDA #$07		; AA1A	$A9 $07
	STA $45			; AA1C	$85 $45
	STA $44			; AA1E	$85 $44
	LDA #$02		; AA20	$A9 $02
	STA $AA			; AA22	$85 $AA
	LDA #$0B		; AA24	$A9 $0B		$0B: "xHit"
	STA $55			; AA26	$85 $55
	JSR $ACDD		; AA28	$20 $DD $AC	message text process (hit count/miss/dmg)
	LDX #$02		; AA2B	$A2 $02		top right window
L32A2D:
	STX $7CD0		; AA2D	$8E $D0 $7C
	INC $4F			; AA30	$E6 $4F
	LDA $AE			; AA32	$A5 $AE
	STA $62			; AA34	$85 $62
	LDA $AF			; AA36	$A5 $AF
	BPL L32A3E		; AA38	$10 $04
	LDA #$FF		; AA3A	$A9 $FF
	BNE L32AA1		; AA3C	$D0 $63
L32A3E:
	STA $63			; AA3E	$85 $63
	LDA $E4			; AA40	$A5 $E4
	BNE L32A59		; AA42	$D0 $15
	LDA #$07		; AA44	$A9 $07
	STA $45			; AA46	$85 $45
	STA $44			; AA48	$85 $44
	LDA #$00		; AA4A	$A9 $00
	STA $AA			; AA4C	$85 $AA
	LDA #$0E		; AA4E	$A9 $0E		$0E: "Miss"
	STA $55			; AA50	$85 $55
	JSR $ACDD		; AA52	$20 $DD $AC	show hit/miss/dmg
	LDA #$03		; AA55	$A9 $03
	BNE L32AA1		; AA57	$D0 $48
L32A59:
	JSR $9749		; AA59	$20 $49 $97	convert hex to decimal
	LDX #$00		; AA5C	$A2 $00
	LDA $65			; AA5E	$A5 $65
	CMP #$FF		; AA60	$C9 $FF
	BEQ L32A68		; AA62	$F0 $04
	STA $7D47,X		; AA64	$9D $47 $7D
	INX			; AA67	$E8
L32A68:
	LDA $66			; AA68	$A5 $66
	STA $7D47,X		; AA6A	$9D $47 $7D	text buffer
	INX			; AA6D	$E8
	LDA $67			; AA6E	$A5 $67
	STA $7D47,X		; AA70	$9D $47 $7D	text buffer
	INX			; AA73	$E8
	LDA $68			; AA74	$A5 $68
	STA $7D47,X		; AA76	$9D $47 $7D	text buffer
	LDA #$07		; AA79	$A9 $07
	STA $45			; AA7B	$85 $45
	STA $44			; AA7D	$85 $44
	LDA $65			; AA7F	$A5 $65
	CMP #$FF		; AA81	$C9 $FF
	BEQ L32A94		; AA83	$F0 $0F
	INX			; AA85	$E8
	LDA #$00		; AA86	$A9 $00
	STA $7D47,X		; AA88	$9D $47 $7D	text buffer
	STA $55			; AA8B	$85 $55
	JSR $ACDD		; AA8D	$20 $DD $AC	show hit/miss/dmg
	LDA #$03		; AA90	$A9 $03
	BNE L32AA1		; AA92	$D0 $0D
L32A94:
	LDA #$03		; AA94	$A9 $03
	STA $AA			; AA96	$85 $AA
	LDA #$0C		; AA98	$A9 $0C		$0C: " DMG"
	STA $55			; AA9A	$85 $55
	JSR $ACDD		; AA9C	$20 $DD $AC	message text process (hit/miss/dmg)
	LDA #$03		; AA9F	$A9 $03		middle right window
L32AA1:
	STA $7CD1		; AAA1	$8D $D1 $7C
	JSR Wait_NMI_end	; AAA4	$20 $46 $FD
	JSR Get_player_status1	; AAA7	$20 $71 $AF	get attacker status 1
	AND #$C0		; AAAA	$29 $C0
	BEQ L32AC1		; AAAC	$F0 $13
	LDA $7FDE		; AAAE	$AD $DE $7F
	BNE L32B07		; AAB1	$D0 $54
	LDY #$09		; AAB3	$A0 $09
	LDA ($9F),Y		; AAB5	$B1 $9F		attacker's status 2
	AND #$80		; AAB7	$29 $80
	BEQ L32B0D		; AAB9	$F0 $52		branch if not confused
	LDA ($9F),Y		; AABB	$B1 $9F		main hand hit mult ?? - enemy ??
	AND #$48		; AABD	$29 $48
	BNE L32B0D		; AABF	$D0 $4C		branch if not paralyzed or asleep
L32AC1:
	LDY #$2A		; AAC1	$A0 $2A
	LDA ($9F),Y		; AAC3	$B1 $9F		battle command
	CMP #$FF		; AAC5	$C9 $FF
	BEQ L32B0D		; AAC7	$F0 $44
	CMP #$FE		; AAC9	$C9 $FE
	BEQ L32B0D		; AACB	$F0 $40
	LDY #$12		; AACD	$A0 $12
	LDA ($A1),Y		; AACF	$B1 $A1		target's intellect
	BNE L32B07		; AAD1	$D0 $34
	JSR Get_enemy_status1	; AAD3	$20 $76 $AF
	AND #$E0		; AAD6	$29 $E0
	BNE L32AE1		; AAD8	$D0 $07		branch if dead, stone, or toad
	INY			; AADA	$C8
	LDA ($A1),Y		; AADB	$B1 $A1
	AND #$20		; AADD	$29 $20
	BEQ L32B0D		; AADF	$F0 $2C		branch if not mini
L32AE1:
	LDY #$2B		; AAE1	$A0 $2B
	LDA ($9F),Y		; AAE3	$B1 $9F		target ?? m???aiii - m,a,i
	AND #$7F		; AAE5	$29 $7F
	TAX			; AAE7	$AA
	LDA $7B62,X		; AAE8	$BD $62 $7B	monster id in each slot
	CMP #$FF		; AAEB	$C9 $FF
	BEQ L32B0D		; AAED	$F0 $1E
	LDY #$08		; AAEF	$A0 $08
	LDA #$80		; AAF1	$A9 $80
	STA ($A1),Y		; AAF3	$91 $A1		abcdefgh status 1
	LDA #$FF		; AAF5	$A9 $FF
	STA $7B62,X		; AAF7	$9D $62 $7B	monster id in each slot
	LDY #$01		; AAFA	$A0 $01
	STY $A5			; AAFC	$84 $A5
	JSR $FAC8		; AAFE	$20 $C8 $FA	monster eliminate animation
	DEC $7B4D		; AB01	$CE $4D $7B	number of monsters remaining - decrement
	JMP $AB0D		; AB04	$4C $0D $AB
L32B07:
	JSR $AEE0		; AB07	$20 $E0 $AE
	JSR $FAD4		; AB0A	$20 $D4 $FA	load character graphics
L32B0D:
	LDX #$00		; AB0D	$A2 $00
	LDA msg_que,X		; AB0F	$BD $BA $7F
	CMP #$FF		; AB12	$C9 $FF
	BNE L32B1B		; AB14	$D0 $05
	LDY $AB			; AB16	$A4 $AB
	JSR $949B		; AB18	$20 $9B $94
L32B1B:
	LDX $AD			; AB1B	$A6 $AD
	BEQ L32B21		; AB1D	$F0 $02
L32B1F:
	DEC $AD			; AB1F	$C6 $AD
L32B21:
	LDX $AD			; AB21	$A6 $AD
	LDA msg_que,X		; AB23	$BD $BA $7F
	CMP #$FF		; AB26	$C9 $FF
	BEQ L32B6B		; AB28	$F0 $41		branch if no battle message
	JSR $BECE		; AB2A	$20 $CE $BE	load next battle message
	LDA #$04		; AB2D	$A9 $04		bottom window
	STA $4F			; AB2F	$85 $4F
	JSR $AC2D		; AB31	$20 $2D $AC	message text process (eliminate/fell) ??
	JSR Wait_NMI_end	; AB34	$20 $46 $FD
	LDA $7CB6		; AB37	$AD $B6 $7C
	BEQ L32B5A		; AB3A	$F0 $1E
	DEC $7CB6		; AB3C	$CE $B6 $7C
	LDA $7CCD		; AB3F	$AD $CD $7C
	TAX			; AB42	$AA
	LDA #$FF		; AB43	$A9 $FF
	STA $7B62,X		; AB45	$9D $62 $7B
	LDA $7B6A,X		; AB48	$BD $6A $7B
	ORA #$80		; AB4B	$09 $80
	STA $7B6A,X		; AB4D	$9D $6A $7B
	LDA #$02		; AB50	$A9 $02
	STA $A5			; AB52	$85 $A5
	JSR $FAC8		; AB54	$20 $C8 $FA
	DEC $7B4D		; AB57	$CE $4D $7B	decrement number of monsters remaining
L32B5A:
	JSR Wait_MENU_snd	; AB5A	$20 $5B $FD
	LDY $AB			; AB5D	$A4 $AB
	JSR $949B		; AB5F	$20 $9B $94
	LDA #$04		; AB62	$A9 $04		bottom window
	STA $54			; AB64	$85 $54
	JSR $AC44		; AB66	$20 $44 $AC	remove text(end of text message box) ??
	DEC $4F			; AB69	$C6 $4F
L32B6B:
	LDA $AD			; AB6B	$A5 $AD
	BNE L32B1F		; AB6D	$D0 $B0
	LDX #$00		; AB6F	$A2 $00
	LDA msg_que,X		; AB71	$BD $BA $7F
	CMP #$FF		; AB74	$C9 $FF
	BNE L32B7D		; AB76	$D0 $05
	LDY $AB			; AB78	$A4 $AB
	JSR $949B		; AB7A	$20 $9B $94
L32B7D:
	LDX $4F			; AB7D	$A6 $4F
L32B7F:
	LDA $7CCE,X		; AB7F	$BD $CE $7C
	STA $54			; AB82	$85 $54
	BMI L32B8D		; AB84	$30 $07
	TXA			; AB86	$8A
	PHA			; AB87	$48
	JSR $AC44		; AB88	$20 $44 $AC	remove text ??
	PLA			; AB8B	$68
	TAX			; AB8C	$AA
L32B8D:
	DEX			; AB8D	$CA
	BPL L32B7F		; AB8E	$10 $EF		loop - remove text
	JSR Wait_NMI_end	; AB90	$20 $46 $FD
	LDA turn_order_cnt	; AB93	$AD $BB $7C	counter for turn order
	CMP #$0B		; AB96	$C9 $0B
	BEQ L32BA3		; AB98	$F0 $09
	LDA cur_turn_id		; AB9A	$A5 $E1
	CMP #$FF		; AB9C	$C9 $FF
	BNE L32BA3		; AB9E	$D0 $03
	JMP $ABEF		; ABA0	$4C $EF $AB
; End of
L32BA3:
	LDA $7CB7		; ABA3	$AD $B7 $7C	monster ran away
	BEQ L32BB7		; ABA6	$F0 $0F		branch if didn't run away
	JSR $ADEA		; ABA8	$20 $EA $AD
	JSR $FD46		; ABAB	$20 $46 $FD
	JSR $AD2F		; ABAE	$20 $2F $AD
	JSR $9A63		; ABB1	$20 $63 $9A
	JMP $FAE8		; ABB4	$4C $E8 $FA	characters run away
L32BB7:
	JSR Wait_MENU_snd	; ABB7	$20 $5B $FD
	JSR $AF30		; ABBA	$20 $30 $AF	????  not analyzed
	LDA $7B4D		; ABBD	$AD $4D $7B	number of monsters remaining ??
	BNE L32BEF		; ABC0	$D0 $2D		branch if any monsters remain
	LDX #$00		; ABC2	$A2 $00
	LDA #$18		; ABC4	$A9 $18		$18: "You won!"
	STA msg_que,X		; ABC6	$9D $BA $7F
	JSR $BECE		; ABC9	$20 $CE $BE	load next battle message
	LDA #$04		; ABCC	$A9 $04		bottom window
	STA $4F			; ABCE	$85 $4F
	JSR Wait_MENU_snd	; ABD0	$20 $5B $FD
	JSR $AC2D		; ABD3	$20 $2D $AC
	JSR Wait_NMI_end	; ABD6	$20 $46 $FD
	JSR $ADEA		; ABD9	$20 $EA $AD
	JSR Wait_NMI_end	; ABDC	$20 $46 $FD
	JSR $FAD8		; ABDF	$20 $D8 $FA	characters run off-screen
	LDA #$04		; ABE2	$A9 $04		bottom window
	STA $54			; ABE4	$85 $54
	JSR $AC44		; ABE6	$20 $44 $AC
	JSR $AD2F		; ABE9	$20 $2F $AD	update character properties in sram
	JMP $FB3C		; ABEC	$4C $3C $FB	battle victory
L32BEF:
	LDA $A6			; ABEF	$A5 $A6
	BEQ L32C03		; ABF1	$F0 $10
	DEC $A6			; ABF3	$C6 $A6
	BEQ L32C03		; ABF5	$F0 $0C
	LDY #$2B		; ABF7	$A0 $2B
	LDA ($9F),Y		; ABF9	$B1 $9F		target
	TAX			; ABFB	$AA
	INX			; ABFC	$E8
	TXA			; ABFD	$8A
	STA ($9F),Y		; ABFE	$91 $9F
	JMP $A74F		; AC00	$4C $4F $A7
L32C03:
	INC turn_order_cnt	; AC03	$EE $BB $7C	counter for turn order
	LDA turn_order_cnt	; AC06	$AD $BB $7C	counter for turn order
	CMP #$0C		; AC09	$C9 $0C
	BEQ L32C10		; AC0B	$F0 $03
	JMP $A746		; AC0D	$4C $46 $A7	LOOP for next TURN ORDER ==========
L32C10:
	JSR $9A63		; AC10	$20 $63 $9A
	JSR $FAC4		; AC13	$20 $C4 $FA
	LDA #$00		; AC16	$A9 $00
	STA $7B4A		; AC18	$8D $4A $7B
	JSR Wait_MENU_snd	; AC1B	$20 $5B $FD
	JSR $AE28		; AC1E	$20 $28 $AE
	JSR $ADEA		; AC21	$20 $EA $AD
	JSR Wait_MENU_snd	; AC24	$20 $5B $FD
	JSR $912A		; AC27	$20 $2A $91
	JMP $9A5D		; AC2A	$4C $5D $9A
; End of

; Name	:
; Marks	:
	JSR Wait_NMI_end	; AC2D	$20 $46 $FD
	JSR Init_gfx_buf	; AC30	$20 $90 $94
	LDA #$00		; AC33	$A9 $00
	STA $6F			; AC35	$85 $6F
	JSR $95E7		; AC37	$20 $E7 $95	copy text to buffer - text message ??
	JSR Wait_MENU_snd	; AC3A	$20 $5B $FD
	LDA $4F			; AC3D	$A5 $4F
	STA $64			; AC3F	$85 $64
	JMP $FB42		; AC41	$4C $42 $FB	open message window
; End of

; Name	:
; Marks	:
	JSR Wait_NMI_end	; AC44	$20 $46 $FD
	LDA $54			; AC47	$A5 $54
	STA $64			; AC49	$85 $64
	JMP $FB46		; AC4B	$4C $46 $FB	close message window
;End of

; Name	:
; Marks	: display attacker/target name
	LDA $55			; AC4E	$A5 $55
	CMP #$80		; AC50	$C9 $80
	BCS L32C7B		; AC52	$B0 $27		branch if a monster
	CMP #$7F		; AC54	$C9 $7F
	BEQ L32C7B		; AC56	$F0 $23
	LDA $9E			; AC58	$A5 $9E
	PHA			; AC5A	$48
	LDA $55			; AC5B	$A5 $55
	STA $9E			; AC5D	$85 $9E
	JSR $96E1		; AC5F	$20 $E1 $96	update character/monster pointers
	PLA			; AC62	$68
	STA $9E			; AC63	$85 $9E
	LDY #$02		; AC65	$A0 $02
	LDX #$00		; AC67	$A2 $00
L32C69:
	LDA ($7A),Y		; AC69	$B1 $7A
	STA $7D47,X		; AC6B	$9D $47 $7D	text buffer
	INY			; AC6E	$C8
	INX			; AC6F	$E8
	CPX #$06		; AC70	$E0 $06
	BNE L32C69		; AC72	$D0 $F5
	LDA #$00		; AC74	$A9 $00
	STA $7D47,X		; AC76	$9D $47 $7D
	BEQ L32C8A		; AC79	$F0 $0F
L32C7B:
	AND #$7F		; AC7B	$29 $7F
	STA $64			; AC7D	$85 $64
	LDA #$AC		; AC7F	$A9 $AC		monster names (05/AC44)
	STA $63			; AC81	$85 $63
	LDA #$44		; AC83	$A9 $44
	STA $62			; AC85	$85 $62
	JSR $9AAB		; AC87	$20 $AB $9A	load text (bank 05)
L32C8A:
	LDA #$08		; AC8A	$A9 $08
	STA $44			; AC8C	$85 $44
	STA $45			; AC8E	$85 $45
	JMP $AC2D		; AC90	$4C $2D $AC
; End of

; Name	:
; Marks	: do nothing this round
	LDX #$00		; AC93	$A2 $00
	STX $AE			; AC95	$86 $AE
	STX $E4			; AC97	$86 $E4
	DEX			; AC99	$CA
	STX cur_turn_id		; AC9A	$86 $E1
	STX msg_que		; AC9C	$8E $BA $7F
	STX $AF			; AC9F	$86 $AF
	RTS			; ACA1	$60
; End of

; Name	:
; Marks	: show "nothing happend" message
	LDX #$00		; ACA2	$A2 $00
	STA $AE			; ACA4	$86 $AE
	STA $E4			; ACA6	$86 $E4
	DEX			; ACA8	$CA
	STX $AF			; ACA9	$86 $AF
	LDX #$13		; ACAB	$A2 $13		$13: "Nothing happended"
	STX $7FBA		; ACAD	$8E $BA $7F
	RTS			; ACB0	$60
; End of

; Name	:
; Marks	: show "escaped" message
	LDX #$00		; ACB1	$A2 $00
	STX $AE			; ACB3	$86 $AE
	STX $E4			; ACB5	$86 $E4
	DEX			; ACB7	$CA
	STX $AF			; ACB8	$86 $AF
	LDX #$0F		; ACBA	$A2 $0F		$0F: "Escaped"
	STX $7FBA		; ACBC	$8E $BA $7F
	RTS			; ACBF	$60
; End of

; Name	:
; Marks	: show "can't escape" message
	LDX #$00		; ACC0	$A2 $00
	STX $AE			; ACC2	$86 $AE
	STX $E4			; ACC4	$86 $E4
	DEX			; ACC6	$CA
	STX $AF			; ACC7	$86 $AF
	LDX #$10		; ACC9	$A2 $10		$10: "Can't escape!"
	STX $7FBA		; ACCB	$8E $BA $7F
	RTS			; ACCE	$60
; End of

; Name	:
; Marks	: show "not effective" message
	LDX #$00		; ACCF	$A2 $00
	STX $AE			; ACD1	$86 $AE
	LDX #$80		; ACD3	$A2 $80
	STX $AF			; ACD5	$86 $AF
	LDX #$14		; ACD7	$A2 $14		$14: "Not effective."
	STX $7FBA		; ACD9	$8E $BA $7F
	RTS			; ACDC	$60
; End of

; Name	:
; Marks	: show hit/miss/dmg
	LDA $55			; ACDD	$A5 $55		cursor 1 sprite y positin ??
	BEQ L32CF0		; ACDF	$F0 $0F
	STA $64			; ACE1	$85 $64		menu target h-scroll position ??
	LDA #$B2		; ACE3	$A9 $B2		05/B295
	STA $63			; ACE5	$85 $63
	LDA #$95		; ACE7	$A9 $95
	STA $62			; ACE9	$85 $62
	LDX #$05		; ACEB	$A2 $05
	JSR $FD8C		; ACED	$20 $8C $FD	bank 05 - load text
L32CF0:
	JMP $AC2D		; ACF0	$4C $2D $AC
; End of

; Name	:
; Marks	: show spell name
	LDA $55			; ACF3	$A5 $55
	STA $64			; ACF5	$85 $64
	LDA #$B0		; ACF7	$A9 $B0		attack names (05/B0BB)
	STA $63			; ACF9	$85 $63
	LDA #$BB		; ACFB	$A9 $BB
	STA $62			; ACFD	$85 $62
	JSR $9AAB		; ACFF	$20 $AB $9A	load text (bank 05)
	LDX $7CBF		; AD02	$AE $BF $7C
	LDA #$FF		; AD05	$A9 $FF
	STA $7D47,X		; AD07	$9D $47 $7D
	LDY #$25		; AD0A	$A0 $25
	LDA ($9F),Y		; AD0C	$B1 $9F		spell level
	STA $62			; AD0E	$85 $62
	LDA #$00		; AD10	$A9 $00
	STA $63			; AD12	$85 $63
	JSR $9749		; AD14	$20 $49 $97	convert hex to decimal
	LDX $7CBF		; AD17	$AE $BF $7C
	INX			; AD1A	$E8
	LDA $67			; AD1B	$A5 $67
	STA $7D47,X		; AD1D	$9D $47 $7D
	INX			; AD20	$E8
	LDA $68			; AD21	$A5 $68
	STA $7D47,X		; AD23	$9D $47 $7D
	INX			; AD26	$E8
	LDA #$00		; AD27	$A9 $00
	STA $7D47,X		; AD20	$9D $47 $7D
	JMP $AC2D		; AD23	$4C $2D $AC
; End of

; Name	:
; Marks	: update character properties in sram
	LDA #$00		; AD2F	$A9 $00
	STA $9E			; AD31	$85 $9E
	JSR $96E1		; AD33	$20 $E1 $96	update character/monster pointers
	LDA $9E			; AD36	$A5 $9E
	ASL A			; AD38	$0A
	TAX			; AD39	$AA
	SEC			; AD3A	$38
	LDY #$08		; AD3B	$A0 $08
	LDA ($7A),Y		; AD3D	$B1 $7A		calculate net hp loss
	LDY #$0A		; AD3F	$A0 $0A
	SBC ($80),Y		; AD41	$F1 $80
	STA $7D6A,X		; AD43	$9D $6A $7D
	LDY #$09		; AD46	$A0 $09
	LDA ($7A),Y		; AD48	$B1 $7A
	LDY #$0B		; AD4A	$A0 $0B
	SBC ($80),Y		; AD4C	$F1 $80
	STA $7D6B,X		; AD4E	$9D $6B $7D
	BCS L32D5B		; AD51	$B0 $08
	LDA #$00		; AD53	$A9 $00		minimum 0
	STA $7D6A,X		; AD55	$9D $6A $7D
	STA $7D6B,X		; AD58	$9D $6B $7D
L32D5B:
	SEC			; AD5B	$38
	LDY #$0C		; AD5C	$A0 $0C
	LDA ($7A),Y		; AD5E	$B1 $7A		calculate net mp loss
	LDY #$0C		; AD60	$A0 $0C
	SBC ($80),Y		; AD62	$F1 $80
	STA $7D72,X		; AD64	$9D $72 $7D
	LDY #$0D		; AD67	$A0 $0D
	LDA ($7A),Y		; AD69	$B1 $7A
	LDY #$0D		; AD6B	$A0 $0D
	SBC ($80),Y		; AD6D	$F1 $80
	STA $7D73,X		; AD6F	$9D $73 $7D
	BCS L32D7C		; AD72	$B0 $08
	LDA #$00		; AD74	$A9 $00		minimum 0
	STA $7D72,X		; AD76	$9D $72 $7D
	STA $7D73,X		; AD78	$9D $73 $7D
L32D7C:
	LDA $7B48		; AD7B	$AD $48 $7B
	CMP #$7F		; AD7F	$C9 $7F
	BEQ L32DAE		; AD81	$F0 $2B		branch if final battle ???
	JSR $AF6C		; AD83	$20 $6C $AF	get status 1
	PHA			; AD86	$48
	LDY #$01		; AD87	$A0 $01
	STA ($7A),Y		; AD89	$91 $7A		update status 1 in sram
	PLA			; AD8B	$68
	AND #$C0		; AD8C	$29 $C0
	BEQ L32D98		; AD8E	$F0 $08		branch if not dead
	LDY #$35		; AD90	$A0 $35
	LDA ($7E),Y		; AD92	$B1 $7E		move to back row
	ORA #$01		; AD94	$09 $01
	STA ($7E),Y		; AD96	$91 $7E
L32D98:
	LDY #$0A		; AD98	$A0 $0A		current hp
	STY $44			; AD9A	$84 $44
	LDY #$09		; AD9C	$A0 $09
	STY $45			; AD9E	$84 $45
	JSR $ADD9		; ADA0	$20 $D9 $AD	update hp/mp in sram
	LDY #$0C		; ADA3	$A0 $0C		current mp
	STY $44			; ADA5	$84 $44
	LDY #$0D		; ADA7	$A0 $0D
	STY $45			; ADA9	$84 $45
	JSR $ADD9		; ADAB	$20 $D9 $AD	update hp/mp in sram
L32DAE:
	LDY #$1C		; ADAE	$A0 $1C
	LDA ($7A),Y		; ADB0	$B1 $7A		right hand item
	CMP #$30		; ADB2	$C9 $30
	BNE L32DBA		; ADB4	$D0 $04		branch if not unarmed
	LDA #$00		; ADB6	$A9 $00
	STA ($7A),Y		; ADB8	$91 $7A
L32DBA:
	INY			; ADBA	$C8
	LDA ($7A),Y		; ADBB	$B1 $7A		left hand item
	CMP #$30		; ADBD	$C9 $30
	BNE L32DC5		; ADBF	$D0 $04		branch if not unarmed
	LDA #$00		; ADC1	$A9 $00
	STA ($7A),Y		; ADC3	$91 $7A
L32DC5:
	LDY #$35		; ADC5	$A0 $35
	LDA ($7E),Y		; ADC7	$B1 $7E		invert character row
	EOR #$01		; ADC9	$49 $01
	STA ($7E),Y		; ADCB	$91 $7E
	INC $9E			; ADCD	$E6 $9E		next character
	LDA $9E			; ADCF	$A5 $9E
	CMP #$04		; ADD1	$C9 $04
	BEQ L32DD8		; ADD3	$F0 $03
	JMP $AD33		; ADD5	$4C $33 $AD
L32DD8:
	RTS			; ADD8	$60
; End of

; Name	:
; Marks	: update hp/mp in sram
	LDY $44			; ADD9	$A4 $44
	LDA ($80),Y		; ADDB	$B1 $80
	PHA			; ADDD	$48
	INY			; ADDE	$C8
	LDA ($80),Y		; ADE1	$B1 $80
	LDY $45			; ADE3	$A4 $45
	STA ($7A),Y		; ADE5	$91 $7A
	DEY			; ADE5	$88 
	PLA			; ADE6	$68
	STA ($7A),Y		; ADE7	$91 $7A
	RTS			; ADE9	$60
; End of

; Name	:
; Marks	:
	LDX #$00		; ADEA	$A2 $00
	STX $9E			; ADEC	$86 $9E
L32DEE:
	JSR $96E1		; ADEE	$20 $E1 $96	update character/monster pointers
	LDY #$35		; ADF1	$A0 $35
	LDA ($7E),Y		; ADF3	$B1 $7E
	LSR A			; ADF5	$4A
	BCS L32DFF		; ADF6	$B0 $07
	JSR $AF6C		; ADF8	$20 $6C $AF	get status 1
	AND #$C0		; ADFB	$29 $C0
	BEQ L32E25		; ADFD	$F0 $26
L32DFF:
	INC $9E			; ADFF	$E6 $9E
	LDA $9E			; AE01	$A5 $9E
	CMP #$04		; AE03	$C9 $04
	BNE L32DEE		; AE05	$D0 $E7
	LDX #$00		; AE07	$A2 $00
	STX $9E			; AE09	$86 $9E
L32E0B:
	JSR $96E1		; AE0B	$20 $E1 $96	update character/monster pointers
	JSR $AF6C		; AE0E	$20 $6C $AF	get status 1
	AND #$C0		; AE11	$29 $C0
	BNE L32E1D		; AE13	$D0 $08
	LDY #$35		; AE15	$A0 $35
	LDA ($7E),Y		; AE17	$B1 $7E
	AND #$FE		; AE19	$29 $FE
	STA ($7E),Y		; AE1B	$91 $7E
L32E1D:
	INC $9E			; AE1D	$E6 $9E
	LDA $9E			; AE1F	$A5 $9E
	CMP #$04		; AE21	$C9 $04
	BNE L32E0B		; AE23	$D0 $E6
L32E25:
	JMP Wait_MENU_snd	; AE25	$4C $5B $FD
; End of

; Name	:
; Marks	:
	LDA #$00		; AE28	$A9 $00
	STA $9E			; AE2A	$85 $9E
	JSR Wait_NMI_end	; AE2C	$20 $46 $FD
	JSR $96E1		; AE2F	$20 $E1 $96	get status 2
	JSR $AF80		; AE32	$20 $80 $AF
	LDY #$2D		; AE35	$A0 $2D
	STA ($80),Y		; AE37	$91 $80
	LDA #$00		; AE39	$A9 $00
	STA $44			; AE3B	$85 $44
	JSR $AF80		; AE3D	$20 $80 $AF	get status 2
	STA $45			; AE40	$85 $45
	STA $47			; AE42	$85 $47
L32E44:
	LSR $47			; AE44	$46 $47
	BCC L32E67		; AE46	$90 $1F
	LDX #$01		; AE48	$A2 $01
	LDA #$64		; AE4A	$A9 $64
	JSR $FD11		; AE4C	$20 $11 $FD	random (X..A)
;AE4F
	STA $46			; AE4F	$85 $46
	LDA $44			; AE51	$A5 $44
	TAX			; AE53	$AA
	LDA $8E4B,X		; AE54	$BD $4B $8E
	SEC			; AE57	$38
	SBC $46			; AE58	$E5 $46
	BCC L32E67		; AE5A	$90 $0B
	LDA $45			; AE5C	$A5 $45
	JSR $900E		; AE5E	$20 $0E $90	clear bit
	LDY #$09		; AE61	$A0 $09
	STA ($80),Y		; AE63	$91 $80
	STA $45			; AE65	$85 $45
L32E67:
	INC $44			; AE67	$E6 $44
	LDA $44			; AE69	$A5 $44
	CMP #$08		; AE6B	$C9 $08
	BNE L32E44		; AE6D	$D0 $D5
	JSR $AF80		; AE6F	$20 $80 $AF	get status 2
	AND #$04		; AE72	$29 $04
	BEQ L32E80		; AE74	$F0 $0A
	LDX #$00		; AE76	$A2 $00
	LDA #$02		; AE78	$A9 $02
	JSR $FD11		; AE7A	$20 $11 $FD	random (X..A)
	JSR $AEB0		; AE7D	$20 $B0 $AE
L32E80:
	JSR $AF6C		; AE80	$20 $6C $AF	get status 1
	AND #$04		; AE83	$29 $04
	BEQ L32E91		; AE85	$F0 $0A
	LDX #$02		; AE87	$A2 $02
	LDA #$04		; AE89	$A9 $04
	JSR $FD11		; AE8B	$20 $11 $FD	random (X..A)
	JSR $AEB0		; AE8E	$20 $B0 $AE
L32E91:
	LDA $9E			; AE91	$A5 $9E
	CMP #$04		; AE93	$C9 $04
	BCS L32E9F		; AE95	$B0 $08
	STA $27			; AE97	$85 $27
	JSR $9A63		; AE99	$20 $63 $9A
	JSR $FAD4		; AE9C	$20 $D4 $FA	load character graphics
L32E9F:
	JSR Wait_MENU_snd	; AE9F	$20 $5B $FD
	INC $9E			; AEA2	$E6 $9E
	LDA $9E			; AEA4	$A5 $9E
	CMP #$0C		; AEA6	$C9 $0C
	BEQ L32EAD		; AEA8	$F0 $03
	JMP $AE2C		; AEAA	$4C $2C $AE
L32EAD:
	JMP $AF30		; AEAD	$4C $30 $AF
; End of

; Name	:
; Marks	:
	STA $44			; AEB0	$85 $44
	SEC			; AEB2	$38
	LDY #$0A		; AEB3	$A0 $0A
	LDA ($80),Y		; AEB5	$B1 $80
	SBC $44			; AEB7	$E5 $44
	STA ($80),Y		; AEB9	$91 $80
	INY			; AEBB	$C8
	LDA ($80),Y		; AEBC	$B1 $80
	SBC #$00		; AEBE	$E9 $00
	STA ($80),Y		; AEC0	$91 $80
	BCC L32EC9		; AEC2	$90 $05
	DEY			; AEC4	$88
	ORA ($80),Y		; AEC5	$11 $80
	BNE L33EDF		; AEC7	$D0 $16
L32EC9:
	LDY #$0A		; AEC9	$A0 $0A
	LDA #$00		; AECB	$A9 $00
	STA ($80),Y		; AECD	$91 $80
	INY			; AECF	$C8
	STA ($80),Y		; AED0	$91 $80
	JSR $AF6C		; AED2	$20 $6C $AF	get status 1
;AED5
	LDY #$2C		; AED5	$A0 $2C
	STA ($80),Y		; AED7	$91 $80
	LDY #$08		; AED9	$A0 $08
	ORA #$80		; AEDB	$09 $80
	STA ($80),Y		; AEDD	$91 $80
L33EDF:
	RTS			; AEDF	$60
; End of

; Name	:
; Marks	:
	LDY #$0A		; AEE0	$A0 $0A
	LDA ($A1),Y		; AEE2	$B1 $A1
	STA $46			; AEE4	$85 $46
	INY			; AEE6	$C8
	LDA ($A1),Y		; AEE7	$B1 $A1
	STA $47			; AEE9	$85 $47
	ORA $46			; AEEB	$05 $46
	BEQ L32F2F		; AEED	$F0 $40
	LDY #$0E		; AEEF	$A0 $0E
	LDA ($A1),Y		; AEF1	$B1 $A1
	STA $48			; AEF3	$85 $48
	INY			; AEF5	$C8
	LDA ($A1),Y		; AEF6	$B1 $A1
	STA $49			; AEF8	$85 $49
	LSR $49			; AEFA	$46 $49
	ROR $48			; AEFC	$66 $48
	LSR $49			; AEFE	$46 $49
	ROR $48			; AF00	$66 $48
	SEC			; AF02	$38
	LDA $48			; AF03	$A5 $48
	SBC $46			; AF05	$E5 $46
	LDA $49			; AF07	$A5 $49
	SBC $47			; AF09	$E5 $47
	BCC L32F1C		; AF0B	$90 $0F
	JSR Get_enemy_status2	; AF0D	$20 $7B $AF
	LDY #$2D		; AF10	$A0 $2D
	STA ($A1),Y		; AF12	$91 $A1
	LDY #$09		; AF14	$A0 $09
	ORA #$02		; AF16	$09 $02
	STA ($A1),Y		; AF18	$91 $A1
	BNE L32F2F		; AF1A	$D0 $13
L32F1C:
	JSR Get_enemy_status2	; AF1C	$20 $7B $AF
	AND #$02		; AF1F	$29 $02
	BEQ L32F2F		; AF21	$F0 $0C
	LDA ($A1),Y		; AF23	$B1 $A1
	LDY #$2D		; AF25	$A0 $2D
	STA ($A1),Y		; AF27	$91 $A1
	LDY #$09		; AF29	$A0 $09
	AND #$FD		; AF2B	$29 $FD
	STA ($A1),Y		; AF2D	$91 $A1
L32F2F:
	RTS			; AF2F	$60
; End of

; Name	:
; Marks	:
	JSR $9A5D		; AF30	$20 $5D $9A
	JSR $912A		; AF33	$20 $2A $91
	JSR Wait_NMI_end	; AF36	$20 $46 $FD
	LDX #$00		; AF39	$A2 $00
L32F3B:
	STX $9E			; AF3B	$86 $9E
	JSR $96E1		; AF3D	$20 $E1 $96
	JSR $AF6C		; AF40	$20 $6C $AF
	AND #$E0		; AF43	$29 $E0
	BEQ L32F6B		; AF45	$F0 $24		branch if not dead stone or toad
	LDY #$2A		; AF47	$A0 $2A
	LDA #$FF		; AF49	$A9 $FF
	STA ($80),Y		; AF4B	$91 $80		reset battle command
	INX			; AF4D	$E8		next character
	CPX #$04		; AF4E	$E0 $04
	BNE L32F3B		; AF50	$D0 $E9
	LDX #$00		; AF52	$A2 $00
	LDA #$17		; AF54	$A9 $17		$17: " lost."
	STA msg_que,X		; AF56	$9D $BA $7F
	JSR $BECE		; AF59	$20 $CE $BE	load next battle message
;AF5C
	LDA #$04		; AF5C	$A9 $04
	STA $4F			; AF5E	$85 $4F
	JSR $AC2D		; AF60	$20 $2D $AC
	JSR $AD2F		; AF63	$20 $2F $AD	update character properties in sram
	PLA			; AF66	$68
	PLA			; AF67	$68
	JMP $FAEC		; AF68	$4C $EC $FA	battle defeat
L32F6B:
	RTS			; AF6B	$60

; Name	: Get_stat_status1
; SRC	: $80(ADDR) = character/monster battle stats (12 * 48bytes) ($7D7A-$7FB9)
; Marks	:
Get_stat_status1:
	LDY #$08		; AF6C	$A0 $08
	LDA ($80),Y		; AF6E	$B1 $80
	RTS			; AF70	$60
; End of Get_stat_status1

; Name	: Get_player_status1
; Marks	: $9F(ADDR) = player information address base xxxxx
;	  get attacker status 1
Get_player_status1:
	LDY #$08		; AF71	$A0 $08
	LDA ($9F),Y		; AF73	$B1 $9F
	RTS			; AF75	$60
; End of Get_player_status1

; Name	: Get_enemy_status1
; Marks	: $A1(ADDR) = enemy information address base xxxxx
;	  get target status 1
Get_enemy_status1:
	LDY #$08		; AF76	$A0 $08
	LDA ($A1),Y		; AF78	$B1 $A1
	RTS			; AF7A	$60
; End of Get_enemy_status1

; Name	: Get_enemy_status2
; Marks	: $A1(ADDR) = enemy information address base
Get_enemy_status2:
	LDY #$09		; AF7B	$A0 $09
	LDA ($A1),Y		; AF7D	$B1 $A1
	RTS			; AF7F	$60
; End of Get_enemy_status2

; Name	: Get_stat_status2
; Marks	:
Get_stat_status2:
	LDY #$09		; AF80	$A0 $09
	LDA ($80),Y		; AF82	$B1 $80
	RTS			; AF84	$60
; End of Get_stat_status2

; Name	:
; Marks	: do fight action - init ??
	LDX #$00		; AF85	$A2 $00
	STX $9C			; AF87	$86 $9C		clear damage
	STX $9D			; AF89	$86 $9D
	STX $9A			; AF8B	$86 $9A
	STX $24			; AF8D	$86 $24		clear crit flag
	LDX #$80		; AF8F	$A2 $80
	STX $9B			; AF91	$86 $9B
	JSR Get_enemy_status1	; AF93	$20 $76 $AF
	AND #$C0		; AF96	$29 $C0		dead(bit7)/stone(bit6)
	BNE L32F9D		; AF98	$D0 $03		branch if dead or stone
	JSR $AFBD		; AF9A	$20 $BD $AF	do fight effect
L32F9D:
	LDA $9A			; AF9D	$A5 $9A
	STA $AE			; AF9F	$85 $AE
	LDA $9B			; AFA1	$A5 $9B
	STA $AF			; AFA3	$85 $AF
	ORA $9A			; AFA5	$05 $9A
	BNE L32FAF		; AFA7	$D0 $06
	LDA $28			; AFA9	$A5 $28
	AND #$BF		; AFAB	$29 $BF
	STA $28			; AFAD	$85 $28
L32FAF:
	LDA $9C			; AFAF	$A5 $9C
	STA $E4			; AFB1	$85 $E4
	LDA $24			; AFB3	$A5 $24
	BEQ L32FBC		; AFB5	$F0 $05
	LDA #$0D		; AFB7	$A9 $0D		$0D: "Critical Hit!"
	JSR $BF92		; AFB9	$20 $92 $BF	add to battle message queue
L32FBC:
	RTS			; AFBC	$60
; End of

; Name	:
; Marks	: $9F(ADDR) = character battle stats address base
;	  $A1(ADDR) = monster battle stats address base
;	  do fight effect
	LDY #$18		; AFBD	$A0 $18
	LDA ($9F),Y		; AFBF	$B1 $9F		main hand hit mult
	LDY #$07		; AFC1	$A0 $07
	CLC			; AFC3	$18
	ADC ($9F),Y		; AFC4	$71 $9F		haste/slow modifier
	STA $46			; AFC6	$85 $46		hit + haste/slow
	LDA #$00		; AFC8	$A9 $00
	ADC #$00		; AFCA	$69 $00
	STA $47			; AFCC	$85 $47
	SEC			; AFCE	$38
	LDA $46			; AFCF	$A5 $46		hit + haste/slow
	SBC #$14		; AFD1	$E9 $14		subtract 20
	STA $46			; AFD3	$85 $46		hit + haste/slow
	LDA $47			; AFD5	$A5 $47
	SBC #$00		; AFD7	$E9 $00
	STA $47			; AFD9	$85 $47
	BCS L32FE4		; AFDB	$B0 $07		min 1
	LDX #$01		; AFDD	$A2 $01
	STX $46			; AFDF	$86 $46		hit + haste/slow
	DEX			; AFE1	$CA
	STX $47			; AFE2	$86 $47
L32FE4:
	LDY #$19		; AFE4	$A0 $19
	LDA ($9F),Y		; AFE6	$B1 $9F		main hand hit %
	STA $44			; AFE8	$85 $44		hit %
	LDA #$00		; AFEA	$A9 $00
	STA $45			; AFEC	$85 $45
	JSR Get_player_status1	; AFEE	$20 $71 $AF
	AND #$02		; AFF1	$29 $02		blind(bit1)
	BEQ L32FF9		; AFF3	$F0 $04		branch if not blind
	LSR $45			; AFF5	$46 $45
	ROR $44			; AFF7	$66 $44		hit %
L32FF9:
	JSR $BC2C		; AFF9	$20 $2C $BC	check for hit - status calc ?? (toad/mini)
	LDA $48			; AFFC	$A5 $48
	STA $52			; AFFE	$85 $52		$52(ADDR) = number of successful hits
	LDA $49			; B000	$A5 $49
	STA $53			; B002	$85 $53
	LDY #$00		; B004	$A0 $00
	LDA ($A1),Y		; B006	$B1 $A1		target's evade mult
	STA $46			; B008	$85 $46
	INY			; B00A	$C8
	LDA ($A1),Y		; B00B	$B1 $A1		target's evade %
	STA $44			; B00D	$85 $44		evade %
	LDA #$00		; B00F	$A9 $00
	STA $45			; B011	$85 $45
	STA $47			; B013	$85 $47
	JSR Get_enemy_status1	; B015	$20 $76 $AF
	AND #$02		; B018	$29 $02		blind(bit1)
	BEQ L33020		; B01A	$F0 $04		branch if not blind
	LSR $45			; B01C	$46 $45
	ROR $44			; B01E	$66 $44
L33020:
	JSR $BC2C		; B020	$20 $2C $BC	check for hit - status calc ??
	LDA $48			; B023	$A5 $48
	STA $54			; B025	$85 $54
	LDA $49			; B027	$A5 $49
	STA $55			; B029	$85 $55
	SEC			; B02B	$38
L33C2C:
	LDA $52			; B02C	$A5 $52		subtract evaded hits
	SBC $54			; B02E	$E5 $54
	STA $9C			; B030	$85 $9C
	LDA $53			; B032	$A5 $53
	SBC $55			; B034	$E5 $55
	STA $9D			; B036	$85 $9D		set damage multiplier
	BCS L33040		; B038	$B0 $06
	LDA #$00		; B03A	$A9 $00		min zero
	STA $9C			; B03C	$85 $9C
	STA $9D			; B03E	$85 $9D
L33040:
	LDA $9C			; B040	$A5 $9C
	ORA $9D			; B042	$05 $9D
	BNE L3304B		; B044	$D0 $05		branch if there was at least one hit
	STA $9A			; B046	$85 $9A		zero damage
	STA $9B			; B048	$85 $9B
	RTS			; B04A	$60
; End of
L3304B:
	LDA $28			; B04B	$A5 $28
	ORA #$40		; B04D	$09 $40
	STA $28			; B04F	$85 $28
	LDY #$12		; B051	$A0 $12
	LDA ($9F),Y		; B053	$B1 $9F		intellect
	STA $44			; B055	$85 $44
	LDY #$2B		; B057	$A0 $2B
	LDA ($9F),Y		; B059	$B1 $9F		target m???aiii
	STA $45			; B05B	$85 $45
	LDA $44			; B05D	$A5 $44
	BEQ L33067		; B05F	$F0 $06		branch if monster attacker
	LDA $45			; B061	$A5 $45		character attacker
	BPL L3307A		; B063	$10 $15		branch if character target
	BMI L3306B		; B065	$30 $04		branch if monster target
L33067:
	LDA $45			; B067	$A5 $45		monster attacker
	BMI L3307A		; B069	$30 $0F		branch if monster target
L3306B:
	JSR Get_enemy_status2	; B06B	$20 $7B $AF
	AND #$08		; B06E	$29 $08		sleep(bit3)
	BEQ L33074		; B070	$F0 $02
	BNE L3307A		; B072	$D0 $06		branch if target is asleep
L33074:
	LDA ($A1),Y		; B074	$B1 $A1		get status2
	AND #$40		; B076	$29 $40		mute(bit4)
	BEQ L33084		; B078	$F0 $0A		branch if target is not paralyzed
L3307A:
	LDY #$18		; B07A	$A0 $18		24 hits
	LDA ($9F),Y		; B07C	$B1 $9F		hit multiplier
	STA $9C			; B07E	$85 $9C
	LDA #$00		; B080	$A9 $00
	STA $9D			; B082	$85 $9D
L33084:
	LDY #$1A		; B084	$A0 $1A
	LDA ($9F),Y		; B086	$B1 $9F		main hand attack power
	STA $44			; B088	$85 $44
	LDA #$00		; B08A	$A9 $00
	STA $45			; B08C	$85 $45
	LDY #$1C		; B08E	$A0 $1C
	LDA ($9F),Y		; B090	$B1 $9F		main monster type bonus
	LDY #$15		; B092	$A0 $15
	AND ($A1),Y		; B094	$31 $A1		monster type
	BNE L330A2		; B096	$D0 $0A
	LDY #$1B		; B098	$A0 $1B
	LDA ($9F),Y		; B09A	$B1 $9F		main hand element
	LDY #$16		; B09C	$A0 $16
	AND ($A1),Y		; B09E	$31 $A1		target weak elements
	BEQ L330AF		; B0A0	$F0 $0D
L330A2:
	CLC			; B0A2	$18
	LDA $44			; B0A3	$A5 $44
	ADC #$14		; B0A5	$69 $14		+20 attack
	STA $44			; B0A7	$85 $44
	LDA $45			; B0A9	$A5 $45
	ADC #$00		; B0AB	$69 $00
	STA $45			; B0AD	$85 $45
L330AF:
	LDY #$02		; B0AF	$A0 $02
	LDA ($A1),Y		; B0B1	$B1 $A1		target defense
	STA $46			; B0B3	$85 $46
	LDA #$00		; B0B5	$A9 $00
	STA $47			; B0B7	$85 $47
	LDA $9C			; B0B9	$A5 $9C
	STA $48			; B0BB	$85 $48
	JSR $BC88		; B0BD	$20 $88 $BC	calculate damage
	LDA $4A			; B0C0	$A5 $4A
	STA $9A			; B0C2	$85 $9A
	LDA $4B			; B0C4	$A5 $4B
	STA $9B			; B0C6	$85 $9B
	LDA $9B			; B0C8	$A5 $9B
	AND #$80		; B0CA	$29 $80
	BEQ L330D4		; B0CC	$F0 $06		branch if damage is not negative ???
	LDA #$00		; B0CE	$A9 $00		set damage to zero
	STA $9A			; B0D0	$85 $9A
	STA $9B			; B0D2	$85 $9B
L330D4:
	LDY #$0A		; B0D4	$A0 $0A
	LDA ($A1),Y		; B0D6	$B1 $A1		subtract from target's hp - current hp L
	SEC			; B0D8	$38
	SBC $9A			; B0D9	$E5 $9A
	STA ($A1),Y		; B0DB	$91 $A1
	INY			; B0DD	$C8
	LDA ($A1),Y		; B0DE	$B1 $A1		current hp H ex> $7E75
	SBC $9B			; B0E0	$E5 $9B
	STA ($A1),Y		; B0E2	$91 $A1
	BCC L330EE		; B0E4	$90 $08		branch if dead
	LDA ($A1),Y		; B0E6	$B1 $A1
	DEY			; B0E8	$88
	ORA ($A1),Y		; B0E9	$11 $A1
	BNE L3310C		; B0EB	$D0 $1F		branch if not dead
	INY			; B0ED	$C8
L330EE:
	LDA #$00		; B0EE	$A9 $00
	DEY			; B0F0	$88
	STA ($A1),Y		; B0F1	$91 $A1		set target hp to zero - current hp L
	INY			; B0F3	$C8
	STA ($A1),Y		; B0F4	$91 $A1		current hp H
	JSR $BF9A		; B0F6	$20 $9A $BF	add dead target message to queue - message / check hp
	JSR Get_enemy_status1	; B0F9	$20 $76 $AF
	LDY #$2C		; B0FC	$A0 $2C
	STA ($A1),Y		; B0FE	$91 $A1		set previous status 1(enemy)
	LDY #$08		; B100	$A0 $08
	ORA #$80		; B102	$09 $80		dead(bit7)
	STA ($A1),Y		; B104	$91 $A1		set status 1(enemy)
	LDA $28			; B106	$A5 $28
	ORA #$20		; B108	$09 $20
	STA $28			; B10A	$85 $28
L3310C:
	LDY #$1D		; B10C	$A0 $1D
	LDA ($9F),Y		; B10E	$B1 $9F		main hand weapon special effect
	BEQ L33124		; B110	$F0 $12
	STA $60			; B112	$85 $60
	AND #$01		; B114	$29 $01
	BEQ L3311B		; B116	$F0 $03
	JMP $B351		; B118	$4C $51 $B3
L3311B:
	LDA $60			; B11B	$A5 $60
	AND #$02		; B11D	$29 $02
	BEQ L3312D		; B11F	$F0 $0C
	JMP $B35F		; B121	$4C $5F $B3
L33124:
	RTS			; B124	$60
; End of

;B125 - data block = weapon special effect jump table
.word $B161			; B125	$61 $B1
.word $B1CC			; B127	$CC $B1
.word $B214			; B129	$14 $B2
.word $B22A			; B12B	$2A $B2

; from above
L3312D:
	LDA #$00		; B12D	$A9 $00
	STA $52			; B12F	$85 $52
	STA $53			; B131	$85 $53
	LDA $60			; B133	$A5 $60		weapon special effect
	LSR			; B135	$4A
	LSR			; B136	$4A
	LDX #$04		; B137	$A2 $04
L33139:
	LSR			; B139	$4A
	BCS L33142		; B13A	$B0 $06
	INC $52			; B13C	$E6 $52
	DEX			; B13E	$CA
	BNE L33139		; B13F	$D0 $F8
	RTS			; B141	$60
L33142:
	ASL $52			; B142	$06 $52
	CLC			; B144	$18
	LDA #$25		; B145	$A9 $25		0C/B125
	ADC $52			; B147	$65 $52
	STA $52			; B149	$85 $52
	LDA #$B1		; B14B	$A9 $B1
	ADC $53			; B14D	$65 $53
	STA $53			; B14F	$85 $53
	LDY #$00		; B151	$A0 $00
	LDA ($52),Y		; B153	$B1 $52
	PHA			; B155	$48
	INY			; B156	$C8
	LDA ($52),Y		; B157	$B1 $52
	STA $53			; B159	$85 $53
	PLA			; B15B	$68
	STA $52			; B15C	$85 $52
	JMP ($0052)		; B15E	$6C $52 $00
; 0: drain hp
	LDY #$15		; B161	$A0 $15
	LDA ($A1),Y		; B163	$B1 $A1
	AND #$80		; B165	$29 $80
	BNE L3319C		; B167	$D0 $33
	LDY #$0E		; B169	$A0 $0E
	LDA ($A1),Y		; B16B	$B1 $A1
	STA $52			; B16D	$85 $52
	INY			; B16F	$C8
	LDA ($A1),Y		; B170	$B1 $A1
	STA $53			; B172	$85 $53
	JSR $B279		; B174	$20 $79 $B2
	JSR $B331		; B177	$20 $31 $B3
	JSR $B33F		; B17A	$20 $3F $B3
	JSR $B31F		; B17D	$20 $1F $B3
	JSR $B2C8		; B180	$20 $C8 $B2
	JSR $B33F		; B183	$20 $3F $B3
	JSR $B328		; B186	$20 $28 $B3
	JSR $B305		; B189	$20 $05 $B3
	LDY #$0A		; B18C	$A0 $0A
	LDA ($A1),Y		; B18E	$B1 $A1
	INY			; B190	$C8
	ORA ($A1),Y		; B191	$11 $A1
	BNE L3319B		; B193	$D0 $06
	LDY #$08		; B195	$A0 $08
	LDA #$80		; B197	$A9 $80
	STA ($A1),Y		; B199	$91 $A1
L3319B:
	RTS			; B19B	$60
L3319C:
	LDY #$0E		; B19C	$A0 $0E
	LDA ($9F),Y		; B19E	$B1 $9F
	STA $52			; B1A0	$85 $52
	INY			; B1A2	$C8
	LDA ($9F),Y		; B1A3	$B1 $9F
	STA $53			; B1A5	$85 $53
	JSR $B279		; B1A7	$20 $79 $B2
	JSR $B33F		; B1AA	$20 $3F $B3
	JSR $B328		; B1AD	$20 $28 $B3
	JSR $B2C8		; B1B0	$20 $C8 $B2
	JSR $B33F		; B1B3	$20 $3F $B3
	JSR $B31F		; B1B6	$20 $1F $B3
	JSR $B305		; B1B9	$20 $05 $B3
	LDY #$0A		; B1BC	$A0 $0A
	LDA ($9F),Y		; B1BE	$B1 $9F
	INY			; B1C0	$C8
	ORA ($9F),Y		; B1C1	$11 $9F
	BNE L331CB		; B1C3	$D0 $06
	LDY #$08		; B1C5	$A0 $08
	LDA #$80		; B1C7	$A9 $80
	STA ($9F),Y		; B1C9	$91 $9F
L331CB:
	RTS			; B1CB	$60
; End of

; 1: drain mp
	LDY #$15		; B1CC	A0 15     
	LDA ($A1),Y             ; B1CE	B1 A1     
	AND #$80                ; B1D0	29 80     
	BNE L331F4              ; B1D2	D0 20     
	LDY #$10                ; B1D4	A0 10     
	LDA ($A1),Y             ; B1D6	B1 A1     
	STA $52                 ; B1D8	85 52     
	INY                     ; B1DA	C8        
	LDA ($A1),Y             ; B1DB	B1 A1     
	STA $53                 ; B1DD	85 53     
	JSR $B279               ; B1DF	20 79 B2  
	JSR $B348               ; B1E2	20 48 B3  
	JSR $B328               ; B1E5	20 28 B3  
	JSR $B305               ; B1E8	20 05 B3  
	JSR $B348               ; B1EB	20 48 B3  
	JSR $B31F               ; B1EE	20 1F B3  
	JMP $B2C8               ; B1F1	4C C8 B2  
L331F4:
	LDY #$10                ; B1F4	A0 10     
	LDA ($9F),Y             ; B1F6	B1 9F     
	STA $52                 ; B1F8	85 52     
	INY                     ; B1FA	C8        
	LDA ($9F),Y             ; B1FB	B1 9F     
	STA $53                 ; B1FD	85 53     
	JSR $B279               ; B1FF	20 79 B2  
	JSR $B348               ; B202	20 48 B3  
	JSR $B328               ; B205	20 28 B3  
	JSR $B2C8               ; B208	20 C8 B2  
	JSR $B348               ; B20B	20 48 B3  
	JSR $B31F               ; B20E	20 1F B3  
	JMP $B305               ; B211	4C 05 B3  
; End of

; 2: ripper
	LDA $9C			; B214	A5 9C     
	STA $00                 ; B216	85 00     
	LDA #$00                ; B218	A9 00     
	STA $01                 ; B21A	85 01     
	LDA #$14                ; B21C	A9 14     
	STA $02                 ; B21E	85 02     
	LDA #$00                ; B220	A9 00     
	STA $03                 ; B222	85 03     
	JSR $FC98               ; B224	20 98 FC
	JMP $B331               ; B227	4C 31 B3  
; End of

; 3: heal
	LDY #$15		; B22A	A0 15     
	LDA ($A1),Y             ; B22C	B1 A1     
	AND #$80                ; B22E	29 80     
	BEQ L3323B              ; B230	F0 09     branch if not undead
	LDY $9C                 ; B232	A4 9C     
L33234:
	JSR $B2A4               ; B234	20 A4 B2  calculate healing damage
	DEY                     ; B237	88        
	BNE L33234              ; B238	D0 FA     
	RTS                     ; B23A	60        
L3323B:
	LDY $9C                 ; B23B	A4 9C     
L3323D:
	JSR $B2A4               ; B23D	20 A4 B2  calculate healing damage
	DEY                     ; B240	88        
	BNE L3323D              ; B241	D0 FA     
	CLC                     ; B243	18        
	LDY #$0A                ; B244	A0 0A     
	LDA ($A1),Y             ; B246	B1 A1     
	ADC $9A                 ; B248	65 9A     
	STA ($A1),Y             ; B24A	91 A1     
	INY                     ; B24C	C8        
	LDA ($A1),Y             ; B24D	B1 A1     
	ADC $9B                 ; B24F	65 9B     
	STA ($A1),Y             ; B251	91 A1     
	JSR $B33F               ; B253	20 3F B3  
	JSR $B328               ; B256	20 28 B3  
	JSR $B2D8               ; B259	20 D8 B2  
	LDA #$00                ; B25C	A9 00     
	STA $9A                 ; B25E	85 9A     
	STA $9B                 ; B260	85 9B     
	LDA $28                 ; B262	A5 28     
	AND #$DF                ; B264	29 DF     
	STA $28                 ; B266	85 28     
	JSR $AF76               ; B268	20 76 AF   get target status 1
	AND #$7F                ; B26B	29 7F     
	STA ($A1),Y             ; B26D	91 A1     
	LDY #$2C                ; B26F	A0 2C     
	STA ($A1),Y             ; B271	91 A1     
	LDA #$FF                ; B273	A9 FF     
	STA $7FBA               ; B275	8D BA 7F  
	RTS                     ; B278	60        
; End of

; Name	:
; Marks	: calculate drain damage
	LSR $53			; B279	46 53     divide by 16
	ROR $52                 ; B27B	66 52     
	LSR $53                 ; B27D	46 53     
	ROR $52                 ; B27F	66 52     
	LSR $53                 ; B281	46 53     
	ROR $52                 ; B283	66 52     
	LSR $53                 ; B285	46 53     
	ROR $52                 ; B287	66 52     
	LDA $52                 ; B289	A5 52     
	ORA $53                 ; B28B	05 53     
	BNE L33291              ; B28D	D0 02     
	INC $52                 ; B28F	E6 52     min 1
L33291:
	LDA $9C                 ; B291	A5 9C     damage multiplier
	STA $00                 ; B293	85 00     
	LDA #$00                ; B295	A9 00     
	STA $01                 ; B297	85 01     
	LDA $52                 ; B299	A5 52     
	STA $02                 ; B29B	85 02     
	LDA $53                 ; B29D	A5 53     
	STA $03                 ; B29F	85 03     
	JMP $FC98               ; B2A1	4C 98 FC  multiply (16-bit)
; End of

; Name	:
; Marks	: calculate healing damage 
	LDX #$00		; B2A4	A2 00     
	STX $52                 ; B2A6	86 52     
	STX $53                 ; B2A8	86 53     
	LDA #$1E                ; B2AA	A9 1E     
	JSR $FD11               ; B2AC	20 11 FD  random (X..A)
	CLC                     ; B2AF	18        
	ADC #$1E                ; B2B0	69 1E     
	STA $04                 ; B2B2	85 04     
	LDA $53                 ; B2B4	A5 53     
	ADC #$00                ; B2B6	69 00     
	STA $05                 ; B2B8	85 05     
	CLC                     ; B2BA	18        
	LDA $9A                 ; B2BB	A5 9A     
	ADC $04                 ; B2BD	65 04     
	STA $9A                 ; B2BF	85 9A     
	LDA $9B                 ; B2C1	A5 9B     
	ADC $05                 ; B2C3	65 05     
	STA $9B                 ; B2C5	85 9B     
	RTS                     ; B2C7	60        
; End of

;
	LDY $56			; B2C8	A4 56     
	CLC                     ; B2CA	18        
	LDA ($58),Y             ; B2CB	B1 58     
	ADC $04                 ; B2CD	65 04     
	STA ($58),Y             ; B2CF	91 58     
	INY                     ; B2D1	C8        
	LDA ($58),Y             ; B2D2	B1 58     
	ADC $05                 ; B2D4	65 05     
	STA ($58),Y             ; B2D6	91 58     
	LDY $56                 ; B2D8	A4 56     
	LDA ($58),Y             ; B2DA	B1 58     
	STA $00                 ; B2DC	85 00     
	INY                     ; B2DE	C8        
	LDA ($58),Y             ; B2DF	B1 58     
	STA $01                 ; B2E1	85 01     
	LDY $57                 ; B2E3	A4 57     
	LDA ($58),Y             ; B2E5	B1 58     
	STA $02                 ; B2E7	85 02     
	INY                     ; B2E9	C8        
	LDA ($58),Y             ; B2EA	B1 58     
	STA $03                 ; B2EC	85 03     
	LDA $04                 ; B2EE	A5 04     
	PHA                     ; B2F0	48        
	JSR $8FFC               ; B2F1	20 FC 8F  compare (16-bit)
	BCC L33301              ; B2F4	90 0B     
	LDY $56                 ; B2F6	A4 56     
	LDA $02                 ; B2F8	A5 02     
	STA ($58),Y             ; B2FA	91 58     
	INY                     ; B2FC	C8        
	LDA $03                 ; B2FD	A5 03     
	STA ($58),Y             ; B2FF	91 58     
L33301:
	PLA                     ; B301	68        
	STA $04                 ; B302	85 04     
	RTS                     ; B304	60        
; End of

;
	LDY $56			; B305	A4 56     
	SEC                     ; B307	38        
	LDA ($58),Y             ; B308	B1 58     
	SBC $04                 ; B30A	E5 04     
	STA ($58),Y             ; B30C	91 58     
	INY                     ; B30E	C8        
	LDA ($58),Y             ; B30F	B1 58     
	SBC $05                 ; B311	E5 05     
	STA ($58),Y             ; B313	91 58     
	BCS L3331E              ; B315	B0 07     
	LDA #$00                ; B317	A9 00     
	STA ($58),Y             ; B319	91 58     
	DEY                     ; B31B	88        
	STA ($58),Y             ; B31C	91 58     
L3331E:
	RTS                     ; B31E	60        
; End of

;
	LDA $9F			; B31F	A5 9F     
	STA $58                 ; B321	85 58     
	LDA $A0                 ; B323	A5 A0     
	STA $59                 ; B325	85 59     
	RTS                     ; B327	60        
; End of

;
	LDA $A1                 ; B328	A5 A1     
	STA $58                 ; B32A	85 58     
	LDA $A2                 ; B32C	A5 A2     
	STA $59                 ; B32E	85 59     
	RTS                     ; B330	60        
; End of

;
	CLC                     ; B331	18        
	LDA $9A                 ; B332	A5 9A     
	ADC $04                 ; B334	65 04     
	STA $9A                 ; B336	85 9A     
	LDA $9B                 ; B338	A5 9B     
	ADC $05                 ; B33A	65 05     
	STA $9B                 ; B33C	85 9B     
	RTS                     ; B33E	60        
; End of

;
	LDY #$0A                ; B33F	A0 0A     
	STY $56                 ; B341	84 56     
	LDY #$0E                ; B343	A0 0E     
	STY $57                 ; B345	84 57     
	RTS                     ; B347	60        
; End of
	                        
;
	LDY #$0C                ; B348	A0 0C     
	STY $56                 ; B34A	84 56     
	LDY #$10                ; B34C	A0 10     
	STY $57                 ; B34E	84 57     
	RTS                     ; B350	60        
; End of

;
	LDY #$08		; B351	A0 08     
	STY $56                 ; B353	84 56     
	LDY #$2C                ; B355	A0 2C     
	STY $5E                 ; B357	84 5E     
	LDA #$FE                ; B359	A9 FE     
	STA $57                 ; B35B	85 57     
	BNE L3336D               ; B35D	D0 0E     
L3335F:
	LDY #$09		; B35F	$A0 $09
	STY $56			; B361	$84 $56
	LDY #$2D		; B363	$A0 $2D
	STY $5E			; B365	$84 $5E
	LDA #$FD		; B367	$A9 $FD
	STA $57			; B369	$85 $57
	BNE L3336D		; B36B	$D0 $00
L3336D:
	LDY #$03		; B36D	$A0 $03
	LDA ($A1),Y		; B36F	$B1 $A1
	STA $46			; B371	$85 $46
	INY			; B373	$C8
	LDA ($A1),Y		; B374	$B1 $A1
	STA $44			; B376	$85 $44
	LDA #$00		; B378	$A9 $00
	STA $45			; B37A	$85 $45
	STA $47			; B37C	$85 $47
	JSR $AF76		; B37E	$20 $76 $AF
	AND #$02		; B381	$29 $02
	BEQ L33389		; B383	$F0 $04
	LSR $45			; B385	$46 $45
	ROR $44			; B387	$66 $44
L33389:
	JSR $BC2C		; B389	$20 $2C $BC	check for hit
	LDY #$1D		; B38C	$A0 $1D
	LDA ($9F),Y		; B38E	$B1 $9F
	AND $57			; B390	$25 $57
	STA $52			; B392	$85 $52
	SEC			; B394	$38
	LDA $9C			; B395	$A5 $9C
	SBC $48			; B397	$E5 $48
	BCC L333C5		; B399	$90 $2A
	BEQ L333C5		; B39B	$F0 $28
	LDY $56			; B39D	$A4 $56
	LDA ($A1),Y		; B39F	$B1 $A1
	LDY $5E			; B3A1	$A4 $5E
	STA ($A1),Y		; B3A3	$91 $A1
	ORA $52			; B3A5	$05 $52
	LDY $56			; B3A7	$A4 $56
	STA ($A1),Y		; B3A9	$91 $A1
	LDY $56			; B3AB	$A4 $56
	CPY #$08		; B3AD	$C0 $08
	BNE L333C0		; B3AF	$D0 $0F
	LDA ($A1),Y		; B3B1	$B1 $A1
	AND #$80		; B3B3	$29 $80
	BEQ L333C0		; B3B5	$F0 $09
	LDA #$00		; B3B7	$A9 $00
	LDY #$0A		; B3B9	$A0 $0A
	STA ($A1),Y		; B3BB	$91 $A1
	INY			; B3BD	$C8
	STA ($A1),Y		; B3BE	$91 $A1
L333C0:
	LDA $52			; B3C0	$A5 $52
	JSR $BF5C		; B3C2	$20 $5C $BF	show status inflicted message
L333C5:
	RTS			; B3C5	$60
; End of

; Name	:
; Marks	: do magic/item action
	LDA #$00		; B3C6	A9 00     
	STA $4A                 ; B3C8	85 4A     
	STA $4B                 ; B3CA	85 4B     
	STA $00AE               ; B3CC	8D AE 00  
	LDA #$80                ; B3CF	A9 80     
	STA $00AF               ; B3D1	8D AF 00  
	LDA $28                 ; B3D4	A5 28     
	ORA #$40                ; B3D6	09 40     
	STA $28                 ; B3D8	85 28     
	LDY #$2A                ; B3DA	A0 2A     
	LDA ($9F),Y             ; B3DC	B1 9F     spell id
	STA $6C                 ; B3DE	85 6C     
	STA $5E                 ; B3E0	85 5E     
	LDX $7CBB               ; B3E2	AE BB 7C  counter for turn order
	LDA $7D5E,X             ; B3E5	BD 5E 7D  turn order
	CMP #$04                ; B3E8	C9 04     
	BCC L3340D              ; B3EA	90 21     branch if a character
	SEC                     ; B3EC	38        monster attacker
	SBC #$04                ; B3ED	E9 04     
	TAX                     ; B3EF	AA        
	LDA $7CD3,X             ; B3F0	BD D3 7C  
	CLC                     ; B3F3	18        
	ADC #$64                ; B3F4	69 64     
	STA $E4                 ; B3F6	85 E4     
	LDY #$23                ; B3F8	A0 23     
	LDA ($9F),Y             ; B3FA	B1 9F     palette id
	STA $7CB1               ; B3FC	8D B1 7C  
	INY                     ; B3FF	C8        
	LDA ($9F),Y             ; B400	B1 9F     animation id
	STA $7CB0               ; B402	8D B0 7C  
	INY                     ; B405	C8        
	LDA ($9F),Y             ; B406	B1 9F     
	STA $29                 ; B408	85 29     
	JMP $B487               ; B40A	4C 87 B4  
L3340D:
	LDY #$25                ; B40D	A0 25     character attacker
	LDA ($9F),Y             ; B40F	B1 9F     spell level
	STA $29                 ; B411	85 29     
	LDA $6C                 ; B413	A5 6C     
	TAX                     ; B415	AA        
	DEX                     ; B416	CA        
	TXA                     ; B417	8A        
	STA $6C                 ; B418	85 6C     
	CLC                     ; B41A	18        
	ADC #$64                ; B41B	69 64     
	STA $E4                 ; B41D	85 E4     
	LDA $6C                 ; B41F	A5 6C     
	STA $00                 ; B421	85 00     
	LDA #$07                ; B423	A9 07     size	7 bytes
	STA $02                 ; B425	85 02     
	LDA #$00                ; B427	A9 00     
	STA $01                 ; B429	85 01     
	STA $03                 ; B42B	85 03     
	JSR $FC98               ; B42D	20 98 FC  multiply (16-bit)
	LDA $04			; B430	$A5 $04
	ADC #<Magic_prop
	;ADC #$D9		; B432	$69 $D9
	STA $44			; B434	$85 $44
	LDA $05			; B436	$A5 $05
	ADC #>Magic_prop
	;ADC #$85		; B438	$69 $85
	STA $45			; B43A	$85 $45
	LDY #$00		; B43C	$A0 $00
	LDA ($44),Y		; B43E	$B1 $44
	STA $5E			; B440	85 5E     
	INY                     ; B442	C8        
	LDA ($44),Y             ; B443	B1 44     byte 1 (spell %)
	STA $46                 ; B445	85 46     
	INY                     ; B447	C8        
	LDA ($44),Y             ; B448	B1 44     byte 2 (spell power)
	STA $47                 ; B44A	85 47     
	INY                     ; B44C	C8        
	LDA ($44),Y             ; B44D	B1 44     byte 3 (parameter 1)
	STA $48                 ; B44F	85 48     
	INY                     ; B451	C8        
	LDA ($44),Y             ; B452	B1 44     byte 4 (parameter 2)
	STA $49                 ; B454	85 49     
	INY                     ; B456	C8        
	LDA ($44),Y             ; B457	B1 44     byte 5 (palette id)
	STA $7CB1               ; B459	8D B1 7C  
	INY                     ; B45C	C8        
	LDA ($44),Y             ; B45D	B1 44     byte 6 (animation id)
	STA $7CB0               ; B45F	8D B0 7C  
	LDY #$26                ; B462	A0 26     
	LDX #$00                ; B464	A2 00     
L33466:
	LDA $46,X               ; B466	B5 46     
	STA ($9F),Y             ; B468	91 9F     copy to spell stats
	INY                     ; B46A	C8        
	INX                     ; B46B	E8        
	CPX #$04                ; B46C	E0 04     
	BNE L33466              ; B46E	D0 F6     
	LDA $6C                 ; B470	A5 6C     
	CMP #$14                ; B472	C9 14     
	BCS L3347E              ; B474	B0 08     
	LDY #$12                ; B476	A0 12     use intellect
	JSR $B551               ; B478	20 51 B5  calculate mod. spell stats
	JMP $B487               ; B47B	4C 87 B4  
L3347E:
	CMP #$28                ; B47E	C9 28     
	BCS L33487              ; B480	B0 05     
	LDY #$13                ; B482	A0 13     use spirit
	JSR $B551               ; B484	20 51 B5  calculate mod. spell stats
L33487:
	JSR $AF76               ; B487	20 76 AF  get target status 1
	AND #$C0                ; B48A	29 C0     
	BEQ L3349B              ; B48C	F0 0D     branch if not dead
	LDA $6C                 ; B48E	A5 6C     
	CMP #$15                ; B490	C9 15     life can target dead characters
	BEQ L3349B              ; B492	F0 07     
	CMP #$17                ; B494	C9 17     esuna can target dead characters
	BEQ L3349B              ; B496	F0 03     
	JMP $BE73               ; B498	4C 73 BE  magic ineffective
L3349B:
	LDA $A6                 ; B49B	A5 A6     
	BEQ L334B1              ; B49D	F0 12     
	LDY #$26                ; B49F	A0 26     
	LDA ($9F),Y             ; B4A1	B1 9F     save attacker mod. spell %
	STA $70                 ; B4A3	85 70     
	LSR                     ; B4A5	4A        
	STA ($9F),Y             ; B4A6	91 9F     halve spell %
	INY                     ; B4A8	C8        
	LDA ($9F),Y             ; B4A9	B1 9F     save attacker mod. spell power
	STA $71                 ; B4AB	85 71     
	LSR                     ; B4AD	4A        
	LSR                     ; B4AE	4A        
	STA ($9F),Y             ; B4AF	91 9F     
L334B1:
	JSR $AF76               ; B4B1	20 76 AF  get target status 1
	AND #$C0                ; B4B4	29 C0     
	BEQ L334C3              ; B4B6	F0 0B     
	LDA $6C                 ; B4B8	A5 6C     
	CMP #$15                ; B4BA	C9 15     
	BEQ L334C3              ; B4BC	F0 05     
	CMP #$17                ; B4BE	C9 17     
	BEQ L334C3              ; B4C0	F0 01     
	RTS                     ; B4C2	60        
L334C3:
	LDA $6C                 ; B4C3	A5 6C     
	CMP #$14                ; B4C5	C9 14     
	BCS L334CC              ; B4C7	B0 03     
	JSR $BC12               ; B4C9	20 12 BC  check magic wall
L334CC:
	LDY #$28                ; B4CC	A0 28     
	LDA ($9F),Y             ; B4CE	B1 9F     
	LDY #$17                ; B4D0	A0 17     
	AND ($A1),Y             ; B4D2	31 A1     
	BEQ L334D9              ; B4D4	F0 03     
	JMP $BCFB               ; B4D6	4C FB BC  restore hp
L334D9:
	LDA $5E                 ; B4D9	A5 5E     
	ASL                     ; B4DB	0A        
	CLC                     ; B4DC	18        
	ADC #$8A                ; B4DD	69 8A     BE8A (magic effect jump table)
	STA $44                 ; B4DF	85 44     
	LDA #$00                ; B4E1	A9 00     
	ADC #$BE                ; B4E3	69 BE     
	STA $45                 ; B4E5	85 45     
	LDY #$00                ; B4E7	A0 00     
	LDA ($44),Y             ; B4E9	B1 44     
	STA $46                 ; B4EB	85 46     
	INY                     ; B4ED	C8        
	LDA ($44),Y             ; B4EE	B1 44     
	STA $47                 ; B4F0	85 47     
	JSR $BE87               ; B4F2	20 87 BE  do magic effect
	LDY #$0A                ; B4F5	A0 0A     
	LDA ($9F),Y             ; B4F7	B1 9F     
	INY                     ; B4F9	C8        
	ORA ($9F),Y             ; B4FA	11 9F     
	BNE L33504              ; B4FC	D0 06     branch if attacker hp is not zero
	LDY #$08                ; B4FE	A0 08     
	LDA #$80                ; B500	A9 80     
	STA ($9F),Y             ; B502	91 9F     make attacker dead
L33504:
	LDA $71                 ; B504	A5 71     
	LDY #$27                ; B506	A0 27     
	STA ($9F),Y             ; B508	91 9F     restore attacker mod. spell power
	DEY                     ; B50A	88        
	LDA $70                 ; B50B	A5 70     
	STA ($9F),Y             ; B50D	91 9F     restore attacker mod. spell %
	LDA $4A                 ; B50F	A5 4A     
	STA $00                 ; B511	85 00     
	LDA $4B                 ; B513	A5 4B     
	STA $01                 ; B515	85 01     
	LDA #$86                ; B517	A9 86     *** bug *** should be 01869Fh = 99999
	STA $03                 ; B519	85 03     
	LDA #$9F                ; B51B	A9 9F     
	STA $02                 ; B51D	85 02     
	JSR $8FFC               ; B51F	20 FC 8F  compare (16-bit)
	BCC L3352C              ; B522	90 08     
	LDA #$86                ; B524	A9 86     
	STA $4B                 ; B526	85 4B     
	LDA #$9F                ; B528	A9 9F     
	STA $4A                 ; B52A	85 4A     
L3352C:
	LDA $4A                 ; B52C	A5 4A     
	STA $9A                 ; B52E	85 9A     
	STA $AE                 ; B530	85 AE     
	LDA $4B                 ; B532	A5 4B     
	STA $9B                 ; B534	85 9B     
	STA $AF                 ; B536	85 AF     
	LDY #$0A                ; B538	A0 0A     
	LDA ($A1),Y             ; B53A	B1 A1     target's current hp
	INY                     ; B53C	C8        
	ORA ($A1),Y             ; B53D	11 A1     
	BNE L3354E              ; B53F	D0 0D     branch if not zero
	JSR $AF76               ; B541	20 76 AF  get target status 1
	LDY #$2C                ; B544	A0 2C     
	STA ($A1),Y             ; B546	91 A1     make target dead
	LDY #$08                ; B548	A0 08     
	ORA #$80                ; B54A	09 80     
	STA ($A1),Y             ; B54C	91 A1     
L3354E:
	JMP $BF9A               ; B54E	4C 9A BF  add dead target message to queue
; End of

; Name	:
; Y	: spell stat offset
; Marks	: calculate mod. spell stats
;	  $12 = intellect
;	  $13 = spirit
	LDA ($9F),Y		; B551	B1 9F     intellect or spirit
	STA $48                 ; B553	85 48     
	LDY #$24                ; B555	A0 24     
	SEC                     ; B557	38        
	SBC ($9F),Y             ; B558	F1 9F     subtract spell % penalty
	BCS L3355E              ; B55A	B0 02     
	LDA #$00                ; B55C	A9 00     min zero
L3355E:
	CLC                     ; B55E	18        
	ADC $46                 ; B55F	65 46     add spell % from magic properties
	LDY #$26                ; B561	A0 26     
	STA ($9F),Y             ; B563	91 9F     set mod. spell %
	LDA $48                 ; B565	A5 48     
	LSR                     ; B567	4A        
	LSR                     ; B568	4A        
	CLC                     ; B569	18        
	ADC $47                 ; B56A	65 47     stat / 4 + spell power from magic properties
	LDY #$27                ; B56C	A0 27     
	STA ($9F),Y             ; B56E	91 9F     set mod. spell power
	RTS                     ; B570	60        
; End of

; Name	:
; Marks	: magic effect 
;	  $00/$01: magic damage
	JSR $BD7B		; B571	20 7B BD  calculate magic damage
	LDY #$0A                ; B574	A0 0A     
	JMP $B579		; B576	4C 79 B5  subtract damage from target hp/mp
; End of


; Y: offset of current hp/mp ($0A = hp, $0C = mp)
; Marks	: subtract damage from target hp/mp
	SEC 			; B579	38        
	LDA ($A1),Y             ; B57A	B1 A1     
	SBC $4A                 ; B57C	E5 4A     
	STA ($A1),Y             ; B57E	91 A1     
	INY                     ; B580	C8        
	LDA ($A1),Y             ; B581	B1 A1     
	SBC $4B                 ; B583	E5 4B     
	STA ($A1),Y             ; B585	91 A1     
	BCS L3358C              ; B587	B0 03     
	JSR $B58D               ; B589	20 8D B5  set target hp to zero
L3358C:
	RTS                     ; B58C	60        
	                        
; Marks	: set target hp to zero
	LDA #$00                ; B58D	A9 00     
	STA ($A1),Y             ; B58F	91 A1     
	DEY                     ; B591	88        
	STA ($A1),Y             ; B592	91 A1     
	RTS                     ; B594	60        
; End of
	                        
; Marks	: magic effect $02:magic healing
	LDY #$15                ; B595	A0 15     
	LDA ($A1),Y             ; B597	B1 A1     
	AND #$80                ; B599	29 80     
	BNE L335A3              ; B59B	D0 06     branch if undead
	JSR $BCFB               ; B59D	20 FB BC  restore hp
	JMP $B5A6               ; B5A0	4C A6 B5  
L335A3:
	JSR $BD52               ; B5A3	20 52 BD  do magic damage (undead)
	RTS                     ; B5A6	60        
; End of

; Marks	: magic effect $03/$04	inflict status
	LDA $5E                 ; B5A7	A5 5E     
	CMP #$04                ; B5A9	C9 04     
	BEQ L335C8              ; B5AB	F0 1B     
	LDA #$08                ; B5AD	A9 08     status 1
	STA $5E                 ; B5AF	85 5E     
	JSR $B5E2               ; B5B1	20 E2 B5  inflict status
	LDY #$08                ; B5B4	A0 08     
	LDA ($A1),Y             ; B5B6	B1 A1     
	AND #$80                ; B5B8	29 80     
	BEQ L335C5              ; B5BA	F0 09     
	LDY #$00                ; B5BC	A0 00     
	STY $A5                 ; B5BE	84 A5     
	LDY #$0B                ; B5C0	A0 0B     
	JSR $B58D               ; B5C2	20 8D B5  set target hp to zero
L335C5:
	JMP $B5CF               ; B5C5	4C CF B5  
L335C8:
	LDA #$09                ; B5C8	A9 09     status 2
	STA $5E                 ; B5CA	85 5E     
	JSR $B5E2               ; B5CC	20 E2 B5  inflict status
	RTS                     ; B5CF	60        
; End of

; Marks	:
	SEC                     ; B5D0	38        
	LDA $52                 ; B5D1	A5 52     
	SBC $54                 ; B5D3	E5 54     
	STA $52                 ; B5D5	85 52     
	LDA $53                 ; B5D7	A5 53     
	SBC $55                 ; B5D9	E5 55     
	STA $53                 ; B5DB	85 53     
	LDA $52                 ; B5DD	A5 52     
	ORA $53                 ; B5DF	05 53     
	RTS                     ; B5E1	60        
; End of
	                        
; Name	:
; Marks	: inflict status
	JSR $BE23               ; B5E2	20 23 BE  get number of magic hits
	JSR $B5D0               ; B5E5	20 D0 B5  
	BCC L33610              ; B5E8	90 26     branch if less than 1 hit
	BEQ L33610              ; B5EA	F0 24     
	LDY $5E                 ; B5EC	A4 5E     
	TYA                     ; B5EE	98        
	CLC                     ; B5EF	18        
	ADC #$24                ; B5F0	69 24     
	STA $5F                 ; B5F2	85 5F     
	LDA ($A1),Y             ; B5F4	B1 A1     previous status 1/2
	LDY $5F                 ; B5F6	A4 5F     
	STA ($A1),Y             ; B5F8	91 A1     
	LDY #$29                ; B5FA	A0 29     
	ORA ($9F),Y             ; B5FC	11 9F     spell parameter 2
	LDY $5E                 ; B5FE	A4 5E     
	STA ($A1),Y             ; B600	91 A1     
	LDA $5E                 ; B602	A5 5E     
	STA $56                 ; B604	85 56     
	LDY #$29                ; B606	A0 29     
	LDA ($9F),Y             ; B608	B1 9F     
	JSR $BF5C               ; B60A	20 5C BF  show status inflicted message
	JMP $BE7E               ; B60D	4C 7E BE  don't show damage message
L33610:
	JMP $BE73               ; B610	4C 73 BE  magic ineffective
; End of

; magic effect $05: slow
	JSR $BE23		; B613	20 23 BE            ; get number of magic hits
	JSR $B5D0               ; B616	20 D0 B5  
	BCC L33649              ; B619	90 2E     
	SEC                     ; B61B	38        
	LDA #$14                ; B61C	A9 14     
	SBC $52                 ; B61E	E5 52     
	STA $02                 ; B620	85 02     
	LDA #$00                ; B622	A9 00     
	SBC $53                 ; B624	E5 53     
	STA $03                 ; B626	85 03     
	LDY #$07                ; B628	A0 07     
	LDA ($A1),Y             ; B62A	B1 A1     
	STA $00                 ; B62C	85 00     
	LDA #$00                ; B62E	A9 00     
	STA $01                 ; B630	85 01     
	JSR $8FFC               ; B632	20 FC 8F  compare (16-bit)
	BCC L33649              ; B635	90 12     
	LDY #$07                ; B637	A0 07     
	LDA $02                 ; B639	A5 02     
	STA ($A1),Y             ; B63B	91 A1     
	LDA #$3D                ; B63D	A9 3D     $3D	"Can hit"
	JSR $BF92               ; B63F	20 92 BF  add to battle message queue
	LDA #$BE                ; B642	A9 BE     $3E	" less"
	JSR $BF92               ; B644	20 92 BF  add to battle message queue
	BNE L3364C              ; B647	D0 03     
L33649:
	JSR $BE73               ; B649	20 73 BE  magic ineffective
L3364C:
	JMP $BE7E               ; B64C	4C 7E BE  don't show damage message
	                        
; magic effect $06: haste
	JSR $BDE9               ; B64F	20 E9 BD  check for hit (magic)
	JSR $B68D               ; B652	20 8D B6  set number of hits
	AND #$80                ; B655	29 80     
	BNE L33687              ; B657	D0 2E     branch if negative number of hits
	CLC                     ; B659	18        
	LDA #$14                ; B65A	A9 14     add 20
	ADC $52                 ; B65C	65 52     
	STA $02                 ; B65E	85 02     
	LDA #$00                ; B660	A9 00     
	ADC $53                 ; B662	65 53     
	STA $03                 ; B664	85 03     
	LDY #$07                ; B666	A0 07     
	LDA ($A1),Y             ; B668	B1 A1     current haste/slow modifier
	STA $00                 ; B66A	85 00     
	LDA #$00                ; B66C	A9 00     
	STA $01                 ; B66E	85 01     
	JSR $8FFC               ; B670	20 FC 8F  compare (16-bit)
	BCS L33687              ; B673	B0 12     branch if current modifier is greater
	LDY #$07                ; B675	A0 07     
	LDA $02                 ; B677	A5 02     
	STA ($A1),Y             ; B679	91 A1     set haste/slow modifier
	LDA #$3D                ; B67B	A9 3D     $3D	"Can hit"
	JSR $BF92               ; B67D	20 92 BF  add to battle message queue
	LDA #$BF                ; B680	A9 BF     $3F	" more"
	JSR $BF92               ; B682	20 92 BF  add to battle message queue
	BNE L3368A              ; B685	D0 03     
L33687:
	JSR $BE73               ; B687	20 73 BE  magic ineffective
L3368A:
	JMP $BE7E               ; B68A	4C 7E BE  don't show damage message

; set number of hits
	LDA $48                 ; B68D	A5 48     
	STA $52                 ; B68F	85 52     
	LDA $49                 ; B691	A5 49     
	STA $53                 ; B693	85 53     
	RTS                     ; B695	60        
	                        
; magic effect $07:fear
	JSR $BE23               ; B696	20 23 BE  get number of magic hits
	JSR $B5D0               ; B699	20 D0 B5  
	BCC L336C2              ; B69C	90 24     
	LDA $52                 ; B69E	A5 52     
	STA $00                 ; B6A0	85 00     
	LDA $53                 ; B6A2	A5 53     
	STA $01                 ; B6A4	85 01     
	LDY #$27                ; B6A6	A0 27     
	LDA ($9F),Y             ; B6A8	B1 9F     
	STA $02                 ; B6AA	85 02     
	LDA #$00                ; B6AC	A9 00     
	STA $03                 ; B6AE	85 03     
	JSR $FC98               ; B6B0	20 98 FC  multiply (16-bit)
	LDY #$14                ; B6B3	A0 14     
	CLC                     ; B6B5	18        
	LDA ($A1),Y             ; B6B6	B1 A1     
	ADC $04                 ; B6B8	65 04     
	STA ($A1),Y             ; B6BA	91 A1     
	BCC L336C5              ; B6BC	90 07     
	LDA #$FF                ; B6BE	A9 FF     
	STA ($A1),Y             ; B6C0	91 A1     
L336C2:
	JMP $BE73               ; B6C2	4C 73 BE  magic ineffective
L336C5:
	LDA #$33                ; B6C5	A9 33     Terrified enemy"
	JSR $BF92               ; B6C7	20 92 BF  add to battle message queue
	JMP $BE7E               ; B6CA	4C 7E BE  don't show damage message

; magic effect $08/$09/$0B/$0C: esuna, basuna, barrier, aura
	JSR $BDE9          ; che; B6CD	20 E9 BD  ck for hit (magic)
	LDA $5E                 ; B6D0	A5 5E     
	CMP #$0A                ; B6D2	C9 0A     
	BCC L336D9              ; B6D4	90 03     
	JMP $B72C               ; B6D6	4C 2C B7  
; esuna, basuna
L336D9:
	PHA                     ; B6D9	48        
	CLC                     ; B6DA	18        
	LDY #$28                ; B6DB	A0 28     
	LDA ($9F),Y             ; B6DD	B1 9F     spell parameter 1
	ADC $48                 ; B6DF	65 48     
	STA $48                 ; B6E1	85 48     add to number of hits
	PLA                     ; B6E3	68        
	CMP #$08                ; B6E4	C9 08     
	BNE L336FB              ; B6E6	D0 13     
; esuna
	LDY #$08                ; B6E8	A0 08     
	STY $5E                 ; B6EA	84 5E     
	LDA ($A1),Y             ; B6EC	B1 A1     status 1
	LDY #$2C                ; B6EE	A0 2C     
	STY $5F                 ; B6F0	84 5F     
	STA ($A1),Y             ; B6F2	91 A1     previous status 1
	LDY #$08                ; B6F4	A0 08     
	LDX $48                 ; B6F6	A6 48     
	JMP $B70D               ; B6F8	4C 0D B7  
; basuna
L336FB:
	LDY #$09                ; B6FB	A0 09     
	STY $5E                 ; B6FD	84 5E     
	LDA ($A1),Y             ; B6FF	B1 A1     status 2
	LDY #$2D                ; B701	A0 2D     
	STY $5F                 ; B703	84 5F     
	STA ($A1),Y             ; B705	91 A1     previous status 2
	LDY #$09                ; B707	A0 09     
	LDX $48                 ; B709	A6 48     
	INX                     ; B70B	E8        
	INX                     ; B70C	E8        
	CPX #$08                ; B70D	E0 08     
	BCC L33713              ; B70F	90 02     
	LDX #$07                ; B711	A2 07     
L33713:
	LDA ($A1),Y             ; B713	B1 A1     
L33715:
	JSR $900E               ; B715	20 0E 90  clear bit
	DEX                     ; B718	CA        
	BPL L33715              ; B719	10 FA     
	STA ($A1),Y             ; B71B	91 A1     
	LDY $5E                 ; B71D	A4 5E     
	LDA ($A1),Y             ; B71F	B1 A1     
	STA $4E                 ; B721	85 4E     
	LDY $5F                 ; B723	A4 5F     
	LDA ($A1),Y             ; B725	B1 A1     
	STA $4F                 ; B727	85 4F     
	JMP $B784               ; B729	4C 84 B7  show status removed message
; barrier, aura
	PHA                     ; B72C	48        
	LDA #$49                ; B72D	A9 49     $49	"White"
	STA $5C                 ; B72F	85 5C     
	LDA #$D1                ; B731	A9 D1     $51	" Aura"
	STA $5D                 ; B733	85 5D     
	PLA                     ; B735	68        
	CMP #$0C                ; B736	C9 0C     
	BEQ L33747              ; B738	F0 0D     branch if aura
	LDA #$40                ; B73A	A9 40     $40	"Ice"
	STA $5C                 ; B73C	85 5C     
	LDA #$C8                ; B73E	A9 C8     $48	" resist!"
	STA $5D                 ; B740	85 5D     
	LDY #$05                ; B742	A0 05     
	JMP $B74D               ; B744	4C 4D B7  show barrier/aura messages
L33747:
	LDY #$1C                ; B747	A0 1C     
	JSR $B74D               ; B749	20 4D B7  show barrier/aura messages
	RTS                     ; B74C	60        
; End of

;B74D
.byte $B1,$A1,$A6
.byte $48,$E0,$08,$90,$02,$A2,$07,$CA,$30,$24,$86,$48,$20,$0A,$90,$CA
.byte $10,$FA,$91,$A1,$A2,$00,$86,$5F,$A5,$5C,$20,$92,$BF,$A5,$5D,$20
.byte $92,$BF,$A5,$48,$C5,$5F,$F0,$09,$E6,$5F,$E6,$5C,$D0,$EA,$20,$73
.byte $BE,$4C,$7E,$BE,$A2,$07,$A5,$4F,$20,$16,$90,$D0,$05,$CA,$10,$F8
.byte $30,$35,$A5,$4E,$20,$16,$90,$F0,$05,$CA,$10,$EC,$30,$29,$38,$A5
.byte $5E,$E9,$08,$85,$5E,$0A,$85,$5F,$0A,$18,$65,$5E,$65,$5F,$69,$26
.byte $85,$5E,$8A,$85,$5F,$38,$A9,$07,$E5,$5F,$85,$5F,$18,$A5,$5E,$65
.byte $5F,$20,$92,$BF,$4C,$7E,$BE,$4C,$73,$BE,$20,$E9,$BD,$A0,$27,$B1
.byte $A1,$85,$00,$A9,$00,$85,$01,$A5,$48,$85,$02,$A5,$49,$85,$03,$20
.byte $98,$FC,$A0,$02,$18,$B1,$A1,$65,$04,$91,$A1,$90,$07,$A9,$FF,$91
.byte $A1,$4C,$73,$BE,$A9,$5C,$20,$92,$BF,$A9,$E6,$20,$92,$BF,$4C,$7E

;; [$B800 :: 0x33800]

.byte $BE,$20,$23,$BE,$A6,$52,$CA,$10,$02,$30,$30,$E0,$08,$90,$02,$A2
.byte $07,$86,$52,$A0,$05,$B1,$A1,$20,$0E,$90,$CA,$10,$FA,$A2,$00,$86
.byte $5F,$A9,$52,$85,$5C,$A5,$5C,$20,$92,$BF,$A9,$DA,$20,$92,$BF,$A5
.byte $52,$C5,$5F,$F0,$09,$E6,$5F,$E6,$5C,$D0,$EA,$20,$73,$BE,$4C,$7E
.byte $BE,$20,$E9,$BD,$A5,$5E,$C9,$0F,$F0,$06,$A9,$00,$85,$5E,$F0,$04
.byte $A9,$03,$85,$5E,$18,$A4,$5E,$B1,$A1,$65,$48,$91,$A1,$90,$07,$A9
.byte $FF,$91,$A1,$4C,$73,$BE,$A5,$5E,$C9,$00,$D0,$04,$A9,$34,$D0,$02
.byte $A9,$35,$20,$92,$BF,$4C,$7E,$BE,$A0,$15,$B1,$A1,$29,$80,$F0,$03
.byte $4C,$A7,$B5,$20,$76,$AF,$29,$80,$F0,$09,$20,$E9,$BD,$A5,$48,$05
.byte $49,$D0,$03,$4C,$73,$BE,$20,$76,$AF,$A0,$2C,$91,$A1,$A0,$08,$29
.byte $7F,$91,$A1,$A9,$26,$20,$92,$BF,$38,$A9,$10,$E5,$48,$85,$02,$A9
.byte $00,$E5,$49,$85,$03,$05,$02,$D0,$02,$E6,$02,$A0,$0E,$B1,$A1,$85
.byte $00,$C8,$B1,$A1,$85,$01,$20,$C3,$FC,$A0,$0A,$A5,$04,$91,$A1,$4C
.byte $7E,$BE,$20,$23,$BE,$20,$D0,$B5,$B0,$06,$A9,$00,$85,$52,$85,$53
.byte $18,$A5,$52,$69,$01,$85,$02,$A5,$53,$69,$00,$85,$03,$A0,$0C,$B1
.byte $A1,$85,$00,$A9,$00,$85,$01,$20,$C3,$FC,$A5,$04,$91,$A1,$A9,$5E

;; [$B900 :: 0x33900]

.byte $20,$92,$BF,$A9,$B6,$20,$92,$BF,$4C,$7E,$BE,$20,$23,$BE,$20,$D0
.byte $B5,$90,$50,$F0,$4E,$A0,$0A,$20,$66,$B9,$A0,$0C,$20,$66,$B9,$A9
.byte $0A,$85,$5C,$A9,$0E,$85,$5D,$A5,$9F,$85,$5E,$A5,$A0,$85,$5F,$20
.byte $83,$B9,$A5,$A1,$85,$5E,$A5,$A2,$85,$5F,$20,$83,$B9,$A9,$0C,$85
.byte $5C,$A9,$10,$85,$5D,$A5,$9F,$85,$5E,$A5,$A0,$85,$5F,$20,$83,$B9
.byte $A5,$A1,$85,$5E,$A5,$A2,$85,$5F,$20,$83,$B9,$A9,$37,$20,$92,$BF
.byte $4C,$7E,$BE,$4C,$73,$BE,$B1,$9F,$85,$52,$C8,$B1,$9F,$85,$53,$88
.byte $B1,$A1,$91,$9F,$C8,$B1,$A1,$91,$9F,$A5,$53,$91,$A1,$88,$A5,$52
.byte $91,$A1,$60,$A4,$5C,$B1,$5E,$85,$00,$C8,$B1,$5E,$85,$01,$A4,$5D
.byte $B1,$5E,$85,$02,$C8,$B1,$5E,$85,$03,$20,$FC,$8F,$90,$0B,$A4,$5C
.byte $A5,$02,$91,$5E,$C8,$A5,$03,$91,$5E,$60,$A9,$0A,$85,$5C,$A9,$0E
.byte $85,$5D,$A9,$5D,$85,$60,$A5,$5E,$C9,$13,$F0,$0A,$E6,$60,$E6,$5C
.byte $E6,$5C,$E6,$5D,$E6,$5D,$20,$7B,$BD,$A0,$15,$B1,$A1,$29,$80,$D0
.byte $18,$A4,$5C,$20,$79,$B5,$A4,$5C,$18,$B1,$9F,$65,$4A,$91,$9F,$C8
.byte $B1,$9F,$65,$4B,$91,$9F,$4C,$1D,$BA,$06,$4A,$26,$4B,$A4,$5C,$84
.byte $50,$A4,$5D,$84,$51,$20,$1B,$BD,$A4,$5C,$38,$B1,$9F,$E5,$4A,$91

;; [$BA00 :: 0x33A00]

.byte $9F,$C8,$B1,$9F,$E5,$4B,$91,$9F,$B0,$07,$A9,$00,$91,$9F,$88,$91
.byte $9F,$A5,$60,$20,$92,$BF,$A9,$E8,$20,$92,$BF,$D0,$0A,$A5,$60,$20
.byte $92,$BF,$A9,$E9,$20,$92,$BF,$A5,$9F,$85,$5E,$A5,$A0,$85,$5F,$20
.byte $83,$B9,$A5,$A1,$85,$5E,$A5,$A2,$85,$5F,$20,$83,$B9,$4C,$7E,$BE
.byte $20,$E9,$BD,$A0,$27,$B1,$9F,$85,$02,$C8,$B1,$9F,$85,$03,$A5,$48
.byte $85,$00,$A5,$49,$85,$01,$20,$98,$FC,$A0,$1A,$18,$B1,$A1,$65,$04
.byte $90,$02,$A9,$FF,$91,$A1,$A9,$5B,$20,$92,$BF,$A9,$E6,$20,$92,$BF
.byte $4C,$7E,$BE,$20,$E9,$BD,$A0,$06,$38,$B1,$A1,$E5,$48,$90,$03,$4C
.byte $73,$BE,$A5,$48,$91,$A1,$A9,$38,$20,$92,$BF,$4C,$7E,$BE,$20,$E9
.byte $BD,$A5,$48,$05,$49,$D0,$03,$4C,$73,$BE,$20,$76,$AF,$A0,$29,$31
.byte $9F,$48,$20,$76,$AF,$A0,$2C,$91,$A1,$85,$4F,$A0,$08,$84,$5E,$68
.byte $91,$A1,$20,$84,$B7,$4C,$7E,$BE,$20,$E9,$BD,$18,$A5,$48,$65,$46
.byte $85,$52,$A5,$49,$69,$00,$85,$53,$A0,$28,$B1,$9F,$A0,$15,$31,$A1
.byte $90,$06,$A9,$00,$85,$52,$85,$53,$20,$06,$BE,$20,$06,$BB,$A0,$27
.byte $B1,$9F,$85,$44,$A9,$00,$85,$45,$85,$46,$85,$47,$A5,$52,$85,$48
.byte $20,$88,$BC,$A0,$29,$B1,$9F,$A0,$15,$31,$A1,$F0,$04,$06,$4A,$26

;; [$BB00 :: 0x33B00]

.byte $4B,$A0,$0A,$4C,$79,$B5,$A5,$48,$85,$54,$A5,$49,$85,$55,$60,$A0
.byte $15,$B1,$A1,$29,$80,$F0,$03,$4C,$52,$BD,$4C,$73,$BE,$20,$FB,$BC
.byte $20,$C6,$BD,$4C,$7E,$BE,$A9,$01,$85,$46,$A0,$26,$B1,$9F,$85,$44
.byte $A9,$00,$85,$45,$20,$71,$AF,$29,$02,$F0,$04,$46,$45,$66,$44,$20
.byte $2C,$BC,$18,$A5,$48,$65,$46,$85,$52,$A5,$49,$69,$00,$85,$53,$20
.byte $06,$BE,$20,$06,$BB,$38,$A5,$52,$E5,$54,$85,$48,$A5,$53,$E5,$55
.byte $85,$49,$B0,$06,$A9,$00,$85,$48,$85,$49,$18,$A5,$48,$69,$01,$85
.byte $48,$A5,$49,$69,$00,$85,$49,$A0,$27,$B1,$9F,$85,$44,$A9,$00,$85
.byte $45,$85,$46,$85,$47,$20,$88,$BC,$A0,$0A,$4C,$79,$B5,$A9,$00,$85
.byte $4A,$85,$4B,$A0,$0A,$B1,$9F,$85,$00,$C8,$B1,$9F,$85,$01,$A0,$0E
.byte $B1,$9F,$85,$02,$C8,$B1,$9F,$85,$03,$20,$FC,$8F,$B0,$23,$A0,$25
.byte $B1,$9F,$85,$48,$A0,$27,$B1,$9F,$85,$44,$A9,$00,$85,$45,$85,$47
.byte $A0,$02,$8C,$DE,$7F,$B1,$A1,$85,$46,$20,$88,$BC,$A0,$0A,$4C,$79
.byte $B5,$A9,$00,$8D,$E4,$00,$4C,$73,$BE,$20,$C6,$BD,$4C,$7E,$BE,$A0
.byte $28,$B1,$9F,$48,$A0,$29,$B1,$9F,$18,$69,$12,$A8,$68,$91,$A1,$98
.byte $18,$69,$4E,$20,$92,$BF,$A9,$E6,$20,$92,$BF,$4C,$7E,$BE,$A0,$01

;; [$BC00 :: 0x33C00]

.byte $B1,$A1,$AA,$CA,$8A,$91,$A1,$4C,$40,$BA,$20,$7B,$BD,$A0,$0A,$4C
.byte $79,$B5,$A0,$06,$B1,$A1,$38,$A0,$25,$F1,$9F,$90,$08,$A9,$3A,$20
.byte $92,$BF,$68,$68,$60,$A9,$00,$A0,$06,$91,$A1,$60

; Name	:
; Marks	:
	LDA #$00		; BC2C	$A9 $00
	STA $48			; BC2E	$85 $48
	STA $49			; BC30	$85 $49
	JSR Get_player_status1	; BC32	$20 $71 $AF
	AND #$20		; BC34	$29 $20		toad(bit5)
	BNE L32C53		; BC36	$D0 $1A
	INY			; BC38	$C8
	LDA ($9F),Y		; BC39	$B1 $9F		get status 2
	AND #$20		; BC3C	$29 $20		mini(bit5)
	BNE L32C53		; BC3E	$D0 $13
	LDY $46			; BC40	$A4 $46
L32C42:
	LDX #$00		; BC42	$A2 $00
	LDA #$64		; BC44	$A9 $64
	JSR $FD11		; BC46	$20 $11 $FD
	SEC			; BC49	$38
	SBC $44			; BC4A	$E5 $44		hit % ??
	BCS L32C50		; BC4C	$B0 $02
	INC $48			; BC4E	$E6 $48
L32C50:
	DEY			; BC50	$88
	BNE L32C42		; BC51	$D0 $EF
L32C53:
	RTS			; BC53	$60
; End of

;BC54
.byte $A9,$28,$48,$48,$A8,$B1,$9F,$A0,$05,$31,$A1,$F0
.byte $06,$A9,$00,$85,$44,$85,$45,$68,$A8,$B1,$9F,$A0,$17,$31,$A1,$F0
.byte $06,$A9,$00,$85,$44,$85,$45,$68,$A8,$B1,$9F,$A0,$16,$31,$A1,$F0
.byte $06,$A9,$00,$85,$46,$85,$47,$60

; Name	:
; Marks	:
	LDA #$00		; BC88	$A9 $00
	STA $49			; BC8A	$85 $49
	STA $4A			; BC8C	$85 $4A
	STA $4B			; BC8E	$85 $4B
	JSR Get_player_status1	; BC90	$20 $71 $AF
	AND #$08		; BC93	$29 $08		curse
	BEQ L33C9B		; BC95	$F0 $04
	LSR $45			; BC97	$46 $45
	ROR $44			; BC99	$66 $44
L33C9B:
	LDA ($A1),Y		; BC9B	$B1 $A1		get status1(enemy)
	AND #$08		; BC9D	$29 $08		curse
	BEQ L33CA5		; BC9F	$F0 $04
	LSR $47			; BCA1	$46 $47
	ROR $46			; BCA3	$66 $46
L33CA5:
	LDY $48			; BCA5	$A4 $48
L33CA7:
	LDX #$00		; BCA7	$A2 $00
	LDA $44			; BCA9	$A5 $44
	JSR $FD11		; BCAB	$20 $11 $FD
	CLC			; BCAE	$18
	ADC $44			; BCAF	$65 $44
	STA $4C			; BCB1	$85 $4C
	LDA #$00		; BCB3	$A9 $00
	ADC $45			; BCB5	$65 $45
	STA $4D			; BCB7	$85 $4D
	SEC			; BCB9	$38
	LDA $4C			; BCBA	$A5 $4C
	SBC $46			; BCBC	$E5 $46
	STA $4C			; BCBE	$85 $4C
	LDA $4D			; BCC0	$A5 $4D
	SBC $47			; BCC2	$E5 $47
	STA $4D			; BCC4	$85 $4D
	BCS L33CCE		; BCC6	$B0 $06
	LDA #$00		; BCC8	$A9 $00
	STA $4C			; BCCA	$85 $4C
	STA $4D			; BCCC	$85 $4D
L33CCE:
	CLC			; BCCE	$18
	LDA $4C			; BCCF	$A5 $4C
	ADC $4A			; BCD1	$65 $4A
	STA $4A			; BCD3	$85 $4A
	LDA $4D			; BCD5	$A5 $4D
	ADC $4B			; BCD7	$65 $4B
	STA $4B			; BCD9	$85 $4B
	LDX #$00		; BCDB	$A2 $00
	LDA #$64		; BCDD	$A9 $64
	JSR $FD11		; BCDF	$20 $11 $FD
	CMP #$05		; BCE2	$C9 $05
	BCS L33CF7		; BCE4	$B0 $11
	LDA #$01		; BCE6	$A9 $01
	STA $24			; BCE8	$85 $24
	CLC			; BCEA	$18
	LDA $4A			; BCEB	$A5 $4A
	ADC $44			; BCED	$65 $44
	STA $4A			; BCEF	$85 $4A
	LDA $4B			; BCF1	$A5 $4B
	ADC $45			; BCF3	$65 $45
	STA $4B			; BCF5	$85 $4B
L33CF7:
	DEY			; BCF7	$88
	BNE L33CA7		; BCF8	$D0 $AD
	RTS			; BCFA	$60
; End of

;BCFB
.byte $20,$5A,$BD,$A0,$0A

;; [$BD00 :: 0x33D00]

.byte $84,$50,$A0,$0E,$84,$51,$20,$1B,$BD,$A9,$0B,$8D,$B0,$7C,$A9,$5D
.byte $20,$92,$BF,$A9,$EA,$20,$92,$BF,$4C,$7E,$BE,$A4,$50,$18,$B1,$A1
.byte $65,$4A,$91,$A1,$C8,$B1,$A1,$65,$4B,$91,$A1,$A4,$50,$B1,$A1,$85
.byte $00,$C8,$B1,$A1,$85,$01,$A4,$51,$B1,$A1,$85,$02,$C8,$B1,$A1,$85
.byte $03,$20,$FC,$8F,$90,$0B,$A4,$50,$A5,$02,$91,$A1,$C8,$A5,$03,$91
.byte $A1,$60,$20,$7B,$BD,$A0,$0A,$4C,$79,$B5,$20,$E9,$BD,$18,$A5,$46
.byte $65,$48,$85,$48,$A9,$00,$65,$49,$85,$49,$A0,$27,$B1,$9F,$85,$44
.byte $A9,$00,$85,$45,$85,$46,$85,$47,$4C,$88,$BC,$20,$23,$BE,$20,$D0
.byte $B5,$B0,$06,$A9,$00,$85,$52,$85,$53,$A0,$25,$B1,$9F,$18,$65,$52
.byte $85,$48,$A9,$00,$65,$53,$85,$49,$A0,$27,$B1,$9F,$85,$44,$A9,$00
.byte $85,$45,$85,$46,$85,$47,$20,$88,$BC,$A0,$28,$B1,$9F,$A0,$16,$31
.byte $A1,$F0,$04,$06,$4A,$26,$4B,$A0,$28,$B1,$9F,$A0,$05,$31,$A1,$F0
.byte $04,$46,$4B,$66,$4A,$60,$20,$5A,$BD,$A0,$0C,$84,$50,$A0,$10,$84
.byte $51,$20,$1B,$BD,$A9,$5E,$20,$92,$BF,$A9,$EA,$20,$92,$BF,$4C,$7E
.byte $BE,$20,$7B,$BD,$A0,$0C,$4C,$79,$B5,$A0,$25,$B1,$9F,$85,$46,$C8
.byte $B1,$9F,$85,$44,$A9,$00,$85,$45,$20,$71,$AF,$29,$02,$F0,$04,$46

;; [$BE00 :: 0x33E00]

.byte $45,$66,$44,$4C,$2C,$BC,$A0,$03,$B1,$A1,$85,$46,$C8,$B1,$A1,$85
.byte $44,$A9,$00,$85,$45,$20,$76,$AF,$29,$02,$F0,$04,$46,$45,$66,$44
.byte $4C,$2C,$BC,$20,$E9,$BD,$A0,$28,$B1,$9F,$A0,$05,$31,$A1,$F0,$06
.byte $A9,$00,$85,$48,$85,$49,$A0,$28,$B1,$9F,$A0,$16,$31,$A1,$F0,$08
.byte $A5,$46,$85,$48,$A9,$00,$85,$49,$20,$8D,$B6,$20,$06,$BE,$A0,$28
.byte $B1,$9F,$A0,$05,$31,$A1,$F0,$08,$A5,$46,$85,$48,$A9,$00,$85,$49
.byte $A0,$28,$B1,$9F,$A0,$16,$31,$A1,$F0,$06,$A9,$00,$85,$48,$85,$49
.byte $4C,$06,$BB,$A5,$28,$29,$BF,$85,$28,$A9,$14,$20,$92,$BF,$A9,$00
.byte $85,$4A,$A9,$80,$85,$4B,$60,$6C,$46,$00,$71,$B5,$71,$B5,$95,$B5
.byte $A7,$B5,$A7,$B5,$13,$B6,$4F,$B6,$96,$B6,$CD,$B6,$CD,$B6,$CA,$B7
.byte $CD,$B6,$CD,$B6,$01,$B8,$41,$B8,$41,$B8,$78,$B8,$D2,$B8,$0B,$B9
.byte $AA,$B9,$AA,$B9,$40,$BA,$73,$BA,$8E,$BA,$B8,$BA,$0F,$BB,$1D,$BB
.byte $1D,$BB,$26,$BB,$8D,$BB,$D9,$BB,$DF,$BB,$FE,$BB,$0A,$BC

; Name	:
; Marks	:
	LDA #$00		; BECE	$A9 $00
	STA $AA			; BED0	$85 $AA
	LDA #$10		; BED2	$A9 $10
	STA $45			; BED4	$85 $45
	STA $44			; BED6	$85 $44
	LDA #$B2		; BED8	$A9 $B2
	STA $63			; BEDA	$85 $63
	LDA #$95		; BEDC	$A9 $95
	STA $62			; BEDE	$85 $62
	LDA msg_que,X		; BEE0	$BD $BA $7F
	BMI L33F3E		; BEE3	$30 $59
	CMP #$15		; BEE5	$C9 $15
	BNE L33F0D		; BEE7	$D0 $24
	LDA $E3			; BEE9	$A5 $E3
	AND #$7F		; BEEB	$29 $7F
	STA $64			; BEED	$85 $64
	LDA #$AC		; BEEF	$A9 $AC
	STA $63			; BEF1	$85 $63
	LDA #$44		; BEF3	$A9 $44
	STA $62			; BEF5	$85 $62
	LDX #$05		; BEF7	$A2 $05
	JSR $FD8C		; BEF9	$20 $8C $FD
	LDX $7CBF		; BEFC	$AE $BF $7C
	STX $AA			; BEFF	$86 $AA
	LDA #$B2		; BF01	$A9 $B2
	STA $63			; BF03	$85 $63
	LDA #$95		; BF05	$A9 $95
	STA $62			; BF07	$85 $62
	LDA #$15		; BF09	$A9 $15
	BNE L33F3C		; BF0B	$D0 $2F
L33F0D:
	CMP #$16		; BF0D	$C9 $16
	BNE L33F14		; BF0F	$D0 $03
	PHA			; BF11	$48
	BEQ L33F1D		; BF12	$F0 $09
L33F14:
	CMP #$17		; BF14	$C9 $17
	BNE L33F3C		; BF16	$D0 $24
	PHA			; BF18	$48
	LDA #$00		; BF19	$A9 $00
	STA $E3			; BF1B	$85 $E3
L33F1D:
	LDA $9E			; BF1D	$A5 $9E
	PHA			; BF1F	$48
	LDA $E3			; BF20	$A5 $E3
	STA $9E			; BF22	$85 $9E
	JSR $96E1		; BF24	$20 $E1 $96
;BF27
.byte $68,$85,$9E,$A0,$02,$A2,$00,$B1,$7A
.byte $9D,$47,$7D,$C8,$E8,$E0,$06,$D0,$F5,$86,$AA,$68
L33F3C:
	BNE L33F55		; BF3C	$D0 $17
L33F3E:
	AND #$7F		; BF3E	$29 $7F
	PHA			; BF40	$48
	DEC $AD			; BF41	$C6 $AD
	LDX $AD			; BF43	$A6 $AD
	LDA msg_que,X		; BF45	$BD $BA $7F
	STA $64			; BF48	$85 $64
	LDX #$05		; BF4A	$A2 $05
	JSR $FD8C		; BF4C	$20 $8C $FD
;BF4F
.byte $AE
.byte $BF,$7C,$86,$AA,$68
L33F55:
	STA $64			; BF55	$85 $64
	LDX #$05		; BF57	$A2 $05
	JMP $FD8C		; BF59	$4C $8C $FD
; End of

; Name	:
; Marks	:
	PHA			; BF5C	$48
	SEC			; BF5D	$38
	LDA $56			; BF5E	$A5 $56
	SBC #$08		; BF60	$E9 $08
	STA $5F			; BF62	$85 $5F
	ASL A			; BF64	$0A
	STA $5E			; BF65	$85 $5E
	ASL A			; BF67	$0A
	CLC			; BF68	$18
	ADC $5E			; BF69	$65 $5E
	ADC $5F			; BF6B	$65 $5F
	ADC #$19		; BF6D	$69 $19
	STA $5E			; BF6F	$85 $5E
	DEC $5E			; BF71	$C6 $5E
	LDY #$08		; BF73	$A0 $08
	PLA			; BF75	$68
	BEQ L33F90		; BF76	$F0 $18
L33F78:
	ASL A			; BF78	$0A
	INC $5E			; BF79	$E6 $5E
	BCC L33F8C		; BF7B	$90 $0F
	PHA			; BF7D	$48
	LDA $5E			; BF7E	$A5 $5E
	CMP #$33		; BF80	$C9 $33
	BNE L33F88		; BF82	$D0 $04
	PLA			; BF84	$68
	JMP $BF8C		; BF85	$4C $8C $BF
L33F88:
	JSR $BF92		; BF88	$20 $92 $BF
	PLA			; BF8B	$68
L33F8C:
	DEY			; BF8C	$88
	BNE L33F78		; BF8D	$D0 $E9
	RTS			; BF8F	$60
L33F90:
.byte $A9,$14

; Name	:
; Marks	:
	LDX $AD			; BF92	$A6 $AD
	STA msg_que,X		; BF94	$9D $BA $7F
	INC $AD			; BF97	$E6 $AD
	RTS			; BF99	$60
; End of

; Name	:
; Marks	:
	LDA msg_que		; BF9A	$AD $BA $7F
	CMP #$14		; BF9D	$C9 $14
	BEQ L33FBD		; BF9F	$F0 $1C
	LDY #$0A		; BFA1	$A0 $0A
	LDA ($A1),Y		; BFA3	$B1 $A1		current hp L
	INY			; BFA5	$C8
	ORA ($A1),Y		; BFA6	$11 $A1		current hp H
	BNE L33FBD		; BFA8	$D0 $13
	LDY #$12		; BFAA	$A0 $12
	LDA ($A1),Y		; BFAC	$B1 $A1		intellect
	BNE L33FB4		; BFAE	$D0 $04
	LDA #$15		; BFB0	$A9 $15
	BNE L33FB6		; BFB2	$D0 $02
L33FB4:
	LDA #$16		; BFB4	$A9 $16
L33FB6:
	LDX $AD			; BFB6	$A6 $AD
	STA msg_que,X		; BFB8	$9D $BA $7F
	INC $AD			; BFBB	$E6 $AD
L33FBD:
	RTS			; BFBD	$60
; End of

.byte $90,$58
.byte $90,$F0,$90,$00,$FF
;; $BFC5 - data block: OAM X, Y position ( cursor ?? )
.byte $C0,$A8,$C0,$B8,$C0,$C8,$C0,$D8,$48,$B8,$48
.byte $D8,$A0,$B8,$A0,$C8,$08,$A8,$08,$B8,$08,$C8,$08,$D8,$30,$A8,$30
.byte $B8,$30,$C8,$30,$D8,$58,$A8,$58,$B8,$58,$C8,$58,$D8,$80,$A8,$80
.byte $B8,$80,$C8,$80,$D8,$5A,$94,$86,$94,$44,$9D,$78,$9F,$9F,$9F,$9F
; ========== battle main code ($8F43-$BFFF) END ==========
