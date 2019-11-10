/**************************************
* File: Assignment : part1 solution
* Author: Pavan Kumar G
* Roll number: CS18M517
* Guide: Prof. Madhumutyam IITM, PACE
***************************************/

/*Assignment 5 
  PART 2 - Convert a given eight ASCII characters in the variable STRING to an 8-bit binary number in the variable NUMBER.
  Clear the byte variable ERROR if all the ASICC characters are either ASCII “1” or ASCII “0”;
  otherwise set ERROR to all ones (0xFF).*/
  

		.bss 			@ BSS section
  
		.data			@ DATA SECTION
		
	/*Input:	
		STRING:	.word 0x31
				.word 0x31
				.word 0x30
				.word 0x31
				.word 0x30
				.word 0x30
				.word 0x31
				.word 0x31
				.word 0x30*/
	
	Input:	
		STRING:	.word 0x31
				.word 0x31
				.word 0x30
				.word 0x31
				.word 0x30
				.word 0x37
				.word 0x31
				.word 0x31
				.word 0x30
	
	Output:	
		NUMBER: .word 0x00
		ERROR:  .word 0x00
		
	Length_string: .word(NUMBER - STRING) /4    @length of STRING
		
       .text			@ TEXT section

.globl _main

_main:
	        EOR r0, r0, r0			;@ r0 <-- output number & r1 <-- error  
			EOR r1, r1, r1	
	   
			LDR r2, =Length_string	;@ check input length
			LDR r3, [r2]
	   		CMP r3, #8
			BLT INVALID
	   
			MOV r5, #8				;@ r5 as itr with 8
			LDR r4, =STRING
			
LOOP:         					    
			LDR r3, [r4], #4
			CMP r3, #0x30			;@ CHECK 30h
			BLT INVALID				;@ < 30h, throw error	   
			CMP r3, #0x31			;@ SIMILAR check with 31h
			BGT INVALID
	   
			AND r3, r3, #0x0F		;@ 30h or 31h, getdigit 0 or 1
			MOV r0, r0, LSL #1
			ORR r0, r0, r3
	   
			SUBS r5, r5, #1			;@ Decrement LOOP counter each time
			BNE LOOP				
			BEQ END				


INVALID:    MOV r1, #0xFF			;@ If INVALID occurred, store 0xFF as Error
			EOR r0, r0, r0

END:       	LDR r4, =NUMBER			;@ Load address of NUMBER & store result
			STR r0, [r4]
			LDR r4, =ERROR			;@ Load address of ERROR & store ERROR if any
			STR r1, [r4]
			SWI 0x11
			.end