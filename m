Return-Path: <linux-kernel+bounces-789783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18559B39A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A191C22351
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147FF30C61B;
	Thu, 28 Aug 2025 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="IJJJU+mU"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF530C60A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756378085; cv=none; b=hZMQE2BW8aRrMzoDvDZteybvSPDv6vEXMKGqgWmghp1yuOxHsjBrUkx868cTpsdgzFl4O7KCX/v1nBU98xIRdGBOHezyraEo8/NNcAy9slRNLPnbPaUzgyOjMesEaAuddMLBrTGOQ7GvcIopvBBGxot93qwIipn/g9/+B/BKE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756378085; c=relaxed/simple;
	bh=Zlwoh+qa6SilypL4zeShmNK0fRUZrxTorgAzE0eTKAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUJ/T9HItVxg2MswvEaEsO+NwgSJEW9MGrqP/4QSlWmJbCwzufC9p+AFQKvde7uC8kw6XIWybOqPj23eDpLdZLbEQfx07cEDEpEdM/4cMZj+srjvPW4IzE3YiLXbtt0wn4pZsZI7E4Ggs7BAZ9rKilPsAskZR5iwBowe9DscZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=IJJJU+mU; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7720c7cc05fso589204b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756378083; x=1756982883; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtGthQ0upOgEQqzx2TwZo3OjqznpTQZNr4AegOn3my4=;
        b=IJJJU+mUua3l+WKATbJeoFjApmDuOxOkcbTYdGNbWZeUrvWaD9XZboQ7QaXKg6UgMw
         K5FePFi5MrFuoECD3QUWTPmhex4UybRa7RBJToe+CvoLLo4Sg0vYPbP+VdRPcimCgMOT
         ib+JwjBO3HjafvGzLX4HJNY+ubrQxgQkGPntoWCkknAWLRcwa5LHAs47MXB1lQ3FDAJk
         3HVMcQZ01p4FIPBYq29uHZRk6/TARmiJIMfO4WVmsbPYlHiiqqDzl2IIi7Bok2hrbUii
         rfne0Ig/1N+P7tzSL2Pi8ZaBqNh7yIFqR7AzhSOUXHW5dWQW97WKUurF9GhNgx0kQrLe
         jiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756378083; x=1756982883;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGthQ0upOgEQqzx2TwZo3OjqznpTQZNr4AegOn3my4=;
        b=QFPkeX4oUPOWaP1cyLj2s7IEpBSRxwTs1Q/5Mm+yzAuxUH5O3pS5EPcQYUDQSHWl4R
         o+SrsDDfEa7rUVRBU8UM+CKWysMUEm6nRsBgip3LYxOK1tjpEumHz84d717cEXi8ocSZ
         kPDd75bf4967LC147sbfH+I2+ZwpXLJEmHb4cQb5kuIRw72hbGsrS4tvWV+hudYisFX9
         U8L/xzBv6AbPyu7K4VPr1UbDwdX6pMwcTR3612CgdVyRGxzBCnpn6cEw3yvbg4CvAJZj
         KZYM++QSEuqfid1sdRiLOlVEhCcDOEF4ooyWK+5N+pm8O7g+mJoGXj0zz/2AGWE8J+fg
         J21g==
X-Forwarded-Encrypted: i=1; AJvYcCXAO72XjdPy1lczgYxArXxzh2LPOhBgClp6FIVQ+n8LCWFfJ/R2YdwwT+fsSp5rcWIJ1MOSrm/MNEJwP70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKyv6JYs5zgVZJNcn7h+dDJNR38HGwF6lXb5ZqgdCpPNf0zVnT
	sGYZ0jSfjerq7HSfsLF9U1/vEIbJK2RiPj5sq4/i3tsiarXiInF2F3i1VL6NcJWOepU=
