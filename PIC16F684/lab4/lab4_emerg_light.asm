
_main:

;lab4_emerg_light.mbas,25 :: 		main:
;lab4_emerg_light.mbas,28 :: 		TRISA = %00000111   'RA7-RA0
	MOVLW      7
	MOVWF      TRISA+0
;lab4_emerg_light.mbas,29 :: 		TRISC = %00000001   'RC7-RC0
	MOVLW      1
	MOVWF      TRISC+0
;lab4_emerg_light.mbas,30 :: 		PORTA = %00000000   'RA7-RA0
	CLRF       PORTA+0
;lab4_emerg_light.mbas,31 :: 		PORTC = %00000000   'RC7-RC0
	CLRF       PORTC+0
;lab4_emerg_light.mbas,33 :: 		cmcon0 = 0    'Turn Comparators Off
	CLRF       CMCON0+0
;lab4_emerg_light.mbas,36 :: 		ANSEL = $0F
	MOVLW      15
	MOVWF      ANSEL+0
;lab4_emerg_light.mbas,37 :: 		ADCON0 = $80
	MOVLW      128
	MOVWF      ADCON0+0
;lab4_emerg_light.mbas,38 :: 		ADCON1 = $70
	MOVLW      112
	MOVWF      ADCON1+0
;lab4_emerg_light.mbas,41 :: 		PWM1_Init(1000)
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	BSF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;lab4_emerg_light.mbas,42 :: 		PWM1_Start
	CALL       _PWM1_Start+0
;lab4_emerg_light.mbas,44 :: 		PORTC.3 = 0' Turn Light Off
	BCF        PORTC+0, 3
