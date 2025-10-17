Return-Path: <linux-kernel+bounces-857416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFC7BE6BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 188F04F8CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7FB30F94B;
	Fri, 17 Oct 2025 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SF6trazP"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC7222578
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683431; cv=none; b=KOgqBAIBxoog1P4rxN0haMa+bd3+24jZ9ux9H6e0TKe+TbQrP//2jo3UdxwIDkaP7Ce+EOJ4Ogl797QVRDjTPGhYyvmVd7UiyWOBNR0xWpwRJNjYQ7tZ4Ldu/s968kJXsNRnqY9UeiiccZQ2nHcks7VTpDPsg484uJXHAYLkccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683431; c=relaxed/simple;
	bh=3H0BxXJo8aB6HEq3FCJuAwdi4rJ4YI3wLy7UJ8usk0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K35S3t7nzI+13jMSbAimxlpGpj5bAxe3Yhn4xHGKPVLx5Z0u20jMZA2znDLtcbcjt1T01zf/rHik78Gk3zHn1qLQVPPC9go7TGbhz4Zv/KTqre7wjhTeJ0Avq2eImtPfplB/3xVJnt07xTAH8mq8tES+WaMX+lloUIxWubbyHjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SF6trazP; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <556352a6-70dc-4709-a0d2-038e2cd4fd88@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760683425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=27ILP3PisFWMzeZ0qER84rVbx10h57G1tQZ/rIsZYvs=;
	b=SF6trazPBL787T7iEDAxBvdVButWkO6CS5V+nuyrFgUYLqFoXBQRYYcui4o8yhzXVDAw6Q
	73trCNxynS1BqseH1RPxZQBN4Ly7rQp7FOJSdRs+TKSYB8InQ60aiRNZv0gsjG4iTOwKtA
	DPrLw/8OxW3fwKx1kn7FASkApJxUPgI=
Date: Fri, 17 Oct 2025 14:42:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20251017045749.3060696-1-hao.ge@linux.dev>
 <aPHcqbQkPV--NCt8@hyeyoo>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <aPHcqbQkPV--NCt8@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Harry


Thank you for your quick response.


On 2025/10/17 14:05, Harry Yoo wrote:
> On Fri, Oct 17, 2025 at 12:57:49PM +0800, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> In the alloc_slab_obj_exts function, there is a race condition
>> between the successful allocation of slab->obj_exts and its
>> setting to OBJEXTS_ALLOC_FAIL due to allocation failure.
>>
>> When two threads are both allocating objects from the same slab,
>> they both end up entering the alloc_slab_obj_exts function because
>> the slab has no obj_exts (allocated yet).
>>
>> And One call succeeds in allocation, but the racing one overwrites
>> our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
>> allocated will have prepare_slab_obj_exts_hook() return
>> slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(slab)
>> already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
>> on the zero address.
>>
>> And then it will call alloc_tag_add, where the member codetag_ref *ref
>> of obj_exts will be referenced.Thus, a NULL pointer dereference occurs,
>> leading to a panic.
>>
>> In order to avoid that, for the case of allocation failure where
>> OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignment.
>>
>> Thanks for Vlastimil and Suren's help with debugging.
>>
>> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
> I think we should add Cc: stable as well?
> We need an explicit Cc: stable to backport mm patches to -stable.
Oh sorry, I missed this.
>
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>> ---
>>   mm/slub.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 2e4340c75be2..9e6361796e34 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>>   
>>   static inline void mark_failed_objexts_alloc(struct slab *slab)
>>   {
>> -	slab->obj_exts = OBJEXTS_ALLOC_FAIL;
>> +	cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>   }
> A silly question:
>
> If mark_failed_objexts_alloc() succeeds and a concurrent
> alloc_slab_obj_exts() loses, should we retry cmpxchg() in
> alloc_slab_obj_exts()?

Great point.

We could modify it like this, perhaps?

  static inline void mark_failed_objexts_alloc(struct slab *slab)
  {
+       unsigned long old_exts = READ_ONCE(slab->obj_exts);
+       if( old_exts == 0 )
+               cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
  }

Do you have any better suggestions on your end?

>
>> -- 
>> 2.25.1

