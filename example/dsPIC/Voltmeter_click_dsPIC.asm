
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 50
	MOV	#4, W0
	IOR	68
	LNK	#4

;Voltmeter_click_dsPIC.c,18 :: 		void main()
;Voltmeter_click_dsPIC.c,20 :: 		system_setup();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_system_setup
;Voltmeter_click_dsPIC.c,22 :: 		UART1_Write_Text( "Entering While Loop...\r\n" );
	MOV	#lo_addr(?lstr1_Voltmeter_click_dsPIC), W10
	CALL	_UART1_Write_Text
;Voltmeter_click_dsPIC.c,24 :: 		while (1) {
L_main0:
;Voltmeter_click_dsPIC.c,26 :: 		voltage = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _voltage
	MOV	W1, _voltage+2
;Voltmeter_click_dsPIC.c,28 :: 		measurement = getADC()/2;        // Get ADC result
	CALL	_getADC
	LSR	W0, #1, W0
	CLR	W1
	CALL	__Long2Float
	MOV	W0, _measurement
	MOV	W1, _measurement+2
;Voltmeter_click_dsPIC.c,29 :: 		voltage = (measurement - calibration) * 33.3405;
	MOV	_calibration, W0
	CLR	W1
	CALL	__Long2Float
	MOV	W0, [W14+0]
	MOV	W1, [W14+2]
	MOV	_measurement, W0
	MOV	_measurement+2, W1
	PUSH.D	W2
	MOV	[W14+0], W2
	MOV	[W14+2], W3
	CALL	__Sub_FP
	POP.D	W2
	MOV	#23724, W2
	MOV	#16901, W3
	CALL	__Mul_FP
	MOV	W0, _voltage
	MOV	W1, _voltage+2
;Voltmeter_click_dsPIC.c,31 :: 		FloatToStr(voltage, txt);
	MOV	#lo_addr(_txt), W12
	MOV.D	W0, W10
	CALL	_FloatToStr
;Voltmeter_click_dsPIC.c,33 :: 		UART1_Write_Text(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_UART1_Write_Text
;Voltmeter_click_dsPIC.c,34 :: 		UART1_Write(32);
	MOV	#32, W10
	CALL	_UART1_Write
;Voltmeter_click_dsPIC.c,35 :: 		UART1_Write_Text("mV");
	MOV	#lo_addr(?lstr2_Voltmeter_click_dsPIC), W10
	CALL	_UART1_Write_Text
;Voltmeter_click_dsPIC.c,36 :: 		UART1_Write(13);
	MOV	#13, W10
	CALL	_UART1_Write
;Voltmeter_click_dsPIC.c,37 :: 		UART1_Write(10);
	MOV	#10, W10
	CALL	_UART1_Write
;Voltmeter_click_dsPIC.c,39 :: 		delay_ms(1000);                //Za test moze sa delay da se resi sample rate, za ozbiljnije interrupt + TMR
	MOV	#13, W8
	MOV	#13575, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	DEC	W8
	BRA NZ	L_main2
;Voltmeter_click_dsPIC.c,40 :: 		}
	GOTO	L_main0
;Voltmeter_click_dsPIC.c,41 :: 		}
L_end_main:
	POP	W12
	POP	W11
	POP	W10
	ULNK
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main

_system_setup:

;Voltmeter_click_dsPIC.c,43 :: 		void system_setup( void )
;Voltmeter_click_dsPIC.c,45 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;Voltmeter_click_dsPIC.c,46 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
	MOV	#4, W8
	MOV	#43393, W7
L_system_setup4:
	DEC	W7
	BRA NZ	L_system_setup4
	DEC	W8
	BRA NZ	L_system_setup4
	NOP
	NOP
	NOP
;Voltmeter_click_dsPIC.c,47 :: 		UART1_Write_Text( "UART Initialized\r\n" );
	MOV	#lo_addr(?lstr3_Voltmeter_click_dsPIC), W10
	CALL	_UART1_Write_Text
