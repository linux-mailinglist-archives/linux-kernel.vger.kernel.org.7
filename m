Return-Path: <linux-kernel+bounces-754823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156F2B19D36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825D93A4DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9F5237A3B;
	Mon,  4 Aug 2025 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="YfUunz6C"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5760E1DE3A4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294493; cv=none; b=lUoXCfOCe2b32LXsQvjHg2gkSBxpMwQKgwfCBMVuoJgQ3yU8OZI4Llirirr19NzxiptDkz520n1sc/qC+gvPc+gM/+/ziaaihnGOu0GHYWEbi36AOhTQDTvYVsprA4bwkncEYCvVhdnxVHo5obkgFmA1+wgD/1YsizMcDTKrD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294493; c=relaxed/simple;
	bh=xDhLppw2L3vRH2h1TFd8U1F141s5ahWW28lk0dC9TdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WkzmSpsyxcGNR3GfeOFGoPOS6en3QM0RVrUpDAJROb/ONlZmRV8gLansu2J1F3Pr2sbkEP5EThB673y0n6poLnBCCBBP/BEyOFQy4AXZKukNhaWc3M0P89ff/hGvfzwRwBHVlG2UPeAGsy06NRySwW0XLsqi85U2jzRKuMLdJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=YfUunz6C; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-455b00339c8so25256485e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754294488; x=1754899288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8G6SdAq33xZMMM/rI205allMoBUdvN/RkDayt2kSpHg=;
        b=YfUunz6CafkL5PwvwaYm0oYJhOu7OB7AC7VJ9CzHwDLChnBugaSaUUiEqY1KbV/XVa
         xNX3x/L3+/1hWw+CfRhznwDh5LJDWJtA+Ii0bRL9/qeLmDSlNmkPI8KqrQrGVb6penCn
         bvcwsW+eCCLUPMM9wcgAnh7i0vH7VvAjXsQEI7K7+2qE/9BgDbBDNPOhRwKyukOYb1PX
         dQDJnfH2o4wX5xBmxIc+ptpAgm7sU+fZQL9fcFJmuEKh7Ev4A/WOTuOxee/rr8zUG+OI
         WgV5fL3A0Gio6gJez13Bfjyfv/MiKbTGcgN1jYjswJNaTmCb9aFqcEsDlEOAId88DRQ8
         j3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754294488; x=1754899288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8G6SdAq33xZMMM/rI205allMoBUdvN/RkDayt2kSpHg=;
        b=Ybo1x6/VHvBLpYgaZujDKqs5WX4Lr7X4jOOeodSnPND+Ppdmw+PwsAJezFwqAY8VWu
         x4sLEv1FcusBfsBwKY0gAttleaIUBTKWghhF55nGO/hnJ9gExcmGjAdz52f7BC4F4eco
         JQ6DTT2+vwmsQrd4a9gv34GK9wlEUT6i4AZ7yrMAY44lqYxtqQxSNESoM4SwEL9UFuRu
         f/Xh5TBPt4+C/JQWmuIan0YirlFmLOQBLG8Rg3HtFbQPYKpbNwJvhRLsZXgUwaK80/oN
         hrjPOyA4vIURJqYHBzSSKNJll1DqGvE7MwU8JvGvj0vMwlnIKY/fzDob0f31iBCGPdeB
         ckfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlSKUGdFPx9M42kWrXjiVcvEn2xsgs40uM/TtYcFP5WOXmVu+vt54CRbjiVn1kAMBg54WU9JP06x6wv0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqMeV+NqHiQBRx6qmid76adSWQ4hOYmaiVCZbdZ1yiYo/ww6sJ
	ZdwTbUXZQbB+pHWjnZGCe/zfP/LWfXzV2y3gCwODNUehs7DAqfFrzF4WbxlgPdEpU1w=
X-Gm-Gg: ASbGncuSyBUAZqNHxh+5vAN/Wjow9phcviOSL60xa1esl5zT3dqNuPhAkgFZ2k+85Zx
	EgQYu+CGEfksRqkF7sFOTaG7hiGSFv9SFVKnWCnp7n5xRZG2OzL2yfgH6psIO8zuka3yMvQhW8q
	LAYQ7Fqcjwk+47e30+nUQ5tcSW3FMyEy0+PJq8LMT5zZDiCRHZL+BkDqjRxv8NpyT3QCeEyx3kH
	muQ66Hw76HUo2oHwnL8ECcgkWgNFyfdUI0m76n8Y5pRPkraipmrc1keZTPozWSYEFwUiIKaI/R3
	RvEzUb0wrQwck6DS7OrNDZIA21r8k4bukiKrW9QWHzrPxUhezQToz2L+1iXMa2T+52TXeTFyirM
	Kt4G77msrWZDbNBomiEStylKxVaux7sgM1gKl44A/VFIZe+2T8PHUV4xm7S3c194j4LchKC4rdp
	tkXA==
