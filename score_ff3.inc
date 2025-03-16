DUTY_1_8     = $F5
DUTY_1_4     = $F6
DUTY_1_2     = $F7
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
FCh, +a : repeat end
FDh, +a : volta repeat
FEh, +a : jump
FFh : end of script
.endif
