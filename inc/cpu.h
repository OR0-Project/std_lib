//
// Created by marijn on 3/3/23.
//

#ifndef STD_LIB_SYS_H
#define STD_LIB_SYS_H


#include "defs.h"

// TODO: refine these
// https://wiki.osdev.org/CPUID
// https://en.wikipedia.org/wiki/CPUID
// https://c9x.me/x86/html/file_module_x86_id_45.html
#define VENDOR_ID									0x00000000
#define CPU_INFO									0x00000001
#define TLB_INFO									0x00000002	// TODO
#define SERIAL_NUMBER								0x00000003
#define DETERMINISTIC_CACHE_INFO					0x00000004	// TODO
#define MWAIT_MONITOR_INFO							0x00000005	// TODO
#define THERMAL_INFO								0x00000006	// TODO
#define EXTENDED_FEATURE_INFO						0x00000007	// TODO

#define EXTENDED_LEAF_INFO							0x80000000	// TODO
#define EXTENDED_FEATURE_INFO						0x80000001	// TODO
#define BRAND_STRING0								0x80000002
#define BRAND_STRING1								0x80000003
#define BRAND_STRING2								0x80000004
#define L1_CACHE_INFO								0x80000005	// TODO
#define L2_CACHE_INFO								0x80000006	// TODO
#define POWER_MANAGEMENT_INFO						0x80000007	// TODO
#define ADDRESS_SIZES								0x80000008	// TODO
#define ENCRYPTED_MEMORY_INFO						0x8000001F	// TODO
#define EXTENDED_FEATURE3_INFO						0x80000021	// TODO

#define AMD_EASTER_EGG								0x8FFFFFFF	// TODO


extern void cpu_id(uint64_t leaf, uint32_t* eax, uint32_t* ebx, uint32_t* ecx, uint32_t* edx);


#endif //STD_LIB_SYS_H