X-Google-Smtp-Source: AGHT+IHGTL2p73OZAkR6Zhl82VsFts4qTEomO3hhVxV4oe1lEGQWPlGnVyYDEipdtaPueV9FcCrmNA==
X-Received: by 2002:a05:600c:a43:b0:456:173c:8a53 with SMTP id 5b1f17b1804b1-458b69c8300mr69087015e9.2.1754294488307;
        Mon, 04 Aug 2025 01:01:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a6f62sm14381510f8f.73.2025.08.04.01.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:01:27 -0700 (PDT)
Message-ID: <6bbecd00-8c47-44fc-aaa0-eb5607d4ca53@rivosinc.com>
Date: Mon, 4 Aug 2025 10:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] riscv: Introduce support for hardware
 break/watchpoints
To: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Oleg Nesterov <oleg@redhat.com>,
 Himanshu Chauhan <hchauhan@ventanamicro.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Samuel Holland <samuel.holland@sifive.com>, Deepak Gupta
 <debug@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>,
 Atish Patra <atishp@rivosinc.com>, Anup Patel <apatel@ventanamicro.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>, WangYuli
 <wangyuli@uniontech.com>, Huacai Chen <chenhuacai@kernel.org>,
 Nam Cao <namcao@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Joel Granados <joel.granados@kernel.org>,
 Celeste Liu <coelacanthushex@gmail.com>, Evan Green <evan@rivosinc.com>,
 Nylon Chen <nylon.chen@sifive.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
 <20250722173829.984082-5-jesse@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250722173829.984082-5-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/07/2025 19:38, Jesse Taube wrote:
