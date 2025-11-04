Return-Path: <linux-kernel+bounces-884589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD66C30898
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDC7E34B2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C774A2D47E0;
	Tue,  4 Nov 2025 10:35:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABA29B764
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252555; cv=none; b=IbeG8GZ07MiOc0NLIOKlCSfr8MalYHlupORALqN/vIkuw7ZUurpFIq70RJg/UQPj6LQMhgNLw6MNflXKHGUXRBEwVWPH+hNsGF6LnQG2WHZBGGsCEtxciZx7Q9i3Xc4h4ZZ5KsVGiCueXUL9zjZYEA1C5q2V2pWHffcnefRUQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252555; c=relaxed/simple;
	bh=zUIW4Yu3Z7IGJ683BDPXs+nNJDVXffygGg9M/Lf8uzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6qKG5udBXzgYuADKdOYtQv/dC8taZys7BR4v0xvLCSPvmlmzfpnYFkCuJryzmdWFKxS35dRxPsXWEKyFWPzFSz1/dn8RfrHI0PkHLFbhrIBL93OZ/rWLVYOUVGvXEFTmzKuiq9Pr5y9fvLQysK/HtMkyePFcTjg+VSq6/e43q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 663671764;
	Tue,  4 Nov 2025 02:35:44 -0800 (PST)
Received: from [10.164.18.64] (unknown [10.164.18.64])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56E1C3F694;
	Tue,  4 Nov 2025 02:35:49 -0800 (PST)
Message-ID: <9dcd181a-7058-4fee-83a5-695df77c9edb@arm.com>
Date: Tue, 4 Nov 2025 16:05:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: prevent infinite loop in kmalloc_nolock() with
 debugging
To: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251103-fix-nolock-loop-v1-1-6e2b3e82b9da@suse.cz>
 <5bb311a5-b59f-4897-b4d0-4e06d7d2b3f2@arm.com>
 <f59e2a0e-1da3-4670-84ee-679c2001f58f@suse.cz>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f59e2a0e-1da3-4670-84ee-679c2001f58f@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/11/25 3:54 pm, Vlastimil Babka wrote:
> On 11/4/25 6:26 AM, Dev Jain wrote:
>> On 03/11/25 5:54 pm, Vlastimil Babka wrote:
>>> In review of a followup work, Harry noticed a potential infinite loop.
>>> Upon closed inspection, it already exists for kmalloc_nolock() on a
>>> cache with debugging enabled, since commit af92793e52c3 ("slab:
>>> Introduce kmalloc_nolock() and kfree_nolock().")
>>>
>>> When alloc_single_from_new_slab() fails to trylock node list_lock, we
>>> keep retrying to get partial slab or allocate a new slab. If we indeed
>>> interrupted somebody holding the list_lock, the trylock fill fail
>> Hi Vlastimil,
>>
>> I see that we always take n->list_lock spinlock by disabling irqs. So
>> how can we interrupt someone holding the list_lock?
>  From a NMI or e.g. a kprobe->bpf hook, which are the use cases for
> kmalloc_nolock(). The word "interrupt" thus doesn't mean IRQ, but I'm
> not sure which word would be better. "Preempt" would be perhaps even
> more potentially misleading.
>
>> If we are already in a path holding list_lock, and trigger a slab
>> allocation
>> and recursively end up in the same path again, we can get the situation
>> you mention, is that possible?
> There shouldn't be such recursion in the code itself, in the absence of
> NMI/kprobe/etc.

Thanks for explaining.

>>> deterministically and we end up allocating and defer-freeing slabs
>>> indefinitely with no progress.
>>>
>>> To fix it, fail the allocation if spinning is not allowed. This is
>>> acceptable in the restricted context of kmalloc_nolock(), especially
>>> with debugging enabled.
>>>
>>> Reported-by: Harry Yoo <harry.yoo@oracle.com>
>>> Closes: https://lore.kernel.org/all/aQLqZjjq1SPD3Fml@hyeyoo/
>>> Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and
>>> kfree_nolock().")
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>> as we discussed in the linked thread, 6.18 hotfix to be included in
>>> slab/for-next-fixes
>>> ---
>>>    mm/slub.c | 6 +++++-
>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index d4367f25b20d..f1a5373eee7b 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -4666,8 +4666,12 @@ static void *___slab_alloc(struct kmem_cache
>>> *s, gfp_t gfpflags, int node,
>>>        if (kmem_cache_debug(s)) {
>>>            freelist = alloc_single_from_new_slab(s, slab, orig_size,
>>> gfpflags);
>>>    -        if (unlikely(!freelist))
>>> +        if (unlikely(!freelist)) {
>>> +            /* This could cause an endless loop. Fail instead. */
>>> +            if (!allow_spin)
>>> +                return NULL;
>>>                goto new_objects;
>>> +        }
>>>              if (s->flags & SLAB_STORE_USER)
>>>                set_track(s, freelist, TRACK_ALLOC, addr,
>>>
>>> ---
>>> base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
>>> change-id: 20251103-fix-nolock-loop-854e0101672f
>>>
>>> Best regards,

