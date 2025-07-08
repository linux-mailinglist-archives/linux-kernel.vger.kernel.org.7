Return-Path: <linux-kernel+bounces-721347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F5FAFC7F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03A51BC5033
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD626981C;
	Tue,  8 Jul 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KwFsDt5p"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64BC26980F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969262; cv=none; b=EsUEFz0jWi82AA0uCpX8puK0cIfuA8R9rePiIv6jAfKHXXqPXBoutFp5Y0Amjp7KEryuOuAgjWh48+JxHVOR0seyzipHqxALrDZtSacuqGTkFEWrVeu3T2wZ8pHuzGbsM+hbS2GDIvbECK695LECVb8FZqKzQ4pbt5VJC9NsHu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969262; c=relaxed/simple;
	bh=35djzYc9BLFa8nR6gLknLCooLN3D2nfxBd+OYygbI+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqYa4YFyqnR9rRkmkKG2D4Sjd7SxUpzvNuKtT0oSsyYHgCx/A7xPz4DEEHWStmHvReHPOuGjX2w8RBE61juqwilGFQgKn5wF5ZVQxnh5mSIS6RBiL8AzXtJD+DwbbDeraVUAk57cqtb47ppg3GZyoLyxzPk814kMSQm4qiJ4Fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KwFsDt5p; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-407a3913049so1662424b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1751969259; x=1752574059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShBg34hVsoMJ1vlPxNf3mH3/jDb2DnYrFBCkYKMK3pY=;
        b=KwFsDt5pFXdStGWGsWIKIOGCYlDybZlRMH3AkpY5T8apqxALA6M6N8HBQiG3C7G6DJ
         Oxdlfl1Nc05n5gHCd4A1Guijj7DalNq2RURwbZUEb7MuCZ6Tk90xrQyijxSX9LDjkewf
         /JyewuvuEviJ6Vh+UknJaRXfldDl6ccZGc9RxbpIF6X63XkAJngzz+omK2cykh4rf5EX
         UquJz8nwp56iSXJXDpC6dhukQY7NZUIEC+BKMwdHGwUNvSvmdQHiB7JQ3fWNyu4w65v+
         kfsRMnDyuj2wpeJ0On6qci5XIa1zFG5CYfot9EponlpKEnqr6+98IEyBJkWmSw2zc9yN
         g5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969259; x=1752574059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShBg34hVsoMJ1vlPxNf3mH3/jDb2DnYrFBCkYKMK3pY=;
        b=NRqwWeQ254NDnHtVGb8fSplwBYMlCgQojvoVBmlHorc+XxgXIvb665PcVKfi+ROqJi
         rYhVqjFX2VXRqHu20wzgvrr1ZjLYBDZZCFpqQUsmszW4P7fZbSSRWu3S69EYpoOYGWze
         sfATmWbFrfV1tqx0yL04FylIVBgfR51hJP/50E3McEK0QCeRbkEkUmJwErn/MSiCXE6V
         xNgokgdy5LE06UOfAGcqfoqRJMWVsFQ5KEd5F0SRm2RgIyh67YABqzkMq3khZWFfn0qV
         Bkvuhk5GF1KJnvB8HoRSYJcDiw0HbZbysMSjxFUdUWOmvxEF+/fY2pEiKk3T9LkNY3Gj
         Ev+A==
X-Forwarded-Encrypted: i=1; AJvYcCXI+WRyoRhDvwRDuV79sgZJjhG+WGA05H/YB5B7Moidy6+jpMVGkbwEVi3BER1HvECXbxteha+UnIAhoq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUwamvJDPtYCWhFev/2g/vwoBk6n3cusNEU67Oo3nWCthb0uJ
	NJdS9WTlKLc4DTmNdWKJubVLXBMAMmtKvpMM5SB5VR6FTXppkuRGsmFSr09nMDdP3FoIJqv8SoB
	G8PqIVDS/qtrgSyAy8BRYHmyxry6lh+ORFZ1W/f5uKg==
X-Gm-Gg: ASbGncv7LHI2FbEn5f+HsHCqVJftw5Fp4wztNP0iwXPF8qmfhZq34+PrfYy7Dd08OUs
	4CcGiEPxjS7bMVu1rqlAbDmNV429fBX0/qWv2Rhh6oB2GGZpSL7MN2L/2rGcJI6BlrXulJyUi8p
	361fRAdJM0TeITgmTF/Fxk6XP4bPANBtdeL6fy1nx5FCYLCQ==