;lab4_emerg_light.mbas,46 :: 		while true
L__main2:
;lab4_emerg_light.mbas,48 :: 		pwm_data = adc_read(0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _Word2Double+0
	MOVF       R0+0, 0
	MOVWF      _pwm_data+0
	MOVF       R0+1, 0
	MOVWF      _pwm_data+1
	MOVF       R0+2, 0
	MOVWF      _pwm_data+2
	MOVF       R0+3, 0
	MOVWF      _pwm_data+3
;lab4_emerg_light.mbas,49 :: 		pwm_vadc = (5*pwm_data)/1023
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
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
	MOVWF      _pwm_vadc+0
	MOVF       R0+1, 0
	MOVWF      _pwm_vadc+1
	MOVF       R0+2, 0
	MOVWF      _pwm_vadc+2
	MOVF       R0+3, 0
	MOVWF      _pwm_vadc+3
;lab4_emerg_light.mbas,50 :: 		pwm_dutyCycle = 951.1-(190.3*pwm_vadc)
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
	MOVWF      _pwm_dutyCycle+0
	MOVF       R0+1, 0
	MOVWF      _pwm_dutyCycle+1
	MOVF       R0+2, 0
	MOVWF      _pwm_dutyCycle+2
	MOVF       R0+3, 0
	MOVWF      _pwm_dutyCycle+3
;lab4_emerg_light.mbas,52 :: 		rectified_data = adc_read(1)
	MOVLW      1
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _Word2Double+0
	MOVF       R0+0, 0
	MOVWF      _rectified_data+0
	MOVF       R0+1, 0
	MOVWF      _rectified_data+1
	MOVF       R0+2, 0
	MOVWF      _rectified_data+2
	MOVF       R0+3, 0
	MOVWF      _rectified_data+3
;lab4_emerg_light.mbas,53 :: 		rectified_vadc = (5*rectified_data)/1023
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
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
	MOVWF      _rectified_vadc+0
	MOVF       R0+1, 0
	MOVWF      _rectified_vadc+1
	MOVF       R0+2, 0
	MOVWF      _rectified_vadc+2
	MOVF       R0+3, 0
	MOVWF      _rectified_vadc+3
;lab4_emerg_light.mbas,55 :: 		light_data = adc_read(2)
	MOVLW      2
	MOVWF      FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	CALL       _Word2Double+0
	MOVF       R0+0, 0
	MOVWF      _light_data+0
	MOVF       R0+1, 0
	MOVWF      _light_data+1
	MOVF       R0+2, 0
	MOVWF      _light_data+2
	MOVF       R0+3, 0
	MOVWF      _light_data+3
;lab4_emerg_light.mbas,56 :: 		light_vadc = (5*light_data)/1023
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      32
	MOVWF      R4+2
	MOVLW      129
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
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
	MOVWF      _light_vadc+0
	MOVF       R0+1, 0
	MOVWF      _light_vadc+1
	MOVF       R0+2, 0
	MOVWF      _light_vadc+2
	MOVF       R0+3, 0
	MOVWF      _light_vadc+3
;lab4_emerg_light.mbas,58 :: 		if PORTC.0 = 1 then   'Read Switch, if not pushed
	BTFSS      PORTC+0, 0
	GOTO       L__main7
;lab4_emerg_light.mbas,59 :: 		if rectified_vadc > 3 then   'Rectified voltage available
	MOVF       _rectified_vadc+0, 0
	MOVWF      R4+0
	MOVF       _rectified_vadc+1, 0
	MOVWF      R4+1
	MOVF       _rectified_vadc+2, 0
	MOVWF      R4+2
	MOVF       _rectified_vadc+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      64
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main10
;lab4_emerg_light.mbas,60 :: 		PWM1_Set_Duty(pwm_dutyCycle)    'Set duty cycle
	MOVF       _pwm_dutyCycle+0, 0
	MOVWF      R0+0
	MOVF       _pwm_dutyCycle+1, 0
	MOVWF      R0+1
	MOVF       _pwm_dutyCycle+2, 0
	MOVWF      R0+2
	MOVF       _pwm_dutyCycle+3, 0
	MOVWF      R0+3
	CALL       _Double2Byte+0
	MOVF       R0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;lab4_emerg_light.mbas,61 :: 		PORTC.2 = 0                     'Low Battery LED OFF
	BCF        PORTC+0, 2
;lab4_emerg_light.mbas,62 :: 		PORTC.1 = 1                     'Battery Charging LED ON
	BSF        PORTC+0, 1
;lab4_emerg_light.mbas,63 :: 		PORTC.3 = 0                     'Light OFF
	BCF        PORTC+0, 3
	GOTO       L__main11
;lab4_emerg_light.mbas,65 :: 		else                          'Rectified voltage not available
L__main10:
;lab4_emerg_light.mbas,66 :: 		if pwm_vadc > 3.83 then         'Battery is operational
	MOVF       _pwm_vadc+0, 0
	MOVWF      R4+0
	MOVF       _pwm_vadc+1, 0
	MOVWF      R4+1
	MOVF       _pwm_vadc+2, 0
	MOVWF      R4+2
	MOVF       _pwm_vadc+3, 0
	MOVWF      R4+3
	MOVLW      184
	MOVWF      R0+0
	MOVLW      30
	MOVWF      R0+1
	MOVLW      117
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main13
;lab4_emerg_light.mbas,67 :: 		if light_vadc > 2.5 then     'Dark Room
	MOVF       _light_vadc+0, 0
	MOVWF      R4+0
	MOVF       _light_vadc+1, 0
	MOVWF      R4+1
	MOVF       _light_vadc+2, 0
	MOVWF      R4+2
	MOVF       _light_vadc+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVLW      32
	MOVWF      R0+2
	MOVLW      128
	MOVWF      R0+3
	CALL       _Compare_Double+0
	MOVLW      255
	BTFSC      STATUS+0, 0
	MOVLW      0
	MOVWF      R0+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main16
;lab4_emerg_light.mbas,68 :: 		PORTC.1 = 0               'Battery Charging LED OFF
	BCF        PORTC+0, 1
;lab4_emerg_light.mbas,69 :: 		PORTC.3 = 1               'Light ON
	BSF        PORTC+0, 3
	GOTO       L__main17
;lab4_emerg_light.mbas,70 :: 		else                         'Light Room
L__main16:
;lab4_emerg_light.mbas,71 :: 		PORTC.1 = 0               'Battery Charging LED OFF
	BCF        PORTC+0, 1
;lab4_emerg_light.mbas,72 :: 		PORTC.3 = 0               'Light OFF
	BCF        PORTC+0, 3
;lab4_emerg_light.mbas,73 :: 		end if
L__main17:
	GOTO       L__main14
;lab4_emerg_light.mbas,74 :: 		else                            'Battery is NOT operational
L__main13:
;lab4_emerg_light.mbas,75 :: 		PORTC.2 = 1                  'Low Battery LED ON
	BSF        PORTC+0, 2
;lab4_emerg_light.mbas,76 :: 		PORTC.1 = 0                  'Battery Charging LED ON
	BCF        PORTC+0, 1
;lab4_emerg_light.mbas,77 :: 		PORTC.3 = 0                  'Light OFF
	BCF        PORTC+0, 3
;lab4_emerg_light.mbas,78 :: 		end if
L__main14:
;lab4_emerg_light.mbas,79 :: 		end if
L__main11:
	GOTO       L__main8
;lab4_emerg_light.mbas,81 :: 		else                            'If Switch is pushed
L__main7:
;lab4_emerg_light.mbas,82 :: 		PORTC.3 = 0                 'Light ON
	BCF        PORTC+0, 3
;lab4_emerg_light.mbas,83 :: 		PORTC.1 = 1                 'Battery Charging LED OFF
	BSF        PORTC+0, 1
;lab4_emerg_light.mbas,84 :: 		end if
L__main8:
;lab4_emerg_light.mbas,86 :: 		delay_ms(1000)                  'Delay a second
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L__main18:
	DECFSZ     R13+0, 1
	GOTO       L__main18
	DECFSZ     R12+0, 1
	GOTO       L__main18
	DECFSZ     R11+0, 1
	GOTO       L__main18
	NOP
	NOP
;lab4_emerg_light.mbas,87 :: 		wend
	GOTO       L__main2
L_end_main:
	GOTO       $+0
; end of _main
