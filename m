Return-Path: <linux-kernel+bounces-754840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A70B19D66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D2C171F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27D923BCF0;
	Mon,  4 Aug 2025 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="CwLdPRhB"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98A7DA6D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295160; cv=none; b=hlAiMpO+F1ACPcXWryj3PrMe1mb1+kJXdcuFufW0vGL0y5ZzBbRUE/Gr0wP6lvYY6/Rr0+ebEbSuuiDCkT7olkqGI6NWUQG1OC/k20cH3LRL5FJWR+AhQt+xCOXNoKG2cOJDmNEA3iJdv+Nh5C7aRDPQiq8EtTAzAEdoxLwDwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295160; c=relaxed/simple;
	bh=bSyytSbvRjNBckqPoFfDrj6n2a6Xf29BerRxypXTZa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKaBEGoaNZwiqpcQPIfWBBdCFwjL9MfjLN5H1gNtlkN+9CuvgzJI9LHgKvuUaHTsRCQ93LmO7l1rMx5EGuMOMzQwkR/1053rFftqmSOe9UmBvgxgoURLoM3U7bqnR2G+DenT0rvZXuyTxhMSADzoGx4zkt/qh67nuLAF9UXjtOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=CwLdPRhB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-458bc3ce3beso9594405e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754295155; x=1754899955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YWX1EAOoOHJi8vMtJH0oIBKBvx6srlJh1t9rUpQB80=;
        b=CwLdPRhB0sw37GExwHxYX2tWaMvS4ivxtLdVx4FW6hWylZzPZS4sVvPOiAd7fkoboq
         qojz7+MVWF9jAN0dJnB81wIzefpvAjaOwyqW9YCQjk+9XA6U7VxlAbftC3Axja5Ar6T+
         eBJj0EOERo/vS92Mr2l0TiF2c5cZSFrOsUMF7FeevsL7THdQ6QngKaaIX+EmSsctVU9c
         UV03EFmfb/Lop9cPhDQziXhbrFoFbbI2hcVYUsSd+7WYly2NQ2iyaHaNY46xKbeSOG1f
         aLRnmwVZQSbotqoGw/s33iJYE04C1KDmUUjq1p1hvumcAiJWSSRVbCtWpZJutWTcNGYw
         THKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295155; x=1754899955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YWX1EAOoOHJi8vMtJH0oIBKBvx6srlJh1t9rUpQB80=;
        b=GAV4EhC4eUlGv0bk5eX8sOGh8EUKBin0RwUthINnHTXZWIRME2ABGs/qDgUc0Bc/TN
         hFA3KtronlApocJ8rza6OFu67WXKKoIRoP9ReEFdaBBRQo00pszb7USRSu4puq3Guubk
         cuJnZyeqHzMpNIXOOiavQCft9HbNz/0/YA1Hau/qPgY2Nss6a4Joezf4SZbgCUKNs36T
         wHpabUD3/hGR9JG9dunzO6KRKtflKqfYidI0T3IAZ8R5f7eTN/ghhnS7xmEfDYc1EGX6
         7hyYAefiU5tSE1Xbg7Oa6oR9L1190C+GcljFp2HYR3OPMgmsmklVPIHMaONpofh+2QZn
         WPvA==
X-Forwarded-Encrypted: i=1; AJvYcCWMTLlbWpPPss7QOAOCMAs8mqlCgr0ZxQfB6hnHoM/tdCc4usQXKYdxkEYPUUSrDc2B0VMO3tI36s3YLgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Ah1vHcWgsvE2Z4fylIUpq67Ppz79lA/vu5Eo/xUvmRjenAft
	lCxS4ZNBSHEMc9l0FjN2tpCQ2TWVpJw2lZ2Kj7Cr1Y9Vvp9BTrvldR02GS4syk4SIlY=
