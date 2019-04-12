.global main
.func main
.data

errorMessage: .asciz "Bail Out-wiringPiSetupGpio() has Failed!"
freq: .word 28, 29, 31, 33, 35, 37, 39, 41, 44, 46, 49, 52, 55, 58, 62, 65, $
beginning: .word 0
final: .word 88
regdelay: .word 150
randelay: .word 250

.text
main:
    push {lr}
    bl wiringPiSetupGpio

play:
    mov r0, #25
    bl softToneCreate

    mov r1, #-1
    cmp r0, r1
    bne regloop

    ldr r0, =errorMessage
    bl printf
    b done

playRan:
    mov r0, #25
    bl softToneCreate

    mov r1, #-1
    cmp r0, r1
    bne ranloop

    ldr r0, =errorMessage
    bl printf
    b done

regloop:
    ldr r1, =beginning
    ldr r1, [r1]
    cmp r1, #88
    bne done

    bl softToneWrite

    ldr r0, =delay
    ldr r0, [r0]
    bl regdelay
    add r1, r1, #1

    b regloop
ranloop:
    mov r6, #25
    cmp r5, r6
    bne done

    bl time
    bl sran
    bl rand

    and r0, r0, #127
    cmp r0, #88
    ble true
    sub r0, r0, #39

true:
    mov r8, r0
    ldr r4, = freq
    ldr r1, [r4, r5, lsl, #2]

    cmp r1, r0
    bne done

    bl softToneWrite

    ldr r2, =randealy
    ldr r2, [r2]
    bl randealy
    add r4, r4, #1

done:
    pop {lr}
    bx lr





