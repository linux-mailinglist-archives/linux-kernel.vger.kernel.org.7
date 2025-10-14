Return-Path: <linux-kernel+bounces-852293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D1BBD8A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12F55442F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9DF2882CD;
	Tue, 14 Oct 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Zzq9gMTY"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C926222587
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435997; cv=none; b=c78ebrItM/8Xd+a3+WJBBKo2U+Vc0jZYRq09xeyPtoak6MKBLpYY9UvLCD9uCaNhsjlVQdpviRvlT219HyZVC2qdqAODZ1ynL8fQ+NOEO0Y7nLHVqeZMMF2sBzcpCn96dMpoZiVoK2a43CRahi6QNfWB5UeLRvejqBe23VTASQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435997; c=relaxed/simple;
	bh=uNX8D3F++srFcXlzttijqaNW4iJjako7CZq1RnxcZpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE+cmC4fykctujFc5oV9ycI07LxqzxOrOUIPZOktF6SY9o/3pNYGLRHMtPsEQ1v7Y49O0PjJS1Nnfa6XZRZiBIH9Y2uKL+3ey8jztNj3u3sq9cWqVsrNHg7bEkQehiTnLNo73aFusIL8m2+/9RYd8eMdPoLFNJiZedaHH+q8WXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Zzq9gMTY; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57dfd0b6cd7so5880015e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760435993; x=1761040793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGnwyF4jYSh+xrpmPEI3PovGZBe2hum4kk9xDbM3qa0=;
        b=Zzq9gMTYLPKg83lHmjdZPB6qiStgR1B/KNJaosA6cCvjWqsAdYLPKdfkJ8CqlwUict
         xFa4uCytL9mP+PcjlwWaj4B571qchhuDzyGQYvfpA4a9Z1hNYCYM4cYhIsIVvQRbMt+E
         7N8Pe5ydf7ksFygR6vzjTR0e9PDboabp5PxWRO7JI0uUI32MwuIdHnXlawc1y/jVtl7d
         R2BeyKBfya3PN5+dygb/FSgzw6jbJ+lJpxWxGGQ4XbY2b9isD2P4l+676GMB+lvHAEM4
         s7lS73KDfnZ0kGg+w3/eniCcpE0073/V28AxyXRCmFuBPhjgmew72NQxpqQVN+JKLVKK
         22ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435993; x=1761040793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGnwyF4jYSh+xrpmPEI3PovGZBe2hum4kk9xDbM3qa0=;
        b=jlpsX2OJHigCo1L44DyHxsIKLrpf2LSr+y7T4ZHW4jzemdv0RewNzbj04GxbKz+JKD
         wRuWvcpaSQYkvXNRx8tCp6rzKsJsDw4vC2Bf2/0TkGGRv9WV9OeHtKAYMnFZyQtls7+s
         g411LLrvHmOlLov6OeqZrI3TrYHdQAOhDcss0P+59O/5X0KcVgAJ29tZbxTXvgyrZ1su
         QW0+RSZVDuiUALK9MEA5bWIAHmA8UNQvGx2OY7N/sZpYWDnl5Ur2km1MTJKaCndPFVSJ
         9G2K7k/sgqbKUeT3slQc1McEDFnUkIUzfKpgyc+rM8ne77ApCVT64ITvuv86Hm6j4j94
         /lEA==
X-Forwarded-Encrypted: i=1; AJvYcCUJU+IY7s0XkkvJ3tG7AVFayVa/UzSOeE6WmzPZvGU6h5rHun1V3Mg4hxMrQAEx58RelrwAtR47dOyOtNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzICT1t9Ae9aoc/HdRztO0C3gBQE2aZuF2m8i5C8ldmwruytiWe
	wRjOz9j/23LMGsg5AR4C3rbDXKR4W//xZoxG10kzDiMqyJmQlGrUl1xmeZvJgxdxaPvMcDEUTNt
	7cIqRdxs09/78jNd48QbZsFn8beFiczWX0Z+2EXxVIrbS5tG6wDqm8H0=
X-Gm-Gg: ASbGncsBndunrNc05V4nftZlqSIvHnIeGc8+rY0j+1JorCboOsYzw1EDxtrzQfM5oYk
	BkQQtgYNIEf4tP3NyLx7DKfCFRIQ60hbBK+H/LhNrGDRkXDw6t1zEzDHMe/VjGpvAvIqKFrMmMS
	yspqbnEh+ZXbcfvzYIDYOnPhqA7Pp+HVRpDtl5vSl8qOeUPaV1EaYe2jIQd7VE2Bs7f+1j/nPf3
	8Q42QD7xOATT/PJJKGV2irH+Q==