;Voltmeter_click_dsPIC.c,49 :: 		voltage = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _voltage
	MOV	W1, _voltage+2
;Voltmeter_click_dsPIC.c,50 :: 		sum = 0;
	CLR	W0
	MOV	W0, _sum
;Voltmeter_click_dsPIC.c,51 :: 		measurement = 0;
	CLR	W0
	CLR	W1
	MOV	W0, _measurement
	MOV	W1, _measurement+2
;Voltmeter_click_dsPIC.c,52 :: 		calibration = 0;
	CLR	W0
	MOV	W0, _calibration
;Voltmeter_click_dsPIC.c,55 :: 		PLLFBD = 70;             // PLL multiplier M=70
	MOV	#70, W0
	MOV	WREG, PLLFBD
;Voltmeter_click_dsPIC.c,56 :: 		CLKDIV = 0x0000;         // PLL prescaler N1=2, PLL postscaler N2=2
	CLR	CLKDIV
;Voltmeter_click_dsPIC.c,58 :: 		ANSELA = 0x00;           // Convert all I/O pins to digital
	CLR	ANSELA
;Voltmeter_click_dsPIC.c,59 :: 		ANSELB = 0x00;
	CLR	ANSELB
;Voltmeter_click_dsPIC.c,60 :: 		ANSELC = 0x00;
	CLR	ANSELC
;Voltmeter_click_dsPIC.c,61 :: 		ANSELD = 0x00;
	CLR	ANSELD
;Voltmeter_click_dsPIC.c,62 :: 		ANSELE = 0x00;
	CLR	ANSELE
;Voltmeter_click_dsPIC.c,64 :: 		PPS_Mapping(100, _INPUT,  _U1RX);              // Sets pin RP100 to be Input, and maps U1RX to it
	MOV.B	#34, W12
	MOV.B	#1, W11
	MOV.B	#100, W10
	CALL	_PPS_Mapping
;Voltmeter_click_dsPIC.c,65 :: 		PPS_Mapping(101, _OUTPUT, _U1TX);              // Sets pin RP101 to be Output, and maps U1TX to it
	MOV.B	#1, W12
	CLR	W11
	MOV.B	#101, W10
	CALL	_PPS_Mapping
;Voltmeter_click_dsPIC.c,66 :: 		Delay_ms(300);
	MOV	#4, W8
	MOV	#43393, W7
L_system_setup6:
	DEC	W7
	BRA NZ	L_system_setup6
	DEC	W8
	BRA NZ	L_system_setup6
	NOP
	NOP
	NOP
;Voltmeter_click_dsPIC.c,69 :: 		Chip_Select_Direction  = 0;
	BCLR	TRISC2_bit, BitPos(TRISC2_bit+0)
;Voltmeter_click_dsPIC.c,70 :: 		Chip_Select = 1;
	BSET	RC2_bit, BitPos(RC2_bit+0)
;Voltmeter_click_dsPIC.c,73 :: 		PPS_Mapping(104, _OUTPUT,  _SDO3);             // Sets pin RP104 to be Output, and maps SD03 to it
	MOV.B	#31, W12
	CLR	W11
	MOV.B	#104, W10
	CALL	_PPS_Mapping
;Voltmeter_click_dsPIC.c,74 :: 		PPS_Mapping(98, _INPUT, _SDI3);                // Sets pin RP98 to be Input, and maps SD01 to it
	MOV.B	#51, W12
	MOV.B	#1, W11
	MOV.B	#98, W10
	CALL	_PPS_Mapping
;Voltmeter_click_dsPIC.c,75 :: 		PPS_Mapping(79, _OUTPUT, _SCK3OUT);            // Sets pin RP79 to be Output, and maps SCK3 to it
	MOV.B	#32, W12
	CLR	W11
	MOV.B	#79, W10
	CALL	_PPS_Mapping
;Voltmeter_click_dsPIC.c,76 :: 		Delay_ms(300);
	MOV	#4, W8
	MOV	#43393, W7
