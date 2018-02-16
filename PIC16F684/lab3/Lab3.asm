
_main:

;Lab3.mbas,7 :: 		main:
;Lab3.mbas,8 :: 		TRISA = $01
	MOVLW      1
	MOVWF      TRISA+0
;Lab3.mbas,9 :: 		cmcon0=0            'comparators off
	CLRF       CMCON0+0
;Lab3.mbas,10 :: 		ANSEL=$01
	MOVLW      1
	MOVWF      ANSEL+0
;Lab3.mbas,11 :: 		ADCON0=$80          'right justified
	MOVLW      128
	MOVWF      ADCON0+0
;Lab3.mbas,12 :: 		ADCON1=$70          'set clock frequency
	MOVLW      112
	MOVWF      ADCON1+0
;Lab3.mbas,13 :: 		TRISC = 0
	CLRF       TRISC+0
;Lab3.mbas,14 :: 		PORTC=$FF           'initial value
	MOVLW      255
	MOVWF      PORTC+0
;Lab3.mbas,15 :: 		PWM1_Init(1000)     'initializes PWM module, freq = 1kHz.
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Lab3.mbas,16 :: 		PWM1_Start          'starts PWM
	CALL       _PWM1_Start+0
;Lab3.mbas,18 :: 		While true
L__main2:
;Lab3.mbas,19 :: 		data1 = adc_read(0)         'Reading adc
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _data1+0
	MOVF       R0+1, 0
	MOVWF      _data1+1
;Lab3.mbas,20 :: 		vadc = (5*data1)/1023       'Converting
	MOVLW      0
	MOVWF      R0+2
	MOVWF      R0+3
	MOVLW      5
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	CALL       _Longword2Double+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      192
	MOVWF      R4+1
	MOVLW      127
	MOVWF      R4+2
	MOVLW      136
	MOVWF      R4+3
	CALL       _Div_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _vadc+0
	MOVF       R0+1, 0
	MOVWF      _vadc+1
	MOVF       R0+2, 0
	MOVWF      _vadc+2
	MOVF       R0+3, 0
	MOVWF      _vadc+3
;Lab3.mbas,21 :: 		dc1 = 951.1-190.3*vadc      'Calculated conversion
	MOVLW      205
	MOVWF      R4+0
	MOVLW      76
	MOVWF      R4+1
	MOVLW      62
	MOVWF      R4+2
	MOVLW      134
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      102
	MOVWF      R0+0
	MOVLW      198
	MOVWF      R0+1
	MOVLW      109
	MOVWF      R0+2
	MOVLW      136
	MOVWF      R0+3
	CALL       _Sub_32x32_FP+0
	MOVF       R0+0, 0
	MOVWF      _dc1+0
	MOVF       R0+1, 0
	MOVWF      _dc1+1
	MOVF       R0+2, 0
	MOVWF      _dc1+2
	MOVF       R0+3, 0
	MOVWF      _dc1+3
;Lab3.mbas,22 :: 		PWM1_Set_Duty(dc1)          'Setting PWM
	CALL       _Double2Byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Lab3.mbas,23 :: 		Delay_ms(100)
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L__main6:
	DECFSZ     R13+0, 1
	GOTO       L__main6
	DECFSZ     R12+0, 1
	GOTO       L__main6
	NOP
	NOP
;Lab3.mbas,24 :: 		wend
	GOTO       L__main2
L_end_main:
	GOTO       $+0
; end of _main
