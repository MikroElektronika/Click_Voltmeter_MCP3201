#line 1 "C:/Users/Corey/Documents/Projects/Voltmeter/AVR/Voltmeter_click_AVR.c"


sbit Chip_Select at PORTA5_bit;
sbit Chip_Select_DIR at DDA5_bit;


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
 voltage = (measurement - calibration)*33.3405;

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
 Chip_Select_DIR = 1;

 UART1_Init(9600);
 Delay_ms(300);
 UART1_Write_Text( "UART Initialized\r\n" );

 voltage = 0;
 sum = 0;
 measurement = 0;
 calibration = 0;

 Chip_Select = 1;


 SPI1_Init_Advanced( _SPI_MASTER, _SPI_FCY_DIV32, _SPI_CLK_LO_TRAILING );
 Delay_ms(300);
 UART1_Write_Text( "SPI Initialized\r\n" );

 calibration = getADC()/2;

}

unsigned int getADC( void )
{

 char i, buffer;
 volatile unsigned int read, read1, avrg, sum;


 sum = 0;

 for(i=0; i<10; i++ )
 {
 Chip_Select = 0;
 read = SPI1_Read(buffer);
 read1 = SPI1_Read(buffer);
 Chip_Select = 1;
 read = ((read & 0x1F) << 8);
 read = ((read | read1) >> 1);
 sum = sum + read;
 }
 avrg = sum / 10;
 return avrg;
}
