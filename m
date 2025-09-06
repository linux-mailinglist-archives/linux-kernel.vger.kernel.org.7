Return-Path: <linux-kernel+bounces-804058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FFFB46956
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCFD3B0DEA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E2920408A;
	Sat,  6 Sep 2025 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNCX+awG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995C1367
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757137526; cv=none; b=ja5q9N04JlMOT/QmhXykwzSx9KF2XPbnHHJ29c9iCFjtoQw6H5Nuc/jmVkXF8geFS8+hAPiGMus6MdA/JpxwLZ9Ep2PB8KyN7JESbURGV3NhuXZuUCYK4ngMaUZ/oUoJ13OUhOrzKN4EBDwLMz0iZ6ioHL6tcTF5IWXtSvb7gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757137526; c=relaxed/simple;
	bh=Y2H2ghaUA6BwKtBztuwLUDtij2lov+amvzwUCBE/+b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUPznQirOq8DYj9KE4+gztDhXAyxzMQd7deJ9aPYNnzMWrVLhZNQDfMzRPsTVvcXcXEgsH4HZlgtwl+8dHCyAJcM7CmyAT0tHZmQD+nuxa25bARXVQBxqw7ikvChdZFtPlgno3FiAK5yYoolfJ2JaZ0EEId7usBHKM30ja/EhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNCX+awG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E53C4CEF8
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 05:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757137526;
	bh=Y2H2ghaUA6BwKtBztuwLUDtij2lov+amvzwUCBE/+b0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FNCX+awGSm3x5khTRhUWEl9sv2XI4bwE+CjTYQlDnhjHRPHpOZ2tKmrMRmG6Rbz4E
	 tofE5T2dZO8UB1eLOrud/BDWHHmJNah0LO6nuq6QoinfsWilO3pMP9ekZQwgtTccMm
	 EW9zSX0R1uIao9QK1ewuiiovmWDsEp0wuJ/cAtOTCIiZJj/9PoghU6y0uJkoLrV53f
	 D+Obhsj3SQwxGz3sWUK+QvNMtRvBHvtbUL91luo5bDzRydUCKOufFR93rbLH2mSOEk
	 7og0krODKiEjFB5bBSdgV4I6EWiN4O02oixkdJenLjqzHNou/Ouc2h2LD7HuHQ/DTO
	 Kn4roOe4AC/Xw==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45ddca76f22so20865e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 22:45:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX50tvWW+uKiynE15zHQ/N3TByKeZeF/4KsCMxynvm1Vl6qLrWnKeGALndx2eg/A15UzMQUJj7UXLMT1v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW6FzU9j6qxgfCUlCBmteaxS/4vOzfitv/BywLFA4mYMt9CxsR
	i8FQSvDuPybbRzUBjbov9m3m7yGuik7dQERxshCRhcZr+ZM23WLJppLmmpoISYK1Y4o0RENJqM/
	Lp/vl2UrcVv/+yCwDjqTRu8069ja9qOg5MNNrEctx
X-Google-Smtp-Source: AGHT+IFHl8FEjWMumhaltqQyu6gYBf9y4IR3uR2BERFsortiYCZosuzmTajMi+ll2FqM4abJGpY9uFGn2AWSCgd3ilY=
X-Received: by 2002:a05:600c:a408:b0:45b:7d8f:4bd4 with SMTP id
 5b1f17b1804b1-45dddad7944mr712595e9.4.1757137524818; Fri, 05 Sep 2025
 22:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-10-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-10-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 22:45:12 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPkipwbjiKNe_xSyDJwPxUvNuaqO94EqXyeUadUcPb06A@mail.gmail.com>
