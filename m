Return-Path: <linux-kernel+bounces-873309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFDC13A22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15D39563CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8558296BC5;
	Tue, 28 Oct 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="1p1v+ecK"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AFC209F43
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641343; cv=none; b=PBKhOrxZFw0fYgO7vNfdUVwM+m5SnTMtfdtHSsBgD08FmR3mvHAKxiKmHBOHjKtVxjgWqqj3awQhOACljhGotT611tmHjC/pHcPBslhuDG/v/Y2VwFUc7WQ/C+VxSJ0Lh7nZs6TzQuNlwoathaOSbCu2Gi3EogKX2yVHxqlhJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641343; c=relaxed/simple;
	bh=JoSpd1Y2s+SKdaoAqTh1RDxCAqr82ccTDXUqiqK91Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmenQd4Cyq2wc9e70ctIXlx7pHU4U0TtD0yDYVzB1eNGv5eBcsosyvyJrjbPjOkpXjlvCy3DsLMLmgrCSNmFd+dmVdPAid+5oBbBalAqv00J3KCeJOH6XFP5kJRVbxmHyOyptVxy4fm+ZX3m3j2dB9WFsmpGGtPe6GYm3FGiNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=1p1v+ecK; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-431da4fa224so54526205ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1761641341; x=1762246141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Nqa5RbaqHXJiWr4JVVo/GVQ9sZBLUjp7DYkmXle1AE=;
        b=1p1v+ecKh0GRLSRHn9eknQ/oja0oZ3iz7m6fojCSPibe2HP45ICVDZDhGohSWPyacC
         qVpRlYJOUr+GKAki+1PednBnuf/fOBXt1cAR6FJeKxyOaQn+SQDsYx6AxNOPKdf5qZqC
         mWdlsCkAi81hkt1KbBJA4eNvxm9YTRTAb7Khz+a5hOn+eUu02d4T6suyeTaalvHEL3UM
         kt7uQiqEdWbiQhm+S41qYjWnCzL0hbM4wSF1Uv+04yi5evfzL3DjiMJEgB2MGqQyCFln
         FJgL1SphXAY1A1Zdcpji6swsDXol2Ya588GRl5vhZJ+XUuyY8nqcvMLUZcNQE+OC4Tc2
         OPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641341; x=1762246141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Nqa5RbaqHXJiWr4JVVo/GVQ9sZBLUjp7DYkmXle1AE=;
        b=f8DzEBcjtqmVdWsuwhQL03XhKR/wa3U2VZEedEw1//m9HE42lMw94vXBuMc1ph2aix
         wVYGWuY2wdJOtbIXNS4SR/ThC9j64vWYSQAZafRdLoJCRyaURhEBUmCcnFTHSAP4IYwA
         8Yc150wPsb87mouTfvbXpRRAs1VMk7qQmnx6QsGziUI1BI2J6w4ZNb0WhxRYM4GXIsMl
         as/rjlFONSb02eKyq36xrBbltbPPolRnu3mgk+aymL7auY71FZTv7DUtilMdDCTkOn64
         qM8g3L6c/QKilt7k1fVsSFOwhZXYNXvVMNdhOBeRBZGxV+r2O7cANqEy5Vz4WEDnrBRk
         yyWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHDpygvTs5MNzBN7IQiNFUMhH3ULljeuTMmhqDcuOIg5APMCjUwwB+5XKQMdB7mWRAKuXd4VXCsZ51Si8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL5OAoUhVi5ufX1TsepyOsT24RqsKCbw30AEWyadct7k5VPxlz
	+e3iHwKbxCSCcKwKrK/XKhMNSHfPAJ0tMYIOEr7ym+Y1Hgwh3v8+hk+gwfQX63Vlpsl60uLEPOB
	RgNnoK+gkF3FGxiIrjLO6w0Gqkr7MAU6D4g4oHlWPoQ==
X-Gm-Gg: ASbGnct6ti6xX4vTytW8im3U0+WGS52YrF7UhzFpS5eCXNb0RVZNDtO9tcZHRJiDnXK
	+1FvhBqleGT7z/4jXDTwXk4UM/R/HGK2g0mqkKfF25EvGGhJPsqIHtvbjmA4Igl/WMheZYh0aPE
	9CspYd0YtObmbsLvPUuP7ZETX0t8APpI/wcjdT9WL8UBSuMfRSMqURoqPBUIhcI0++LY7TfSSct
	pIxXfg3M8FwS3wTh1V1HsayaKHAoCsm81QQ56extaiJwWbjWz/C8hyI5hYwFgtIbr3PAzwNicKH
	wXvzf8obLq/KG49nZkueybujbvI6
X-Google-Smtp-Source: AGHT+IEH7J7U7ktX4Uis4xGlSf/2jzsm1a9LrCcJPxeHAMh+NGwOe+bFbXW6utxN1p2P8zORVmeyzMyyBWVM07iRlGU=
X-Received: by 2002:a05:6e02:240c:b0:423:fcd6:5488 with SMTP id
 e9e14a558f8ab-4320f7bbbadmr48796285ab.12.1761641341073; Tue, 28 Oct 2025
 01:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905122512.71684-1-apatel@ventanamicro.com> <0f7e6be5-f9ac-4019-93c6-295a068046a8@linux.dev>