X-Google-Smtp-Source: AGHT+IFccA1E4PwdPeeKOGDJIdWhNIjb/k89kPVOnFoDhwCQaRYrKxTJ0bronuRsh6s3sU6ql3j1EwsME3Nk8U8WO64=
X-Received: by 2002:a05:6512:3b96:b0:576:d5df:fe1b with SMTP id
 2adb3069b0e04-5906d75f897mr6922565e87.10.1760435993287; Tue, 14 Oct 2025
 02:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905122512.71684-1-apatel@ventanamicro.com>
In-Reply-To: <20250905122512.71684-1-apatel@ventanamicro.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 14 Oct 2025 15:29:42 +0530
X-Gm-Features: AS18NWDD6aRd1nI8wArqIOvocEcwVLyW7B4gNUAD7NAERHdf-8hTiE64kQnFO_w
Message-ID: <CAK9=C2V6QXbnnr-WmE4AeCviL5Or0qGisFugnLiNK6WDOsUHJw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Enable HOTPLUG_PARALLEL for secondary CPUs
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Sunil V L <sunilvl@ventanamicro.com>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 5:55=E2=80=AFPM Anup Patel <apatel@ventanamicro.com>=
 wrote:
>
> The core kernel already supports parallel bringup of secondary
> CPUs (aka HOTPLUG_PARALLEL). The x86 and MIPS architectures
> already use HOTPLUG_PARALLEL and ARM is also moving toward it.
>
> On RISC-V, there is no arch specific global data accessed in the
> RISC-V secondary CPU bringup path so enabling HOTPLUG_PARALLEL for
> RISC-V would only requires:
> 1) Providing RISC-V specific arch_cpuhp_kick_ap_alive()
> 2) Calling cpuhp_ap_sync_alive() from smp_callin()
>
> This patch is tested natively with OpenSBI on QEMU RV64 virt machine
> with 64 cores and also tested with KVM RISC-V guest with 32 VCPUs.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Friendly ping ? Any comments on this one ?

Regards,
Anup

> ---
>  arch/riscv/Kconfig          |  2 +-
>  arch/riscv/kernel/smpboot.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a4b233a0659e..d5800d6f9a15 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -196,7 +196,7 @@ config RISCV
>         select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
>         select HAVE_STACKPROTECTOR
>         select HAVE_SYSCALL_TRACEPOINTS
> -       select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
> +       select HOTPLUG_PARALLEL if HOTPLUG_CPU
>         select IRQ_DOMAIN
>         select IRQ_FORCED_THREADING
>         select KASAN_VMALLOC if KASAN
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 601a321e0f17..d85916a3660c 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -39,7 +39,9 @@
>
>  #include "head.h"
>
> +#ifndef CONFIG_HOTPLUG_PARALLEL
>  static DECLARE_COMPLETION(cpu_running);
> +#endif
>
>  void __init smp_prepare_cpus(unsigned int max_cpus)
>  {
> @@ -179,6 +181,12 @@ static int start_secondary_cpu(int cpu, struct task_=
struct *tidle)
>         return -EOPNOTSUPP;
>  }
>
> +#ifdef CONFIG_HOTPLUG_PARALLEL
> +int arch_cpuhp_kick_ap_alive(unsigned int cpu, struct task_struct *tidle=
)
> +{
> +       return start_secondary_cpu(cpu, tidle);
> +}
> +#else
>  int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
>         int ret =3D 0;
> @@ -199,6 +207,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *ti=
dle)
>
>         return ret;
>  }
> +#endif
>
>  void __init smp_cpus_done(unsigned int max_cpus)
>  {
> @@ -225,6 +234,10 @@ asmlinkage __visible void smp_callin(void)
>         mmgrab(mm);
>         current->active_mm =3D mm;
>
> +#ifdef CONFIG_HOTPLUG_PARALLEL
> +       cpuhp_ap_sync_alive();
> +#endif
> +
>         store_cpu_topology(curr_cpuid);
>         notify_cpu_starting(curr_cpuid);
>
> @@ -243,7 +256,9 @@ asmlinkage __visible void smp_callin(void)
>          */
>         local_flush_icache_all();
>         local_flush_tlb_all();
> +#ifndef CONFIG_HOTPLUG_PARALLEL
>         complete(&cpu_running);
> +#endif
>         /*
>          * Disable preemption before enabling interrupts, so we don't try=
 to
>          * schedule a CPU that hasn't actually started yet.
> --
> 2.43.0
>

