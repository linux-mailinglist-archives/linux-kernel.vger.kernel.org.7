Return-Path: <linux-kernel+bounces-804086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E9EB469CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3923A67F9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117EE279791;
	Sat,  6 Sep 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvjfXusF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC5239591
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757142598; cv=none; b=knU2lidnwnih1Xvs84AmtRCQSWPr+SS2KSKwcPzS+GWdxiLkDSvxgTVuF1M0QOgWdV7oChwj3C2QUnZ3Rv16uur3m1CCj8MlhLF/9EYMsGAynUGngwOtcBrlj+OWvzLIEz1pvNhTfnnhrU874g5k8z23Am8B3brzrNnVd7Sf08I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757142598; c=relaxed/simple;
	bh=Tf/k29nvO+fQos5qe0jaYD2C57//qJ4JQBIphFK/8ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5ek8mxosF7uwzajpfjO1GsBi/Zcq0+JqZVk2CRiOnIxvk2HiDeOnkiB7zPJkbHbXUtBhzD24iJG5s7SxV77K0/C+6sWqEFDndVIOvu8jCvyjd+bD+xpyaCTzcjvHeUnk6BUCQ+8jvsXJDSoDu3UdZzvbBBNh9lYRHlUz4E13Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvjfXusF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF343C4CEF7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 07:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757142597;
	bh=Tf/k29nvO+fQos5qe0jaYD2C57//qJ4JQBIphFK/8ek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kvjfXusFfRhlYDigzMKHMbrSg/UyP7ldtBb0MrUgkIhkrj6fcpyRXy/MXnwaY0mmg
	 YazE8Qgcgid0qwS0KBtYLm7v1oxwRhyQCXHTvcAs1Om7c1wEq7iy8PDDAZ212Ekef1
	 o+qjAUiDqmzqKsyPFJDmpO3PxtvNQsUevzNGoHwPCEyQ0xhfib3cRWQYKUmnadBR+M
	 7xaR2WDRY393l6LamMhl/w4hFhjoIZjJfGZnm6G+0hEg1GG5tYF4rAWeh+9BXWLdQU
	 rA69LpzYrp7yNxmEpgm4dXx5L/quhALlWXrUZznkgbAAbq9XR8dmE+enTEFNvdPrwG
	 IL10l4pZzzJBg==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b886f92ccso45755e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 00:09:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNAFQNLWVB6NEwmikQX1y7CUtLEBzsefn9Vyg44zSVMygXo9BbMu8eaSmZf9Zlph+ko4r0T42XF7DdQGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUohALeTtbOf9X4DXe72uJa+ujGYBYQ6HwtX9lTj+OrFwPZoxq
	ksoq0+mULL23ZrA17tF8Pfb6pPGvAfXW22FckZKAVk5BhoAmvDkHwL0HyA4HtdBnxcEXxmq9twj
	f1dH2d7wbieLvskBlTaitbcVs6wYJ7MPMtE59yEoS
X-Google-Smtp-Source: AGHT+IEk3pcPP/qsOuyioVB9KutzSfd7D5HDiSrX+WPJAuZhb1y0hTN/+e6dNsHQV1/ajSG51pgGUmwdRXH6nvz0198=
X-Received: by 2002:a05:600c:8a0c:20b0:43d:409c:6142 with SMTP id
 5b1f17b1804b1-45ddd9f1833mr796345e9.0.1757142596305; Sat, 06 Sep 2025
 00:09:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-11-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-11-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 00:09:44 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPOTm8e-GLQ=SuQo_CWqjNy05CWFO0nG5OsMbhjjJfXqA@mail.gmail.com>
