Return-Path: <linux-kernel+bounces-823961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74C1B87D23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605135652B0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754F25C80E;
	Fri, 19 Sep 2025 03:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SG4ZYQLK"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095F25A355
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252862; cv=none; b=d72171gzbfpIA+yV6FipbmwWBWG1X699gfSrmACGcKybpAoGqV9aB598fiM7dI+Zk1GTI1x4u9RL/2Z6o7arx76B5bwmwbEJiboN1pqpHMgJnhIdoO385Dg+cZC/qqDQ+WjlMkQeFG/SN0C64ShzTvNhHNvjIoCTJzLAmia3iPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252862; c=relaxed/simple;
	bh=g6jvA3VCV7B+4YWnBLz+G/a9z+tD7ceTJS80Z6TyM7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f1Lg5g1uk7KIma8A/Bjs6IqCWw+vqddrKOnJmikkZWYggz0S6TEjXWGPUGD3aSLDauCy5HTciMhyKpb1SkXKjoscH/rVJ21XapKXGon3bYHm99UEdKeN5JdTcdl1FsUnbQSciEGvQqHrvMVH1FHCCIy61EkAsDWlALHBPf3j/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SG4ZYQLK; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af66aaaa-9652-497a-9ff3-9ce8d9417acb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758252857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMjFu7SVR95qSNzgCJYmzYUNzwf9n1HS7Sx7fQIOgfY=;
	b=SG4ZYQLKRvqHXnEoTxh1cvMz3hiaM6ZElAjyjuHPKfUn38WjqZWgHb5fOhLCQdaTGVRD+K
	Jop2ChIZ7x3SXAvdh2Eu1HIkcE//1SEKc6qw1gdr+IBHu/Kb+gCeT4NA3TSX7tDasm7pWI
	Z6R+2Tf8GatMpaUW4oX4h4zAej9nP0Q=
Date: Fri, 19 Sep 2025 11:34:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v2 2/2] mm/khugepaged: abort collapse scan on guard
 PTEs
Content-Language: en-US
To: Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 kirill@shutemov.name, hughd@google.com, mpenttil@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250918050431.36855-1-lance.yang@linux.dev>
 <20250918050431.36855-3-lance.yang@linux.dev>
 <6BAE5498-D0AB-40F5-85F8-B92A05CA72AD@nvidia.com>
 <20e0fb73-3476-4b1c-959e-c1af38f8e1a0@linux.dev>
 <7ca12da2-4ddc-4b4e-a8da-a1d9d2c44e03@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <7ca12da2-4ddc-4b4e-a8da-a1d9d2c44e03@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/9/19 11:18, Baolin Wang wrote:
> 
> 
> On 2025/9/19 10:44, Lance Yang wrote:
>>
>>
>> On 2025/9/19 03:12, Zi Yan wrote:
>>> On 18 Sep 2025, at 1:04, Lance Yang wrote:
>>>
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Guard PTE markers are installed via MADV_GUARD_INSTALL to create
>>>> lightweight guard regions.
>>>>
>>>> Currently, any collapse path (khugepaged or MADV_COLLAPSE) will fail 
>>>> when
>>>> encountering such a range.
>>>>
>>>> MADV_COLLAPSE fails deep inside the collapse logic when trying to 
>>>> swap-in
>>>> the special marker in __collapse_huge_page_swapin().
>>>>
>>>> hpage_collapse_scan_pmd()
>>>>   `- collapse_huge_page()
>>>>       `- __collapse_huge_page_swapin() -> fails!
>>>>
>>>> khugepaged's behavior is slightly different due to its max_ptes_swap 
>>>> limit
>>>> (default 64). It won't fail as deep, but it will still needlessly 
>>>> scan up
>>>> to 64 swap entries before bailing out.
>>>>
>>>> IMHO, we can and should detect this much earlier.
>>>>
>>>> This patch adds a check directly inside the PTE scan loop. If a guard
>>>> marker is found, the scan is aborted immediately with 
>>>> SCAN_PTE_NON_PRESENT,
>>>> avoiding wasted work.
>>>>
>>>> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>>   mm/khugepaged.c | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>>> index 9ed1af2b5c38..70ebfc7c1f3e 100644
>>>> --- a/mm/khugepaged.c
>>>> +++ b/mm/khugepaged.c
>>>> @@ -1306,6 +1306,16 @@ static int hpage_collapse_scan_pmd(struct 
>>>> mm_struct *mm,
>>>>                       result = SCAN_PTE_UFFD_WP;
>>>>                       goto out_unmap;
>>>>                   }
>>>> +                /*
>>>> +                 * Guard PTE markers are installed by
>>>> +                 * MADV_GUARD_INSTALL. Any collapse path must
>>>> +                 * not touch them, so abort the scan immediately
>>>> +                 * if one is found.
>>>> +                 */
>>>> +                if (is_guard_pte_marker(pteval)) {
>>>
>>> pteval is already is_swap_pte(), would is_guard_swp_entry() be a better
>>> choice here? Save one is_swap_pte() call.
> 
> Agree. Then seems we don't need to move the is_guard_pte_marker() into a 
> header file.

Got it. I'll only remove the redundant check in #01 patch.


