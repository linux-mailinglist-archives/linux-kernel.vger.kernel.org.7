Return-Path: <linux-kernel+bounces-792644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F5FB3C725
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 03:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C994720221A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06A23C506;
	Sat, 30 Aug 2025 01:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLSQk+gh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D986321D59C
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756518153; cv=none; b=Me5QOajuifNl3O5p6NeBnnhR8iw15/YvduBnhS8Ndlg2yj9+MOYyiPBvMtjCaawkX/NpK+b6mPuYeqKNPi2mnDctqYEECLHQ4OkAIbOjgv1sonB32XgLT+/3828wZt5ivmL+pdXS/rj6SsP+oLAwhp0RpvkMXHJj7OeOANOHQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756518153; c=relaxed/simple;
	bh=1BdOkDsxUViW8TkDK+QZwdvtemhOptK1QYTppmdS15w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE5E92/vxv1qgCUTU7tN3AhGcXwfTBsNwzMvrKOTeTjPoe5xAXHJHlrfBu44QHT+gOfRdF+8LraWfWm0Yl3WmtZBNeItmzI8xu1lg9YokCQ+dlVHHsgy+sDy1jxV4FKNsx1Eco+oWhNaOsMcARIoptBkloWSicWeoUcdm0Y6QSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLSQk+gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57632C116B1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756518153;
	bh=1BdOkDsxUViW8TkDK+QZwdvtemhOptK1QYTppmdS15w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dLSQk+ghgYBTuTx/kf1oHly3EU51ydMwzoisWx3mOhtis2b6l2H3YwcubVAwunJY1
	 Pmxy7bpUBUOpwGWKbNewYVfZYaP+c+AOEn6yLv91JN6k2l9ObFS6HcV/bHxkT6GS/C
	 b8facSsn8bePGIXZe3UazGbvPcKOGWz8+H4VJk4QMCwXjP6kDH7OpBzV1tntcXa+v9
	 9xji8RgQldK7wGhxIagfIcnctXvM36oriOY3hJOhCgV0Cy4PofQl5Tabw4fO9nL/8D
	 ZX1yHVRqoEYG/ywHJJO3EeKkDIbLvqCG1FhtFeNnl3tanZIXlQvcYOHK22GFNZfwMD
	 QU3ZZSr/3/2Mg==
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e970a7f0e54so2302854276.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:42:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWYPXIbkuubbL1k3kbcecZyl7/eZNgwWVrZeUMQ27o7TaQWMv97WmnE41D21sqmMPdeJ7g0xtV7cr8Ac/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNe/AiCQ1lxyEkr8QU81L5bJwdQ1TDwiMYD6ZZPaMvrWSNzk4
	sh3/KmlP2ylAI03lDfnwQdUilnf9RcFxt91SaTJx4YS295qtkwDQ1RlKOp75D2CwPPBEgVYY/AA
	Ny0Z1HFhiqDdiyLHL60y0gkVn0nAvwlEtF72Ehm0cmQ==
X-Google-Smtp-Source: AGHT+IHF6KxVOHS3kToYOuE6Kd/lPQ/gBnZx1Kg68zofo0+ra/ynZ0uZP+ZHCp18rV6vFNpvM39l7s2nZtXQUnYJhMg=
X-Received: by 2002:a05:690c:4803:b0:71f:b944:ffc with SMTP id
 00721157ae682-7227657ee6cmr6792617b3.47.1756518152404; Fri, 29 Aug 2025
 18:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuMX_WTg7vyACBxskNmDHB4C-ZkowuKYP71gQ8qyKuwAaA@mail.gmail.com> <CAMgjq7D3EiLOyEQiR+Uq6mTdXajMCg4+A+KRZajE91kbTw=tHg@mail.gmail.com>
In-Reply-To: <CAMgjq7D3EiLOyEQiR+Uq6mTdXajMCg4+A+KRZajE91kbTw=tHg@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 18:42:20 -0700
X-Gmail-Original-Message-ID: <CACePvbUYDfne6mZ32c3YzxcwH16u-G3YXoYoGaXL5EtxjDH8mw@mail.gmail.com>
X-Gm-Features: Ac12FXzMEbrDM4n3UP1sqECYx8QlPnei49nlNt0dz5bDLhFiqVQ13GZT36zH2fw
Message-ID: <CACePvbUYDfne6mZ32c3YzxcwH16u-G3YXoYoGaXL5EtxjDH8mw@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