L_system_setup8:
	DEC	W7
	BRA NZ	L_system_setup8
	DEC	W8
	BRA NZ	L_system_setup8
	NOP
	NOP
	NOP
;Voltmeter_click_dsPIC.c,81 :: 		_SPI_PRESCALE_PRI_16,
	MOV	#1, W13
;Voltmeter_click_dsPIC.c,80 :: 		_SPI_PRESCALE_SEC_8,
	CLR	W12
;Voltmeter_click_dsPIC.c,79 :: 		_SPI_8_BIT,
	CLR	W11
;Voltmeter_click_dsPIC.c,78 :: 		SPI3_Init_Advanced(_SPI_MASTER,
	MOV	#32, W10
;Voltmeter_click_dsPIC.c,85 :: 		_SPI_IDLE_2_ACTIVE);
	MOV	#256, W0
	PUSH	W0
;Voltmeter_click_dsPIC.c,84 :: 		_SPI_CLK_IDLE_LOW,
	CLR	W0
	PUSH	W0
;Voltmeter_click_dsPIC.c,83 :: 		_SPI_DATA_SAMPLE_END,
	MOV	#512, W0
	PUSH	W0
;Voltmeter_click_dsPIC.c,82 :: 		_SPI_SS_DISABLE,
	CLR	W0
	PUSH	W0
;Voltmeter_click_dsPIC.c,85 :: 		_SPI_IDLE_2_ACTIVE);
	CALL	_SPI3_Init_Advanced
	SUB	#8, W15
;Voltmeter_click_dsPIC.c,86 :: 		Delay_ms( 300 );
	MOV	#4, W8
	MOV	#43393, W7
L_system_setup10:
	DEC	W7
	BRA NZ	L_system_setup10
	DEC	W8
	BRA NZ	L_system_setup10
	NOP
	NOP
	NOP
;Voltmeter_click_dsPIC.c,89 :: 		UART1_Init( 9600 );
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;Voltmeter_click_dsPIC.c,90 :: 		Delay_ms(300);
	MOV	#4, W8
	MOV	#43393, W7
L_system_setup12:
	DEC	W7
	BRA NZ	L_system_setup12
	DEC	W8
	BRA NZ	L_system_setup12
	NOP
	NOP
	NOP
;Voltmeter_click_dsPIC.c,92 :: 		UART1_Write_Text( "SPI Initialized\r\n" );
	MOV	#lo_addr(?lstr4_Voltmeter_click_dsPIC), W10
	CALL	_UART1_Write_Text
;Voltmeter_click_dsPIC.c,93 :: 		UART1_Write_Text( "UART Initialized\r\n" );
	MOV	#lo_addr(?lstr5_Voltmeter_click_dsPIC), W10
	CALL	_UART1_Write_Text
;Voltmeter_click_dsPIC.c,95 :: 		calibration = getADC()/2;
	CALL	_getADC
	LSR	W0, #1, W0
	MOV	W0, _calibration
;Voltmeter_click_dsPIC.c,97 :: 		}
L_end_system_setup:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _system_setup

_getADC:
	LNK	#2

;Voltmeter_click_dsPIC.c,99 :: 		unsigned int getADC( void )
;Voltmeter_click_dsPIC.c,102 :: 		char i = 0, buffer = 0;
	PUSH	W10
;Voltmeter_click_dsPIC.c,103 :: 		volatile float avrg = 0, sum = 0;
;Voltmeter_click_dsPIC.c,104 :: 		volatile unsigned int read = 0, read1 = 0;
;Voltmeter_click_dsPIC.c,107 :: 		sum = 0.0;
; sum start address is: 8 (W4)
	CLR	W4
	CLR	W5
;Voltmeter_click_dsPIC.c,108 :: 		read = 0.0;
; read start address is: 0 (W0)
	CLR	W0
; read end address is: 0 (W0)
;Voltmeter_click_dsPIC.c,109 :: 		read1 = 0.0;
; read1 start address is: 0 (W0)
	CLR	W0
