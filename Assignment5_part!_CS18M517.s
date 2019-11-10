/**************************************
* File: Assignment : part1 solution
* Author: Pavan Kumar G
* Roll number: CS18M517
* Guide: Prof. Madhumutyam IITM, PACE
***************************************/

/*Assignment 5 
  PART 1 - Convert the contents of a given A_DIGIT variable from an ASCII character to a hexadecimal digit and store the result in H_DIGIT. 
  Assume that A_DIGIT contains the ASCII representation of a hexadecimal digit (i.e., 7 bits with MSB=0).*/
  

		.bss 			@ BSS section
  
		.data			@ DATA SECTION
	Input:	
		A_DIGIT:	.word 0x43		@ ASCII variable
	Output:	
		H_DIGIT:    .word 0x00
		
       .text			@ TEXT section

.globl _main


_main:
	        EOR r5, r5, r5			;@ r5 <-- result 
	   
			LDR r4, =A_DIGIT		;@ Load ASCII variable
			LDRB r1, [r4]			;@ Loading digit 
	   
			CMP r1, #0x30			;@ check Extreme range
			BLT ERROR									   
			CMP r1, #0x66						
			BGT ERROR					   	        
	   
			CMP r1, #0x39			;@ check with 39h
			BLE SAMENUM				;@ 30h < value < 39h, same number 
	   
			CMP r1, #0x41			; @ check  39h < value < 41h then return ERROR
			BLT ERROR				
	   
			CMP r1, #0x61			
			BGE NUMCONVERSION		;@61h < value < 66h, number conversion is needed
			
			CMP r1, #0x46			;@ 46h < value < 61h, return error
			BGT ERROR				
	          
NUMCONVERSION:
			SUB r1, r1, #7			;@ r1-7 if r1 in 41h - 46h or 61h - 66h
	   
SAMENUM: 	AND r5, r1, #0x0F		; @ perform and operation to get the output hex digit
			B END					;@ end the execution & store the result

ERROR:      MOV r5, #0xFF			;@ if ERROR occurred, store 0xFF

END:       	LDR r4, =H_DIGIT		
            STRB r5, [r4]			;@ Store the value in memory
            SWI 0x11				
			.end