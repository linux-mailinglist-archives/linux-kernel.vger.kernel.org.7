Return-Path: <linux-kernel+bounces-854926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3ABDFC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D25E4EC5FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1344E334397;
	Wed, 15 Oct 2025 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kjaqzwYK"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACF1E2834
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547119; cv=none; b=afLlNACEN2WRhGyNNhL8zh6bJbm+S/71QdqCh97YzgpZtvD6Ht3U3YQq62gug+svqgltfcRhrwuipzHyYskcX60RLKO31xtOkLtA03aHx3iwMB+6xovRB5Nc4tVwP1feEDjEKIvbvfr/oVgUTLzCec2K22FF9036DJ3l9uyaM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547119; c=relaxed/simple;
	bh=BDLolwCHz0ndTl+ov7KUUh1tJrFWg7dmSK/Z3A/brN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdYkB/XWmTNl0z6VPeyamHJwBgJNmY99Gd0BfjEKX1eRu6S9vmbwHqQZJLgw2Hoel3uIuq6JtJQPKitH41Av0iHe2MivEvsnjhgrOpDntwzwsLy03N74AJxnPblfh8/ZUU22L/s5kCWG1Tdt1yhJCzA3S44j1S1eVlo2M0nFKes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kjaqzwYK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so15067a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760547116; x=1761151916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9apsDayZRzDTw/yqZt7bxlKxNDmDz0cZMGpkHc07gM=;
        b=kjaqzwYKHavw8AkyKEJBA1sdTSJNVw0lbcsfnQbNhX0BQL3yiUQWtRp0981793JZqI
         qhCtmQum9mbnN+CU7IKQ5fPCULhkk8m8Q05iTlyO1X27JRIApYKj5ip5v4jtqQH6p9Vl
         Yr9d1zXLiEqO3dom5dSVUYnM9lZkDaogNCQkKo2ONBasUI8KVARdDlaGUuaWTpAVGbYB
         GrbHhBsKSNL2LKYsk+zZEQuCQ1izVk/rWooMv+YUreT5uYt5FP+/fRV8y6Mm3WmUCPf3
         tG4c9V6KfMCuiaZIgYBILUmA51FQ+y/JVZeV6VI+dOn4u23FehG4EH0sxetbCumlGI0F
         g8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760547116; x=1761151916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9apsDayZRzDTw/yqZt7bxlKxNDmDz0cZMGpkHc07gM=;
        b=UJ7n7YNhy4HEes3pDV1N0Cd8Yvi856zy41jQC0vAnAsGf92+Tp52qurOrDcIlSx1vI
         tOOXctkWj9Oj8nqU0TTWMAm0WdARtLCtPLAcbrHDC+P3gK+XPL8KAUcXwuvGdOl3NkkG
         TCj2/LJlFzua0zUjXWfowWdmn1Jvb06WirXNk8mzGE9k73Suot3Gv5FN69KIG2Hedpjc
         e0/efRfWdS0mQIB8cNZaRpePyLS+8msx5n0QExNkmF23LOmVmjnkART2aQRJlLJEALSr
         shRQJgAYMhs0DaIoSIRDLvn87eR0zSMgk6Qg/pngh3q/1zEC6U6hBmVQl8/hVBe5qv7X
         QbbA==
X-Forwarded-Encrypted: i=1; AJvYcCVqMPWqYIVDUZm77bZGt4LJPAwVIwpqWG+omBBbDviPg7Z4BPx+Q71pJ0Onx9UT0iEvP282huTOA9dbvfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxda/J4KMZoxGS6CIRI2UExC5mJGeUbzNzd72xZ8Pr+/ayrkg2g
	T5mpk2/iho0zR9Z7nrMrbqy0qL8B/Pz/2//L0L3a7cxhQ+qMCyfDHYXt1LSCRSnv64hmx13uBUd
	/HdUPSiINV6nLATINZnDCugz0tGbXAgGx+00k8dCX
X-Gm-Gg: ASbGnctqYDnD2h3pvG46LHPiD6BUydOjOkkQrUNoAZTL5ANTQLc9t9E5z3aMcxL8UZC
	XAMSzrLuQhhPVEYpRvZw7m8rG+hL3R/cCz0yri2i943qLmoVX3Gkq3coHvO5olGulpAK1LKlCKX
	6p5MFAEMK+Bh3IOhHO13hBOaIar6daW8YUADiCB/oNFveEFMJU1XgiUe+Lusdpz1gzd38lRm8jt
	RZohUHOu18h59JaCk7Bq0oolJD4cUcRceLAfKmRlCEAtqoo9mh5Qm6FzyDUz48Ay16Ifjl17uXb
	iBmc0dOa
