	;adresse du haut à gauche
	ldl 0
	ldh 0x20
	mv2reg r10
	
	;adresse du caractère à écrire : r99
	
	;contient un 1
	ldl 1
	mv2reg r101
	
	;contient un 0
	clr r100
	
	;contient un -1
	ldl -1
	ldh -1
	mv2reg r48
	
	;caractère '0'
	ldl 27
	mv2reg r50
	
	;caractères +, -, x, ^
	ldl 49
	mv2reg r51
	ldl 46
	mv2reg r49
	ldl 24
	mv2reg r52
	ldl 50
	mv2reg r53
	
	;écriture du polynome : 7x^3-5x^2+9x+2
	ldl 3
	mv2reg r4
	
	;a0 puis a1 puis a2 puis a3
	ldl 2
	mv2reg r80
	ldl 9
	mv2reg r81
	ldl -1
	ldh -1
	mv2reg r82
	ldl 7
	mv2reg r83
	
	;adresse : arbitraire
	ldl 0x50
	mv2reg r5
	wrinc r80
	wrinc r81
	wrinc r82
	wrinc r83
	
	;routine
	
	;addresse de sortie sur l'écran r98
	ldl 85
	add r10
	mv2reg r98
	
	;r91 <- mem[r5+r4]
	mv2acc r4
	add r5
	rd r91
	
	;aff(+-r91)
	mv2acc r91
	!s cmp r100
	add r50
	mv2reg r99
	mv2acc r98
?p LT wrinc r49
?p NE wrinc r99
	mv2reg r98
	mv2acc r4
	add r50
	mv2reg r99
	mv2acc r98
?p NE wrinc r52
?p NE wrinc r53
?p NE wrinc r99
	mv2reg r98
	
	;r4--
	mv2acc r4
	sub r101
	mv2reg r4
	
	
boucle:
	;r91 <- mem[r5+r4]
	mv2acc r4
	add r5
	rd r91
	
	;aff(+-r91)
	!s mv2acc r91
?p LE mul r48
	add r50
	mv2reg r99
	mv2acc r98
?p LT wrinc r49
?p GT wrinc r51
?p NE wrinc r99
	mv2reg r98
	mv2acc r4
	add r50
	mv2reg r99
	mv2acc r98
?p NE wrinc r52
?p NE wrinc r53
?p NE wrinc r99
	mv2reg r98
	
	;r4--
	mv2acc r4
	!s add r100
	sub r101
	mv2reg r4
	
?p NE jmri boucle

nosegfault:
	jmri nosegfault

	
	
	
	
	
	

