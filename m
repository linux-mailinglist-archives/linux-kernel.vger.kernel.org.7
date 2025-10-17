Return-Path: <linux-kernel+bounces-857862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9C3BE8191
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE461AA3E91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094DC3128BE;
	Fri, 17 Oct 2025 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRSgXxBC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i/7QJkxp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sRSgXxBC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i/7QJkxp"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6674C3126D1
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697635; cv=none; b=aPVceq/KsBbzbGRplwMi+/PzzxRoK03o0kk7nFgkieaeXdfqsRj/QOZGWECkzeKSP2M0z53E352HE/sZpqWWxEdUPvpL5EIbDn3ltj9FxLcH9HmRxr6sojhyEG34K1ihLOywYUfHFO4UT750p4Cj/kw2ax8DpkwVEva1vUofdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697635; c=relaxed/simple;
	bh=2MPIr6eg9j8MMfkdTLcls/LjgbCIxLTLzPy/Qo/CGWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPqE88EOkHBGM+DTD5kOW2lTrb2WiUkIGsPUm3Xmia9K7Sy+HuRXNclHrrLOinEreqwbBsI4bDPEfLY2V8ikIeGNqrWoAGGp/xaafnvQMcRSMtB85nUjx3oYGxK4Rn2FKj4YxzWYjrphBMHjn2C/b3S/ztBvoXBABizem85Vris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRSgXxBC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i/7QJkxp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sRSgXxBC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i/7QJkxp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E34F1FE36;
	Fri, 17 Oct 2025 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760697631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WFmr5m5ApwaLvw1kC/IwmGZr0B7ly+XAnDh5ibV2XJY=;
	b=sRSgXxBCsJwbv81IdJGDC+x27PZqiAh1a6tDYJm1lt+ijXp6mDFc/PWHda//f968AW6ow+
	IM94o9qqrZ9Dsn1dmz+gSATebjY3fM238lleDPcgdmBqAzjo864FtWwN76gnZwv5r8GUvz
	rw+L+7GXfBxbgcrH7zM5kAyNGCHbbbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760697631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WFmr5m5ApwaLvw1kC/IwmGZr0B7ly+XAnDh5ibV2XJY=;
	b=i/7QJkxpG0SiSuB3xNw+STi/5Vi9DuA/9Nv3q7F24CF5Vda/ZAd8Dfn7E1K7BFhE4Z0f4z
	1wQxYVi5B8S6nYAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sRSgXxBC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="i/7QJkxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760697631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WFmr5m5ApwaLvw1kC/IwmGZr0B7ly+XAnDh5ibV2XJY=;
	b=sRSgXxBCsJwbv81IdJGDC+x27PZqiAh1a6tDYJm1lt+ijXp6mDFc/PWHda//f968AW6ow+
	IM94o9qqrZ9Dsn1dmz+gSATebjY3fM238lleDPcgdmBqAzjo864FtWwN76gnZwv5r8GUvz
	rw+L+7GXfBxbgcrH7zM5kAyNGCHbbbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760697631;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WFmr5m5ApwaLvw1kC/IwmGZr0B7ly+XAnDh5ibV2XJY=;
	b=i/7QJkxpG0SiSuB3xNw+STi/5Vi9DuA/9Nv3q7F24CF5Vda/ZAd8Dfn7E1K7BFhE4Z0f4z
	1wQxYVi5B8S6nYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32F9813A71;
	Fri, 17 Oct 2025 10:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KMwbDB8d8mjldQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 17 Oct 2025 10:40:31 +0000
