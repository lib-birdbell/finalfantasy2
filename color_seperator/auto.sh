#!/bin/sh
count=1
COLOR_ARR="00f39fc8 00f392c0 00f391be 00f398c4 00f39cc4 00f396c3 00f399c2 00f397c2 00f39fc5 00f39dc4 00f39cc3 00f39fc7 00f380b4 00f383b7 00f386b8 00f382b6 00f38eba 00f38aba 00f389b9 00f38dbe 00f38dbc 00f38fbd 00f388b8 00f386b7 00f379b1 00f373ae 00f378b0 00f373ad 00f37cb3 00f377ae 00f375ae 00f376af 00f376ae 00f37fb4 00f375af 00f374ae"
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