> From: Himanshu Chauhan <hchauhan@ventanamicro.com>
> 
> RISC-V hardware breakpoint framework is built on top of perf subsystem and uses
> SBI debug trigger extension to install/uninstall/update/enable/disable hardware
> triggers as specified in Sdtrig ISA extension.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/Kconfig                     |   1 +
>  arch/riscv/include/asm/hw_breakpoint.h |  60 +++
>  arch/riscv/include/asm/kdebug.h        |   3 +-
>  arch/riscv/include/asm/sbi.h           |   4 +-
>  arch/riscv/kernel/Makefile             |   1 +
>  arch/riscv/kernel/hw_breakpoint.c      | 620 +++++++++++++++++++++++++
>  arch/riscv/kernel/traps.c              |   6 +
>  7 files changed, 693 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
>  create mode 100644 arch/riscv/kernel/hw_breakpoint.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index bbec87b79309..95d3047cab10 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -163,6 +163,7 @@ config RISCV
>  	select HAVE_FUNCTION_ERROR_INJECTION
>  	select HAVE_GCC_PLUGINS
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
> +	select HAVE_HW_BREAKPOINT if PERF_EVENTS && RISCV_SBI
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
>  	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/asm/hw_breakpoint.h
> new file mode 100644
> index 000000000000..8efa3921c535
> --- /dev/null
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
> @@ -0,0 +1,60 @@
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
> +#if __riscv_xlen == 64
> +#define cpu_to_le cpu_to_le64
> +#define le_to_cpu le64_to_cpu
> +#elif __riscv_xlen == 32
> +#define cpu_to_le cpu_to_le32
> +#define le_to_cpu le32_to_cpu
> +#else
> +#error "Unexpected __riscv_xlen"
> +#endif
> +
> +struct arch_hw_breakpoint {
> +	unsigned long address;
> +	unsigned long len;
> +
> +	/* Callback info */
> +	unsigned long next_addr;
> +	bool in_callback;
> +
> +
> +	/* Trigger configuration data */
> +	unsigned long tdata1;
> +	unsigned long tdata2;
> +	unsigned long tdata3;
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
> +			     const struct perf_event_attr *attr,
> +			     struct arch_hw_breakpoint *hw);
> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +				    unsigned long val, void *data);
> +int arch_install_hw_breakpoint(struct perf_event *bp);
> +void arch_uninstall_hw_breakpoint(struct perf_event *bp);
> +void hw_breakpoint_pmu_read(struct perf_event *bp);
> +
> +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> +#endif /* __RISCV_HW_BREAKPOINT_H */
> diff --git a/arch/riscv/include/asm/kdebug.h b/arch/riscv/include/asm/kdebug.h
> index 85ac00411f6e..53e989781aa1 100644
> --- a/arch/riscv/include/asm/kdebug.h
> +++ b/arch/riscv/include/asm/kdebug.h
> @@ -6,7 +6,8 @@
>  enum die_val {
>  	DIE_UNUSED,
>  	DIE_TRAP,
> -	DIE_OOPS
> +	DIE_OOPS,
> +	DIE_DEBUG
>  };
>  
>  #endif
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index be2ca8e8a49e..64fa7a82aa45 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -282,7 +282,9 @@ struct sbi_sta_struct {
>  	u8 pad[47];
>  } __packed;
>  
> -#define SBI_SHMEM_DISABLE		-1
> +#define SBI_SHMEM_DISABLE	(-1UL)
> +#define SBI_SHMEM_LO(pa)	((unsigned long)lower_32_bits(pa))
> +#define SBI_SHMEM_HI(pa)	((unsigned long)upper_32_bits(pa))
>  
>  enum sbi_ext_nacl_fid {
>  	SBI_EXT_NACL_PROBE_FEATURE = 0x0,
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 4f719b09e5ad..3e72505734bd 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>  
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
> +obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>  obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
>  ifeq ($(CONFIG_RISCV_SBI), y)
>  obj-$(CONFIG_SMP)		+= sbi-ipi.o
> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> new file mode 100644
> index 000000000000..9e3a3b82d300
> --- /dev/null
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -0,0 +1,620 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/hw_breakpoint.h>
> +#include <linux/perf_event.h>
> +#include <linux/spinlock.h>
> +#include <linux/percpu.h>
> +#include <linux/kdebug.h>
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>
> +
> +#include <asm/insn.h>
> +#include <asm/sbi.h>
> +
> +#define DBTR_TDATA1_TYPE_SHIFT		(__riscv_xlen - 4)
> +#define DBTR_TDATA1_DMODE		BIT_UL(__riscv_xlen - 5)
> +
> +#define DBTR_TDATA1_TYPE_MCONTROL	(2UL << DBTR_TDATA1_TYPE_SHIFT)
> +#define DBTR_TDATA1_TYPE_MCONTROL6	(6UL << DBTR_TDATA1_TYPE_SHIFT)
> +
> +#define DBTR_TDATA1_MCONTROL6_LOAD		BIT(0)
> +#define DBTR_TDATA1_MCONTROL6_STORE		BIT(1)
> +#define DBTR_TDATA1_MCONTROL6_EXECUTE		BIT(2)
> +#define DBTR_TDATA1_MCONTROL6_U			BIT(3)
> +#define DBTR_TDATA1_MCONTROL6_S			BIT(4)
> +#define DBTR_TDATA1_MCONTROL6_M			BIT(6)
> +#define DBTR_TDATA1_MCONTROL6_SIZE_FIELD	GENMASK(18, 16)
> +#define DBTR_TDATA1_MCONTROL6_SELECT		BIT(21)
> +#define DBTR_TDATA1_MCONTROL6_VU		BIT(23)
> +#define DBTR_TDATA1_MCONTROL6_VS		BIT(24)
> +
> +#define DBTR_TDATA1_MCONTROL6_SIZE_8BIT		1
> +#define DBTR_TDATA1_MCONTROL6_SIZE_16BIT	2
> +#define DBTR_TDATA1_MCONTROL6_SIZE_32BIT	3
> +#define DBTR_TDATA1_MCONTROL6_SIZE_64BIT	5
> +
> +#define DBTR_TDATA1_MCONTROL_LOAD		BIT(0)
> +#define DBTR_TDATA1_MCONTROL_STORE		BIT(1)
> +#define DBTR_TDATA1_MCONTROL_EXECUTE		BIT(2)
> +#define DBTR_TDATA1_MCONTROL_U			BIT(3)
> +#define DBTR_TDATA1_MCONTROL_S			BIT(4)
> +#define DBTR_TDATA1_MCONTROL_M			BIT(6)
> +#define DBTR_TDATA1_MCONTROL_SIZELO_FIELD	GENMASK(17, 16)
> +#define DBTR_TDATA1_MCONTROL_SELECT		BIT(19)
> +#define DBTR_TDATA1_MCONTROL_SIZEHI_FIELD	GENMASK(22, 21)
> +
> +#define DBTR_TDATA1_MCONTROL_SIZELO_8BIT	1
> +#define DBTR_TDATA1_MCONTROL_SIZELO_16BIT	2
> +#define DBTR_TDATA1_MCONTROL_SIZELO_32BIT	3
> +/* value of 5 split across HI and LO */
> +#define DBTR_TDATA1_MCONTROL_SIZELO_64BIT	1
> +#define DBTR_TDATA1_MCONTROL_SIZEHI_64BIT	1
> +
> +/* Registered per-cpu bp/wp */
> +static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RV_MAX_TRIGGERS]);
> +static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
> +static DEFINE_PER_CPU(raw_spinlock_t, ecall_lock);
> +
> +/* Per-cpu shared memory between S and M mode */
> +static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_dbtr_shmem);
> +
> +/* number of debug triggers on this cpu . */
> +static int dbtr_total_num __ro_after_init;
> +static unsigned long dbtr_type __ro_after_init;
> +static unsigned long dbtr_init __ro_after_init;
> +
> +static int arch_smp_setup_sbi_shmem(unsigned int cpu)
> +{
> +	union sbi_dbtr_shmem_entry *dbtr_shmem;
> +	unsigned long shmem_pa;
> +	struct sbiret ret;
> +	int rc;
> +
> +	dbtr_shmem = per_cpu_ptr(&sbi_dbtr_shmem, cpu);
> +	if (!dbtr_shmem) {
> +		pr_err("Invalid per-cpu shared memory for debug triggers\n");
> +		return -ENODEV;
> +	}
> +
> +	shmem_pa = virt_to_phys(dbtr_shmem);
> +
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> +			SBI_SHMEM_LO(shmem_pa), SBI_SHMEM_HI(shmem_pa), 0, 0, 0, 0);
> +
> +	if (ret.error) {
> +		switch (ret.error) {
> +		case SBI_ERR_DENIED:
> +			pr_warn("%s: Access denied for shared memory at %lx\n",
> +				__func__, shmem_pa);
> +			rc = -EPERM;
> +			break;
> +
> +		case SBI_ERR_INVALID_PARAM:
> +		case SBI_ERR_INVALID_ADDRESS:
> +			pr_warn("%s: Invalid address parameter (%ld)\n",
> +				__func__, ret.error);
> +			rc = -EINVAL;
> +			break;
> +
> +		case SBI_ERR_ALREADY_AVAILABLE:
> +			pr_warn("%s: Shared memory is already set\n",
> +				__func__);
> +			rc = -EADDRINUSE;
> +			break;
> +
> +		case SBI_ERR_FAILURE:
> +			pr_err("%s: Internal sdtrig state error\n",
> +			       __func__);
> +			rc = -ENXIO;
> +			break;
> +
> +		default:
> +			pr_warn("%s: Unknown error %lu\n", __func__, ret.error);
> +			rc = -ENXIO;
> +			break;
> +		}
> +	}