X-Google-Smtp-Source: AGHT+IFdygiMrtAr3w7DSDw7JV9029btHscJYvjgfYSwaS21yzc+Kl0Y+SRoposbiwbIa6UvUKMeWDqflKBTeUkbkUk=
X-Received: by 2002:a05:6402:2346:b0:634:909c:d3c with SMTP id
 4fb4d7f45d1cf-63bebf9d4c8mr145952a12.2.1760547115463; Wed, 15 Oct 2025
 09:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141642.700170-1-hao.ge@linux.dev> <CAJuCfpEpO_HaJuV3ukDtTdw_5zCq9R0MnMexC5PoEwOcKWjuYg@mail.gmail.com>
 <6728a58d-7849-4eba-bce4-68968dd55afe@suse.cz>
In-Reply-To: <6728a58d-7849-4eba-bce4-68968dd55afe@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 15 Oct 2025 09:51:42 -0700
X-Gm-Features: AS18NWDqQ41FVH8ZYboWxXt6zcq7Vx8LpxfxJ3nRfWr_DO8FT0wuSBcm_pg4RZo
Message-ID: <CAJuCfpEMqh81=Cx0jnrxFnjV3wYOisoOLUoHi6gzbb0XRsQ-Rw@mail.gmail.com>
Subject: Re: [PATCH v5] slab: reset obj_ext when it is not actually valid
 during freeing
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Hao Ge <hao.ge@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Alexei Starovoitov <ast@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:37=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 10/15/25 18:29, Suren Baghdasaryan wrote:
> > On Wed, Oct 15, 2025 at 7:17=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote=
:
> >>
> >> From: Hao Ge <gehao@kylinos.cn>
> >>
> >> If obj_exts allocation failed, slab->obj_exts is set to OBJEXTS_ALLOC_=
FAIL,
> >> But we did not clear it when freeing the slab. Since OBJEXTS_ALLOC_FAI=
L and
> >> MEMCG_DATA_OBJEXTS currently share the same bit position, during the
> >> release of the associated folio, a VM_BUG_ON_FOLIO() check in
> >> folio_memcg_kmem() is triggered because it was mistakenly assumed that
> >> a valid folio->memcg_data was not cleared before freeing the folio.
> >>
> >> When freeing a slab, we clear slab->obj_exts and reset it to 0
> >> if the obj_ext array has been successfully allocated.
> >> So let's reset slab->obj_exts to 0 when freeing a slab if
> >> the obj_ext array allocated fail to allow them to be returned
> >> to the buddy system more smoothly.
> >>
> >> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >> ---
> >> v5: Adopt the simpler solution proposed by Vlastimil;
> >>     Many thanks to him
> >> ---
> >>  mm/slub.c | 10 +++++++++-
> >>  1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/slub.c b/mm/slub.c
> >> index b1f15598fbfd..2e4340c75be2 100644
> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -2170,8 +2170,16 @@ static inline void free_slab_obj_exts(struct sl=
ab *slab)
> >>         struct slabobj_ext *obj_exts;
> >>
> >>         obj_exts =3D slab_obj_exts(slab);
> >> -       if (!obj_exts)
> >> +       if (!obj_exts) {
> >> +               /*
> >> +                * If obj_exts allocation failed, slab->obj_exts is se=
t to OBJEXTS_ALLOC_FAIL,
> >> +                * In this case, we will end up here.
> >> +                * Therefore, we should clear the OBJEXTS_ALLOC_FAIL f=
lag first when freeing a slab.
> >> +                * Then let's set it to 0 as below.
> >> +                */
> >> +               slab->obj_exts =3D 0;
> >>                 return;
> >> +       }
> >
> > How about this instead:
> >
> > static inline void free_slab_obj_exts(struct slab *slab)
> > {
> >         struct slabobj_ext *obj_exts;
> >
> >         obj_exts =3D slab_obj_exts(slab);
> > +        /*
> > +         * Reset obj_exts to ensure all bits including OBJEXTS_ALLOC_F=
AIL
> > +         * are always cleared.
> > +         */
> > +        slab->obj_exts =3D 0;
> >         if (!obj_exts)
> >                 return;
> >
> >         /*
> >          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore i=
ts
> >          * corresponding extension will be NULL. alloc_tag_sub() will t=
hrow a
> >          * warning if slab has extensions but the extension of an objec=
t is
> >          * NULL, therefore replace NULL with CODETAG_EMPTY to indicate =
that
> >          * the extension for obj_exts is expected to be NULL.
> >          */
> >         mark_objexts_empty(obj_exts);
> >         kfree(obj_exts);
> > -        slab->obj_exts =3D 0;
>
> You have an older base, check current mainline, we evaluate slab->obj_ext=
s
> later in the function

Ah, sorry about that. Yeah, then this looks good.

>
> > }
> >
> >>
> >>         /*
> >>          * obj_exts was created with __GFP_NO_OBJ_EXT flag, therefore =
its
> >> --
> >> 2.25.1
> >>
>

