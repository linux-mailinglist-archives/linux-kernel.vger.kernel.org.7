Return-Path: <linux-kernel+bounces-773248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7BAB29D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3E6188967C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467A30DD0D;
	Mon, 18 Aug 2025 09:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="TBuxkKgJ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1727979A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508095; cv=none; b=q6e0vlg+0/GzVWPVtdoVX7tm8vChMWsmHjOrrSaD8nMSUwpAnzyQ30LOs2VSerfKTGYv3sb7r9H0gwv9YJ+T/mOJh5k0XYO2F3VVtGiwPW8dWnpkXZcF6EeX+kKiBiBnJOxh4P0tS8hXxFAN5qMbo8EwjNRhs3JcRzEOiVaKtrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508095; c=relaxed/simple;
	bh=Ff5BY1WglD7L+IeglTnJyKzZPEbZ0BYsqsNV/P+w1mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCCeCdFcAM6Kqj2TulN+wXv4S5I7KUy8QhvM3Y9a+25R3hNeZzQLhWP5uLSqiCSOOL9DcfNVom7FcBXdbi8NECm/S0IV8L9IUtBSuNHgkQoI2QoOldccKErgbih6uFw4rlq1/gM4q+W8JAkn3SbqYy7fA0W90w0JauydbcxNJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=TBuxkKgJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-435de5ccff6so2022448b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1755508092; x=1756112892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGq36/HLVmA2mW4+mSHk8ba9pJWAeo5d7C5uofJJPcg=;
        b=TBuxkKgJHs0tExuQIEj5ONAdV0FdPKwp0uJuuZQKKRNNiY/lYdqeWNP1lHDw4ZOkTV
         CvwhPbjdDCc1B7Pb3qBisOr1p41L7JudlKueIlQgIQ/MB64XbPTd65lADnnZC+ZF9Oen
         hH7+ymZ1HXhtTKzQNI5Pq6oR+D6XZTotRf5nhEK5Lgz3XfEOusToLo3pMGuJsyFrSikd
         Q9pdqZx/c5iXJ+jSGx6kqP5jeAQX13KQx++boJ/AGtivl99AQjAgAlGmNOTEofZUL1be
         Wakw1F5QsxkQnV6QoXwtT+8yywiKKFMdchEJ8PWpss1LUBJwj+Ymphm0lB/96R/xsyYv
         mK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755508092; x=1756112892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UGq36/HLVmA2mW4+mSHk8ba9pJWAeo5d7C5uofJJPcg=;
        b=UR+RtlylgfnUr2pHW2HZe06irpt5t4/krioxzYAxBA8KhY5daB242Dhr2zmvOGC3OW
         nEgf9scZBEPPJrB/1qIpZnNWb8qpe2a53hzEla1llVDUVJ6goRihb8uo72FvI703a5iW
         jE19Q0Oa0pcZIRq7M4dcbP9N0NKK4mCXQ/HDQ3dLjSQl2d5j/ZhDa1Pe1XK9qcqOmoBR
         /wbv3jLG3KEX9kwJX0m1sNZ0LoRYkjauJCyvTGGWN+of2X958e2fNjWSP4LvZ0n+MjL5
         +f0A8j4224QHmLGA58eLIGgUIRcAaqs0LIdGORK1heJ6d85iNzfCAuAtd8btOdffimtd
         Fttg==
X-Forwarded-Encrypted: i=1; AJvYcCVuRxJJWVwjcll4d0UqclWIXgoU3RLYTHWQQEKE/z9SST3Ks/RsFCey2n8Vic84ejtOMUzJ5N/qda7XMLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/LOc6ZWRAErmwwXiVjve1f9810ZODEHH+JmKIMwBxSNTw0i2Y
	mmLAT7dTYvyiaUCH3L+1yCb3gsCsjz+6mPz7IP19lUGr+nvbJeZpatnuEzWdqk21bKITXa0iiyu
	yBErxMJPqdXfpLqggjd5xy69v8nSQ0YGum0MqnO7H4g==
X-Gm-Gg: ASbGncsy2o2lHa0mlzz/48GPrrAH/NCsRTji8WoRnSjIGItJgMDR5cpz7oYlqT6MIn1
	hIDQ9lFluWLBsiO0u7zJaA/u/rAC6iPlzA1BS2lqmopZZXo7Lzx8EGOVnBr4aFJqe931umuVLL4
	DxRvaCbpaIKFBSBE2HJdqnUZnYDQJBik2njQ9JWc7HSRPthcDkSLqNbBX6y5OYzmHdLgyDOi4c0
	cTyREGaUj4RuuV3bifzdD0zGajm