X-Gm-Gg: ASbGnctMU0nMfPBVvP6bi7QBM5ZGFsH+yLbWdpiFNEFeMymp41wpy7LJjWyE1PlM83w
	VkOlZM0pHuQfRxM4SkKm3I3DkkwM8HmFk0d9gzx2iWP9YJ+fOmD1Bl1CTBqbtBA0IAvY5pFzpOr
	lVrVRCOjDkAuGu6cTvfpMHcPiWPsFC/eXeTg1kR7XENGuEWneBY+P+MSdwqzmKE37S2Xmx6EyD1
	MUWJfS3p5GzTp1DEBt60JEu6bgHFpVrkMriQdNkNz/CIrhEJchopaoqzDpAGN6cxleSVVAEEZsg
	JNNcc3JSAVEtzKgooRJQ9SpSiepd8FBe5AYph64O863ldzc+nFODhds4Kh3m3YGS/HBNNBu/xqq
	N0l9oTUOvG4uZtyCsx6UIMtLM6VHDFMQlfoDcBERjHmBu7qOA03/mITQI/suDR+7bNNs=
X-Google-Smtp-Source: AGHT+IFfulHEU4i5ZqtWeJV0rbVTF8HwVdqWaWZfFWus9OsgWoiF7Rskd29Bz99kF/5hDBKCiLD+9Q==
X-Received: by 2002:a05:600c:3b93:b0:459:94a7:220f with SMTP id 5b1f17b1804b1-45994a72576mr36054585e9.26.1754295154538;
        Mon, 04 Aug 2025 01:12:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm14357054f8f.32.2025.08.04.01.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:12:33 -0700 (PDT)
Message-ID: <9b8848c3-f1c8-458e-9ff1-99f356b95e8d@rivosinc.com>
Date: Mon, 4 Aug 2025 10:12:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] [PATCH v5 2/5] riscv: add support for SBI Supervisor
 Software Events extension
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Xu Lu <luxu.kernel@bytedance.com>,
 Atish Patra <atishp@atishpatra.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20250715160234.454848-1-cleger@rivosinc.com>
 <20250715160234.454848-3-cleger@rivosinc.com>
 <CAEEQ3wkQr6dWPJOkowNO5f9QWdkQ3r2v4cZENuHp_YyBbhS0fg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAEEQ3wkQr6dWPJOkowNO5f9QWdkQ3r2v4cZENuHp_YyBbhS0fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/07/2025 09:29, yunhui cui wrote:
