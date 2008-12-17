	ldl 0
	mv2reg r100
	ldl 15
	mv2reg r115
	ldl 11
	mv2reg r111
	ldl 24
	mv2reg r124
	ldl 37
	mv2reg r37
	
	ldl 27
	mv2reg r50
	ldl 28
	mv2reg r51
	ldl 46
	mv2reg r49
	
	ldl 80
	mv2reg r7
	
	ldl 0
	ldh 0x20
	mv2reg r5
	
	ldl -1
	ldh -1
	ldl 2
	mv2reg r3


jmri start


fn:
	wrinc r124
	rts





start:
	

	mv2acc r5
	wrinc r115
	jmri fn
	wrinc r115
	jmri fn
	wrinc r115
	wrinc r37
	mv2reg r5
	
	ldl 15
	mv2reg r15
	
	ldl -15
	ldh -1
	!s add r15
	mv2acc r5
	?p EQ wrinc r115
	?p EQ wrinc r111
	?p EQ wrinc r37
	mv2reg r5
	
	ldl -3
	ldh -1
	ldl 3
	mv2reg r7
	
	ldl -3
	ldh -1
	;ldl 3
	mul r7
	
	add r50
	mv2reg r99
	mv2acc r5
	wrinc r99
	
	
	
	







