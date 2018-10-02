.global patron_volteo_arm_c
patron_volteo_arm_c:
@Prologo
MOV IP,SP
STMDB sp!, {r4-r10,FP,IP,LR,PC}
SUB FP,IP,#4
@cargar los parametros r4-r6 con lo argumentos restantes
ldr r4, [IP]
ldr r5, [IP, #4]
ldr r6, [IP, #8]
mov r7, r0 @guardamos en r7 el tablero (dejando usable r0 para devolver al terminar la funcion)


@valor que devuelve la funcion
mov r0, #1

@Epilogo
SUB SP, FP, #40
LDMIA SP, {r4-r10,FP,SP,PC}

@Fin
.end
#        END
