//
// Created by marijn on 2/12/23.
//

#ifndef STD_LIB_MATH_H
#define STD_LIB_MATH_H


#include "types.h"

// arithmetic.asm
extern f64 fabs(f64 x);
extern f32 fabs32(f32 x);

// trig.asm
extern f64 sin(f64 x);
extern f32 sin32(f32 x);
extern f64 cos(f64 x);
extern f32 cos32(f32 x);
extern f64 tan(f64 x);
extern f32 tan32(f32 x);
extern f64 csc(f64 x);
extern f32 csc32(f32 x);
extern f64 sec(f64 x);
extern f32 sec32(f32 x);
extern f64 cot(f64 x);
extern f32 cot32(f32 x);

// exp.asm
extern f64 sqrt(f64 x);
extern f32 sqrt32(f32 x);
// log and exp functions are only for f64 because the x87 instruction set does not have any 32 bit versions
extern f64 ln(f64 x);
extern f64 log2(f64 x);
extern f64 log10(f64 x);
extern f64 exp(f64 x);
extern f64 pow(f64 x, f64 y);


#endif //STD_LIB_MATH_H
