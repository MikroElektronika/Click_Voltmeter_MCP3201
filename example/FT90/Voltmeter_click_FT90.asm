_main:
;Voltmeter_click_FT90.c,16 :: 		void main()
LDK.L	SP, #43605
;Voltmeter_click_FT90.c,18 :: 		system_setup();
CALL	_system_setup+0
;Voltmeter_click_FT90.c,20 :: 		while (1)
L_main0:
;Voltmeter_click_FT90.c,23 :: 		voltage = 0;
LDK.L	R0, #0
STA.L	_voltage+0, R0
;Voltmeter_click_FT90.c,25 :: 		measurement = getADC()/2;        // Get ADC result
CALL	_getADC+0
LSHR.L	R0, R0, #1
BEXTU.L	R0, R0, #0
BEXTU.L	R4, R0, #0
CALL	__Unsigned16IntToFloat+0
STA.L	_measurement+0, R0
;Voltmeter_click_FT90.c,26 :: 		voltage = (measurement - calibration)*33.3405;
LDA.S	R4, _calibration+0
CALL	__Unsigned16IntToFloat+0
MOVE.L	R6, R0
LDA.L	R4, _measurement+0
CALL	__Sub_FP+0
MOVE.L	R4, R0
LDK.L	R6, #1107647660
LDL.L	R6, R6, #1107647660
CALL	__Mul_FP+0
STA.L	_voltage+0, R0
;Voltmeter_click_FT90.c,28 :: 		FloatToStr(voltage, txt);
LDK.L	R1, #_txt+0
CALL	_FloatToStr+0
;Voltmeter_click_FT90.c,30 :: 		UART1_Write_Text(txt);
LDK.L	R0, #_txt+0
CALL	_UART1_Write_Text+0
;Voltmeter_click_FT90.c,31 :: 		UART1_Write(32);
LDK.L	R0, #32
CALL	_UART1_Write+0
;Voltmeter_click_FT90.c,32 :: 		UART1_Write_Text("mV");
LDK.L	R0, #?lstr1_Voltmeter_click_FT90+0
CALL	_UART1_Write_Text+0
;Voltmeter_click_FT90.c,33 :: 		UART1_Write(13);
LDK.L	R0, #13
CALL	_UART1_Write+0
;Voltmeter_click_FT90.c,34 :: 		UART1_Write(10);
LDK.L	R0, #10
CALL	_UART1_Write+0
;Voltmeter_click_FT90.c,36 :: 		delay_ms(1000);                //Za test moze sa delay da se resi sample rate, za ozbiljnije interrupt + TMR
LPM.L	R28, #33333331
NOP	
L_main2:
SUB.L	R28, R28, #1
CMP.L	R28, #0
JMPC	R30, Z, #0, L_main2
JMP	$+8
	#33333331
NOP	
NOP	
;Voltmeter_click_FT90.c,37 :: 		}
JMP	L_main0
;Voltmeter_click_FT90.c,38 :: 		}
L_end_main:
L__main_end_loop:
JMP	L__main_end_loop
; end of _main
_system_setup:
;Voltmeter_click_FT90.c,40 :: 		void system_setup( void )
;Voltmeter_click_FT90.c,42 :: 		GPIO_Digital_Output( &GPIO_PORT_24_31, _GPIO_PINMASK_4 );
LDK.L	R1, #16
LDK.L	R0, #GPIO_PORT_24_31+0
CALL	_GPIO_Digital_Output+0
;Voltmeter_click_FT90.c,44 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
LDK.L	R0, #9600
CALL	_UART1_Init+0
;Voltmeter_click_FT90.c,45 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
LPM.L	R28, #9999998
NOP	
L_system_setup4:
SUB.L	R28, R28, #1
CMP.L	R28, #0
JMPC	R30, Z, #0, L_system_setup4
JMP	$+8
	#9999998
NOP	
;Voltmeter_click_FT90.c,46 :: 		UART1_Write_Text( "UART Initialized\r\n" );
LDK.L	R0, #?lstr2_Voltmeter_click_FT90+0
CALL	_UART1_Write_Text+0
;Voltmeter_click_FT90.c,48 :: 		voltage = 0;
LDK.L	R0, #0
STA.L	_voltage+0, R0
;Voltmeter_click_FT90.c,49 :: 		sum = 0;
LDK.L	R1, #0
STA.S	_sum+0, R1
;Voltmeter_click_FT90.c,50 :: 		measurement = 0;
LDK.L	R0, #0
STA.L	_measurement+0, R0
;Voltmeter_click_FT90.c,51 :: 		calibration = 0;
STA.S	_calibration+0, R1
;Voltmeter_click_FT90.c,53 :: 		Chip_Select = 1;                 // Deselect MCP3204
LDA.x	R0, #AlignedAddress(GPIO_PIN28_bit+0)
BINS.L	R0, R0, #BitPos(GPIO_PIN28_bit+0)=1
STI.x	GPIO_PIN28_bit+0, #AlignedAddress(R0)
;Voltmeter_click_FT90.c,58 :: 		_SPI_CFG_FIFO_DISABLE, _SPI_SS_LINE_NONE );
LDK.L	R2, #0
LDK.L	R1, #101
;Voltmeter_click_FT90.c,56 :: 		SPIM1_Init_Advanced( _SPI_MASTER_CLK_RATIO_64, _SPI_CFG_PHASE_CAPTURE_RISING |
LDK.L	R0, #32
;Voltmeter_click_FT90.c,58 :: 		_SPI_CFG_FIFO_DISABLE, _SPI_SS_LINE_NONE );
CALL	_SPIM1_Init_Advanced+0
;Voltmeter_click_FT90.c,59 :: 		Delay_ms(300);
LPM.L	R28, #9999998
NOP	
L_system_setup6:
SUB.L	R28, R28, #1
CMP.L	R28, #0
JMPC	R30, Z, #0, L_system_setup6
JMP	$+8
	#9999998