X-Google-Smtp-Source: AGHT+IFYEYqs2WMKAMHJi+n4eGUgFs64PQCx+HQ60GIjFCu+jrmCDIf42ANQM6HjwmKcez+B2RP2YUVdr28AeKuyiV4=
X-Received: by 2002:a05:6808:4a52:20b0:404:ed0d:79e5 with SMTP id
 5614622812f47-4113f408987mr1144175b6e.30.1751969259482; Tue, 08 Jul 2025
 03:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704084500.62688-1-cuiyunhui@bytedance.com> <DB5U402ARSEO.4H4PE19LGCR7@ventanamicro.com>
In-Reply-To: <DB5U402ARSEO.4H4PE19LGCR7@ventanamicro.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 8 Jul 2025 18:07:27 +0800
X-Gm-Features: Ac12FXysBXsB5Ps-NOvgjudnKpiBJody5f6VY0xxRLYTEmLwWFyQR8cdqQJ11iE
Message-ID: <CAEEQ3w=V6-d+YSWP=0WMt6UAZexrazq0UQjdyUmS3AnMtkdoKQ@mail.gmail.com>
Subject: Re: [External] [PATCH] RISC-V: store percpu offset in CSR_SCRATCH
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: masahiroy@kernel.org, nathan@kernel.org, nicolas.schier@linux.dev, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, andybnac@gmail.com, 
	bjorn@rivosinc.com, cyrilbur@tenstorrent.com, rostedt@goodmis.org, 
	puranjay@kernel.org, ben.dooks@codethink.co.uk, zhangchunyan@iscas.ac.cn, 
	ruanjinjie@huawei.com, jszhang@kernel.org, charlie@rivosinc.com, 
	cleger@rivosinc.com, antonb@tenstorrent.com, ajones@ventanamicro.com, 
	debug@rivosinc.com, haibo1.xu@intel.com, samuel.holland@sifive.com, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	linux-riscv <linux-riscv-bounces@lists.infradead.org>, wangziang.ok@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Radim,

On Mon, Jul 7, 2025 at 8:50=E2=80=AFPM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar=
@ventanamicro.com> wrote:
>
> 2025-07-04T16:45:00+08:00, Yunhui Cui <cuiyunhui@bytedance.com>:
> > The following data was collected from tests conducted on the
> > Spacemit(R) X60 using the fixed register method:
> > [...]
> > The fixed register method reduced performance by 5.29%.
> > The per-CPU offset optimization improved performance by 2.52%.
>
> What is the performance if you use the scratch register?
>
> The patch below is completely unoptimized as I didn't want to shuffle
> code around too much, but it could give a rough idea.
>
> Thanks.
>
> ---8<---
> The scratch register currently denotes the mode before exception, but we
> can just use two different exception entry points to provide the same
> information, which frees the scratch register for the percpu offset.
>
> The user/kernel entry paths need more through rewrite, because they are
> terribly wasteful right now.
> ---
> Applies on top of d7b8f8e20813f0179d8ef519541a3527e7661d3a (v6.16-rc5)
>
>  arch/riscv/include/asm/percpu.h | 13 ++++++++++
>  arch/riscv/kernel/entry.S       | 46 ++++++++++++++++++++-------------
>  arch/riscv/kernel/head.S        |  7 +----
>  arch/riscv/kernel/smpboot.c     |  7 +++++
>  arch/riscv/kernel/stacktrace.c  |  4 +--
>  5 files changed, 51 insertions(+), 26 deletions(-)
>  create mode 100644 arch/riscv/include/asm/percpu.h
>
> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/per=
cpu.h
> new file mode 100644
> index 000000000000..2c838514e3ea
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h
> @@ -0,0 +1,13 @@
> +#ifndef __ASM_PERCPU_H
> +#define __ASM_PERCPU_H
> +
> +static inline void set_my_cpu_offset(unsigned long off)
> +{
> +       csr_write(CSR_SCRATCH, off);
> +}
> +
> +#define __my_cpu_offset csr_read(CSR_SCRATCH)
> +
> +#include <asm-generic/percpu.h>
> +
> +#endif
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 75656afa2d6b..e48c553d6779 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -91,18 +91,8 @@
>         REG_L   a0, TASK_TI_A0(tp)
>  .endm
>
> -
> -SYM_CODE_START(handle_exception)
> -       /*
> -        * If coming from userspace, preserve the user thread pointer and=
 load
> -        * the kernel thread pointer.  If we came from the kernel, the sc=
ratch
> -        * register will contain 0, and we should continue on the current=
 TP.
> -        */
> -       csrrw tp, CSR_SCRATCH, tp
> -       bnez tp, .Lsave_context
> -
> -.Lrestore_kernel_tpsp:
> -       csrr tp, CSR_SCRATCH
> +SYM_CODE_START(handle_kernel_exception)
> +       csrw CSR_SCRATCH, tp
>
>  #ifdef CONFIG_64BIT
>         /*
> @@ -126,8 +116,22 @@ SYM_CODE_START(handle_exception)
>         bnez sp, handle_kernel_stack_overflow
>         REG_L sp, TASK_TI_KERNEL_SP(tp)
>  #endif
> +       j handle_exception
> +ASM_NOKPROBE(handle_kernel_exception)
> +SYM_CODE_END(handle_kernel_exception)
>
> -.Lsave_context:
> +SYM_CODE_START(handle_user_exception)
> +       /*
> +        * If coming from userspace, preserve the user thread pointer and=
 load
> +        * the kernel thread pointer.
> +        */
> +       csrrw tp, CSR_SCRATCH, tp
> +       j handle_exception
> +
> +SYM_CODE_END(handle_user_exception)
> +ASM_NOKPROBE(handle_user_exception)
> +
> +SYM_CODE_START_NOALIGN(handle_exception)
>         REG_S sp, TASK_TI_USER_SP(tp)
>         REG_L sp, TASK_TI_KERNEL_SP(tp)
>         addi sp, sp, -(PT_SIZE_ON_STACK)
> @@ -158,11 +162,15 @@ SYM_CODE_START(handle_exception)
>         REG_S s4, PT_CAUSE(sp)
>         REG_S s5, PT_TP(sp)
>
> -       /*
> -        * Set the scratch register to 0, so that if a recursive exceptio=
n
> -        * occurs, the exception vector knows it came from the kernel
> -        */
> -       csrw CSR_SCRATCH, x0
> +       REG_L s0, TASK_TI_CPU(tp)
> +       slli s0, s0, 3
> +       la s1, __per_cpu_offset
> +       add s1, s1, s0
> +       REG_L s1, 0(s1)
> +
> +       csrw CSR_SCRATCH, s1