Hi Jesse,

Is there a reason not to use sbi_err_map_linux_errno() ?

> +
> +	pr_debug("CPU %d: HW Breakpoint shared memory registered.\n", cpu);
> +
> +	return rc;
> +}
> +
> +static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
> +{
> +	struct sbiret ret;
> +
> +	/* Disable shared memory */
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_SETUP_SHMEM,
> +			SBI_SHMEM_DISABLE, SBI_SHMEM_DISABLE, 0, 0, 0, 0);
> +
> +	if (ret.error) {
> +		switch (ret.error) {
> +		case SBI_ERR_DENIED:
> +			pr_err("%s: Access denied for shared memory.\n",
> +			       __func__);
> +			break;
> +
> +		case SBI_ERR_INVALID_PARAM:
> +		case SBI_ERR_INVALID_ADDRESS:
> +			pr_err("%s: Invalid address parameter (%lu)\n",
> +			       __func__, ret.error);
> +			break;
> +
> +		case SBI_ERR_ALREADY_AVAILABLE:
> +			pr_err("%s: Shared memory is already set\n",
> +			       __func__);
> +			break;
> +		case SBI_ERR_FAILURE:
> +			pr_err("%s: Internal sdtrig state error\n",
> +			       __func__);
> +			break;
> +		default:
> +			pr_err("%s: Unknown error %lu\n", __func__, ret.error);
> +			break;
> +		}
> +	}