NOP	
;Voltmeter_click_FT90.c,60 :: 		UART1_Write_Text( "SPI Initialized\r\n" );
LDK.L	R0, #?lstr3_Voltmeter_click_FT90+0
CALL	_UART1_Write_Text+0
;Voltmeter_click_FT90.c,62 :: 		calibration = getADC()/2;
CALL	_getADC+0
LSHR.L	R0, R0, #1
STA.S	_calibration+0, R0
;Voltmeter_click_FT90.c,64 :: 		}
L_end_system_setup:
RETURN	
; end of _system_setup
_getADC:
;Voltmeter_click_FT90.c,66 :: 		unsigned int getADC( void )
LINK	LR, #4
;Voltmeter_click_FT90.c,73 :: 		sum = 0;
; sum start address is: 20 (R5)
LDK.L	R5, #0
;Voltmeter_click_FT90.c,75 :: 		for(i=0; i<10; i++ )
; i start address is: 16 (R4)
LDK.L	R4, #0
; sum end address is: 20 (R5)
; i end address is: 16 (R4)
L_getADC8:
; i start address is: 16 (R4)
; sum start address is: 20 (R5)
CMP.B	R4, #10
JMPC	R30, C, #0, L_getADC9
;Voltmeter_click_FT90.c,77 :: 		Chip_Select = 0;               // Select MCP3201
LDA.x	R0, #AlignedAddress(GPIO_PIN28_bit+0)
BINS.L	R0, R0, #BitPos(GPIO_PIN28_bit+0)=0
STI.x	GPIO_PIN28_bit+0, #AlignedAddress(R0)
;Voltmeter_click_FT90.c,78 :: 		read = SPIM1_Read(buffer);      // Get first 8 bits of ADC value
LDI.B	R0, SP, #0
CALL	_SPIM1_Read+0
; read start address is: 24 (R6)
BEXTU.L	R6, R0, #256
;Voltmeter_click_FT90.c,79 :: 		read1 = SPIM1_Read(buffer);     // Get the rest of the ADC value bits
LDI.B	R0, SP, #0
CALL	_SPIM1_Read+0
; read1 start address is: 4 (R1)
BEXTU.L	R1, R0, #256
;Voltmeter_click_FT90.c,80 :: 		Chip_Select = 1;               // Deselect MCP3201
LDA.x	R0, #AlignedAddress(GPIO_PIN28_bit+0)
BINS.L	R0, R0, #BitPos(GPIO_PIN28_bit+0)=1
STI.x	GPIO_PIN28_bit+0, #AlignedAddress(R0)
;Voltmeter_click_FT90.c,81 :: 		read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
AND.L	R0, R6, #31
BEXTU.L	R0, R0, #0
; read end address is: 24 (R6)
ASHL.L	R0, R0, #8
; read start address is: 8 (R2)
BEXTU.L	R2, R0, #0
;Voltmeter_click_FT90.c,82 :: 		read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
OR.L	R0, R2, R1
BEXTU.L	R0, R0, #0
; read1 end address is: 4 (R1)
; read end address is: 8 (R2)
LSHR.L	R0, R0, #1
; read start address is: 4 (R1)
BEXTU.L	R1, R0, #0
;Voltmeter_click_FT90.c,83 :: 		sum = sum + read;              // Sum of the eight ADC readings
ADD.L	R5, R5, R1
BEXTU.L	R5, R5, #0
; read end address is: 4 (R1)
;Voltmeter_click_FT90.c,75 :: 		for(i=0; i<10; i++ )
ADD.L	R4, R4, #1
BEXTU.L	R4, R4, #256
;Voltmeter_click_FT90.c,84 :: 		}
; i end address is: 16 (R4)
JMP	L_getADC8
L_getADC9:
;Voltmeter_click_FT90.c,85 :: 		avrg = sum / 10;                  // Average ADC value based on sum of the ADC readings
UDIV.L	R0, R5, #10
; sum end address is: 20 (R5)
; avrg start address is: 0 (R0)
;Voltmeter_click_FT90.c,86 :: 		return avrg;                     // Returns the average ADC value
; avrg end address is: 0 (R0)
;Voltmeter_click_FT90.c,87 :: 		}
L_end_getADC:
UNLINK	LR
RETURN	
; end of _getADC