> Hi Clément,
> 
> On Wed, Jul 16, 2025 at 12:04 AM Clément Léger <cleger@rivosinc.com> wrote:
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
>>  arch/riscv/include/asm/sse.h         |  44 +++++++
>>  arch/riscv/include/asm/switch_to.h   |  14 +++
>>  arch/riscv/include/asm/thread_info.h |   1 +
>>  arch/riscv/kernel/Makefile           |   1 +
>>  arch/riscv/kernel/asm-offsets.c      |  12 ++
>>  arch/riscv/kernel/sse.c              | 146 +++++++++++++++++++++++
>>  arch/riscv/kernel/sse_entry.S        | 169 +++++++++++++++++++++++++++
>>  9 files changed, 405 insertions(+), 3 deletions(-)
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
>> index 000000000000..ff938bd9007d
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/sse.h
>> @@ -0,0 +1,44 @@
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
>> +};
>> +
>> +static inline bool sse_event_is_global(u32 evt)
>> +{
>> +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
>> +}
>> +
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
>> index 6e8c0d6feae9..651779647cdd 100644
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
>> @@ -528,4 +530,14 @@ void asm_offsets(void)
>>         DEFINE(FREGS_A6,            offsetof(struct __arch_ftrace_regs, a6));
>>         DEFINE(FREGS_A7,            offsetof(struct __arch_ftrace_regs, a7));
>>  #endif
>> +
>> +#ifdef CONFIG_RISCV_SSE
>> +       OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
>> +       OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stack);
>> +       OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
>> +
>> +       DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
>> +       DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
>> +       DEFINE(ASM_NR_CPUS, NR_CPUS);
>> +#endif
>>  }
>> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
>> new file mode 100644
>> index 000000000000..49d59f9ffa09
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sse.c
>> @@ -0,0 +1,146 @@
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
>> diff --git a/arch/riscv/kernel/sse_entry.S b/arch/riscv/kernel/sse_entry.S
>> new file mode 100644
>> index 000000000000..c22ebfc0e063
>> --- /dev/null
>> +++ b/arch/riscv/kernel/sse_entry.S
>> @@ -0,0 +1,169 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2024 Rivos Inc.
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/linkage.h>
>> +
>> +#include <asm/asm.h>
>> +#include <asm/csr.h>
>> +#include <asm/scs.h>
>> +
>> +/* When entering handle_sse, the following registers are set:
>> + * a6: contains the hartid
>> + * a7: contains struct sse_registered_event pointer
> 
> Can it be written as struct sse_event_arch_data?

Hi Yunhui,

You are right, this is a typo, it should be sse_event_arch_data rather
than sse_registered_event.

> 
>> + */
>> +SYM_CODE_START(handle_sse)
>> +       /* Save stack temporarily */
>> +       REG_S sp, SSE_REG_EVT_TMP(a7)
>> +       /* Set entry stack */
>> +       REG_L sp, SSE_REG_EVT_STACK(a7)
>> +
>> +       addi sp, sp, -(PT_SIZE_ON_STACK)
>> +       REG_S ra, PT_RA(sp)
>> +       REG_S s0, PT_S0(sp)
>> +       REG_S s1, PT_S1(sp)
>> +       REG_S s2, PT_S2(sp)
>> +       REG_S s3, PT_S3(sp)
>> +       REG_S s4, PT_S4(sp)
>> +       REG_S s5, PT_S5(sp)
>> +       REG_S s6, PT_S6(sp)
>> +       REG_S s7, PT_S7(sp)
>> +       REG_S s8, PT_S8(sp)
>> +       REG_S s9, PT_S9(sp)
>> +       REG_S s10, PT_S10(sp)
>> +       REG_S s11, PT_S11(sp)
>> +       REG_S tp, PT_TP(sp)
>> +       REG_S t0, PT_T0(sp)
>> +       REG_S t1, PT_T1(sp)
>> +       REG_S t2, PT_T2(sp)
>> +       REG_S t3, PT_T3(sp)
>> +       REG_S t4, PT_T4(sp)
>> +       REG_S t5, PT_T5(sp)
>> +       REG_S t6, PT_T6(sp)
>> +       REG_S gp, PT_GP(sp)
>> +       REG_S a0, PT_A0(sp)
>> +       REG_S a1, PT_A1(sp)
>> +       REG_S a2, PT_A2(sp)
>> +       REG_S a3, PT_A3(sp)
>> +       REG_S a4, PT_A4(sp)
>> +       REG_S a5, PT_A5(sp)
>> +
>> +       /* Retrieve entry sp */
>> +       REG_L a4, SSE_REG_EVT_TMP(a7)
>> +       /* Save CSRs */
>> +       csrr a0, CSR_EPC
>> +       csrr a1, CSR_SSTATUS
>> +       csrr a2, CSR_STVAL
>> +       csrr a3, CSR_SCAUSE
>> +
>> +       REG_S a0, PT_EPC(sp)
>> +       REG_S a1, PT_STATUS(sp)
>> +       REG_S a2, PT_BADADDR(sp)
>> +       REG_S a3, PT_CAUSE(sp)
>> +       REG_S a4, PT_SP(sp)
>> +
>> +       /* Disable user memory access and floating/vector computing */
>> +       li t0, SR_SUM | SR_FS_VS
>> +       csrc CSR_STATUS, t0
>> +
>> +       load_global_pointer
>> +       scs_load_sse_stack a7
>> +
>> +       /* Restore current task struct from __sse_entry_task */
>> +       li t1, ASM_NR_CPUS
>> +       mv t3, zero
>> +
>> +#ifdef CONFIG_SMP
>> +       /* Find the CPU id associated to the hart id */
>> +       la t0, __cpuid_to_hartid_map
>> +.Lhart_id_loop:
>> +       REG_L t2, 0(t0)
>> +       beq t2, a6, .Lcpu_id_found
>> +
>> +       /* Increment pointer and CPU number */
>> +       addi t3, t3, 1
>> +       addi t0, t0, RISCV_SZPTR
>> +       bltu t3, t1, .Lhart_id_loop
>> +
> 
> Can we get the CPU number directly here? E.g., pass it during
> SBI_SSE_EVENT_REGISTER, or create a reverse array of
> __cpuid_to_hartid_map[]?

