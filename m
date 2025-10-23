Return-Path: <linux-kernel+bounces-866138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B02BFEFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083B03A7FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A6D224AE6;
	Thu, 23 Oct 2025 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJMdsd/v"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D213D2B2
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761189180; cv=none; b=DqkcaqDufPghuApOSPfM2uUkZi/gQpWpo+6NMt71n0wSb2m2/uKiTLNgujh5s1DUchECHmglmjrl8Pood6ywXvt1pZ9YIydyNf4KE9QEW/Q9kQkfT1avLItJkUzGaudi+HJYiPLVZR8K3S9wOitMm74XJj6jHJrIekllq1GDk6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761189180; c=relaxed/simple;
	bh=L5JoeUi4WeEe+pRIOovU+B+uZJIWZX7XGgvaKQi3ENY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dkz3gz+TfKlk++Sew5qcCJx767+w/boij6QwUXowZpLsCa4vZ4TKub1BD1QEla3vGinazzWld5XqDTgSVUNi/erFj2jrZXU2PWPl4mtq4FYrnoErEnfzo4hbQipgePp6HoK/EgnKU92wzPCE0H5rcfBXi0q/mLTK0ytrldQ/Qfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJMdsd/v; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8c90552-7be6-45bb-b586-ee21f63499c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761189174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFkWNTRoB/vWjqG2R3wUjVcnbHUc9YIZUBF8y0lylxA=;
	b=SJMdsd/v/n7qYpNMD0GsCkMe2XJR8wOEzvSvdCFiCAlKhs6jakoNH86bSAuk2ZTSAVA1yr
	mcpeQWoWfK0diJ92k0LlQzJPP7wRBJpvB7HdKx/kYWSEsmUfrX5aLKxZp1WMlBzEH+RFZO
	OI9eYVdTtQKpPqONpyuPavmZfqmz8AM=
Date: Thu, 23 Oct 2025 11:11:56 +0800
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
 <aPmR6Fz8HxYk4rTF@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <aPmR6Fz8HxYk4rTF@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry


On 2025/10/23 10:24, Harry Yoo wrote:
> On Thu, Oct 23, 2025 at 09:21:17AM +0800, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> If two competing threads enter alloc_slab_obj_exts(), and the
>> thread that failed to allocate the object extension vector exits
>> after the one that succeeded, it will mistakenly assume slab->obj_ext
>> is still empty due to its own allocation failure. This will then trigger
>> warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG checks in
>> the subsequent free path.
>>
>> Therefore, let's add an additional check when alloc_slab_obj_exts fails.
>>
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   mm/slub.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index d4403341c9df..42276f0cc920 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2227,9 +2227,12 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
>>   	slab = virt_to_slab(p);
>>   	if (!slab_obj_exts(slab) &&
>>   	    alloc_slab_obj_exts(slab, s, flags, false)) {
>> -		pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
>> -			     __func__, s->name);
>> -		return NULL;
>> +		/* Recheck if a racing thread has successfully allocated slab->obj_exts. */
>> +		if (!slab_obj_exts(slab)) {
>> +			pr_warn_once("%s, %s: Failed to create slab extension vector!\n",
>> +				     __func__, s->name);
>> +			return NULL;
>> +		}
>>   	}
> Maybe this patch is a bit paranoid... since if mark_failed_objexts_alloc()
> win cmpxchg() and then someone else allocates the object extension vector,
> the warning will still be printed anyway.


The process that successfully allocates slab_exts will call 
handle_failed_objexts_alloc, setting ref->ct = CODETAG_EMPTY

to prevent the warning from being triggered.


> But anyway, I think there is a better way to do this:
>
> diff --git a/mm/slub.c b/mm/slub.c
> index dd4c85ea1038..d08d7580349d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>   	}
>   }
>   
> -static inline void mark_failed_objexts_alloc(struct slab *slab)
> +static inline bool mark_failed_objexts_alloc(struct slab *slab)
>   {
> -	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> +	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
>   }
>   
>   static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
> @@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>   #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>   
>   static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
> -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
> +static inline bool mark_failed_objexts_alloc(struct slab *slab) { return true; }
>   static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>   			struct slabobj_ext *vec, unsigned int objects) {}
>   
> @@ -2125,7 +2125,9 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>   	}
>   	if (!vec) {
>   		/* Mark vectors which failed to allocate */
> -		mark_failed_objexts_alloc(slab);
> +		if (!mark_failed_objexts_alloc(slab) &&
> +			slab_obj_exts(slab))
> +			return 0;
>   
>   		return -ENOMEM;
>   	}
>

