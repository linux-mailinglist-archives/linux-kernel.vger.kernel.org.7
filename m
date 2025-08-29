Return-Path: <linux-kernel+bounces-791184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FFCB3B309
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF5B57BA37D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232061B532F;
	Fri, 29 Aug 2025 06:12:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D910F8BEC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447929; cv=none; b=GH7JivSy1RpArlLcAp8lWNRuwWuUg2d7a4kYktE1YQKBMgTAks3HYadAoCsS6cKDBwYDN06SElfMG0JTAxH+mYuFYvY74884I4B2d0RIBHdAeWIM8b1Y29EIadSNN6zKfRYZpW1lbqO/1xKfq1kgeGtxxVnsxjW5JR26kBOfe0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447929; c=relaxed/simple;
	bh=R1DP1iGQo2XGO0dpWZCwWDEt5F+wx6hisF2gRVT5w78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfL2d9uPq27huQr/z4MRIaa3SgXUv4AApRFnhQ+uWWItiMXdstVj/euGdRbTLl9qyBAZCbVW1PvVz2itEXTWa9bT9UqzuS476/VDijk/4ZyvStHByb8yihsApwoTg4SFFIlNFoH9D+Z/RrJhCDI84uHBnuBIPfvGGdfXzIPaE6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F195B1758;
	Thu, 28 Aug 2025 23:11:58 -0700 (PDT)
Received: from [10.164.18.63] (unknown [10.164.18.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5FC3F63F;
	Thu, 28 Aug 2025 23:12:04 -0700 (PDT)
Message-ID: <2bf90f7c-a026-488a-8a27-26f571b3d02a@arm.com>
Date: Fri, 29 Aug 2025 11:42:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/3] arm64/ptdump: Add ARM64_PTDUMP_CONSOLE
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20250818091436.938517-1-anshuman.khandual@arm.com>
 <20250818091436.938517-4-anshuman.khandual@arm.com>
 <87bjo2qe5w.fsf@gmail.com> <7302615c-e190-43ac-bc29-e82d7b048403@arm.com>
 <87zfbikd4f.fsf@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <87zfbikd4f.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 29/08/25 9:12 AM, Ritesh Harjani (IBM) wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> On 26/08/25 9:16 PM, Ritesh Harjani (IBM) wrote:
>>> Anshuman Khandual <anshuman.khandual@arm.com> writes:
>>>
>>>> Enable early kernel page table dump for debug purpose when required via new
>>>> config ARM64_PDUMP_CONSOLE. This calls existing ptdump_walk() early on just
>>>> after ptdump has been initialized with ptdump_init().
>>>
>>> I happen to stumble upon this while looking for something else related
>>> to ptdump and was curious to understand where this will be really
>>> useful? 
>>>
>>> So instead of dumping it via cat /sys/kernel/debug/kernel_page_tables,
>>> this will dump at early boot during arch setup and before start_kernel().
>>
>> Right, primarily before vmalloc() space gets crowded. Also this provides
>> an opportunity to do a diff between early boot and after boot kernel page
>> table states.
> 
> Just want to understand this better - the diff here will mainly show the
> new page table entries for the remaining layout which will get populated
> in start_kernel() right? The existing mappings created during
> setup_arch() won't get changed right?

Correct.
> 
>>>
>>> I was curious, since this anyway gets enabled only in debug kernels.
>>> There we can always just boot with minimal busybox image which can jump
>>> to shell quickly and dump the kernel page tables, correct?
>>
>> Here the kernel page table dump could happen earlier than that as well.
>>>
>>> Also is ARM64_PTDUMP_CONSOLE config option added on purpose? A kernel cmdline
>>> like early_ptdump=yes|1|true could come much handy, right?
>>
>> Currently this is just for arm64 platform but could be enabled in general
>> for other platforms as well. Yes, early_ptdump=yes|1|true will be useful
>> as well. ARM64_PTDUMP_CONSOLE just build guards the additional code. But
>> if required cmdline option "early_ptdump=" could just provide the runtime
>> switch and then this could always be built enabled on CONFIG_PTDUMP.
>>>
>>> (Since I am fixing few issues on powerpc ptdump - hence was just curious
>>> to know whether this can come useful for me too or not :) )
>>
>> This feature could be extended in general to other platforms. Let me know
>> if you find this useful for powerpc.
> 
> Sure - as of now I don't have a direct usecase. But let me try to do
> an early page table dump by taking some inspiration from your patch to
> see if this adds value for powerpc case or not.

