.if FF3_DRIVER
VOL2	= $E1
VOL3	= $E2
VOL4	= $E3
VOL5	= $E4
VOL6	= $E5
VOL7	= $E6
VOL8	= $E7
VOL9	= $E8
VOL10	= $E9
VOL11	= $EA
VOL12	= $EB
VOL13	= $EC
VOL14	= $ED
VOL15	= $EE

OT0	= $EF
OT1	= $F0
OT2	= $F1
OT3	= $F2
OT4	= $F3
OT5	= $F4
.endif

DUTY_1_8     = $F5
DUTY_1_4     = $F6
DUTY_1_2     = $F7

BACK_CNT     = $FB
.if 0
[format]
script pointer 5ch (10 bytes)
00h-DFh : note
E0h b1 : tempo
E1h-EEh : vol
EFh-F4h : oct(0-5)
F5h b1 b2 : set env 1/8(duty), b1 = volume envelope table number, b2 = pitch envelope table number
F6h b1 b2 : set env 1/4(duty), b1 = volume envelope table number, b2 = pitch envelope table number
F7h b1 b2 : set env 1/2(duty), b1 = volume envelope table number, b2 = pitch envelope table number
F8h b1 : sweep
F9h : hi-hat preset
FAh : snare drum preset
FBh b1 : repeat start
FCh, +a : repeat end
FDh, +a : volta repeat
FEh, +a : jump
FFh : end of script
.endif
