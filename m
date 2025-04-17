Return-Path: <linux-kernel+bounces-608721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E07A91730
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 11:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51A223BF3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 09:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350B2139A4;
	Thu, 17 Apr 2025 09:03:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC2199E9A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880590; cv=none; b=Xhl2QpayXTYRLis8xuivXQ/44HRH4RHM/DZ4GG0x//z+2/lmgSY9IMZL9mMktGR7hrg4DreEsjfKQZxGwXDo7SWC80uqBh5m3aAXWfj1a2UYcPZnspw4CuI7XwkihNz31YrpItoqyJbdSyCy4AsH/pHfwj5xcUfHqhy5h64M0do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880590; c=relaxed/simple;
	bh=chPNgJWlAJIYfoVhPSe8B7wibkLIdRt+TN7BeZpBL3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4j4HUAMP+WXfV4KrW+Dty9RPRt4YTqAwrnDdxg3COMJ5PXA4sp+0Jb4Bn4+RP1QKyvE6LxO3t1KWQdqnXStNv9saFgURed6fku+678OJbyRzR1Q+SwppqbPjG/V+3NNbhZe/4CWG0eptS3hSDSU362VHAp3pofIyHL/pEAohxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1DAB1516;
	Thu, 17 Apr 2025 02:02:58 -0700 (PDT)
Received: from [10.163.48.140] (unknown [10.163.48.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B3C13F59E;
	Thu, 17 Apr 2025 02:02:57 -0700 (PDT)
Message-ID: <ac7b1117-76cc-4eac-8975-f0dc3cbbe398@arm.com>
Date: Thu, 17 Apr 2025 14:32:55 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Support ARM64_VA_BITS=52 when setting
 ARCH_MMAP_RND_BITS_MAX
To: =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steve Capper <steve.capper@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, ssradjacoumar@google.com,
 chromeos-krk-upstreaming@google.com
References: <20250403183638.3386628-1-korneld@google.com>
 <38049b58-a504-4223-9f6d-537609931fb4@arm.com>
 <CACF_fqnevOo9NSRwDAh7KVQZTHTkP0pc2NKEXrWFapMYLf0Wkw@mail.gmail.com>
 <6f1af7bf-a354-4b90-bf82-edc8cc6e71fe@arm.com>
 <CACF_fq=yFLUO2P0qrZFizUJe8J2FGYUK7w3DykKL3x7_R87UQA@mail.gmail.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CACF_fq=yFLUO2P0qrZFizUJe8J2FGYUK7w3DykKL3x7_R87UQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/17/25 13:38, Kornel Dulęba wrote:
> On Thu, Apr 17, 2025 at 7:15 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 4/4/25 22:16, Kornel Dulęba wrote:
>>> On Thu, Apr 3, 2025 at 11:46 PM Anshuman Khandual
>>> <anshuman.khandual@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 4/4/25 00:06, Kornel Dulęba wrote:
>>>>> When the 52-bit virtual addressing was enabled the select like
>>>>> ARCH_MMAP_RND_BITS_MAX logic was never updated to account for it.
>>>>> Because of that the rnd max bits would be set to the default value of
>>>>> 18 when ARM64_VA_BITS=52.
>>>>> Fix this by setting ARCH_MMAP_RND_BITS_MAX to the same value that would
>>>>> be used if 48-bit addressing was used. That's because the 52-bit
>>>>> addressing is used only if the caller provides a hint to mmap, with a
>>>>> fallback to 48-bit addressing.
>>>>
>>>> Why should ARCH_MMAP_RND_BITS_MAX value be same for both 48 bits and 52
>>>> bits VA in case the user does request for 52 bit VA via mmap() hint and
>>>> the HW supports it ?
>>>
>>> Two reasons really.
>>> 1. The whole behavior is controlled through a global knob -
>>> /proc/sys/vm/mmap_rnd_bits. ARCH_MMAP_RND_BITS_MAX is used as an upper
>>> bound for the value that can be set to that knob.
>>> So we have a single setting for all processes. Some might want 52 bit
>>> addressing, others will stick with 48.
>>> 2. Quoting the documentation for this knob:
>>>
>>> """
>>> mmap_rnd_bits
>>> This value can be used to select the number of bits to use to
>>> determine the random offset to the base address of vma regions
>>> resulting from mmap allocations on architectures which support tuning
>>> address space randomization. This value will be bounded by the
>>> architecture’s minimum and maximum supported values.
>>> """
>>>
>>> I suppose that it's legal for some calls to mmap from the same process
>>> to request a 52 bit VA, while other calls will want only 48 bits.
>>> Because of that the random offset can't be larger than what would work
>>> for the 48 bit case.
>>
>> Agreed but should not this rationale also be added in the commit
>> message as well ?
> 
> Sure, I will update this in v2.
>>
>>
>>>
>>>>
>>>>>
>>>>> Fixes: b6d00d47e81a ("arm64: mm: Introduce 52-bit Kernel VAs")
>>
>> Correct commit to be attributed for this fix.
> 
> What commit would you like me to point at? I selected b6d00d47e81a,
> because it introduced "ARM64_VA_BITS=52".
> Looking at git blame, ARCH_MMAP_RND_BITS_MAX logic was introduced back
> in 2016 in 8f0d3aa9de57 ("arm64: mm: support ARCH_MMAP_RND_BITS"),
> which is before "ARM64_VA_BITS=52" was a thing.
> I suppose that there's also 3cb7e662a930 ("arm64: Kconfig: Fix
> indentation and add comments"), but that's just some whitespace
> adjustments.

It was just a statement confirming that the commit ID chosen here in
this patch is the right one indeed. Apologies for the confusion.

> 
>>
>>
>>>>> Signed-off-by: Kornel Dulęba <korneld@google.com>
>>>>> ---
>>>>>  arch/arm64/Kconfig | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>> index 748c34dc953c..38e0bac567f5 100644
>>>>> --- a/arch/arm64/Kconfig
>>>>> +++ b/arch/arm64/Kconfig
>>>>> @@ -332,9 +332,9 @@ config ARCH_MMAP_RND_BITS_MAX
>>>>>       default 24 if ARM64_VA_BITS=39
>>>>>       default 27 if ARM64_VA_BITS=42
>>>>>       default 30 if ARM64_VA_BITS=47
>>>>> -     default 29 if ARM64_VA_BITS=48 && ARM64_64K_PAGES
>>>>> -     default 31 if ARM64_VA_BITS=48 && ARM64_16K_PAGES
>>>>> -     default 33 if ARM64_VA_BITS=48
>>>>> +     default 29 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_64K_PAGES
>>>>> +     default 31 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52) && ARM64_16K_PAGES
>>>>> +     default 33 if (ARM64_VA_BITS=48 || ARM64_VA_BITS=52)
>>>>>       default 14 if ARM64_64K_PAGES
>>>>>       default 16 if ARM64_16K_PAGES
>>>>>       default 18
>>
>> Otherwise LGTM.
>>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

