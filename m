Return-Path: <linux-kernel+bounces-884773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FAC3115C
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A50734EA566
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AC20C461;
	Tue,  4 Nov 2025 12:52:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96786329
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260763; cv=none; b=SmHenw4CNriorbifPh09yth9MZsxIxsbZlQurDvuZ7uBtG4JB8YCDrZxLSH//fS1dMzIyyrqCQTUQnqUwSptw8ZmoKvJFlZeR47uV1mcigkHwETo8KLD6F+C5sJfxBCpH0O0jxvwOd9/M+aCsHDpLFJrsQyHu1TUTBDA2a2xPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260763; c=relaxed/simple;
	bh=VXB+TQzWrma6Zyeo2qk0CF6LZtfJ8NizQTHO2rPz/uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iy4PMlcEyqf5KT9LKsBE9bm8lCProOLz7flH+f/+4yG1gy3vlKKnnaQo+OB36NczrMb9PH8QVisGKVeUaqRI8ffjIwx9+8eXT7V/+qyQhfU99O8EtW9D80RnIVM+NFhWzWtec4cl5Za6J/KsJ3d3i4hiAnFReiyABcyYlh9vk2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7286F1CE0;
	Tue,  4 Nov 2025 04:52:26 -0800 (PST)
Received: from [10.1.31.224] (XHFQ2J9959.cambridge.arm.com [10.1.31.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 734283F66E;
	Tue,  4 Nov 2025 04:52:32 -0800 (PST)
Message-ID: <cd64b1b6-4d5c-49f4-b87a-29c39bc33652@arm.com>
Date: Tue, 4 Nov 2025 12:52:30 +0000
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
To: Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, yang@os.amperecomputing.com, david@redhat.com,
 ardb@kernel.org, dev.jain@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <groeck@google.com>
References: <20251103125738.3073566-1-ryan.roberts@arm.com>
 <aQjMUhspJrRQn5Ew@willie-the-truck>
 <3611cfeb-53d5-4db5-95a1-1d095edfc3c9@arm.com>
 <aQn0ZqCPSA61QmDI@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aQn0ZqCPSA61QmDI@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2025 12:41, Will Deacon wrote:
> Hey Ryan,
> 
> On Mon, Nov 03, 2025 at 04:28:44PM +0000, Ryan Roberts wrote:
>> On 03/11/2025 15:37, Will Deacon wrote:
>>> On Mon, Nov 03, 2025 at 12:57:37PM +0000, Ryan Roberts wrote:
>>>> +static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	arch_enter_lazy_mmu_mode();
>>>> +	ret = walk_kernel_page_table_range_lockless(start, end,
>>>> +					&split_to_ptes_ops, NULL, &gfp);
>>>> +	arch_leave_lazy_mmu_mode();
>>>
>>> Why are you entering/leaving lazy mode now? linear_map_split_to_ptes()
>>> calls flush_tlb_kernel_range() right after this so now it looks like
>>> we have more barriers than we need there.
>>
>> Without the lazy mmu block, every write to every pte (or pmd/pud) will cause a
>> dsb and isb to be emitted. With the lazy mmu block, we only emit a single
>> dsb/isb at the end of the block.
>>
>> linear_map_split_to_ptes() didn't previously have a lazy mmu block; that was an
>> oversight, I believe. So when refactoring I thought it made sense to make it
>> common for both cases.
>>
>> Yes, the flush_tlb_kernel_range() also has the barriers, so the lazy mmu mode is
>> reducing from a gazillion barriers to 2. We could further optimize from 2 to 1,
>> but I doubt the performance improvement will be measurable.
>>
>> Perhaps I've misunderstood your point...?
> 
> I was just trying to understand whether this was a functional thing (which
> I couldn't grok) or an optimisation. Sounds like it's the latter, but I'd
> prefer not to mix optimisations with fixes.

Ahh, yes fair enough. I'll send out a new version either tomorrow or Thursday.
In that I'll include 3 separate patches; the fix, this optimization and the tidy
up that David suggested. Ideally all 3 will go to 6.18, but if you only want to
push the fix to 6.18 and leave the rest for 6.19 fair enough.

Thanks,
Ryan

> 
> Will


