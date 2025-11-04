Return-Path: <linux-kernel+bounces-885419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14565C32D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65AFC18993C3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F152DC320;
	Tue,  4 Nov 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtNSAabS"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855270809
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285960; cv=none; b=i5mWyTVxoBRkjNAhvlEWb53/ia2PHA2Fy/gdEqm+IIlCfvNm9kbI75WqnZu2pnHI8Hzrr5ZD2j6jLUcTaW5HlTQHhWgc7p4Slr9pRi+hmqsnMoP4TLbm2u8Pk5EeHv7pjRIQJ1E/IaB2CKTmw5G7942d100RH2oe76RCq2b/ei0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285960; c=relaxed/simple;
	bh=2hYSFKUA//hwRd4nbzKq2kF3Fq1WAG/5+5f1s0LKR8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLac5QXnNNJQG6C3gkmF8wzHG62k4HszeOVn7N0TFjqA7Efcv1W6gIdFcg0tP+QBAHrOWLlfhB3skTA2yay5TwWf4UPRYzsUc+OTUFkblBWHYvgvS9u+F4UOdv4kpFpIxw64kUvncRHYxA/ypTW+I+ija/e/vcNuOZUDMRk1tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtNSAabS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed72cc09ddso1689141cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762285958; x=1762890758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhuUACoe017FfPrBL9Y+3E62APiFcTixj+edYubzRZY=;
        b=dtNSAabSeLKm/01WRJ51p+PtjeyXjbC4ia/GOTMak3MH0uHehFLmDb1T9xCpknFaKC
         ZOcHqWfWJYB/B+jsJ0v6zI2B0A6gXtJAkVuckO8YABYgmxTEPiBBGlaMINTxfzHutt6C
         bauLgmfv5qx/ouzCkfeQimo5nWaV73MbZf3fXaSwRkFB+mYIOguW+xgb7AGHbBNDKjXB
         RXGPlNvmFF/XfGRkQv4AKLIHGu9bqTvLxmTkiYAQzj0kDt6Lt8ZBmXnM5c10BXfkCVL+
         ZRS1gIyGpeM9pHoF9NZyRo/CUYvqeQaplHXzOZpchmxB6dxB+7XPBnS39/zB/jGKIjD1
         rmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762285958; x=1762890758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhuUACoe017FfPrBL9Y+3E62APiFcTixj+edYubzRZY=;
        b=DnX6F3Ic+aLQmdKvUsUb41AE6T77nyfkBX/7ppuZRDWsxhCJZ3c79pxHsxMyFLkCUg
         fKpVowjObsmoLCzCo0/4K0fLGtUc6kpeuzVd6hS09x+0D0EV3sWteZKoE7fIw6gtVKVz
         koSmlaRATjvot1bo+lvZ9HTzW6TgqFjMq8F3lZDw/HVJ7Tu2WFBB670y/qcWOJvbCYiY
         keuF2QVAyfGCip9854BJkLOmbub1y3+L+kDi9ut+hq0gxmlmvltykTpY5tryBp740FvL
         ON+VXnV1cIfRxKWOZDC4I21CQcOFf1yUrDgURegwJbnrKCVTAwafVl/dUaY1KWGCvYK7
         0ASQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMExC5A2lilR83j8z2/EWS55PVfPNh9eCK+/ACXfmL7+UPu4t/RaNeyqDzhvIEESVhgSiG98JFtHHV6eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5z3M3ZJj2K5tLrjGhs93JldNe7Vz8bqmroZCyyRUtjg6JUEV
	mmCCWmK1VeuO8GxkGrEALbHgDFfwac+G/CIwDY+j6QwmAPJ/eTJ8t5uUkTYUy2/Mh6+obgCqI+j
	3Mmc0zorivgVqR5KxcMls63aTA0Aqj0s=
X-Gm-Gg: ASbGncvvexoAtT8GFkqemBnU/wgoKeMVvPL4kERY/FOI16eka2dkwDz78rArf6tyk2R
	FtXEx6X6GXb9NlVzC9BDu7zVqZIdcJo5dOLaTVPc93We5XThd4RWrDZZtbSzod6ZJ45Y62c5ZoT
	i2e/X1WHs1lVTrOaQFUoJjJ3hb+Hv4jTu8pxYEU2qslNltkO0V6z4by+hNqu0GrW1XjT4PI77Ne
	WHL2vH/StM81bRgUbEzI1t8XEm2ivWmVOM7uCseqpEgci5MUf3b8z41qHl7DA5wQ+WRvjCu97+C
	IPp/QkSOWnmJ16PW
