Return-Path: <linux-kernel+bounces-799956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775DB4319E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34701B27BF9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A80423C4FD;
	Thu,  4 Sep 2025 05:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V1AcFyeG"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B8814A60C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963878; cv=none; b=hSE6shqPKhwbBJ7X2fbl98zzw7S3knPe6KJL6EewCoE0Jrl4KopxI6bVkl9j9OlPNcJ1pRy31EOSLZPxPW8NGQPCxAY39mDlOQ0kiqghALkVQn2soEQ+Cu8e7FOMW8Aze7xNITfecJN0QfWvybYP0YpaNGloHr54f6cVtqhVyo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963878; c=relaxed/simple;
	bh=vGcbX+I0w1fuEqR/qXTtav6XoGYX3rGtlVX/FK6XFuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qnhzd3WJI9pc5ukJnNmKETx0hktyE6PP+LDKRKsGC3ImQg9agoDZ8ZEMjBPNbKOKdhVwqDUpJZmDFctqu1sR5EBQk5voQrOKGHaaia4F/f9mORtKzhp3N1ZrRnJUkodnoWUnT1NB91I3rrTso8eKjsX5g+l3TCbHXUpTImMYoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=V1AcFyeG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso734917e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1756963875; x=1757568675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUS5HOLhW/VpyZE9onIdkx0oHXwb/D4QXFFEiFH3pRQ=;
        b=V1AcFyeGzS1iy+U1HenPzqA9mkeuvziFn2degKBzdcqowmOCCjGnQp9XUrdWkk54lE
         bzdzaqC+sRHPMQZpc3RUDTxYtsHv/0NNw40ot7r9ZGBEtP8GjQXP5iv696cHhzyy80mN
         t5tcTsTYK43ml5vyR4h3GgNVWJp6qUm/Osfy0SuRSBZfaWOdej+51T7wzciR8IofR4RR
         XeujSl/A04wxcQy6BvF1jCSwqbOii3b66Cuu1ihMYGxc6iGfJwciUNC9L+22E6i5XjaX
         InTrUMZPt6x/LBXCeH6sxLhM4JBcM4DUyVLCO4XJdrsVPc20pGC18XwW5kj9u+3Guy5G
         nx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756963875; x=1757568675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUS5HOLhW/VpyZE9onIdkx0oHXwb/D4QXFFEiFH3pRQ=;
        b=qlgBFbplJIdRCjXpKG6nas5B4YyNuUVuNN2UIoYWDxb2sD9y1sg9bZrhR9V1+bH2Mq
         de52yVVfnHLKX3iWLEtaLfnK5L0b8/UMWOI+9QG6JauVIIrO2cwBhCZNhtYY3PPQREKY
         PxEPcIxyzbyAiidEYgWEMLwWYvNTAmEeFoTDlsaxo/nOgv/sFbajJCR0YcPsXVLU16on
         1fXpULZoXaNmYmcVKDNhPTMay4eCcaqT1TmSzvF9aItaS7gt+JmzhIF9irDVChct8alj
         nk7ae+LLdKP7QTu5kg/hGeIKB8F7veZ5mctliDbvkYE7vAwQ7a6ijckGHWGi+FC/a3oU
         rcZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7sCHG/0FZtHTK92cQEHxpxRhemStBHWvmsY94/0MfoGx5VKpu1rgh/5aKfZRlHDJbGnM3Yp0V0Dzpe8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZxDz6fxeHVjJJLYTbPd8uXjOvskvjgKfA+DDKr2U3+dzPTKUk
	mQ1o/9JfMZkVquN229ny0Wp7gcPGDR8vem3oeNZTyVuyky5HxuRqg59SAepHSW5Zl7vAu8SnpO1
	tWyL72mLL7Ue9d3/axVcxf0/DUlzJWPz3yEViyrkqhA==
