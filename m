Return-Path: <linux-kernel+bounces-884060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D55C2F39B
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37BCB4E550E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F5B23F429;
	Tue,  4 Nov 2025 04:02:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E25D18EFD1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762228958; cv=none; b=cyHZtgE3fGFcDWXsui8sGnl3e8ms5zrOZLjzK8QsQo2FqmVf5ghoNydnpwkHXbwue6QSv5RpMIujU40V+f0SnsJQr+RvVi09tuE/Xgh65xzzJZSS+7C+PbmIokZNR8bxtD7UJiGq9CKNZJUuEi/geTvYkleY7FBugzeqekaQbeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762228958; c=relaxed/simple;
	bh=ai311xqe2NwWYwAn1EDtxG6F9OfFgNxqHZJpzvQ6VtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kv6IQcP7Y76zPztB9loC6CiRPZaeT2uQykHLUpv2XPz4xvGcnssVvONiRm12B92/SFv1AEFhSYeoXo1sk23TbbzYweWdn7xSe6dCJ84ZhDfAKhiXS2Mv+385d738Oa0SEzd8rRsyG1xBGW7DNgdDU3JRZ2tJSoJ0OcH2KVL9FdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA7481C2B;
	Mon,  3 Nov 2025 20:02:27 -0800 (PST)
Received: from [10.164.18.64] (unknown [10.164.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1ED3F694;
	Mon,  3 Nov 2025 20:02:28 -0800 (PST)
Message-ID: <2be04785-d725-4e79-a609-87f174271f83@arm.com>
Date: Tue, 4 Nov 2025 09:32:25 +0530
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
 <666e012e-0b13-4def-82de-55ccd5868d36@arm.com>
 <9359ce51-5ac7-4312-8ef8-79fa51d014f5@bytedance.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <9359ce51-5ac7-4312-8ef8-79fa51d014f5@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 03/11/25 2:37 pm, Qi Zheng wrote:
> Hi Dev,
>
> On 11/3/25 4:43 PM, Dev Jain wrote:
>>
>> On 03/11/25 12:33 pm, Qi Zheng wrote:
>>> Hi Dev,
>>>
>>> On 11/3/25 2:37 PM, Dev Jain wrote:
>>>> The implementation of CONFIG_PT_RECLAIM is completely contained in 
>>>> generic
>>>> mm code. It depends on the RCU callback which will reclaim the 
>>>> pagetables -
>>>> there is nothing arch-specific about that. So, enable this config for
>>>> all architectures.
>>>
>>> Thanks for doing this!
>>>
>>> But unfortunately, not all architectures call tlb_remove_ptdesc() in
>>> __pte_free_tlb(). Some architectures directly call pte_free() to
>>> free PTE pages (without RCU).
>>
>> Thanks! This was not obvious to figure out.
>>
>> Is there an arch bottleneck because of which they do this? I mean to 
>> say,
>>
>> is something stopping us from simply redirecting __pte_free_tlb to 
>> tlb_remove_ptdesc
>
> Some architectures have special handling in __pte_free_tlb(), and cannot
> simple redirect __pte_free_tlb() to tlb_remove_ptdesc(), such as m68k,
> powerpc, etc.
>
> For those architectures that call pte_free() in __pte_free_tlb(), it
> should be easy to modify them.
>
> If you're not in a rush, I can take the time to finish the above tasks.

Right then, I'll leave that up to you!


>
>>
>> or pte_free_defer?
>>
>>
>> I am looking to enable this config at least on arm64 by default, I 
>> believe it will be legal
>>
>> to do this at least here.
>
> IIRC, arm64 can directly enable CONFIG_PT_RECLAIM, as it is supported
> at the architecture level.
>
> Thanks,
> Qi
>
>>
>>
>>>
>>> We need to modify these architectures first, otherwise it will
>>> lead to UAF. This approach is feasible because Hugh provides similar
>>> support in pte_free_defer().
>>>
>>> Enabling PT_RECLAIM on all architecture has always been on my
>>> TODO list, but it's been blocked by other things. :(
>>>
>>> Thanks,
>>> Qi
>>>
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>   arch/x86/Kconfig | 1 -
>>>>   mm/Kconfig       | 5 +----
>>>>   mm/pt_reclaim.c  | 2 +-
>>>>   3 files changed, 2 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index fa3b616af03a..5681308a5650 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -327,7 +327,6 @@ config X86
>>>>       select FUNCTION_ALIGNMENT_4B
>>>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>>       select SCHED_SMT            if SMP
>>>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index 0e26f4fc8717..903c37d02555 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>>         The architecture has hardware support for userspace shadow 
>>>> call
>>>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>>   -config ARCH_SUPPORTS_PT_RECLAIM
>>>> -    def_bool n
>>>> -
>>>>   config PT_RECLAIM
>>>>       bool "reclaim empty user page table pages"
>>>>       default y
>>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>> +    depends on MMU && SMP
>>>>       select MMU_GATHER_RCU_TABLE_FREE
>>>>       help
>>>>         Try to reclaim empty user page table pages in paths other 
>>>> than munmap
>>>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>>>> index 7e9455a18aae..049e17f08c6a 100644
>>>> --- a/mm/pt_reclaim.c
>>>> +++ b/mm/pt_reclaim.c
>>>> @@ -1,6 +1,6 @@
>>>>   // SPDX-License-Identifier: GPL-2.0
>>>>   #include <linux/hugetlb.h>
>>>> -#include <asm-generic/tlb.h>
>>>> +#include <asm/tlb.h>
>>>>   #include <asm/pgalloc.h>
>>>>     #include "internal.h"
>>>
>

