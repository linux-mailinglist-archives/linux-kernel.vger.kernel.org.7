Return-Path: <linux-kernel+bounces-884604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7D4C30938
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 961E44F83C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4060F2D8774;
	Tue,  4 Nov 2025 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWhDA9eM"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BDF2D8362
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253131; cv=none; b=B+TELKTAPZ2DN50FufdPfQuYPt7DoipgdrTkFftJlUyvU3kPyGIq3SsN4JUYByRIx94Q08v1DnjQOFcq3BIbSb1sl5WDO/wUsgPwDW66mE/KMth72XJYtOcFSjl34QTwZPI1aQt0gO4azmtzN+uCLONSUkq73pgz3CAp5AyvuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253131; c=relaxed/simple;
	bh=UtT4hB4wz8X3bMAUgHhzNLv636yEuYMZWA2ZbRDp7ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5fLU1ArOFMnSfYCGWwzLb63X6gq/XRxWNdzjtO4NsBDwegyCxpac0eOT82AZWblkKV036vEJYDGppSX13VKDmDZvNSPZU5wRY7TRo/18Nacofn97xTN0dUCULSB+5UFrTq5TAxS8AfT69H85vZiB0UA1shOAh8g0LITeMU4qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWhDA9eM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4aed12cea3so965500566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253127; x=1762857927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrAQ1tstwLJDUUq1JtEKI2ptLUx1UO5CNRJ0YwBBWYg=;
        b=RWhDA9eM6X2Zmr921e1ULybXwQimDdDunW5NGkohI8d3QMbM/S2cetW34Zwe0aOYU5
         gxnc49Nt+zh7DynUz+piHp+rHAaBv8A8zlj4FP6+wvfU23BCHGP/Cw/Fn4mRkm60sqeW
         RWmSo0HrGIfHeaBGeh+YMtUJLHzdTuVRcOyVJbsAJFgU7uOPL8d0fmKvFVII0IrS2w9C
         iKzWEe06yEyD+bidIfil5EE35RONvjI3iw/809zsNbZ2eoYUbZf+u3LB4Hr2INcqRhMY
         jjptgdBxyc4YrgtCxBGZic8P61dZpjCJZOLhDZtBSbAYOn1kctdGdq3hFW1vYNHtiqYD
         QtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253127; x=1762857927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrAQ1tstwLJDUUq1JtEKI2ptLUx1UO5CNRJ0YwBBWYg=;
        b=XLyLwEhGMDr917+n0UfaUX4v2x/v4hhv1faAo9G1aNMxhRugvJ1EJx/vl6BqYKB8Lf
         2dLefmmM6ymh770p4VWa0MPduFFIw9eU2nC/CLzanlIcmoNvIhEUK7unveGRRrFuRC3K
         VIgQQNu8m+dsrAHsLGl/nDK0S7SlpH4YiYnoLhLIxZJjjAXvFMrvwlD3QA8PWYbMhrOA
         pfepRB49iPOJISNVCoZF9KzvWJftVaqaW+ROieoqp5qSdoDEdSV8uPMEoRxabi+Cweja
         AxlXE3EWCjnekjBPXJfpR1nrv3lzcg+gGwzd34TM0BQF/O/G4SJJ6B6dBfsOpYCeX2qz
         6lXg==
X-Forwarded-Encrypted: i=1; AJvYcCV26BkgI6f+Wk1b3id9+71CqN6Ov+FETP+TPfjJ2cEPRkxx371HNlvecN8Jfc1CVOXcBv4L6u4W9InAys0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39sul47mWRlCct/rcDzstXoE/W1dzXZfV07Vg5RJR1/qssXvA
	0LxNrTNcl/mK6nWjluOQGEc9WspH0xSUr9UGX7pnZIMBGxW91Tl+5fPgU0XezBf4Ylbe4gYF4IC
	ZQeHGaBu4Mr10oXUREwWz40/SBd3L3Rk=
X-Gm-Gg: ASbGncshuV4YyOx941yuuIAV1+7G3o2D67sfzsoFP90+1/GIE90lGVD8b3q7pB5JovJ
	yJQgNjNNdEErfx9dDcuIQsipo0s8zryTq7+S+jdJ99ZrjE5nb12K66myLonEekpRVwqqVhxdwpy
	lwexwBCgNzh98jg6l+rhx789m5aG7MwnKtjPa+mcQrjp/mFiXOsQ1bV9Nppt3UTL1BvTKEQN7Bs
	rthI/RQ0/bgrpHCrEalkuQbd8I0y55DCsekW538cQS1Y89g6WmlZo2yU9eY2ZmP
X-Google-Smtp-Source: AGHT+IEaCuYtWsLBUaCT9EKWFYKNWcQu6GTVXqPxrrHWQ7DA5N/s8CqAY4lUgmi5MjTuQPv3/sxjqCOfDtZbqoQ1cXY=
X-Received: by 2002:a17:907:3ea0:b0:b72:5380:f645 with SMTP id
 a640c23a62f3a-b725380fcc6mr140955866b.3.1762253126839; Tue, 04 Nov 2025
 02:45:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-3-3d43f3b6ec32@tencent.com> <CAGsJ_4xsUwUH_VyeYaXHURqTS66Fbuxa00GTM5izwK-=Vg_20g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xsUwUH_VyeYaXHURqTS66Fbuxa00GTM5izwK-=Vg_20g@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 4 Nov 2025 18:44:50 +0800
