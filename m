Return-Path: <linux-kernel+bounces-788404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02950B383E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F25577AC57B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A81352FF1;
	Wed, 27 Aug 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdBRbmfo"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C530CDB3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302289; cv=none; b=kabkANirFamQOe3YjingEjaXjddYXy1+HOgylsaKUPYvach4BHwOV/Vbm1kYSDeXfI3Bkm92oIfjGjrzTsY/kYWuPkXchOPTWV0ZIXu+6z/g7j0goe5efz/jc2TD1xGx+L7Zk9jOpvTjeExHcHgNGy+AP8IGrwLRb0hAAyGmYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302289; c=relaxed/simple;
	bh=8weO0UGyGhQ7Lx3WSfc3Ona6g+pJEzYKSzkzqQYzMhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8C5T28YE8ltUcEEbD2Ve1j1DA6L4AVcPg5k917YRHb71WBgzUCKS3fRwO7UwvOTjNoAUzATUkSW2oyD1W3oZ/d+kbarOultYdkVTU/54mBYedtT/aruZ+v8KTyy8lRv54bDeay/hF5RTRUAZAE69xz4ZbYNLcDA/MZjKkPN0Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdBRbmfo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3367f35d031so21983301fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756302281; x=1756907081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xwolI3JL6HatAKk8RXMI3q1JurvvPS3JqRohVosR4A=;
        b=GdBRbmfoefjwfcCt+XsrxtPeEHOMBH7xk/quXNkk0wvgL0cLwoq8GANtOPzOP+9uN+
         7NXvO8jGePMt/84v+ry4CE23yN5hfDuM2rQN8DSLGS8yx8DeD3wuwBUZiXQMv5YJXOLh
         tAxY+orDEsqSOUBI/2RLZRDTz+3xc9nagBbjADvrWOL+25VIvTzecicug/7OsFtdeQhb
         NqtO5CHijagHX8GzbpKfc56pT013Ut6mh95xYXuzhP0XDPO92+EUG63hMTdwP8lSzd0G
         dUcw5SQesedkG9aKMscHXwV/SHMEZLuxVyz4+ZeZQBvdQL2qGrWPq0YL4eEH25aLROuJ
         XDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756302281; x=1756907081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xwolI3JL6HatAKk8RXMI3q1JurvvPS3JqRohVosR4A=;
        b=v21oXUc0mNLiC/Wu0Z161i15kvzlR9DZ+UnjFmOIH0UZT2Q+IWl8z7VLqdqTBvyNGB
         0EPApXqD/9R64H6GiNeFHvi9CC43BzO0K2Z4jVPzQ7hunnYWUGeNPXse6dAVedmjd56k
         Od4Q6sVxmlODlMhwFbsishkwAxtXX2BjZWaXvX6gJSw8TSYScEjSJcYeXY3OWKn9rdX5
         htlfxS4ZKoINxN+sWaTWtd4AUCILa7j9wPZObtxHL9YsQVlWrI7cx4GsuH7CrA1FBWG/
         XPIp3W7PFii0tiVSimqyxP+cjALwqDno3/YdQnw97lR9E1Z4+wQ9xLDQfOk8rt69INzu
         TRYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcu/TGgAOZTyXHsMcX67cXZp/dR3t025PPxOyux+H/SKAPa0mNkcKNCoOn9zrsUNyXlVkFIW+gXd1umlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLgLc+ei2YTMUV4lrY2k6JjiM1tVPP7UTX1GX9+SgITf5NUcd9
	pU55JQWFrWEauMmgWfXcFPISAeU4qmACRugr1/QXd3HybpyoI9lqWgE+C3tYK0al5Hoh6McJQh2
	jEFuBY6uhmyLZvOc9JztWhCAphxBBuD8=
X-Gm-Gg: ASbGnctzbToyw9oK+UJ/zaRvMH7+6H9vl9oQF9AqfZt2Kqi14ghqiShzezOJtcwqBti
	gyc+TOboRwXfTrwzSvp/hWVhdzU1Z3RCV4smnz9nG8073hAWPufV23mvsPdCfmdEMoV17CaJq4n
	u6ciiy69sTafQAuSPT3xK2zT5faZPDNU9XdcS8zRRHHrl+2bL5JXK7FnsFgjyx1PDCY6QC1aYH1
	7XE+DE=
X-Google-Smtp-Source: AGHT+IGmYpQbpfuydC8NCsfBCwp183Em8dNqxVVVzvuFWJmjtTKiVrVr8p0Yg43IfJSD/pG8ONjOD4NvS6tNvLVFCHs=
X-Received: by 2002:a2e:ae0c:0:b0:336:4eee:6ea8 with SMTP id
 38308e7fff4ca-33695ac4dcfmr4568601fa.24.1756302281118; Wed, 27 Aug 2025
 06:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuMX_WTg7vyACBxskNmDHB4C-ZkowuKYP71gQ8qyKuwAaA@mail.gmail.com>
