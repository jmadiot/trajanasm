	
	;TOPLEFT
		ldl 0
		ldh 0x20
		mv2reg r5
	
	;CARACTERES r52 = '*' r53 = ' '
		ldl 54
		mv2reg r52
		ldl 37
		mv2reg r53
	
	;CONSTANTES r80=80; r82=60; r81=1; r79=-1
		ldl 80
		mv2reg r80
		ldl 1
		mv2reg r81
		ldl -1
		ldh -1
		mv2reg r79
		ldl 60
		mv2reg r82


	;ADRESSE DU PREMIER FLOCON
		ldl 0x00
		ldh 0x10
		mv2reg r15
		mv2reg r16
	

	;POSITION PRECEDENTE
		ldl -64
		ldh 0x12
		add r5
		mv2reg r22


	;UTILISER canon.ml POUR GENERER LE CODE DES FLOCONS DE NEIGE CI-DESSOUS
	
	
	


	;NUMBER OF SNOW FLAKES
		ldl 20
		mv2reg r14

	;FLOCON #0
		;POSITION x,y
			ldl 74
			mv2reg r20
			ldl 27
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #1
		;POSITION x,y
			ldl 5
			mv2reg r20
			ldl 40
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #2
		;POSITION x,y
			ldl 36
			mv2reg r20
			ldl 20
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 14
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #3
		;POSITION x,y
			ldl 40
			mv2reg r20
			ldl 15
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #4
		;POSITION x,y
			ldl 34
			mv2reg r20
			ldl 2
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 18
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #5
		;POSITION x,y
			ldl 2
			mv2reg r20
			ldl 20
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #6
		;POSITION x,y
			ldl 20
			mv2reg r20
			ldl 40
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #7
		;POSITION x,y
			ldl 28
			mv2reg r20
			ldl 29
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 6
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #8
		;POSITION x,y
			ldl 65
			mv2reg r20
			ldl 42
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 12
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #9
		;POSITION x,y
			ldl 12
			mv2reg r20
			ldl 21
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 21
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #10
		;POSITION x,y
			ldl 72
			mv2reg r20
			ldl 36
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 4
			mv2reg r24
		;PERIODE
			ldl 3
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #11
		;POSITION x,y
			ldl 6
			mv2reg r20
			ldl 25
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 10
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #12
		;POSITION x,y
			ldl 46
			mv2reg r20
			ldl 56
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 0
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #13
		;POSITION x,y
			ldl 15
			mv2reg r20
			ldl 44
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 6
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #14
		;POSITION x,y
			ldl 64
			mv2reg r20
			ldl 0
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 2
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #15
		;POSITION x,y
			ldl 64
			mv2reg r20
			ldl 30
			mv2reg r21
		;VITESSE
			ldl -1
			ldh -1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 19
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #16
		;POSITION x,y
			ldl 17
			mv2reg r20
			ldl 12
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 3
			mv2reg r24
		;PERIODE
			ldl 13
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #17
		;POSITION x,y
			ldl 57
			mv2reg r20
			ldl 42
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 8
			mv2reg r24
		;PERIODE
			ldl 15
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #18
		;POSITION x,y
			ldl 32
			mv2reg r20
			ldl 51
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 1
			mv2reg r24
		;PERIODE
			ldl 12
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16

	;FLOCON #19
		;POSITION x,y
			ldl 76
			mv2reg r20
			ldl 13
			mv2reg r21
		;VITESSE
			ldl 1
			mv2reg r23
		;TIMER
			ldl 5
			mv2reg r24
		;PERIODE
			ldl 8
			mv2reg r25
		;STOCKAGE
			mv2acc r16
			wrinc r20
			wrinc r21
			wrinc r22
			wrinc r23
			wrinc r24
			wrinc r25
			mv2reg r16




	
	
	;FIN DU CODE GENERE AUTOMATIQUEMENT
	




	
	;BOUCLE D'AFFICHAGE
	aff:
		
		mv2acc r14
		mv2reg r34
		
		mv2acc r15
		mv2reg r16
		
		;BOUCLE DE PARCOURS DES FLOCONS
		flocon:
			
			;CHARGEMENT DES DONNEES DU FLOCON
				mv2acc r16
				rdinc r20
				rdinc r21
				rdinc r22
				rdinc r23
				rdinc r24
				rdinc r25
			
			;TIMER
				mv2acc r24
				!s sub r81
					;SI NUL REINITIALISER
					?p LE mv2acc r25
				mv2reg r24
				;SI NUL INVERSER LA VITESSE r23
					?p LE mv2acc r23
					?p LE mul r79
					?p LE mv2reg r23
			
			;EFFACER LE FLOCON PRECEDENT
				mv2acc r22
				wr r53
			
			;MAJ FLOCON
				mv2acc r20
				add r23
				mv2reg r20
				
				mv2acc r21
				add r81
				mv2reg r21
				!s sub r82
				?p GT clr r21
			
			;AFFICHER LE FLOCON
				ldl 80
				mul r21
				add r20
				add r5
				wr r52
				mv2reg r22
			
			;SAUVEGARDE DES DONNEES DU FLOCON
				mv2acc r16
				wrinc r20
				wrinc r21
				wrinc r22
				wrinc r23
				wrinc r24
				wrinc r25
				mv2reg r16
			
			;COMPTEUR
				mv2acc r34
				!s sub r81
				mv2reg r34
			
				
		?p GT jmri flocon

	jmri aff
	