Message-ID: <7791b2b8-5db8-458c-89e2-49a0876c13a3@suse.cz>
Date: Fri, 17 Oct 2025 12:40:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
Content-Language: en-US
To: Hao Ge <hao.ge@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <a9ca7cc6-f4d1-4fba-a9aa-2826b9a604bc@suse.cz>
 <8F4AE1E9-7412-40D6-B383-187021266174@linux.dev>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <8F4AE1E9-7412-40D6-B383-187021266174@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 4E34F1FE36
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email,kylinos.cn:email];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 10/17/25 12:02, Hao Ge wrote:
> 
> 
>> On Oct 17, 2025, at 16:22, Vlastimil Babka <vbabka@suse.cz> wrote:
>> 
>> ﻿On 10/17/25 09:40, Harry Yoo wrote:
>>>> On Fri, Oct 17, 2025 at 02:42:56PM +0800, Hao Ge wrote:
>>>> Hi Harry
>>>> 
>>>> 
>>>> Thank you for your quick response.
>>>> 
>>>> 
>>>> On 2025/10/17 14:05, Harry Yoo wrote:
>>>>> On Fri, Oct 17, 2025 at 12:57:49PM +0800, Hao Ge wrote:
>>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>> 
>>>>>> In the alloc_slab_obj_exts function, there is a race condition
>>>>>> between the successful allocation of slab->obj_exts and its
>>>>>> setting to OBJEXTS_ALLOC_FAIL due to allocation failure.
>>>>>> 
>>>>>> When two threads are both allocating objects from the same slab,
>>>>>> they both end up entering the alloc_slab_obj_exts function because
>>>>>> the slab has no obj_exts (allocated yet).
>>>>>> 
>>>>>> And One call succeeds in allocation, but the racing one overwrites
>>>>>> our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
>>>>>> allocated will have prepare_slab_obj_exts_hook() return
>>>>>> slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(slab)
>>>>>> already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
>>>>>> on the zero address.
>>>>>> 
>>>>>> And then it will call alloc_tag_add, where the member codetag_ref *ref
>>>>>> of obj_exts will be referenced.Thus, a NULL pointer dereference occurs,
>>>>>> leading to a panic.
>>>>>> 
>>>>>> In order to avoid that, for the case of allocation failure where
>>>>>> OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignment.
>>>>>> 
>>>>>> Thanks for Vlastimil and Suren's help with debugging.
>>>>>> 
>>>>>> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures unconditionally")
>>>>> I think we should add Cc: stable as well?
>>>>> We need an explicit Cc: stable to backport mm patches to -stable.
>>>> Oh sorry, I missed this.
>>>>> 
>>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>>> ---
>>>>>>  mm/slub.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>> 
>>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>>> index 2e4340c75be2..9e6361796e34 100644
>>>>>> --- a/mm/slub.c
>>>>>> +++ b/mm/slub.c
>>>>>> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct slabobj_ext *obj_exts)
>>>>>>  static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>>>>  {
>>>>>> -    slab->obj_exts = OBJEXTS_ALLOC_FAIL;
>>>>>> +    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>>>>  }
>>>>> A silly question:
>>>>> 
>>>>> If mark_failed_objexts_alloc() succeeds and a concurrent
>>>>> alloc_slab_obj_exts() loses, should we retry cmpxchg() in
>>>>> alloc_slab_obj_exts()?
>>>> 
>>>> Great point.
>>>> 
>>>> We could modify it like this, perhaps?
>>>> 
>>>>  static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>>  {
>>>> +       unsigned long old_exts = READ_ONCE(slab->obj_exts);
>>>> +       if( old_exts == 0 )
>>>> +               cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>>  }
>>> 
>>> I don't think this makes sense.
>>> cmpxchg() fails anyway if old_exts != 0.
> 
> Aha, sorry I misunderstood what you meant.
> 
>>> 
>>>> Do you have any better suggestions on your end?
>>> 
>>> I meant something like this.
>>> 
>>> But someone might argue that this is not necessary anyway
>>> if there's a severe memory pressure :)
>>> 
>>> diff --git a/mm/slub.c b/mm/slub.c
>>> index a585d0ac45d4..4354ae68b0e1 100644
>>> --- a/mm/slub.c
>>> +++ b/mm/slub.c
>>> @@ -2139,6 +2139,11 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>        slab->obj_exts = new_exts;
>>>    } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
>>>           cmpxchg(&slab->obj_exts, old_exts, new_exts) != old_exts) {
>>> +
>>> +        old_exts = READ_ONCE(slab->obj_exts);
>>> +        if (old_exts == OBJEXTS_ALLOC_FAIL &&
>>> +            cmpxchg(&slab->obj_exts, old_exts, new_exts) == old_exts)
>>> +            goto out;
>> 
>> Yeah, but either we make it a full loop or we don't care.
>> Maybe we could care because even without a severe memory pressure, one side
>> might be using kmalloc_nolock() and fail more easily. I'd bet it's what's
>> making this reproducible actually.
> 
> From my understanding, it only affected the obj_ext associated with this allocation, which was subsequently deallocated, leading to the loss of this count. Is this correct?

Yes.

> 
>> 
>>>        /*
>>>         * If the slab is already in use, somebody can allocate and
>>>         * assign slabobj_exts in parallel. In this case the existing
>>> @@ -2152,6 +2157,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>>>        return 0;
>>>    }
>>> 
>>> +out:
>>>    kmemleak_not_leak(vec);
>>>    return 0;
>>> }
>>> 
>>>>> 
>>>>>> --
>>>>>> 2.25.1
>>>> 
>>> 
>> 


