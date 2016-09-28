#line 1 "C:/Users/Corey/Documents/Projects/Voltmeter/dsPIC/Voltmeter_click_dsPIC.c"


sbit Chip_Select_Direction at TRISC2_bit;
sbit Chip_Select at RC2_bit;


unsigned int calibration, sum, average;
float voltage, measurement;
char txt[15];
char lower_deo, upper_deo;
unsigned int adc_rd;
float voltage_v;


void system_setup( void );
unsigned int getADC( void );

void main()
{
 system_setup();

 UART1_Write_Text( "Entering While Loop...\r\n" );

 while (1) {

 voltage = 0;

 measurement = getADC()/2;
 voltage = (measurement - calibration) * 33.3405;

 FloatToStr(voltage, txt);

 UART1_Write_Text(txt);
 UART1_Write(32);
 UART1_Write_Text("mV");
 UART1_Write(13);
 UART1_Write(10);

 delay_ms(1000);
 }
}

void system_setup( void )
{
 UART1_Init(9600);
 Delay_ms(300);
 UART1_Write_Text( "UART Initialized\r\n" );

 voltage = 0;
 sum = 0;
 measurement = 0;
 calibration = 0;


 PLLFBD = 70;
 CLKDIV = 0x0000;

 ANSELA = 0x00;
 ANSELB = 0x00;
 ANSELC = 0x00;
 ANSELD = 0x00;
 ANSELE = 0x00;

 PPS_Mapping(100, _INPUT, _U1RX);
 PPS_Mapping(101, _OUTPUT, _U1TX);
 Delay_ms(300);


 Chip_Select_Direction = 0;
 Chip_Select = 1;


 PPS_Mapping(104, _OUTPUT, _SDO3);
 PPS_Mapping(98, _INPUT, _SDI3);
 PPS_Mapping(79, _OUTPUT, _SCK3OUT);
 Delay_ms(300);

 SPI3_Init_Advanced(_SPI_MASTER,
 _SPI_8_BIT,
 _SPI_PRESCALE_SEC_8,
 _SPI_PRESCALE_PRI_16,
 _SPI_SS_DISABLE,
 _SPI_DATA_SAMPLE_END,
 _SPI_CLK_IDLE_LOW,
 _SPI_IDLE_2_ACTIVE);
 Delay_ms( 300 );


 UART1_Init( 9600 );
 Delay_ms(300);

 UART1_Write_Text( "SPI Initialized\r\n" );
 UART1_Write_Text( "UART Initialized\r\n" );

 calibration = getADC()/2;

}

unsigned int getADC( void )
{

 char i = 0, buffer = 0;
 volatile float avrg = 0, sum = 0;
 volatile unsigned int read = 0, read1 = 0;


 sum = 0.0;
 read = 0.0;
 read1 = 0.0;
 avrg = 0.0;
 buffer = 0;

 for(i=0; i<10; i++ )
 {
 Chip_Select = 0;
 read = SPI3_Read(buffer);
 read1 = SPI3_Read(buffer);
 Chip_Select = 1;
 read = ((read & 0x1F) << 8);
 read = ((read | read1) >> 1);
 sum = sum + read;
 }
 avrg = sum / 10.0;

 return avrg;
}
