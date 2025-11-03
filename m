Return-Path: <linux-kernel+bounces-882298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E429C2A1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20F0D4E1BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8921028C871;
	Mon,  3 Nov 2025 05:53:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4771285CAE
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762149228; cv=none; b=sjY8CSY9Qx5ExfkjX5OawLzMEXvN9mzXVKr0zUODtGB2SljxJc9ESWQV9nWoPZPZ16H9oOtNcOwDpVmWauoSbHyFoAjbxF+abRCYc9YC/5sIAPoajepv4qW+mc+LFo7wSYdNWd7k1sY7v1ocxZF2hnYyli5BCGfOEwcVLP9GWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762149228; c=relaxed/simple;
	bh=2A6MEl0+oN8/SiQNDoN7HkDimNG6pp7ZcpCwW+XB1MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IET657MHMYIrEQcCMIS0NyuY3IxIkjrsJfvhp3nO4hcZpJLg+FfItUtqLFJ8UdXIDCiqPoUTc8Sl1SwkGdOhY/qM2nEr1O/oN8CG9atAYaK30BOtvZkWYLzW9sMwYCkk/i8BhieJN5WrirTf7j3EEuWRYdc4ZHDLZR42ZiGcJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D80F28FA;
	Sun,  2 Nov 2025 21:53:38 -0800 (PST)
Received: from [10.164.136.41] (unknown [10.164.136.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BEB33F694;
	Sun,  2 Nov 2025 21:53:40 -0800 (PST)
Message-ID: <4bc562ea-2fba-4484-9548-c606e254bc00@arm.com>
Date: Mon, 3 Nov 2025 11:23:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/5] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, Guenter Roeck <linux@roeck-us.net>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@redhat.com, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, nd@arm.com
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
 <20250917190323.3828347-4-yang@os.amperecomputing.com>
 <f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net>
 <933a2eff-1e06-451e-9994-757d66f4b985@arm.com>
 <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <bee6b93d-aa2e-4335-9801-89f02eb3eccc@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>>>
>>> With lock debugging enabled, we see a large number of "BUG: sleeping
>>> function called from invalid context at kernel/locking/mutex.c:580"
>>> and "BUG: Invalid wait context:" backtraces when running v6.18-rc3.
>>> Please see example below.
>>>
>>> Bisect points to this patch.
>>>
>>> Please let me know if there is anything I can do to help tracking
>>> down the problem.
>> Thanks for the report - ouch!
>>
>> I expect you're running on a system that supports BBML2_NOABORT, based on the
>> stack trace, I expect you have CONFIG_DEBUG_PAGEALLOC enabled? That will cause
>> permission tricks to be played on the linear map at page allocation and free
>> time, which can happen in non-sleepable contexts. And with this patch we are
>> taking pgtable_split_lock (a mutex) in split_kernel_leaf_mapping(), which is
>> called as a result of the permission change request.
>>
>> However, when CONFIG_DEBUG_PAGEALLOC enabled we always force-map the linear map
>> by PTE so split_kernel_leaf_mapping() is actually unneccessary and will return
>> without actually having to split anything. So we could add an early "if
>> (force_pte_mapping()) return 0;" to bypass the function entirely in this case,
>> and I *think* that should solve it.
>>
>> But I'm also concerned about KFENCE. I can't remember it's exact semantics off
>> the top of my head, so I'm concerned we could see similar problems there (where
>> we only force pte mapping for the KFENCE pool).
>>
>> I'll investigate fully tomorrow and hopefully provide a fix.
> Here's a proposed fix, although I can't get access to a system with BBML2 until
> tomorrow at the earliest. Guenter, I wonder if you could check that this
> resolves your issue?
>
> ---8<---
> commit 602ec2db74e5abfb058bd03934475ead8558eb72
> Author: Ryan Roberts <ryan.roberts@arm.com>
> Date:   Sun Nov 2 11:45:18 2025 +0000
>
>      arm64: mm: Don't attempt to split known pte-mapped regions
>      
>      It has been reported that split_kernel_leaf_mapping() is trying to sleep
>      in non-sleepable context. It does this when acquiring the
>      pgtable_split_lock mutex, when either CONFIG_DEBUG_ALLOC or
>      CONFIG_KFENCE are enabled, which change linear map permissions within
>      softirq context during memory allocation and/or freeing.
>      
>      But it turns out that the memory for which these features may attempt to
>      modify the permissions is always mapped by pte, so there is no need to
>      attempt to split the mapping. So let's exit early in these cases and
>      avoid attempting to take the mutex.
>      
>      Closes: https://lore.kernel.org/all/f24b9032-0ec9-47b1-8b95-c0eeac7a31c5@roeck-us.net/
>      Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
>      Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index b8d37eb037fc..6e26f070bb49 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -708,6 +708,16 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   	return ret;
>   }
>   
> +static inline bool force_pte_mapping(void)
> +{
> +	bool bbml2 = system_capabilities_finalized() ?
> +		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> +
> +	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> +			   is_realm_world())) ||
> +		debug_pagealloc_enabled();
> +}
> +
>   static DEFINE_MUTEX(pgtable_split_lock);
>   
>   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
> @@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   	if (!system_supports_bbml2_noabort())
>   		return 0;
>   
> +	/*
> +	 * If the region is within a pte-mapped area, there is no need to try to
> +	 * split. Additionally, CONFIG_DEBUG_ALLOC and CONFIG_KFENCE may change

Nit: CONFIG_DEBUG_PAGEALLOC.

> +	 * permissions from softirq context so for those cases (which are always
> +	 * pte-mapped), we must not go any further because taking the mutex
> +	 * below may sleep.
> +	 */
> +	if (force_pte_mapping() || is_kfence_address((void *)start))
> +		return 0;
> +
>   	/*
>   	 * Ensure start and end are at least page-aligned since this is the
>   	 * finest granularity we can split to.
> @@ -1009,16 +1029,6 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
>   
>   #endif /* CONFIG_KFENCE */
>   
> -static inline bool force_pte_mapping(void)
> -{
> -	bool bbml2 = system_capabilities_finalized() ?
> -		system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> -
> -	return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
> -			   is_realm_world())) ||
> -		debug_pagealloc_enabled();
> -}
> -

Otherwise LGTM.

Reviewed-by: Dev Jain <dev.jain@arm.com>

>   static void __init map_mem(pgd_t *pgdp)
>   {
>   	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
> ---8<---
>
> Thanks,
> Ryan
>
>> Yang Shi, Do you have any additional thoughts?
>>
>> Thanks,
>> Ryan
>>

