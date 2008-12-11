init:
	;the character to be printed is =
	ldl 47
	mv2reg r5
		
	ldl 0x00
	ldh 0x20
	mv2reg r3

	ldl 20
	mv2reg r4
	ldl 80
	
	mul r4
	add r4
	add r3
	
	;this contains the address
	mv2reg r2

	;number of characters
	ldl 20
	mv2reg r7

	clr r11
	
	;two stripes of ==========
	ldl 2
	mv2reg r19 

draw: 
	;gets the number of characters from r7
	;gets the memory address where to start from r2
	;zero is available in r11
	
	;print one character
		
	mv2acc r2
	wrinc r5
	mv2reg r2 
	
	;decrement the number of characters
	
	ldl 1
	mv2reg r12
	mv2acc r7
	sub r12
	mv2reg r7
	;
	
	;compare to zero
	!s cmp r11
?p NE jmri draw  
			
	ldl 80
	mv2reg r20
	mv2acc r2
	add r20
	add r20
	sub r4
	mv2reg r2 
	
	ldl 20
	mv2reg r7	
		
	ldl 1
	mv2reg r12
	mv2acc r19
	sub r12
	mv2reg r19
	
	!s cmp r11
?p NE jmri draw
	
	;print text <asr1 2008>
	ldl 6
	mv2reg r77
	;set text 
	clr r21
		
	;A
	ldl 1
	mv2reg r30
	;S	
	ldl 19
	mv2reg r31	
	;R	
	ldl 18
	mv2reg r32
	;" "
	clr    r33
	;2
	ldl 29
	mv2reg r34
	;0
	ldl 27
	mv2reg r35
	;8
	ldl 35
	mv2reg r36
	
	; set memory address
	ldl 80
	mv2reg r55
	
	mv2acc r2
	add r77
	sub r55
	sub r55
	sub r55	   
	
	;actually write
	wrinc r30
	wrinc r31
	wrinc r32
	wrinc r33
	wrinc r34
	wrinc r35
	wrinc r35
	wrinc r36			
		
	ldl -3
