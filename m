Return-Path: <linux-kernel+bounces-866580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9026AC0023D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A903A517D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D85F2F9984;
	Thu, 23 Oct 2025 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JOkl5iIB"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC5286417
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210722; cv=none; b=EmR50wxQanI7c00Dx5z1Rzy8eGZMtxeuW0tCzjlR22mp3V1/RnEVvf50MyD6j1TTYg+IDcnxx/pMVYrwC93dPDVx7TCos7q9NNjZ0S1PBbw2Dlk3oY6k8HZcQCwhvm/OVQiQXbmwgG45ZOj1D3xfnFYjbeuIwP8WXYjw4blEQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210722; c=relaxed/simple;
	bh=P6pkN/XT9VOW5uVHhsuwqPpyOs/Klr7TawSDY8T24/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQsAuspwSBz+dnugy6trsONUiWOYdDQq/++2coh/ApHZeJmQBJEIFEnmkmT+QKzCklwTjJhJ2FKQM0XKQALV/zEUFYW3XkQg4KNY2ii/hWpSS6wYadWKTQ89wltMcJ5MH+K+vxzZWhgrTPVCBfYW+PldFWRgLDXKmK7EnHfryk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JOkl5iIB; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <268f8300-3be0-4b45-aa86-e11bf09c86bb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761210716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmispLrE7a4YOiW6K5NNzShTdcLhEQ+ZufQ8+3A6y5g=;
	b=JOkl5iIBkvZqrgJUDnNLlBLRgFgyo+zC/WeZHufXVg1SvfFYeZX/4spL4xStPG7DSKuy/H
	dEhLMnEbcXA5S/7nN1CJcjkukdJyic8o2hTsLStMagyJbwTMUitKIvhLvOqXYMtkt5QjOi
	dZXEH1QcGdmi5lC0JZijQuL2Ze82lcU=
Date: Thu, 23 Oct 2025 17:11:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20251023012117.890883-1-hao.ge@linux.dev>
 <aPmR6Fz8HxYk4rTF@hyeyoo> <b8c90552-7be6-45bb-b586-ee21f63499c8@linux.dev>
 <aPneQRY5ei-zvSGQ@hyeyoo> <cc961fad-f9bc-4c5a-a7f1-ea3842aefed3@linux.dev>
 <abc7bc71-c9a4-4a19-a47f-f6d6f40608fb@linux.dev> <aPnv_W48rbPPmAOj@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <aPnv_W48rbPPmAOj@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Harry