Ditto

> +
> +	pr_debug("CPU %d: HW Breakpoint shared memory disabled.\n", cpu);
> +
> +	return 0;
> +}
> +
> +static void init_sbi_dbtr(void)
> +{
> +	struct sbiret ret;
> +
> +	/*
> +	 * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
> +	 * Only proceed if this is the first CPU to reach this code.
> +	 */
> +	if (test_and_set_bit(0, &dbtr_init))
> +		return;
> +
> +	if (sbi_probe_extension(SBI_EXT_DBTR) <= 0) {
> +		pr_debug("%s: SBI_EXT_DBTR is not supported\n", __func__);
> +		dbtr_total_num = 0;
> +		return;
> +	}
> +
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +			DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("%s: failed to detect mcontrol6 triggers. error: %ld.\n",
> +			__func__, ret.error);
> +	} else if (!ret.value) {
> +		pr_warn("%s: No mcontrol6 triggers available.\n", __func__);
> +	} else {
> +		dbtr_total_num = ret.value;
> +		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL6;
> +		return;
> +	}
> +
> +	/* fallback to legacy mcontrol triggers if mcontrol6 is not available */

Nit: Since all other comments starts with a capital letter, I'd suggest
using a capital F (Fallback).

> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +			DBTR_TDATA1_TYPE_MCONTROL, 0, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("%s: failed to detect mcontrol triggers. error: %ld.\n",
> +			__func__, ret.error);
> +	} else if (!ret.value) {
> +		pr_err("%s: No mcontrol triggers available.\n", __func__);
> +		dbtr_total_num = 0;
> +	} else {
> +		dbtr_total_num = ret.value;
> +		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL;
> +	}
> +}
> +
> +int hw_breakpoint_slots(int type)
> +{
> +	/*
> +	 * We can be called early, so don't rely on
> +	 * static variables being initialised.
> +	 */
> +	init_sbi_dbtr();
> +
> +	return dbtr_total_num;
> +}
> +
> +int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
> +{
> +	unsigned int len;
> +	unsigned long va;
> +
> +	va = hw->address;
> +	len = hw->len;
> +
> +	return (va >= TASK_SIZE) && ((va + len - 1) >= TASK_SIZE);
> +}
> +
> +static int rv_init_mcontrol_trigger(const struct perf_event_attr *attr,
> +				    struct arch_hw_breakpoint *hw)
> +{
> +	unsigned long tdata1 = DBTR_TDATA1_TYPE_MCONTROL;
> +
> +	switch (attr->bp_type) {
> +	case HW_BREAKPOINT_X:
> +		tdata1 |= DBTR_TDATA1_MCONTROL_EXECUTE;
> +		break;
> +	case HW_BREAKPOINT_R:
> +		tdata1 |= DBTR_TDATA1_MCONTROL_LOAD;
> +		break;
> +	case HW_BREAKPOINT_W:
> +		tdata1 |= DBTR_TDATA1_MCONTROL_STORE;
> +		break;
> +	case HW_BREAKPOINT_RW:
> +		tdata1 |= DBTR_TDATA1_MCONTROL_STORE | DBTR_TDATA1_MCONTROL_LOAD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (attr->bp_len) {
> +	case HW_BREAKPOINT_LEN_1:
> +		hw->len = 1;
You can probably add a define for that to avoid

#define TDATA1(lo, hi) \
	FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD, \
		   DBTR_TDATA1_MCONTROL_SIZELO_64BIT) | \
	FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD, \
		   DBTR_TDATA1_MCONTROL_SIZEHI_64BIT);

> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
> +				     DBTR_TDATA1_MCONTROL_SIZELO_8BIT);

		tdata1 |= TDATA1(DBTR_TDATA1_MCONTROL_SIZELO_8BIT, 0);

> +		break;
> +	case HW_BREAKPOINT_LEN_2:
> +		hw->len = 2;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
> +				     DBTR_TDATA1_MCONTROL_SIZELO_16BIT);

		tdata1 |= TDATA1(DBTR_TDATA1_MCONTROL_SIZELO_16BIT, 0);

