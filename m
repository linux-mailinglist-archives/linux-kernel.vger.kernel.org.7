Return-Path: <linux-kernel+bounces-854193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5388BBDDCC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E553B54F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FD19D8A7;
	Wed, 15 Oct 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JTr6NNWa"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771430B538
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520691; cv=none; b=U8G7evl29ld6scTs87BC/qFI4ofdRAkSsQJePihL36HRJEN0nD9wavwW/AnWJbbGjkereeGRs7QMVwx6E1wlP87UBfp16dp+akcfAkLGvugsqThnYeRSUscKzEQQ0tucqsb6zGjXR05E94Th+Ixfg3pU8qXqNdp+sphmfAmOnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520691; c=relaxed/simple;
	bh=II+vIPX06UFsA+ssss7IijHXyQ4/Mzv2GZFVxR7WnG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufeBAZuAoPJ1t3o8sofTWnKxVThItmMnbbD/gnGDIqks9P8NUu9Q3b44y2L2HbhjQc62JirrfAZUvtxF57SjJZBp1s9OYjgGsyRWpzeh+Wt20EYoovjWsEIVSjSLp4ooc2ELsh+hibTkVilZqrT6SHCEANX8idwryJDl9snjvvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JTr6NNWa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8dd76501-9e19-4471-86e2-6c4254fd8d42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760520687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWnb6HM59m53HWWkDZ7wJOQ8divhA+pm6fAx1aM0zU=;
	b=JTr6NNWa2wIWtUi5kh6m5VAdhCS9RvVGDXyapvf1sQp+ucujZtSQPW5m9p6vRvoFuHGulp
	93WF7vRxhitiV+c5szfeRiVd/W11D3M9UhKVdaTC8pG9DxIhJKJmLm38UDy17jFHfufNNn
	JVlqIV7/wuygPyJnbY5dSLdV0brBj4A=
Date: Wed, 15 Oct 2025 17:31:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 1/3] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-2-lance.yang@linux.dev>
 <3982686f-908f-4f92-b3ae-e6f141e617ef@lucifer.local>
 <cfbd4f48-69a0-4ba9-bce8-f578d9602125@redhat.com>
 <80771030-0d8d-4f65-803a-f89da3b59796@linux.dev>
 <cc998aee-2a98-45ae-875a-9712d4c29240@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <cc998aee-2a98-45ae-875a-9712d4c29240@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/15 17:16, Lorenzo Stoakes wrote:
> On Wed, Oct 15, 2025 at 12:49:26PM +0800, Lance Yang wrote:
>>
>>
>> On 2025/10/14 20:27, David Hildenbrand wrote:
>>> On 14.10.25 14:17, Lorenzo Stoakes wrote:
>>>> On Wed, Oct 08, 2025 at 12:37:46PM +0800, Lance Yang wrote:
>>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>>
>>>>> As pointed out by Dev, the PTE checks for disjoint conditions in the
>>>>> scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
>>>>> and pte_uffd_wp are mutually exclusive.
>>>>
>>>> But you're not using is_swap_pte anywhere :) This comes back to my review
>>>> quesiotn on the series this is dependent upon.
>>>>
>>>>>
>>>>> This patch refactors the loops in both
>>>>> __collapse_huge_page_isolate() and
>>>>> hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
>>>>> instead of separate if blocks. While at it, the redundant pte_present()
>>>>> check before is_zero_pfn() is also removed.
>>>>
>>>> I mean see review below, I don't see why you're doing this and I am
>>>> unconvinced by how redundant that check is.
>>
>> Ah, good catch! Lorenzo, thanks!!!
>>
>>>>
>>>> Also this just feels like it should be part of the series where you
>>>> change
>>>> these? I'm not sure why this is separate?
>>>
>>> I think Lance is trying to unify both scanning functions to look alike,
>>> such that when he refactors them out in patch #3 it looks more straight
>>> forward.
>>>
>>> The missing pte_present() check in hpage_collapse_scan_pmd() is interesting
>>
>> Yep, indeed ;)
>>
>>>
>>> Likely there is one such check missing there?
>>
>> I think the risk is exactly how pte_pfn() would handle a swap PTE ...
>>
>> A swap PTE contains completely different data(swap type and offset).
>> pte_pfn() doesn't know this, so if we feed a swap entry to it, it will
>> spit out a junk PFN :)
>>
>> What if that junk PFN happens to match the zeropage's PFN by sheer
>> chance? IHMO, it's really unlikely, but it would be really bad if it did.
>>
>> Clearly, pte_present() prevents this ;)
> 
> Yeah, not so clearly kinda the whole point I'm making here. I mean all this code
> sucks because we have deeply nested conditions and you have to keep in your mind
> that 'oh we already checked for X so we can do Y'.

I see :)

> 
> But the THP code is horrible in general.

Yep, you'll get no argument from me on that one ;p

The code is indeed tricky ...

> 
> Anyway let's stay focused (so I can stand a chance of catching up with my
> post-vacation backlog :), I will check the respin once you send!

Cheers!

This series has been dropped from mm-new. I'm going to take a bit to
rethink the approach based on the feedback.

> 
>>
>> By the way, I noticed there are other places in khugepaged.c that
>> call pte_pfn() without being under a pte_present() check.
>>
>> Perhaps those should all be fixed as well in a separate patch?
> 
> Yeah I'm not surprised and sure indeed.
> 
> Thanks, Lorenzo

In the meantime, I'll send up a separate patch for the missing
pte_present() checks first ;)

Thanks,
Lance