On 2025/10/23 17:06, Harry Yoo wrote:
> On Thu, Oct 23, 2025 at 04:46:42PM +0800, Hao Ge wrote:
>> Hi Harry
>>
>>
>> On 2025/10/23 16:23, Hao Ge wrote:
>>> Hi Harry
>>>
>>>
>>> On 2025/10/23 15:50, Harry Yoo wrote:
>>>> On Thu, Oct 23, 2025 at 11:11:56AM +0800, Hao Ge wrote:
>>>>> Hi Harry
>>>>>
>>>>>
>>>>> On 2025/10/23 10:24, Harry Yoo wrote:
>>>>>> On Thu, Oct 23, 2025 at 09:21:17AM +0800, Hao Ge wrote:
>>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>>>
>>>>>>> If two competing threads enter alloc_slab_obj_exts(), and the
>>>>>>> thread that failed to allocate the object extension vector exits
>>>>>>> after the one that succeeded, it will mistakenly assume slab->obj_ext
>>>>>>> is still empty due to its own allocation failure. This
>>>>>>> will then trigger
>>>>>>> warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
>>>>>>> the subsequent free path.
>>>>>>>
>>>>>>> Therefore, let's add an additional check when
>>>>>>> alloc_slab_obj_exts fails.
>>>>>>>
>>>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>>>> ---
>>>>>>>     mm/slub.c | 9 ++++++---
>>>>>>>     1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>>>> index d4403341c9df..42276f0cc920 100644
>>>>>>> --- a/mm/slub.c
>>>>>>> +++ b/mm/slub.c
>>>>>>> @@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct
>>>>>>> kmem_cache *s, gfp_t flags, void *p)
>>>>>>>         slab = virt_to_slab(p);
>>>>>>>         if (!slab_obj_exts(slab) &&
>>>>>>>             alloc_slab_obj_exts(slab, s, flags, false)) {
>>>>>>> -        pr_warn_once("%s, %s: Failed to create slab
>>>>>>> extension vector!\n",
>>>>>>> -                 __func__, s->name);
>>>>>>> -        return NULL;
>>>>>>> +        /* Recheck if a racing thread has successfully
>>>>>>> allocated slab->obj_exts. */
>>>>>>> +        if (!slab_obj_exts(slab)) {
>>>>>>> +            pr_warn_once("%s, %s: Failed to create slab
>>>>>>> extension vector!\n",
>>>>>>> +                     __func__, s->name);
>>>>>>> +            return NULL;
>>>>>>> +        }
>>>>>>>         }
>>>>>> Maybe this patch is a bit paranoid... since if
>>>>>> mark_failed_objexts_alloc()
>>>>>> win cmpxchg() and then someone else allocates the object
>>>>>> extension vector,
>>>>>> the warning will still be printed anyway.
>>>> Oh, just to be clear I was talking about the other warning:
>>>> pr_warn_once("%s, %s: Failed to create slab extension vector!",
>>>> __func__, s->name);
>>>>
>>>>> The process that successfully allocates slab_exts will call
>>>>> handle_failed_objexts_alloc, setting ref->ct = CODETAG_EMPTY
>>>>> to prevent the warning from being triggered.
>>>> But yeah I see what you mean.
>>>>
>>>> As you mentioned, if the process that failed to allocate the vector wins
>>>> cmpxchg(), later process that successfully allocate the vector would
>>>> call set_codetag_empty(), so no warning.
>>>>
>>>> But if the process that allocates the vector wins cmpxchg(),
>>>> then it won't call set_codetag_empty(), so the process
>>>> that was trying to set OBJEXTS_ALLOC_FAIL now needs to set the tag.
>>> Yes, the case I'm encountering is exactly this one.
>>>
>>>>>> But anyway, I think there is a better way to do this:
>>>> What do you think about the diff I suggested below, though?
>>> Sorry for the delayed response earlier; I was trying to deduce all
>>> possible scenarios.
>>>
>>> It makes sense to me, and I will submit the V2 version based on this
>>> suggestion.
>>>
>>> Thank you for your help.
>>>
>>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>>> index dd4c85ea1038..d08d7580349d 100644
>>>>>> --- a/mm/slub.c
>>>>>> +++ b/mm/slub.c
>>>>>> @@ -2052,9 +2052,9 @@ static inline void
>>>>>> mark_objexts_empty(struct slabobj_ext *obj_exts)
>>>>>>         }
>>>>>>     }
>>>>>> -static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>>>> +static inline bool mark_failed_objexts_alloc(struct slab *slab)
>>>>>>     {
>>>>>> -    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>>>> +    return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
>>>>>>     }
>>>>>>     static inline void handle_failed_objexts_alloc(unsigned
>>>>>> long obj_exts,
>>>>>> @@ -2076,7 +2076,7 @@ static inline void
>>>>>> handle_failed_objexts_alloc(unsigned long obj_exts,
>>>>>>     #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>>>>>>     static inline void mark_objexts_empty(struct slabobj_ext
>>>>>> *obj_exts) {}
>>>>>> -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
>>>>>> +static inline bool mark_failed_objexts_alloc(struct slab
>>>>>> *slab) { return true; }
>> Maybe it returns false here.
>>
>> When CONFIG_MEM_ALLOC_PROFILING_DEBUG is not enabled,
>>
>> The following condition will never be executed:
>>
>> if (!mark_failed_objexts_alloc(slab) && slab_obj_exts(slab))
> Good point. But without CONFIG_MEM_ALLOC_PROFILING_DEBUG, we don't know
> if someone else successfully allocated the vector or not (unlike, with
> CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled, we know that when we lose
> cmpxchg()). We cannot "fix" the case where a process fails to allocate
> the vector but another allocates the vector.
>
> So I'm not sure if checking slab_obj_exts() once more is worth it in
> this case, but I'm fine with either way.
>
>> if another process that allocates the vector, we will lose one count.
> By "one count" you mean skipping accounting the object in memory
> profiling, right?
Yes.
>
>>>>>>     static inline void handle_failed_objexts_alloc(unsigned
>>>>>> long obj_exts,
>>>>>>                 struct slabobj_ext *vec, unsigned int objects) {}
>>>>>> @@ -2125,7 +2125,9 @@ int alloc_slab_obj_exts(struct slab
>>>>>> *slab, struct kmem_cache *s,
>>>>>>         }
>>>>>>         if (!vec) {
>>>>>>             /* Mark vectors which failed to allocate */
>>>>>> -        mark_failed_objexts_alloc(slab);
>>>>>> +        if (!mark_failed_objexts_alloc(slab) &&
>>>>>> +            slab_obj_exts(slab))
>>>>>> +            return 0;
>>>>>>             return -ENOMEM;
>>>>>>         }
>>>>>>

