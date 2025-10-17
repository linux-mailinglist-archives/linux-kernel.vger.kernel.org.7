Return-Path: <linux-kernel+bounces-857782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC83BE7EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A8364E5FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A782DECA1;
	Fri, 17 Oct 2025 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H4E9SeDq"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29912D595F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760695398; cv=none; b=VtKGqWeOJ0U67RiWu8lAEjuJU32c2+oOX9bykVGkfRLrjm6trKTOEUdO6qC1U5Q28nW+q7EFpCFrzE4gY20HxtTokNXA+pfhpjaqrCg37xadOs36g1rl05BOwPVhsVoEF25BMV33VuN1RZK3C4axXpqFppEE2YT9m0a3gWB5bPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760695398; c=relaxed/simple;
	bh=yPYJA9nWA9ckhRTcnQ1HkAudNskYOmW67TDLW3UqjHg=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=FjwL4EPITmrr/h/N7fT9DufrwEBIMJ9c2JipVV46egppFkLbrLpTd6U/AnVEHJrzuBviISLODXe50g8Ygy9RSOwkHPTKaNIQWzdUhCS7Kb6fSqKL7xaVGSx3WHatq3tbFteGbcQxLgMzVRzrMmYDWXW2LjUZbqIM+u4wsB1hcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H4E9SeDq; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760695393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7T9fbRkF3jqCU0uPzbOUF0lxcaNuHAGLnaDOYW7kx98=;
	b=H4E9SeDqU1sLWo2YpFChIWayvi4ND0Pf01lnG/s/cCcYpLSed1wy0J76NDDxw/r2ws8Sop
	SIS4X0VeIEtCTi9oDOAxuaO3AttPVpTdLmBHJn2cuI7QKJCgiHXaJbvzxPV3ld6lvaWpfN
	+cK9hsHrcT8GWxj/Ppba3k7f3PlxqEY=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
Date: Fri, 17 Oct 2025 18:02:57 +0800
Message-Id: <8F4AE1E9-7412-40D6-B383-187021266174@linux.dev>
References: <a9ca7cc6-f4d1-4fba-a9aa-2826b9a604bc@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
In-Reply-To: <a9ca7cc6-f4d1-4fba-a9aa-2826b9a604bc@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
X-Migadu-Flow: FLOW_OUT



> On Oct 17, 2025, at 16:22, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> =EF=BB=BFOn 10/17/25 09:40, Harry Yoo wrote:
>>> On Fri, Oct 17, 2025 at 02:42:56PM +0800, Hao Ge wrote:
>>> Hi Harry
>>>=20
>>>=20
>>> Thank you for your quick response.
>>>=20
>>>=20
>>> On 2025/10/17 14:05, Harry Yoo wrote:
>>>> On Fri, Oct 17, 2025 at 12:57:49PM +0800, Hao Ge wrote:
>>>>> From: Hao Ge <gehao@kylinos.cn>
>>>>>=20
>>>>> In the alloc_slab_obj_exts function, there is a race condition
>>>>> between the successful allocation of slab->obj_exts and its
>>>>> setting to OBJEXTS_ALLOC_FAIL due to allocation failure.
>>>>>=20
>>>>> When two threads are both allocating objects from the same slab,
>>>>> they both end up entering the alloc_slab_obj_exts function because
>>>>> the slab has no obj_exts (allocated yet).
>>>>>=20
>>>>> And One call succeeds in allocation, but the racing one overwrites
>>>>> our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
>>>>> allocated will have prepare_slab_obj_exts_hook() return
>>>>> slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_exts(sl=
ab)
>>>>> already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset based
>>>>> on the zero address.
>>>>>=20
>>>>> And then it will call alloc_tag_add, where the member codetag_ref *ref=

>>>>> of obj_exts will be referenced.Thus, a NULL pointer dereference occurs=
,
>>>>> leading to a panic.
>>>>>=20
>>>>> In order to avoid that, for the case of allocation failure where
>>>>> OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assignme=
nt.
>>>>>=20
>>>>> Thanks for Vlastimil and Suren's help with debugging.
>>>>>=20
>>>>> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failures un=
conditionally")
>>>> I think we should add Cc: stable as well?
>>>> We need an explicit Cc: stable to backport mm patches to -stable.
>>> Oh sorry, I missed this.
>>>>=20
>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
>>>>> ---
>>>>>  mm/slub.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/mm/slub.c b/mm/slub.c
>>>>> index 2e4340c75be2..9e6361796e34 100644
>>>>> --- a/mm/slub.c
>>>>> +++ b/mm/slub.c
>>>>> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct sla=
bobj_ext *obj_exts)
>>>>>  static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>>>  {
>>>>> -    slab->obj_exts =3D OBJEXTS_ALLOC_FAIL;
>>>>> +    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>>>  }
>>>> A silly question:
>>>>=20
>>>> If mark_failed_objexts_alloc() succeeds and a concurrent
>>>> alloc_slab_obj_exts() loses, should we retry cmpxchg() in
>>>> alloc_slab_obj_exts()?
>>>=20
>>> Great point.
>>>=20
>>> We could modify it like this, perhaps?
>>>=20
>>>  static inline void mark_failed_objexts_alloc(struct slab *slab)
>>>  {
>>> +       unsigned long old_exts =3D READ_ONCE(slab->obj_exts);
>>> +       if( old_exts =3D=3D 0 )
>>> +               cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
>>>  }
>>=20
>> I don't think this makes sense.
>> cmpxchg() fails anyway if old_exts !=3D 0.

Aha, sorry I misunderstood what you meant.

>>=20
>>> Do you have any better suggestions on your end?
>>=20
>> I meant something like this.
>>=20
>> But someone might argue that this is not necessary anyway
>> if there's a severe memory pressure :)
>>=20
>> diff --git a/mm/slub.c b/mm/slub.c
>> index a585d0ac45d4..4354ae68b0e1 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2139,6 +2139,11 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>>        slab->obj_exts =3D new_exts;
>>    } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
>>           cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_exts) {
>> +
>> +        old_exts =3D READ_ONCE(slab->obj_exts);
>> +        if (old_exts =3D=3D OBJEXTS_ALLOC_FAIL &&
>> +            cmpxchg(&slab->obj_exts, old_exts, new_exts) =3D=3D old_exts=
)
>> +            goto out;
>=20
> Yeah, but either we make it a full loop or we don't care.
> Maybe we could care because even without a severe memory pressure, one sid=
e
> might be using kmalloc_nolock() and fail more easily. I'd bet it's what's
> making this reproducible actually.

=46rom my understanding, it only affected the obj_ext associated with this a=
llocation, which was subsequently deallocated, leading to the loss of this c=
ount. Is this correct?


>=20
>>        /*
>>         * If the slab is already in use, somebody can allocate and
>>         * assign slabobj_exts in parallel. In this case the existing
>> @@ -2152,6 +2157,7 @@ int alloc_slab_obj_exts(struct slab *slab, struct k=
mem_cache *s,
>>        return 0;
>>    }
>>=20
>> +out:
>>    kmemleak_not_leak(vec);
>>    return 0;
>> }
>>=20
>>>>=20
>>>>> --
>>>>> 2.25.1
>>>=20
>>=20
>=20

