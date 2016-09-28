_main:
;Voltmeter_ARM.c,18 :: 		void main()
SUB	SP, SP, #16
;Voltmeter_ARM.c,20 :: 		system_setup();
BL	_system_setup+0
;Voltmeter_ARM.c,22 :: 		UART1_Write_Text( "Entering While Loop...\r\n" );
MOVW	R0, #lo_addr(?lstr1_Voltmeter_ARM+0)
MOVT	R0, #hi_addr(?lstr1_Voltmeter_ARM+0)
BL	_UART1_Write_Text+0
;Voltmeter_ARM.c,24 :: 		while (1) {
L_main0:
;Voltmeter_ARM.c,26 :: 		voltage = 0;
MOV	R1, #0
MOVW	R0, #lo_addr(_voltage+0)
MOVT	R0, #hi_addr(_voltage+0)
STR	R0, [SP, #12]
STR	R1, [R0, #0]
;Voltmeter_ARM.c,28 :: 		measurement = getADC()/2;        // Get ADC result
BL	_getADC+0
LSRS	R0, R0, #1
UXTH	R0, R0
BL	__UnsignedIntegralToFloat+0
MOVW	R1, #lo_addr(_measurement+0)
MOVT	R1, #hi_addr(_measurement+0)
STR	R1, [SP, #8]
STR	R0, [R1, #0]
;Voltmeter_ARM.c,29 :: 		voltage = (measurement - calibration)*33.3405;
MOVW	R0, #lo_addr(_calibration+0)
MOVT	R0, #hi_addr(_calibration+0)
LDRH	R0, [R0, #0]
BL	__UnsignedIntegralToFloat+0
STR	R0, [SP, #4]
LDR	R0, [SP, #8]
LDR	R0, [R0, #0]
STR	R1, [SP, #0]
LDR	R1, [SP, #4]
MOV	R2, R1
BL	__Sub_FP+0
LDR	R1, [SP, #0]
MOVW	R2, #23724
MOVT	R2, #16901
BL	__Mul_FP+0
LDR	R1, [SP, #12]
STR	R0, [R1, #0]
;Voltmeter_ARM.c,31 :: 		FloatToStr(voltage, txt);
MOV	R0, R0
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_FloatToStr+0
;Voltmeter_ARM.c,33 :: 		UART1_Write_Text(txt);
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_UART1_Write_Text+0
;Voltmeter_ARM.c,34 :: 		UART1_Write(32);
MOVS	R0, #32
BL	_UART1_Write+0
;Voltmeter_ARM.c,35 :: 		UART1_Write_Text("mV");
MOVW	R0, #lo_addr(?lstr2_Voltmeter_ARM+0)
MOVT	R0, #hi_addr(?lstr2_Voltmeter_ARM+0)
BL	_UART1_Write_Text+0
;Voltmeter_ARM.c,36 :: 		UART1_Write(13);
MOVS	R0, #13
BL	_UART1_Write+0
;Voltmeter_ARM.c,37 :: 		UART1_Write(10);
MOVS	R0, #10
BL	_UART1_Write+0
;Voltmeter_ARM.c,39 :: 		delay_ms(1000);                //Za test moze sa delay da se resi sample rate, za ozbiljnije interrupt + TMR
MOVW	R7, #6911
MOVT	R7, #183
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
;Voltmeter_ARM.c,40 :: 		}
IT	AL
BAL	L_main0
;Voltmeter_ARM.c,41 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_system_setup:
;Voltmeter_ARM.c,43 :: 		void system_setup( void )
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Voltmeter_ARM.c,45 :: 		GPIO_Digital_Output( &GPIOD_BASE, _GPIO_PINMASK_13 );
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Digital_Output+0
;Voltmeter_ARM.c,47 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
MOVW	R0, #9600
BL	_UART1_Init+0
;Voltmeter_ARM.c,48 :: 		Delay_ms(300);                  // Wait for UART module to stabilize
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_system_setup4:
SUBS	R7, R7, #1
BNE	L_system_setup4
NOP
NOP
NOP
;Voltmeter_ARM.c,49 :: 		UART1_Write_Text( "UART Initialized\r\n" );
MOVW	R0, #lo_addr(?lstr3_Voltmeter_ARM+0)
MOVT	R0, #hi_addr(?lstr3_Voltmeter_ARM+0)
BL	_UART1_Write_Text+0
;Voltmeter_ARM.c,51 :: 		ADC1_Init();
BL	_ADC1_Init+0
;Voltmeter_ARM.c,52 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_system_setup6:
SUBS	R7, R7, #1
BNE	L_system_setup6
NOP
NOP
NOP
;Voltmeter_ARM.c,53 :: 		UART1_Write_Text( "ADC 1 Initialized\r\n" );
MOVW	R0, #lo_addr(?lstr4_Voltmeter_ARM+0)
MOVT	R0, #hi_addr(?lstr4_Voltmeter_ARM+0)
BL	_UART1_Write_Text+0
;Voltmeter_ARM.c,55 :: 		voltage = 0;
MOV	R1, #0
MOVW	R0, #lo_addr(_voltage+0)
MOVT	R0, #hi_addr(_voltage+0)
STR	R1, [R0, #0]
;Voltmeter_ARM.c,56 :: 		sum = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_sum+0)
MOVT	R0, #hi_addr(_sum+0)
STRH	R1, [R0, #0]
;Voltmeter_ARM.c,57 :: 		measurement = 0;
MOV	R1, #0
MOVW	R0, #lo_addr(_measurement+0)
MOVT	R0, #hi_addr(_measurement+0)
STR	R1, [R0, #0]
;Voltmeter_ARM.c,58 :: 		calibration = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_calibration+0)
MOVT	R0, #hi_addr(_calibration+0)
STRH	R1, [R0, #0]
;Voltmeter_ARM.c,60 :: 		Chip_Select = 1;                 // Deselect MCP3204
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Voltmeter_ARM.c,66 :: 		_SPI_SSI_1, &_GPIO_MODULE_SPI3_PC10_11_12 );
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI3_PC10_11_12+0)
MOVW	R1, #773
;Voltmeter_ARM.c,63 :: 		SPI3_Init_Advanced( _SPI_FPCLK_DIV16, _SPI_MASTER | _SPI_8_BIT |
MOVS	R0, #3
;Voltmeter_ARM.c,66 :: 		_SPI_SSI_1, &_GPIO_MODULE_SPI3_PC10_11_12 );
BL	_SPI3_Init_Advanced+0
;Voltmeter_ARM.c,67 :: 		Delay_ms(300);
MOVW	R7, #61055
MOVT	R7, #54
NOP
NOP
L_system_setup8:
SUBS	R7, R7, #1
BNE	L_system_setup8
NOP
NOP
NOP
;Voltmeter_ARM.c,68 :: 		UART1_Write_Text( "SPI Initialized\r\n" );
MOVW	R0, #lo_addr(?lstr5_Voltmeter_ARM+0)
MOVT	R0, #hi_addr(?lstr5_Voltmeter_ARM+0)
BL	_UART1_Write_Text+0
;Voltmeter_ARM.c,70 :: 		calibration = getADC()/2;
BL	_getADC+0
LSRS	R1, R0, #1
MOVW	R0, #lo_addr(_calibration+0)
MOVT	R0, #hi_addr(_calibration+0)
STRH	R1, [R0, #0]
;Voltmeter_ARM.c,72 :: 		}
L_end_system_setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _system_setup
_getADC:
;Voltmeter_ARM.c,74 :: 		unsigned int getADC( void )
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Voltmeter_ARM.c,81 :: 		sum = 0;
; sum start address is: 20 (R5)
MOVS	R5, #0
;Voltmeter_ARM.c,83 :: 		for(i=0; i<10; i++ )
; i start address is: 16 (R4)
MOVS	R4, #0
; sum end address is: 20 (R5)
; i end address is: 16 (R4)
L_getADC10:
; i start address is: 16 (R4)
; sum start address is: 20 (R5)
CMP	R4, #10
IT	CS
BCS	L_getADC11
;Voltmeter_ARM.c,85 :: 		Chip_Select = 0;               // Select MCP3201
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Voltmeter_ARM.c,86 :: 		read = SPI3_Read(buffer);      // Get first 8 bits of ADC value
LDRB	R0, [SP, #4]
BL	_SPI3_Read+0
; read start address is: 24 (R6)
UXTH	R6, R0
;Voltmeter_ARM.c,87 :: 		read1 = SPI3_Read(buffer);     // Get the rest of the ADC value bits
LDRB	R0, [SP, #4]
BL	_SPI3_Read+0
; read1 start address is: 8 (R2)
UXTH	R2, R0
;Voltmeter_ARM.c,88 :: 		Chip_Select = 1;               // Deselect MCP3201
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Voltmeter_ARM.c,89 :: 		read = ((read & 0x1F) << 8);   // Store the first 8 bits of the ADC value in temporary variable
AND	R0, R6, #31
UXTH	R0, R0
; read end address is: 24 (R6)
LSLS	R0, R0, #8
; read start address is: 4 (R1)
UXTH	R1, R0
;Voltmeter_ARM.c,90 :: 		read = ((read | read1) >> 1);  // Store the rest of the ADC value bits in temporary variable
ORR	R0, R1, R2, LSL #0
UXTH	R0, R0
; read1 end address is: 8 (R2)
; read end address is: 4 (R1)
LSRS	R0, R0, #1
; read start address is: 4 (R1)
UXTH	R1, R0
;Voltmeter_ARM.c,91 :: 		sum = sum + read;              // Sum of the eight ADC readings
ADDS	R5, R5, R1
UXTH	R5, R5
; read end address is: 4 (R1)
;Voltmeter_ARM.c,83 :: 		for(i=0; i<10; i++ )
ADDS	R4, R4, #1
UXTB	R4, R4
;Voltmeter_ARM.c,92 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_getADC10
L_getADC11:
;Voltmeter_ARM.c,93 :: 		avrg = sum / 10;                  // Average ADC value based on sum of the ADC readings
MOVS	R0, #10
UDIV	R0, R5, R0
; sum end address is: 20 (R5)
; avrg start address is: 0 (R0)
;Voltmeter_ARM.c,94 :: 		return avrg;                     // Returns the average ADC value
; avrg end address is: 0 (R0)
;Voltmeter_ARM.c,95 :: 		}
L_end_getADC:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _getADC
