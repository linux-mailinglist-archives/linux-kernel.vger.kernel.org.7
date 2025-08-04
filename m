Return-Path: <linux-kernel+bounces-754843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1D3B19D6E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8518D18968B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826E82367D3;
	Mon,  4 Aug 2025 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="brm4Jvel"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3F2C1A2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295327; cv=none; b=BvIzSuqRAZ3Y4GLCVrS17pn/Y86y42dIS2qM/RNapqrN0BgQiJNcM3Nc7XcljSq1bCvHh5hoyDFeNyBauK0PEZ3pYCOmjexa7k1gOiNeArz1bqnR+VG0q3XVm6F9o3ZP8K5PKE8yLxCxPK2ihNcOjRE4SwmhBnj3g1yDDdZw0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295327; c=relaxed/simple;
	bh=MAr9RuQstdhH521q/RfL2aCdxAKm730NW43QEwbVVRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8VhnFKKWxfbhtpGC0rt6GMheUa7y7gGS0KXJZDFJ3lftbuOAXMa4hIaRFlBxAtEYGHUwyZKaRdBERbAMvtwI6zPnjS+vtjM2ymqUR/8w2/CkMKtxwmzk5OXEvQx5gqAKk4rcY88dkCTcJaqyyJRrCYTT3N/Xav2BIw6UtsjIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=brm4Jvel; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459ddb41539so1314155e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754295324; x=1754900124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0/hn9Eliq7ebIUdeCMqZrdU4Llw8i8H1X4gsxBpU9U=;
        b=brm4JvelnpafV7ZAm0NfG/utcEeNM9+Tc3krIfwDwYfupaBqk/S6UH35Bchu7JJ9IJ
         qJ/KS1JHC2DVyCqwLm8zGshPtgG2DLy4zALiZC8fzapIR+nHJO6eax+5kOmhIq1xQnzb
         LyY8qbW3cN34oeaC0MvJe3KbL6/Gim41wYg2/jwjRRa9BsJn9rKwRxVEiv8jx5lmgrqe
         GYgrXWcuptsMazIA2RAV+rSVj/Trv+cmrqoVW/1UD4kfR4RVz6t+l2+/p+bFwm+7U1My
         zzT/UkFj+Vr/h4RhRlKafLSrJH3Xa2WqsqOwQ38Bczj/2/Jv+s+8rYhZQ3hM8KgtqVRE
         cjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754295324; x=1754900124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0/hn9Eliq7ebIUdeCMqZrdU4Llw8i8H1X4gsxBpU9U=;
        b=wJLMJwX9AlPHhpQdv4GbRSju4HKluQwcFFknziNLKHkVhJJUg1B9lfeHBvjtAgRxg7
         wpxCL0+one5WSfwUP7ONo3XwsBuOZkPjEezwrd/jDOeFKU3Fa9J0MiAgadhuLzCF7PHH
         NPNR28KTS8ognjBv32QLrby2MA9eu+m3jGyn4f4Qz6dzlWj5z9CZ5HIRMljZ2ZJzH3IG
         Se9iX6ZT8Fwha1VnkbBJjyFrIUjRo26arTPckk8m5ZAMdGSe4zvnqm7FL7km9DEr8UZA
         DAN42EG6VP0IE3/Jz4BgdQEHfpipEx833JKKC5l00luonKNw28iXv+BdKehMmptRfCvC
         7Xpw==
X-Forwarded-Encrypted: i=1; AJvYcCW/EI7A7TabvZWRtXBFJHfAANO+M1XMLeYt7H1amt/a8Yrbb6Wu4RFhm5+3u+XBexnnCYVJMIYX6cA0FJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7IdWwZ46PeCCGQa2/TYXO33mrUtoCzFc3D8OBob8io+sbRDQ
	2cQxNtGsnlsSBh3yIZFIxcNCBLYbg9xrjHh1rYSJeQw9+gE9EuNoL46zkqDBshIS0eo=
X-Gm-Gg: ASbGncsw7IQpLB+nF4oHaTaIDmeEiVwv3MLeIfuUvUncRd0mBxk2A+qKkhf42/5UHby
	UGo+wDepopCuMhY0bVud8o0Krtl1O61TOAaoojgpSwqYgJfllDIPJXDhQQTHBSB+xLhYucpx36d
	2myCMZg0X7vsWnIjJ+BscOw4lczwLWXzKafiC8xJY4w23RhNX9imwvVFRSr3PXDz2xoIHe/Ee+U
	NbhzBTckyV+CgOjSIZO7zpdJE1vxKvoChCBvZaDi9DObuQZQpSla7l3e1Xb7hLBxOBGS70KAj3N
	2Gwb8FdyWgmYkgIwUU5hGixvBELz+Tq05LageVEmcAGHoq2gGo5J96cELihmzh0FFz3lEzO89GB
	Mo0/1EAuB3BNY07yzyDo8OqZB5v7ir5lvTGbiImnR38wJC7p9LylbjCQ5QR4bh13R5VM=
