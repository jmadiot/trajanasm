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
	ldl 7
	mv2reg r80
	ldl -5
	ldh -1
	mv2reg r81
	ldl 9
	mv2reg r82
	ldl 2
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
	!s add r100
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
	mv2acc r91
	!s add r100
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





	;evaluation
	ldl 2
	mv2reg r6
	
	;r7 <- adresse de ai
	mv2acc r4
	add r5
	mv2reg r7
		
	;r9 <- resultat
	clr r9
	
	;r10 <-r4
	mv2acc r4
	mv2reg r10

debut:	
	mv2acc r10
	!s add r100
?p LT jmri fin
	
	;i--	
	sub r101
	mv2reg r10

	; r8 <- ai
	mv2acc r7
	rddec r8
	mv2reg r7
	
	;r9 <- r9*r6+ai
	mv2acc r9
	!s mul r6
?p OV jmri erreur
	!s add r8
?p OV jmri erreur
	mv2reg r9
	jmri debut
	
; a completer.... 
erreur:

fin:


nosegfault:
	jmri nosegfault

	
	
	
	
	
	

