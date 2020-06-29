
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

Msg1	DB	"s.m_int1 = %d, s.m_int2 = %d",00Ah,0
Msg2	DB	"v[0] = %d, v[1] = %d",00Ah,0
Msg3	DB	"argc = %d",00Ah,0
Msg4	DB	"argv[1] = ",0

.code
main	proc	c	public	uses EBX EDI ESI,	argc:SDWORD, argv:PTR PTR BYTE

		;-----------------------
		;ローカル変数
		local	s:stest
		local	v[2]:SDWORD

		;-----------------------
		;コード

		invoke	printf,	offset Msg

		mov		s.m_int1, 10
		mov		s.m_int2, -20

		invoke	printf,	offset Msg1, s.m_int1, s.m_int2

		mov		v[sizeof(SDWORD) * 0], -1234567
		mov		v[sizeof(SDWORD) * 1], 7654321

		invoke	printf,	offset Msg2, v[0], v[4]

		invoke	printf,	offset Msg3, argc

		mov		ebx, argv
		invoke	printf,	offset Msg4
		invoke	printf, [ebx + sizeof(DWORD) * 1]

		mov		eax, 0

		ret

main	ENDP

		END
