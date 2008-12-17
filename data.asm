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
	wrinc r111
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
	
	ldl 5
	mv2reg r2
	
	nop
	nop
	nop
	ldlline
	ldhline
	add r2
	mv2reg r2
	jmri skip
		data 2 15 14 10 15 21 18 37 12 5 19 37 7 5 14 19 37 51 52 51 52 0
	skip:
	
	;r2 : tête de lecture
	;r5 : tête d'écriture

boucle:
	mv2acc r2
	rdinc r99
	mv2reg r2
	mv2acc r99
	!s add r100
	?p NE mv2acc r5
	?p NE wrinc r99
	?p NE mv2reg r5
	?p NE jmri boucle
	
	mv2acc r5
	wrinc r37
	
	

	ldl 0
	jmr r0
	
	
	
	
	
	