X-Gm-Features: AWmQ_bkH1skkIY2XCclQdBdauODDo9nzt-9MwbugyftrD-jN4_dDbPmfi1759Fg
Message-ID: <CAMgjq7DR9o+MmczWoT-p0=q6X-Ed3+qXe=fxj7_CKB77QLxsog@mail.gmail.com>
Subject: Re: [PATCH 03/19] mm, swap: never bypass the swap cache even for SWP_SYNCHRONOUS_IO
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 11:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Now the overhead of the swap cache is trivial, bypassing the swap
> > cache is no longer a valid optimization. So unify the swapin path using
> > the swap cache. This changes the swap in behavior in multiple ways:
> >
> > We used to rely on `SWP_SYNCHRONOUS_IO && __swap_count(entry) =3D=3D 1`=
 as
> > the indicator to bypass both the swap cache and readahead. The swap
> > count check is not a good indicator for readahead. It existed because
> > the previously swap design made readahead strictly coupled with swap
> > cache bypassing. We actually want to always bypass readahead for
> > SWP_SYNCHRONOUS_IO devices even if swap count > 1, But bypassing the
> > swap cache will cause redundant IO.
>
> I suppose it=E2=80=99s not only redundant I/O, but also causes additional=
 memory
> copies, as each swap-in allocates a new folio. Using swapcache allows the
> folio to be shared instead?

Thanks for the review!

Right, one thing I forgot to mention is after this change, workloads
involving mTHP swapin are less likely to OOM, that's related.

>
> >
> > Now that limitation is gone, with the new introduced helpers and design=
,
> > we will always swap cache, so this check can be simplified to check
> > SWP_SYNCHRONOUS_IO only, effectively disabling readahead for all
> > SWP_SYNCHRONOUS_IO cases, this is a huge win for many workloads.
> >
> > The second thing here is that this enabled a large swap for all swap
> > entries on SWP_SYNCHRONOUS_IO devices. Previously, the large swap in is
> > also coupled with swap cache bypassing, and so the count checking side
> > effect also makes large swap in less effective. Now this is also fixed.
> > We will always have a large swap in support for all SWP_SYNCHRONOUS_IO
> > cases.
> >
>
> In your cover letter, you mentioned: =E2=80=9Cit=E2=80=99s especially bet=
ter for workloads
> with swap count > 1 on SYNC_IO devices, about ~20% gain in the above test=
.=E2=80=9D
> Is this improvement mainly from mTHP swap-in?

Mainly from bypassing readahead I think. mTHP swap-in might also help thoug=
h.

> > And to catch potential issues with large swap in, especially with page
> > exclusiveness and swap cache, more debug sanity checks and comments are
> > added. But overall, the code is simpler. And new helper and routines
> > will be used by other components in later commits too. And now it's
> > possible to rely on the swap cache layer for resolving synchronization
> > issues, which will also be done by a later commit.
> >
> > Worth mentioning that for a large folio workload, this may cause more
> > serious thrashing. This isn't a problem with this commit, but a generic
> > large folio issue. For a 4K workload, this commit increases the
> > performance.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 136 +++++++++++++++++++++---------------------------=
--------
> >  mm/swap.h       |   6 +++
> >  mm/swap_state.c |  27 +++++++++++
> >  3 files changed, 84 insertions(+), 85 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 4c3a7e09a159..9a43d4811781 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4613,7 +4613,15 @@ static struct folio *alloc_swap_folio(struct vm_=
fault *vmf)
> >  }
> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > -static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> > +/* Sanity check that a folio is fully exclusive */
> > +static void check_swap_exclusive(struct folio *folio, swp_entry_t entr=
y,
> > +                                unsigned int nr_pages)
> > +{
> > +       do {
> > +               VM_WARN_ON_ONCE_FOLIO(__swap_count(entry) !=3D 1, folio=
);
> > +               entry.val++;
> > +       } while (--nr_pages);
> > +}
> >
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> > @@ -4626,17 +4634,14 @@ static DECLARE_WAIT_QUEUE_HEAD(swapcache_wq);
> >  vm_fault_t do_swap_page(struct vm_fault *vmf)
> >  {
> >         struct vm_area_struct *vma =3D vmf->vma;
> > -       struct folio *swapcache, *folio =3D NULL;
> > -       DECLARE_WAITQUEUE(wait, current);
> > +       struct folio *swapcache =3D NULL, *folio;
> >         struct page *page;
> >         struct swap_info_struct *si =3D NULL;
> >         rmap_t rmap_flags =3D RMAP_NONE;
> > -       bool need_clear_cache =3D false;
> >         bool exclusive =3D false;
> >         swp_entry_t entry;
> >         pte_t pte;
> >         vm_fault_t ret =3D 0;
> > -       void *shadow =3D NULL;
> >         int nr_pages;
> >         unsigned long page_idx;
> >         unsigned long address;
> > @@ -4707,57 +4712,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         folio =3D swap_cache_get_folio(entry);
> >         if (folio)
> >                 swap_update_readahead(folio, vma, vmf->address);
> > -       swapcache =3D folio;
> > -
>
> I wonder if we should move swap_update_readahead() elsewhere. Since for
> sync IO you=E2=80=99ve completely dropped readahead, why do we still need=
 to call
> update_readahead()?

That's a very good suggestion, the overhead will be smaller too.

I'm not sure if the code will be messy if we move this right now, let
me try, or maybe this optimization can be done later.

I do plan to defer swap cache lookup inside swapin_reahahead /
swapin_folio. We can do that now because swapin_folio requires the
caller to alloc a folio for THP swapin, so doing swap cache lookup
early helps to reduce memory overhead.

Once we unify swapin folio allocation for shmem / anon and always do
folio allocation with swap_cache_alloc_folio, everything will be
arranged in a nice way I think.

