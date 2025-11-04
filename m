Return-Path: <linux-kernel+bounces-884807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD0C31320
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9E63AE45D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5396B320CB5;
	Tue,  4 Nov 2025 13:21:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF367320A29
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262478; cv=none; b=LQqltTgmOWtaBEg9me347DBaz+3WaSXdi2vi1UX/K8a8xPY+wNxkMpaiBdk2L/G6al+8exiy6TC6IegNILeFGbuEZTMD6MD3poKzFEG3EPLV+nxht2bCmAnMe6M9laAtG0fRw00WCw2zIs90G25kjWPDUwnfyHnfBK1Al11M/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262478; c=relaxed/simple;
	bh=ZszWIcep5j8BMARO1YZ7AX2+22qA9IuN2AzHj9fLZRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7RBBSUnOlSw0C/g1034BtpTkTLFTw9swvYdaipsTa4nETca0Gi8DdBTIW409E8zFIaROvpc1I3bWx4ooMaZKp7ZDX8ayOasoKClbjbobOjh8IRXZaeeY4nIKMMIHIcfPT99YQbrl7b8hHxSYqZVEBYHMUeb9u1BgwEoutq8YSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BE1D1CE0;
	Tue,  4 Nov 2025 05:21:08 -0800 (PST)
Received: from [10.164.18.64] (unknown [10.164.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2E9C3F66E;
	Tue,  4 Nov 2025 05:21:08 -0800 (PST)
Message-ID: <d51ecac7-d67b-4da0-babe-a65aaf9293d0@arm.com>
Date: Tue, 4 Nov 2025 18:51:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable CONFIG_PT_RECLAIM on all architectures
To: Lance Yang <ioworker0@gmail.com>, zhengqi.arch@bytedance.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, david@redhat.com,
 hannes@cmpxchg.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mhocko@suse.com,
 mingo@redhat.com, ppt@kernel.org, ryan.roberts@arm.com,
 shakeel.butt@linux.dev, surenb@google.com, tglx@linutronix.de,
 vbabka@suse.cz, will@kernel.org, x86@kernel.org,
 Lance Yang <lance.yang@linux.dev>
References: <827b647d-798f-4775-bb31-ef735485c6bb@bytedance.com>
 <20251104131348.32332-1-ioworker0@gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20251104131348.32332-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/11/25 6:43 pm, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
>
> On Tue, 4 Nov 2025 14:33:00 +0800, Qi Zheng wrote:
>>
>> On 11/4/25 12:02 PM, Dev Jain wrote:
>>> On 03/11/25 2:37 pm, Qi Zheng wrote:
>>>> Hi Dev,
>>>>
>>>> On 11/3/25 4:43 PM, Dev Jain wrote:
>>>>> On 03/11/25 12:33 pm, Qi Zheng wrote:
>>>>>> Hi Dev,
>>>>>>
>>>>>> On 11/3/25 2:37 PM, Dev Jain wrote:
>>>>>>> The implementation of CONFIG_PT_RECLAIM is completely contained in
>>>>>>> generic
>>>>>>> mm code. It depends on the RCU callback which will reclaim the
>>>>>>> pagetables -
>>>>>>> there is nothing arch-specific about that. So, enable this config for
>>>>>>> all architectures.
>>>>>> Thanks for doing this!
>>>>>>
>>>>>> But unfortunately, not all architectures call tlb_remove_ptdesc() in
>>>>>> __pte_free_tlb(). Some architectures directly call pte_free() to
>>>>>> free PTE pages (without RCU).
>>>>> Thanks! This was not obvious to figure out.
>>>>>
>>>>> Is there an arch bottleneck because of which they do this? I mean to
>>>>> say,
>>>>>
>>>>> is something stopping us from simply redirecting __pte_free_tlb to
>>>>> tlb_remove_ptdesc
>>>> Some architectures have special handling in __pte_free_tlb(), and cannot
>>>> simple redirect __pte_free_tlb() to tlb_remove_ptdesc(), such as m68k,
>>>> powerpc, etc.
>>>>
>>>> For those architectures that call pte_free() in __pte_free_tlb(), it
>>>> should be easy to modify them.
>>>>
>>>> If you're not in a rush, I can take the time to finish the above tasks.
>>> Right then, I'll leave that up to you!
>> OK, I will do it ASAP.
> Cool! Looking forward to seeing that land ;p
>
> Cheers,
> Lance
>
>>>
>>>>> or pte_free_defer?
>>>>>
>>>>>
>>>>> I am looking to enable this config at least on arm64 by default, I
>>>>> believe it will be legal
> Great proposal, Dev! That looks like a very useful feature. Let's make it
> happen on arm64 ;)

Yup, but not sure whether an arm64 enabling patch, only for that to go away
when Qi implements the feature generically, is worth the trouble!

>
>>>>> to do this at least here.
>>>> IIRC, arm64 can directly enable CONFIG_PT_RECLAIM, as it is supported
>>>> at the architecture level.
>>>>
>>>> Thanks,
>>>> Qi
>>>>
>>>>>
>>>>>> We need to modify these architectures first, otherwise it will
>>>>>> lead to UAF. This approach is feasible because Hugh provides similar
>>>>>> support in pte_free_defer().
>>>>>>
>>>>>> Enabling PT_RECLAIM on all architecture has always been on my
>>>>>> TODO list, but it's been blocked by other things. :(
>>>>>>
>>>>>> Thanks,
>>>>>> Qi
>>>>>>
>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>> ---
>>>>>>>    arch/x86/Kconfig | 1 -
>>>>>>>    mm/Kconfig       | 5 +----
>>>>>>>    mm/pt_reclaim.c  | 2 +-
>>>>>>>    3 files changed, 2 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>>>> index fa3b616af03a..5681308a5650 100644
>>>>>>> --- a/arch/x86/Kconfig
>>>>>>> +++ b/arch/x86/Kconfig
>>>>>>> @@ -327,7 +327,6 @@ config X86
>>>>>>>        select FUNCTION_ALIGNMENT_4B
>>>>>>>        imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>>>>>        select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>>>>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>>>>>        select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>>>>>        select SCHED_SMT            if SMP
>>>>>>>        select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>>> index 0e26f4fc8717..903c37d02555 100644
>>>>>>> --- a/mm/Kconfig
>>>>>>> +++ b/mm/Kconfig
>>>>>>> @@ -1355,13 +1355,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>>>>>          The architecture has hardware support for userspace shadow
>>>>>>> call
>>>>>>>              stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>>>>>    -config ARCH_SUPPORTS_PT_RECLAIM
>>>>>>> -    def_bool n
>>>>>>> -
>>>>>>>    config PT_RECLAIM
>>>>>>>        bool "reclaim empty user page table pages"
>>>>>>>        default y
>>>>>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>>>>> +    depends on MMU && SMP
>>>>>>>        select MMU_GATHER_RCU_TABLE_FREE
>>>>>>>        help
>>>>>>>          Try to reclaim empty user page table pages in paths other
>>>>>>> than munmap
>>>>>>> diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
>>>>>>> index 7e9455a18aae..049e17f08c6a 100644
>>>>>>> --- a/mm/pt_reclaim.c
>>>>>>> +++ b/mm/pt_reclaim.c
>>>>>>> @@ -1,6 +1,6 @@
>>>>>>>    // SPDX-License-Identifier: GPL-2.0
>>>>>>>    #include <linux/hugetlb.h>
>>>>>>> -#include <asm-generic/tlb.h>
>>>>>>> +#include <asm/tlb.h>
>>>>>>>    #include <asm/pgalloc.h>
>>>>>>>      #include "internal.h"
>>