X-Gm-Features: Ac12FXzj4LpxyTh54HO3g2hi0SCO66oy7pinB7gE8honvJ1AVinfu5BU57zJIPo
Message-ID: <CAF8kJuPOTm8e-GLQ=SuQo_CWqjNy05CWFO0nG5OsMbhjjJfXqA@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] mm, swap: wrap swap cache replacement with a helper
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Sep 5, 2025 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> There are currently three swap cache users that are trying to replace an
> existing folio with a new one: huge memory splitting, migration, and
> shmem replacement. What they are doing is quite similar.
>
> Introduce a common helper for this. In later commits, they can be easily
> switched to use the swap table by updating this helper.
>
> The newly added helper also makes the swap cache API better defined, and
> debugging is easier.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/huge_memory.c |  5 ++---
>  mm/migrate.c     | 11 +++--------
>  mm/shmem.c       | 10 ++--------
>  mm/swap.h        |  3 +++
>  mm/swap_state.c  | 32 ++++++++++++++++++++++++++++++++
>  5 files changed, 42 insertions(+), 19 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd7418..a4d192c8d794 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3798,9 +3798,8 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>                          * NOTE: shmem in swap cache is not supported yet=
.
>                          */
>                         if (swap_cache) {
> -                               __xa_store(&swap_cache->i_pages,
> -                                          swap_cache_index(new_folio->sw=
ap),
> -                                          new_folio, 0);
> +                               __swap_cache_replace_folio(swap_cache, ne=
w_folio->swap,
> +                                                          folio, new_fol=
io);
>                                 continue;
>                         }
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8e435a078fc3..7e1d01aa8c85 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -566,7 +566,6 @@ static int __folio_migrate_mapping(struct address_spa=
ce *mapping,
>         struct zone *oldzone, *newzone;
>         int dirty;
>         long nr =3D folio_nr_pages(folio);
> -       long entries, i;
>
>         if (!mapping) {
>                 /* Take off deferred split queue while frozen and memcg s=
et */
> @@ -615,9 +614,6 @@ static int __folio_migrate_mapping(struct address_spa=
ce *mapping,
>         if (folio_test_swapcache(folio)) {
>                 folio_set_swapcache(newfolio);
>                 newfolio->private =3D folio_get_private(folio);
> -               entries =3D nr;
> -       } else {
> -               entries =3D 1;
>         }
>
>         /* Move dirty while folio refs frozen and newfolio not yet expose=
d */
> @@ -627,11 +623,10 @@ static int __folio_migrate_mapping(struct address_s=
pace *mapping,
>                 folio_set_dirty(newfolio);
>         }
>
> -       /* Swap cache still stores N entries instead of a high-order entr=
y */
> -       for (i =3D 0; i < entries; i++) {
> +       if (folio_test_swapcache(folio))
> +               __swap_cache_replace_folio(mapping, folio->swap, folio, n=
ewfolio);
> +       else
>                 xas_store(&xas, newfolio);
> -               xas_next(&xas);
> -       }
>
>         /*
>          * Drop cache reference from old folio by unfreezing
> diff --git a/mm/shmem.c b/mm/shmem.c
> index cc6a0007c7a6..823ceae9dff8 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2123,10 +2123,8 @@ static int shmem_replace_folio(struct folio **foli=
op, gfp_t gfp,
>         struct folio *new, *old =3D *foliop;
>         swp_entry_t entry =3D old->swap;
>         struct address_space *swap_mapping =3D swap_address_space(entry);
> -       pgoff_t swap_index =3D swap_cache_index(entry);
> -       XA_STATE(xas, &swap_mapping->i_pages, swap_index);
>         int nr_pages =3D folio_nr_pages(old);
> -       int error =3D 0, i;
> +       int error =3D 0;
>
>         /*
>          * We have arrived here because our zones are constrained, so don=
't
> @@ -2155,12 +2153,8 @@ static int shmem_replace_folio(struct folio **foli=
op, gfp_t gfp,
>         new->swap =3D entry;
>         folio_set_swapcache(new);
>
> -       /* Swap cache still stores N entries instead of a high-order entr=
y */
>         xa_lock_irq(&swap_mapping->i_pages);
> -       for (i =3D 0; i < nr_pages; i++) {
> -               WARN_ON_ONCE(xas_store(&xas, new));
> -               xas_next(&xas);
> -       }
> +       __swap_cache_replace_folio(swap_mapping, entry, old, new);
>         xa_unlock_irq(&swap_mapping->i_pages);
>
>         mem_cgroup_replace_folio(old, new);
> diff --git a/mm/swap.h b/mm/swap.h
> index 8b38577a4e04..a139c9131244 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -182,6 +182,9 @@ int swap_cache_add_folio(struct folio *folio, swp_ent=
ry_t entry,
>  void swap_cache_del_folio(struct folio *folio);
>  void __swap_cache_del_folio(struct folio *folio,
>                             swp_entry_t entry, void *shadow);
> +void __swap_cache_replace_folio(struct address_space *address_space,
> +                               swp_entry_t entry,
> +                               struct folio *old, struct folio *new);
>  void swap_cache_clear_shadow(int type, unsigned long begin,
>                              unsigned long end);
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index f3a32a06a950..38f5f4cf565d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -234,6 +234,38 @@ void swap_cache_del_folio(struct folio *folio)
>         folio_ref_sub(folio, folio_nr_pages(folio));
>  }
>
> +/**
> + * __swap_cache_replace_folio - Replace a folio in the swap cache.
> + * @mapping: Swap mapping address space.
> + * @entry: The first swap entry that the new folio corresponds to.
> + * @old: The old folio to be replaced.
> + * @new: The new folio.
> + *
> + * Replace a existing folio in the swap cache with a new folio.
> + *
> + * Context: Caller must ensure both folios are locked, and lock the
> + * swap address_space that holds the entries to be replaced.
> + */
> +void __swap_cache_replace_folio(struct address_space *mapping,
> +                               swp_entry_t entry,
> +                               struct folio *old, struct folio *new)
> +{
> +       unsigned long nr_pages =3D folio_nr_pages(new);
> +       unsigned long offset =3D swap_cache_index(entry);
> +       unsigned long end =3D offset + nr_pages;
> +       XA_STATE(xas, &mapping->i_pages, offset);
> +
> +       VM_WARN_ON_ONCE(entry.val !=3D new->swap.val);
> +       VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new=
));
> +       VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcac=
he(new));
> +
> +       /* Swap cache still stores N entries instead of a high-order entr=
y */
> +       do {
> +               WARN_ON_ONCE(xas_store(&xas, new) !=3D old);
> +               xas_next(&xas);
> +       } while (++offset < end);
> +}
> +
>  /**
>   * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
>   * @type: Indicates the swap device.
> --
> 2.51.0
>
>