In-Reply-To: <CAF8kJuMX_WTg7vyACBxskNmDHB4C-ZkowuKYP71gQ8qyKuwAaA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 27 Aug 2025 21:44:04 +0800
X-Gm-Features: Ac12FXwvwDbIY__kyety6f-KXf8kie0xuSwLrgJfJB1wSgJirCCr99XWfP12D7U
Message-ID: <CAMgjq7D3EiLOyEQiR+Uq6mTdXajMCg4+A+KRZajE91kbTw=tHg@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Chris Li <chrisl@kernel.org>
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

On Wed, Aug 27, 2025 at 4:06=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Swap cache lookup is lockless, it only increases the reference count
> > of the returned folio. That's not enough to ensure a folio is stable in
> > the swap cache, so the folio could be removed from the swap cache at an=
y
> > time. The caller always has to lock and check the folio before use.
> >
> > Document this as a comment, and introduce a helper for swap cache folio
> > verification with proper sanity checks.
> >
> > Also, sanitize all current users to use this convention, and use the ne=
w
> > helper when possible for easier debugging. Some existing callers won't
> > cause any major problem right now, only trivial issues like incorrect
> > readahead statistic (swapin) or wasted loop (swapoff). It's better to
> > always follow this convention to make things robust.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/memory.c     | 28 +++++++++++++---------------
> >  mm/shmem.c      |  4 ++--
> >  mm/swap.h       | 28 ++++++++++++++++++++++++++++
> >  mm/swap_state.c | 13 +++++++++----
> >  mm/swapfile.c   | 10 ++++++++--
> >  5 files changed, 60 insertions(+), 23 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 10ef528a5f44..9ca8e1873c6e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4661,12 +4661,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 goto out;
> >
> >         folio =3D swap_cache_get_folio(entry);
> > -       if (folio) {
> > -               swap_update_readahead(folio, vma, vmf->address);
> > -               page =3D folio_file_page(folio, swp_offset(entry));
> > -       }
> >         swapcache =3D folio;
> > -
>
> Can simplify as:
>            folio =3D swapcache =3D swap_cache_get_folio(entry);

checkpatch.pl is unhappy about it:

checkpatch: multiple assignments should be avoided

>
> >         if (!folio) {
> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                     __swap_count(entry) =3D=3D 1) {
> > @@ -4735,20 +4730,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 ret =3D VM_FAULT_MAJOR;
> >                 count_vm_event(PGMAJFAULT);
> >                 count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > -               page =3D folio_file_page(folio, swp_offset(entry));
> > -       } else if (PageHWPoison(page)) {
> > -               /*
> > -                * hwpoisoned dirty swapcache pages are kept for killin=
g
> > -                * owner processes (which may be unknown at hwpoison ti=
me)
> > -                */
> > -               ret =3D VM_FAULT_HWPOISON;
> > -               goto out_release;
>
> Here you move the HWPosion(page) bail out from before taking the page
> lock to after the page lock. The HWPosion page should be able to bail
> out without taking the lock.
>
>
> >         }
> >
> >         ret |=3D folio_lock_or_retry(folio, vmf);
> >         if (ret & VM_FAULT_RETRY)
> >                 goto out_release;
> >
> > +       page =3D folio_file_page(folio, swp_offset(entry));
> >         if (swapcache) {
> >                 /*
> >                  * Make sure folio_free_swap() or swapoff did not relea=
se the
> > @@ -4757,10 +4745,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                  * swapcache, we need to check that the page's swap has=
 not
> >                  * changed.
> >                  */
> > -               if (unlikely(!folio_test_swapcache(folio) ||
> > -                            page_swap_entry(page).val !=3D entry.val))
> > +               if (!folio_contains_swap(folio, entry))
> >                         goto out_page;
> >
> > +               if (PageHWPoison(page)) {
> > +                       /*
> > +                        * hwpoisoned dirty swapcache pages are kept fo=
r killing
> > +                        * owner processes (which may be unknown at hwp=
oison time)
> > +                        */
> > +                       ret =3D VM_FAULT_HWPOISON;
> > +                       goto out_page;
>
> It seems you bail out with the page still locked, that seems like a bug t=
o me.

I think it's the original behaviour that is kind of fragile. The
returned folio of swap_cache_get_folio is unstable unless locked, so
the folio could have been removed from swap cache or marked by some
other threads as Poisoned. So the PageHWPoison here could be tested
against an unrelated page, which leads to false positive PageHWPoison
results. We have encountered several similar bugs due to using folios
returned by swap cache lookup without lock & checking first.

So checking HWPoison after locking is actually safer.

>
> I think this HWPoision() check move order with the page lock is problemat=
ic.
>
> Can you double check?
>
> To be continued.
>
> Chris
>
> > +               }
> > +
> > +               swap_update_readahead(folio, vma, vmf->address);
> > +
> >                 /*
> >                  * KSM sometimes has to copy on read faults, for exampl=
e, if
> >                  * folio->index of non-ksm folios would be nonlinear in=
side the
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index e9d0d2784cd5..b4d39f2a1e0a 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                         count_vm_event(PGMAJFAULT);
> >                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
> >                 }
> > -       } else {
> > -               swap_update_readahead(folio, NULL, 0);
> >         }
> >
> >         if (order > folio_order(folio)) {
> > @@ -2431,6 +2429,8 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
> >                 error =3D -EIO;
> >                 goto failed;
> >         }
> > +       if (!skip_swapcache)
> > +               swap_update_readahead(folio, NULL, 0);
> >         folio_wait_writeback(folio);
> >         nr_pages =3D folio_nr_pages(folio);
> >
> > diff --git a/mm/swap.h b/mm/swap.h
> > index efb6d7ff9f30..bb2adbfd64a9 100644
> > --- a/mm/swap.h
> > +++ b/mm/swap.h
> > @@ -52,6 +52,29 @@ static inline pgoff_t swap_cache_index(swp_entry_t e=
ntry)
> >         return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
> >  }
> >
> > +/**
> > + * folio_contains_swap - Does this folio contain this swap entry?
> > + * @folio: The folio.
> > + * @entry: The swap entry to check against.
> > + *
> > + * Swap version of folio_contains()
> > + *
> > + * Context: The caller should have the folio locked to ensure
> > + * nothing will move it out of the swap cache.
> > + * Return: true or false.
> > + */
> > +static inline bool folio_contains_swap(struct folio *folio, swp_entry_=
t entry)
> > +{
> > +       pgoff_t offset =3D swp_offset(entry);
> > +
> > +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > +       if (unlikely(!folio_test_swapcache(folio)))
> > +               return false;
> > +       if (unlikely(swp_type(entry) !=3D swp_type(folio->swap)))
> > +               return false;
> > +       return offset - swp_offset(folio->swap) < folio_nr_pages(folio)=
;
> > +}
> > +
> >  void show_swap_cache_info(void);
> >  void *get_shadow_from_swap_cache(swp_entry_t entry);
> >  int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> > @@ -144,6 +167,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t=
 entry)
