Return-Path: <linux-kernel+bounces-866490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30ABFFE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 888FF4FABB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206F2FD7D3;
	Thu, 23 Oct 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fThTnFDg"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58692F5A1F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761207882; cv=none; b=u2QwKdE6YKgAenjTRp1LMJxPSGhpjhSLy2dH0OJ7x1q3NkYtfcZaMDHKF0xoxccgAPJPcxS9Pp7Zjc2/PfvLLI9trU5XlcoGlEd+6Bizlp+K9Uk8wtpJfxuOVvr5VIKVjY3n26vVnj3N0etNtbozyBkItA1zgHm2RfSQR7ocBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761207882; c=relaxed/simple;
	bh=NcCrlUf4fOwfqPKQ8Z4xxpeURczQzsoS4x4MvBaX9zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTRnKZkL6Q5oxWsg2EwZWfaEuOq4GyIe0QnKTDtGx/kUMMVkX5SIeiF1TLMNumCb1phBI7zSkrQdFEc7KkZhrGlQFXADnY05LLZmTSLD69NvgeYskkdAni46agJqZ1moeqNltPWkcPWi5/H0gYIR8XktO6asI02fuvGMmCYejl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fThTnFDg; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cc961fad-f9bc-4c5a-a7f1-ea3842aefed3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761207877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zxjCR3n53HVShccK/xRoPJo5rB7aVfPPhCgNh53dbY8=;
	b=fThTnFDg+1ijgoPzAgbubMu5OymL/xwomkEXwN6LQgU2M/qiN/YXap8eaIsyTw5X2NUafZ
	kCxlvd73b82O3ZmEsS7eXWyV7EXGy9Fsmv90Mm2J23WJIzAYmjTJsnMwgskeLB0U7mPwEY
	4D60U5jwltBRaymwIeAk4SGBhPNC1fU=
Date: Thu, 23 Oct 2025 16:23:46 +0800
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
 <aPneQRY5ei-zvSGQ@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <aPneQRY5ei-zvSGQ@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry


On 2025/10/23 15:50, Harry Yoo wrote:
> On Thu, Oct 23, 2025 at 11:11:56AM +0800, Hao Ge wrote:
>> Hi Harry
>>
>>
>> On 2025/10/23 10:24, Harry Yoo wrote:
>>> On Thu, Oct 23, 2025 at 09:21:17AM +0800, Hao Ge wrote:
>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>
>>>> If two competing threads enter alloc_slab_obj_exts(), and the
>>>> thread that failed to allocate the object extension vector exits
>>>> after the one that succeeded, it will mistakenly assume slab->obj_ext
>>>> is still empty due to its own allocation failure. This will then trigger
>>>> warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
>>>> the subsequent free path.
>>>>
>>>> Therefore, let's add an additional check when alloc_slab_obj_exts fails.
>>>>
>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>> ---
>>>>    mm/slub.c | 9 ++++++---
>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>> index d4403341c9df..42276f0cc920 100644
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>>>>    	slab = virt_to_slab(p);
>>>>    	if (!slab_obj_exts(slab) &&
>>>>    	    alloc_slab_obj_exts(slab, s, flags, false)) {
>>>> -		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
>>>> -			     __func__, s->name);
>>>> -		return NULL;
>>>> +		/* Recheck if a racing thread has successfully allocated slab->obj_exts. */
>>>> +		if (!slab_obj_exts(slab)) {
>>>> +			pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
>>>> +				     __func__, s->name);
>>>> +			return NULL;
>>>> +		}
>>>>    	}
>>> Maybe this patch is a bit paranoid... since if mark_failed_objexts_alloc()
>>> win cmpxchg() and then someone else allocates the object extension vector,
>>> the warning will still be printed anyway.
> Oh, just to be clear I was talking about the other warning:
> pr_warn_once("%s, %s: Failed to create slab extension vector!", __func__, s->name);
>
>> The process that successfully allocates slab_exts will call
>> handle_failed_objexts_alloc, setting ref->ct = CODETAG_EMPTY
>> to prevent the warning from being triggered.
> But yeah I see what you mean.
>
> As you mentioned, if the process that failed to allocate the vector wins
> cmpxchg(), later process that successfully allocate the vector would
> call set_codetag_empty(), so no warning.
>
> But if the process that allocates the vector wins cmpxchg(),
> then it won't call set_codetag_empty(), so the process
> that was trying to set OBJEXTS_ALLOC_FAIL now needs to set the tag.

Yes, the case I'm encountering is exactly this one.

>
>>> But anyway, I think there is a better way to do this:
> What do you think about the diff I suggested below, though?

Sorry for the delayed response earlier; I was trying to deduce all 
possible scenarios.

It makes sense to me, and I will submit the V2 version based on this 
suggestion.

Thank you for your help.

>
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index dd4c85ea1038..d08d7580349d 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>>>    	}
>>>    }
>>> -static inline void mark_failed_objexts_alloc(struct slab *slab)
>>> +static inline bool mark_failed_objexts_alloc(struct slab *slab)
>>>    {
>>> -	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>> +	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
>>>    }
>>>    static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>>> @@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>>>    #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>>>    static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
>>> -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
>>> +static inline bool mark_failed_objexts_alloc(struct slab *slab) { return true; }
>>>    static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>>>    			struct slabobj_ext *vec, unsigned int objects) {}
>>> @@ -2125,7 +2125,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>    	}
>>>    	if (!vec) {
>>>    		/* Mark vectors which failed to allocate */
>>> -		mark_failed_objexts_alloc(slab);
>>> +		if (!mark_failed_objexts_alloc(slab) &&
>>> +			slab_obj_exts(slab))
>>> +			return 0;
>>>    		return -ENOMEM;
>>>    	}
>>>