X-Gm-Gg: ASbGncsFOIYU9XpMeEByw8eeV69AT1f0hVbEJPJy7AXkxtMW2mE7gDe1I4ltQXrb/nQ
	1Gmh5Ub1zSLAD9Twv4BmIGoDqJ7wUEDprJ7OFkhKF8wwO0gvqnQtTqI8IcJ6tOcLcL+0LD5wGBU
	29qUYvXtHXfBDOC073/fTKzeNO8zHGsjT6Rmkb7aPANTioxWcozUqaEpE4rwS3MRR2aWlfBjuJG
	B7lrR0jr/KW4L4WfBK5SXXKvptT435g+OUptj88UxrHYqdA+GJNvO4n09Jja2E+ZuNTH7LRuG8V
	fhCfhTk5GwD3M9YHqsdQhcKbf9chnZxNZKWujlAjFCU7vPk2CvxnG1uje6GF0P8uCeGYyUhkuZI
	h/SOr9pRrH3hEB543YI4OEhNe3+BDb8XAE32UfJRv7SJsYJrCXfg62W2rj6Ff5/wJh/unEVDeb1
	AZJQ==
X-Google-Smtp-Source: AGHT+IFg/4U1C4hDt6D+sol//DAeZoKYVjecS/OZxJBf4KsldAhJFeGu7S6YWjTmOrdEcSNq1kGx/g==
X-Received: by 2002:a05:6a00:66ea:b0:770:573f:fc60 with SMTP id d2e1a72fcca58-770573ffe32mr19626815b3a.0.1756378082801;
        Thu, 28 Aug 2025 03:48:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772093cac4bsm4314244b3a.12.2025.08.28.03.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 03:48:02 -0700 (PDT)
Message-ID: <15af1c5c-abab-4b2a-a32c-4933b2c325d6@rivosinc.com>
Date: Thu, 28 Aug 2025 12:47:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v6 2/5] riscv: add support for SBI Supervisor
 Software Events extension
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20250808153901.2477005-1-cleger@rivosinc.com>
 <20250808153901.2477005-3-cleger@rivosinc.com>
 <CAEEQ3w=iMtePajsANgJ=imUfGyWUag2m1Y9kexHT3BDuL5+dtg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAEEQ3w=iMtePajsANgJ=imUfGyWUag2m1Y9kexHT3BDuL5+dtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/08/2025 11:08, yunhui cui wrote:
