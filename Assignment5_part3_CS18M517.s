/**************************************
* File: Assignment : part3 solution
* Author: Pavan Kumar G
* Roll number: CS18M517
* Guide: Prof. Madhumutyam IITM, PACE
***************************************/

/*Assignment 5 
  PART 3` - 
  Convert a given eight-digit packed binary-coded-decimal number in the BCDNUM variable into a 32-bit number in a NUMBER variable.
  */
  

		.bss 			@ BSS section
  
		.data			@ DATA SECTION
	Input:	
		BCDNUM:	   .word 0x92529679	
	Output:	
		NUMBER:    .word 0x00
		
       .text			@ TEXT section

.globl _main

_main:
	        EOR r0, r0, r0			;@ r0 <-- result
	        EOR r1, r1, r1			
			
			LDR r4, =BCDNUM			;@ Load the BCDNUM input
			LDR r2, [r4]
			
			MOV r3, #1
			MOV r4, #10				;@ temp variables
			
LOOP:		AND r1, r2, #0x0F		;@ get LSB 4 bits 
			MUL r1, r1, r3			;@ Multiply these 4 bits by the appropriate power of 10
			ADD r0, r0, r1
			MUL r3, r3, r4			;@ Increase power of 10 each time
			MOV r2, r2, LSR #4
			CMP r2, #0				;@ get next  4 bits  & Check for all the bits 
			BNE LOOP
			LDR r4, =NUMBER			;@ Load address of output NUMBER & store value
            STR r0, [r4]
            SWI 0x11				
			.end