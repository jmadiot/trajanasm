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
	
	;caractères n,p,space,z
	ldl 14
	mv2reg r55
	ldl 16
	mv2reg r56
	ldl 37
	mv2reg r57
	ldl 26
	mv2reg r58
	
	;écriture du polynome : 7x^3-5x^2+9x+1
	ldl 6
	mv2reg r4
	
	;a0 puis a1 puis a2 puis a3
	ldl 1
	mv2reg r80
	ldl 8
	mv2reg r81
	ldl -1
	ldh -1
	mv2reg r82
	ldl 7
	mv2reg r83
	ldl 9
	mv2reg r84
	ldl -5
	ldh -1
	mv2reg r85
	ldl 8
	mv2reg r86
	
	;adresse de stockage du polynome : arbitraire
	ldl 0x50
	mv2reg r5
	wrinc r80
	wrinc r81
	wrinc r82
	wrinc r83
	wrinc r84
	wrinc r85
	wrinc r86

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
	
	;r48 <- abs(r91)
	;r99 <- caractère de r48
	mv2acc r91
	!s add r100
	?p LE mul r48
	mv2reg r97
	add r50
	mv2reg r99
	mv2acc r98

	;Affichage du signe de toutes façons.
	?p LT wrinc r49
	?p GT wrinc r51

	;Affichage ou non du coefficient : coefficient!=1 ou exposant=0 :
	?p EQ jmri skip3
		mv2reg r98
		mv2acc r97
		!s sub r101
		?p NE jmri skip4
				mv2acc r4
				!s add r100
				ldl 1
				?p EQ jmri skip5
					ldl 0
				skip5:
				!s add r100
		skip4:
		mv2acc r98
	skip3:
	
	?p NE wrinc r99
	mv2reg r98
	
	;Affichage du X ?
	mv2acc r4
	!s add r100
	add r50
	mv2reg r99
	mv2acc r98
?p NE wrinc r52

	;Affichage du ^i ?
	?p EQ jmri skip2
		mv2reg r98
		mv2acc r4
		!s sub r101
		mv2acc r98
	skip2:
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

	
	
	
	
	
	

