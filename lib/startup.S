.syntax unified

/*
  This function serves as the entry point when you turn on or reset your board.
  It will initialise the stack pointer and RAM, and then call your `main` function.
 */
.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    /*
      Constants that start with an underscore are (by convention) defined in the linker script.
      They generally relate to memory locations, which are the linkers job to resolve.

      In this case, the linker defines _stack_end and we use it as the place to start the main stack
     */
    ldr sp, =_stack_end

    @ copy over the .data parts from FLASH to RAM.
    ldr r0, =_data_start_ram     @ where to start copying data to in RAM
    ldr r1, =_data_end_ram       @ where to stop copying data to in RAM
    ldr r2, =_data_start_flash   @ where to start copying data from in FLASH

    cmp r0, r1
    bge CopyDataEnd

    CopyData:
    ldr r3, [r2], 4
    str r3, [r0], 4
    cmp r0, r1
    blt CopyData

    CopyDataEnd:

    @ call the user function entrypoint
    bl main

    /*
      Execution returns here when returning from the `main` function. We use an infinite loop to
      prevent it from trying to run whatever happens to come next in memory!
     */
    ProgramEnd:
    nop
    b ProgramEnd
.size Reset_Handler, . - Reset_Handler

/*
  This function is used as a catch-all exception handler. It is just an infinite loop.
  If your code reaches here, it did something wrong. More information might be found in
  the peripherals section (SCB -> CFSR_UFSR_BFSR_MMFSR)
 */
.global Default_Handler
Default_Handler:
    nop
    b Default_Handler
.size Default_Handler, . - Default_Handler

/*
  The vector table (B1.5.3). It must be placed at the location pointed to by the VTOR (B3.2.5)
  The VTOR defaults to 0, so we configure the linker to put the vector table there
  (via positioning the .rodata.vtable section).
 */
.section .rodata.vtable @ (r)ead-(o)nly(data), the .vtable suffix is just a way to uniquely identify this section in the linker
.word _stack_end
.word Reset_Handler
.word NMI_Handler
.word HardFault_Handler
.word MemManage_Handler
.word BusFault_Handler
.word UsageFault_Handler
.word 0 @ Reserved
.word 0 @ Reserved
.word 0 @ Reserved
.word 0 @ Reserved
.word SVC_Handler
.word DebugMon_Handler
.word 0 @ Reserved
.word PendSV_Handler
.word SysTick_Handler
.word WWDG_IRQHandler
.word PVD_PVM_IRQHandler
.word TAMP_STAMP_IRQHandler
.word RTC_WKUP_IRQHandler
.word FLASH_IRQHandler
.word RCC_IRQHandler
.word EXTI0_IRQHandler
.word EXTI1_IRQHandler
.word EXTI2_IRQHandler
.word EXTI3_IRQHandler
.word EXTI4_IRQHandler
.word DMA1_Channel1_IRQHandler
.word DMA1_Channel2_IRQHandler
.word DMA1_Channel3_IRQHandler
.word DMA1_Channel4_IRQHandler
.word DMA1_Channel5_IRQHandler
.word DMA1_Channel6_IRQHandler
.word DMA1_Channel7_IRQHandler
.word ADC1_2_IRQHandler
.word CAN1_TX_IRQHandler
.word CAN1_RX0_IRQHandler
.word CAN1_RX1_IRQHandler
.word CAN1_SCE_IRQHandler
.word EXTI9_5_IRQHandler
.word TIM1_BRK_TIM15_IRQHandler
.word TIM1_UP_TIM16_IRQHandler
.word TIM1_TRG_COM_TIM17_IRQHandler
.word TIM1_CC_IRQHandler
.word TIM2_IRQHandler
.word TIM3_IRQHandler
.word TIM4_IRQHandler
.word I2C1_EV_IRQHandler
.word I2C1_ER_IRQHandler
.word I2C2_EV_IRQHandler
.word I2C2_ER_IRQHandler
.word SPI1_IRQHandler
.word SPI2_IRQHandler
.word USART1_IRQHandler
.word USART2_IRQHandler
.word USART3_IRQHandler
.word EXTI15_10_IRQHandler
.word RTC_Alarm_IRQHandler
.word DFSDM1_FLT3_IRQHandler
.word TIM8_BRK_IRQHandler
.word TIM8_UP_IRQHandler
.word TIM8_TRG_COM_IRQHandler
.word TIM8_CC_IRQHandler
.word ADC3_IRQHandler
.word FMC_IRQHandler
.word SDMMC1_IRQHandler
.word TIM5_IRQHandler
.word SPI3_IRQHandler
.word UART4_IRQHandler
.word UART5_IRQHandler
.word TIM6_DAC_IRQHandler
.word TIM7_IRQHandler
.word DMA2_Channel1_IRQHandler
.word DMA2_Channel2_IRQHandler
.word DMA2_Channel3_IRQHandler
.word DMA2_Channel4_IRQHandler
.word DMA2_Channel5_IRQHandler
.word DFSDM1_FLT0_IRQHandler
.word DFSDM1_FLT1_IRQHandler
.word DFSDM1_FLT2_IRQHandler
.word COMP_IRQHandler
.word LPTIM1_IRQHandler
.word LPTIM2_IRQHandler
.word OTG_FS_IRQHandler
.word DMA2_Channel6_IRQHandler
.word DMA2_Channel7_IRQHandler
.word LPUART1_IRQHandler
.word QUADSPI_IRQHandler
.word I2C3_EV_IRQHandler
.word I2C3_ER_IRQHandler
.word SAI1_IRQHandler
.word SAI2_IRQHandler
.word SWPMI1_IRQHandler
.word TSC_IRQHandler
.word LCD_IRQHandler
.word 0 @ Reserved
.word RNG_IRQHandler
.word FPU_IRQHandler