Unfortunately, we can't get the CPU number directly since the SBI is not
forced to handle the event on the preferred hart. The SBI spec says:

PREFERRED_HART

Hart id of the *preferred* hart that
*should* handle the global software
event.

A reverse array would lead to the same kind of loop since the ISA spec
states that:

"
Hart IDs might not necessarily be numbered contiguously in a
multiprocessor system, but at least one hart must have a hart ID of
zero. Hart IDs must be unique within the execution environment.
"

We could optimize it by setting the hart/cpu match in the
sse_event_arch_data and check if the hart is the same. If so, we can
skip the CPU id retrieval loop. I'll implement that.

Thanks,

Clément

> 
>> +       /*
>> +        * This should never happen since we expect the hart_id to match one
>> +        * of our CPU, but better be safe than sorry
>> +        */
>> +       la tp, init_task
>> +       la a0, sse_hart_id_panic_string
>> +       la t0, panic
>> +       jalr t0
>> +
>> +.Lcpu_id_found:
>> +#endif
>> +       asm_per_cpu_with_cpu t2 __sse_entry_task t1 t3
>> +       REG_L tp, 0(t2)
>> +
>> +       mv a1, sp /* pt_regs on stack */
>> +
>> +       /*
>> +        * Save sscratch for restoration since we might have interrupted the
>> +        * kernel in early exception path and thus, we don't know the content of
>> +        * sscratch.
>> +        */
>> +       csrr s4, CSR_SSCRATCH
>> +       /* In-kernel scratch is 0 */
>> +       csrw CSR_SCRATCH, x0
>> +
>> +       mv a0, a7
>> +
>> +       call do_sse
>> +
>> +       csrw CSR_SSCRATCH, s4
>> +
>> +       REG_L a0, PT_STATUS(sp)
>> +       REG_L a1, PT_EPC(sp)
>> +       REG_L a2, PT_BADADDR(sp)
>> +       REG_L a3, PT_CAUSE(sp)
>> +       csrw CSR_SSTATUS, a0
>> +       csrw CSR_EPC, a1
>> +       csrw CSR_STVAL, a2
>> +       csrw CSR_SCAUSE, a3
>> +
>> +       REG_L ra, PT_RA(sp)
>> +       REG_L s0, PT_S0(sp)
>> +       REG_L s1, PT_S1(sp)
>> +       REG_L s2, PT_S2(sp)
>> +       REG_L s3, PT_S3(sp)
>> +       REG_L s4, PT_S4(sp)
>> +       REG_L s5, PT_S5(sp)
>> +       REG_L s6, PT_S6(sp)
>> +       REG_L s7, PT_S7(sp)
>> +       REG_L s8, PT_S8(sp)
>> +       REG_L s9, PT_S9(sp)
>> +       REG_L s10, PT_S10(sp)
>> +       REG_L s11, PT_S11(sp)
>> +       REG_L tp, PT_TP(sp)
>> +       REG_L t0, PT_T0(sp)
>> +       REG_L t1, PT_T1(sp)
>> +       REG_L t2, PT_T2(sp)
>> +       REG_L t3, PT_T3(sp)
>> +       REG_L t4, PT_T4(sp)
>> +       REG_L t5, PT_T5(sp)
>> +       REG_L t6, PT_T6(sp)
>> +       REG_L gp, PT_GP(sp)
>> +       REG_L a0, PT_A0(sp)
>> +       REG_L a1, PT_A1(sp)
>> +       REG_L a2, PT_A2(sp)
>> +       REG_L a3, PT_A3(sp)
>> +       REG_L a4, PT_A4(sp)
>> +       REG_L a5, PT_A5(sp)
>> +
>> +       REG_L sp, PT_SP(sp)
>> +
>> +       li a7, SBI_EXT_SSE
>> +       li a6, SBI_SSE_EVENT_COMPLETE
>> +       ecall
>> +
>> +SYM_CODE_END(handle_sse)
>> +
>> +SYM_DATA_START_LOCAL(sse_hart_id_panic_string)
>> +    .ascii "Unable to match hart_id with cpu\0"
>> +SYM_DATA_END(sse_hart_id_panic_string)
>> --
>> 2.43.0
>>
>>
> 
> Thanks,
> Yunhui


