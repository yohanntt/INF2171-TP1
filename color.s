#
# INF2171 - UQAM
#
# Librairie de manipulation de couleurs
#
# Arguments et valeur de retour:
#
#   a0: couleur a
#   a1: couleur b
#   a0: sortie: a [+-] b
#
# Par simplicité:
#  - Utiliser seulement les registres t0 à t6.
#  - Ne faites pas de sous-routines.
#

.global	color_add color_sub

.text 

color_add:

	li t6,24
	li t5,0xff # valeur saturer au maximum
	li t4,0x00000000 #registre qui contient zero, va contenir la couleur après l'addition
loop:
	srl t0,a0,t6 #shift a droite de argument a
	srl t1,a1,t6 #shift a droite de argument b
	andi t0,t0,0xff #extraction de la valeur dans a
	andi t1,t1,0xff #extraction de la valuer dans b
	beq t0,t5,skip1 # regarde si t0 est egal a une valeur saturer
	beq t1,t5,skip2 # regarde si t1 est egal a une valeur saturer
	add t0,t0,t1  #addition des rouges a et b
	bgt t0,t5,skip4
	sll t0,t0,t6  #decalage de position de la valeur a ajouter dans a0
	add t4,t4,t0  # ajout de la partie de couleur (RGBA) dans t4
	addi t6,t6,-8
	bge t6,zero,loop 
	li a0,0x00000000
	add a0,a0,t4
	ret
	
	
skip1:	
	sll t0,t0,t6  #decalage de position de la valeur a ajouter dans a0
	add t4,t4,t0  # ajout de la partie de couleur (RGBA) dans t4
	addi t6,t6,-8
	bge t6,zero,loop 
	li a0,0x00000000
	add a0,a0,t4
	ret
	

	
skip2:
	sll t1,t1,t6  #decalage de position de la valeur a ajouter dans a0
	add t4,t4,t1  # ajout de la partie de couleur (RGBA) dans t4
	addi t6,t6,-8
	bge t6,zero,loop 
	li a0,0x00000000
	add a0,a0,t4
	ret
	
skip4:
	li t0,0x00
	li t0,0xff
	sll t0,t0,t6  #decalage de position de la valeur a ajouter dans a0
	add t4,t4,t0  # ajout de la partie de couleur (RGBA) dans t4
	addi t6,t6,-8
	bge t6,zero,loop 
	li a0,0x00000000
	add a0,a0,t4
	ret



color_sub:
	
	li t6,24
	li t5,0x00 # valeur minimum d'une couleur
	li t4,0x00000000 #registre vide
loop1:
	srl t0,a0,t6 #shift a droite de argument a
	srl t1,a1,t6 #shift a droite de argument b
	andi t0,t0,0xff
	andi t1,t1,0xff
	beq t0,t5,skip3
	sub t0,t0,t1  #addition des rouges a et b
	blt t0,t5,skip5
	sll t0,t0,t6  #decalage de position
	add t4,t4,t0
	addi t6,t6,-8 #decrementer le compteur 
	bge t6,zero,loop1
	li a0,0x00000000 #mettre a0 a 0 pour ensuite meettre la valeur de retour
	add a0,a0,t4
	ret
	
skip3:
	add t4,t4,t0
	addi t6,t6,-8
	bge t6,zero,loop1
	li a0,0x00000000
	add a0,a0,t4
	ret
		

skip5:
	li t0,0x00
	sll t0,t0,t6  #decalage de position
	add t4,t4,t0  #mettre valeur decaler dans t4
	addi t6,t6,-8
	bge t6,zero,loop1
	li a0,0x00000000
	add a0,a0,t4
	ret	

