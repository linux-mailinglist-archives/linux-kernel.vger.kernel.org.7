Return-Path: <linux-kernel+bounces-787719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B972B37A34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071CE365BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902130F950;
	Wed, 27 Aug 2025 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNyIBn/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0844026A08C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275222; cv=none; b=ArsluQtEe3eCrPHNWewbv342jKZ++AhX7Ec0D2HuPvFABSGV/VaYBIWfv3T+YEmBmu2X3tKKtBtGvOKjLrhWHy4JPSGTahcaasqBkRRzf87CNtRDnFceOxEN/UsXUJDByIPizQ8BIwDeFk/MYcsJgB43KGPZ/bGDpCIIJK0Yo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275222; c=relaxed/simple;
	bh=58IM4CO3GzYGElXulUjCsmon9Noi6X7JoteWvqArny4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIbLA8bUt5xMRMGxgFUzEqm9WXWhkk9Wneg8gvbwPuMOGbKpVnK+c8ehNLh9Ow6rUzZ5HWGdB8tIutM+BNFEdebG1RTL/xT5GwvaEC7R4OihTs706fQXS+LrjSyEtGSE8Hd3OcVAwZCHEynlTFiavLKgmtZiADu8qWtOpEiyIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNyIBn/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC7DC4CEEB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756275221;
	bh=58IM4CO3GzYGElXulUjCsmon9Noi6X7JoteWvqArny4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GNyIBn/KRQ/og/VQKH755dpknO2+GXDkzJLCpL3KoWXhhz2LhLZM29MshWyG4D8K8
	 Uevl4ItL+8+BE6QtpgplXL50evCZHc6gjeKzfOFRAFAleB1Zs45a+LlYtAMbP4L8Mf
	 K2fGeCQHiRA/Z8ecdQfPk/fzSMTae0hVHk1Dc4aBCZnCskgQInO0CqBgISJGGNLyIw
	 0+aNpmagrg+ktCWLxrFmJeDHfdCblb00Dc5QP+hpzM8kTFRgvqVu1S3E5gxnbEQU+j
	 pkqcopQ3CQ4IeDnYwVA6qAguoSiXehOKIrqPeZl7kFIFebAR582mFWAA3zBjXh06IK
	 MIBFvLyHt2akQ==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so43075e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:13:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQF1/xEiFILxnwQvI/XlJFs2eVQzuQj1P+wGKRsTWltqsRo+6gPNeEInDDSNXjta5Ix9jrbiDNDB4Q4Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSi7Tei8ibQxiDBHBJs2dJAuvLnampqRIMDYkxXXNkzH8ho9hY
	9N6UlImSxYh1P2TSKfPUSOCPMIsbBjNG3uK6B7zN+DhTXZCRc0tZWQsGAyvhiJqiu9LecZ35ze9
	zarbLT/4zm9iSHvMwMoUlf9j3of1D7kblbvuhwzem
X-Google-Smtp-Source: AGHT+IF/M5nnBkFj8JCQ/wd31/i7BTMrdvdLwr55gMNN7OSMKTtQEybe9ApR8eFYMcDo9u87NtRAOyds2X9C13tVmGA=
X-Received: by 2002:a05:600c:8219:b0:45a:2861:3625 with SMTP id
 5b1f17b1804b1-45b65ee0f36mr3307965e9.4.1756275219801; Tue, 26 Aug 2025
 23:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 26 Aug 2025 23:13:28 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMX_WTg7vyACBxskNmDHB4C-ZkowuKYP71gQ8qyKuwAaA@mail.gmail.com>
X-Gm-Features: Ac12FXx6j9Ld3lDohs75YQOI64HdH5xtgDz7f-SuJOL8YjcKUe9IiesbxU2NYqw
Message-ID: <CAF8kJuMX_WTg7vyACBxskNmDHB4C-ZkowuKYP71gQ8qyKuwAaA@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Kairui Song <kasong@tencent.com>
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

On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cache lookup is lockless, it only increases the reference count
> of the returned folio. That's not enough to ensure a folio is stable in
> the swap cache, so the folio could be removed from the swap cache at any
> time. The caller always has to lock and check the folio before use.
>
> Document this as a comment, and introduce a helper for swap cache folio
> verification with proper sanity checks.
>
> Also, sanitize all current users to use this convention, and use the new
> helper when possible for easier debugging. Some existing callers won't
> cause any major problem right now, only trivial issues like incorrect
> readahead statistic (swapin) or wasted loop (swapoff). It's better to
> always follow this convention to make things robust.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 28 +++++++++++++---------------
>  mm/shmem.c      |  4 ++--
>  mm/swap.h       | 28 ++++++++++++++++++++++++++++
>  mm/swap_state.c | 13 +++++++++----
>  mm/swapfile.c   | 10 ++++++++--
>  5 files changed, 60 insertions(+), 23 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 10ef528a5f44..9ca8e1873c6e 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4661,12 +4661,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 goto out;
>
>         folio =3D swap_cache_get_folio(entry);
> -       if (folio) {
> -               swap_update_readahead(folio, vma, vmf->address);
> -               page =3D folio_file_page(folio, swp_offset(entry));
> -       }
>         swapcache =3D folio;
> -

Can simplify as:
           folio =3D swapcache =3D swap_cache_get_folio(entry);