X-Google-Smtp-Source: AGHT+IHh6lJTxt89IoV6UjlZAMAaTFa15cBdIglhIjIYunXFrPikDGuSjaityyh1p9LywkUtKs2m0PJOUrEqoiDuDvc=
X-Received: by 2002:a05:6808:2444:b0:434:487:320e with SMTP id
 5614622812f47-435ec4c98cfmr5912286b6e.29.1755508091887; Mon, 18 Aug 2025
 02:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808153901.2477005-1-cleger@rivosinc.com> <20250808153901.2477005-3-cleger@rivosinc.com>
In-Reply-To: <20250808153901.2477005-3-cleger@rivosinc.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 18 Aug 2025 17:08:00 +0800
X-Gm-Features: Ac12FXz_kFhSDLqYWi0ryuhYRPn1CMlHjPwg70sroWJxaHzl7fgGfLLqlAydhFY
Message-ID: <CAEEQ3w=iMtePajsANgJ=imUfGyWUag2m1Y9kexHT3BDuL5+dtg@mail.gmail.com>
Subject: Re: [External] [PATCH v6 2/5] riscv: add support for SBI Supervisor
 Software Events extension
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Anup Patel <apatel@ventanamicro.com>, 
	Xu Lu <luxu.kernel@bytedance.com>, Atish Patra <atishp@atishpatra.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cl=C3=A9ment,

