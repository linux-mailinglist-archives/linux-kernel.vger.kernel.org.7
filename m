Return-Path: <linux-kernel+bounces-766609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D001B248F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E780E7BA17C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4D23D2B8;
	Wed, 13 Aug 2025 11:58:35 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E02C1798
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086314; cv=none; b=ljcv5wIqy7Vl8dvN8G22EK7iNgFvP/7cBRvmo7o3Z+kJ4U1CZCm1/2Pv8fXS8Y8SQQxHW8+MAKx+OFNv6UuuChwU34i9L3rMf1lUH1zFk//SCe0MeT1bmfz0IHebrVCjEf+vx3gPFZRfhaBawjiQnFGvPEV4gN1Vd+nBY+X/w0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086314; c=relaxed/simple;
	bh=soO95FIhAbuBe1NtXUFhM5A485GPz0jPJvklQccoIas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvPY4P5YV2hIYyp9baYJmelymTnFy39hJwWNeHOgViv4dFXWeWmJaAsHyloUbFApYkGtztqlllrJ1dsi/x0nx5rcBvOn1QbLmp084mFF1UY1tLOYG2qJJG4areKis6bEb+fDlfUEKuxIZdQLvU0SGZdVbbjSsmFLZDsEZiVXj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id C75EE438E2;
	Wed, 13 Aug 2025 11:58:21 +0000 (UTC)
Message-ID: <44c69df3-9c5b-4c37-bcaa-9a6e47b8bd01@ghiti.fr>
Date: Wed, 13 Aug 2025 13:58:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] riscv: add support for SBI Supervisor Software
 Events extension
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Yunhui Cui <cuiyunhui@bytedance.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
 <20250808153901.2477005-3-cleger@rivosinc.com>
 <c6488202-7721-4f08-8b27-bddbda70296a@ghiti.fr>
 <80e73e9c-2b16-4a6a-91b9-0100d7708fa2@rivosinc.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <80e73e9c-2b16-4a6a-91b9-0100d7708fa2@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeekudehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeefteevgfehfeejveefkeeltdekkeefvdeuleeglefhkedukeejffekuefgtdehjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhsshgvpggvnhhtrhihrdhssgenucfkphepudelfedrfeefrdehjedrudelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleefrdeffedrheejrdduleelpdhhvghloheplgduledvrdduieekrddvvddruddtudgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheptghlvghgvghrsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepl
 hhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohephhgthhgruhhhrghnsehvvghnthgrnhgrmhhitghrohdrtghomhdprhgtphhtthhopegrphgrthgvlhesvhgvnhhtrghnrghmihgtrhhordgtohhm
X-GND-Sasl: alex@ghiti.fr

