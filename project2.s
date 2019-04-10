.global main
.func main

.data
    errorMessage: .asciz "Bail out - wiringPiSetupGpio() has failed!"
    setupErrorCode = -1

    softToneErrorMessage: .asciz "setup softTone failed"


.text
main:
    push {lr}
    bl wiringPiSetupGpio
    cmp r0, #setupErrorCode
    bne init_complete
    ldr r0, = errorMessage
    bl puts
    mov r0, #setupErrorCode
    b done
    
init_complete:
    push {lr}
    b playScale
    b playRandom

playScale:

playRandom:

done: 
    pop {lr}
    bx lr



@ mov r0, (RANDOM NUMBER)
@ mov r1, #88
@ udiv r2, r0, r1 @ R2 <- R0 / R1
@ mul r3, r1, r2, @ R3 <- R1 * R2 
@ sub r0, r0, r3  @ R0 <- R0 - R3 @r3 and r0 were swapped