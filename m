Return-Path: <linux-kernel+bounces-811404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B88B528A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B855175A82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5BA2580EC;
	Thu, 11 Sep 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xn79Xbsq"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7611CBA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757571614; cv=none; b=XHskawv8Hn/r9URkunqmApLA8JvHYKYwMWK5z+39dlWwkE7gc0Myl5FhxStLNHFwf4OWgX/Wrs7bXxTPClfQ2YzRS0LLYQ2h+5ZpD0spvS8u5jpKUbVteSX9h8ibZHFwsHwIJshASviRuC8zZrYg7J0rStnFPA3rp7NVTtKXQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757571614; c=relaxed/simple;
	bh=+OcTPhDXmteRe1PNLIfDFfpfOT4FMCkRaR60k0PaIgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSCVaWTt08e/2ZaiSWL9JBV3LbuUu07hUthd9FcejEbv3EvJbhtulSWgaZhV+v+8FUqB/u/uE+FlLSYVnzLr0Fokqlpw01kdR5M3nh6I1RhsEw9cDDlMQ6+Q7LHwR9t16obKgSbOO8if/2WzeYXShbltSVg8gmk0CiQaYfVP/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xn79Xbsq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCVpV05arJb/df2LDqwEGY92EPwb11YSWgjJEikbBwl0I5TUc5tGst6LWPnFnhBF/GFKOq2aSav3HIXNnxQ=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757571608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gW9kGgY5O1ezjweXONJKB6kktYtOO1YmCHdIBztrWyg=;
	b=Xn79XbsqbLl4R1+fOVr4W+sHo7icAgTQQF762ElORdpIJGIq1riEe6VeIEROhw+rk5uPSt
	zy7mi3q4ramyhrBcASxCrvxigNBdoKaVOvEqwY917SNCnPOmjHHl7YyGhXonOgiyVeD/Df
	KYxjD+uO0ItBOresAqjq4Q6Y/JyDPjU=
X-Gm-Message-State: AOJu0Yx00gkSnCPV4O5sfxga6KfTQGetWGKEGe1+ktGYoP7BuFkzgxlK
	wCVAUxqa1ewyrsMmM6noGVLVJMtQY4N6l2SYrPUN/ntXKABCaYls49zujsSGd5507jxmVbUScD2
	lVHLgECmf1PJIdYC2VOWAAgNK7UNcdi8=
X-Google-Smtp-Source: AGHT+IFGtnt2Vv6SnW1AjDnoJHfVqQd98eP0nU8GK5mtsYSq4Y3GNWAX/MZSUTzZwyESeMv3dbmLCN1SIFPpKRJDb6Q=
X-Received: by 2002:a05:6214:20a1:b0:720:e4bd:d3f3 with SMTP id
 6a1803df08f44-762245144aamr20961806d6.26.1757571592842; Wed, 10 Sep 2025
 23:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911021401.734817-1-balrogg+code@gmail.com> <9CD4E5BC-185A-47E6-9A2C-1B5416DC57EE@nvidia.com>
In-Reply-To: <9CD4E5BC-185A-47E6-9A2C-1B5416DC57EE@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Thu, 11 Sep 2025 14:19:13 +0800
X-Gmail-Original-Message-ID: <CABzRoyYo_dmzEJHQGiA3zc4uC_M9yKzEZ6L+VSbdG-t6fnahZA@mail.gmail.com>
X-Gm-Features: AS18NWAZxQBFYdwpNshSnWdM9G9E87ityKhXYKHZyrw40T9emGfPhd7ZwGCqXPs
Message-ID: <CABzRoyYo_dmzEJHQGiA3zc4uC_M9yKzEZ6L+VSbdG-t6fnahZA@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid poison consumption when splitting THP
To: Zi Yan <ziy@nvidia.com>, Andrew Zaborowski <balrogg@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miaohe Lin <linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 11, 2025 at 12:11=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 10 Sep 2025, at 22:14, Andrew Zaborowski wrote:
>
> > Handling a memory failure pointing inside a huge page requires splittin=
g
> > the page.  The splitting logic uses a mechanism, implemented in
> > migrate.c:try_to_map_unused_to_zeropage(), that inspects contents of
> > individual pages to find zero-filled pages.  The read access to the
> > contents may cause a new, synchronous exception like an x86 Machine
> > Check, delivered before the initial memory_failure() finishes, ending
> > in a crash.
> >
> > Luckily memory_failure() already sets the has_hwpoisoned flag on the
> > folio right before try_to_split_thp_page().  Don't enable the shared
> > zeropage mechanism (RMP_USE_SHARED_ZEROPAGE flag) down in
> > __split_unmapped_folio() when the original folio has has_hwpoisoned.

