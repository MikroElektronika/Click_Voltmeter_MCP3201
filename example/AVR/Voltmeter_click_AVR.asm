
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Voltmeter_click_AVR.c,19 :: 		void main()
;Voltmeter_click_AVR.c,21 :: 		system_setup();
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	PUSH       R6
	PUSH       R7
	CALL       _system_setup+0
;Voltmeter_click_AVR.c,23 :: 		UART1_Write_Text( "Entering While Loop...\r\n" );
	LDI        R27, #lo_addr(?lstr1_Voltmeter_click_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr1_Voltmeter_click_AVR+0)
	MOV        R3, R27
	CALL       _UART1_Write_Text+0
;Voltmeter_click_AVR.c,25 :: 		while (1) {
L_main0:
;Voltmeter_click_AVR.c,27 :: 		voltage = 0;
	LDI        R27, 0
	STS        _voltage+0, R27
	STS        _voltage+1, R27
	STS        _voltage+2, R27
	STS        _voltage+3, R27
;Voltmeter_click_AVR.c,29 :: 		measurement = getADC()/2;        // Get ADC result
	CALL       _getADC+0
	LSR        R17
	ROR        R16
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	STS        _measurement+0, R16
	STS        _measurement+1, R17
	STS        _measurement+2, R18
	STS        _measurement+3, R19
;Voltmeter_click_AVR.c,30 :: 		voltage = (measurement - calibration)*33.3405;
	LDS        R16, _calibration+0
	LDS        R17, _calibration+1
	LDI        R18, 0
	MOV        R19, R18
	CALL       _float_ulong2fp+0
	MOVW       R20, R16
	MOVW       R22, R18
	LDS        R16, _measurement+0
	LDS        R17, _measurement+1
	LDS        R18, _measurement+2
	LDS        R19, _measurement+3
	CALL       _float_fpsub1+0
	LDI        R20, 172
	LDI        R21, 92
	LDI        R22, 5
	LDI        R23, 66
	CALL       _float_fpmul1+0
	STS        _voltage+0, R16
	STS        _voltage+1, R17
	STS        _voltage+2, R18
	STS        _voltage+3, R19
;Voltmeter_click_AVR.c,32 :: 		FloatToStr(voltage, txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R6, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R7, R27
	MOVW       R2, R16
	MOVW       R4, R18
	CALL       _FloatToStr+0
;Voltmeter_click_AVR.c,34 :: 		UART1_Write_Text(txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R2, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R3, R27
	CALL       _UART1_Write_Text+0
;Voltmeter_click_AVR.c,35 :: 		UART1_Write(32);
	LDI        R27, 32
	MOV        R2, R27
	CALL       _UART1_Write+0
;Voltmeter_click_AVR.c,36 :: 		UART1_Write_Text("mV");
	LDI        R27, #lo_addr(?lstr2_Voltmeter_click_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr2_Voltmeter_click_AVR+0)
	MOV        R3, R27
	CALL       _UART1_Write_Text+0
;Voltmeter_click_AVR.c,37 :: 		UART1_Write(13);
	LDI        R27, 13
	MOV        R2, R27
	CALL       _UART1_Write+0
;Voltmeter_click_AVR.c,38 :: 		UART1_Write(10);
	LDI        R27, 10
	MOV        R2, R27
	CALL       _UART1_Write+0
;Voltmeter_click_AVR.c,40 :: 		delay_ms(1000);                //Za test moze sa delay da se resi sample rate, za ozbiljnije interrupt + TMR
	LDI        R18, 41
	LDI        R17, 150
	LDI        R16, 128
L_main2:
	DEC        R16
	BRNE       L_main2
	DEC        R17
	BRNE       L_main2
	DEC        R18
	BRNE       L_main2
;Voltmeter_click_AVR.c,41 :: 		}
	JMP        L_main0
;Voltmeter_click_AVR.c,42 :: 		}
L_end_main:
	POP        R7
	POP        R6
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_system_setup:

;Voltmeter_click_AVR.c,44 :: 		void system_setup( void )
;Voltmeter_click_AVR.c,46 :: 		Chip_Select_DIR = 1;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	IN         R27, DDA5_bit+0
	SBR        R27, BitMask(DDA5_bit+0)
	OUT        DDA5_bit+0, R27
;Voltmeter_click_AVR.c,48 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	LDI        R27, 51
	OUT        UBRRL+0, R27
	LDI        R27, 0
	OUT        UBRRH+0, R27
	CALL       _UART1_Init+0
;Voltmeter_click_AVR.c,49 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_system_setup4:
	DEC        R16
	BRNE       L_system_setup4
	DEC        R17
	BRNE       L_system_setup4
	DEC        R18
	BRNE       L_system_setup4
	NOP
	NOP
;Voltmeter_click_AVR.c,50 :: 		UART1_Write_Text( "UART Initialized\r\n" );
	LDI        R27, #lo_addr(?lstr3_Voltmeter_click_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr3_Voltmeter_click_AVR+0)
	MOV        R3, R27
	CALL       _UART1_Write_Text+0
;Voltmeter_click_AVR.c,52 :: 		voltage = 0;
	LDI        R27, 0
	STS        _voltage+0, R27
	STS        _voltage+1, R27
	STS        _voltage+2, R27
	STS        _voltage+3, R27
;Voltmeter_click_AVR.c,53 :: 		sum = 0;
	LDI        R27, 0
	STS        _sum+0, R27
	STS        _sum+1, R27
;Voltmeter_click_AVR.c,54 :: 		measurement = 0;
	LDI        R27, 0
	STS        _measurement+0, R27
	STS        _measurement+1, R27
	STS        _measurement+2, R27
	STS        _measurement+3, R27
;Voltmeter_click_AVR.c,55 :: 		calibration = 0;
	LDI        R27, 0
	STS        _calibration+0, R27
	STS        _calibration+1, R27
;Voltmeter_click_AVR.c,57 :: 		Chip_Select = 1;                 // Deselect MCP3204
	IN         R27, PORTA5_bit+0
	SBR        R27, BitMask(PORTA5_bit+0)
	OUT        PORTA5_bit+0, R27
;Voltmeter_click_AVR.c,60 :: 		SPI1_Init_Advanced( _SPI_MASTER, _SPI_FCY_DIV32, _SPI_CLK_LO_TRAILING );
	LDI        R27, 4
	MOV        R4, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 16
	MOV        R2, R27
	CALL       _SPI1_Init_Advanced+0
;Voltmeter_click_AVR.c,61 :: 		Delay_ms(300);
	LDI        R18, 13
	LDI        R17, 45
	LDI        R16, 216
L_system_setup6:
	DEC        R16
	BRNE       L_system_setup6
	DEC        R17
	BRNE       L_system_setup6
	DEC        R18
	BRNE       L_system_setup6
	NOP
	NOP
;Voltmeter_click_AVR.c,62 :: 		UART1_Write_Text( "SPI Initialized\r\n" );
	LDI        R27, #lo_addr(?lstr4_Voltmeter_click_AVR+0)
	MOV        R2, R27
	LDI        R27, hi_addr(?lstr4_Voltmeter_click_AVR+0)
	MOV        R3, R27
	CALL       _UART1_Write_Text+0
;Voltmeter_click_AVR.c,64 :: 		calibration = getADC()/2;
	CALL       _getADC+0
	LSR        R17
	ROR        R16
	STS        _calibration+0, R16
	STS        _calibration+1, R17
;Voltmeter_click_AVR.c,66 :: 		}
L_end_system_setup:
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _system_setup

