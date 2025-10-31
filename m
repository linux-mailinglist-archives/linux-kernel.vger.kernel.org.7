Return-Path: <linux-kernel+bounces-879958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF8CC247BD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1DDD4610F8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26960338939;
	Fri, 31 Oct 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="puzyI4VS"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA9320397
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906912; cv=none; b=Lnpcc7hqON7M0fHJ11PSs5N2uuvM4dGE6bugXCDMCmw7kp59HU6OWAmhSAB52Jq3L6A/7lBYfdFpJ5yYPtLvDorFzgbQiCerKGbexLHSzdAEwcnOdYtRHThfWPoZk6xy5MYQEKZtSLaAF2CkiOgo339xMsozRqhdIlWBxxzLrEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906912; c=relaxed/simple;
	bh=UQLJEn0L5U5fEjbo73zPZFZsVwvrPvxRKeocPtqgLW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzaATj7NoK2FinSEh/iiocXmjXDCTKIZr/EWPKJBlgy9N2ZAZkIjDddFgEzzBcO1QuE3Xr8yksNTf+Ha+P0JJuywUftBuQw2yAVG9ooORYnmPXi1hp9ZyZw/+Bw2qW73oQb9rmZRALweqAy+//7DivuysFnKxDjmS+6F/m75s+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=puzyI4VS; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5adc0331-d699-402f-a798-acbf76e124db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761906903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=15d5jagqZuWVPOYKHa4FJ77KmZ/Kk6K2xbbjYubxhkU=;
	b=puzyI4VSEcGnkKbWUyQwU8Fr2Cmzx93J3JXvaM/b5q6xIf6hFk4D9XEQIXtewTZydWzo3h
	N7MZfd9y7CNsoHOwLv1jNmWQyvU1MkeMbx+/edLqwHblPKh1suHNw5L5WZsFOSgk+13cso
	XTQeEKURcNDUydqbFINmNPex8s5BQEM=
Date: Fri, 31 Oct 2025 18:34:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/secretmem: fix use-after-free race in fault
 handler
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, big-sleep-vuln-reports@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 david@redhat.com, stable@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
References: <CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com>
 <20251031091818.66843-1-lance.yang@linux.dev> <aQSIdCpf-2pJLwAF@kernel.org>
 <02caf80d-ccde-49d4-99dd-0ea3763a0593@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <02caf80d-ccde-49d4-99dd-0ea3763a0593@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/10/31 18:24, Lorenzo Stoakes wrote:
> Small thing, sorry to be a pain buuuut could we please not send patches
> in-reply to another mail, it makes it harder for people to see :)
> 
> On Fri, Oct 31, 2025 at 11:59:16AM +0200, Mike Rapoport wrote:
>> On Fri, Oct 31, 2025 at 05:18:18PM +0800, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> The error path in secretmem_fault() frees a folio before restoring its
>>> direct map status, which is a race leading to a panic.
>>
>> Let's use the issue description from the report:
>>
>> When a page fault occurs in a secret memory file created with
>> `memfd_secret(2)`, the kernel will allocate a new folio for it, mark
>> the underlying page as not-present in the direct map, and add it to
>> the file mapping.
>>
>> If two tasks cause a fault in the same page concurrently, both could
>> end up allocating a folio and removing the page from the direct map,
>> but only one would succeed in adding the folio to the file
>> mapping. The task that failed undoes the effects of its attempt by (a)
>> freeing the folio again and (b) putting the page back into the direct
>> map. However, by doing these two operations in this order, the page
>> becomes available to the allocator again before it is placed back in
>> the direct mapping.
>>
>> If another task attempts to allocate the page between (a) and (b), and
>> the kernel tries to access it via the direct map, it would result in a
>> supervisor not-present page fault.
>>
>>> Fix the ordering to restore the map before the folio is freed.
>>
>> ... restore the direct map
>>
>> With these changes
>>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Agree with David, Mike this looks 'obviously correct' thanks for addressing
> it.
> 
> But also as per Mike, please update message accordingly and send v2
> not-in-reply-to-anything :P

Sure. V2 is on the way ;)

> 
> With that said:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!
Lance

> 
>>
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
>>> Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>> ---
>>>   mm/secretmem.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/secretmem.c b/mm/secretmem.c
>>> index c1bd9a4b663d..37f6d1097853 100644
>>> --- a/mm/secretmem.c
>>> +++ b/mm/secretmem.c
>>> @@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
>>>   		__folio_mark_uptodate(folio);
>>>   		err = filemap_add_folio(mapping, folio, offset, gfp);
>>>   		if (unlikely(err)) {
>>> -			folio_put(folio);
>>>   			/*
>>>   			 * If a split of large page was required, it
>>>   			 * already happened when we marked the page invalid
>>>   			 * which guarantees that this call won't fail
>>>   			 */
>>>   			set_direct_map_default_noflush(folio_page(folio, 0));
>>> +			folio_put(folio);
>>>   			if (err == -EEXIST)
>>>   				goto retry;
>>>
>>> --
>>> 2.49.0
>>>
>>
>> --
>> Sincerely yours,
>> Mike.


