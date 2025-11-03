Return-Path: <linux-kernel+bounces-883490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF34C2D97D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B92E4F20D9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E7283FF0;
	Mon,  3 Nov 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsRz6HJR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1041C72
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193189; cv=none; b=m2YiKsRC9zBWdionadOOJMwEw8VSGWALJTbTzyeyQmEyOt6BQeQ14CfHw/va2eMjYSueXnfNWz65CwPpvDpJXJzJZkOpTG0KnAjtt5mm+W1Cs4VFLKmg9ya+v38xL3vkuSu/FpfTFHiMHmy1wdLOOYEG0xujtNyO1GBAX3qobrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193189; c=relaxed/simple;
	bh=AnbfUwPzkbHols+QiT2l5c4xTQZEscZ7pxRKBf3sdYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDrKDg2+8Mt53VXoko7TXhjRSjXxNC3wz0hFeGLhXc3hYd6dhNAQpO0ICIz1zkidPU+tglpqCUpUXRcCTKQ1LZ7qhrn4kpIjWF4Z9KhpZ6RbiInwcX1nMU1HkK3eVTuzAW7/6CSYzsjvv3cMxPdEH9ZEeOqnIC/c0tP1/GY32Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsRz6HJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF47C4CEE7;
	Mon,  3 Nov 2025 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762193188;
	bh=AnbfUwPzkbHols+QiT2l5c4xTQZEscZ7pxRKBf3sdYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qsRz6HJRxpQGx9VQ8+UjPgABTqHGOwBwaVGe22cJ6Ie0R+SJmoWPXMvJ+ypcmAZzL
	 rWRXW0IMFLZ+lQZut8028LHNqCrMNVf3bBB/+9LkBCjPlK6Tqu33AcnclRvzwHZOHb
	 2DBxizgEOHFVrPNl9FgyxyxDg33F4b/Te9VmocyQHmjXU1rCr9TLN64SWohgZtG2lj
	 +0bUCjj14/4gJ30GUDWDRFjnVhYDFhDKdyeMeC0xQyS5ZBBLQU3lEmbSEbgNlTWdKJ
	 10dd568pgIFgTPug9DUhnf1NoCbXqfacF+0+UmPt/MSv23X8H9QBWVf4+wbDN70vUx
	 ZTF30IA6wUplg==
Message-ID: <f6ee43c3-7175-48a5-a483-f89650ce02bc@kernel.org>
Date: Mon, 3 Nov 2025 19:06:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: mm: Don't sleep in split_kernel_leaf_mapping()
 when in atomic context
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, yang@os.amperecomputing.com, ardb@kernel.org,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <groeck@google.com>
References: <20251103125738.3073566-1-ryan.roberts@arm.com>
 <e5fee14a-4569-49c8-9f42-844839e51e85@kernel.org>
 <8df1d593-f176-422d-8b87-844986ac38a6@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <8df1d593-f176-422d-8b87-844986ac38a6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03.11.25 18:28, Ryan Roberts wrote:
> On 03/11/2025 15:38, David Hildenbrand (Red Hat) wrote:
>>
>>>    }
>>>
>>> +static inline bool force_pte_mapping(void)
>>> +{
>>> +    bool bbml2 = system_capabilities_finalized() ?
>>> +        system_supports_bbml2_noabort() : cpu_supports_bbml2_noabort();
>>
>> You are only moving this function. Still, there is some room for improvement I
>> want to point out :)
>>
>> bbml2 could be a const (or a helper function like bbml2_supported).
>>
>>> +
>>> +    return (!bbml2 && (rodata_full || arm64_kfence_can_set_direct_map() ||
>>> +               is_realm_world())) ||
>>> +        debug_pagealloc_enabled();
>>
>>
>> I suspect this could be made a bit easier to read.
>>
>>      if (debug_pagealloc_enabled())
>>          return true;
>>      if (bbml2)
>>          return false;
>>      return rodata_full || arm64_kfence_can_set_direct_map() || is_realm_world();
> 
> Yeah, I guess that's a bit nicer. I'd prefer to tidy it up in as separate commit
> though. (feel free ;-) )

Separate commit is fine (hoping you can do it once this lands :P ).

> 
>>
>>
>>> +}
>>> +
>>>    static DEFINE_MUTEX(pgtable_split_lock);
>>>
>>>    int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>>> @@ -723,6 +733,16 @@ int split_kernel_leaf_mapping(unsigned long start,
>>> unsigned long end)
>>>        if (!system_supports_bbml2_noabort())
>>>            return 0;
>>>
>>> +    /*
>>> +     * If the region is within a pte-mapped area, there is no need to try to
>>> +     * split. Additionally, CONFIG_DEBUG_PAGEALLOC and CONFIG_KFENCE may
>>> +     * change permissions from softirq context so for those cases (which are
>>> +     * always pte-mapped), we must not go any further because taking the
>>> +     * mutex below may sleep.
>>> +     */
>>> +    if (force_pte_mapping() || is_kfence_address((void *)start))
>>> +        return 0;
>>> +
>>
>> We're effectively performing two system_supports_bbml2_noabort() checks,
>> similarly in
>> arch_kfence_init_pool().
>>
>> I wonder if there is a clean way to avoid that.
> 
> I thought about this too. But system_supports_bbml2_noabort() is actually a
> magic alternatives patching thing; 

Makes sense, so likely just another nop in the final code.

> the code is updated so it's zero overhead. I
> decided this was the simplest and clearest way to do it. But I'm open to other
> ideas...

Given that we have two such call sequences, I was wondering if we could 
have a helper that better expresses+documents the desired semantics.

static bool pte_leaf_split_possible()
{
	/*
	 * !BBML2_NOABORT systems should never run into scenarios where
          * we would have to split. So exit early and let calling code
	 * detect it + raise a warning.
	 */
	if (!system_supports_bbml2_noabort())
		return false;
	return force_pte_mapping();
}

Something like that maybe.

-- 
Cheers

David