X-Gm-Features: Ac12FXzS1p3-svG_Q6inF4tvEzx7nIONHK1_zcHzJlaaeUw6eR-u7nLtk6PfPFE
Message-ID: <CAF8kJuPkipwbjiKNe_xSyDJwPxUvNuaqO94EqXyeUadUcPb06A@mail.gmail.com>
Subject: Re: [PATCH v2 09/15] mm, swap: cleanup swap cache API and add kerneldoc
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
> In preparation for replacing the swap cache backend with the swap table,
> clean up and add proper kernel doc for all swap cache APIs. Now all swap
> cache APIs are well-defined with consistent names.
>
> No feature change, only renaming and documenting.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/filemap.c        |  2 +-
>  mm/memory-failure.c |  2 +-
>  mm/memory.c         |  2 +-
>  mm/swap.h           | 48 ++++++++++++++-----------
>  mm/swap_state.c     | 86 ++++++++++++++++++++++++++++++++-------------
>  mm/swapfile.c       |  8 ++---
>  mm/vmscan.c         |  2 +-
>  mm/zswap.c          |  2 +-
>  8 files changed, 98 insertions(+), 54 deletions(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 344ab106c21c..29ea56999a16 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4517,7 +4517,7 @@ static void filemap_cachestat(struct address_space =
*mapping,
>                                  * invalidation, so there might not be
>                                  * a shadow in the swapcache (yet).
>                                  */
> -                               shadow =3D get_shadow_from_swap_cache(swp=
);
> +                               shadow =3D swap_cache_get_shadow(swp);
>                                 if (!shadow)
>                                         goto resched;
>                         }
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index b93ab99ad3ef..922526533cd9 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1199,7 +1199,7 @@ static int me_swapcache_clean(struct page_state *ps=
, struct page *p)
>         struct folio *folio =3D page_folio(p);
>         int ret;
>
> -       delete_from_swap_cache(folio);
> +       swap_cache_del_folio(folio);
>
>         ret =3D delete_from_lru_cache(folio) ? MF_FAILED : MF_RECOVERED;
>         folio_unlock(folio);
> diff --git a/mm/memory.c b/mm/memory.c
> index 5808c4ef21b3..41e641823558 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4699,7 +4699,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>
>                                 memcg1_swapin(entry, nr_pages);
>
> -                               shadow =3D get_shadow_from_swap_cache(ent=
ry);
> +                               shadow =3D swap_cache_get_shadow(entry);
>                                 if (shadow)
>                                         workingset_refault(folio, shadow)=
;
>
> diff --git a/mm/swap.h b/mm/swap.h
> index a65e72edb087..8b38577a4e04 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -164,17 +164,29 @@ static inline bool folio_matches_swap_entry(const s=
truct folio *folio,
>         return folio->swap.val =3D=3D round_down(entry.val, folio_nr_page=
s(folio));
>  }
>
> +/*
> + * All swap cache helpers below require the caller to ensure the swap en=
tries
> + * used are valid and stablize the device by any of the following ways:
> + * - Hold a reference by get_swap_device(): this ensures a single entry =
is
> + *   valid and increases the swap device's refcount.
> + * - Locking a folio in the swap cache: this ensures the folio's swap en=
tries
> + *   are valid and pinned, also implies reference to the device.
> + * - Locking anything referencing the swap entry: e.g. PTL that protects
> + *   swap entries in the page table, similar to locking swap cache folio=
.
> + * - See the comment of get_swap_device() for more complex usage.
> + */
> +struct folio *swap_cache_get_folio(swp_entry_t entry);
> +void *swap_cache_get_shadow(swp_entry_t entry);
> +int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> +                        gfp_t gfp, void **shadow);
> +void swap_cache_del_folio(struct folio *folio);
> +void __swap_cache_del_folio(struct folio *folio,
> +                           swp_entry_t entry, void *shadow);
> +void swap_cache_clear_shadow(int type, unsigned long begin,
> +                            unsigned long end);
> +
>  void show_swap_cache_info(void);
> -void *get_shadow_from_swap_cache(swp_entry_t entry);
> -int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> -                     gfp_t gfp, void **shadowp);
> -void __delete_from_swap_cache(struct folio *folio,
> -                             swp_entry_t entry, void *shadow);
> -void delete_from_swap_cache(struct folio *folio);
> -void clear_shadow_from_swap_cache(int type, unsigned long begin,
> -                                 unsigned long end);
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int=
 nr);