>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> @@ -4735,20 +4730,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 ret =3D VM_FAULT_MAJOR;
>                 count_vm_event(PGMAJFAULT);
>                 count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> -               page =3D folio_file_page(folio, swp_offset(entry));
> -       } else if (PageHWPoison(page)) {
> -               /*
> -                * hwpoisoned dirty swapcache pages are kept for killing
> -                * owner processes (which may be unknown at hwpoison time=
)
> -                */
> -               ret =3D VM_FAULT_HWPOISON;
> -               goto out_release;

Here you move the HWPosion(page) bail out from before taking the page
lock to after the page lock. The HWPosion page should be able to bail
out without taking the lock.

>         }
>
>         ret |=3D folio_lock_or_retry(folio, vmf);
>         if (ret & VM_FAULT_RETRY)
>                 goto out_release;
>
> +       page =3D folio_file_page(folio, swp_offset(entry));
>         if (swapcache) {
>                 /*
>                  * Make sure folio_free_swap() or swapoff did not release=
 the
> @@ -4757,10 +4745,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                  * swapcache, we need to check that the page's swap has n=
ot
>                  * changed.
>                  */
> -               if (unlikely(!folio_test_swapcache(folio) ||
> -                            page_swap_entry(page).val !=3D entry.val))
> +               if (!folio_contains_swap(folio, entry))
>                         goto out_page;
>
> +               if (PageHWPoison(page)) {
> +                       /*
> +                        * hwpoisoned dirty swapcache pages are kept for =
killing
> +                        * owner processes (which may be unknown at hwpoi=
son time)
> +                        */
> +                       ret =3D VM_FAULT_HWPOISON;
> +                       goto out_page;

It seems you bail out with the page still locked, that seems like a bug to =
me.

I think this HWPoision() check move order with the page lock is problematic=
.

Can you double check?

To be continued.

Chris

> +               }
> +
> +               swap_update_readahead(folio, vma, vmf->address);
> +
>                 /*
>                  * KSM sometimes has to copy on read faults, for example,=
 if
>                  * folio->index of non-ksm folios would be nonlinear insi=
de the
> diff --git a/mm/shmem.c b/mm/shmem.c
> index e9d0d2784cd5..b4d39f2a1e0a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2379,8 +2379,6 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                         count_vm_event(PGMAJFAULT);
>                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
>                 }
> -       } else {
> -               swap_update_readahead(folio, NULL, 0);
>         }
>
>         if (order > folio_order(folio)) {
> @@ -2431,6 +2429,8 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                 error =3D -EIO;
>                 goto failed;
>         }
> +       if (!skip_swapcache)
> +               swap_update_readahead(folio, NULL, 0);
>         folio_wait_writeback(folio);
>         nr_pages =3D folio_nr_pages(folio);
>
> diff --git a/mm/swap.h b/mm/swap.h
> index efb6d7ff9f30..bb2adbfd64a9 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -52,6 +52,29 @@ static inline pgoff_t swap_cache_index(swp_entry_t ent=
ry)
>         return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
>  }
>
> +/**
> + * folio_contains_swap - Does this folio contain this swap entry?
> + * @folio: The folio.
> + * @entry: The swap entry to check against.
> + *
> + * Swap version of folio_contains()
> + *
> + * Context: The caller should have the folio locked to ensure
> + * nothing will move it out of the swap cache.
> + * Return: true or false.
> + */
> +static inline bool folio_contains_swap(struct folio *folio, swp_entry_t =
entry)
> +{
> +       pgoff_t offset =3D swp_offset(entry);
> +
> +       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> +       if (unlikely(!folio_test_swapcache(folio)))
> +               return false;
> +       if (unlikely(swp_type(entry) !=3D swp_type(folio->swap)))
> +               return false;
> +       return offset - swp_offset(folio->swap) < folio_nr_pages(folio);
> +}
> +
>  void show_swap_cache_info(void);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);
>  int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> @@ -144,6 +167,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t e=
ntry)
>         return 0;
>  }
>
> +static inline bool folio_contains_swap(struct folio *folio, swp_entry_t =
entry)
> +{
> +       return false;
> +}
> +
>  static inline void show_swap_cache_info(void)
>  {
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ff9eb761a103..be0d96494dc1 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -70,10 +70,12 @@ void show_swap_cache_info(void)
>  }
>
>  /*
> - * Lookup a swap entry in the swap cache. A found folio will be returned
> - * unlocked and with its refcount incremented.
> + * swap_cache_get_folio - Lookup a swap entry in the swap cache.
>   *
> - * Caller must lock the swap device or hold a reference to keep it valid=
.
> + * A found folio will be returned unlocked and with its refcount increas=
ed.
> + *
> + * Context: Caller must ensure @entry is valid and pin the swap device, =
also
> + * check the returned folio after locking it (e.g. folio_swap_contains).
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry)
>  {
> @@ -338,7 +340,10 @@ struct folio *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
>         for (;;) {
>                 int err;
>
> -               /* Check the swap cache in case the folio is already ther=
e */
> +               /*
> +                * Check the swap cache first, if a cached folio is found=
,
> +                * return it unlocked. The caller will lock and check it.
> +                */
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         goto got_folio;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4b8ab2cb49ca..12f2580ebe8d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -240,12 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>          * Offset could point to the middle of a large folio, or folio
>          * may no longer point to the expected offset before it's locked.
>          */
> -       entry =3D folio->swap;
> -       if (offset < swp_offset(entry) || offset >=3D swp_offset(entry) +=
 nr_pages) {
> +       if (!folio_contains_swap(folio, entry)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 goto again;
>         }
> +       entry =3D folio->swap;
>         offset =3D swp_offset(entry);
>
>         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
> @@ -2150,6 +2150,12 @@ static int unuse_pte_range(struct vm_area_struct *=
vma, pmd_t *pmd,
>                 }
>
>                 folio_lock(folio);
> +               if (!folio_contains_swap(folio, entry)) {
> +                       folio_unlock(folio);
> +                       folio_put(folio);
> +                       continue;
> +               }
> +
>                 folio_wait_writeback(folio);
>                 ret =3D unuse_pte(vma, pmd, addr, entry, folio);
>                 if (ret < 0) {
> --
> 2.51.0
>
>

