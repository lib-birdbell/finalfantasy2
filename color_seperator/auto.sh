#!/bin/sh
count=1
COLOR_ARR="00f8adcb 00f8a1c6 00f89cc2 00f894be 00f89fc5 00f895bf 00f8bcd6 00f8a2c6 00f89dc3 00f8accc 00f8afcc 00f8b1ce 00f8a9c9 00f8a4c8 00f88fbb 00f8b3d0 00f8b5d2 00f8bbd5 00f89bc1 00f8bed7 00f8aecc 00f8b6d2 00f8bad4 00f8aaca 00f8aac9 00f8a5c7 00f88fbc 00f8d1e2 00f8a2c5 00f8b0cd 00f8b7d2 00f8b3cf 00f8abca 00f8b2cf 00f8b9d4 00f8a4c6 00f8bfd7 00f8bed6 00f8b9d3 00f8b6d1 00f891bd 00f88cba 00f88ab9 00f88bba 00f8a5c6 00f8b4d0 00f88ebb 00f892bd 00f898c0 00f89ec3 00f8afcd 00f8d1e1 00f8a8c8 00f888b8 00f8d2e2"
REF_VAL=16306400
set -- $COLOR_ARR
while [ -n "$1" ];
do
	./color_seperator.out -c "$((0x$1))" "$REF_VAL"
	shift
done
# 1> f8f8f8 : 16316664(white)
# 4> f8e0f0 : 16310512(more bright pink)
# 2> f8d0e0 : 16306400(bright pink)
# 3> e85098 : 15224984(pink)
