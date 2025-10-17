Return-Path: <linux-kernel+bounces-858795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF6BEBDB0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 23:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1404A4F9E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF2A30F546;
	Fri, 17 Oct 2025 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mdy9Br21"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E812D5A16
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760737993; cv=none; b=nn5amJOdciGlSn6IUJ+h91htHZp9esUOS90JnVGdYffA29e17ocdHoWJFxiREWjrEk9puDKiRC2dOcL4KY8Mtr3nVAG4Di4uVMuh93n1sDjPJIIcKJyN+DKht1NoHVGUcO1pLsBahQmBqhxiR+DEX2diZAmYOySo4R9rAsYrsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760737993; c=relaxed/simple;
	bh=5FmTGQtwUzvio6Ryf5WOyQ5YvpbY+qdDvOj3CKnL4hE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnKebRu1PPzXr2gE9kS3oiWKEzrkU/jsbkyPasVMepLe1DZiF5A23oOXe/nPQJC14iWjAFhF0WFqayuS/TIinom+zQYo241+FJHvZnby4oCd6747NKroAC0fErEnvRhS/ledmwsBjnmf+ZEo5vsbfjm4MauAqBxeVSp73PTkx7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mdy9Br21; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4308afd43f0so208615ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760737989; x=1761342789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zg+LvDgyn3hse8ECOJ3X3R84bc7PJRNWcq+EOuKGoKs=;
        b=Mdy9Br21U5wbguKU4Ib6MmWnTfrB2cobA6yA+qYXQBcN3XT8YrTkLfKbnVKUAD4ov8
         cAb/apjHRg3m2DFc7/x0Fld20gHQUV0UXVPhFlvE5ILKZqribTnlLW5/q69TBSAWFYn8
         9KuX0NT9v9RcrUZD3kqzYSzFMD+yu1c9ihTBK6VRmv3Igw3BYJRmwZGSDFND527VWTn+
         WSLkUJK5LsMDnlYuZnvBWSQIZViFWgE8UJjJHphBSUxrLLsILxGWDMeXqfIHO6zxk409
         FkJANYfNoQbyWjImfyuVvlvTStWCfDmTpWT5H4jz5BAh1cDMJ9N1Vngpn02ce2Ojhqmu
         xYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760737990; x=1761342790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg+LvDgyn3hse8ECOJ3X3R84bc7PJRNWcq+EOuKGoKs=;
        b=kCWVmymf514lK6O3rq37USycavnTvYT7Ge2HPlZ9IW4AXwFpBynHlkOHeFkvBSI9hi
         618Yy1v10CKwHR9IKVhqh76zEnuHKGYhaKPfKjlYfRS38k1+jXY+NbVYHFt4eMeOet8f
         Vqc9s/wFpiitzT9Ie9/PWLaTULFnF9bMSsxZiXCBK0w/wKGnEymqA7dvxs/yqhgnpZGs
         DfgAtp+boAD1eqSILAxME/N+il8rGSzgZmL0UMgM04mnQVyJfV4yNR3USBKTxuQ4YOYQ
         TjaiVw9R8skRCARa75iNjUE8EQuez90h2qE15mYNSMxCUeLJ0pI06rwXf1pUzrIdQvAi
         s1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUO8KC1s882xNgz6+fbfoNSSivugaBEDoVnpyVdJDrzpixqdU/2dzW9R9jOwZSEZsmiQTQAwy6Ds+xpt2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ffIc9W0diFl3juqSWNm/KMIrUzB0/1OFmhO2uvtgtKXISjFB
	dpWATmJL/NKZZ8Bvp+Y+ToFBUNEpvz9a9ngmT49oNE3603pm1VBPEgP4AYZpRxXdaQWxxll6dGU
	7SYHYklIlmB/uwau1JGQC1hHCBKjY6cvZJ7nzlabB
X-Gm-Gg: ASbGncv1m3OGjgVHwhL0DDsxR9jPFZ48mOlWs1QzmLJMRIJ2G2xdRw8YWkGs0AKiGwG
	kheDJb0Hv2IY8PREDdmIiMsd0JvyXXDulvA4BopnQcdCCM8LJPiDA8QqecwbIqb/bjq4JwYVKLM
	OA9ZSaOYqJp0jPQw13hAeT5Hp+xPSAu9a4i7YS8GEELRbEeLSf07ZfuIxXpxPQTDHYMxX/KO/G9
	70VAJcMT34teOqDc9gF/zk0La6H+V8FmP+NZqwtl1+BPGY6avc/ROzh7aR9EPQZhsEWhg==
