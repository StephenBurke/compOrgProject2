.global main
.func main

.data
    buzzer = 15
    gpioSetupErrorMessage: .asciz "Bail out - wiringPiSetupGpio() has failed!"
    gpioSetupErrorCode = -1

    softToneErrorMessage: .asciz "setup softTone failed"
    softToneErrorCode = -1

    frequency: .word 28, 29, 31, 33, 35, 37, 39, 41, 44, 46, 49, 52, 55, 58, 62, 65, 69, 73, 78, 82, 87, 92, 98, 104, 110, 117, 123, 131, 139, 147, 156, 165, 175, 185, 196, 208, 220, 233, 247, 262, 277, 294, 311, 330, 349, 370, 392, 415, 440, 466, 494, 523, 554, 587, 622, 659, 698, 740, 784, 831, 880, 932, 988, 1047, 1109, 1175, 1245, 1319, 1397, 1480, 1568, 1661, 1760, 1865, 1976, 2093, 2217, 2349, 2489, 2637, 2794, 2960, 3136, 3322, 3520, 3729, 3951, 4186


.text
main:
    push {lr}
    bl gpioInit

gpioInitComplete:
    bl playScale
    bl playRandom
    b done

gpioInit:
    push {lr}
    bl wiringPiSetupGpio
    cmp r0, #gpioSetupErrorCode
    bne gpioInitComplete

    ldr r0, = gpioSetupErrorMessage
    bl puts
    mov r0, #gpioSetupErrorCode
    b done

playScale:
    push {lr}
    @this block checks the softTone setup
    mov r0, #buzzer
    bl softToneCreate
    cmp r0, #softToneErrorCode
    bne softToneSuccess
    ldr r0, =softToneErrorMessage
    bl puts
    @making noise
    ldr r2, =frequency
    mov r3, #0

    mov r0, #buzzer
    mov r1, #220
    bl softToneWrite
    mov r0, #250
    bl delay

    pop {lr}
    bx lr 

playRandom:
    push {lr}
    @this block checks the softTone setup
    mov r0, #buzzer
    bl softToneCreate
    cmp r0, #softToneErrorCode
    bne softToneSuccess
    ldr r0, =softToneErrorMessage
    bl puts

    pop {lr}
    bx lr

done: 
    pop {lr}
    bx lr



@ mov r0, (RANDOM NUMBER)
@ mov r1, #88
@ udiv r2, r0, r1 @ R2 <- R0 / R1
@ mul r3, r1, r2, @ R3 <- R1 * R2 
@ sub r0, r0, r3  @ R0 <- R0 - R3 @r3 and r0 were swapped