/*
  The following sets the above labels to weakly refer to the Default_Handler
  function. Weak means that if you write a function with the same name and marked
  as `.global` then yours will be used instead.
 */
.weak NMI_Handler
.thumb_set NMI_Handler, Default_Handler

.weak HardFault_Handler
.thumb_set HardFault_Handler, Default_Handler

.weak MemManage_Handler
.thumb_set MemManage_Handler, Default_Handler

.weak BusFault_Handler
.thumb_set BusFault_Handler, Default_Handler

.weak UsageFault_Handler
.thumb_set UsageFault_Handler, Default_Handler

.weak SVC_Handler
.thumb_set SVC_Handler, Default_Handler

.weak DebugMon_Handler
.thumb_set DebugMon_Handler, Default_Handler

.weak PendSV_Handler
.thumb_set PendSV_Handler, Default_Handler

.weak SysTick_Handler
.thumb_set SysTick_Handler, Default_Handler

.weak WWDG_IRQHandler
.thumb_set WWDG_IRQHandler, Default_Handler

.weak PVD_PVM_IRQHandler
.thumb_set PVD_PVM_IRQHandler, Default_Handler

.weak TAMP_STAMP_IRQHandler
.thumb_set TAMP_STAMP_IRQHandler, Default_Handler

.weak RTC_WKUP_IRQHandler
.thumb_set RTC_WKUP_IRQHandler, Default_Handler

.weak FLASH_IRQHandler
.thumb_set FLASH_IRQHandler, Default_Handler

.weak RCC_IRQHandler
.thumb_set RCC_IRQHandler, Default_Handler

.weak EXTI0_IRQHandler
.thumb_set EXTI0_IRQHandler, Default_Handler

.weak EXTI1_IRQHandler
.thumb_set EXTI1_IRQHandler, Default_Handler

.weak EXTI2_IRQHandler
.thumb_set EXTI2_IRQHandler, Default_Handler

.weak EXTI3_IRQHandler
.thumb_set EXTI3_IRQHandler, Default_Handler

.weak EXTI4_IRQHandler
.thumb_set EXTI4_IRQHandler, Default_Handler

