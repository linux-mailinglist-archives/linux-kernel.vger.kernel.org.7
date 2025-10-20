Return-Path: <linux-kernel+bounces-859959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD57BEF0B8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29331899349
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336D01A0B15;
	Mon, 20 Oct 2025 02:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGc9e1Ii"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04661DF270
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760925749; cv=none; b=WYB/ZtnedMYbOpu/hngZCMROPIwhpoCcCZrEgiZ/Fuqi+d5OmY5KcIdaM0LRQm5AGxU4BfZjWXPxUNkOkQYG0iQrrt5cCddhoSHjURVlWXtbqTvOhx8BWC/FnnV3IyE8JQchlm0OTaF18BOECcj092/XEV/f8C3yz4uzNHqJsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760925749; c=relaxed/simple;
	bh=r7F8VBaOqPbONl17XxGa6LIdMwTAnSRZB1acdtZ6BKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9QMS1PuaIWBv8ICTUiDkjOmswMY3GNiOZl5VIcXIWizX0pmtiJdNT9f11yNSK3LOXhHfKbV2Uirr2fRy7h47jRXNilCyI/4p1qimQhbt/TvmAC06abyvNpS/ALKxDW0O+tK6gVecVPbaLFMkfOyzVUb3Wzfv6PRtOQoflzn1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGc9e1Ii; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3efc2a94-54c7-48a8-a804-c231d06b5ed5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760925743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvw6EEcLVS321+82zeKA5qCqsquigv/cxrzA5Vq7LGo=;
	b=hGc9e1IiLST/psAYvB/aakCsP4XWX8OkVLTCEs0D0o0PKzJbXKei56mJzB8lGov+Y3y6o7
	Dag7c4YvbxLjuBbfOKPzW9XAxDi9ovSSPNYx1a9bDt5F6iiq0yqlCPxGeo+EshhCkcvhkk
	qdozeyfCimZd3viWAswm9uEhGE4jHBA=
Date: Mon, 20 Oct 2025 10:01:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
To: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <a9ca7cc6-f4d1-4fba-a9aa-2826b9a604bc@suse.cz>
 <8F4AE1E9-7412-40D6-B383-187021266174@linux.dev>
 <7791b2b8-5db8-458c-89e2-49a0876c13a3@suse.cz>
 <CAJuCfpEWGujJe3JOjmiKLOUr49Hw_3smT6iatY7kaRBPPCWpNg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpEWGujJe3JOjmiKLOUr49Hw_3smT6iatY7kaRBPPCWpNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2025/10/18 05:52, Suren Baghdasaryan wrote:
