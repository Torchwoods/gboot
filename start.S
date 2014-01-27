.text
.global _start
_start:
    b   reset
    ldr pc, _Undefined_instructions
    ldr pc,  _SoftWare_Interrupt
    ldr pc,  _Prefetch_Abort
    ldr pc,  _Data_Abort
    ldr pc,  _Not_Used
    ldr pc,  _IRQ
    ldr pc,  _FIQ
_Undefined_instructions: .word Undefined_instructions
_SoftWare_Interrupt: .word SoftWare_Interrupt
_Prefetch_Abort: .word Prefetch_Abort
_Data_Abort: .word Data_Abort
_Not_Used: .word Not_Used
_IRQ: .word IRQ
_FIQ: .word FIQ
Undefined_instructions:
    nop
SoftWare_Interrupt:
    nop
Prefetch_Abort:
    nop
Data_Abort:
    nop
Not_Used:
    nop
IRQ:
    nop
FIQ:
    nop

reset:
    bl setSVC
    bl disable_watchdog
    bl disable_interrupt
    bl disable_mmu
setSVC:
    mrs r0,cpsr
    bic r0,r0,#0x1f
    orr r0,r0,#0xd3
    msr cpsr,r0
    mov pc,lr
#define pWTCON  0X7E004000
disable_watchdog:
    ldr r0,=pWTCON
    mov r1,#0x0
    str r1,[r0]
    mov pc,lr
#define VIC0    0X71200014
#define VIC1    0X71300014
disable_interrupt:
    MVN R1,#0x0
    LDR R0,=VIC0
    STR R1,[R0]

    LDR R0,=VIC1
    STR R1,[R0]
    MOV PC,LR
disable_mmu:
    mcr p15,0,r0,c7,c7,0
    mrc p15,0,r0,c1,c0,0
    bic r0,r0,#0x00000007
    mcr p15,0,r0,c1,c0,0
    mov pc,lr