_getADC:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;Voltmeter_click_AVR.c,68 :: 		unsigned int getADC( void )
;Voltmeter_click_AVR.c,75 :: 		sum = 0;
	PUSH       R2
; sum start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
;Voltmeter_click_AVR.c,77 :: 		for(i=0; i<10; i++ )
; i start address is: 18 (R18)
	LDI        R18, 0
; sum end address is: 19 (R19)
; i end address is: 18 (R18)
L_getADC8:
; i start address is: 18 (R18)
; sum start address is: 19 (R19)
	CPI        R18, 10
	BRLO       L__getADC15
	JMP        L_getADC9
L__getADC15:
;Voltmeter_click_AVR.c,79 :: 		Chip_Select = 0;               // Select MCP3201
	IN         R27, PORTA5_bit+0
	CBR        R27, BitMask(PORTA5_bit+0)
	OUT        PORTA5_bit+0, R27
;Voltmeter_click_AVR.c,80 :: 		read = SPI1_Read(buffer);      // Get first 8 bits of ADC value
	LDD        R2, Y+0
	CALL       _SPI1_Read+0
; read start address is: 23 (R23)
	MOV        R23, R16
	LDI        R24, 0
;Voltmeter_click_AVR.c,81 :: 		read1 = SPI1_Read(buffer);     // Get the rest of the ADC value bits
	LDD        R2, Y+0
	CALL       _SPI1_Read+0
; read1 start address is: 21 (R21)
	MOV        R21, R16
	LDI        R22, 0
;Voltmeter_click_AVR.c,82 :: 		Chip_Select = 1;               // Deselect MCP3201
	IN         R27, PORTA5_bit+0
	SBR        R27, BitMask(PORTA5_bit+0)
	OUT        PORTA5_bit+0, R27
;Voltmeter_click_AVR.c,83 :: 		read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
	MOV        R16, R23
	MOV        R17, R24
	ANDI       R16, 31
	ANDI       R17, 0
; read end address is: 23 (R23)
	MOV        R17, R16
	CLR        R16
; read start address is: 23 (R23)
	MOV        R23, R16
	MOV        R24, R17
;Voltmeter_click_AVR.c,84 :: 		read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
	MOV        R16, R23
	MOV        R17, R24
	OR         R16, R21
	OR         R17, R22
; read1 end address is: 21 (R21)
; read end address is: 23 (R23)
	LSR        R17
	ROR        R16
; read start address is: 21 (R21)
	MOV        R21, R16
	MOV        R22, R17
;Voltmeter_click_AVR.c,85 :: 		sum = sum + read;              // Sum of the eight ADC readings
	MOV        R16, R21
	MOV        R17, R22
	ADD        R16, R19
	ADC        R17, R20
; read end address is: 21 (R21)
	MOV        R19, R16
	MOV        R20, R17
;Voltmeter_click_AVR.c,77 :: 		for(i=0; i<10; i++ )
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;Voltmeter_click_AVR.c,86 :: 		}
; i end address is: 18 (R18)
	JMP        L_getADC8
L_getADC9:
;Voltmeter_click_AVR.c,87 :: 		avrg = sum / 10;                  // Average ADC value based on sum of the ADC readings
	MOV        R16, R19
	MOV        R17, R20
	LDI        R20, 10
	LDI        R21, 0
	CALL       _Div_16x16_U+0
	MOVW       R16, R24
; sum end address is: 19 (R19)
; avrg start address is: 18 (R18)
	MOVW       R18, R16
;Voltmeter_click_AVR.c,88 :: 		return avrg;                     // Returns the average ADC value
	MOVW       R16, R18
; avrg end address is: 18 (R18)
;Voltmeter_click_AVR.c,89 :: 		}
;Voltmeter_click_AVR.c,88 :: 		return avrg;                     // Returns the average ADC value
;Voltmeter_click_AVR.c,89 :: 		}
L_end_getADC:
	POP        R2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _getADC
