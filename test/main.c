//
// Created by marijn on 2/12/23.
//
#include <stdio.h>

#include "../inc/cpu.h"
#include "../inc/math.h"


void basic_trig(void) {
	f64_t x;
	for (uint8_t i = 0;; i++) {		// loop that roughly divides pi into 255 pieces
		x = (f64_t)i / 0x51; printf("%d:\n", i);
		printf("sin(%f)\t=> %.20f\n", x, sin(x));
		printf("sin32(%f)\t=> %.20f\n", x, sin32(x));
		printf("cos(%f)\t=> %.20f\n", x, cos(x));
		printf("cos32(%f)\t=> %.20f\n", x, cos32(x));
		printf("tan(%f)\t=> %.20f\n", x, tan(x));
		printf("tan32(%f)\t=> %.20f\n", x, tan32(x));
		printf("csc(%f)\t=> %.20f\n", x, csc(x));
		printf("csc32(%f)\t=> %.20f\n", x, csc32(x));
		printf("sec(%f)\t=> %.20f\n", x, sec(x));
		printf("sec32(%f)\t=> %.20f\n", x, sec32(x));
		printf("cot(%f)\t=> %.20f\n", x, cot(x));
		printf("cot32(%f)\t=> %.20f\n", x, cot32(x));
		if (i == 0xff) { break; }  // check at the end to include 0xff
	}
}
void basic_exp(void) {
	f64_t x;
	for (uint8_t i = 0;; i++) {		// loop that roughly divides pi into 255 pieces
		x = (f64_t)i / 0xff; printf("%d:\n", i);
		printf("sqrt(%d)\t\t\t\t=> %.20f\n", i, sqrt(i));
		printf("sqrt32(%d)\t\t\t\t=> %.20f\n", i, sqrt32(i));
		printf("ln(%f)\t\t\t=> %.20f\n", x, ln(x));
		printf("log2(%f)\t\t\t=> %.20f\n", x, log2(x));
		printf("log10(%f)\t\t\t=> %.20f\n", x, log10(x));
		printf("exp(%f)\t\t\t=> %.20f\n", x, exp(x));
		printf("pow(%f, %f)\t=> %.20f\n", x, x, pow(x, x));
		if (i == 0xff) { break; }  // check at the end to include 0xff
	}
}

int main(int argc, char** argv) {
	//basic_trig();
	//basic_exp();

	return 0;
}