> Hi Clément,
> 
> On Fri, Aug 8, 2025 at 11:39 PM Clément Léger <cleger@rivosinc.com> wrote:
>>
>> The SBI SSE extension allows the supervisor software to be notified by
>> the SBI of specific events that are not maskable. The context switch is
>> handled partially by the firmware which will save registers a6 and a7.
>> When entering kernel we can rely on these 2 registers to setup the stack
>> and save all the registers.
>>
>> Since SSE events can be delivered at any time to the kernel (including
>> during exception handling, we need a way to locate the current_task for
>> context tracking. On RISC-V, it is sotred in scratch when in user space
>> or tp when in kernel space (in which case SSCRATCH is zero). But at a
>> at the beginning of exception handling, SSCRATCH is used to swap tp and
>> check the origin of the exception. If interrupted at that point, then,
>> there is no way to reliably know were is located the current
>> task_struct. Even checking the interruption location won't work as SSE
>> event can be nested on top of each other so the original interruption
>> site might be lost at some point. In order to retrieve it reliably,
>> store the current task in an additional __sse_entry_task per_cpu array.
>> This array is then used to retrieve the current task based on the
>> hart ID that is passed to the SSE event handler in a6.
>>
>> That being said, the way the current task struct is stored should
>> probably be reworked to find a better reliable alternative.
>>
>> Since each events (and each CPU for local events) have their own
>> context and can preempt each other, allocate a stack (and a shadow stack
>> if needed for each of them (and for each cpu for local events).
>>
>> When completing the event, if we were coming from kernel with interrupts
>> disabled, simply return there. If coming from userspace or kernel with
>> interrupts enabled, simulate an interrupt exception by setting IE_SIE in
>> CSR_IP to allow delivery of signals to user task. For instance this can
>> happen, when a RAS event has been generated by a user application and a
>> SIGBUS has been sent to a task.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/asm.h         |  14 ++-
>>  arch/riscv/include/asm/scs.h         |   7 ++
>>  arch/riscv/include/asm/sse.h         |  47 +++++++
>>  arch/riscv/include/asm/switch_to.h   |  14 +++
>>  arch/riscv/include/asm/thread_info.h |   1 +
>>  arch/riscv/kernel/Makefile           |   1 +
>>  arch/riscv/kernel/asm-offsets.c      |  14 +++
>>  arch/riscv/kernel/sse.c              | 154 +++++++++++++++++++++++
>>  arch/riscv/kernel/sse_entry.S        | 180 +++++++++++++++++++++++++++
>>  9 files changed, 429 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/sse.h
>>  create mode 100644 arch/riscv/kernel/sse.c
>>  create mode 100644 arch/riscv/kernel/sse_entry.S
>>
>> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
>> index a8a2af6dfe9d..982c4be9a9c3 100644
>> --- a/arch/riscv/include/asm/asm.h
>> +++ b/arch/riscv/include/asm/asm.h
>> @@ -90,16 +90,24 @@
>>  #define PER_CPU_OFFSET_SHIFT 3
>>  #endif
>>
>> -.macro asm_per_cpu dst sym tmp
>> -       REG_L \tmp, TASK_TI_CPU_NUM(tp)
>> -       slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
>> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
>> +       slli  \tmp, \cpu, PER_CPU_OFFSET_SHIFT
>>         la    \dst, __per_cpu_offset
>>         add   \dst, \dst, \tmp
>>         REG_L \tmp, 0(\dst)
>>         la    \dst, \sym
>>         add   \dst, \dst, \tmp
>>  .endm
>> +
>> +.macro asm_per_cpu dst sym tmp
>> +       REG_L \tmp, TASK_TI_CPU_NUM(tp)
>> +       asm_per_cpu_with_cpu \dst \sym \tmp \tmp
>> +.endm
>>  #else /* CONFIG_SMP */
>> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
>> +       la    \dst, \sym
>> +.endm
>> +
>>  .macro asm_per_cpu dst sym tmp
>>         la    \dst, \sym
>>  .endm
>> diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
>> index 0e45db78b24b..62344daad73d 100644
>> --- a/arch/riscv/include/asm/scs.h
>> +++ b/arch/riscv/include/asm/scs.h
>> @@ -18,6 +18,11 @@
>>         load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
>>  .endm
>>
>> +/* Load the per-CPU IRQ shadow call stack to gp. */
>> +.macro scs_load_sse_stack reg_evt
>> +       REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
>> +.endm
>> +
>>  /* Load task_scs_sp(current) to gp. */
>>  .macro scs_load_current
>>         REG_L   gp, TASK_TI_SCS_SP(tp)
>> @@ -41,6 +46,8 @@
>>  .endm
>>  .macro scs_load_irq_stack tmp
>>  .endm
>> +.macro scs_load_sse_stack reg_evt
>> +.endm
>>  .macro scs_load_current
>>  .endm
>>  .macro scs_load_current_if_task_changed prev
>> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
>> new file mode 100644
>> index 000000000000..8929a268462c
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/sse.h
>> @@ -0,0 +1,47 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2024 Rivos Inc.
>> + */
>> +#ifndef __ASM_SSE_H
>> +#define __ASM_SSE_H
>> +
>> +#include <asm/sbi.h>
>> +
>> +#ifdef CONFIG_RISCV_SSE
>> +
>> +struct sse_event_interrupted_state {
>> +       unsigned long a6;
>> +       unsigned long a7;
>> +};
>> +
>> +struct sse_event_arch_data {
>> +       void *stack;
>> +       void *shadow_stack;
>> +       unsigned long tmp;
>> +       struct sse_event_interrupted_state interrupted;
>> +       unsigned long interrupted_phys;
>> +       u32 evt_id;
>> +       unsigned int hart_id;
>> +       unsigned int cpu_id;
>> +};
>> +
>> +static inline bool sse_event_is_global(u32 evt)
>> +{
>> +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
>> +}
>> +
>> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int cpu);
>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id,
>> +                       int cpu);
>> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
>> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
>> +
>> +void sse_handle_event(struct sse_event_arch_data *arch_evt,
>> +                     struct pt_regs *regs);
>> +asmlinkage void handle_sse(void);
>> +asmlinkage void do_sse(struct sse_event_arch_data *arch_evt,
>> +                      struct pt_regs *reg);
>> +
>> +#endif
>> +
>> +#endif
>> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
>> index 0e71eb82f920..cd1cead0c682 100644
>> --- a/arch/riscv/include/asm/switch_to.h
>> +++ b/arch/riscv/include/asm/switch_to.h
>> @@ -88,6 +88,19 @@ static inline void __switch_to_envcfg(struct task_struct *next)
>>                         :: "r" (next->thread.envcfg) : "memory");
>>  }
>>
>> +#ifdef CONFIG_RISCV_SSE
>> +DECLARE_PER_CPU(struct task_struct *, __sse_entry_task);
>> +
>> +static inline void __switch_sse_entry_task(struct task_struct *next)
>> +{
>> +       __this_cpu_write(__sse_entry_task, next);
>> +}
>> +#else
>> +static inline void __switch_sse_entry_task(struct task_struct *next)
>> +{
>> +}
>> +#endif
>> +
>>  extern struct task_struct *__switch_to(struct task_struct *,
>>                                        struct task_struct *);
>>
>> @@ -122,6 +135,7 @@ do {                                                        \
>>         if (switch_to_should_flush_icache(__next))      \
>>                 local_flush_icache_all();               \
>>         __switch_to_envcfg(__next);                     \
>> +       __switch_sse_entry_task(__next);                        \
>>         ((last) = __switch_to(__prev, __next));         \
>>  } while (0)
>>
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> index f5916a70879a..28e9805e61fc 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -36,6 +36,7 @@
>>  #define OVERFLOW_STACK_SIZE     SZ_4K
>>
>>  #define IRQ_STACK_SIZE         THREAD_SIZE
>> +#define SSE_STACK_SIZE         THREAD_SIZE
>>
>>  #ifndef __ASSEMBLY__
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index c7b542573407..62e4490b34ee 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -99,6 +99,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)  += mcount-dyn.o
>>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>>  obj-$(CONFIG_RISCV_SBI)                += sbi.o sbi_ecall.o
>> +obj-$(CONFIG_RISCV_SSE)                += sse.o sse_entry.o
>>  ifeq ($(CONFIG_RISCV_SBI), y)
>>  obj-$(CONFIG_SMP)              += sbi-ipi.o
>>  obj-$(CONFIG_SMP) += cpu_ops_sbi.o
>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> index 6e8c0d6feae9..315547c3a2ef 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -14,6 +14,8 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/cpu_ops_sbi.h>
>>  #include <asm/stacktrace.h>
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>>  #include <asm/suspend.h>
>>
>>  void asm_offsets(void);
>> @@ -528,4 +530,16 @@ void asm_offsets(void)
>>         DEFINE(FREGS_A6,            offsetof(struct __arch_ftrace_regs, a6));
>>         DEFINE(FREGS_A7,            offsetof(struct __arch_ftrace_regs, a7));
>>  #endif
>> +
>> +#ifdef CONFIG_RISCV_SSE
>> +       OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
>> +       OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stack);
>> +       OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
>> +       OFFSET(SSE_REG_HART_ID, sse_event_arch_data, hart_id);
>> +       OFFSET(SSE_REG_CPU_ID, sse_event_arch_data, cpu_id);
>> +
>> +       DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
>> +       DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
>> +       DEFINE(ASM_NR_CPUS, NR_CPUS);
>> +#endif
>>  }
>> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
>> new file mode 100644
>> index 000000000000..d2da7e23a74a
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sse.c
>> @@ -0,0 +1,154 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024 Rivos Inc.
>> + */
>> +#include <linux/nmi.h>
>> +#include <linux/scs.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/riscv_sse.h>
>> +#include <linux/percpu-defs.h>
>> +
>> +#include <asm/asm-prototypes.h>
>> +#include <asm/switch_to.h>
>> +#include <asm/irq_stack.h>
>> +#include <asm/sbi.h>
>> +#include <asm/sse.h>
>> +
>> +DEFINE_PER_CPU(struct task_struct *, __sse_entry_task);
>> +
>> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
>> +{
>> +}
>> +
>> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
>> +{
>> +       nmi_enter();
>> +
>> +       /* Retrieve missing GPRs from SBI */
>> +       sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
>> +                 SBI_SSE_ATTR_INTERRUPTED_A6,
>> +                 (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED_A6) + 1,
>> +                 arch_evt->interrupted_phys, 0, 0);
>> +
>> +       memcpy(&regs->a6, &arch_evt->interrupted, sizeof(arch_evt->interrupted));
>> +
>> +       sse_handle_event(arch_evt, regs);
>> +
>> +       /*
>> +        * The SSE delivery path does not uses the "standard" exception path
>> +        * (see sse_entry.S) and does not process any pending signal/softirqs
>> +        * due to being similar to a NMI.
>> +        * Some drivers (PMU, RAS) enqueue pending work that needs to be handled
>> +        * as soon as possible by bottom halves. For that purpose, set the SIP
>> +        * software interrupt pending bit which will force a software interrupt
>> +        * to be serviced once interrupts are reenabled in the interrupted
>> +        * context if they were masked or directly if unmasked.
>> +        */
>> +       csr_set(CSR_IP, IE_SIE);
> 
> When using perf record, will S mode interrupts experience starvation?