On Fri, Aug 8, 2025 at 11:39=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@riv=
osinc.com> wrote:
>
> The SBI SSE extension allows the supervisor software to be notified by
> the SBI of specific events that are not maskable. The context switch is
> handled partially by the firmware which will save registers a6 and a7.
> When entering kernel we can rely on these 2 registers to setup the stack
> and save all the registers.
>
> Since SSE events can be delivered at any time to the kernel (including
> during exception handling, we need a way to locate the current_task for
> context tracking. On RISC-V, it is sotred in scratch when in user space
> or tp when in kernel space (in which case SSCRATCH is zero). But at a
> at the beginning of exception handling, SSCRATCH is used to swap tp and
> check the origin of the exception. If interrupted at that point, then,
> there is no way to reliably know were is located the current
> task_struct. Even checking the interruption location won't work as SSE
> event can be nested on top of each other so the original interruption
> site might be lost at some point. In order to retrieve it reliably,
> store the current task in an additional __sse_entry_task per_cpu array.
> This array is then used to retrieve the current task based on the
> hart ID that is passed to the SSE event handler in a6.
>
> That being said, the way the current task struct is stored should
> probably be reworked to find a better reliable alternative.
>
> Since each events (and each CPU for local events) have their own
> context and can preempt each other, allocate a stack (and a shadow stack
> if needed for each of them (and for each cpu for local events).
>
> When completing the event, if we were coming from kernel with interrupts
> disabled, simply return there. If coming from userspace or kernel with
> interrupts enabled, simulate an interrupt exception by setting IE_SIE in
> CSR_IP to allow delivery of signals to user task. For instance this can
> happen, when a RAS event has been generated by a user application and a
> SIGBUS has been sent to a task.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <cleger@rivosinc.com>
> ---
>  arch/riscv/include/asm/asm.h         |  14 ++-
>  arch/riscv/include/asm/scs.h         |   7 ++
>  arch/riscv/include/asm/sse.h         |  47 +++++++
>  arch/riscv/include/asm/switch_to.h   |  14 +++
>  arch/riscv/include/asm/thread_info.h |   1 +
>  arch/riscv/kernel/Makefile           |   1 +
>  arch/riscv/kernel/asm-offsets.c      |  14 +++
>  arch/riscv/kernel/sse.c              | 154 +++++++++++++++++++++++
>  arch/riscv/kernel/sse_entry.S        | 180 +++++++++++++++++++++++++++
>  9 files changed, 429 insertions(+), 3 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sse.h
>  create mode 100644 arch/riscv/kernel/sse.c
>  create mode 100644 arch/riscv/kernel/sse_entry.S
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index a8a2af6dfe9d..982c4be9a9c3 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -90,16 +90,24 @@
>  #define PER_CPU_OFFSET_SHIFT 3
>  #endif
>
> -.macro asm_per_cpu dst sym tmp
> -       REG_L \tmp, TASK_TI_CPU_NUM(tp)
> -       slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
> +       slli  \tmp, \cpu, PER_CPU_OFFSET_SHIFT
>         la    \dst, __per_cpu_offset
>         add   \dst, \dst, \tmp
>         REG_L \tmp, 0(\dst)
>         la    \dst, \sym
>         add   \dst, \dst, \tmp
>  .endm
> +
> +.macro asm_per_cpu dst sym tmp
> +       REG_L \tmp, TASK_TI_CPU_NUM(tp)
> +       asm_per_cpu_with_cpu \dst \sym \tmp \tmp
> +.endm
>  #else /* CONFIG_SMP */
> +.macro asm_per_cpu_with_cpu dst sym tmp cpu
> +       la    \dst, \sym
> +.endm
> +
>  .macro asm_per_cpu dst sym tmp
>         la    \dst, \sym
>  .endm
> diff --git a/arch/riscv/include/asm/scs.h b/arch/riscv/include/asm/scs.h
> index 0e45db78b24b..62344daad73d 100644
> --- a/arch/riscv/include/asm/scs.h
> +++ b/arch/riscv/include/asm/scs.h
> @@ -18,6 +18,11 @@
>         load_per_cpu gp, irq_shadow_call_stack_ptr, \tmp
>  .endm
>
> +/* Load the per-CPU IRQ shadow call stack to gp. */
> +.macro scs_load_sse_stack reg_evt
> +       REG_L gp, SSE_REG_EVT_SHADOW_STACK(\reg_evt)
> +.endm
> +
>  /* Load task_scs_sp(current) to gp. */
>  .macro scs_load_current
>         REG_L   gp, TASK_TI_SCS_SP(tp)
> @@ -41,6 +46,8 @@
>  .endm
>  .macro scs_load_irq_stack tmp
>  .endm
> +.macro scs_load_sse_stack reg_evt
> +.endm
>  .macro scs_load_current
>  .endm
>  .macro scs_load_current_if_task_changed prev
> diff --git a/arch/riscv/include/asm/sse.h b/arch/riscv/include/asm/sse.h
> new file mode 100644
> index 000000000000..8929a268462c
> --- /dev/null
> +++ b/arch/riscv/include/asm/sse.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +#ifndef __ASM_SSE_H
> +#define __ASM_SSE_H
> +
> +#include <asm/sbi.h>
> +
> +#ifdef CONFIG_RISCV_SSE
> +
> +struct sse_event_interrupted_state {
> +       unsigned long a6;
> +       unsigned long a7;
> +};
> +
> +struct sse_event_arch_data {
> +       void *stack;
> +       void *shadow_stack;
> +       unsigned long tmp;
> +       struct sse_event_interrupted_state interrupted;
> +       unsigned long interrupted_phys;
> +       u32 evt_id;
> +       unsigned int hart_id;
> +       unsigned int cpu_id;
> +};
> +
> +static inline bool sse_event_is_global(u32 evt)
> +{
> +       return !!(evt & SBI_SSE_EVENT_GLOBAL);
> +}
> +
> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int=
 cpu);
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id=
,
> +                       int cpu);
> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt);
> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt);
> +
> +void sse_handle_event(struct sse_event_arch_data *arch_evt,
> +                     struct pt_regs *regs);
> +asmlinkage void handle_sse(void);
> +asmlinkage void do_sse(struct sse_event_arch_data *arch_evt,
> +                      struct pt_regs *reg);
> +
> +#endif
> +
> +#endif
> diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/=
switch_to.h
> index 0e71eb82f920..cd1cead0c682 100644
> --- a/arch/riscv/include/asm/switch_to.h
> +++ b/arch/riscv/include/asm/switch_to.h
> @@ -88,6 +88,19 @@ static inline void __switch_to_envcfg(struct task_stru=
ct *next)
>                         :: "r" (next->thread.envcfg) : "memory");
>  }
>
> +#ifdef CONFIG_RISCV_SSE
> +DECLARE_PER_CPU(struct task_struct *, __sse_entry_task);
> +
> +static inline void __switch_sse_entry_task(struct task_struct *next)
> +{
> +       __this_cpu_write(__sse_entry_task, next);
> +}
> +#else
> +static inline void __switch_sse_entry_task(struct task_struct *next)
> +{
> +}
> +#endif
> +
>  extern struct task_struct *__switch_to(struct task_struct *,
>                                        struct task_struct *);
>
> @@ -122,6 +135,7 @@ do {                                                 =
       \
>         if (switch_to_should_flush_icache(__next))      \
>                 local_flush_icache_all();               \
>         __switch_to_envcfg(__next);                     \
> +       __switch_sse_entry_task(__next);                        \
>         ((last) =3D __switch_to(__prev, __next));         \
>  } while (0)
>
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index f5916a70879a..28e9805e61fc 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -36,6 +36,7 @@
>  #define OVERFLOW_STACK_SIZE     SZ_4K
>
>  #define IRQ_STACK_SIZE         THREAD_SIZE
> +#define SSE_STACK_SIZE         THREAD_SIZE
>
>  #ifndef __ASSEMBLY__
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index c7b542573407..62e4490b34ee 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)  +=3D mcount-dyn.o
>  obj-$(CONFIG_PERF_EVENTS)      +=3D perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   +=3D perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                +=3D sbi.o sbi_ecall.o
> +obj-$(CONFIG_RISCV_SSE)                +=3D sse.o sse_entry.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP)              +=3D sbi-ipi.o
>  obj-$(CONFIG_SMP) +=3D cpu_ops_sbi.o
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offs=
ets.c
> index 6e8c0d6feae9..315547c3a2ef 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -14,6 +14,8 @@
>  #include <asm/ptrace.h>
>  #include <asm/cpu_ops_sbi.h>
>  #include <asm/stacktrace.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
>  #include <asm/suspend.h>
>
>  void asm_offsets(void);
> @@ -528,4 +530,16 @@ void asm_offsets(void)
>         DEFINE(FREGS_A6,            offsetof(struct __arch_ftrace_regs, a=
6));
>         DEFINE(FREGS_A7,            offsetof(struct __arch_ftrace_regs, a=
7));
>  #endif
> +
> +#ifdef CONFIG_RISCV_SSE
> +       OFFSET(SSE_REG_EVT_STACK, sse_event_arch_data, stack);
> +       OFFSET(SSE_REG_EVT_SHADOW_STACK, sse_event_arch_data, shadow_stac=
k);
> +       OFFSET(SSE_REG_EVT_TMP, sse_event_arch_data, tmp);
> +       OFFSET(SSE_REG_HART_ID, sse_event_arch_data, hart_id);
> +       OFFSET(SSE_REG_CPU_ID, sse_event_arch_data, cpu_id);
> +
> +       DEFINE(SBI_EXT_SSE, SBI_EXT_SSE);
> +       DEFINE(SBI_SSE_EVENT_COMPLETE, SBI_SSE_EVENT_COMPLETE);
> +       DEFINE(ASM_NR_CPUS, NR_CPUS);
> +#endif
>  }
> diff --git a/arch/riscv/kernel/sse.c b/arch/riscv/kernel/sse.c
> new file mode 100644
> index 000000000000..d2da7e23a74a
> --- /dev/null
> +++ b/arch/riscv/kernel/sse.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Rivos Inc.
> + */
> +#include <linux/nmi.h>
> +#include <linux/scs.h>
> +#include <linux/bitfield.h>
> +#include <linux/riscv_sse.h>
> +#include <linux/percpu-defs.h>
> +
> +#include <asm/asm-prototypes.h>
> +#include <asm/switch_to.h>
> +#include <asm/irq_stack.h>
> +#include <asm/sbi.h>
> +#include <asm/sse.h>
> +
> +DEFINE_PER_CPU(struct task_struct *, __sse_entry_task);
> +
> +void __weak sse_handle_event(struct sse_event_arch_data *arch_evt, struc=
t pt_regs *regs)
> +{
> +}
> +
> +void do_sse(struct sse_event_arch_data *arch_evt, struct pt_regs *regs)
> +{
> +       nmi_enter();
> +
> +       /* Retrieve missing GPRs from SBI */
> +       sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_ATTR_READ, arch_evt->evt_id,
> +                 SBI_SSE_ATTR_INTERRUPTED_A6,
> +                 (SBI_SSE_ATTR_INTERRUPTED_A7 - SBI_SSE_ATTR_INTERRUPTED=
_A6) + 1,
> +                 arch_evt->interrupted_phys, 0, 0);
> +
> +       memcpy(&regs->a6, &arch_evt->interrupted, sizeof(arch_evt->interr=
upted));
> +
> +       sse_handle_event(arch_evt, regs);
> +
> +       /*
> +        * The SSE delivery path does not uses the "standard" exception p=
ath
> +        * (see sse_entry.S) and does not process any pending signal/soft=
irqs
> +        * due to being similar to a NMI.
> +        * Some drivers (PMU, RAS) enqueue pending work that needs to be =
handled
> +        * as soon as possible by bottom halves. For that purpose, set th=
e SIP
> +        * software interrupt pending bit which will force a software int=
errupt
> +        * to be serviced once interrupts are reenabled in the interrupte=
d
> +        * context if they were masked or directly if unmasked.
> +        */
> +       csr_set(CSR_IP, IE_SIE);

