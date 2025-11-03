Return-Path: <linux-kernel+bounces-882507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010A5C2A9E9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B431892121
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B982E228D;
	Mon,  3 Nov 2025 08:44:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523E953363
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159447; cv=none; b=KkdlTnLhHqT5Cm1Q9mNs2zirFNqUWjrT+4EVg9EpyOMCJk8E+oXCZWPpJr4CivDDoLtV/p9AeByvj4iqF+6c0l/HHATNH4ZESCCl4BgKhsoUAyBF8A8CL5pXb1RXbAG+R6lERatOPMau6YGxxQUs8i9J8Tw0iPa3zqMEqDyc/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159447; c=relaxed/simple;
	bh=ErdmyhYmbu+Q9MnDZ2ZB5VBnhzRHqOJACZeTJaH+/b4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RUfqDOQ5cOmNSKUy7U5lu0oBFevxzB/BBFhpHPGj1cj0FBlCrv/5xl4/yHC+DzsMauql8fRdioOP2wlgGT2MPsXWktbUf9z6YP+anLTaJsGF78RXWPrntIA99aP+L+42o5qyskLDTJv2aJbkStuXOZ6KmToYEiUzKBt2SZrRW1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF88A1D13;
	Mon,  3 Nov 2025 00:43:56 -0800 (PST)
Received: from [10.164.136.41] (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3999F3F694;
	Mon,  3 Nov 2025 00:43:57 -0800 (PST)
Message-ID: <666e012e-0b13-4def-82de-55ccd5868d36@arm.com>
Date: Mon, 3 Nov 2025 14:13:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
To: Qi Zheng <zhengqi.arch@bytedance.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, hannes@cmpxchg.org
Cc: ryan.roberts@arm.com, hpa@zytor.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, ppt@kernel.org, surenb@google.com,
 mhocko@suse.com, shakeel.butt@linux.dev, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20251103063718.90743-1-dev.jain@arm.com>
 <044e3f9a-3de2-4939-afff-3bb527eb024b@bytedance.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <044e3f9a-3de2-4939-afff-3bb527eb024b@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/11/25 12:33 pm, Qi Zheng wrote:
> Hi Dev,
>
> On 11/3/25 2:37 PM, Dev Jain wrote:
>> The implementation of CONFIG_PT_RECLAIM is completely contained in 
>> generic
>> mm code. It depends on the RCU callback which will reclaim the 
>> pagetables -
>> there is nothing arch-specific about that. So, enable this config for
>> all architectures.
>
> Thanks for doing this!
>
> But unfortunately, not all architectures call tlb_remove_ptdesc() in
> __pte_free_tlb(). Some architectures directly call pte_free() to
> free PTE pages (without RCU).

Thanks! This was not obvious to figure out.

Is there an arch bottleneck because of which they do this? I mean to say,

is something stopping us from simply redirecting __pte_free_tlb to 
tlb_remove_ptdesc

or pte_free_defer?


I am looking to enable this config at least on arm64 by default, I 
believe it will be legal

to do this at least here.


>
> We need to modify these architectures first, otherwise it will
> lead to UAF. This approach is feasible because Hugh provides similar
> support in pte_free_defer().
>
> Enabling PT_RECLAIM on all architecture has always been on my
> TODO list, but it's been blocked by other things. :(
>
> Thanks,
> Qi
>
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   arch/x86/Kconfig | 1 -
>>   mm/Kconfig       | 5 +----
>>   mm/pt_reclaim.c  | 2 +-
>>   3 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index fa3b616af03a..5681308a5650 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -327,7 +327,6 @@ config X86
>>       select FUNCTION_ALIGNMENT_4B
>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>       select SCHED_SMT            if SMP
>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 0e26f4fc8717..903c37d02555 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>         The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>   -config ARCH_SUPPORTS_PT_RECLAIM
>> -    def_bool n
>> -
>>   config PT_RECLAIM
>>       bool "reclaim empty user page table pages"
>>       default y
>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> +    depends on MMU && SMP
>>       select MMU_GATHER_RCU_TABLE_FREE
>>       help
>>         Try to reclaim empty user page table pages in paths other 
>> than munmap
>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>> index 7e9455a18aae..049e17f08c6a 100644
>> --- a/mm/pt_reclaim.c
>> +++ b/mm/pt_reclaim.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <linux/hugetlb.h>
>> -#include <asm-generic/tlb.h>
>> +#include <asm/tlb.h>
>>   #include <asm/pgalloc.h>
>>     #include "internal.h"
>