> >         return 0;
> >  }
> >
> > +static inline bool folio_contains_swap(struct folio *folio, swp_entry_=
t entry)
> > +{
> > +       return false;
> > +}
> > +
> >  static inline void show_swap_cache_info(void)
> >  {
> >  }
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index ff9eb761a103..be0d96494dc1 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -70,10 +70,12 @@ void show_swap_cache_info(void)
> >  }
> >
> >  /*
> > - * Lookup a swap entry in the swap cache. A found folio will be return=
ed
> > - * unlocked and with its refcount incremented.
> > + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
> >   *
> > - * Caller must lock the swap device or hold a reference to keep it val=
id.
> > + * A found folio will be returned unlocked and with its refcount incre=
ased.
> > + *
> > + * Context: Caller must ensure @entry is valid and pin the swap device=
, also
> > + * check the returned folio after locking it (e.g. folio_swap_contains=
).
> >   */
> >  struct folio *swap_cache_get_folio(swp_entry_t entry)
> >  {
> > @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entry_t =
entry, gfp_t gfp_mask,
> >         for (;;) {
> >                 int err;
> >
> > -               /* Check the swap cache in case the folio is already th=
ere */
> > +               /*
> > +                * Check the swap cache first, if a cached folio is fou=
nd,
> > +                * return it unlocked. The caller will lock and check i=
t.
> > +                */
> >                 folio =3D swap_cache_get_folio(entry);
> >                 if (folio)
> >                         goto got_folio;
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 4b8ab2cb49ca..12f2580ebe8d 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info=
_struct *si,
> >          * Offset could point to the middle of a large folio, or folio
> >          * may no longer point to the expected offset before it's locke=
d.
> >          */
> > -       entry =3D folio->swap;
> > -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entry)=
 + nr_pages) {
> > +       if (!folio_contains_swap(folio, entry)) {
> >                 folio_unlock(folio);
> >                 folio_put(folio);
> >                 goto again;
> >         }
> > +       entry =3D folio->swap;
> >         offset =3D swp_offset(entry);
> >
> >         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> > @@ -2150,6 +2150,12 @@ static int unuse_pte_range(struct vm_area_struct=
 *vma, pmd_t *pmd,
> >                 }
> >
> >                 folio_lock(folio);
> > +               if (!folio_contains_swap(folio, entry)) {
> > +                       folio_unlock(folio);
> > +                       folio_put(folio);
> > +                       continue;
> > +               }
> > +
> >                 folio_wait_writeback(folio);
> >                 ret =3D unuse_pte(vma, pmd, addr, entry, folio);
> >                 if (ret < 0) {
> > --
> > 2.51.0
> >
> >
>