X-Google-Smtp-Source: AGHT+IF2iR02AAB1yhMP8NRjCBEy1r/sjM3towmkE9K8hsnQNhLd85ExCIqMpGCqsotkV7O9JjocBQ==
X-Received: by 2002:a05:600c:6304:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-458b69e0380mr60785165e9.8.1754295323813;
        Mon, 04 Aug 2025 01:15:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bc1f62e7sm79111125e9.2.2025.08.04.01.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:15:23 -0700 (PDT)
Message-ID: <b37f6f25-7569-4cae-b33d-61ed14b19611@rivosinc.com>
Date: Mon, 4 Aug 2025 10:15:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] riscv: hw_breakpoint: Use icount for single
 stepping
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
 <20250722173829.984082-6-jesse@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20250722173829.984082-6-jesse@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/07/2025 19:38, Jesse Taube wrote:
> The Sdtrig RISC-V ISA extension does not have a resume flag for
> returning to and executing the instruction at the breakpoint.
> To avoid skipping the instruction or looping, it is necessary to remove
> the hardware breakpoint and single step. Use the icount feature of
> Sdtrig to accomplish this. Use icount as default with an option to allow
> software-based single stepping when hardware or SBI does not have
> icount functionality, as it may cause unwanted side effects when reading
> the instruction from memory.
> 
> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
>  arch/riscv/Kconfig                | 11 +++++
>  arch/riscv/kernel/hw_breakpoint.c | 81 +++++++++++++++++++++++++------
>  2 files changed, 76 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 95d3047cab10..bbde5e118470 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1105,6 +1105,17 @@ config PARAVIRT_TIME_ACCOUNTING
>  
>  	  If in doubt, say N here.
>  
> +config HW_BREAKPOINT_COMPUTE_STEP
> +	bool "Allow computing hardware breakpoint step address"
> +	default n
> +	depends on HAVE_HW_BREAKPOINT
> +	help
> +	  Select this option if hardware breakpoints are desired, but
> +	  hardware or SBI does not have icount functionality. This may cause
> +	  unwanted side affects when reading the instruction from memory.

Hi Jesse,

Typo: s/affects/effects

Thanks,

Clément

