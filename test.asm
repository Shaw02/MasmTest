
	.586p
	.model	flat,C

;===============================================================|
;Visual C++ 2019で printf() を使うには、このライブラリが必要

	INCLUDELIB	legacy_stdio_definitions.lib

;===============================================================|
;		プロトタイプ宣言				*
;===============================================================|

printf	proto	stPrint:ptr
exit	proto	iCode:dword

main	proto	argc:SDWORD, argv:PTR BYTE

;===============================================================|
;		main		
;---------------------------------------------------------------|
;	●引数	
;		argc:SDWORD
;		argv:PTR BYTE
;	●引数	
;		SDWORD
;===============================================================|
.const

Msg		DB	"Hello World",0

.code
main	proc	c	public	uses EBX EDI ESI,	argc:SDWORD, argv:PTR BYTE
	.safeseh	main

	local	var[16]:BYTE

	invoke	printf,	offset Msg

	invoke	exit,	0

	ret

main	ENDP

;	.startup
;
;	invoke	main
;
;	.exit	0

	END
