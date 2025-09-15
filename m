Return-Path: <linux-kernel+bounces-817179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7926EB57EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A719A189B011
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874132A83F;
	Mon, 15 Sep 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RMtWfSvN"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1968327A0C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946424; cv=none; b=IvnqomoZtXNIlyeeYvvSZ4TC0BqYPCwHTzc9iWvlvo5xiap9hXHWTbb3sL7kw2gE132p0U1VWYu+qwiIkPUiwv8T1+L+1evWo4vkOD0OUSPkBsFkWfyAhrgRIh2eRg42xsbCMdz7nbAILh0bLgmzWaHlRuBRtA49X/WfcEG4LFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946424; c=relaxed/simple;
	bh=4kDRsdMHX+x78ly2T+SWI794hARsVpUs1q8YjwbxA9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+bnSE+UKscdYf/a1QM/ocn+EP1u6w7GyXNJN1UKdw1vF+A1RexsuI9kkPNaP5pH/QA1uTjcZfXm/VrsKSrzE/2VESSHNetFlhRnEcd1Jz4/ysUIZM0c3DaknbZGPqtS0L/Wex8YHNWR9nlTG2ePKK4TPGjZn4S/uUQj/tHPV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RMtWfSvN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ee7a430-f92d-409b-89a8-f084605eda98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757946419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAWgOkmD5YFn/glj5ESxRFYtDt9wouSNosBxkMLToC4=;
	b=RMtWfSvN2qkTyq23TvknU+5jvUqth0eJ3sjEEUmnn10qqNEr6tx9r+h0yY6RMyv1kCk0r4
	zIyPO366ZYwoY+5zfGRmEq3DkpIg3KMU79RepORdOGYx5bnKvzJ05r4u3mgoznxoLYHDSH
	2oZZ2LDu6Zv8X1czsurKsRzk4EJeSoY=
Date: Mon, 15 Sep 2025 22:26:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new 2/3] mm: clean up and expose is_guard_pte_marker()
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Kairui Song <kasong@tencent.com>
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-3-lance.yang@linux.dev>
 <a0133269-82dc-4249-bb78-202b44a4a25e@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <a0133269-82dc-4249-bb78-202b44a4a25e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Lorenzo,

Thanks for taking time to review!

On 2025/9/15 21:54, Lorenzo Stoakes wrote:
> On Sun, Sep 14, 2025 at 10:35:46PM +0800, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> is_guard_pte_marker() performs a redundant check because it calls both
>> is_pte_marker() and is_guard_swp_entry(), both of which internally check
>> for a PTE marker.
>>
>> is_guard_pte_marker()
>>   |- is_pte_marker()
>>   |   `- is_pte_marker_entry()  // First check
>>   `- is_guard_swp_entry()
>>       `- is_pte_marker_entry()  // Second, redundant check
>>
> 
> I mean, it expands to:
> 
> is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte)) &&
> is_pte_marker_entry(pte_to_swp_entry(pte))

Yes, that's a much clearer way to lay it out ;)

> 
> So I don't think it's really unreasonable to expect compiler magic here...
> 
> But you're right that I should have just used is_swap_pte() really, it's a bit
> silly not to, so this is fine :)

Exactly. Glad we're on the same page!

> 
>> While a modern compiler could likely optimize this away, let's have clean
>> code and not rely on it ;)
> 
> Please don't put smileys in commit messages :) as cute as they are, this is
> going on the permanent kernel record and while we all love them, it's
> probably not the best place to put them :P
> 
>>
>> Also, make it available for hugepage collapsing code.
> 
> Nit but put a newline after this.

Got it. Will fix up all nits in v2.

> 
> I think probably if I'm really really nitty I'd say that you should put
> this bit first, as it's the primary motivation for the change, and put the
> refactoring stuff after.

Ah, right. The motivation for exposing the helper should come first. I'll
reorder this changelog in v2.

> 
>> Cc: Kairui Song <kasong@tencent.com>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> 
> This seems fine to me, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks,
Lance

> 
>> ---
>>   include/linux/swapops.h | 6 ++++++
>>   mm/madvise.c            | 6 ------
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
>> index 59c5889a4d54..7f5684fa043b 100644
>> --- a/include/linux/swapops.h
>> +++ b/include/linux/swapops.h
>> @@ -469,6 +469,12 @@ static inline int is_guard_swp_entry(swp_entry_t entry)
>>   		(pte_marker_get(entry) & PTE_MARKER_GUARD);
>>   }
>>
>> +static inline bool is_guard_pte_marker(pte_t ptent)
>> +{
>> +	return is_swap_pte(ptent) &&
>> +	       is_guard_swp_entry(pte_to_swp_entry(ptent));
>> +}
>> +
>>   /*
>>    * This is a special version to check pte_none() just to cover the case when
>>    * the pte is a pte marker.  It existed because in many cases the pte marker
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 35ed4ab0d7c5..bd46e6788fac 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -1069,12 +1069,6 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
>>   	return !(vma->vm_flags & disallowed);
>>   }
>>
>> -static bool is_guard_pte_marker(pte_t ptent)
>> -{
>> -	return is_pte_marker(ptent) &&
>> -		is_guard_swp_entry(pte_to_swp_entry(ptent));
>> -}
>> -
>>   static int guard_install_pud_entry(pud_t *pud, unsigned long addr,
>>   				   unsigned long next, struct mm_walk *walk)
>>   {
>> --
>> 2.49.0
>>


