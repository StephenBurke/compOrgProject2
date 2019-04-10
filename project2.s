.global main
.func main

.data
    gpioErrorMessage: .asciz "Bail out - wiringPiSetupGpio() has failed!"
    softToneErrorMessage: .asciz "setup softTone failed"
    gpioSetupErrorCode = -1

.text
main:
    push {lr}
    bl wiringPiSetupGpio
    cmp r0, #gpioSetupErrorCode
    bne gpio_init_complete
    ldr r0, = gpioErrorMessage
    bl puts
    mov r0, #gpioSetupErrorCode
    b done
    
gpio_init_complete:
    push {lr}
    bl 


done: 
    pop {lr}
    bx lr

