/*
 * Copyright 2020, NVIDIA CORPORATION.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#include <stdint.h>
#include <stdio.h>

#include "nvbit_reg_rw.h"
#include "utils/utils.h"
#include "pf_injector.h"
#include "arch.h"


extern "C" __device__ __noinline__ void inject_error(uint64_t piinfo, uint64_t pverbose_device, int destGPRNum, int regval, int numDestGPRs, int maxRegs) {

				inj_info_t* inj_info = (inj_info_t*)piinfo; 
				uint32_t verbose_device = *((uint32_t *)pverbose_device);
				
				//check performed on the Straming Multiprocessor ID
				uint32_t smid;
				asm("mov.u32 %0, %smid;" :"=r"(smid));
				if (smid != inj_info->injSMID) 
							return; // This is not the selected SM. No need to proceed.
				
				//not used
				uint32_t nctaidX;
				asm("mov.u32 %0, %nctaid.x;" :"=r"(nctaidX));
				uint32_t nctaidY;
				asm("mov.u32 %0, %nctaid.y;" :"=r"(nctaidY));
				uint32_t nctaidZ;
				asm("mov.u32 %0, %nctaid.z;" :"=r"(nctaidZ));								
				uint32_t ctaidX;
				asm("mov.u32 %0, %ctaid.x;" :"=r"(ctaidX));
				uint32_t ctaidY;
				asm("mov.u32 %0, %ctaid.y;" :"=r"(ctaidY));			
				uint32_t ctaidZ;
				asm("mov.u32 %0, %ctaid.z;" :"=r"(ctaidZ));
				
				
				//Thread ID calculation
				uint32_t threadidX;
				asm("mov.u32 %0, %tid.x;" :"=r"(threadidX));
				uint32_t threadidY;
				asm("mov.u32 %0, %tid.y;" :"=r"(threadidY));
				uint32_t threadidZ;
				asm("mov.u32 %0, %tid.z;" :"=r"(threadidZ));
				uint32_t nthreadidX;
				asm("mov.u32 %0, %ntid.x;" :"=r"(nthreadidX));
				uint32_t nthreadidY;
				asm("mov.u32 %0, %ntid.y;" :"=r"(nthreadidY));
				uint32_t nthreadidZ;
				asm("mov.u32 %0, %ntid.z;" :"=r"(nthreadidZ));
				uint32_t threadid = (threadidZ*nthreadidY*nthreadidX)+(threadidY*nthreadidX)+threadidX;		
	
			
				//check if the thread ID is the same of fault
				if (threadid != inj_info->injThreadID) 					
					return;
				assert(numDestGPRs > 0);
				uint32_t injAfterVal = 0; 
				uint32_t injBeforeVal = nvbit_read_reg(destGPRNum); // read the register value
				if (destGPRNum != inj_info->injReg ) { //ADDED
								injAfterVal = injBeforeVal;
				
				} else {
					if(inj_info->injStuckat == 1){
								injAfterVal = injBeforeVal | (inj_info->injMask); //OR
								nvbit_write_reg(destGPRNum, injAfterVal);
					}
					else {	
								injAfterVal = injBeforeVal & (~inj_info->injMask);//Bug coredumped					
								//injAfterVal = ~injBeforeVal ^ (inj_info->injMask); //NOR				
								nvbit_write_reg(destGPRNum, injAfterVal);
											
					}

				}
				// updating counter/flag to check whether the error was injected
				if (verbose_device) printf("register=%d, before=0x%x, after=0x%x, expected_after=0x%x, mask=0x%x\n", destGPRNum, injBeforeVal, nvbit_read_reg(destGPRNum), injAfterVal, inj_info->injMask);
				inj_info->errorInjected = true; 
				atomicAdd((unsigned long long*) &inj_info->injNumActivations, 1LL);  
}