; read1 end address is: 0 (W0)
;Voltmeter_click_dsPIC.c,110 :: 		avrg = 0.0;
; avrg start address is: 0 (W0)
	CLR	W0
	CLR	W1
; avrg end address is: 0 (W0)
;Voltmeter_click_dsPIC.c,111 :: 		buffer = 0;
	CLR	W0
	MOV.B	W0, [W14+1]
;Voltmeter_click_dsPIC.c,113 :: 		for(i=0; i<10; i++ )
	CLR	W0
	MOV.B	W0, [W14+0]
; sum end address is: 8 (W4)
	MOV.D	W4, W2
L_getADC14:
; sum start address is: 4 (W2)
	MOV.B	[W14+0], W0
	CP.B	W0, #10
	BRA LTU	L__getADC21
	GOTO	L_getADC15
L__getADC21:
;Voltmeter_click_dsPIC.c,115 :: 		Chip_Select = 0;               // Select MCP3201
	BCLR	RC2_bit, BitPos(RC2_bit+0)
;Voltmeter_click_dsPIC.c,116 :: 		read = SPI3_Read(buffer);      // Get first 8 bits of ADC value
	ADD	W14, #1, W0
	ZE	[W0], W10
	CALL	_SPI3_Read
; read start address is: 8 (W4)
	MOV	W0, W4
;Voltmeter_click_dsPIC.c,117 :: 		read1 = SPI3_Read(buffer);     // Get the rest of the ADC value bits
	ADD	W14, #1, W0
	ZE	[W0], W10
	CALL	_SPI3_Read
; read1 start address is: 2 (W1)
	MOV	W0, W1
;Voltmeter_click_dsPIC.c,118 :: 		Chip_Select = 1;               // Deselect MCP3201
	BSET	RC2_bit, BitPos(RC2_bit+0)
;Voltmeter_click_dsPIC.c,119 :: 		read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
	AND	W4, #31, W0
; read end address is: 8 (W4)
	SL	W0, #8, W0
; read start address is: 8 (W4)
	MOV	W0, W4
;Voltmeter_click_dsPIC.c,120 :: 		read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
	IOR	W4, W1, W0
; read1 end address is: 2 (W1)
; read end address is: 8 (W4)
	LSR	W0, #1, W0
; read start address is: 8 (W4)
	MOV	W0, W4
;Voltmeter_click_dsPIC.c,121 :: 		sum = sum + read;              // Sum of the eight ADC readings
	PUSH.D	W2
; read end address is: 8 (W4)
	MOV	W4, W0
	CLR	W1
	CALL	__Long2Float
	POP.D	W2
	CALL	__AddSub_FP
; sum end address is: 4 (W2)
; sum start address is: 8 (W4)
	MOV.D	W0, W4
;Voltmeter_click_dsPIC.c,113 :: 		for(i=0; i<10; i++ )
	MOV.B	[W14+0], W1
	ADD	W14, #0, W0
	ADD.B	W1, #1, [W0]
;Voltmeter_click_dsPIC.c,122 :: 		}
	MOV.D	W4, W2
; sum end address is: 8 (W4)
	GOTO	L_getADC14
L_getADC15:
;Voltmeter_click_dsPIC.c,123 :: 		avrg = sum / 10.0;                  // Average ADC value based on sum of the ADC readings
; sum start address is: 4 (W2)
	MOV.D	W2, W0
	MOV	#0, W2
	MOV	#16672, W3
	CALL	__Div_FP
; sum end address is: 4 (W2)
; avrg start address is: 4 (W2)
	MOV.D	W0, W2
;Voltmeter_click_dsPIC.c,125 :: 		return avrg;                     // Returns the average ADC value
	MOV.D	W2, W0
	CALL	__Float2Longint
; avrg end address is: 4 (W2)
;Voltmeter_click_dsPIC.c,126 :: 		}
;Voltmeter_click_dsPIC.c,125 :: 		return avrg;                     // Returns the average ADC value
;Voltmeter_click_dsPIC.c,126 :: 		}
L_end_getADC:
	POP	W10
	ULNK
	RETURN
; end of _getADC
