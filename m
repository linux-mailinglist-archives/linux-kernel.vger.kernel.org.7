Return-Path: <linux-kernel+bounces-868499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C6C055DB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE9B3B018C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316F30ACF4;
	Fri, 24 Oct 2025 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPJiCYOF"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB984309F0E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761298119; cv=none; b=e+Dab1c3Gbykc1vYN2Q4o0wFb6pyEc4w00A67NNqZDMNNPorqEdkijyIwcJFOKonI4dPS4rJYwhLWAVCIhNfOEfwT/RFDRbcLAqoeFzrBy86WTzIEj9hdO4hej7Rr5+Wah3yygkNG4QUSTMSnp/9qIbrm0GeDuWlDKerRwn5wUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761298119; c=relaxed/simple;
	bh=k7xngE3GO/Y4YrPPxiGXifV1ruEinc/ketHeBWH7bzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mSvZjjUkK9vHxKs3s2g3OhFovtQlFDAEisrhKsQYkhxj2AgaaJE+or1nr+wm9SbP/X6eOowgtNA/289pd1TR9pvl55dJPCU9JuHooAlz3XEahv7LDDMAK+ZzNeJrrdbitPBF/dzrfrx5M9U+nveSMlmgljjoQ9JXpk5tGcy5fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HPJiCYOF; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49a186cf-c248-45ff-a61c-a6de1a3a98b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761298114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WEjiKaJQmXfdvCFlzkFqU/zz27ee+mxZNS3z1hWWko4=;
	b=HPJiCYOFHl7B44O3yhgS2sA0eZwd/Z/eqa//JdqqG9CBe4DhWJCsZN3Hi+9ELs/9pGVrKA
	4b2T2eJPJnglMw/NBxx2mJgE+xOQyExKN9BUC4RD7mN7sqOQxBKCIc0OoB0IVr91qLdgWz
	0AY1awteljfV/UOiMJi7eDfClZqmOmQ=
Date: Fri, 24 Oct 2025 17:27:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] slab: Fix obj_ext is mistakenly considered NULL due to
 race condition
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20251023143313.1327968-1-hao.ge@linux.dev>
 <aPs-sKOJQs-OelVM@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <aPs-sKOJQs-OelVM@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Harry


On 2025/10/24 16:54, Harry Yoo wrote:
> On Thu, Oct 23, 2025 at 10:33:13PM +0800, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> If two competing threads enter alloc_slab_obj_exts(), if the process
>> that allocates the vector wins cmpxchg(), and the other thread mistakenly
>> assume slab->obj_ext is still empty due to its own allocation failure.
> Massaging this a little bit:
>
>    "If two competing threads enter alloc_slab_obj_exts(), and the one that
>     allocates the vector wins the cmpxchg(), the other thread that failed
>     allocation mistakenly assumes that slab->obj_exts is still empty due to
>     its own allocation failure."
>
>> This
>> will then trigger warnings enforced by CONFIG_MEM_ALLOC_PROFILING_DEBUG
>> checks in the subsequent free path.
>>
>> Therefore, let's add an additional check when the process that allocates
>> the vector loses the cmpxchg()
> You mean "when the process that failed to allocate the vector loses the
> cmpxchg()"?

Yes, I apologize for not being clear enough in my description here.

>> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>> v2: Revise the solution according to Harry's suggestion.
>>      Add Suggested-by: Harry Yoo <harry.yoo@oracle.com>
>> ---
>>
>>   mm/slub.c | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index d4403341c9df..d7bfec6c0171 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2052,9 +2052,9 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>>   	}
>>   }
>>   
>> -static inline void mark_failed_objexts_alloc(struct slab *slab)
>> +static inline bool mark_failed_objexts_alloc(struct slab *slab)
>>   {
>> -	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>> +	return cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL) == 0;
>>   }
>>   
>>   static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>> @@ -2076,7 +2076,7 @@ static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>>   #else /* CONFIG_MEM_ALLOC_PROFILING_DEBUG */
>>   
>>   static inline void mark_objexts_empty(struct slabobj_ext *obj_exts) {}
>> -static inline void mark_failed_objexts_alloc(struct slab *slab) {}
>> +static inline bool mark_failed_objexts_alloc(struct slab *slab) { return false; }
>>   static inline void handle_failed_objexts_alloc(unsigned long obj_exts,
>>   			struct slabobj_ext *vec, unsigned int objects) {}
>>   
>> @@ -2124,8 +2124,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>   				   slab_nid(slab));
>>   	}
>>   	if (!vec) {
>> -		/* Mark vectors which failed to allocate */
>> -		mark_failed_objexts_alloc(slab);
>> +		/*
>> +		 * Try to mark vectors which failed to allocate
> nit:
>                                                                 ^ missing
> 							       period
> 							       (.) here
>
> With the comments resolved,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>


A period is indeed missing here.


Hi Vlastimil


Thank you for adding V2 to your tree. Now, should I resubmit V3,

or can you assist with making these modifications in your tree?


>
>> +		 * If this operation fails, there may be a racing process
>> +		 * that has already completed the allocation.
>> +		 */
>> +		if (!mark_failed_objexts_alloc(slab) &&
>> +		    slab_obj_exts(slab))
>> +			return 0;
>>   
>>   		return -ENOMEM;
>>   	}
>> -- 
>> 2.25.1

