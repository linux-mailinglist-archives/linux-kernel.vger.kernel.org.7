Return-Path: <linux-kernel+bounces-809279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7CFB50B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 04:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00B33B752D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A0F2153E7;
	Wed, 10 Sep 2025 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBA0iCu5"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098B191
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757471475; cv=none; b=WGcYB9rqlu8QKDCPXpFYkGbLEfGZf3Ub6pNs7KcJIzShPjoZdZZjAaEm3NMDtIILb7GFoKjvaN6eqUK3nhXHhtHua3NBqeNHhnvR0Wu6vTu4NID/UPqLd7nEJZdBOvEtGnp3zNgfmFN7V+xJsoyjewgchzSHQhVB2Vop6OOMI44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757471475; c=relaxed/simple;
	bh=rbJQ+ubwAoq3bIhkrlJgD214+CQ5EbWK8AJ+rfvVgZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTHd1LR9R4ioG8XQLWep29vwWBANYAe7Z7VZOJh7KDkrH6BGoVVL4Oux+2554s7Xw/QibRHgqhVa2u1twqE/k16AXv/PxmYd4AWdxBRmfws/GHnJVJX0qabGgzfE0/z8Tr7RPGY6ZLQkgDEr/Eu+eDInaPkl+Cl4pQhYfJo8DeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBA0iCu5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-724b9ba6e65so48807407b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757471473; x=1758076273; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gGYOV2JHkr+pmYrSJQK9SOPoU4vgjNE883gSiydCMeY=;
        b=jBA0iCu5dGMmDa/R24uOrfoqVmGdjKXmsk8VxUm9zDFXUUbci+1y9+iF6ziCdQ6wxK
         roQp39FKo6ooRjW/6GGOli9WgR34T/tES4Hnq3DPxtA7z5wtLkQSw1kaeorpnn3x/qSm
         3B3/uOETWNnpif0tfqM3QSg9v+wMmQ0heFlSV8wqEQFBfYeO4WBBYLdCkyyGnhgSL4Vc
         uJ7CYxzquwEAwQOgZwXUFuMO2/iWxM6jxK9pczdEBscvz2l1o/ZNEB79kP68O+FTUM89
         qYygmbbIeUSh7C4kfXAzXUP8+LGI7K2l4hDQr6rvisu6pY3oHlcXvGETmuZnopqmPPmT
         GHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757471473; x=1758076273;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGYOV2JHkr+pmYrSJQK9SOPoU4vgjNE883gSiydCMeY=;
        b=gw9VH5bixkydH1adiu6sxRyJEWw8cCsqWjex+ZeCz3FV7GFM6+26cdVAhdvQTd6+SD
         8jzfDID7A3k1CZOWJKYT33Y3PBqEmhMpySpigMl7DgmeEDLaLWAI2k7UH+/2uIVeezSh
         Yzs32bte08ni3wzaUaLNkivD+DVYxFMXnlYsavq11wgbD+cjmAutl5lKvzXoy7ePW+L4
         Km6pqEuK9B0lMMxCrUDGQ3rFHS9BE3UgXaX406BTXm4NWACeoMo92RiSXTWngWULy8s+
         1RkwcgwbWh9isNfZujiaZGjZJbHCL5/y6ugLGMGRAu8Iv/D5bDclFVcJ4UH8edHo+a9f
         TJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNDFZHWSBSMrH5A9mFA8t7hKg4jVZVNfIQ7Cc+lpa3sBsRbyBGYgTPzT6SDOcPartGgjKfTWJrcqxhS1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcFT9swALpyr3m1GRFiqmz/4PPlPXQA+cEjBGddB5BpOSoo6a5
	l+EnbtmFOrOjnoSvpmwOoNuLHGVtqM9zq1UREwV/pgK++oWslcq3IVD6WLirKEHK/O3gDip6HmR
	XAhLveUUz28MlcyZ80ryHC46VYSV295s=
X-Gm-Gg: ASbGncsw0HFU4tresM2Ihe7OWfnsTXAK7+A+XqTDIEB2fFYDOoSJ5EqoHY+jU6vHYdz
	Xl/wWpGomO6jMgn7gv8DLV4WfqS9bNbqpPArXv26MnoaUzg4DCzshJvFQ01KQiXGRZLpe1PmRTg
	iiriJ2f/Ld5RDaiwa2NkFnl+xf9fcx3QHe2lTHo/SagOdNJ189DEoJ3aUTqJVVhUJje1BncE7TA
	kktG0Hq3jCqUcj7B0E=