> +		break;
> +	case HW_BREAKPOINT_LEN_4:
> +		hw->len = 4;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
> +				     DBTR_TDATA1_MCONTROL_SIZELO_32BIT);

		tdata1 |= TDATA1(DBTR_TDATA1_MCONTROL_SIZELO_32BIT, 0);

> +		break;
> +#if __riscv_xlen >= 64
> +	case HW_BREAKPOINT_LEN_8:
> +		hw->len = 8;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZELO_FIELD,
> +				     DBTR_TDATA1_MCONTROL_SIZELO_64BIT) |
> +			  FIELD_PREP(DBTR_TDATA1_MCONTROL_SIZEHI_FIELD,
> +				     DBTR_TDATA1_MCONTROL_SIZEHI_64BIT);


		tdata1 |= TDATA1(DBTR_TDATA1_MCONTROL_SIZELO_64BIT,
DBTR_TDATA1_MCONTROL_SIZEHI_64BIT);

> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tdata1 |= DBTR_TDATA1_MCONTROL_U;
> +
> +	hw->tdata1 = tdata1;
> +
> +	return 0;
> +}
> +
> +static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
> +				     struct arch_hw_breakpoint *hw)
> +{
> +	unsigned long tdata1 = DBTR_TDATA1_TYPE_MCONTROL;
> +
> +	switch (attr->bp_type) {
> +	case HW_BREAKPOINT_X:
> +		tdata1 |= DBTR_TDATA1_MCONTROL6_EXECUTE;
> +		break;
> +	case HW_BREAKPOINT_R:
> +		tdata1 |= DBTR_TDATA1_MCONTROL6_LOAD;
> +		break;
> +	case HW_BREAKPOINT_W:
> +		tdata1 |= DBTR_TDATA1_MCONTROL6_STORE;
> +		break;
> +	case HW_BREAKPOINT_RW:
> +		tdata1 |= DBTR_TDATA1_MCONTROL6_STORE | DBTR_TDATA1_MCONTROL6_LOAD;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (attr->bp_len) {
> +	case HW_BREAKPOINT_LEN_1:
> +		hw->len = 1;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
> +				     DBTR_TDATA1_MCONTROL6_SIZE_8BIT);
> +		break;
> +	case HW_BREAKPOINT_LEN_2:
> +		hw->len = 2;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
> +				     DBTR_TDATA1_MCONTROL6_SIZE_16BIT);
> +		break;
> +	case HW_BREAKPOINT_LEN_4:
> +		hw->len = 4;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
> +				     DBTR_TDATA1_MCONTROL6_SIZE_32BIT);
> +		break;
> +	case HW_BREAKPOINT_LEN_8:
> +		hw->len = 8;
> +		tdata1 |= FIELD_PREP(DBTR_TDATA1_MCONTROL6_SIZE_FIELD,
> +				     DBTR_TDATA1_MCONTROL6_SIZE_64BIT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	tdata1 |= DBTR_TDATA1_MCONTROL6_U;
> +
> +	hw->tdata1 = tdata1;
> +
> +	return 0;
> +}
> +
> +int hw_breakpoint_arch_parse(struct perf_event *bp,
> +			     const struct perf_event_attr *attr,
> +			     struct arch_hw_breakpoint *hw)
> +{
> +	int ret;
> +
> +	/* Breakpoint address */
> +	hw->address = attr->bp_addr;
> +	hw->tdata2 = attr->bp_addr;
> +	hw->tdata3 = 0x0;
> +	hw->next_addr = 0x0;
> +	hw->in_callback = false;
> +
> +	switch (dbtr_type) {
> +	case DBTR_TDATA1_TYPE_MCONTROL:
> +		ret = rv_init_mcontrol_trigger(attr, hw);
> +		break;
> +	case DBTR_TDATA1_TYPE_MCONTROL6:
> +		ret = rv_init_mcontrol6_trigger(attr, hw);
> +		break;
> +	default:
> +		pr_warn("Unsupported trigger type %lu.\n", dbtr_type >> DBTR_TDATA1_TYPE_SHIFT);
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Set breakpoint to next insruction after breakpoint.

Typo: instruction

> + * Returns 0 if success
> + * Returns < 0 on error
> + */
> +static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
> +{
> +	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
> +	struct arch_hw_breakpoint old_hw_bp;
> +	struct perf_event_attr bp_insn;
> +	unsigned long next_addr, insn;
> +	int ret;
> +
> +	/* Remove breakpoint even if return error as not to loop */
> +	arch_uninstall_hw_breakpoint(event);
> +
> +	ret = get_insn(regs, regs->epc, &insn);
> +	if (ret < 0)
> +		return ret;
> +
> +	next_addr = get_step_address(regs, insn);
> +
> +	ret = get_insn(regs, next_addr, &insn);
> +	if (ret < 0)
> +		return ret;
> +
> +	bp_insn.bp_type = HW_BREAKPOINT_X;
> +	bp_insn.bp_addr = next_addr;
> +	/* Get the size of the intruction */
> +	bp_insn.bp_len = GET_INSN_LENGTH(insn);
> +
> +	ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> +	if (ret)
> +		return ret;
> +
> +	ret = arch_install_hw_breakpoint(event);
> +	if (ret)
> +		return ret;
> +
> +	bp->in_callback = true;
> +	bp->next_addr = next_addr;
> +	return 0;
> +}
> +
> +/*
> + * HW Breakpoint/watchpoint handler
> + */
> +static int hw_breakpoint_handler(struct pt_regs *regs)
> +{
> +	struct perf_event *event;
> +	struct arch_hw_breakpoint *bp;
> +	int ret, i;
> +
> +	for (i = 0; i < dbtr_total_num; i++) {
> +		event = this_cpu_read(pcpu_hw_bp_events[i]);
> +		if (!event)
> +			continue;
> +
> +		bp = counter_arch_bp(event);
> +		if (bp->in_callback) {
> +			/* Reset changed breakpoint data */
> +			bp->in_callback = false;
> +			if (regs->epc == bp->next_addr) {
> +				arch_uninstall_hw_breakpoint(event);
> +				/* Restore original breakpoint */
> +				if (hw_breakpoint_arch_parse(NULL, &event->attr, bp))
> +					return NOTIFY_DONE;
> +				if (arch_install_hw_breakpoint(event))
> +					return NOTIFY_DONE;
> +				return NOTIFY_STOP;
> +			}
> +
> +			pr_err("%s: in_callback was set, but epc(%lx) was not next "
> +				 "address(%lx).\n", __func__, regs->epc, bp->next_addr);
> +			bp->next_addr = 0x0;
> +			return NOTIFY_DONE;
> +		}
> +
> +		switch (event->attr.bp_type) {
> +		/* Breakpoint */
> +		case HW_BREAKPOINT_X:
> +			if (event->attr.bp_addr == regs->epc) {
> +				ret = setup_singlestep(event, regs);
> +				if (ret < 0) {
> +					pr_err("%s: setup_singlestep failed %d.\n", __func__, ret);
> +					return NOTIFY_DONE;
> +				}
> +
> +				perf_bp_event(event, regs);
> +				return NOTIFY_STOP;
> +			}
> +			break;
> +
> +		/* Watchpoint */
> +		case HW_BREAKPOINT_W:
> +		case HW_BREAKPOINT_R:
> +		case HW_BREAKPOINT_RW:
> +			if (event->attr.bp_addr == regs->badaddr) {
> +				ret = setup_singlestep(event, regs);
> +				if (ret < 0) {
> +					pr_err("%s: setup_singlestep failed %d.\n", __func__, ret);
> +					return NOTIFY_DONE;
> +				}
> +
> +				perf_bp_event(event, regs);
> +				return NOTIFY_STOP;
> +			}
> +			break;
> +
> +		default:
> +			pr_warn("%s: Unknown type: %u\n", __func__, event->attr.bp_type);
> +			break;
> +		}
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
> +				    unsigned long val, void *data)
> +{
> +	struct die_args *args = data;
> +
> +	if (val != DIE_DEBUG)
> +		return NOTIFY_DONE;
> +
> +	return hw_breakpoint_handler(args->regs);
> +}
> +
> +/* atomic: counter->ctx->lock is held */
> +int arch_install_hw_breakpoint(struct perf_event *event)
> +{
> +	struct arch_hw_breakpoint *bp = counter_arch_bp(event);
> +	union sbi_dbtr_shmem_entry *shmem = this_cpu_ptr(&sbi_dbtr_shmem);
> +	struct sbi_dbtr_data_msg *xmit;
> +	struct sbi_dbtr_id_msg *recv;
> +	struct perf_event **slot;
> +	unsigned long idx;
> +	struct sbiret ret;
> +	int err = 0;
> +
> +	raw_spin_lock_irqsave(this_cpu_ptr(&ecall_lock),
> +			      *this_cpu_ptr(&ecall_lock_flags));
> +
> +	xmit = &shmem->data;
> +	recv = &shmem->id;
> +	xmit->tdata1 = cpu_to_le(bp->tdata1);
> +	xmit->tdata2 = cpu_to_le(bp->tdata2);
> +	xmit->tdata3 = cpu_to_le(bp->tdata3);
> +
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_INSTALL,
> +			1, 0, 0, 0, 0, 0);
> +
> +	if (ret.error) {
> +		pr_warn("%s: failed to install trigger. error: %ld\n", __func__, ret.error);
> +		err = sbi_err_map_linux_errno(ret.error);
> +		goto done;
> +	}
> +
> +	idx = le_to_cpu(recv->idx);
> +	if (idx >= dbtr_total_num) {
> +		pr_warn("%s: invalid trigger index %lu\n", __func__, idx);
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
> +	slot = this_cpu_ptr(&pcpu_hw_bp_events[idx]);
> +	if (*slot) {
> +		pr_warn("%s: slot %lu is in use\n", __func__, idx);
> +		err = -EBUSY;
> +		goto done;
> +	}
> +
> +	pr_debug("Trigger 0x%lx installed at index 0x%lx\n", bp->tdata2, idx);
> +
> +	/* Save the event - to be looked up in handler */
> +	*slot = event;
> +
> +done:
> +	raw_spin_unlock_irqrestore(this_cpu_ptr(&ecall_lock),
> +				   *this_cpu_ptr(&ecall_lock_flags));
> +	return err;
> +}
> +
> +/* atomic: counter->ctx->lock is held */
> +void arch_uninstall_hw_breakpoint(struct perf_event *event)
> +{
> +	struct sbiret ret;
> +	int i;
> +
> +	for (i = 0; i < dbtr_total_num; i++) {
> +		struct perf_event **slot = this_cpu_ptr(&pcpu_hw_bp_events[i]);
> +
> +		if (*slot == event) {
> +			*slot = NULL;
> +			break;
> +		}
> +	}
> +
> +
> +	if (i == dbtr_total_num) {
> +		pr_warn("%s: Breakpoint not installed.\n", __func__);
> +		return;
> +	}
> +
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_TRIG_UNINSTALL,
> +			i, 1, 0, 0, 0, 0);
> +	if (ret.error)
> +		pr_warn("%s: Failed to uninstall trigger %d. error: %ld\n", __func__, i, ret.error);
> +}
> +
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk) { }

Is there nothing to do to remove the registered breakpoints ? All other
architecture seems to implement it.

> +
> +void hw_breakpoint_pmu_read(struct perf_event *bp) { }
> +
> +static int __init arch_hw_breakpoint_init(void)
> +{
> +	unsigned int cpu;
> +	int rc = 0;
> +
> +	for_each_possible_cpu(cpu)
> +		raw_spin_lock_init(&per_cpu(ecall_lock, cpu));
> +
> +	init_sbi_dbtr();
> +
> +	if (dbtr_total_num) {
> +		pr_debug("%s: total number of type %lu triggers: %u\n",
> +			__func__, dbtr_type >> DBTR_TDATA1_TYPE_SHIFT, dbtr_total_num);
> +	} else {
> +		pr_debug("%s: No hardware triggers available\n", __func__);
> +		return rc;
> +	}
> +
> +	/* Hotplug handler to register/unregister shared memory with SBI */
> +	rc = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
> +			       "riscv/hw_breakpoint:prepare",
> +			       arch_smp_setup_sbi_shmem,
> +			       arch_smp_teardown_sbi_shmem);
> +
> +	if (rc < 0)
> +		pr_warn("%s: Failed to setup CPU hotplug state\n", __func__);
> +
> +	return rc;
> +}
> +arch_initcall(arch_hw_breakpoint_init);
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 938a8b841f94..2ac471ec79a8 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -289,6 +289,12 @@ void handle_break(struct pt_regs *regs)
>  	if (probe_breakpoint_handler(regs))
>  		return;
>  
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	if (notify_die(DIE_DEBUG, "EBREAK", regs, 0, regs->cause, SIGTRAP)
> +	    == NOTIFY_STOP)
> +		return;
> +#endif
> +
>  	current->thread.bad_cause = regs->cause;
>  
>  	if (user_mode(regs))