This patch cleverly differentiates whether an exception originates
from user mode or kernel mode. However, there's still an issue with
using CSR_SCRATCH: each time handle_exception() is called, the
following instructions must be executed:

REG_L s0, TASK_TI_CPU(tp)
slli s0, s0, 3
la s1, __per_cpu_offset
add s1, s1, s0
REG_L s1, 0(s1)
csrw CSR_SCRATCH, s1

Should we consider adding a dedicated CSR (e.g., CSR_SCRATCH2) to
store the percpu offset instead?
See: https://lists.riscv.org/g/tech-privileged/topic/113437553#msg2506


> +       la s1, handle_kernel_exception
> +       csrw CSR_TVEC, s1
>
>         /* Load the global pointer */
>         load_global_pointer
> @@ -236,6 +244,8 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>          * structures again.
>          */
>         csrw CSR_SCRATCH, tp
> +       la a0, handle_user_exception
> +       csrw CSR_TVEC, a0
>  1:
>  #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>         move a0, sp
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index bdf3352acf4c..d8858334af2d 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -188,14 +188,9 @@ secondary_start_sbi:
>  .align 2
>  .Lsetup_trap_vector:
>         /* Set trap vector to exception handler */
> -       la a0, handle_exception
> +       la a0, handle_kernel_exception
>         csrw CSR_TVEC, a0
>
> -       /*
> -        * Set sup0 scratch register to 0, indicating to exception vector=
 that
> -        * we are presently executing in kernel.
> -        */
> -       csrw CSR_SCRATCH, zero
>         ret
>
>  SYM_CODE_END(_start)
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 601a321e0f17..2db44b10bedb 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -41,6 +41,11 @@
>
>  static DECLARE_COMPLETION(cpu_running);
>
> +void __init smp_prepare_boot_cpu(void)
> +{
> +       set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
> +}
> +
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
>         int cpuid;
> @@ -225,6 +230,8 @@ asmlinkage __visible void smp_callin(void)
>         mmgrab(mm);
>         current->active_mm =3D mm;
>
> +       set_my_cpu_offset(per_cpu_offset(curr_cpuid));
> +
>         store_cpu_topology(curr_cpuid);
>         notify_cpu_starting(curr_cpuid);
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 3fe9e6edef8f..69b2f390a2d4 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -16,7 +16,7 @@
>
>  #ifdef CONFIG_FRAME_POINTER
>
> -extern asmlinkage void handle_exception(void);
> +extern asmlinkage void handle_kernel_exception(void);
>  extern unsigned long ret_from_exception_end;
>
>  static inline int fp_is_valid(unsigned long fp, unsigned long sp)
> @@ -72,7 +72,7 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>                         fp =3D frame->fp;
>                         pc =3D ftrace_graph_ret_addr(current, &graph_idx,=
 frame->ra,
>                                                    &frame->ra);
> -                       if (pc >=3D (unsigned long)handle_exception &&
> +                       if (pc >=3D (unsigned long)handle_kernel_exceptio=
n &&
>                             pc < (unsigned long)&ret_from_exception_end) =
{
>                                 if (unlikely(!fn(arg, pc)))
>                                         break;

Thanks,
Yunhui

