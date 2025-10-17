Return-Path: <linux-kernel+bounces-858343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9856BBEA6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44744586877
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467C61A0728;
	Fri, 17 Oct 2025 15:50:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37A330B20
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716220; cv=none; b=djumVi0aI2tSghLomzKNZUYcUjsAT5O4H6834LGttElaOfpS21bptAWJUK6HnBnGiVl6vSaFDWNfUC+3qOzX4Gzg4UNWBgbQch6u0mvKS9ROMD2FECUz/XD0vM35EM0/j3Mj+bu1LrciH8qPF8Ra0S+rpLq4dlniVxk61U1ZOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716220; c=relaxed/simple;
	bh=wWWU0Gyd+dk7dAb3argi3LBrZh2fIuZUjix4Eb0LtYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XApT5+uqW5lLt1wi4BzMDq3Xi0ld2GuT3JAnao2lnEy4IUu6Pl9hQYjvS6QX9fWdSFqJk/VM5Oq86X5/gLbu1Tqu5un4Zjq+bEa+SvCD/GjkemPejI1cx4Uz56kfSrl9r8okddxdcKUih0PifkWrv2IUibYFFc+4meMdhkEXz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 722161595;
	Fri, 17 Oct 2025 08:50:09 -0700 (PDT)
Received: from [10.163.68.204] (unknown [10.163.68.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5A7C3F66E;
	Fri, 17 Oct 2025 08:50:14 -0700 (PDT)
Message-ID: <ceae80d4-ae63-4bf7-bf97-1d6b5b090aad@arm.com>
Date: Fri, 17 Oct 2025 21:20:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: mm: relax VM_ALLOW_HUGE_VMAP if BBML2_NOABORT
 is supported
To: Yang Shi <yang@os.amperecomputing.com>, ryan.roberts@arm.com,
 cl@gentwo.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-3-yang@os.amperecomputing.com>
 <eaa67b0d-e256-4db6-82e7-c4d56df70c09@arm.com>
 <05331884-9723-48ff-a3ce-c2ea023bbabd@os.amperecomputing.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <05331884-9723-48ff-a3ce-c2ea023bbabd@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 17/10/25 12:20 am, Yang Shi wrote:
>
>
> On 10/14/25 11:50 PM, Dev Jain wrote:
>>
>> On 14/10/25 4:57 am, Yang Shi wrote:
>>> When changing permissions for vmalloc area, VM_ALLOW_HUGE_VMAP area is
>>> exclueded because kernel can't split the va mapping if it is called on
>>> partial range.
>>> It is no longer true if the machines support BBML2_NOABORT after commit
>>> a166563e7ec3 ("arm64: mm: support large block mapping when 
>>> rodata=full").
>>> So we can relax this restriction and update the comments accordingly.
>>>
>>> Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when 
>>> rodata=full")
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   arch/arm64/mm/pageattr.c | 13 +++++++------
>>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>> index c21a2c319028..b4dcae6273a8 100644
>>> --- a/arch/arm64/mm/pageattr.c
>>> +++ b/arch/arm64/mm/pageattr.c
>>> @@ -157,13 +157,13 @@ static int change_memory_common(unsigned long 
>>> addr, int numpages,
>>>         /*
>>>        * Kernel VA mappings are always live, and splitting live section
>>> -     * mappings into page mappings may cause TLB conflicts. This means
>>> -     * we have to ensure that changing the permission bits of the 
>>> range
>>> -     * we are operating on does not result in such splitting.
>>> +     * mappings into page mappings may cause TLB conflicts on the 
>>> machines
>>> +     * which don't support BBML2_NOABORT.
>>>        *
>>>        * Let's restrict ourselves to mappings created by vmalloc (or 
>>> vmap).
>>> -     * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only 
>>> page
>>> -     * mappings are updated and splitting is never needed.
>>> +     * Disallow VM_ALLOW_HUGE_VMAP mappings if the systems don't 
>>> support
>>> +     * BBML2_NOABORT to guarantee that only page mappings are 
>>> updated and
>>> +     * splitting is never needed on those machines.
>>>        *
>>>        * So check whether the [addr, addr + size) interval is entirely
>>>        * covered by precisely one VM area that has the VM_ALLOC flag 
>>> set.
>>> @@ -171,7 +171,8 @@ static int change_memory_common(unsigned long 
>>> addr, int numpages,
>>>       area = find_vm_area((void *)addr);
>>>       if (!area ||
>>>           end > (unsigned long)kasan_reset_tag(area->addr) + 
>>> area->size ||
>>> -        ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
>>> +        !(area->flags & VM_ALLOC) || ((area->flags & 
>>> VM_ALLOW_HUGE_VMAP) &&
>>> +        !system_supports_bbml2_noabort()))
>>>           return -EINVAL;
>>>         if (!numpages)
>>
>> This will conflict with my upcoming vmalloc-huge series, so best to 
>> leave it to me,
>> I already have this included :)
>
> My point is that I hope this can be merged as a hotfix for 6.18. I 
> have no strong opinion on either the maintainers take this one or from 
> your series. But if this will go into 6.18 as a hotfix, it should be 
> also a prerequisite patch (standalone)  in your series, and the rest 
> of your series should be based on top of it. Of course this argument 
> will not stand if we don't care to have it fixed for 6.18.

I see what you mean, but I don't think this patch should be treated as a 
hotfix. We forgot to relax a

restriction - that's fine. That is not an incorrectness in the linear 
map series. A fix usually

fixes an incorrectness.


>
> Thanks,
> Yang
>
>