.weak DMA1_Channel1_IRQHandler
.thumb_set DMA1_Channel1_IRQHandler, Default_Handler

.weak DMA1_Channel2_IRQHandler
.thumb_set DMA1_Channel2_IRQHandler, Default_Handler

.weak DMA1_Channel3_IRQHandler
.thumb_set DMA1_Channel3_IRQHandler, Default_Handler

.weak DMA1_Channel4_IRQHandler
.thumb_set DMA1_Channel4_IRQHandler, Default_Handler

.weak DMA1_Channel5_IRQHandler
.thumb_set DMA1_Channel5_IRQHandler, Default_Handler

.weak DMA1_Channel6_IRQHandler
.thumb_set DMA1_Channel6_IRQHandler, Default_Handler

.weak DMA1_Channel7_IRQHandler
.thumb_set DMA1_Channel7_IRQHandler, Default_Handler

.weak ADC1_2_IRQHandler
.thumb_set ADC1_2_IRQHandler, Default_Handler

.weak CAN1_TX_IRQHandler
.thumb_set CAN1_TX_IRQHandler, Default_Handler

.weak CAN1_RX0_IRQHandler
.thumb_set CAN1_RX0_IRQHandler, Default_Handler

.weak CAN1_RX1_IRQHandler
.thumb_set CAN1_RX1_IRQHandler, Default_Handler

.weak CAN1_SCE_IRQHandler
.thumb_set CAN1_SCE_IRQHandler, Default_Handler

.weak EXTI9_5_IRQHandler
.thumb_set EXTI9_5_IRQHandler, Default_Handler

.weak TIM1_BRK_TIM15_IRQHandler
.thumb_set TIM1_BRK_TIM15_IRQHandler, Default_Handler

.weak TIM1_UP_TIM16_IRQHandler
.thumb_set TIM1_UP_TIM16_IRQHandler, Default_Handler

.weak TIM1_TRG_COM_TIM17_IRQHandler
.thumb_set TIM1_TRG_COM_TIM17_IRQHandler, Default_Handler

.weak TIM1_CC_IRQHandler
.thumb_set TIM1_CC_IRQHandler, Default_Handler

.weak TIM2_IRQHandler
.thumb_set TIM2_IRQHandler, Default_Handler

.weak TIM3_IRQHandler
.thumb_set TIM3_IRQHandler, Default_Handler

.weak TIM4_IRQHandler
.thumb_set TIM4_IRQHandler, Default_Handler

.weak I2C1_EV_IRQHandler
.thumb_set I2C1_EV_IRQHandler, Default_Handler

.weak I2C1_ER_IRQHandler
.thumb_set I2C1_ER_IRQHandler, Default_Handler

.weak I2C2_EV_IRQHandler
.thumb_set I2C2_EV_IRQHandler, Default_Handler

.weak I2C2_ER_IRQHandler
.thumb_set I2C2_ER_IRQHandler, Default_Handler

.weak SPI1_IRQHandler
.thumb_set SPI1_IRQHandler, Default_Handler

.weak SPI2_IRQHandler
.thumb_set SPI2_IRQHandler, Default_Handler

.weak USART1_IRQHandler
.thumb_set USART1_IRQHandler, Default_Handler

.weak USART2_IRQHandler
.thumb_set USART2_IRQHandler, Default_Handler

.weak USART3_IRQHandler
.thumb_set USART3_IRQHandler, Default_Handler

.weak EXTI15_10_IRQHandler
.thumb_set EXTI15_10_IRQHandler, Default_Handler

.weak RTC_Alarm_IRQHandler
.thumb_set RTC_Alarm_IRQHandler, Default_Handler

.weak DFSDM1_FLT3_IRQHandler
.thumb_set DFSDM1_FLT3_IRQHandler, Default_Handler

.weak TIM8_BRK_IRQHandler
.thumb_set TIM8_BRK_IRQHandler, Default_Handler

.weak TIM8_UP_IRQHandler
.thumb_set TIM8_UP_IRQHandler, Default_Handler

