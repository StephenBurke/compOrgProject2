#include <stdio.h>
#include <stdlib.h>
#include "wiringPi.h"
#include "softTone.h"
#define buzzer 25
int frequency [] = {28, 29, 31, 33, 35, 37, 39, 41, 44, 46, 49, 52, 55, 58, 62, 65, 69, 73, 78, 82, 87, 92, 98, 104, 110, 117, 123, 131, 139, 147, 156, 165, 175, 185, 196, 208, 220, 233, 247, 262, 277, 294, 311, 330, 349, 370, 392, 415, 440, 466, 494, 523, 554, 587, 622, 659, 698, 740, 784, 831, 880, 932, 988, 1047, 1109, 1175, 1245, 1319, 1397, 1480, 1568, 1661, 1760, 1865, 1976, 2093, 2217, 2349, 2489, 2637, 2794, 2960, 3136, 3322, 3520, 3729, 3951, 4186};

void playScale(int start, int finish, int delayFactor);
void playRandom(int numNotes, int delayFactor);

int main(){
    if(wiringPiSetupGpio() == -1){
        printf("Bail out - wiringPiSetupGpio() has failed!\n");
        return -1;
    }
    playScale(0, 88, 125); // all the notes in frequency from 0 to 87, with a 125ms delay
    playRandom(25, 250); // 25 notes picked at random, with a 250ms delay
    return 0;
}

void playScale(int start, int finish, int delayFactor){
    if(softToneCreate(buzzer) == -1){
        printf("Setup softTone failed");
        return;
    }
    int note = start;
    while(note < finish, delayFactor){
        softToneWrite(buzzer, frequency[note]);
        delay(delayFactor);
        note++;
    }
}

void playRandom(int numNotes, int delayFactor){
    if(softToneCreate(buzzer) == -1){
        printf("Setup softTone failed");
        return;
    }
    int i = 0;
    while(i < numNotes) {
        softToneWrite(buzzer, frequency[rand() % 88]);
        delay(delayFactor);
        i++;
    }
}