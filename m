Return-Path: <linux-kernel+bounces-853759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3741BDC8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241321924D91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC72D3A7C;
	Wed, 15 Oct 2025 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EZ2qVHvF"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF07E110
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503788; cv=none; b=jUUJL0T9a1CzME3B1xWLg84VGljRs0kzd4GhsG0Fh8SvjV70CON/JmNR1yGRZBnR1mBk9g+9U8rpwjO3ICWwOQvo1Dy8+tkeDVg6VzqHZAyCEJI3VkHDdrQHBKhhIQp4gMCZSwoH7IMEbvIX4hXSzcQtmJDFABxZUgZyJ/jS788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503788; c=relaxed/simple;
	bh=ewMrniF/29qkkpkXAGcA3qITORAIFFn/SjldTm8WXq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntlQWK2tjGXUlzsro8QMYfGM+KiInE+YgThTEhG89vz2ZAOxID4EPnmnhawzGwJGqlcc64VIPbWh5iAN5dJj0jI/WpyVSh/Tp/xZpnU3bd2uQwT5yEpgUvb31WmviuoP4wMe8KupIg5rkkqff/EpYmODAuTkDfBoLU75mBe5STY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EZ2qVHvF; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80771030-0d8d-4f65-803a-f89da3b59796@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760503783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygDjvocgrySJ816q1hlB757s4pG93J0anp2ldxVExNw=;
	b=EZ2qVHvFYwYzxX+uULJSA7sCrdOmUs6JY/QrAORm+zvi+iwUX02arVUPk2aOEXOzKbuR2D
	C4ObtDFndbyBJbZH1PsNEsulxhfdOrVUBcD3h0GpmMIdS8fFEm3eZ1hnSuc+fcyyFEqUYU
	WrrPZrrDaH1G2y0C7hxW90gL8+nlHRw=
Date: Wed, 15 Oct 2025 12:49:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH mm-new v3 1/3] mm/khugepaged: optimize PTE scanning with
 if-else-if-else-if chain
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, ioworker0@gmail.com,
 richard.weiyang@gmail.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20251008043748.45554-1-lance.yang@linux.dev>
 <20251008043748.45554-2-lance.yang@linux.dev>
 <3982686f-908f-4f92-b3ae-e6f141e617ef@lucifer.local>
 <cfbd4f48-69a0-4ba9-bce8-f578d9602125@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <cfbd4f48-69a0-4ba9-bce8-f578d9602125@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/14 20:27, David Hildenbrand wrote:
> On 14.10.25 14:17, Lorenzo Stoakes wrote:
>> On Wed, Oct 08, 2025 at 12:37:46PM +0800, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> As pointed out by Dev, the PTE checks for disjoint conditions in the
>>> scanning loops can be optimized. is_swap_pte, (pte_none && is_zero_pfn),
>>> and pte_uffd_wp are mutually exclusive.
>>
>> But you're not using is_swap_pte anywhere :) This comes back to my review
>> quesiotn on the series this is dependent upon.
>>
>>>
>>> This patch refactors the loops in both __collapse_huge_page_isolate() 
>>> and
>>> hpage_collapse_scan_pmd() to use a continuous if-else-if-else-if chain
>>> instead of separate if blocks. While at it, the redundant pte_present()
>>> check before is_zero_pfn() is also removed.
>>
>> I mean see review below, I don't see why you're doing this and I am
>> unconvinced by how redundant that check is.

Ah, good catch! Lorenzo, thanks!!!

>>
>> Also this just feels like it should be part of the series where you 
>> change
>> these? I'm not sure why this is separate?
> 
> I think Lance is trying to unify both scanning functions to look alike, 
> such that when he refactors them out in patch #3 it looks more straight 
> forward.
> 
> The missing pte_present() check in hpage_collapse_scan_pmd() is interesting

Yep, indeed ;)

> 
> Likely there is one such check missing there?

I think the risk is exactly how pte_pfn() would handle a swap PTE ...

A swap PTE contains completely different data(swap type and offset).
pte_pfn() doesn't know this, so if we feed a swap entry to it, it will
spit out a junk PFN :)

What if that junk PFN happens to match the zeropage's PFN by sheer
chance? IHMO, it's really unlikely, but it would be really bad if it did.

Clearly, pte_present() prevents this ;)

By the way, I noticed there are other places in khugepaged.c that
call pte_pfn() without being under a pte_present() check.

Perhaps those should all be fixed as well in a separate patch?