When using perf record, will S mode interrupts experience starvation?

> +
> +       nmi_exit();
> +}
> +
> +static void *alloc_to_stack_pointer(void *alloc)
> +{
> +       return alloc ? alloc + SSE_STACK_SIZE : NULL;
> +}
> +
> +static void *stack_pointer_to_alloc(void *stack)
> +{
> +       return stack - SSE_STACK_SIZE;
> +}
> +
> +#ifdef CONFIG_VMAP_STACK
> +static void *sse_stack_alloc(unsigned int cpu)
> +{
> +       void *stack =3D arch_alloc_vmap_stack(SSE_STACK_SIZE, cpu_to_node=
(cpu));
> +
> +       return alloc_to_stack_pointer(stack);
> +}
> +
> +static void sse_stack_free(void *stack)
> +{
> +       vfree(stack_pointer_to_alloc(stack));
> +}
> +#else /* CONFIG_VMAP_STACK */
> +static void *sse_stack_alloc(unsigned int cpu)
> +{
> +       void *stack =3D kmalloc(SSE_STACK_SIZE, GFP_KERNEL);
> +
> +       return alloc_to_stack_pointer(stack);
> +}
> +
> +static void sse_stack_free(void *stack)
> +{
> +       kfree(stack_pointer_to_alloc(stack));
> +}
> +#endif /* CONFIG_VMAP_STACK */
> +
> +static int sse_init_scs(int cpu, struct sse_event_arch_data *arch_evt)
> +{
> +       void *stack;
> +
> +       if (!scs_is_enabled())
> +               return 0;
> +
> +       stack =3D scs_alloc(cpu_to_node(cpu));
> +       if (!stack)
> +               return -ENOMEM;
> +
> +       arch_evt->shadow_stack =3D stack;
> +
> +       return 0;
> +}
> +
> +void arch_sse_event_update_cpu(struct sse_event_arch_data *arch_evt, int=
 cpu)