Nit: s/__split_unmapped_folio/__folio_split/

As Zi mentioned, remap_page() is called in __folio_split() ;)

> >
> > Note: we're disabling a potentially useful feature, some of the
> > individual pages that aren't poisoned might be zero-filled.  One
> > argument for not trying to add a mechanism to maybe re-scan them later,
> > apart from code cost, is that the owning process is likely being
> > killed and the memory released.
>
> Sounds reasonable to me.

Makes sense to me as well!

>
> >
> > Signed-off-by: Andrew Zaborowski <balrogg+code@gmail.com>
> > ---
> >  mm/huge_memory.c    | 3 ++-
> >  mm/memory-failure.c | 6 ++++--
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9c38a95e9f0..1568f0308b9 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3588,6 +3588,7 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
> >               struct list_head *list, bool uniform_split)
> >  {
> >       struct deferred_split *ds_queue =3D get_deferred_split_queue(foli=
o);
> > +     bool has_hwpoisoned =3D folio_test_has_hwpoisoned(folio);
>
> The state needs to be stored here because __split_unmapped_folio()
> clears the flag. Maybe add a comment here to prevent people
> from =E2=80=9Coptimizing=E2=80=9D it by calling folio_test_has_hwpoisoned=
(folio)
> in the code below.
>
> (I wanted to until I checked the definition of folio_test_has_hwpoisoned(=
))

folio_test_has_hwpoisoned() requires a large folio. That is safe in this
context, since this path is only ever called for large folios.

Cheers,
Lance

>
> >       XA_STATE(xas, &folio->mapping->i_pages, folio->index);
> >       struct folio *end_folio =3D folio_next(folio);
> >       bool is_anon =3D folio_test_anon(folio);
> > @@ -3858,7 +3859,7 @@ static int __folio_split(struct folio *folio, uns=
igned int new_order,
> >       if (nr_shmem_dropped)
> >               shmem_uncharge(mapping->host, nr_shmem_dropped);
> >
> > -     if (!ret && is_anon)
> > +     if (!ret && is_anon && !has_hwpoisoned)
> >               remap_flags =3D RMP_USE_SHARED_ZEROPAGE;
> >       remap_page(folio, 1 << order, remap_flags);
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index fc30ca4804b..2d755493de9 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2352,8 +2352,10 @@ int memory_failure(unsigned long pfn, int flags)
> >                * otherwise it may race with THP split.
> >                * And the flag can't be set in get_hwpoison_page() since
> >                * it is called by soft offline too and it is just called
> > -              * for !MF_COUNT_INCREASED.  So here seems to be the best
> > -              * place.
> > +              * for !MF_COUNT_INCREASED.
> > +              * It also tells __split_unmapped_folio() to not bother
>
> s/__split_unmapped_folio/__folio_split/, since remap_page() is
> called in __folio_split().
>
> > +              * using the shared zeropage -- the all-zeros check would
> > +              * consume the poison.  So here seems to be the best plac=
e.
> >                *
> >                * Don't need care about the above error handling paths f=
or
> >                * get_hwpoison_page() since they handle either free page
> > --
> > 2.45.2
>
> Otherwise, Acked-by: Zi Yan <ziy@nvidia.com>
>
> Best Regards,
> Yan, Zi
>

