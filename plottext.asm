	;CONSTANTES
		
		;TOPLEFT
			ldl 0
			ldh 0x20
			mv2reg r5 
	
	;ROUTINES
	jmri main
		
		;ROUTINE PLOTTEXT
			plottext:
			;r15 <- r1 + 80*r2 + r5
				ldl 80
				mul r2
				add r1
				add r5
				mv2reg r15
				
			;r13 <- r3
				mv2acc r3
				mv2reg r13
				
			;r14 <- r4
				mv2acc r4
				mv2reg r14
				
			;Boucle sur r14
				boucle:
					mv2acc r13
					rdinc r99
					mv2reg r13
				
					mv2acc r15
					wrinc r99
					mv2reg r15
				
					ldl -1
					ldh -1
					!s add r14
					mv2reg r14
					
			?p NE jmri boucle
			
			rts

	
	main:
	;PROGRAMME PRINCIPAL
		
		;POSITION : X, Y
			ldl 20
			mv2reg r1
			ldl 5
			mv2reg r2

		;POINTEUR DE TETE
			ldl 0
			ldh 0x04
			mv2reg r3
	
		;LONGUEUR
			ldl 11
			mv2reg r4
	
		;CHARGEMENT DU TEXTE
			;Caractère par caractère, dans les registres
				ldl 16
				mv2reg r20
				ldl 12
				mv2reg r21
				ldl 15
				mv2reg r22
				ldl 20
				mv2reg r23
				ldl 20
				mv2reg r24
				ldl 5
				mv2reg r25
				ldl 24
				mv2reg r26
				ldl 20
				mv2reg r27
				ldl 37
				mv2reg r28
				ldl 15
				mv2reg r29
				ldl 11
				mv2reg r30
			;registres -> mémoire
				mv2acc r3
				wrinc r20
				wrinc r21
				wrinc r22
				wrinc r23
				wrinc r24
				wrinc r25
				wrinc r26
				wrinc r27
				wrinc r28
				wrinc r29
				wrinc r30
		
		jmrisp plottext
	