> -struct folio *swap_cache_get_folio(swp_entry_t entry);
>  struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                 struct vm_area_struct *vma, unsigned long addr,
>                 struct swap_iocb **plug);
> @@ -302,28 +314,22 @@ static inline struct folio *swap_cache_get_folio(sw=
p_entry_t entry)
>         return NULL;
>  }
>
> -static inline void *get_shadow_from_swap_cache(swp_entry_t entry)
> +static inline void *swap_cache_get_shadow(swp_entry_t entry)
>  {
>         return NULL;
>  }
>
> -static inline int add_to_swap_cache(struct folio *folio, swp_entry_t ent=
ry,
> -                                       gfp_t gfp_mask, void **shadowp)
> -{
> -       return -1;
> -}
> -
> -static inline void __delete_from_swap_cache(struct folio *folio,
> -                                       swp_entry_t entry, void *shadow)
> +static inline int swap_cache_add_folio(swp_entry_t entry, struct folio *=
folio,
> +                                      gfp_t gfp, void **shadow)
>  {
> +       return -EINVAL;
>  }
>
> -static inline void delete_from_swap_cache(struct folio *folio)
> +static inline void swap_cache_del_folio(struct folio *folio)
>  {
>  }
>
> -static inline void clear_shadow_from_swap_cache(int type, unsigned long =
begin,
> -                               unsigned long end)
> +static inline void __swap_cache_del_folio(swp_entry_t entry, struct foli=
o *folio, void *shadow)
>  {
>  }
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0ad4f3b41f1b..f3a32a06a950 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -78,8 +78,8 @@ void show_swap_cache_info(void)
>   * Context: Caller must ensure @entry is valid and protect the swap devi=
ce
>   * with reference count or locks.
>   * Return: Returns the found folio on success, NULL otherwise. The calle=
r
> - * must lock and check if the folio still matches the swap entry before
> - * use (e.g. with folio_matches_swap_entry).
> + * must lock nd check if the folio still matches the swap entry before
> + * use (e.g., folio_matches_swap_entry).
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry)
>  {
> @@ -90,7 +90,15 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
>         return folio;
>  }
>
> -void *get_shadow_from_swap_cache(swp_entry_t entry)
> +/**
> + * swap_cache_get_shadow - Looks up a shadow in the swap cache.
> + * @entry: swap entry used for the lookup.
> + *
> + * Context: Caller must ensure @entry is valid and protect the swap devi=
ce
> + * with reference count or locks.
> + * Return: Returns either NULL or an XA_VALUE (shadow).
> + */
> +void *swap_cache_get_shadow(swp_entry_t entry)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>         pgoff_t idx =3D swap_cache_index(entry);
> @@ -102,12 +110,21 @@ void *get_shadow_from_swap_cache(swp_entry_t entry)
>         return NULL;
>  }
>
> -/*
> - * add_to_swap_cache resembles filemap_add_folio on swapper_space,
> - * but sets SwapCache flag and 'swap' instead of mapping and index.
> +/**
> + * swap_cache_add_folio - Add a folio into the swap cache.
> + * @folio: The folio to be added.
> + * @entry: The swap entry corresponding to the folio.
> + * @gfp: gfp_mask for XArray node allocation.
> + * @shadowp: If a shadow is found, return the shadow.
> + *
> + * Context: Caller must ensure @entry is valid and protect the swap devi=
ce
> + * with reference count or locks.
> + * The caller also needs to mark the corresponding swap_map slots with
> + * SWAP_HAS_CACHE to avoid race or conflict.
> + * Return: Returns 0 on success, error code otherwise.
>   */
> -int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> -                       gfp_t gfp, void **shadowp)
> +int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> +                        gfp_t gfp, void **shadowp)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>         pgoff_t idx =3D swap_cache_index(entry);
> @@ -155,12 +172,20 @@ int add_to_swap_cache(struct folio *folio, swp_entr=
y_t entry,
>         return xas_error(&xas);
>  }
>
> -/*
> - * This must be called only on folios that have
> - * been verified to be in the swap cache.
> +/**
> + * __swap_cache_del_folio - Removes a folio from the swap cache.
> + * @folio: The folio.
> + * @entry: The first swap entry that the folio corresponds to.
> + * @shadow: shadow value to be filled in the swap cache.
> + *
> + * Removes a folio from the swap cache and fills a shadow in place.
> + * This won't put the folio's refcount. The caller has to do that.
> + *
> + * Context: Caller must hold the xa_lock, ensure the folio is
> + * locked and in the swap cache, using the index of @entry.
>   */
> -void __delete_from_swap_cache(struct folio *folio,
> -                       swp_entry_t entry, void *shadow)
> +void __swap_cache_del_folio(struct folio *folio,
> +                           swp_entry_t entry, void *shadow)
>  {
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>         int i;
> @@ -186,27 +211,40 @@ void __delete_from_swap_cache(struct folio *folio,
>         __lruvec_stat_mod_folio(folio, NR_SWAPCACHE, -nr);
>  }
>
> -/*
> - * This must be called only on folios that have
> - * been verified to be in the swap cache and locked.
> - * It will never put the folio into the free list,
> - * the caller has a reference on the folio.
> +/**
> + * swap_cache_del_folio - Removes a folio from the swap cache.
> + * @folio: The folio.
> + *
> + * Same as __swap_cache_del_folio, but handles lock and refcount. The
> + * caller must ensure the folio is either clean or has a swap count
> + * equal to zero, or it may cause data loss.
> + *
> + * Context: Caller must ensure the folio is locked and in the swap cache=
.
>   */
> -void delete_from_swap_cache(struct folio *folio)
> +void swap_cache_del_folio(struct folio *folio)
>  {
>         swp_entry_t entry =3D folio->swap;
>         struct address_space *address_space =3D swap_address_space(entry)=
;
>
>         xa_lock_irq(&address_space->i_pages);
> -       __delete_from_swap_cache(folio, entry, NULL);
> +       __swap_cache_del_folio(folio, entry, NULL);
>         xa_unlock_irq(&address_space->i_pages);
>
>         put_swap_folio(folio, entry);
>         folio_ref_sub(folio, folio_nr_pages(folio));
>  }
>
> -void clear_shadow_from_swap_cache(int type, unsigned long begin,
> -                               unsigned long end)
> +/**
> + * swap_cache_clear_shadow - Clears a set of shadows in the swap cache.
> + * @type: Indicates the swap device.
> + * @begin: Beginning offset of the range.
> + * @end: Ending offset of the range.
> + *
> + * Context: Caller must ensure the range is valid and hold a reference t=
o
> + * the swap device.
> + */
> +void swap_cache_clear_shadow(int type, unsigned long begin,
> +                            unsigned long end)
>  {
>         unsigned long curr =3D begin;
>         void *old;
> @@ -393,7 +431,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>                         goto put_and_return;
>
>                 /*
> -                * We might race against __delete_from_swap_cache(), and
> +                * We might race against __swap_cache_del_folio(), and
>                  * stumble across a swap_map entry whose SWAP_HAS_CACHE
>                  * has not yet been cleared.  Or race against another
>                  * __read_swap_cache_async(), which has set SWAP_HAS_CACH=
E
> @@ -412,7 +450,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>                 goto fail_unlock;
>
>         /* May fail (-ENOMEM) if XArray node allocation failed. */
> -       if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MA=
SK, &shadow))
> +       if (swap_cache_add_folio(new_folio, entry, gfp_mask & GFP_RECLAIM=
_MASK, &shadow))
>                 goto fail_unlock;
>
>         memcg1_swapin(entry, 1);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 367481d319cd..731b541b1d33 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -266,7 +266,7 @@ static int __try_to_reclaim_swap(struct swap_info_str=
uct *si,
>         if (!need_reclaim)
>                 goto out_unlock;
>
> -       delete_from_swap_cache(folio);
> +       swap_cache_del_folio(folio);
>         folio_set_dirty(folio);
>         ret =3D nr_pages;
>  out_unlock:
> @@ -1123,7 +1123,7 @@ static void swap_range_free(struct swap_info_struct=
 *si, unsigned long offset,
>                         swap_slot_free_notify(si->bdev, offset);
>                 offset++;
>         }
> -       clear_shadow_from_swap_cache(si->type, begin, end);
> +       swap_cache_clear_shadow(si->type, begin, end);
>
>         /*
>          * Make sure that try_to_unuse() observes si->inuse_pages reachin=
g 0
> @@ -1288,7 +1288,7 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp=
)
>          * TODO: this could cause a theoretical memory reclaim
>          * deadlock in the swap out path.
>          */
> -       if (add_to_swap_cache(folio, entry, gfp | __GFP_NOMEMALLOC, NULL)=
)
> +       if (swap_cache_add_folio(folio, entry, gfp | __GFP_NOMEMALLOC, NU=
LL))
>                 goto out_free;
>
>         return 0;
> @@ -1758,7 +1758,7 @@ bool folio_free_swap(struct folio *folio)
>         if (folio_swapped(folio))
>                 return false;
>
> -       delete_from_swap_cache(folio);
> +       swap_cache_del_folio(folio);
>         folio_set_dirty(folio);
>         return true;
>  }
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ca9e1cd3cd68..c79c6806560b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -776,7 +776,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct folio *folio,
>
>                 if (reclaimed && !mapping_exiting(mapping))
>                         shadow =3D workingset_eviction(folio, target_memc=
g);
> -               __delete_from_swap_cache(folio, swap, shadow);
> +               __swap_cache_del_folio(folio, swap, shadow);
>                 memcg1_swapout(folio, swap);
>                 xa_unlock_irq(&mapping->i_pages);
>                 put_swap_folio(folio, swap);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c88ad61b232c..3dda4310099e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1069,7 +1069,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>
>  out:
>         if (ret && ret !=3D -EEXIST) {
> -               delete_from_swap_cache(folio);
> +               swap_cache_del_folio(folio);
>                 folio_unlock(folio);
>         }
>         folio_put(folio);
> --
> 2.51.0
>
>