> +
> +	  If unsure, say N.
> +
>  config RELOCATABLE
>  	bool "Build a relocatable kernel"
>  	depends on !XIP_KERNEL
> diff --git a/arch/riscv/kernel/hw_breakpoint.c b/arch/riscv/kernel/hw_breakpoint.c
> index 9e3a3b82d300..437fd82b9590 100644
> --- a/arch/riscv/kernel/hw_breakpoint.c
> +++ b/arch/riscv/kernel/hw_breakpoint.c
> @@ -20,6 +20,7 @@
>  #define DBTR_TDATA1_DMODE		BIT_UL(__riscv_xlen - 5)
>  
>  #define DBTR_TDATA1_TYPE_MCONTROL	(2UL << DBTR_TDATA1_TYPE_SHIFT)
> +#define DBTR_TDATA1_TYPE_ICOUNT		(3UL << DBTR_TDATA1_TYPE_SHIFT)
>  #define DBTR_TDATA1_TYPE_MCONTROL6	(6UL << DBTR_TDATA1_TYPE_SHIFT)
>  
>  #define DBTR_TDATA1_MCONTROL6_LOAD		BIT(0)
> @@ -55,6 +56,14 @@
>  #define DBTR_TDATA1_MCONTROL_SIZELO_64BIT	1
>  #define DBTR_TDATA1_MCONTROL_SIZEHI_64BIT	1
>  
> +#define DBTR_TDATA1_ICOUNT_U			BIT(6)
> +#define DBTR_TDATA1_ICOUNT_S			BIT(7)
> +#define DBTR_TDATA1_ICOUNT_PENDING		BIT(8)
> +#define DBTR_TDATA1_ICOUNT_M			BIT(9)
> +#define DBTR_TDATA1_ICOUNT_COUNT_FIELD		GENMASK(23, 10)
> +#define DBTR_TDATA1_ICOUNT_VU			BIT(25)
> +#define DBTR_TDATA1_ICOUNT_VS			BIT(26)
> +
>  /* Registered per-cpu bp/wp */
>  static DEFINE_PER_CPU(struct perf_event *, pcpu_hw_bp_events[RV_MAX_TRIGGERS]);
>  static DEFINE_PER_CPU(unsigned long, ecall_lock_flags);
> @@ -65,6 +74,7 @@ static DEFINE_PER_CPU(union sbi_dbtr_shmem_entry, sbi_dbtr_shmem);
>  
>  /* number of debug triggers on this cpu . */
>  static int dbtr_total_num __ro_after_init;
> +static bool have_icount __ro_after_init;
>  static unsigned long dbtr_type __ro_after_init;
>  static unsigned long dbtr_init __ro_after_init;
>  
> @@ -168,6 +178,7 @@ static int arch_smp_teardown_sbi_shmem(unsigned int cpu)
>  static void init_sbi_dbtr(void)
>  {
>  	struct sbiret ret;
> +	unsigned long dbtr_count = 0;
>  
>  	/*
>  	 * Called by hw_breakpoint_slots and arch_hw_breakpoint_init.
> @@ -182,6 +193,25 @@ static void init_sbi_dbtr(void)
>  		return;
>  	}
>  
> +	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
> +		DBTR_TDATA1_TYPE_ICOUNT, 0, 0, 0, 0, 0);
> +	if (ret.error) {
> +		pr_warn("%s: failed to detect icount triggers. error: %ld.\n",
> +			__func__, ret.error);
> +	} else if (!ret.value) {
> +		if (IS_ENABLED(CONFIG_HW_BREAKPOINT_COMPUTE_STEP)) {
> +			pr_warn("%s: No icount triggers available. "
> +				"Falling-back to computing single step address.\n", __func__);
> +		} else {
> +			pr_err("%s: No icount triggers available.\n", __func__);
> +			dbtr_total_num = 0;
> +			return;
> +		}
> +	} else {
> +		dbtr_count = ret.value;
> +		have_icount = true;
> +	}
> +
>  	ret = sbi_ecall(SBI_EXT_DBTR, SBI_EXT_DBTR_NUM_TRIGGERS,
>  			DBTR_TDATA1_TYPE_MCONTROL6, 0, 0, 0, 0, 0);
>  	if (ret.error) {
> @@ -190,7 +220,7 @@ static void init_sbi_dbtr(void)
>  	} else if (!ret.value) {
>  		pr_warn("%s: No mcontrol6 triggers available.\n", __func__);
>  	} else {
> -		dbtr_total_num = ret.value;
> +		dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
>  		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL6;
>  		return;
>  	}
> @@ -205,7 +235,7 @@ static void init_sbi_dbtr(void)
>  		pr_err("%s: No mcontrol triggers available.\n", __func__);
>  		dbtr_total_num = 0;
>  	} else {
> -		dbtr_total_num = ret.value;
> +		dbtr_total_num = min_not_zero((unsigned long)ret.value, dbtr_count);
>  		dbtr_type = DBTR_TDATA1_TYPE_MCONTROL;
>  	}
>  }
> @@ -344,6 +374,21 @@ static int rv_init_mcontrol6_trigger(const struct perf_event_attr *attr,
>  	return 0;
>  }
>  
> +static int rv_init_icount_trigger(struct arch_hw_breakpoint *hw)
> +{
> +	unsigned long tdata1 = DBTR_TDATA1_TYPE_ICOUNT;
> +
> +	/* Step one instruction */
> +	tdata1 |= FIELD_PREP(DBTR_TDATA1_ICOUNT_COUNT_FIELD, 1);
> +
> +	tdata1 |= DBTR_TDATA1_ICOUNT_U;
> +
> +	hw->tdata1 = tdata1;
> +	hw->tdata2 = 0;
> +
> +	return 0;
> +}
> +
>  int hw_breakpoint_arch_parse(struct perf_event *bp,
>  			     const struct perf_event_attr *attr,
>  			     struct arch_hw_breakpoint *hw)
> @@ -389,24 +434,28 @@ static int setup_singlestep(struct perf_event *event, struct pt_regs *regs)
>  	/* Remove breakpoint even if return error as not to loop */
>  	arch_uninstall_hw_breakpoint(event);
>  
> -	ret = get_insn(regs, regs->epc, &insn);
> -	if (ret < 0)
> -		return ret;
> +	if (have_icount) {
> +		rv_init_icount_trigger(bp);
> +	} else {
> +		ret = get_insn(regs, regs->epc, &insn);
> +		if (ret < 0)
> +			return ret;
>  
> -	next_addr = get_step_address(regs, insn);
> +		next_addr = get_step_address(regs, insn);
>  
> -	ret = get_insn(regs, next_addr, &insn);
> -	if (ret < 0)
> -		return ret;
> +		ret = get_insn(regs, next_addr, &insn);
> +		if (ret < 0)
> +			return ret;
>  
> -	bp_insn.bp_type = HW_BREAKPOINT_X;
> -	bp_insn.bp_addr = next_addr;
> -	/* Get the size of the intruction */
> -	bp_insn.bp_len = GET_INSN_LENGTH(insn);
> +		bp_insn.bp_type = HW_BREAKPOINT_X;
> +		bp_insn.bp_addr = next_addr;
> +		/* Get the size of the intruction */
> +		bp_insn.bp_len = GET_INSN_LENGTH(insn);
>  
> -	ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> -	if (ret)
> -		return ret;
> +		ret = hw_breakpoint_arch_parse(NULL, &bp_insn, bp);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	ret = arch_install_hw_breakpoint(event);
>  	if (ret)