On 8/13/25 12:47, Clément Léger wrote:
>
> On 13/08/2025 12:09, Alexandre Ghiti wrote:
>> On 8/8/25 17:38, Clément Léger wrote:
>>> The SBI SSE extension allows the supervisor software to be notified by
>>
>> I would change "notified" with "interrupted" no?
>>
>>
>>> the SBI of specific events that are not maskable. The context switch is
>>
>> Nit: s/the SBI/the SBI implementation
>>
>>
>>> handled partially by the firmware which will save registers a6 and a7.
>>> When entering kernel we can rely on these 2 registers to setup the stack
>>> and save all the registers.
>>>
>>> Since SSE events can be delivered at any time to the kernel (including
>>> during exception handling, we need a way to locate the current_task for
>>
>> s/handling/handling)
>>
>>
>>> context tracking. On RISC-V, it is sotred in scratch when in user space
>> s/sotred/stored
>>
>>> or tp when in kernel space (in which case SSCRATCH is zero). But at a
>>
>> Remove "at a"
>>
>>
>>> at the beginning of exception handling, SSCRATCH is used to swap tp and
>>> check the origin of the exception. If interrupted at that point, then,
>>> there is no way to reliably know were is located the current
>>
>> s/were/where
>>
>>
>>> task_struct. Even checking the interruption location won't work as SSE
>>> event can be nested on top of each other so the original interruption
>>> site might be lost at some point. In order to retrieve it reliably,
>>> store the current task in an additional __sse_entry_task per_cpu array.
>>> This array is then used to retrieve the current task based on the
>>> hart ID that is passed to the SSE event handler in a6.
>>>
>>> That being said, the way the current task struct is stored should
>>> probably be reworked to find a better reliable alternative.
>>>
>>> Since each events (and each CPU for local events) have their own
>>
>> "Since each event has its own"
>>
>>
>>> context and can preempt each other, allocate a stack (and a shadow stack
>>> if needed for each of them (and for each cpu for local events).
>>
>> s/needed/needed)
>>
>>
>>> When completing the event, if we were coming from kernel with interrupts
>>> disabled, simply return there. If coming from userspace or kernel with
>>> interrupts enabled, simulate an interrupt exception by setting IE_SIE in
>>> CSR_IP to allow delivery of signals to user task. For instance this can
>>> happen, when a RAS event has been generated by a user application and a
>>> SIGBUS has been sent to a task.
>>>
>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>> ---
>>>    arch/riscv/include/asm/asm.h         |  14 ++-
>>>    arch/riscv/include/asm/scs.h         |   7 ++
>>>    arch/riscv/include/asm/sse.h         |  47 +++++++
>>>    arch/riscv/include/asm/switch_to.h   |  14 +++
>>>    arch/riscv/include/asm/thread_info.h |   1 +
>>>    arch/riscv/kernel/Makefile           |   1 +
>>>    arch/riscv/kernel/asm-offsets.c      |  14 +++
>>>    arch/riscv/kernel/sse.c              | 154 +++++++++++++++++++++++
>>>    arch/riscv/kernel/sse_entry.S        | 180 +++++++++++++++++++++++++++
>>>    9 files changed, 429 insertions(+), 3 deletions(-)
>>>    create mode 100644 arch/riscv/include/asm/sse.h
>>>    create mode 100644 arch/riscv/kernel/sse.c
>>>    create mode 100644 arch/riscv/kernel/sse_entry.S
>>>
>>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>>> index a8a2af6dfe9d..982c4be9a9c3 100644
>>> --- a/arch/riscv/include/asm/asm.h
>>> +++ b/arch/riscv/include/asm/asm.h
>>> @@ -90,16 +90,24 @@
>>>    #define PER_CPU_OFFSET_SHIFT 3
>>>    #endif
>>>    -.macro asm_per_cpu dst sym tmp
>>> -    REG_L \tmp, TASK_TI_CPU_NUM(tp)
>>> -    slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
>>> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
>>> +    slli  \tmp, \cpu, PER_CPU_OFFSET_SHIFT
>>>        la    \dst, __per_cpu_offset
>>>        add   \dst, \dst, \tmp
>>>        REG_L \tmp, 0(\dst)
>>>        la    \dst, \sym
>>>        add   \dst, \dst, \tmp
>>>    .endm
>>> +
>>> +.macro asm_per_cpu dst sym tmp
>>> +    REG_L \tmp, TASK_TI_CPU_NUM(tp)
>>
>> cpu is not xlen-wide, see https://lore.kernel.org/linux-
>> riscv/20250725165410.2896641-3-rkrcmar@ventanamicro.com/. Can you rebase
>> your next version on top my fixes branch which contains this fix? Here
>> it is https://git.kernel.org/pub/scm/linux/kernel/git/alexghiti/
>> linux.git/log/?h=alex-fixes
> Hi Alex,
>
> Acked, I'll fix that.
>
>>
>>> +    asm_per_cpu_with_cpu \dst \sym \tmp \tmp
>>> +.endm
>>>    #else /* CONFIG_SMP */
>>> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
>>> +    la    \dst, \sym
>>> +.endm
>>> +
>>>    .macro asm_per_cpu dst sym tmp
>>>        la    \dst, \sym
>>>    .endm
>>> diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
>>> index 0e45db78b24b..62344daad73d 100644
>>> --- a/arch/riscv/include/asm/scs.h
>>> +++ b/arch/riscv/include/asm/scs.h
>>> @@ -18,6 +18,11 @@
>>>        load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
>>>    .endm
>>>    +/* Load the per-CPU IRQ shadow call stack to gp. */
>>> +.macro scs_load_sse_stack reg_evt
>>> +    REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
>>> +.endm
>>> +
>>>    /* Load task_scs_sp(current) to gp. */
>>>    .macro scs_load_current
>>>        REG_L    gp, TASK_TI_SCS_SP(tp)
>>> @@ -41,6 +46,8 @@
>>>    .endm
>>>    .macro scs_load_irq_stack tmp
>>>    .endm
>>> +.macro scs_load_sse_stack reg_evt
>>> +.endm
>>>    .macro scs_load_current
>>>    .endm
>>>    .macro scs_load_current_if_task_changed prev
>>> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
>>> new file mode 100644
>>> index 000000000000..8929a268462c
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/sse.h
>>> @@ -0,0 +1,47 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (C) 2024 Rivos Inc.
>>> + */
>>> +#ifndef __ASM_SSE_H
>>> +#define __ASM_SSE_H
>>> +
>>> +#include <asm/sbi.h>
>>> +
>>> +#ifdef CONFIG_RISCV_SSE
>>> +
>>> +struct sse_event_interrupted_state {
>>> +    unsigned long a6;
>>> +    unsigned long a7;
>>> +};
>>> +
>>> +struct sse_event_arch_data {
>>> +    void *stack;
>>> +    void *shadow_stack;
>>> +    unsigned long tmp;
>>> +    struct sse_event_interrupted_state interrupted;
>>> +    unsigned long interrupted_phys;
>>> +    u32 evt_id;
>>> +    unsigned int hart_id;
>>> +    unsigned int cpu_id;
>>> +};
>>> +
>>> +static inline bool sse_event_is_global(u32 evt)
>>> +{
>>> +    return !!(evt & SBI_SSE_EVENT_GLOBAL);
>>> +}
>>> +
>>> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt,
>>> int cpu);
>>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32
>>> evt_id,
>>> +            int cpu);
>>> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
>>> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
>>> +
>>> +void sse_handle_event(struct sse_event_arch_data *arch_evt,
>>> +              struct pt_regs *regs);
>>> +asmlinkage void handle_sse(void);
>>> +asmlinkage void do_sse(struct sse_event_arch_data *arch_evt,
>>> +               struct pt_regs *reg);
>>> +
>>> +#endif
>>> +
>>> +#endif
>>> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/
>>> asm/switch_to.h
>>> index 0e71eb82f920..cd1cead0c682 100644
>>> --- a/arch/riscv/include/asm/switch_to.h
>>> +++ b/arch/riscv/include/asm/switch_to.h
>>> @@ -88,6 +88,19 @@ static inline void __switch_to_envcfg(struct
>>> task_struct *next)
>>>                :: "r" (next->thread.envcfg) : "memory");
>>>    }
>>>    +#ifdef CONFIG_RISCV_SSE
>>> +DECLARE_PER_CPU(struct task_struct *, __sse_entry_task);
>>> +
>>> +static inline void __switch_sse_entry_task(struct task_struct *next)
>>> +{
>>> +    __this_cpu_write(__sse_entry_task, next);
>>> +}
>>> +#else
>>> +static inline void __switch_sse_entry_task(struct task_struct *next)
>>> +{
>>> +}
>>> +#endif
>>> +
>>>    extern struct task_struct *__switch_to(struct task_struct *,
>>>                           struct task_struct *);
>>>    @@ -122,6 +135,7 @@ do {                            \
>>>        if (switch_to_should_flush_icache(__next))    \
>>>            local_flush_icache_all();        \
>>>        __switch_to_envcfg(__next);            \
>>> +    __switch_sse_entry_task(__next);            \
>>>        ((last) = __switch_to(__prev, __next));        \
>>>    } while (0)
>>>    diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/
>>> include/asm/thread_info.h
>>> index f5916a70879a..28e9805e61fc 100644
>>> --- a/arch/riscv/include/asm/thread_info.h
>>> +++ b/arch/riscv/include/asm/thread_info.h
>>> @@ -36,6 +36,7 @@
>>>    #define OVERFLOW_STACK_SIZE     SZ_4K
>>>      #define IRQ_STACK_SIZE        THREAD_SIZE
>>> +#define SSE_STACK_SIZE        THREAD_SIZE
>>>      #ifndef __ASSEMBLY__
>>>    diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>> index c7b542573407..62e4490b34ee 100644
>>> --- a/arch/riscv/kernel/Makefile
>>> +++ b/arch/riscv/kernel/Makefile
>>> @@ -99,6 +99,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)    += mcount-dyn.o
>>>    obj-$(CONFIG_PERF_EVENTS)    += perf_callchain.o
>>>    obj-$(CONFIG_HAVE_PERF_REGS)    += perf_regs.o
>>>    obj-$(CONFIG_RISCV_SBI)        += sbi.o sbi_ecall.o
>>> +obj-$(CONFIG_RISCV_SSE)        += sse.o sse_entry.o
>>>    ifeq ($(CONFIG_RISCV_SBI), y)
>>>    obj-$(CONFIG_SMP)        += sbi-ipi.o
>>>    obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-
>>> offsets.c
>>> index 6e8c0d6feae9..315547c3a2ef 100644
>>> --- a/arch/riscv/kernel/asm-offsets.c
>>> +++ b/arch/riscv/kernel/asm-offsets.c
>>> @@ -14,6 +14,8 @@
>>>    #include <asm/ptrace.h>
>>>    #include <asm/cpu_ops_sbi.h>
>>>    #include <asm/stacktrace.h>
>>> +#include <asm/sbi.h>
>>> +#include <asm/sse.h>
>>>    #include <asm/suspend.h>
>>>      void asm_offsets(void);
>>> @@ -528,4 +530,16 @@ void asm_offsets(void)
>>>        DEFINE(FREGS_A6,        offsetof(struct __arch_ftrace_regs, a6));
>>>        DEFINE(FREGS_A7,        offsetof(struct __arch_ftrace_regs, a7));
>>>    #endif
>>> +
>>> +#ifdef CONFIG_RISCV_SSE
>>> +    OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
>>> +    OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stack);
>>> +    OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
>>> +    OFFSET(SSE_REG_HART_ID, sse_event_arch_data, hart_id);
>>> +    OFFSET(SSE_REG_CPU_ID, sse_event_arch_data, cpu_id);
>>> +
>>> +    DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
>>> +    DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
>>> +    DEFINE(ASM_NR_CPUS, NR_CPUS);
>>> +#endif
>>>    }
>>> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
>>> new file mode 100644
>>> index 000000000000..d2da7e23a74a
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/sse.c
>>> @@ -0,0 +1,154 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>> +/*
>>> + * Copyright (C) 2024 Rivos Inc.
>>> + */
>>> +#include <linux/nmi.h>
>>> +#include <linux/scs.h>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/riscv_sse.h>
>>> +#include <linux/percpu-defs.h>
>>> +
>>> +#include <asm/asm-prototypes.h>
>>> +#include <asm/switch_to.h>
>>> +#include <asm/irq_stack.h>
>>> +#include <asm/sbi.h>
>>> +#include <asm/sse.h>
>>> +
>>> +DEFINE_PER_CPU(struct task_struct *, __sse_entry_task);
>>> +
>>> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt,
>>> struct pt_regs *regs)
>>> +{
>>> +}
>>> +
>>> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
>>> +{
>>> +    nmi_enter();
>>> +
>>> +    /* Retrieve missing GPRs from SBI */
>>> +    sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
>>> +          SBI_SSE_ATTR_INTERRUPTED_A6,
>>> +          (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED_A6)
>>> + 1,
>>> +          arch_evt->interrupted_phys, 0, 0);
>>> +
>>> +    memcpy(&regs->a6, &arch_evt->interrupted, sizeof(arch_evt-
>>>> interrupted));
>>> +
>>> +    sse_handle_event(arch_evt, regs);
>>> +
>>> +    /*
>>> +     * The SSE delivery path does not uses the "standard" exception path
>>> +     * (see sse_entry.S) and does not process any pending signal/
>>> softirqs
>>> +     * due to being similar to a NMI.
>>> +     * Some drivers (PMU, RAS) enqueue pending work that needs to be
>>> handled
>>> +     * as soon as possible by bottom halves. For that purpose, set
>>> the SIP
>>> +     * software interrupt pending bit which will force a software
>>> interrupt
>>> +     * to be serviced once interrupts are reenabled in the interrupted
>>> +     * context if they were masked or directly if unmasked.
>>> +     */
>>> +    csr_set(CSR_IP, IE_SIE);
>>> +
>>> +    nmi_exit();
>>> +}
>>> +
>>> +static void *alloc_to_stack_pointer(void *alloc)
>>> +{
>>> +    return alloc ? alloc + SSE_STACK_SIZE : NULL;
>>> +}
>>> +
>>> +static void *stack_pointer_to_alloc(void *stack)
>>> +{
>>> +    return stack - SSE_STACK_SIZE;
>>> +}
>>> +
>>> +#ifdef CONFIG_VMAP_STACK
>>> +static void *sse_stack_alloc(unsigned int cpu)
>>> +{
>>> +    void *stack = arch_alloc_vmap_stack(SSE_STACK_SIZE,
>>> cpu_to_node(cpu));
>>
>> I'm wondering what could happen if, in case of Svvptc, we take a trap in
>> the sse path because the vmalloced stack page table entry is not yet
>> seen by the page table walker, would that be an issue?
> I'll take a look at that but if it trap at the beginning of the SSE
> handler, it's going to clobber anything that wasn't saved. So basically
> fatal. Should I 'touch' the stack itself after allocation to be sure
> it's mapped in the page table ?


Actually no matter svvptc or not, since we don't emit a sfence.vma after 
each vmalloc allocation, we could trap. So maybe in that case the 
simplest solution is to sfence.vma right after the allocation.


>
>>
>>> +
>>> +    return alloc_to_stack_pointer(stack);
>>> +}
>>> +
>>> +static void sse_stack_free(void *stack)
>>> +{
>>> +    vfree(stack_pointer_to_alloc(stack));
>>> +}
>>> +#else /* CONFIG_VMAP_STACK */
>>> +static void *sse_stack_alloc(unsigned int cpu)
>>> +{
>>> +    void *stack = kmalloc(SSE_STACK_SIZE, GFP_KERNEL);
>>> +
>>> +    return alloc_to_stack_pointer(stack);
>>> +}
>>> +
>>> +static void sse_stack_free(void *stack)
>>> +{
>>> +    kfree(stack_pointer_to_alloc(stack));
>>> +}
>>> +#endif /* CONFIG_VMAP_STACK */
>>> +
>>> +static int sse_init_scs(int cpu, struct sse_event_arch_data *arch_evt)
>>> +{
>>> +    void *stack;
>>> +
>>> +    if (!scs_is_enabled())
>>> +        return 0;
>>> +
>>> +    stack = scs_alloc(cpu_to_node(cpu));
>>> +    if (!stack)
>>> +        return -ENOMEM;
>>> +
>>> +    arch_evt->shadow_stack = stack;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt,
>>> int cpu)
>>> +{
>>> +    arch_evt->cpu_id = cpu;
>>> +    arch_evt->hart_id = cpuid_to_hartid_map(cpu);
>>> +}
>>> +
>>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32
>>> evt_id, int cpu)
>>> +{
>>> +    void *stack;
>>> +
>>> +    arch_evt->evt_id = evt_id;
>>> +    stack = sse_stack_alloc(cpu);
>>> +    if (!stack)
>>> +        return -ENOMEM;
>>> +
>>> +    arch_evt->stack = stack;
>>> +
>>> +    if (sse_init_scs(cpu, arch_evt)) {
>>> +        sse_stack_free(arch_evt->stack);
>>> +        return -ENOMEM;
>>> +    }
>>> +
>>> +    if (sse_event_is_global(evt_id)) {
>>> +        arch_evt->interrupted_phys =
>>> +                    virt_to_phys(&arch_evt->interrupted);
>>
>> I may be missing something but I don't see why interrupted could not be
>> a userspace address?
> I'm not sure to follow what you are saying but arch_evt is allocated via
> kzalloc() from the driver layer (see next commit) and is passed to
> arch_sse_init_event(). There is no way for this struct to be
> allocated/passed by userspace.


My bad, I missed the '&'!


>
>>
>>> +    } else {
>>> +        arch_evt->interrupted_phys =
>>> +                per_cpu_ptr_to_phys(&arch_evt->interrupted);
>>> +    }
>>> +
>>> +    arch_sse_event_update_cpu(arch_evt, cpu);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
>>> +{
>>> +    scs_free(arch_evt->shadow_stack);
>>> +    sse_stack_free(arch_evt->stack);
>>> +}
>>> +
>>> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
>>> +{
>>> +    struct sbiret sret;
>>> +
>>> +    sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, arch_evt-
>>>> evt_id,
>>> +             (unsigned long)handle_sse, (unsigned long)arch_evt, 0,
>>> +             0, 0);
>>> +
>>> +    return sbi_err_map_linux_errno(sret.error);
>>> +}
>>> diff --git a/arch/riscv/kernel/sse_entry.S b/arch/riscv/kernel/
>>> sse_entry.S
>>> new file mode 100644
>>> index 000000000000..112bdb7d4369
>>> --- /dev/null
>>> +++ b/arch/riscv/kernel/sse_entry.S
>>> @@ -0,0 +1,180 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (C) 2024 Rivos Inc.
>>> + */
>>> +
>>> +#include <linux/init.h>
>>> +#include <linux/linkage.h>
>>> +
>>> +#include <asm/asm.h>
>>> +#include <asm/csr.h>
>>> +#include <asm/scs.h>
>>> +
>>> +/* When entering handle_sse, the following registers are set:
>>> + * a6: contains the hartid
>>> + * a7: contains a sse_event_arch_data struct pointer
>>> + */
>>> +SYM_CODE_START(handle_sse)
>>> +    /* Save stack temporarily */
>>> +    REG_S sp, SSE_REG_EVT_TMP(a7)
>>> +    /* Set entry stack */
>>> +    REG_L sp, SSE_REG_EVT_STACK(a7)
>>> +
>>> +    addi sp, sp, -(PT_SIZE_ON_STACK)
>>> +    REG_S ra, PT_RA(sp)
>>> +    REG_S s0, PT_S0(sp)
>>> +    REG_S s1, PT_S1(sp)
>>> +    REG_S s2, PT_S2(sp)
>>> +    REG_S s3, PT_S3(sp)
>>> +    REG_S s4, PT_S4(sp)
>>> +    REG_S s5, PT_S5(sp)
>>> +    REG_S s6, PT_S6(sp)
>>> +    REG_S s7, PT_S7(sp)
>>> +    REG_S s8, PT_S8(sp)
>>> +    REG_S s9, PT_S9(sp)
>>> +    REG_S s10, PT_S10(sp)
>>> +    REG_S s11, PT_S11(sp)
>>> +    REG_S tp, PT_TP(sp)
>>> +    REG_S t0, PT_T0(sp)
>>> +    REG_S t1, PT_T1(sp)
>>> +    REG_S t2, PT_T2(sp)
>>> +    REG_S t3, PT_T3(sp)
>>> +    REG_S t4, PT_T4(sp)
>>> +    REG_S t5, PT_T5(sp)
>>> +    REG_S t6, PT_T6(sp)
>>> +    REG_S gp, PT_GP(sp)
>>> +    REG_S a0, PT_A0(sp)
>>> +    REG_S a1, PT_A1(sp)
>>> +    REG_S a2, PT_A2(sp)
>>> +    REG_S a3, PT_A3(sp)
>>> +    REG_S a4, PT_A4(sp)
>>> +    REG_S a5, PT_A5(sp)
>>> +
>>> +    /* Retrieve entry sp */
>>> +    REG_L a4, SSE_REG_EVT_TMP(a7)
>>> +    /* Save CSRs */
>>> +    csrr a0, CSR_EPC
>>> +    csrr a1, CSR_SSTATUS
>>> +    csrr a2, CSR_STVAL
>>> +    csrr a3, CSR_SCAUSE
>>> +
>>> +    REG_S a0, PT_EPC(sp)
>>> +    REG_S a1, PT_STATUS(sp)
>>> +    REG_S a2, PT_BADADDR(sp)
>>> +    REG_S a3, PT_CAUSE(sp)
>>> +    REG_S a4, PT_SP(sp)
>>> +
>>> +    /* Disable user memory access and floating/vector computing */
>>> +    li t0, SR_SUM | SR_FS_VS
>>> +    csrc CSR_STATUS, t0
>>> +
>>> +    load_global_pointer
>>> +    scs_load_sse_stack a7
>>> +
>>> +    /* Restore current task struct from __sse_entry_task */
>>> +    li t1, ASM_NR_CPUS
>>> +    mv t3, zero
>>
>> t1 is only used in find_hart_id_slowpath and shouldn't we use the real
>> number of present cpus instead of NR_CPUS?
> Indeed, that should be moved to the slow path which iterates over
> hart_id_to_cpu_map. This array is sized based on NR_CPUS which is why I
> use NR_CPUS rather than loading some other variable with the count opf
> onlines cpus. Moreover, the slowpath should never loop up to NR_CPUS
> since the SBI must passed a valid hartid index.
>
>> t3 is clobbered by cpu_id below, is that correct?
> In case of !SMP it is kept to zero. But I'll move that in a else below.
>
>>
>>> +
>>> +#ifdef CONFIG_SMP
>>> +    REG_L t4, SSE_REG_HART_ID(a7)
>>> +    REG_L t3, SSE_REG_CPU_ID(a7)
>>
>> hart_id and cpu_id are "unsigned int", not xlen-wide fields so you must
>> use lw here, not REG_L (a lot of bugs lately on the usage of this macro).
> Ouch, thanks for catching that.
>
>>
>>> +
>>> +    bne t4, a6, .Lfind_hart_id_slowpath
>>> +
>>> +.Lcpu_id_found:
>>> +#endif
>>> +    asm_per_cpu_with_cpu t2 __sse_entry_task t1 t3
>>> +    REG_L tp, 0(t2)
>>> +
>>> +    mv a1, sp /* pt_regs on stack */
>>> +
>>> +    /*
>>> +     * Save sscratch for restoration since we might have interrupted the
>>> +     * kernel in early exception path and thus, we don't know the
>>> content of
>>> +     * sscratch.
>>> +     */
>>> +    csrr s4, CSR_SSCRATCH
>>> +    /* In-kernel scratch is 0 */
>>> +    csrw CSR_SCRATCH, x0
>>
>> csrrw s4, CSR_SSCRATCH, x0 instead?
> Ah yeah.
>
> Thanks !
>
> Clément
>
>>
>>> +
>>> +    mv a0, a7
>>> +
>>> +    call do_sse
>>> +
>>> +    csrw CSR_SSCRATCH, s4
>>> +
>>> +    REG_L a0, PT_STATUS(sp)
>>> +    REG_L a1, PT_EPC(sp)
>>> +    REG_L a2, PT_BADADDR(sp)
>>> +    REG_L a3, PT_CAUSE(sp)
>>> +    csrw CSR_SSTATUS, a0
>>> +    csrw CSR_EPC, a1
>>> +    csrw CSR_STVAL, a2
>>> +    csrw CSR_SCAUSE, a3
>>> +
>>> +    REG_L ra, PT_RA(sp)
>>> +    REG_L s0, PT_S0(sp)
>>> +    REG_L s1, PT_S1(sp)
>>> +    REG_L s2, PT_S2(sp)
>>> +    REG_L s3, PT_S3(sp)
>>> +    REG_L s4, PT_S4(sp)
>>> +    REG_L s5, PT_S5(sp)
>>> +    REG_L s6, PT_S6(sp)
>>> +    REG_L s7, PT_S7(sp)
>>> +    REG_L s8, PT_S8(sp)
>>> +    REG_L s9, PT_S9(sp)
>>> +    REG_L s10, PT_S10(sp)
>>> +    REG_L s11, PT_S11(sp)
>>> +    REG_L tp, PT_TP(sp)
>>> +    REG_L t0, PT_T0(sp)
>>> +    REG_L t1, PT_T1(sp)
>>> +    REG_L t2, PT_T2(sp)
>>> +    REG_L t3, PT_T3(sp)
>>> +    REG_L t4, PT_T4(sp)
>>> +    REG_L t5, PT_T5(sp)
>>> +    REG_L t6, PT_T6(sp)
>>> +    REG_L gp, PT_GP(sp)
>>> +    REG_L a0, PT_A0(sp)
>>> +    REG_L a1, PT_A1(sp)
>>> +    REG_L a2, PT_A2(sp)
>>> +    REG_L a3, PT_A3(sp)
>>> +    REG_L a4, PT_A4(sp)
>>> +    REG_L a5, PT_A5(sp)
>>> +
>>> +    REG_L sp, PT_SP(sp)
>>> +
>>> +    li a7, SBI_EXT_SSE
>>> +    li a6, SBI_SSE_EVENT_COMPLETE
>>> +    ecall
>>> +
>>> +#ifdef CONFIG_SMP
>>> +.Lfind_hart_id_slowpath:
>>> +
>>> +/* Slowpath to find the CPU id associated to the hart id */
>>> +la t0, __cpuid_to_hartid_map
>>
>> ^ Missing tab
>>
>>
>>> +
>>> +.Lhart_id_loop:
>>> +    REG_L t2, 0(t0)
>>> +    beq t2, a6, .Lcpu_id_found
>>> +
>>> +    /* Increment pointer and CPU number */
>>> +    addi t3, t3, 1
>>> +    addi t0, t0, RISCV_SZPTR
>>> +    bltu t3, t1, .Lhart_id_loop
>>> +
>>> +    /*
>>> +     * This should never happen since we expect the hart_id to match one
>>> +     * of our CPU, but better be safe than sorry
>>> +     */
>>> +    la tp, init_task
>>> +    la a0, sse_hart_id_panic_string
>>> +    la t0, panic
>>> +    jalr t0
>>> +
>> This newline is not needed ^
>>
>>> +#endif
>>> +
>>> +SYM_CODE_END(handle_sse)
>>> +
>>> +SYM_DATA_START_LOCAL(sse_hart_id_panic_string)
>>> +    .ascii "Unable to match hart_id with cpu\0"
>>> +SYM_DATA_END(sse_hart_id_panic_string)
>>
>> Thanks,
>>
>> Alex
>>