Sure, please do let us know how that goes.

> > Thanks for sharing the info.
> 
> -ritesh
> 
>>>
>>> Thanks!
>>> -ritesh
>>>
>>>>
>>>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>>  arch/arm64/Kconfig.debug        | 12 ++++++++++++
>>>>  arch/arm64/include/asm/ptdump.h |  7 +++++++
>>>>  arch/arm64/kernel/setup.c       |  1 +
>>>>  arch/arm64/mm/ptdump.c          |  7 +++++++
>>>>  4 files changed, 27 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>>>> index 265c4461031f..0f8af0dd0f4c 100644
>>>> --- a/arch/arm64/Kconfig.debug
>>>> +++ b/arch/arm64/Kconfig.debug
>>>> @@ -20,4 +20,16 @@ config ARM64_RELOC_TEST
>>>>  	depends on m
>>>>  	tristate "Relocation testing module"
>>>>  
>>>> +config ARM64_PTDUMP_CONSOLE
>>>> +	bool "Dump early kernel page table"
>>>> +	depends on DEBUG_KERNEL
>>>> +	depends on ARCH_HAS_PTDUMP
>>>> +	select PTDUMP
>>>> +	help
>>>> +	  Enable this option to dump early kernel page table entries during
>>>> +	  boot using the PTDUMP framework. This helps in examining kernel's
>>>> +	  page table mapping entries and their attributes etc.
>>>> +
>>>> +	  If in doubt, say N.
>>>> +
>>>>  source "drivers/hwtracing/coresight/Kconfig"
>>>> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
>>>> index 27e774134e7f..81dc53ca9643 100644
>>>> --- a/arch/arm64/include/asm/ptdump.h
>>>> +++ b/arch/arm64/include/asm/ptdump.h
>>>> @@ -74,8 +74,15 @@ void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>>>>  static inline void ptdump_debugfs_register(struct ptdump_info *info,
>>>>  					   const char *name) { }
>>>>  #endif /* CONFIG_PTDUMP_DEBUGFS */
>>>> +
>>>> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
>>>> +void __init arm64_kernel_pgtable_dump(void);
>>>> +#else
>>>> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>>>> +#endif /* CONFIG_ARM64_PTDUMP_CONSOLE */
>>>>  #else
>>>>  static inline void __init ptdump_init(void) { }
>>>> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>>>>  static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
>>>>  			     int level, pteval_t val) { }
>>>>  static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
>>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>>> index 0a3812c8e177..86bf7607d304 100644
>>>> --- a/arch/arm64/kernel/setup.c
>>>> +++ b/arch/arm64/kernel/setup.c
>>>> @@ -361,6 +361,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>>>  	init_bootcpu_ops();
>>>>  	smp_init_cpus();
>>>>  	smp_build_mpidr_hash();
>>>> +	arm64_kernel_pgtable_dump();
>>>>  
>>>>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>>>>  	/*
>>>> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
>>>> index c78e6b496dea..f6d22462add6 100644
>>>> --- a/arch/arm64/mm/ptdump.c
>>>> +++ b/arch/arm64/mm/ptdump.c
>>>> @@ -407,6 +407,13 @@ void __init ptdump_init(void)
>>>>  	ptdump_initialize();
>>>>  }
>>>>  
>>>> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
>>>> +void __init arm64_kernel_pgtable_dump(void)
>>>> +{
>>>> +	ptdump_walk(CONSOLE, &kernel_ptdump_info);
>>>> +}
>>>> +#endif
>>>> +
>>>>  static int __init ptdump_debugfs_init(void)
>>>>  {
>>>>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>>>> -- 
>>>> 2.25.1