X-Gm-Gg: ASbGncsPeigk/67iaE62hGnp7Q5P54WOFEmswXqm6bI94gnCOJ630qYGhaPvb1ZIsg1
	FrOz8CPIHZtqLiD8DY8ZrXrDtlHVsVON0Y9PblVtoUUHlFZ0x6eHzyzr2NcLGgT93mr6yNXtbKV
	X8nrgBNJJQa1LKP8LxcekxJ10MkufxW5S3boNSFFwOiy3rUdTgKnzRg5LeEcKH4qkf867F69A0O
	D9Et3YRKf1nFAX3cvY=
X-Google-Smtp-Source: AGHT+IHpG/4DLLscFeJxg9oiSMyrT9Ei4giIfqBu/oq/vW7+cyJh5b4Qc/vs+psL1BC6wQvPjI60Gtk/quL0fGjGJtU=
X-Received: by 2002:a05:6512:1594:b0:55f:6831:6ef4 with SMTP id
 2adb3069b0e04-55f7089c47amr5218029e87.12.1756963874604; Wed, 03 Sep 2025
 22:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822174715.1269138-1-jesse@rivosinc.com> <20250822174715.1269138-5-jesse@rivosinc.com>
In-Reply-To: <20250822174715.1269138-5-jesse@rivosinc.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 4 Sep 2025 11:01:02 +0530
X-Gm-Features: Ac12FXz_-ibvebvqMYm5-3Nr_6futqZOiLsqEgz-5uDfiWQDjH2HOgDMSF197Fg
Message-ID: <CAK9=C2X=SmJeYqZtUNHuDBZRrUpONCm6Z=qVPH8C1ckz=r6hCw@mail.gmail.com>
Subject: Re: [PATCH 4/8] riscv: Introduce support for hardware break/watchpoints
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Shuah Khan <shuah@kernel.org>, 
	Himanshu Chauhan <hchauhan@ventanamicro.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Deepak Gupta <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Atish Patra <atishp@rivosinc.com>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Evan Green <evan@rivosinc.com>, WangYuli <wangyuli@uniontech.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Nam Cao <namcao@linutronix.de>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Joel Granados <joel.granados@kernel.org>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Celeste Liu <coelacanthushex@gmail.com>, 
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Nylon Chen <nylon.chen@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 11:17=E2=80=AFPM Jesse Taube <jesse@rivosinc.com> w=
rote:
>
> From: Himanshu Chauhan <hchauhan@ventanamicro.com>
>
> RISC-V hardware breakpoint framework is built on top of perf subsystem an=
d uses
> SBI debug trigger extension to install/uninstall/update/enable/disable ha=
rdware
> triggers as specified in Sdtrig ISA extension.
>
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> RFC -> V1:
>  - Add dbtr_mode to rv_init_mcontrol(6)_trigger
>  - Add select HAVE_MIXED_BREAKPOINTS_REGS
>  - Add TDATA1_MCTRL_SZ and TDATA1_MCTRL6_SZ
>  - Capitalize F in Fallback comment
>  - Fix in_callback code to allow multiple breakpoints
>  - Move perf_bp_event above setup_singlestep to save the correct state
>  - Use sbi_err_map_linux_errno for arch_smp_teardown/setup_sbi_shmem
> V1 -> V2:
>  - No change
> ---
>  arch/riscv/Kconfig                     |   2 +
>  arch/riscv/include/asm/hw_breakpoint.h |  59 +++
>  arch/riscv/include/asm/kdebug.h        |   3 +-
>  arch/riscv/include/asm/sbi.h           |   4 +-
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/hw_breakpoint.c      | 614 +++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c              |   6 +
>  7 files changed, 687 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bbec87b79309..fd8b62cdc6f5 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,6 +163,7 @@ config RISCV
>         select HAVE_FUNCTION_ERROR_INJECTION
>         select HAVE_GCC_PLUGINS
>         select HAVE_GENERIC_VDSO if MMU && 64BIT
> +       select HAVE_HW_BREAKPOINT if PERF_EVENTS && RISCV_SBI
>         select HAVE_IRQ_TIME_ACCOUNTING
>         select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
>         select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
> @@ -176,6 +177,7 @@ config RISCV
>         select HAVE_KRETPROBES if !XIP_KERNEL
>         # https://github.com/ClangBuiltLinux/linux/issues/1881
>         select HAVE_LD_DEAD_CODE_DATA_ELIMINATION if !LD_IS_LLD
> +       select HAVE_MIXED_BREAKPOINTS_REGS
>         select HAVE_MOVE_PMD
>         select HAVE_MOVE_PUD
>         select HAVE_PAGE_SIZE_4KB
> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/=
asm/hw_breakpoint.h
> new file mode 100644
> index 000000000000..cde6688b91d2
> --- /dev/null
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2024 Ventana Micro Systems Inc.
> + */
> +
> +#ifndef __RISCV_HW_BREAKPOINT_H
> +#define __RISCV_HW_BREAKPOINT_H
> +
> +struct task_struct;
> +
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +
> +#include <uapi/linux/hw_breakpoint.h>
> +
> +#if __riscv_xlen =3D=3D 64
> +#define cpu_to_le cpu_to_le64
> +#define le_to_cpu le64_to_cpu
> +#elif __riscv_xlen =3D=3D 32
> +#define cpu_to_le cpu_to_le32
> +#define le_to_cpu le32_to_cpu
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif
> +
> +struct arch_hw_breakpoint {
> +       unsigned long address;
> +       unsigned long len;
> +
> +       /* Callback info */
> +       unsigned long next_addr;
> +       bool in_callback;
> +
> +       /* Trigger configuration data */
> +       unsigned long tdata1;
> +       unsigned long tdata2;
> +       unsigned long tdata3;
> +};
> +
> +/* Maximum number of hardware breakpoints supported */
> +#define RV_MAX_TRIGGERS 32
> +
> +struct perf_event_attr;
> +struct notifier_block;
> +struct perf_event;
> +struct pt_regs;
> +
> +int hw_breakpoint_slots(int type);
> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_arch_parse(struct perf_event *bp,
> +                            const struct perf_event_attr *attr,
> +                            struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +                                   unsigned long val, void *data);
> +int arch_install_hw_breakpoint(struct perf_event *bp);
> +void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> +void hw_breakpoint_pmu_read(struct perf_event *bp);
> +
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> +#endif /* __RISCV_HW_BREAKPOINT_H */
> diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kde=
bug.h
> index 85ac00411f6e..53e989781aa1 100644
> --- a/arch/riscv/include/asm/kdebug.h
> +++ b/arch/riscv/include/asm/kdebug.h
> @@ -6,7 +6,8 @@
>  enum die_val {
>         DIE_UNUSED,
>         DIE_TRAP,
> -       DIE_OOPS
> +       DIE_OOPS,
> +       DIE_DEBUG
>  };
>
>  #endif
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index be2ca8e8a49e..64fa7a82aa45 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -282,7 +282,9 @@ struct sbi_sta_struct {
>         u8 pad[47];
>  } __packed;
>
> -#define SBI_SHMEM_DISABLE              -1
> +#define SBI_SHMEM_DISABLE      (-1UL)
> +#define SBI_SHMEM_LO(pa)       ((unsigned long)lower_32_bits(pa))
> +#define SBI_SHMEM_HI(pa)       ((unsigned long)upper_32_bits(pa))

These definitions of SBI_SHMEM_LO() and SBI_SHMEM_HI() are
broken for RV64 platforms where a good amount of RAM is beyond
first 4GB.

This should be:

#ifdef CONFIG_32BIT
#define SBI_SHMEM_LO(pa)       ((unsigned long)lower_32_bits(pa))
#define SBI_SHMEM_HI(pa)       ((unsigned long)upper_32_bits(pa))
#else
#define SBI_SHMEM_LO(pa)       ((unsigned long)pa)
#define SBI_SHMEM_HI(pa)       0UL
#endif

Regards,
Anup