> +{
> +       arch_evt->cpu_id =3D cpu;
> +       arch_evt->hart_id =3D cpuid_to_hartid_map(cpu);
> +}
> +
> +int arch_sse_init_event(struct sse_event_arch_data *arch_evt, u32 evt_id=
, int cpu)
> +{
> +       void *stack;
> +
> +       arch_evt->evt_id =3D evt_id;
> +       stack =3D sse_stack_alloc(cpu);
> +       if (!stack)
> +               return -ENOMEM;
> +
> +       arch_evt->stack =3D stack;
> +
> +       if (sse_init_scs(cpu, arch_evt)) {
> +               sse_stack_free(arch_evt->stack);
> +               return -ENOMEM;
> +       }
> +
> +       if (sse_event_is_global(evt_id)) {
> +               arch_evt->interrupted_phys =3D
> +                                       virt_to_phys(&arch_evt->interrupt=
ed);
> +       } else {
> +               arch_evt->interrupted_phys =3D
> +                               per_cpu_ptr_to_phys(&arch_evt->interrupte=
d);
> +       }
> +
> +       arch_sse_event_update_cpu(arch_evt, cpu);
> +
> +       return 0;
> +}
> +
> +void arch_sse_free_event(struct sse_event_arch_data *arch_evt)
> +{
> +       scs_free(arch_evt->shadow_stack);
> +       sse_stack_free(arch_evt->stack);
> +}
> +
> +int arch_sse_register_event(struct sse_event_arch_data *arch_evt)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_SSE, SBI_SSE_EVENT_REGISTER, arch_evt-=
>evt_id,
> +                        (unsigned long)handle_sse, (unsigned long)arch_e=
vt, 0,
> +                        0, 0);
> +
> +       return sbi_err_map_linux_errno(sret.error);
> +}
...

Thanks,
Yunhui