> On Fri, Oct 17, 2025 at 3:40 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> On 10/17/25 12:02, Hao Ge wrote:
>>>
>>>> On Oct 17, 2025, at 16:22, Vlastimil Babka <vbabka@suse.cz> wrote:
>>>>
>>>> ﻿On 10/17/25 09:40, Harry Yoo wrote:
>>>>>> On Fri, Oct 17, 2025 at 02:42:56PM +0800, Hao Ge wrote:
>>>>>> Hi Harry
>>>>>>
>>>>>>
>>>>>> Thank you for your quick response.
>>>>>>
>>>>>>
>>>>>> On 2025/10/17 14:05, Harry Yoo wrote:
>>>>>>> On Fri, Oct 17, 2025 at 12:57:49PM +0800, Hao Ge wrote:
>>>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>>>>
>>>>>>>> In the alloc_slab_obj_exts function, there is a race condition
>>>>>>>> between the successful allocation of slab->obj_exts and its
>>>>>>>> setting to OBJEXTS_ALLOC_FAIL due to allocation failure.
>>>>>>>>
>>>>>>>> When two threads are both allocating objects from the same slab,
>>>>>>>> they both end up entering the alloc_slab_obj_exts function because
>>>>>>>> the slab has no obj_exts (allocated yet).
>>>>>>>>
>>>>>>>> And One call succeeds in allocation, but the racing one overwrites
>>>>>>>> our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
>>>>>>>> allocated will have prepare_slab_obj_exts_hook() return
>>>>>>>> slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(slab)
>>>>>>>> already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
>>>>>>>> on the zero address.
>>>>>>>>
>>>>>>>> And then it will call alloc_tag_add, where the member codetag_ref *ref
>>>>>>>> of obj_exts will be referenced.Thus, a NULL pointer dereference occurs,
>>>>>>>> leading to a panic.
>>>>>>>>
>>>>>>>> In order to avoid that, for the case of allocation failure where
>>>>>>>> OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignment.
>>>>>>>>
>>>>>>>> Thanks for Vlastimil and Suren's help with debugging.
>>>>>>>>
>>>>>>>> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
>>>>>>> I think we should add Cc: stable as well?
>>>>>>> We need an explicit Cc: stable to backport mm patches to -stable.
>>>>>> Oh sorry, I missed this.
>>>>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>>>>> ---
>>>>>>>>   mm/slub.c | 2 +-
>>>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>>>>> index 2e4340c75be2..9e6361796e34 100644
>>>>>>>> --- a/mm/slub.c
>>>>>>>> +++ b/mm/slub.c
>>>>>>>> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>>>>>>>>   static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>>>>>>   {
>>>>>>>> -    slab->obj_exts = OBJEXTS_ALLOC_FAIL;
>>>>>>>> +    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>>>>>>   }
>>>>>>> A silly question:
>>>>>>>
>>>>>>> If mark_failed_objexts_alloc() succeeds and a concurrent
>>>>>>> alloc_slab_obj_exts() loses, should we retry cmpxchg() in
>>>>>>> alloc_slab_obj_exts()?
>>>>>> Great point.
>>>>>>
>>>>>> We could modify it like this, perhaps?
>>>>>>
>>>>>>   static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>>>>   {
>>>>>> +       unsigned long old_exts = READ_ONCE(slab->obj_exts);
>>>>>> +       if( old_exts == 0 )
>>>>>> +               cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>>>>   }
>>>>> I don't think this makes sense.
>>>>> cmpxchg() fails anyway if old_exts != 0.
>>> Aha, sorry I misunderstood what you meant.
>>>
>>>>>> Do you have any better suggestions on your end?
>>>>> I meant something like this.
>>>>>
>>>>> But someone might argue that this is not necessary anyway
>>>>> if there's a severe memory pressure :)
>>>>>
>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>> index a585d0ac45d4..4354ae68b0e1 100644
>>>>> --- a/mm/slub.c
>>>>> +++ b/mm/slub.c
>>>>> @@ -2139,6 +2139,11 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>>         slab->obj_exts = new_exts;
>>>>>     } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
>>>>>            cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>>>>> +
>>>>> +        old_exts = READ_ONCE(slab->obj_exts);
>>>>> +        if (old_exts == OBJEXTS_ALLOC_FAIL &&
>>>>> +            cmpxchg(&slab->obj_exts, old_exts, new_exts) == old_exts)
>>>>> +            goto out;
>>>> Yeah, but either we make it a full loop or we don't care.
>>>> Maybe we could care because even without a severe memory pressure, one side
>>>> might be using kmalloc_nolock() and fail more easily. I'd bet it's what's
>>>> making this reproducible actually.
>>>  From my understanding, it only affected the obj_ext associated with this allocation, which was subsequently deallocated, leading to the loss of this count. Is this correct?
>> Yes.

In that case, we may really need to handle this situation and require a 
full loop.

In theory, this scenario could occur:


Thread1                                                 Thead2

alloc_slab_obj_exts                               alloc_slab_obj_exts

old_exts = READ_ONCE(slab->obj_exts) = 0

mark_failed_objexts_alloc(slab);

  cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts

kfree and return 0;

alloc_tag_add---->a panic occurs


Alternatively, is there any code logic I might have overlooked?

> I think retrying like this should work:
>
> +retry:
>           old_exts = READ_ONCE(slab->obj_exts);
>           handle_failed_objexts_alloc(old_exts, vec, objects);
>           if (new_slab) {
> @@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab,
> struct kmem_cache *s,
>                    * be simply assigned.
>                    */
>                   slab->obj_exts = new_exts;
> -        } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
> -                   cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
> +        } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
>                   /*
>                    * If the slab is already in use, somebody can allocate and
>                    * assign slabobj_exts in parallel. In this case the existing
> @@ -2158,6 +2158,8 @@ int alloc_slab_obj_exts(struct slab *slab,
> struct kmem_cache *s,
>                   else
>                           kfree(vec);
>                   return 0;
> +        } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
> +                goto retry;
>           }

Agree with this. If there are no issues with my comment above,

I will send V2 based on Suren's suggestion.

Additionally, I believe the "Fixes" field should be written as follows:

Fixes: 09c46563ff6d ("codetag: debug: introduce OBJEXTS_ALLOC_FAIL to 
mark failed slab_ext allocations")

Am I wrong?

>
>>>>>         /*
>>>>>          * If the slab is already in use, somebody can allocate and
>>>>>          * assign slabobj_exts in parallel. In this case the existing
>>>>> @@ -2152,6 +2157,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> +out:
>>>>>     kmemleak_not_leak(vec);
>>>>>     return 0;
>>>>> }
>>>>>
>>>>>>>> --
>>>>>>>> 2.25.1

