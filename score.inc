; Pitch example
;	  XYh ~ XYh: X = pitch, Y = length(0=longest, F=shortest)
;	   0Yh=C, 2Yh=D, 4Yh=E, 5Yh=F, 8Yh=G, 9Yh=A, BYh=B
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
;		APBEDD:
;		APBEF9:
;	  F7h,F8h,F9h,FAh,FBh: loop counter(?, 2, 3, 4. 5)
;	  FCh: repeat - if loop count is exist
;	  FDh: repeat - ??
;	  FEh: repeat
;	  FFh: stop

D1	= $00
D3_4	= $01
D1_2	= $02
D3_8	= $03
D1_3	= $04
D1_4	= $05
D3_16	= $06
D1_6	= $07
D1_8	= $08
D3_32	= $09
D1_12	= $0A
D1_16	= $0B
D1_24	= $0C
D1_32	= $0D
D1_48	= $0E
D1_96	= $0F

DH1	= $10
DH3_4	= $11
DH1_2	= $12
DH3_8	= $13
DH1_3	= $14
DH1_4	= $15
DH3_16	= $16
DH1_6	= $17
DH1_8	= $18
DH3_32	= $19
DH1_12	= $1A
DH1_16	= $1B
DH1_24	= $1C
DH1_32	= $1D
DH1_48	= $1E
DH1_96	= $1F

R1	= $20
R3_4	= $21
R1_2	= $22
R3_8	= $23
R1_3	= $24
R1_4	= $25
R3_16	= $26
R1_6	= $27
R1_8	= $28
R3_32	= $29
R1_12	= $2A
R1_16	= $2B
R1_24	= $2C
R1_32	= $2D
R1_48	= $2E
R1_96	= $2F

M1	= $40
M3_4	= $41
M1_2	= $42
M3_8	= $43
M1_3	= $44
M1_4	= $45
M3_16	= $46
M1_6	= $47
M1_8	= $48
M3_32	= $49
M1_12	= $4A
M1_16	= $4B
M1_24	= $4C
M1_32	= $4D
M1_48	= $4E
M1_96	= $4F

F1	= $50
F3_4	= $51
F1_2	= $52
F3_8	= $53
F1_3	= $54
F1_4	= $55
F3_16	= $56
F1_6	= $57
F1_8	= $58
F3_32	= $59
F1_12	= $5A
F1_16	= $5B
F1_24	= $5C
F1_32	= $5D
F1_48	= $5E
F1_96	= $5F

FH1	= $60
FH3_4	= $61
FH1_2	= $62
FH3_8	= $63
FH1_3	= $64
FH1_4	= $65
FH3_16	= $66
FH1_6	= $67
FH1_8	= $68
FH3_32	= $69
FH1_12	= $6A
FH1_16	= $6B
FH1_24	= $6C
FH1_32	= $6D
FH1_48	= $6E
FH1_96	= $6F

S1	= $70
S3_4	= $71
S1_2	= $72
S3_8	= $73
S1_3	= $74
S1_4	= $75
S3_16	= $76
S1_6	= $77
S1_8	= $78
S3_32	= $79
S1_12	= $7A
S1_16	= $7B
S1_24	= $7C
S1_32	= $7D
S1_48	= $7E
S1_96	= $7F

SH1	= $80
SH3_4	= $81
SH1_2	= $82
SH3_8	= $83
SH1_3	= $84
SH1_4	= $85
SH3_16	= $86
SH1_6	= $87
SH1_8	= $88
SH3_32	= $89
SH1_12	= $8A
SH1_16	= $8B
SH1_24	= $8C
SH1_32	= $8D
SH1_48	= $8E
SH1_96	= $8F

L1	= $90
L3_4	= $91
L1_2	= $92
L3_8	= $93
L1_3	= $94
L1_4	= $95
L3_16	= $96
L1_6	= $97
L1_8	= $98
L3_32	= $99
L1_12	= $9A
L1_16	= $9B
L1_24	= $9C
L1_32	= $9D
L1_48	= $9E
L1_96	= $9F

LH1	= $A0
LH3_4	= $A1
LH1_2	= $A2
LH3_8	= $A3
LH1_3	= $A4
LH1_4	= $A5
LH3_16	= $A6
LH1_6	= $A7
LH1_8	= $A8
LH3_32	= $A9
LH1_12	= $AA
LH1_16	= $AB
LH1_24	= $AC
LH1_32	= $AD
LH1_48	= $AE
LH1_96	= $AF

C1	= $B0
C3_4	= $B1
C1_2	= $B2
C3_8	= $B3
C1_3	= $B4
C1_4	= $B5
C3_16	= $B6
C1_6	= $B7
C1_8	= $B8
C3_32	= $B9
C1_12	= $BA
C1_16	= $BB
C1_24	= $BC
C1_32	= $BD
C1_48	= $BE
C1_96	= $BF

X1	= $C0
X3_4	= $C1
X1_2	= $C2
X3_8	= $C3
X1_3	= $C4
X1_4	= $C5
X3_16	= $C6
X1_6	= $C7
X1_8	= $C8
X3_32	= $C9
X1_12	= $CA
X1_16	= $CB
X1_24	= $CC
X1_32	= $CD
X1_48	= $CE
X1_96	= $CF

A1	= $D0
A3_4	= $D1
A1_2	= $D2
A3_8	= $D3
A1_3	= $D4
A1_4	= $D5
A3_16	= $D6
A1_6	= $D7
A1_8	= $D8
A3_32	= $D9
A1_12	= $DA
A1_16	= $DB
A1_24	= $DC
A1_32	= $DD
A1_48	= $DE
A1_96	= $DF

TEMPO	= $E0

VOL1	= $E1
VOL2	= $E2
VOL3	= $E3
VOL4	= $E4
VOL5	= $E5
VOL6	= $E6
VOL7	= $E7
VOL8	= $E8
VOL9	= $E9
VOL10	= $EA
VOL11	= $EB
VOL12	= $EC
VOL13	= $ED
VOL14	= $EE
VOL15	= $EF

OT0	= $F0
OT1	= $F1
OT2	= $F2
OT3	= $F3
OT4	= $F4
OT5	= $F5

SET_P3	= $F6

REPEAT	= $FE

; Duty(DDLC VVVV(Duty/Constant/Volume,envelope) APU $4000,$4004)
;  D18 = 1/8 12.5%
;  D14 = 1/4 25%
;  D12 = 1/2 50%
;  D34 = 3/4 75%(negative)
; Infinite play / One-shot
;  I = Infinite play
;  O = One-shot
; Constant / envelope Lowering
;  C = Constant
;  L = Lowering
; Volume
;  V0 -  V15 = Volume(0-15)
D18ICV15	= $3F
D14ICV15	= $7F
D12ICV00	= $B0
D12ICV15	= $BF
D12OCV15	= $AF
D12OLV15	= $9F
D34ICV15	= $CF