X-Google-Smtp-Source: AGHT+IGkuYKbHclUoNcOzVWw7oQ2X7bUKO4dFGcNmQ9KJ9GMuUtVZDutEeAw8KLoj4aY+JeJ03Z9Ze8oC7BtIPAvMTU=
X-Received: by 2002:a05:690c:9689:b0:720:5db:1220 with SMTP id
 00721157ae682-727f27de65cmr110345907b3.8.1757471472702; Tue, 09 Sep 2025
 19:31:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910005957.54108-1-rgbi3307@gmail.com> <aMDW1urp03myzZFi@hyeyoo>
In-Reply-To: <aMDW1urp03myzZFi@hyeyoo>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Wed, 10 Sep 2025 11:31:01 +0900
X-Gm-Features: AS18NWDwwoRllFR4k3dRG-FUT86xf3SeEZv7mFkYHOI7mhydYUgFVRvyPwSwbbU
Message-ID: <CAHOvCC695c3fBphYvVz0Gk3H2hR9O2GaQLPvOVSZbUyv5C5rwg@mail.gmail.com>
Subject: Re: [PATCH] mm/slub: Removing unnecessary variable accesses in the get_freelist()
To: Harry Yoo <harry.yoo@oracle.com>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rgbi3307@naver.com
Content-Type: text/plain; charset="UTF-8"

Hi, Harry Hyeonggon Yoo,

Thank you for your kind and detailed reply.

I hadn't thought of the union data type.

Since the counters, inuse, and frozen members are unioned within the
slab structure,
there is the problem that the above values are not applied to
__slab_update_freelist() and try_cmpxchg_freelist() if the existing
code is not followed.

I canceled my patch request.
I apologized for my inconvenience.

On Wed, 10 Sept 2025 at 10:39, Harry Yoo <harry.yoo@oracle.com> wrote:
>
> Hi Jaejoon,
>
> I updated my email from 42.hyeyoo@gmail.com to harry.yoo@oracle.com
> a while ago. Please check up-to-date MAINTAINERS file when sending a patch.
>
> On Wed, Sep 10, 2025 at 09:59:56AM +0900, JaeJoon Jung wrote:
> > It pass a NULL pointer to the freelist_new variable
> > in the __slab_update_freelist() function so that it don't have to re-fetch
> > the variable values inside the while loop.
>
> No, it needs to re-fetch values when cmpxchg fails.
> Otherwise it would fall into an infinite loop, no?
>
> at a high level overview, cmpxchg works like this (atomically, of course):
>
> retry:
>     old = var;
>     // modify some bits in 'old' and store it to 'new'
>     new = old + something;
>     if (var == old) { // compare
>          var = new; // exchange if the value is expected
>     } else {
>         // if var != old, someone else updated the variable. retry
>         goto retry;
>     }
>
> and this retry will certainly fail if you don't you re-fetch the value,
> modify it, and try cmpxchg again. The 'old' value fetched before failing
> cmpxchg will not match anymore because other CPUs already updated that
> variable.
>
> > Removing unnecessary variable accesses as shown below
> > will reduce the code size of the get_freelist() function and make it faster.
> >
> > Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
> > ---
> >  mm/slub.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index d257141896c9..2e305a17a9d7 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3654,27 +3654,14 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
> >   */
> >  static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
> >  {
> > -     struct slab new;
> > -     unsigned long counters;
> > -     void *freelist;
> > -
> >       lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> >
> > -     do {
> > -             freelist = slab->freelist;
> > -             counters = slab->counters;
> > -
> > -             new.counters = counters;
> > -
> > -             new.inuse = slab->objects;
> > -             new.frozen = freelist != NULL;
>
> ...and the frozen and inuse bits are part of counters field,
> so they are not updated anymore?
>
> > -
> > -     } while (!__slab_update_freelist(s, slab,
> > -             freelist, counters,
> > -             NULL, new.counters,
> > +     while (!__slab_update_freelist(s, slab,
> > +             slab->freelist, slab->counters,
> > +             NULL, slab->counters,
> >               "get_freelist"));
> >
> > -     return freelist;
> > +     return slab->freelist;
> >  }
> >
> >  /*
> > --
> > 2.43.0
>
> --
> Cheers,
> Harry / Hyeonggon

