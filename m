Return-Path: <linux-kernel+bounces-786981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13507B36F99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13601BA1204
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEFE2773F6;
	Tue, 26 Aug 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1cF6MCk"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F731B85F8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224684; cv=none; b=mfMELMVqgDqYDZIqa9mbHrpLEJCZk+S2I1/W5tLJZcFO87k+fuGgyMHuRKlTggGdlNVg/zH40LBccr5DsuUT2zWUpukJqayzQauVvhoRUYAXs+pUOGXyIyQJXHbOXenBIhHQWaf9cSonEQzajDx4IuMtLoWCgX9kThvveMn4FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224684; c=relaxed/simple;
	bh=lO8l5qEhAahIyHTA8ptQ/O8HBIAUgWnjh7/ZJEDmUo0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=n1uUIFvWzC2bNASelgSN77w5g0wPnpg04nAHdAj2jQOHUO1/qtpnI0LdxdDjR5ZP5TmUXL4Zgv6OLogvUxvK4luxMRzYoT+2y0NPlScuLdEoCjOpMGFk9TCaN50OkYnJiud98qqV1y2RBrIpttSsdclBeeqhxJet3Bpv0S8HerM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1cF6MCk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24666642854so30746095ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756224681; x=1756829481; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7YHGBfWDVADI2xpT7SSYdJvgJ+u1HlsYJPIUxDj/3o=;
        b=k1cF6MCk1SjCxPnuBZgWk8TPn6vzD7FiWjDKpmIMtib8eZV+yca8B4/1i1yZ7N9HmR
         UYSK+oUFIxrBHu9EyQcHC2MzueySi5uzhAT4/HKChcmoff7h77C/TlMiIePEnv+9dVgh
         Ht2WhsbzWFt9URpZTrXgkSa4/y4DuMqKYcrpL+4Qobwz7Ac6wghCwhjjxpi2ykHal4Hv
         OwpeuAk66h+rfTGrzZqpYuEOhjsBU2MQt2H5l44J0mqBOR7VYTCT+q0jX6tCGjIpKMbS
         EV2/Xz5JCa5BfGuW+aooYqTbRnyxXXiIjL+lKruhnhjMCVZSEzIJZJk1beuQ2+OMr4Z4
         arxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224681; x=1756829481;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7YHGBfWDVADI2xpT7SSYdJvgJ+u1HlsYJPIUxDj/3o=;
        b=DxBRyXBq4qoMLiaBAU0necD0YpnKgg3w9Tr5Lc5FfriFjPWXVYAVaL+6Sd4uJoumFf
         ZxrLLb5X2GbLXwbQlaWb+qLvxegCGfOTLdRCWR54WMfOkE4aOY5GXloEKHYtR+CX7gbp
         A4DQKe8vRv9P4N7IRw3xMXgNSSos3NTgZdLv/lbid2BeuMPkbI8BhnAK/hQ5+T6LdR3P
         QALAqeCSLVcuHBajSjivwTIykIDTuHBjZMxk+CYHOnLaxoPYpy2TDL/uNju1KppEa13X
         nKYIh/OZvTUI5IUQ69ZLUUgQ8OOqWfKALYUjbLhIdT6zbrzoVWk7z+atE5/2Br6OYFhi
         b4mg==
X-Forwarded-Encrypted: i=1; AJvYcCUXobXNP95tOeKppHtjgra0rP5JWlXuPp+D/NHb84RkQFaVlD2PwZHY1bN7FdhhH33/LFjc5gcuds23yq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQgciDxxckYg2N8II2EgPkZcvf/EA3mFCXrD7EBEcfeuKSsFX
	ThqO+9F3M/SamgRhddFLpXss+OFvNUMcij9KLxTyeKHYNw/gTGju52LohY3bcg==
X-Gm-Gg: ASbGncu//4ZYEeb/vnpo23kdngka1qXo5va65T/oLUEesL8u2Z/c97UfonKHmAWCiC1
	5ebcSzmhI5WsOp9v54cbZle6hxGcdxD3XJEOlialV88k8/Zm63dRXr6yjHN/XMLefHuDCa3Bevl
	Aeczsmp892UbeRmNtNf/wQ3zncf29Z+/XNTi7iaaM3MkLIhq+y5dV5npszaBk8YMMB3SAu3NaHJ
	y8ryiH7oSUo/i9/Ly+jGuXeYfl5Se5hjK63nnldmm+cuhzlbK6z/Mx0DrYQl4typKClrL7sggtD
	p3GitPw166sDSegYXW8MNdOf0KaSJ/reuQX8fHlS6h7tN3N0bwDePoW6jbUiUzjC1hH+KAGDmZl
	ae62hSVJqNvE4Y9bNcU/dZo3J
