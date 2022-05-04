
// --------------------------Standard for interactions
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h> // added this 
#include <fcntl.h>
#include <signal.h>
#include <sys/mman.h>
// #include <Windows.h>
#include "hps_0.h"

#define REG_BASE 0xff200000 //LW H2F Bride Base Address
#define REG_SPAN 0x00200000 //LW H2F Bridge Span
// ------------------------------------------

#define BUFFER_SIZE 20;

#define VGA_BLANK 0
#define VGA_RDY_POS 2
#define VGA_RDX_POS 4
#define VGA_WRY_POS 6
#define VGA_WRX_POS 8
#define VGA_SPRITES 10

// 11, 10, 9, 8, 8, 8, 9, 10, 11 .. 13 
//char offarr8[8] =   { 'O','O','O','O','O','O','O','O','O' };
//char offarr9[9] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
//char offarr10[10] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
//char offarr11[17] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
//char offarr12[15] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O',};
//char offarr13[13] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O'};
// char offarr7[11] = { 'O','O','O','O','O','O','O','O','O','O','O'};
// char offarr8[13] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O'};
// char offarr9[15] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};



//char arr1[9] =   { 'O','O','O','O','O','O','O','O','O' };




/*
// radius of circle
#define RADIUS 10
// HTOTAL - HFRONT_PORCH - HACTIVE
#define LEFT_EDGE 144
// HTOTAL - HFRONT_PORCH
#define RIGHT_EDGE 774
// VTOTAL - VFRONT_PORCH - VACTIVE
#define TOP_EDGE 35
// VTOTAL - VFRONT_PORCH
#define BOTTOM_EDGE 515



*/

void *base;
//uint8_t *clock;
//uint8_t *reset;
uint8_t *layers; // number represents the bits
uint32_t *inStor;
uint8_t *selStor; 
uint16_t *addrStor;
uint8_t *wrStor;
uint32_t *inCons;
uint8_t *wrCons;
uint16_t *addrCons;
uint8_t *prop;
uint32_t *outCons;
uint32_t *outStor;

int fd;

// Defining spaces that will be used to offset the arrays
int space11 = 13;
int space1_10 = 12;
int space2_9 = 11;
int space3_8 = 10;
int space4_8 = 9;
int space5_6_7 = 8;

// defining size of arrays
int size1 = 13;
int size2 = 15;
int size3 = 17;
int size4 = 19;
int size5 = 21;
int size6 = 21;
int size7 = 21;
int size8 = 19;
int size9 = 15;
int size10 = 13;
int size11 = 11;

