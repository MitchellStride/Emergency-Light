
_main:

;LED Test Project.mbas,25 :: 		main:
;LED Test Project.mbas,28 :: 		TRISA = $07   'RA7-RA0
	MOVLW      7
	MOVWF      TRISA+0
;LED Test Project.mbas,29 :: 		TRISC = $01   'RC7-RC0
	MOVLW      1
	MOVWF      TRISC+0
;LED Test Project.mbas,30 :: 		PORTA = $00   'RA7-RA0
	CLRF       PORTA+0
;LED Test Project.mbas,31 :: 		PORTC = $00   'RC7-RC0
	CLRF       PORTC+0
;LED Test Project.mbas,33 :: 		cmcon0 = $00    'Turn Comparators Off
	CLRF       CMCON0+0
;LED Test Project.mbas,36 :: 		ANSEL = $0F
	MOVLW      15
	MOVWF      ANSEL+0
;LED Test Project.mbas,37 :: 		ADCON0 = $80
	MOVLW      128
	MOVWF      ADCON0+0
;LED Test Project.mbas,38 :: 		ADCON1 = $70
	MOVLW      112
	MOVWF      ADCON1+0
;LED Test Project.mbas,40 :: 		while true
L__main2:
;LED Test Project.mbas,42 :: 		PORTC.3 = 1
	BSF        PORTC+0, 3
;LED Test Project.mbas,43 :: 		PORTC.2 = 1
	BSF        PORTC+0, 2
;LED Test Project.mbas,44 :: 		delay_ms(1000)
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L__main6:
	DECFSZ     R13+0, 1
	GOTO       L__main6
	DECFSZ     R12+0, 1
	GOTO       L__main6
	DECFSZ     R11+0, 1
	GOTO       L__main6
	NOP
	NOP
;LED Test Project.mbas,45 :: 		PORTC.3 = 0
	BCF        PORTC+0, 3
;LED Test Project.mbas,46 :: 		PORTC.2 = 0
	BCF        PORTC+0, 2
;LED Test Project.mbas,47 :: 		delay_ms(1000)
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L__main7:
	DECFSZ     R13+0, 1
	GOTO       L__main7
	DECFSZ     R12+0, 1
	GOTO       L__main7
	DECFSZ     R11+0, 1
	GOTO       L__main7
	NOP
	NOP
;LED Test Project.mbas,49 :: 		wend
	GOTO       L__main2
L_end_main:
	GOTO       $+0
; end of _main
