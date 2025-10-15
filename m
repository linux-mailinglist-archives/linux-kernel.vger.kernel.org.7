Return-Path: <linux-kernel+bounces-854578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C953BDEC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CDD3E7E15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F92264D6;
	Wed, 15 Oct 2025 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q3ECz6l3"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4E21E097
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535523; cv=none; b=gP0EJBM50tLu9IaSX+GGYyLtsr97cCrDHhzmPyou3JBUMNjJ+voUQ1r5juOsrDH3ZLX3YcFKksCyzhJVoiPQ9p8cYSWTGD+4J6RtFnBZupr93Qwd27NvOCep939ewhArQgz/2fxFO88jCwCV70W38lWTIJLpF5A3cdpunVMLVg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535523; c=relaxed/simple;
	bh=AYaafXCDletkKL4AloYl4gjf4twEF8LrRR8OK1FUCa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1U3Nwdth9uwf84+hCX+MMAOCM6HDhtwqcgXfgkfkoRJaxSqMJDDnierXzZiRDEbDCwB6o5oJzCXbYAUIAfmlE+ITieuYG92iQ6ICn7nDcQkmI2KzL4WmLaJESPwnifhq6EfphhtniI6PjHOeoG8WUf8bpYJ6w+mxOi9Izu6yDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q3ECz6l3; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f00c5229-6c56-4116-8ba9-20a75c5bbde6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760535518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYGfkZ4ebd8zW8yNaQUWakKK3LgMJUyMT/Oxz7oB3+Y=;
	b=Q3ECz6l31UzPNBENDMDgPx2sWIVb0jSaQr0AwUW32/hbCe29N547wVY8KWfRQUsmp0gWbU
	JULVbrwj2eiz8G853+sOcahbxQOYe8YSl9vnHmmS/fhxHwtZt40ds+XLhdfZAXInQ/Xeci
	w1FGZqsa9fPtQj3c3MjSU9pB1GUNkVQ=
Date: Wed, 15 Oct 2025 21:37:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] slab: clear OBJEXTS_ALLOC_FAIL when freeing a slab
To: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
References: <20251015125945.481950-1-hao.ge@linux.dev>
 <06b0c6fb-0123-4482-ac07-80f0faec3532@suse.cz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <06b0c6fb-0123-4482-ac07-80f0faec3532@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Vlastimil


On 2025/10/15 21:11, Vlastimil Babka wrote:
> On 10/15/25 14:59, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAIL and
>> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
>> release of the associated folio, a VM_BUG_ON_FOLIO() check in
>> folio_memcg_kmem() is triggered because it was mistakenly assumed that
>> a valid folio->memcg_data was not cleared before freeing the folio.
>>
>> When freeing a slab, we clear slab->obj_exts if the obj_ext array has been
>> successfully allocated. So let's clear OBJEXTS_ALLOC_FAIL when freeing
>> a slab if the obj_ext array allocated fail to allow them to be returned
>> to the buddy system more smoothly.
> Thanks!
>
>> Fixes: 7612833192d5 ("slab: Reuse first bit for OBJEXTS_ALLOC_FAIL")
>> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
>> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Since we changed the approach completely, I think we should not carry over
> the previously added review tags in this case.
got it.
>
>> ---
>> v4: Based on the discussion between Vlastimil and Harry,
>>      modify the solution to clear OBJEXTS_ALLOC_FAIL when freeing a slab.
>>      This does seem more reasonable. Thank you both.
>> ---
>>   mm/slab.h | 26 ++++++++++++++++++++++++++
>>   mm/slub.c |  6 ++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 078daecc7cf5..52424d6871bd 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -547,6 +547,28 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>   	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
>>   }
>>   
>> +/*
>> + * objexts_clear_alloc_fail -  Clear the OBJEXTS_ALLOC_FAIL for
>> + * the slab object extension vector associated with a slab.
>> + * @slab: a pointer to the slab struct
>> + */
>> +static inline void objexts_clear_alloc_fail(struct slab *slab)
>> +{
>> +	unsigned long obj_exts = READ_ONCE(slab->obj_exts);
>> +
>> +#ifdef CONFIG_MEMCG
>> +	/*
>> +	 * obj_exts should be either NULL, a valid pointer with
>> +	 * MEMCG_DATA_OBJEXTS bit set or be equal to OBJEXTS_ALLOC_FAIL.
>> +	 */
>> +	VM_BUG_ON_PAGE(obj_exts && !(obj_exts & MEMCG_DATA_OBJEXTS) &&
>> +		       obj_exts != OBJEXTS_ALLOC_FAIL, slab_page(slab));
>> +	VM_BUG_ON_PAGE(obj_exts & MEMCG_DATA_KMEM, slab_page(slab));
>> +#endif
>> +
>> +	obj_exts &= ~OBJEXTS_ALLOC_FAIL;
>> +	WRITE_ONCE(slab->obj_exts, obj_exts);
>> +}
> This is much larger than necessary I think. See below.
>
>>   int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>                           gfp_t gfp, bool new_slab);
>>   
>> @@ -557,6 +579,10 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
>>   	return NULL;
>>   }
>>   
>> +static inline void objexts_clear_alloc_fail(struct slab *slab)
>> +{
>> +}
>> +
>>   #endif /* CONFIG_SLAB_OBJ_EXT */
>>   
>>   static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b1f15598fbfd..80166a4a62f9 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2169,6 +2169,12 @@ static inline void free_slab_obj_exts(struct slab *slab)
>>   {
>>   	struct slabobj_ext *obj_exts;
>>   
>> +	/*
>> +	 * If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_FAIL,
>> +	 * Therefore, we should clear the OBJEXTS_ALLOC_FAIL flag first when freeing a slab.
>> +	 */
>> +	objexts_clear_alloc_fail(slab);
>> +
>>   	obj_exts = slab_obj_exts(slab);
>>   	if (!obj_exts)
>>   		return;
> It should be enough that this return path does "slab->obj_exts = 0;" no?

I might have had a momentary mental block just now,sorry,

this modification method is indeed much simpler.

I will send v5 as soon as possible.


>
>