Sorry for the late reply. I have been super busy this week.

On Wed, Aug 27, 2025 at 6:44=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Aug 27, 2025 at 4:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 10ef528a5f44..9ca8e1873c6e 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4661,12 +4661,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >                 goto out;
> > >
> > >         folio =3D swap_cache_get_folio(entry);
> > > -       if (folio) {
> > > -               swap_update_readahead(folio, vma, vmf->address);
> > > -               page =3D folio_file_page(folio, swp_offset(entry));
> > > -       }
> > >         swapcache =3D folio;
> > > -
> >
> > Can simplify as:
> >            folio =3D swapcache =3D swap_cache_get_folio(entry);
>
> checkpatch.pl is unhappy about it:
>
> checkpatch: multiple assignments should be avoided

Ah, never mind then. I actually like multiple assignments but I can
see checkpatch wants to ban it.

>
> >
> > >         if (!folio) {
> > >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > >                     __swap_count(entry) =3D=3D 1) {
> > > @@ -4735,20 +4730,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >                 ret =3D VM_FAULT_MAJOR;
> > >                 count_vm_event(PGMAJFAULT);
> > >                 count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > > -               page =3D folio_file_page(folio, swp_offset(entry));
> > > -       } else if (PageHWPoison(page)) {
> > > -               /*
> > > -                * hwpoisoned dirty swapcache pages are kept for kill=
ing
> > > -                * owner processes (which may be unknown at hwpoison =
time)
> > > -                */
> > > -               ret =3D VM_FAULT_HWPOISON;
> > > -               goto out_release;
> >
> > Here you move the HWPosion(page) bail out from before taking the page
> > lock to after the page lock. The HWPosion page should be able to bail
> > out without taking the lock.
> >
> >
> > >         }
> > >
> > >         ret |=3D folio_lock_or_retry(folio, vmf);
> > >         if (ret & VM_FAULT_RETRY)
> > >                 goto out_release;
> > >
> > > +       page =3D folio_file_page(folio, swp_offset(entry));
> > >         if (swapcache) {
> > >                 /*
> > >                  * Make sure folio_free_swap() or swapoff did not rel=
ease the
> > > @@ -4757,10 +4745,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >                  * swapcache, we need to check that the page's swap h=
as not
> > >                  * changed.
> > >                  */
> > > -               if (unlikely(!folio_test_swapcache(folio) ||
> > > -                            page_swap_entry(page).val !=3D entry.val=
))
> > > +               if (!folio_contains_swap(folio, entry))
> > >                         goto out_page;
> > >
> > > +               if (PageHWPoison(page)) {
> > > +                       /*
> > > +                        * hwpoisoned dirty swapcache pages are kept =
for killing
> > > +                        * owner processes (which may be unknown at h=
wpoison time)
> > > +                        */
> > > +                       ret =3D VM_FAULT_HWPOISON;
> > > +                       goto out_page;
> >
> > It seems you bail out with the page still locked, that seems like a bug=
 to me.
>
> I think it's the original behaviour that is kind of fragile. The
> returned folio of swap_cache_get_folio is unstable unless locked, so
> the folio could have been removed from swap cache or marked by some
> other threads as Poisoned. So the PageHWPoison here could be tested
> against an unrelated page, which leads to false positive PageHWPoison
> results. We have encountered several similar bugs due to using folios
> returned by swap cache lookup without lock & checking first.
>
> So checking HWPoison after locking is actually safer.

How do I verify the code can handle HWPoison from unlock to lock page?
I haven't followed the HWPoison path very much. I am still wondering
how does the HWPoison code handle the page previously unlocked, now
become locked and without any additional code change?

If you want this behavior, I strongly suggest you split this portion
of the change out, ideally outside this 9 series if you can afford to
do so.

This patch description has nothing mentioning this kind of subtle
behavior change, as a reviewer I am caught off guard by this. At the
very least the commit should mention this. Talk explains why this
change is needed and why it is safe to do so.

Having very subtle behavior changes buried in a large code restructure
change is the worst. Splitting it out will reduce the reviewer's
workload to reason this behavior change, and makes your series easier
to review.

Does it make sense?

Chris