In-Reply-To: <0f7e6be5-f9ac-4019-93c6-295a068046a8@linux.dev>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 28 Oct 2025 14:18:50 +0530
X-Gm-Features: AWmQ_bmTYrN-PytsOBqPCeZ_JizA4VaPwRHendFWQXuSdLMWDi1UfvXqBxHKNLI
Message-ID: <CAAhSdy1uGQaPc2SkcX5oHF-aP4dOS1gu5iHor5O8zmz-XWUtBA@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable HOTPLUG_PARALLEL for secondary CPUs
To: Atish Patra <atish.patra@linux.dev>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Sunil V L <sunilvl@ventanamicro.com>, Andrew Jones <ajones@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 2:05=E2=80=AFPM Atish Patra <atish.patra@linux.dev>=
 wrote:
>
>
> On 9/5/25 5:25 AM, Anup Patel wrote:
> > The core kernel already supports parallel bringup of secondary
> > CPUs (aka HOTPLUG_PARALLEL). The x86 and MIPS architectures
> > already use HOTPLUG_PARALLEL and ARM is also moving toward it.
> >
> > On RISC-V, there is no arch specific global data accessed in the
> > RISC-V secondary CPU bringup path so enabling HOTPLUG_PARALLEL for
> > RISC-V would only requires:
> > 1) Providing RISC-V specific arch_cpuhp_kick_ap_alive()
> > 2) Calling cpuhp_ap_sync_alive() from smp_callin()
> >
> > This patch is tested natively with OpenSBI on QEMU RV64 virt machine
> > with 64 cores and also tested with KVM RISC-V guest with 32 VCPUs.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >   arch/riscv/Kconfig          |  2 +-
> >   arch/riscv/kernel/smpboot.c | 15 +++++++++++++++
> >   2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index a4b233a0659e..d5800d6f9a15 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -196,7 +196,7 @@ config RISCV
> >       select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> >       select HAVE_STACKPROTECTOR
> >       select HAVE_SYSCALL_TRACEPOINTS
> > -     select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
> > +     select HOTPLUG_PARALLEL if HOTPLUG_CPU
> >       select IRQ_DOMAIN
> >       select IRQ_FORCED_THREADING
> >       select KASAN_VMALLOC if KASAN
> > diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> > index 601a321e0f17..d85916a3660c 100644
> > --- a/arch/riscv/kernel/smpboot.c
> > +++ b/arch/riscv/kernel/smpboot.c
> > @@ -39,7 +39,9 @@
> >
> >   #include "head.h"
> >
> > +#ifndef CONFIG_HOTPLUG_PARALLEL
> >   static DECLARE_COMPLETION(cpu_running);
> > +#endif
> >
> >   void __init smp_prepare_cpus(unsigned int max_cpus)
> >   {
> > @@ -179,6 +181,12 @@ static int start_secondary_cpu(int cpu, struct tas=
k_struct *tidle)
> >       return -EOPNOTSUPP;
> >   }
> >
> > +#ifdef CONFIG_HOTPLUG_PARALLEL
> > +int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tid=
le)
> > +{
> > +     return start_secondary_cpu(cpu, tidle);
> > +}
> > +#else
> >   int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> >   {
> >       int ret =3D 0;
> > @@ -199,6 +207,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *=
tidle)
> >
> >       return ret;
> >   }
> > +#endif
> >
> >   void __init smp_cpus_done(unsigned int max_cpus)
> >   {
> > @@ -225,6 +234,10 @@ asmlinkage __visible void smp_callin(void)
> >       mmgrab(mm);
> >       current->active_mm =3D mm;
> >
> > +#ifdef CONFIG_HOTPLUG_PARALLEL
> > +     cpuhp_ap_sync_alive();
> > +#endif
> > +
> >       store_cpu_topology(curr_cpuid);
> >       notify_cpu_starting(curr_cpuid);
> >
> > @@ -243,7 +256,9 @@ asmlinkage __visible void smp_callin(void)
> >        */
> >       local_flush_icache_all();
> >       local_flush_tlb_all();
> > +#ifndef CONFIG_HOTPLUG_PARALLEL
> >       complete(&cpu_running);
> > +#endif
>
> LGTM.
>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
>
> Have you tried with 128 harts ? I was not able to boot 128 harts in Qemu
> with NR_CPUS=3D256.
> This is unrelated to this patch though. I can reproduce the issue on
> upstream with 6.18-rc3.

I have tried upto 96 harts and that works fine.

For 128 harts, the memory used by OpenSBI goes beyond 2MB so
OpenSBI can't run from the first 2MB of DRAM (0x80000000) as the
first booting stage. Try with U-Boot SPL loading OpenSBI from FIT image.

Regards,
Anup

>
>
> >       /*
> >        * Disable preemption before enabling interrupts, so we don't try=
 to
> >        * schedule a CPU that hasn't actually started yet.