//defining the arrays
char arr1[13]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr2[15]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr3[17]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr4[19]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr5[21]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr6[21]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr7[21]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr8[19]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr9[15]   = { 'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr10[13] = { 'O','O','O','O','O','O','O','O','O','O','O','O','O'};
char arr11[11] = { 'O','O','O','O','O','O','O','O','O','O','O'};

void display() {
    //displaying the arrays
   
    int i = 0;

   
    printf("\n");
    //offsetting the arrays
    for( i = 0; i < space1_10; i++ ){
        printf(" ");
        if(i == space1_10 - 1)
            printf("(");
    }

    for ( i = 0; i < size1; i++) {
        printf("%c", arr1[i]);
        if(i == size1 - 1)
            printf(")");
    }
    
    printf("\n");
    
    for( i = 0; i < space2_9; i++ ){
        printf(" ");
        if(i == space2_9 - 1)
            printf("(");
    }

    for ( i = 0; i < size2; i++) {
        printf("%c", arr2[i]);
        if(i == size2 - 1)
            printf(")");
    }
    
    printf("\n");
    
    for( i = 0; i < space3_8; i++ ){
        printf(" ");
        if(i == space3_8 - 1)
            printf("(");
    }

    for ( i = 0; i < size3; i++) {
        printf("%c", arr3[i]);
        if(i == size3 - 1)
            printf(")");
    }

    
    printf("\n");
    
    for( i = 0; i < space4_8; i++ ){
        printf(" ");
        if(i == space4_8 - 1)
            printf("(");
    }

    for ( i = 0; i < size4; i++) {
        printf("%c", arr4[i]);
        if(i == size4 - 1)
            printf(")");
    }
        
    
    printf("\n");
    
    for( i = 0; i < space5_6_7; i++ ){
        printf(" ");
        if(i == space5_6_7 - 1)
            printf("(");
    }

    for ( i = 0; i < size5; i++) {
        printf("%c", arr5[i]);
        if(i == size5 - 1)
            printf(")");
    }

       
    
    printf("\n");
    
    for( i = 0; i < space5_6_7; i++ ){
        printf(" ");
        if(i == space5_6_7 - 1)
            printf("(");
    }

    for ( i = 0; i < size6; i++) {
        printf("%c", arr6[i]);
        if(i == size6 - 1)
            printf(")");
    }
        
    
    printf("\n");
    
    for( i = 0; i < space5_6_7; i++ ){
        printf(" ");
        if(i == space5_6_7 - 1)
            printf("(");
    }

    for ( i = 0; i < size7; i++) {
        printf("%c", arr7[i]);
        if(i == size7 - 1)
            printf(")");
    }
    
    printf("\n");
    
    for( i = 0; i < space4_8; i++ ){
        printf(" ");
        if(i == space4_8 - 1)
            printf("(");
    }

    for ( i = 0; i < size8; i++) {
        printf("%c", arr8[i]);
        if(i == size8 - 1)
            printf(")");
    }
        
    
    printf("\n");
    
    for( i = 0; i < space2_9; i++ ){
        printf(" ");
        if(i == space2_9 - 1)
            printf("(");
    }

    for ( i = 0; i < size9; i++) {
        printf("%c", arr9[i]);
        if(i == size9 -1)
            printf(")");
    }

        
    
    printf("\n");
    
    for( i = 0; i < space1_10; i++ ){
        printf(" ");
        if(i == space1_10 - 1)
            printf("(");
    }

    for ( i = 0; i < size10; i++) {
        printf("%c", arr10[i]);
        if(i == size10 - 1)
            printf(")");
    }
    
    printf("\n");
    
    for( i = 0; i < space11; i++ ){
        printf(" ");
        if(i == space11 - 1)
            printf("(");
    }

    for ( i = 0; i < size11; i++) {
        printf("%c", arr11[i]);
        if(i == size11 - 1)
            printf(")");
    }
    printf("\n");
       
    
}





void handler(int signo){
    
    *layers = 0; // number represents the bits
    *inStor = 0;
    *selStor = 0; 
    *addrStor = 0;
    *wrStor = 0;
    *inCons = 0;
    *wrCons = 0;
    *addrCons = 0;
    *prop = 0;
    // *outCons = 0;
    // *outCons = 0;
	munmap(base, REG_SPAN);
	close(fd);
	exit(0);
}

int main(int argc, const char **argv){
	
//    int inputData[BUFFER_SIZE];
//    int i=0;
    unsigned int index = 0;
    unsigned int data = 0;
    unsigned int i = 0;
    unsigned int j = 0;
	

	fd=open("/dev/mem", O_RDWR|O_SYNC);
	if(fd<0){
		printf("Can't open memory\n");
		return -1;
	}
	base=mmap(NULL, REG_SPAN, PROT_READ|PROT_WRITE, MAP_SHARED, fd, REG_BASE);
	if(base==MAP_FAILED){
		printf("Can't map to memory\n");
		close(fd);
		return -1;
	}
    
    layers = (uint8_t*)(base+N_LAYERS_BASE); // number represents the bits
    inStor = (uint32_t*)(base+IN_STORAGE_BASE);
    selStor = (uint8_t*)(base+SEL_STORAGE_BASE); 
    addrStor = (uint16_t*)(base+ADDR_STORAGE_BASE);
    wrStor = (uint8_t*)(base+WR_STORAGE_BASE);
    inCons = (uint32_t*)(base+IN_CONS_BASE);
    wrCons = (uint8_t*)(base+WR_CONS_BASE);
    addrCons = (uint16_t*)(base+ADDR_CONS_BASE);
    prop = (uint8_t*)(base+PROP_BASE);
    outCons = (uint32_t*)(base+OUT_CONS_SPAN);
    outStor= (uint32_t*)(base+OUT_STORAGE_BASE);

	
	signal(SIGINT, handler); //handles crtl+c

// --------------------------Code starts here -----------------

    *layers = 3; // number represents the bits
    *prop = 0;
    *selStor = 0; // input
    *wrStor = 1;
    *wrCons = 1;
    
    usleep(500);


    
//    printf("Input for the first 5 spaces \n");
//    while((scanf("%d",&inputData[i])) == 1)
//    {  
//        runMLP
//       printf("%d\n",a[i]);
//       i++;
//    }  

    // char data[BUFFER_SIZE];
    // fgets(data, BUFFER_SIZE, stdin);
    // while (strcmp(data, "quit\n") != 0) {
    //     //myMethod(data);
    //     runMLP(data);
    //     fgets(data, BUFFER_SIZE, stdin);
    // }

   

    for (i = 0; i < 17; i++)
	{
        for(j = 0; j < 3; j++)
        {
            *inStor = data;
            *addrCons = index; 
            *inCons = i;
            *addrStor = i;

            index++;
            data = data + 5;
            usleep(500);
        }
                
                
    }		

    usleep(500);

    *wrCons = 0;
	
		
    *selStor = 1;
    
    for(i = 0; i < 17; i++)
    {
        *inStor = data; 
        *addrStor = i;
        data <= data + 5;
        
        usleep(500);
    }		
				
	usleep(500);	
     
    *selStor = 2;
    

    for(i = 0; i < 17; i++)
    {
        *inStor = data; 
        *addrStor = i;
        data = data + 5;
        usleep(500);
    }
        

    
    usleep(500);

    *prop = 1;
    //*wrStor = 0;
     
    
    usleep(5000);

    *prop = 0;
    *wrStor = 0;
    
    *selStor = 4;
    
    for(i = 0; i < 17; i++) 
    {
        *addrStor = i;
        usleep(500);
        printf("This is Storage out: %d, Address: %d \n",*outStor,*addrStor );
        // defines which part of the brain is activated by our MLP
        if(i == 0 && *outStor > 1000) // dont go past 13
            arr1[(size1 -1) - 4] = 'x';
        else if (i == 1 && *outStor > 1000)
            arr2[(size2 -1) - 5] = 'x';
        else if (i == 2 && *outStor > 1000)
            arr3[(size3 -1) - 6] = 'x';
        else if (i == 3 && *outStor > 1000)
            arr1[(size1 -1) - 3] = 'x';
        else if (i == 4 && *outStor > 1000)
            arr2[(size2 -1) - 4] = 'x';
        else if (i == 5 && *outStor > 1000)
            arr3[(size3 -1) - 5] = 'x';
        else if (i == 6 && *outStor > 1000)
            arr1[(size1 -1) - 2] = 'x';
        else if (i == 7 && *outStor > 1000)
            arr2[(size2 -1) - 3] = 'x';
        else if (i == 8 && *outStor > 1000)
            arr3[(size3 -1) - 4] = 'x';
        else if (i == 9 && *outStor > 1000)
            arr2[(size2 -1) - 2] = 'x';
        else if (i == 10 && *outStor > 1000)
            arr3[(size3 -1) - 3] = 'x';

    }
    
    display();		
			   	
	return 0;
	
}

runMLP(char datac)
{
    unsigned int index = 0;
    unsigned int data = 0;
    unsigned int i = 0;
    unsigned int j = 0;

    // for (i = 0; input[i] != 0; i++){
    // output[i] = input[i] - '0';
    // }
}





