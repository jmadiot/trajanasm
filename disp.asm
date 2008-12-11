	ldl 0
	mv2reg r10
	ldl 1
	mv2reg r11
	ldl 2
	mv2reg r12
	ldl 10
	mv2reg r13
	ldl 20
	mv2reg r14
	ldl 80
	mv2reg r15

	ldl 1
	mv2reg r9
	
plot:
	ldl 80
	mul r2
	add r1
	add r5
	wrinc r3
	
	!s mv2acc r9
	
	?p EQ rts
	;?p EQ jmri end

	clr r9

init:
	ldl 0
	ldh 0x20
	mv2reg r5
	
	ldl 31
	mv2reg r101
	ldl 29
	mv2reg r102
	
	mv2acc r5
	wrinc r101
	wrinc r102
	mv2acc r5
	add r15
	wrinc r101
	wrinc r102
	
	ldl 10
	mv2reg r3
	ldl 39
	mv2reg r1
	ldl 29
	mv2reg r2
	
	jmri plot
	
end:
	
	
	
	

