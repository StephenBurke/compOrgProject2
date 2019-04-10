.global main
.func main

.data
    gpioErrorMessage: .asciz "Bail out - wiringPiSetupGpio() has failed!"
    softToneErrorMessage: .asciz "setup softTone failed"
    setupErrorCode = -1


.text
main:
    push {lr}
    bl wiringPiSetupGpio
    cmp r0, #setupErrorCode
    bne init_complete
    ldr r0, = gpioErrorMessage
    bl puts
    mov r0, #setupErrorCode
    b done
    
init_complete:
    buzzerPin = 25


done: 
    pop {lr}
    bx lr

