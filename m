Return-Path: <linux-kernel+bounces-789148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3055B391A7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA633B508E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931FA246BB8;
	Thu, 28 Aug 2025 02:23:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E91E487
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347781; cv=none; b=tRyuqm4ndcKwrWt9XKspwlMnV1OTr/1Uopwk7+rUvLevWtiopGpZ+dndc0Lh6ohm2qHw9nXbYevNU/aI01zmseZHMkY6TelY1u2pTMqE2TcFiJplfIB4iIQSssUmnKEfkXpI01QzF059KfgYrjxU2l8aujSjf6KfGr330XT4P0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347781; c=relaxed/simple;
	bh=NkAaXmAH+8IwbZ5OpWpV2Au7PU2nD1XGZ3GP1CJalSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl+hCYnygWOyaQX9oJCjV+jwoIJGD6bDWvjRr8BaEm+d2X+G3AIV+opSx90YfkIDMAkb+J43+0XQLEkGnekjmexvztOl0SwQxQ16/lZ4Q4jHoNYtQmXP3U894EuCzZ0kHbmZdBFDQZLYR/FHQbUXp6VNtDxrxHbPp7aXsJ6WEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11D8115A1;
	Wed, 27 Aug 2025 19:22:49 -0700 (PDT)
Received: from [10.163.68.247] (unknown [10.163.68.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A61BD3F738;
	Wed, 27 Aug 2025 19:22:54 -0700 (PDT)
Message-ID: <7302615c-e190-43ac-bc29-e82d7b048403@arm.com>
Date: Thu, 28 Aug 2025 07:52:51 +0530
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
 <87bjo2qe5w.fsf@gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <87bjo2qe5w.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/25 9:16 PM, Ritesh Harjani (IBM) wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> Enable early kernel page table dump for debug purpose when required via new
>> config ARM64_PDUMP_CONSOLE. This calls existing ptdump_walk() early on just
>> after ptdump has been initialized with ptdump_init().
> 
> I happen to stumble upon this while looking for something else related
> to ptdump and was curious to understand where this will be really
> useful? 
> 
> So instead of dumping it via cat /sys/kernel/debug/kernel_page_tables,
> this will dump at early boot during arch setup and before start_kernel().

Right, primarily before vmalloc() space gets crowded. Also this provides
an opportunity to do a diff between early boot and after boot kernel page
table states.
> 
> I was curious, since this anyway gets enabled only in debug kernels.
> There we can always just boot with minimal busybox image which can jump
> to shell quickly and dump the kernel page tables, correct?

Here the kernel page table dump could happen earlier than that as well.
> 
> Also is ARM64_PTDUMP_CONSOLE config option added on purpose? A kernel cmdline
> like early_ptdump=yes|1|true could come much handy, right?

Currently this is just for arm64 platform but could be enabled in general
for other platforms as well. Yes, early_ptdump=yes|1|true will be useful
as well. ARM64_PTDUMP_CONSOLE just build guards the additional code. But
if required cmdline option "early_ptdump=" could just provide the runtime
switch and then this could always be built enabled on CONFIG_PTDUMP.
> 
> (Since I am fixing few issues on powerpc ptdump - hence was just curious
> to know whether this can come useful for me too or not :) )

This feature could be extended in general to other platforms. Let me know
if you find this useful for powerpc.
> 
> Thanks!
> -ritesh
> 
>>
>> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/Kconfig.debug        | 12 ++++++++++++
>>  arch/arm64/include/asm/ptdump.h |  7 +++++++
>>  arch/arm64/kernel/setup.c       |  1 +
>>  arch/arm64/mm/ptdump.c          |  7 +++++++
>>  4 files changed, 27 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
>> index 265c4461031f..0f8af0dd0f4c 100644
>> --- a/arch/arm64/Kconfig.debug
>> +++ b/arch/arm64/Kconfig.debug
>> @@ -20,4 +20,16 @@ config ARM64_RELOC_TEST
>>  	depends on m
>>  	tristate "Relocation testing module"
>>  
>> +config ARM64_PTDUMP_CONSOLE
>> +	bool "Dump early kernel page table"
>> +	depends on DEBUG_KERNEL
>> +	depends on ARCH_HAS_PTDUMP
>> +	select PTDUMP
>> +	help
>> +	  Enable this option to dump early kernel page table entries during
>> +	  boot using the PTDUMP framework. This helps in examining kernel's
>> +	  page table mapping entries and their attributes etc.
>> +
>> +	  If in doubt, say N.
>> +
>>  source "drivers/hwtracing/coresight/Kconfig"
>> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
>> index 27e774134e7f..81dc53ca9643 100644
>> --- a/arch/arm64/include/asm/ptdump.h
>> +++ b/arch/arm64/include/asm/ptdump.h
>> @@ -74,8 +74,15 @@ void __init ptdump_debugfs_register(struct ptdump_info *info, const char *name);
>>  static inline void ptdump_debugfs_register(struct ptdump_info *info,
>>  					   const char *name) { }
>>  #endif /* CONFIG_PTDUMP_DEBUGFS */
>> +
>> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
>> +void __init arm64_kernel_pgtable_dump(void);
>> +#else
>> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>> +#endif /* CONFIG_ARM64_PTDUMP_CONSOLE */
>>  #else
>>  static inline void __init ptdump_init(void) { }
>> +static inline void __init arm64_kernel_pgtable_dump(void) { }
>>  static inline void note_page(struct ptdump_state *pt_st, unsigned long addr,
>>  			     int level, pteval_t val) { }
>>  static inline void note_page_pte(struct ptdump_state *st, unsigned long addr, pte_t pte) { }
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index 0a3812c8e177..86bf7607d304 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -361,6 +361,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>>  	init_bootcpu_ops();
>>  	smp_init_cpus();
>>  	smp_build_mpidr_hash();
>> +	arm64_kernel_pgtable_dump();
>>  
>>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>>  	/*
>> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
>> index c78e6b496dea..f6d22462add6 100644
>> --- a/arch/arm64/mm/ptdump.c
>> +++ b/arch/arm64/mm/ptdump.c
>> @@ -407,6 +407,13 @@ void __init ptdump_init(void)
>>  	ptdump_initialize();
>>  }
>>  
>> +#ifdef CONFIG_ARM64_PTDUMP_CONSOLE
>> +void __init arm64_kernel_pgtable_dump(void)
>> +{
>> +	ptdump_walk(CONSOLE, &kernel_ptdump_info);
>> +}
>> +#endif
>> +
>>  static int __init ptdump_debugfs_init(void)
>>  {
>>  	ptdump_debugfs_register(&kernel_ptdump_info, "kernel_page_tables");
>> -- 
>> 2.25.1