X-Google-Smtp-Source: AGHT+IErS0dFQ9jSDtfrpY3erXURu4B0wJ5JPQIqfYmbvt+/0DnjutNzhFHJ5wyZ+GLxm+MijMOW2D+SuD0mqWz0CIk=
X-Received: by 2002:a05:622a:424d:b0:4c7:130f:72ef with SMTP id
 d75a77b69052e-4ed72347647mr10478241cf.9.1762285957761; Tue, 04 Nov 2025
 11:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-6-3d43f3b6ec32@tencent.com> <CAGsJ_4z1gB8x7GNUL4THdC7G9ZGMqbM3UtWM2LXPoT0xcLAQ3A@mail.gmail.com>
 <CAMgjq7CV14FdHvgGtXwWQPqXKwy4W-5vfR=-hUYkBemeMP=Srw@mail.gmail.com>
In-Reply-To: <CAMgjq7CV14FdHvgGtXwWQPqXKwy4W-5vfR=-hUYkBemeMP=Srw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 5 Nov 2025 03:52:25 +0800
X-Gm-Features: AWmQ_blYiz9VoLZN8wpGXcrjgSu3kDWfO42m1wTALvWOvIpMx5_FNki1QlYNF54
Message-ID: <CAGsJ_4z47L4u50xdv9opC4QN6Jtdx6oR7xVx6WCGCtUa_CqMQQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] mm, swap: free the swap cache after folio is mapped
To: Kairui Song <ryncsn@gmail.com>
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

On Tue, Nov 4, 2025 at 6:51=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Tue, Nov 4, 2025 at 5:15=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Wed, Oct 29, 2025 at 11:59=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > To prevent repeated faults of parallel swapin of the same PTE, remove
> > > the folio from the swap cache after the folio is mapped. So any user
> > > faulting from the swap PTE should see the folio in the swap cache and
> > > wait on it.
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/memory.c | 21 +++++++++++----------
> > >  1 file changed, 11 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 6c5cd86c4a66..589d6fc3d424 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4362,6 +4362,7 @@ static vm_fault_t remove_device_exclusive_entry=
(struct vm_fault *vmf)
> > >  static inline bool should_try_to_free_swap(struct swap_info_struct *=
si,
> > >                                            struct folio *folio,
> > >                                            struct vm_area_struct *vma=
,
> > > +                                          unsigned int extra_refs,
> > >                                            unsigned int fault_flags)
> > >  {
> > >         if (!folio_test_swapcache(folio))
> > > @@ -4384,7 +4385,7 @@ static inline bool should_try_to_free_swap(stru=
ct swap_info_struct *si,
> > >          * reference only in case it's likely that we'll be the exclu=
sive user.
> > >          */
> > >         return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(fo=
lio) &&
> > > -               folio_ref_count(folio) =3D=3D (1 + folio_nr_pages(fol=
io));
> > > +               folio_ref_count(folio) =3D=3D (extra_refs + folio_nr_=
pages(folio));
> > >  }
> > >
> > >  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> > > @@ -4935,15 +4936,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >          */
> > >         arch_swap_restore(folio_swap(entry, folio), folio);
> > >
> > > -       /*
> > > -        * Remove the swap entry and conditionally try to free up the=
 swapcache.
> > > -        * We're already holding a reference on the page but haven't =
mapped it
> > > -        * yet.
> > > -        */
> > > -       swap_free_nr(entry, nr_pages);
> > > -       if (should_try_to_free_swap(si, folio, vma, vmf->flags))
> > > -               folio_free_swap(folio);
> > > -
> > >         add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > >         add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > >         pte =3D mk_pte(page, vma->vm_page_prot);
> > > @@ -4997,6 +4989,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >         arch_do_swap_page_nr(vma->vm_mm, vma, address,
> > >                         pte, pte, nr_pages);
> > >
> > > +       /*
> > > +        * Remove the swap entry and conditionally try to free up the
> > > +        * swapcache. Do it after mapping so any raced page fault wil=
l
> > > +        * see the folio in swap cache and wait for us.
> >
> > This seems like the right optimization=E2=80=94it reduces the race wind=
ow where we might
> > allocate a folio, perform the read, and then attempt to map it, only
> > to find after
> > taking the PTL that the PTE has already changed.
> >
> > Although I am not entirely sure that =E2=80=9Cany raced page fault will=
 see the folio in
> > swapcache,=E2=80=9D it seems there could still be cases where a fault o=
ccurs after
> > folio_free_swap(), and thus can=E2=80=99t see the swapcache entry.
> >
> > T1:
> > swap in PF, allocate and add swapcache, map PTE, delete swapcache
> >
> > T2:
> > swap in PF before PTE is changed;
> > ...........................................................;
> > check swapcache after T1 deletes swapcache -> no swapcache found.
>
> Right, that's true. But we will at most only have one repeated fault,
> and the time window is much smaller. T2 will PTE !=3D orig_pte and then
> return just fine.
>
> So this patch is only reducing the race time window for a potentially
> better performance, and this race is basically harmless anyway. I
> think it's good enough.

Right. What I really disagree with is "Do it after mapping so any
raced page fault
will see the folio in swap cache and wait for". It sounds like it
guarantees no race
at all, so I=E2=80=99d rather we change it to something like "reduced race =
window".

Thanks
Barry

