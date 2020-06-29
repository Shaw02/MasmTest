
	.586p
	.model	flat,C

;===============================================================|
;Visual Studio 2015 以降で printf() を使うには、このライブラリが必要

	INCLUDELIB	legacy_stdio_definitions.lib

;===============================================================|
;		プロトタイプ宣言
;===============================================================|

printf	proto	stPrint:ptr, arg:VARARG
exit	proto	iCode:dword
main	proto	argc:SDWORD, argv:PTR PTR BYTE


;===============================================================|
;		構造体の定義
;===============================================================|
stest	struc
m_int1	dd		?
m_int2	dd		?
stest	ends

;===============================================================|
;		main		
;---------------------------------------------------------------|
;	●引数	
;		argc:SDWORD			:	int		argc
;		argv:PTR PTR BYTE	:	char	*argv[]
;	●引数	
;		SDWORD				：	int
;===============================================================|
.const

;	アセンブラは、"\n"など、エスケープシーケンスは使えないので、直接、コードを書く。
Msg		DB	"Hello World.",00Ah,00Ah, 0

Msg1	DB	"s.m_int1 = %d,",00Ah,"s.m_int2 = %d",00Ah,0
Msg2	DB	"v[0] = %d,",00Ah,"v[1] = %d",00Ah,0

MsgArg	DB	"argv[%d] = ",0
MsgCR	DB	00Ah,0

.code
main	proc	c	public	uses EBX EDI ESI,	argc:SDWORD, argv:PTR PTR BYTE

		;-----------------------
		;ローカル変数
		local	s:stest
		local	v[2]:SDWORD

		;-----------------------
		;コード

		invoke	printf,	offset MsgCR
		invoke	printf,	offset Msg

		mov		s.m_int1, 10
		mov		s.m_int2, -20

		invoke	printf,	offset Msg1, s.m_int1, s.m_int2
		invoke	printf,	offset MsgCR

		mov		v[sizeof(SDWORD) * 0], -1234567
		mov		v[sizeof(SDWORD) * 1], 7654321

		invoke	printf,	offset Msg2, v[sizeof(SDWORD) * 0], v[sizeof(SDWORD) * 1]
		invoke	printf,	offset MsgCR

		mov		ebx, argv
		xor		edi, edi

		.while	(edi < argc)

			;		printf("argv[%d] = ", edi);
			invoke	printf,	offset MsgArg, edi

			;		printf(argv[edi]);
			invoke	printf, [ebx + edi * sizeof(DWORD)]

			;		printf("\n");
			invoke	printf,	offset MsgCR

			;		edi++
			inc		edi

		.endw

		;	return(0);
		mov		eax, 0

		ret

main	ENDP

		END