X-Google-Smtp-Source: AGHT+IG8j7nkE/RFr7BQwCiAtTrjb1Yni0bb2N7tgW2dyTywLJuPO1I0dLGiPUq7BkTRDYyaGss91w==
X-Received: by 2002:a17:902:f70a:b0:246:d703:cf7f with SMTP id d9443c01a7336-246d703e121mr117052065ad.5.1756224680346;
        Tue, 26 Aug 2025 09:11:20 -0700 (PDT)
Received: from dw-tp ([171.76.82.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466885efc8sm99434355ad.90.2025.08.26.09.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:11:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] arm64/ptdump: Add ARM64_PTDUMP_CONSOLE
In-Reply-To: <20250818091436.938517-4-anshuman.khandual@arm.com>
Date: Tue, 26 Aug 2025 21:16:19 +0530
Message-ID: <87bjo2qe5w.fsf@gmail.com>
References: <20250818091436.938517-1-anshuman.khandual@arm.com> <20250818091436.938517-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> Enable early kernel page table dump for debug purpose when required via new
> config ARM64_PDUMP_CONSOLE. This calls existing ptdump_walk() early on just
> after ptdump has been initialized with ptdump_init().

I happen to stumble upon this while looking for something else related
to ptdump and was curious to understand where this will be really
useful? 

So instead of dumping it via cat /sys/kernel/debug/kernel_page_tables,
this will dump at early boot during arch setup and before start_kernel().

I was curious, since this anyway gets enabled only in debug kernels.
There we can always just boot with minimal busybox image which can jump
to shell quickly and dump the kernel page tables, correct?

Also is ARM64_PTDUMP_CONSOLE config option added on purpose? A kernel cmdline
like early_ptdump=yes|1|true could come much handy, right?

(Since I am fixing few issues on powerpc ptdump - hence was just curious
to know whether this can come useful for me too or not :) )

Thanks!
-ritesh

>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/Kconfig.debug        | 12 ++++++++++++
>  arch/arm64/include/asm/ptdump.h |  7 +++++++
>  arch/arm64/kernel/setup.c       |  1 +
>  arch/arm64/mm/ptdump.c          |  7 +++++++
>  4 files changed, 27 insertions(+)
>
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 265c4461031f..0f8af0dd0f4c 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -20,4 +20,16 @@ config ARM64_RELOC_TEST
>  	depends on m
>  	tristate "Relocation testing module"
>  
> +config ARM64_PTDUMP_CONSOLE
> +	bool "Dump early kernel page table"
> +	depends on DEBUG_KERNEL
> +	depends on ARCH_HAS_PTDUMP
> +	select PTDUMP
> +	help
> +	  Enable this option to dump early kernel page table entries during
> +	  boot using the PTDUMP framework. This helps in examining kernel's
> +	  page table mapping entries and their attributes etc.
> +
> +	  If in doubt, say N.
> +
>  source "drivers/hwtracing/coresight/Kconfig"
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index 27e774134e7f..81dc53ca9643 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -74,8 +74,15 @@ void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>  static inline void ptdump_debugfs_register(struct ptdump_info *info,
>  					   const char *name) { }
>  #endif /* CONFIG_PTDUMP_DEBUGFS */
> +
> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
> +void __init arm64_kernel_pgtable_dump(void);
> +#else
> +static inline void __init arm64_kernel_pgtable_dump(void) { }
> +#endif /* CONFIG_ARM64_PTDUMP_CONSOLE */
>  #else
>  static inline void __init ptdump_init(void) { }
> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>  static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
>  			     int level, pteval_t val) { }
>  static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 0a3812c8e177..86bf7607d304 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -361,6 +361,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	init_bootcpu_ops();
>  	smp_init_cpus();
>  	smp_build_mpidr_hash();
> +	arm64_kernel_pgtable_dump();
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  	/*
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index c78e6b496dea..f6d22462add6 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -407,6 +407,13 @@ void __init ptdump_init(void)
>  	ptdump_initialize();
>  }
>  
> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
> +void __init arm64_kernel_pgtable_dump(void)
> +{
> +	ptdump_walk(CONSOLE, &kernel_ptdump_info);
> +}
> +#endif
> +
>  static int __init ptdump_debugfs_init(void)
>  {
>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
> -- 
> 2.25.1