X-Google-Smtp-Source: AGHT+IGc1sSOMmFv/ySY9gPGtIvXBGAMeSfkuZRIHXUrnxuhNCj4FV55NlOQ5imUZ2wq+v2IIFWpN2r0Mv6Ppw9CH8I=
X-Received: by 2002:a05:622a:5449:b0:4d1:c31e:1cc7 with SMTP id
 d75a77b69052e-4e882ee5ef8mr30328921cf.14.1760737989222; Fri, 17 Oct 2025
 14:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a9ca7cc6-f4d1-4fba-a9aa-2826b9a604bc@suse.cz> <8F4AE1E9-7412-40D6-B383-187021266174@linux.dev>
 <7791b2b8-5db8-458c-89e2-49a0876c13a3@suse.cz>
In-Reply-To: <7791b2b8-5db8-458c-89e2-49a0876c13a3@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 17 Oct 2025 14:52:58 -0700
X-Gm-Features: AS18NWBsbKz6L11KPx77elhvnrS5C-2MyEz2rs7vkZo8yWn-AnXc8Z7KatI8Ytw
Message-ID: <CAJuCfpEWGujJe3JOjmiKLOUr49Hw_3smT6iatY7kaRBPPCWpNg@mail.gmail.com>
Subject: Re: [PATCH] slab: Avoid race on slab->obj_exts in alloc_slab_obj_exts
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Ge <hao.ge@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 3:40=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/17/25 12:02, Hao Ge wrote:
> >
> >
> >> On Oct 17, 2025, at 16:22, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> =EF=BB=BFOn 10/17/25 09:40, Harry Yoo wrote:
> >>>> On Fri, Oct 17, 2025 at 02:42:56PM +0800, Hao Ge wrote:
> >>>> Hi Harry
> >>>>
> >>>>
> >>>> Thank you for your quick response.
> >>>>
> >>>>
> >>>> On 2025/10/17 14:05, Harry Yoo wrote:
> >>>>> On Fri, Oct 17, 2025 at 12:57:49PM +0800, Hao Ge wrote:
> >>>>>> From: Hao Ge <gehao@kylinos.cn>
> >>>>>>
> >>>>>> In the alloc_slab_obj_exts function, there is a race condition
> >>>>>> between the successful allocation of slab->obj_exts and its
> >>>>>> setting to OBJEXTS_ALLOC_FAIL due to allocation failure.
> >>>>>>
> >>>>>> When two threads are both allocating objects from the same slab,
> >>>>>> they both end up entering the alloc_slab_obj_exts function because
> >>>>>> the slab has no obj_exts (allocated yet).
> >>>>>>
> >>>>>> And One call succeeds in allocation, but the racing one overwrites
> >>>>>> our obj_ext with OBJEXTS_ALLOC_FAIL. The threads that successfully
> >>>>>> allocated will have prepare_slab_obj_exts_hook() return
> >>>>>> slab_obj_exts(slab) + obj_to_index(s, slab, p), where slab_obj_ext=
s(slab)
> >>>>>> already sees OBJEXTS_ALLOC_FAIL and thus it returns an offset base=
d
> >>>>>> on the zero address.
> >>>>>>
> >>>>>> And then it will call alloc_tag_add, where the member codetag_ref =
*ref
> >>>>>> of obj_exts will be referenced.Thus, a NULL pointer dereference oc=
curs,
> >>>>>> leading to a panic.
> >>>>>>
> >>>>>> In order to avoid that, for the case of allocation failure where
> >>>>>> OBJEXTS_ALLOC_FAIL is assigned, we use cmpxchg to handle this assi=
gnment.
> >>>>>>
> >>>>>> Thanks for Vlastimil and Suren's help with debugging.
> >>>>>>
> >>>>>> Fixes: f7381b911640 ("slab: mark slab->obj_exts allocation failure=
s unconditionally")
> >>>>> I think we should add Cc: stable as well?
> >>>>> We need an explicit Cc: stable to backport mm patches to -stable.
> >>>> Oh sorry, I missed this.
> >>>>>
> >>>>>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >>>>>> ---
> >>>>>>  mm/slub.c | 2 +-
> >>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/mm/slub.c b/mm/slub.c
> >>>>>> index 2e4340c75be2..9e6361796e34 100644
> >>>>>> --- a/mm/slub.c
> >>>>>> +++ b/mm/slub.c
> >>>>>> @@ -2054,7 +2054,7 @@ static inline void mark_objexts_empty(struct=
 slabobj_ext *obj_exts)
> >>>>>>  static inline void mark_failed_objexts_alloc(struct slab *slab)
> >>>>>>  {
> >>>>>> -    slab->obj_exts =3D OBJEXTS_ALLOC_FAIL;
> >>>>>> +    cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> >>>>>>  }
> >>>>> A silly question:
> >>>>>
> >>>>> If mark_failed_objexts_alloc() succeeds and a concurrent
> >>>>> alloc_slab_obj_exts() loses, should we retry cmpxchg() in
> >>>>> alloc_slab_obj_exts()?
> >>>>
> >>>> Great point.
> >>>>
> >>>> We could modify it like this, perhaps?
> >>>>
> >>>>  static inline void mark_failed_objexts_alloc(struct slab *slab)
> >>>>  {
> >>>> +       unsigned long old_exts =3D READ_ONCE(slab->obj_exts);
> >>>> +       if( old_exts =3D=3D 0 )
> >>>> +               cmpxchg(&slab->obj_exts, 0, OBJEXTS_ALLOC_FAIL);
> >>>>  }
> >>>
> >>> I don't think this makes sense.
> >>> cmpxchg() fails anyway if old_exts !=3D 0.
> >
> > Aha, sorry I misunderstood what you meant.
> >
> >>>
> >>>> Do you have any better suggestions on your end?
> >>>
> >>> I meant something like this.
> >>>
> >>> But someone might argue that this is not necessary anyway
> >>> if there's a severe memory pressure :)
> >>>
> >>> diff --git a/mm/slub.c b/mm/slub.c
> >>> index a585d0ac45d4..4354ae68b0e1 100644
> >>> --- a/mm/slub.c
> >>> +++ b/mm/slub.c
> >>> @@ -2139,6 +2139,11 @@ int alloc_slab_obj_exts(struct slab *slab, str=
uct kmem_cache *s,
> >>>        slab->obj_exts =3D new_exts;
> >>>    } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
> >>>           cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_exts)=
 {
> >>> +
> >>> +        old_exts =3D READ_ONCE(slab->obj_exts);
> >>> +        if (old_exts =3D=3D OBJEXTS_ALLOC_FAIL &&
> >>> +            cmpxchg(&slab->obj_exts, old_exts, new_exts) =3D=3D old_=
exts)
> >>> +            goto out;
> >>
> >> Yeah, but either we make it a full loop or we don't care.
> >> Maybe we could care because even without a severe memory pressure, one=
 side
> >> might be using kmalloc_nolock() and fail more easily. I'd bet it's wha=
t's
> >> making this reproducible actually.
> >
> > From my understanding, it only affected the obj_ext associated with thi=
s allocation, which was subsequently deallocated, leading to the loss of th=
is count. Is this correct?
>
> Yes.

I think retrying like this should work:

+retry:
         old_exts =3D READ_ONCE(slab->obj_exts);
         handle_failed_objexts_alloc(old_exts, vec, objects);
         if (new_slab) {
@@ -2145,8 +2146,7 @@ int alloc_slab_obj_exts(struct slab *slab,
struct kmem_cache *s,
                  * be simply assigned.
                  */
                 slab->obj_exts =3D new_exts;
-        } else if ((old_exts & ~OBJEXTS_FLAGS_MASK) ||
-                   cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_e=
xts) {
+        } else if (old_exts & ~OBJEXTS_FLAGS_MASK) {
                 /*
                  * If the slab is already in use, somebody can allocate an=
d
                  * assign slabobj_exts in parallel. In this case the exist=
ing
@@ -2158,6 +2158,8 @@ int alloc_slab_obj_exts(struct slab *slab,
struct kmem_cache *s,
                 else
                         kfree(vec);
                 return 0;
+        } else if (cmpxchg(&slab->obj_exts, old_exts, new_exts) !=3D old_e=
xts) {
+                goto retry;
         }

>
> >
> >>
> >>>        /*
> >>>         * If the slab is already in use, somebody can allocate and
> >>>         * assign slabobj_exts in parallel. In this case the existing
> >>> @@ -2152,6 +2157,7 @@ int alloc_slab_obj_exts(struct slab *slab, stru=
ct kmem_cache *s,
> >>>        return 0;
> >>>    }
> >>>
> >>> +out:
> >>>    kmemleak_not_leak(vec);
> >>>    return 0;
> >>> }
> >>>
> >>>>>
> >>>>>> --
> >>>>>> 2.25.1
> >>>>
> >>>
> >>
>