It shouldn't starve the other interrupts since after returning to S-mode
(before servicing the interrupt), the hart will still be able to set
other interrupts as pending which will be serviced as well I think. At
least, I did not observed anything indicating that S-mode was not
servicing interrupts anymore.

Clément

> 
>> +
>> +       nmi_exit();
>> +}
>> +
>> +static void *alloc_to_stack_pointer(void *alloc)
>> +{
>> +       return alloc ? alloc + SSE_STACK_SIZE : NULL;
>> +}
>> +
>> +static void *stack_pointer_to_alloc(void *stack)
>> +{
>> +       return stack - SSE_STACK_SIZE;
>> +}
>> +
>> +#ifdef CONFIG_VMAP_STACK
>> +static void *sse_stack_alloc(unsigned int cpu)
>> +{
>> +       void *stack = arch_alloc_vmap_stack(SSE_STACK_SIZE, cpu_to_node(cpu));
>> +
>> +       return alloc_to_stack_pointer(stack);
>> +}
>> +
>> +static void sse_stack_free(void *stack)
>> +{
>> +       vfree(stack_pointer_to_alloc(stack));
>> +}
>> +#else /* CONFIG_VMAP_STACK */
>> +static void *sse_stack_alloc(unsigned int cpu)
>> +{
>> +       void *stack = kmalloc(SSE_STACK_SIZE, GFP_KERNEL);
>> +
>> +       return alloc_to_stack_pointer(stack);
>> +}
>> +
>> +static void sse_stack_free(void *stack)
>> +{
>> +       kfree(stack_pointer_to_alloc(stack));
>> +}
>> +#endif /* CONFIG_VMAP_STACK */
>> +
>> +static int sse_init_scs(int cpu, struct sse_event_arch_data *arch_evt)
>> +{
>> +       void *stack;
>> +
>> +       if (!scs_is_enabled())
>> +               return 0;
>> +
>> +       stack = scs_alloc(cpu_to_node(cpu));
>> +       if (!stack)
>> +               return -ENOMEM;
>> +
>> +       arch_evt->shadow_stack = stack;
>> +
>> +       return 0;
>> +}
>> +
>> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int cpu)
>> +{
>> +       arch_evt->cpu_id = cpu;
>> +       arch_evt->hart_id = cpuid_to_hartid_map(cpu);
>> +}
>> +
>> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id, int cpu)
>> +{
>> +       void *stack;
>> +
>> +       arch_evt->evt_id = evt_id;
>> +       stack = sse_stack_alloc(cpu);
>> +       if (!stack)
>> +               return -ENOMEM;
>> +
>> +       arch_evt->stack = stack;
>> +
>> +       if (sse_init_scs(cpu, arch_evt)) {
>> +               sse_stack_free(arch_evt->stack);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       if (sse_event_is_global(evt_id)) {
>> +               arch_evt->interrupted_phys =
>> +                                       virt_to_phys(&arch_evt->interrupted);
>> +       } else {
>> +               arch_evt->interrupted_phys =
>> +                               per_cpu_ptr_to_phys(&arch_evt->interrupted);
>> +       }
>> +
>> +       arch_sse_event_update_cpu(arch_evt, cpu);
>> +
>> +       return 0;
>> +}
>> +
>> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
>> +{
>> +       scs_free(arch_evt->shadow_stack);
>> +       sse_stack_free(arch_evt->stack);
>> +}
>> +
>> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
>> +{
>> +       struct sbiret sret;
>> +
>> +       sret = sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, arch_evt->evt_id,
>> +                        (unsigned long)handle_sse, (unsigned long)arch_evt, 0,
>> +                        0, 0);
>> +
>> +       return sbi_err_map_linux_errno(sret.error);
>> +}
> ...
> 
> Thanks,
> Yunhui


