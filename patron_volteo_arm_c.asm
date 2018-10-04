.global patron_volteo_arm_c
.extern ficha_valida
patron_volteo_arm_c:
@Prologo
MOV IP,SP
STMDB sp!, {r4-r10,FP,IP,LR,PC}
SUB FP,IP,#4

mov r4, r0			@tablero
mov r5, r1			@r5=*longitud
mov r6, r2			@r6=FA
mov r7, r3			@r7=CA

@cargar los parametros r4-r6 con lo argumentos restantes
ldr r8, [IP]		@r8=SF
ldr r9, [IP, #4]	@r9=SC
ldr r10, [IP, #8]	@r10=color

add r6, r6, r8		@FA = FA + SF
add r7, r7, r9		@CA = CA + SC

and r6, r6, #0xFF
and r7, r7, #0xFF

@Llamada a ficha_valida (primero paso de parametros)
@a1=tablero (ya esta en r0)
mov r1, r6 			@a2=FA
mov r2, r7			@a3=CA
sub sp, sp, #4		@dejamos un espacio en la pila para posicion_valida
mov r3, sp			@r3=&posicion_valida
bl ficha_valida		@devuelve en r0 el valor de "casilla"

ldr r3, [sp]		@guardamos en r3 el contenido de posicion_valida
add sp, sp, #4		@volvemos a dejar libre el hueco en la pila
cmp r3, #1			@posicion_valida==1?
bne	pos_invalida
cmp r0, r10			@casilla==color?
beq casilla_igual_color
mov r5, r0 			@(posicion_valida == 1) && (casilla != color)

cmp r5, #0
bne patron_encontrado
mov r0, #0
bl fin_patron_volteo_arm_c

patron_encontrado:
mov r0, #1
bl fin_patron_volteo_arm_c


casilla_igual_color:
@(posicion_valida == 1) && (casilla == color)
ldr r0, [r5]
add r0, r0, #1
str r0, [r5]

mov r0, r4
mov r1, r5
mov r2, r6
mov r3, r7
bl patron_volteo_arm_c


pos_invalida:
@(posicion_valida != 1)
mov r0, #0			@la funcion devuelve 0 (patron no encontrado)



fin_patron_volteo_arm_c:
@Epilogo
SUB SP, FP, #40
LDMIA SP, {r4-r10,FP,SP,PC}

@Fin
.end
#        END