.weak TIM8_TRG_COM_IRQHandler
.thumb_set TIM8_TRG_COM_IRQHandler, Default_Handler

.weak TIM8_CC_IRQHandler
.thumb_set TIM8_CC_IRQHandler, Default_Handler

.weak ADC3_IRQHandler
.thumb_set ADC3_IRQHandler, Default_Handler

.weak FMC_IRQHandler
.thumb_set FMC_IRQHandler, Default_Handler

.weak SDMMC1_IRQHandler
.thumb_set SDMMC1_IRQHandler, Default_Handler

.weak TIM5_IRQHandler
.thumb_set TIM5_IRQHandler, Default_Handler

.weak SPI3_IRQHandler
.thumb_set SPI3_IRQHandler, Default_Handler

.weak UART4_IRQHandler
.thumb_set UART4_IRQHandler, Default_Handler

.weak UART5_IRQHandler
.thumb_set UART5_IRQHandler, Default_Handler

.weak TIM6_DAC_IRQHandler
.thumb_set TIM6_DAC_IRQHandler, Default_Handler

.weak TIM7_IRQHandler
.thumb_set TIM7_IRQHandler, Default_Handler

.weak DMA2_Channel1_IRQHandler
.thumb_set DMA2_Channel1_IRQHandler, Default_Handler

.weak DMA2_Channel2_IRQHandler
.thumb_set DMA2_Channel2_IRQHandler, Default_Handler

.weak DMA2_Channel3_IRQHandler
.thumb_set DMA2_Channel3_IRQHandler, Default_Handler

.weak DMA2_Channel4_IRQHandler
.thumb_set DMA2_Channel4_IRQHandler, Default_Handler

.weak DMA2_Channel5_IRQHandler
.thumb_set DMA2_Channel5_IRQHandler, Default_Handler

.weak DFSDM1_FLT0_IRQHandler
.thumb_set DFSDM1_FLT0_IRQHandler, Default_Handler

.weak DFSDM1_FLT1_IRQHandler
.thumb_set DFSDM1_FLT1_IRQHandler, Default_Handler

.weak DFSDM1_FLT2_IRQHandler
.thumb_set DFSDM1_FLT2_IRQHandler, Default_Handler

.weak COMP_IRQHandler
.thumb_set COMP_IRQHandler, Default_Handler

.weak LPTIM1_IRQHandler
.thumb_set LPTIM1_IRQHandler, Default_Handler

.weak LPTIM2_IRQHandler
.thumb_set LPTIM2_IRQHandler, Default_Handler

.weak OTG_FS_IRQHandler
.thumb_set OTG_FS_IRQHandler, Default_Handler

.weak DMA2_Channel6_IRQHandler
.thumb_set DMA2_Channel6_IRQHandler, Default_Handler

.weak DMA2_Channel7_IRQHandler
.thumb_set DMA2_Channel7_IRQHandler, Default_Handler

.weak LPUART1_IRQHandler
.thumb_set LPUART1_IRQHandler, Default_Handler

.weak QUADSPI_IRQHandler
.thumb_set QUADSPI_IRQHandler, Default_Handler

.weak I2C3_EV_IRQHandler
.thumb_set I2C3_EV_IRQHandler, Default_Handler

.weak I2C3_ER_IRQHandler
.thumb_set I2C3_ER_IRQHandler, Default_Handler

.weak SAI1_IRQHandler
.thumb_set SAI1_IRQHandler, Default_Handler

.weak SAI2_IRQHandler
.thumb_set SAI2_IRQHandler, Default_Handler

.weak SWPMI1_IRQHandler
.thumb_set SWPMI1_IRQHandler, Default_Handler

.weak TSC_IRQHandler
.thumb_set TSC_IRQHandler, Default_Handler

.weak LCD_IRQHandler
.thumb_set LCD_IRQHandler, Default_Handler

.weak RNG_IRQHandler
.thumb_set RNG_IRQHandler, Default_Handler

.weak FPU_IRQHandler
.thumb_set FPU_IRQHandler, Default_Handler
