Return-Path: <linux-kernel+bounces-883442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57249C2D7A6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28623B5581
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1004531C567;
	Mon,  3 Nov 2025 17:28:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542431BCA6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190916; cv=none; b=BE8PG61lBG9y9m0LsxokdQ1J0bQocvPV/WFPfOGEw0RDOm3Y9JTC71rYVkTgeZx+DyE7LDc4wQgqoeK8FiEIwGy5p7E/x+7O3zFmeyVE1/khB7/OofPcClByqFG5jfdFtOvIvzzu/vPDeYHWIpLVIXK2VVyXaEH0GJYXtTBa8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190916; c=relaxed/simple;
	bh=XJ3Joz1OS/b9of1XvQ75wTEjgPyHbknmik2lIvoZM9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWwJwtYCDapcGV+6jAMpD2k9Joiy+YiC5nmZZlniXRhb6TzltepzBzh3MSYJAeWJcZjp7skjchzrcZlzKH3UUg/F5cwJ4lguFQ7yJR4OsSw/NvqmcjQVmAhWxdGkoTDg5+auGkhpohryvBP93/Z11HdRbj9QtB54Y8gCEa5NyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9ED11D14;
	Mon,  3 Nov 2025 09:28:26 -0800 (PST)
Received: from [10.1.36.161] (XHFQ2J9959.cambridge.arm.com [10.1.36.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B00D83F66E;
	Mon,  3 Nov 2025 09:28:32 -0800 (PST)
Message-ID: <8df1d593-f176-422d-8b87-844986ac38a6@arm.com>
Date: Mon, 3 Nov 2025 17:28:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: mm: Don't sleep in split_kernel_leaf_mapping()
 when in atomic context
Content-Language: en-GB
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 catalin.marinas@arm.com, will@kernel.org, yang@os.amperecomputing.com,
 ardb@kernel.org, dev.jain@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@google.com>
References: <20251103125738.3073566-1-ryan.roberts@arm.com>
 <e5fee14a-4569-49c8-9f42-844839e51e85@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e5fee14a-4569-49c8-9f42-844839e51e85@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/11/2025 15:38, David Hildenbrand (Red Hat) wrote:
> 
>>   }
>>
>> +static inline bool force_pte_mapping(void)
>> +{
>> +    bool bbml2 = system_capabilities_finalized() ?
>> +        system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
> 
> You are only moving this function. Still, there is some room for improvement I
> want to point out :)
> 
> bbml2 could be a const (or a helper function like bbml2_supported).
> 
>> +
>> +    return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
>> +               is_realm_world())) ||
>> +        debug_pagealloc_enabled();
> 
> 
> I suspect this could be made a bit easier to read.
> 
>     if (debug_pagealloc_enabled())
>         return true;
>     if (bbml2)
>         return false;
>     return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();

Yeah, I guess that's a bit nicer. I'd prefer to tidy it up in as separate commit
though. (feel free ;-) )

> 
> 
>> +}
>> +
>>   static DEFINE_MUTEX(pgtable_split_lock);
>>
>>   int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>> @@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start,
>> unsigned long end)
>>       if (!system_supports_bbml2_noabort())
>>           return 0;
>>
>> +    /*
>> +     * If the region is within a pte-mapped area, there is no need to try to
>> +     * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
>> +     * change permissions from softirq context so for those cases (which are
>> +     * always pte-mapped), we must not go any further because taking the
>> +     * mutex below may sleep.
>> +     */
>> +    if (force_pte_mapping() || is_kfence_address((void *)start))
>> +        return 0;
>> +
> 
> We're effectively performing two system_supports_bbml2_noabort() checks,
> similarly in
> arch_kfence_init_pool().
> 
> I wonder if there is a clean way to avoid that.

I thought about this too. But system_supports_bbml2_noabort() is actually a
magic alternatives patching thing; the code is updated so it's zero overhead. I
decided this was the simplest and clearest way to do it. But I'm open to other
ideas...

> 
> I'm not super up-to-date on that code. Nothing else jumped at me.

Thanks for the review!

> 


