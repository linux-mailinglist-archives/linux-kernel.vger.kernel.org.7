Return-Path: <linux-kernel+bounces-876776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A216DC1C4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A681887AD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776292F2914;
	Wed, 29 Oct 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLrTxHmB"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC6F38F9C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756765; cv=none; b=kpS3hX0v65uDKUyNLRCDEnxE9fMj6DlHl95vPmmjuVjakHC9BjK16mHzgDXBOseYBG9rVMVghK2aNL5ZQB+CSEzyKmgD2G1oxYxDrHzpz7MSoQXsENoZKrowSFA3EkcFXkngDD4yW4YaD7v13kSOujFosSxbR5PQxcMWhAFhsps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756765; c=relaxed/simple;
	bh=KpTU/URMfVr/LV3wrSu4lh7XaS5Ic6HgRQsEuFiwDeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNuKuM8mF8qYJNl/PAr9uwp3blAP0zJt6WMv8Tu+Fa0rW8+nhCHVaVzOM5zUuEQuTye34wdCQgdCPZ5XzmMY7ImQQWfzm7Of6536BhVwvv5Rw/K1jDEmtjMng1MegkN2ZyVrcpAnfVTcwMwZRUyaJsgnLau5iLL1O4/cSrfbTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLrTxHmB; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso2214093a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761756761; x=1762361561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxIiZdmCR4l+l3+mT+wF8H2WP52Uj/fpDJXLbSoOq5U=;
        b=ZLrTxHmB0XoY5dcsvZ5wFDMHjnLwKgagsJrTV8wVYUXJj951xddmXHjhp3VW2nudpq
         CQ/sHm3S/GBCHlIcbIgnyMYq77TaNv0nFfjFLL/Kujap+g4abq3GcZ0JgQd+4tCyQdQ9
         UL/L7HNxsMTz7qWzOy8/diuR9tNN/1/AUjT5YjfN0LD6Qwfgoe3tqEB1T9Z4zPsBvNWD
         Hn4bHRR+NeiBrozEsHMh54CbaBZfc3rIjzfsElHRJAwXHS4LOnMwyneg98iKhYrLMBpO
         RPcpY2UXfOWazl8o3zStd41ZHoFgF4a28SBDbNc52pr4ckvBiv1Wyp1sSeqPAd6nINWj
         dUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761756761; x=1762361561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxIiZdmCR4l+l3+mT+wF8H2WP52Uj/fpDJXLbSoOq5U=;
        b=KaihIlxB+QYB9/t0x8B5NtDMYKZ5LSm4I4rPwAFACT4BSsnEe1kQ4xxt78WVgJehqJ
         WA4wii0zRmXFBJYQVZ5fVrmKPSNDccU9Y31YL6QYsQESX99KNoFhuQq7Gs56Zz0R1j5T
         WhL1wvcomI0so0rWJYQHjtqF5I0elGXj5laMLLS9FfLkDfTh/zui/a2NArIEaFSKVOWT
         PoeYb73zT9+bwX5eitlWoBSDrakxMajZ9HEw13SDuNJ+6mXZQpNKPOZ9+li3zNPG0Jj4
         U6ass6TJ2rh2VcXNmvHOFVXjlp8H4AYsX+p4RRT1maZHAEZ7VM4UsrpllmYvA63+6FFc
         flxw==
X-Forwarded-Encrypted: i=1; AJvYcCU5IqZYvdwBYMrc/+F2nET4Xz9gGzDWL357xo/LISRoLhvrNlbCMyJ9FssAC8NvrbxJtWvFFMPWElmGKO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfq9RBQOJ2y3wi98FbAqD9sg2JQ1PWFwYZRFUCDfgXEiijrlLY
	GYChGvp75xQh1RD0pwwMa2iCcoQhQwsnKm0hLD2LV1SZLQ6nOLs1Nt11/ATF/DcW2doitonRZgC
	nUYrwO5Q9vlYj4KBZ1JoVSvvy7Hf5vYI=
X-Gm-Gg: ASbGncsIsvNBfEMXACXM4bKJ0nFZ52vQ+OeJbC/UiJv4ni5YBsBe3plhs2gUIrV4ATS
	qfB9jA6p8whoi3F3xVquT0XQt6YxHbFV3zuWbNT0CAVQb1QN6gZUKb0nM6JnOUZXYDtaIboksnz
	MYEssHXBChDyj9mqpI+IY+7p2aB5b5I7ME8wSvrBYLEY0RaGpEA+zkgdzD+xs3/XszBgq8XVb1K
	miDIfGBglGJGacvzYUHAwZCZozDarkhC5maYDnxWOHaqkS7r2fk5jJTsDNn2cUM
X-Google-Smtp-Source: AGHT+IHacpdKc30K8FLtmyAaWXw86AMI/5EseS3Bs4NYNBvfYIC6+In9XAmrl9ZJCLU9Jf2zNb6sS2FMrcpo5JNezHc=
X-Received: by 2002:a05:6402:641:b0:63c:b6e:d1ea with SMTP id
 4fb4d7f45d1cf-6405eff0d98mr192089a12.18.1761756760565; Wed, 29 Oct 2025
 09:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com> <20251029-swap-table-p2-v1-15-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-15-3d43f3b6ec32@tencent.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 30 Oct 2025 00:52:04 +0800
X-Gm-Features: AWmQ_bkNsf0fABBEuQdGaHWQTwp5B0Y2yV-Y5bwZeux_WVwreuxY1OgZhUEou1w
Message-ID: <CAMgjq7AwDH0+s__AYj5os0UzRjjAW6Q8snMA-FcW1NOuD8zWEg@mail.gmail.com>
Subject: Re: [PATCH 15/19] mm, swap: add folio to swap cache directly on allocation
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:00=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> The allocator uses SWAP_HAS_CACHE to pin a swap slot upon allocation.
> SWAP_HAS_CACHE is being deprecated as it caused a lot of confusion.
> This pinning usage here can be dropped by adding the folio to swap
> cache directly on allocation.
>
> All swap allocations are folio-based now (except for hibernation), so
> the swap allocator can always take the folio as the parameter. And now
> both swap cache (swap table) and swap map are protected by the cluster
> lock, scanning the map and inserting the folio can be done in the same
> critical section. This eliminates the time window that a slot is pinned
> by SWAP_HAS_CACHE, but it has no cache, and avoids touching the lock
> multiple times.
>
> This is both a cleanup and an optimization.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |   5 --
>  mm/swap.h            |   8 +--
>  mm/swap_state.c      |  56 +++++++++++-------
>  mm/swapfile.c        | 161 +++++++++++++++++++++------------------------=
------
>  4 files changed, 105 insertions(+), 125 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index ac3caa4c6999..4b4b81fbc6a3 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -452,7 +452,6 @@ static inline long get_nr_swap_pages(void)
>  }
>
>  extern void si_swapinfo(struct sysinfo *);
> -void put_swap_folio(struct folio *folio, swp_entry_t entry);
>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  int swap_type_of(dev_t device, sector_t offset);
>  int find_first_swap(dev_t *device);
> @@ -534,10 +533,6 @@ static inline void swap_put_entries_direct(swp_entry=
_t ent, int nr)
>  {
>  }
>
> -static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
> -{
> -}
> -
>  static inline int __swap_count(swp_entry_t entry)
>  {
>         return 0;
> diff --git a/mm/swap.h b/mm/swap.h
> index 74c61129d7b7..03694ffa662f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -277,13 +277,13 @@ void __swapcache_clear_cached(struct swap_info_stru=
ct *si,
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry);
>  void *swap_cache_get_shadow(swp_entry_t entry);
> -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -                        void **shadow, bool alloc);
>  void swap_cache_del_folio(struct folio *folio);
>  struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
>                                      struct mempolicy *mpol, pgoff_t ilx,
>                                      bool *alloced);
>  /* Below helpers require the caller to lock and pass in the swap cluster=
. */
> +void __swap_cache_add_folio(struct swap_cluster_info *ci,
> +                           struct folio *folio, swp_entry_t entry);
>  void __swap_cache_del_folio(struct swap_cluster_info *ci,
>                             struct folio *folio, swp_entry_t entry, void =
*shadow);
>  void __swap_cache_replace_folio(struct swap_cluster_info *ci,
> @@ -459,8 +459,8 @@ static inline void *swap_cache_get_shadow(swp_entry_t=
 entry)
>         return NULL;
>  }
>
> -static inline int swap_cache_add_folio(struct folio *folio, swp_entry_t =
entry,
> -                                      void **shadow, bool alloc)
> +static inline void *__swap_cache_add_folio(struct swap_cluster_info *ci,
> +               struct folio *folio, swp_entry_t entry)
>  {
>  }
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d2bcca92b6e0..85d9f99c384f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -122,6 +122,34 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>         return NULL;
>  }
>
> +void __swap_cache_add_folio(struct swap_cluster_info *ci,
> +                           struct folio *folio, swp_entry_t entry)
> +{
> +       unsigned long new_tb;
> +       unsigned int ci_start, ci_off, ci_end;
> +       unsigned long nr_pages =3D folio_nr_pages(folio);
> +
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +       VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
> +
> +       new_tb =3D folio_to_swp_tb(folio);
> +       ci_start =3D swp_cluster_offset(entry);
> +       ci_off =3D ci_start;
> +       ci_end =3D ci_start + nr_pages;
> +       do {
> +               VM_WARN_ON_ONCE(swp_tb_is_folio(__swap_table_get(ci, ci_o=
ff)));
> +               __swap_table_set(ci, ci_off, new_tb);
> +       } while (++ci_off < ci_end);
> +
> +       folio_ref_add(folio, nr_pages);
> +       folio_set_swapcache(folio);
> +       folio->swap =3D entry;
> +
> +       node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> +       lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> +}
> +
>  /**
>   * swap_cache_add_folio - Add a folio into the swap cache.
>   * @folio: The folio to be added.
> @@ -136,23 +164,18 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>   * The caller also needs to update the corresponding swap_map slots with
>   * SWAP_HAS_CACHE bit to avoid race or conflict.
>   */
> -int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -                        void **shadowp, bool alloc)
> +static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> +                               void **shadowp)
>  {
>         int err;
>         void *shadow =3D NULL;
> +       unsigned long old_tb;
>         struct swap_info_struct *si;
> -       unsigned long old_tb, new_tb;
>         struct swap_cluster_info *ci;
>         unsigned int ci_start, ci_off, ci_end, offset;
>         unsigned long nr_pages =3D folio_nr_pages(folio);
>
> -       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> -       VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
> -       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
> -
>         si =3D __swap_entry_to_info(entry);
> -       new_tb =3D folio_to_swp_tb(folio);
>         ci_start =3D swp_cluster_offset(entry);
>         ci_end =3D ci_start + nr_pages;
>         ci_off =3D ci_start;
> @@ -168,7 +191,7 @@ int swap_cache_add_folio(struct folio *folio, swp_ent=
ry_t entry,
>                         err =3D -EEXIST;
>                         goto failed;
>                 }
> -               if (!alloc && unlikely(!__swap_count(swp_entry(swp_type(e=
ntry), offset)))) {
> +               if (unlikely(!__swap_count(swp_entry(swp_type(entry), off=
set)))) {
>                         err =3D -ENOENT;
>                         goto failed;
>                 }
> @@ -184,20 +207,11 @@ int swap_cache_add_folio(struct folio *folio, swp_e=
ntry_t entry,
>                  * Still need to pin the slots with SWAP_HAS_CACHE since
>                  * swap allocator depends on that.
>                  */
> -               if (!alloc)
> -                       __swapcache_set_cached(si, ci, swp_entry(swp_type=
(entry), offset));
> -               __swap_table_set(ci, ci_off, new_tb);
> +               __swapcache_set_cached(si, ci, swp_entry(swp_type(entry),=
 offset));
>                 offset++;
>         } while (++ci_off < ci_end);
> -
> -       folio_ref_add(folio, nr_pages);
> -       folio_set_swapcache(folio);
> -       folio->swap =3D entry;
> +       __swap_cache_add_folio(ci, folio, entry);
>         swap_cluster_unlock(ci);
> -
> -       node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
> -       lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
> -
>         if (shadowp)
>                 *shadowp =3D shadow;
>         return 0;
> @@ -466,7 +480,7 @@ static struct folio *__swap_cache_prepare_and_add(swp=
_entry_t entry,
>         __folio_set_locked(folio);
>         __folio_set_swapbacked(folio);
>         for (;;) {
> -               ret =3D swap_cache_add_folio(folio, entry, &shadow, false=
);
> +               ret =3D swap_cache_add_folio(folio, entry, &shadow);
>                 if (!ret)
>                         break;
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 426b0b6d583f..8d98f28907bc 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -875,28 +875,53 @@ static void swap_cluster_assert_table_empty(struct =
swap_cluster_info *ci,
>         }
>  }
>
> -static bool cluster_alloc_range(struct swap_info_struct *si, struct swap=
_cluster_info *ci,
> -                               unsigned int start, unsigned char usage,
> -                               unsigned int order)
> +static bool cluster_alloc_range(struct swap_info_struct *si,
> +                               struct swap_cluster_info *ci,
> +                               struct folio *folio,
> +                               unsigned int offset)
>  {
> -       unsigned int nr_pages =3D 1 << order;
> +       unsigned long nr_pages;
> +       unsigned int order;
>
>         lockdep_assert_held(&ci->lock);
>
>         if (!(si->flags & SWP_WRITEOK))
>                 return false;
>
> +       /*
> +        * All mm swap allocation starts with a folio (folio_alloc_swap),
> +        * it's also the only allocation path for large orders allocation=
.
> +        * Such swap slots starts with count =3D=3D 0 and will be increas=
ed
> +        * upon folio unmap.
> +        *
> +        * Else, it's a exclusive order 0 allocation for hibernation.
> +        * The slot starts with count =3D=3D 1 and never increases.
> +        */
> +       if (likely(folio)) {
> +               order =3D folio_order(folio);
> +               nr_pages =3D 1 << order;
> +               /*
> +                * Pin the slot with SWAP_HAS_CACHE to satisfy swap_dup_e=
ntries.
> +                * This is the legacy allocation behavior, will drop it v=
ery soon.
> +                */
> +               memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
> +               __swap_cache_add_folio(ci, folio, swp_entry(si->type, off=
set));
> +       } else {
> +               order =3D 0;
> +               nr_pages =3D 1;
> +               WARN_ON_ONCE(si->swap_map[offset]);
> +               si->swap_map[offset] =3D 1;
> +               swap_cluster_assert_table_empty(ci, offset, 1);
> +       }
> +
>         /*
>          * The first allocation in a cluster makes the
>          * cluster exclusive to this order
>          */
>         if (cluster_is_empty(ci))
>                 ci->order =3D order;
> -
> -       memset(si->swap_map + start, usage, nr_pages);
> -       swap_cluster_assert_table_empty(ci, start, nr_pages);
> -       swap_range_alloc(si, nr_pages);
>         ci->count +=3D nr_pages;
> +       swap_range_alloc(si, nr_pages);
>
>         return true;
>  }
> @@ -904,13 +929,12 @@ static bool cluster_alloc_range(struct swap_info_st=
ruct *si, struct swap_cluster
>  /* Try use a new cluster for current CPU and allocate from it. */
>  static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
>                                             struct swap_cluster_info *ci,
> -                                           unsigned long offset,
> -                                           unsigned int order,
> -                                           unsigned char usage)
> +                                           struct folio *folio, unsigned=
 long offset)
>  {
>         unsigned int next =3D SWAP_ENTRY_INVALID, found =3D SWAP_ENTRY_IN=
VALID;
>         unsigned long start =3D ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
>         unsigned long end =3D min(start + SWAPFILE_CLUSTER, si->max);
> +       unsigned int order =3D likely(folio) ? folio_order(folio) : 0;
>         unsigned int nr_pages =3D 1 << order;
>         bool need_reclaim;
>
> @@ -930,7 +954,7 @@ static unsigned int alloc_swap_scan_cluster(struct sw=
ap_info_struct *si,
>                                 continue;
>                         offset =3D found;
>                 }
> -               if (!cluster_alloc_range(si, ci, offset, usage, order))
> +               if (!cluster_alloc_range(si, ci, folio, offset))
>                         break;
>                 found =3D offset;
>                 offset +=3D nr_pages;
> @@ -952,8 +976,7 @@ static unsigned int alloc_swap_scan_cluster(struct sw=
ap_info_struct *si,
>
>  static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
>                                          struct list_head *list,
> -                                        unsigned int order,
> -                                        unsigned char usage,
> +                                        struct folio *folio,
>                                          bool scan_all)
>  {
>         unsigned int found =3D SWAP_ENTRY_INVALID;
> @@ -965,7 +988,7 @@ static unsigned int alloc_swap_scan_list(struct swap_=
info_struct *si,
>                 if (!ci)
>                         break;
>                 offset =3D cluster_offset(si, ci);
> -               found =3D alloc_swap_scan_cluster(si, ci, offset, order, =
usage);
> +               found =3D alloc_swap_scan_cluster(si, ci, folio, offset);
>                 if (found)
>                         break;
>         } while (scan_all);
> @@ -1026,10 +1049,11 @@ static void swap_reclaim_work(struct work_struct =
*work)
>   * Try to allocate swap entries with specified order and try set a new
>   * cluster for current CPU too.
>   */
> -static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *s=
i, int order,
> -                                             unsigned char usage)
> +static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *s=
i,
> +                                             struct folio *folio)
>  {
>         struct swap_cluster_info *ci;
> +       unsigned int order =3D likely(folio) ? folio_order(folio) : 0;
>         unsigned int offset =3D SWAP_ENTRY_INVALID, found =3D SWAP_ENTRY_=
INVALID;
>
>         /*
> @@ -1051,8 +1075,7 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                 if (cluster_is_usable(ci, order)) {
>                         if (cluster_is_empty(ci))
>                                 offset =3D cluster_offset(si, ci);
> -                       found =3D alloc_swap_scan_cluster(si, ci, offset,
> -                                                       order, usage);
> +                       found =3D alloc_swap_scan_cluster(si, ci, folio, =
offset);
>                 } else {
>                         swap_cluster_unlock(ci);
>                 }
> @@ -1066,22 +1089,19 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
>          * to spread out the writes.
>          */
>         if (si->flags & SWP_PAGE_DISCARD) {
> -               found =3D alloc_swap_scan_list(si, &si->free_clusters, or=
der, usage,
> -                                            false);
> +               found =3D alloc_swap_scan_list(si, &si->free_clusters, fo=
lio, false);
>                 if (found)
>                         goto done;
>         }
>
>         if (order < PMD_ORDER) {
> -               found =3D alloc_swap_scan_list(si, &si->nonfull_clusters[=
order],
> -                                            order, usage, true);
> +               found =3D alloc_swap_scan_list(si, &si->nonfull_clusters[=
order], folio, true);
>                 if (found)
>                         goto done;
>         }
>
>         if (!(si->flags & SWP_PAGE_DISCARD)) {
> -               found =3D alloc_swap_scan_list(si, &si->free_clusters, or=
der, usage,
> -                                            false);
> +               found =3D alloc_swap_scan_list(si, &si->free_clusters, fo=
lio, false);
>                 if (found)
>                         goto done;
>         }
> @@ -1097,8 +1117,7 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                  * failure is not critical. Scanning one cluster still
>                  * keeps the list rotated and reclaimed (for HAS_CACHE).
>                  */
> -               found =3D alloc_swap_scan_list(si, &si->frag_clusters[ord=
er], order,
> -                                            usage, false);
> +               found =3D alloc_swap_scan_list(si, &si->frag_clusters[ord=
er], folio, false);
>                 if (found)
>                         goto done;
>         }
> @@ -1112,13 +1131,11 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si, int o
>                  * Clusters here have at least one usable slots and can't=
 fail order 0
>                  * allocation, but reclaim may drop si->lock and race wit=
h another user.
>                  */
> -               found =3D alloc_swap_scan_list(si, &si->frag_clusters[o],
> -                                            0, usage, true);
> +               found =3D alloc_swap_scan_list(si, &si->frag_clusters[o],=
 folio, true);
>                 if (found)
>                         goto done;
>
> -               found =3D alloc_swap_scan_list(si, &si->nonfull_clusters[=
o],
> -                                            0, usage, true);
> +               found =3D alloc_swap_scan_list(si, &si->nonfull_clusters[=
o], folio, true);
>                 if (found)
>                         goto done;
>         }
> @@ -1309,12 +1326,12 @@ static bool get_swap_device_info(struct swap_info=
_struct *si)
>   * Fast path try to get swap entries with specified order from current
>   * CPU's swap entry pool (a cluster).
>   */
> -static bool swap_alloc_fast(swp_entry_t *entry,
> -                           int order)
> +static bool swap_alloc_fast(struct folio *folio)
>  {
> +       unsigned int order =3D folio_order(folio);
>         struct swap_cluster_info *ci;
>         struct swap_info_struct *si;
> -       unsigned int offset, found =3D SWAP_ENTRY_INVALID;
> +       unsigned int offset;
>
>         /*
>          * Once allocated, swap_info_struct will never be completely free=
d,
> @@ -1329,22 +1346,18 @@ static bool swap_alloc_fast(swp_entry_t *entry,
>         if (cluster_is_usable(ci, order)) {
>                 if (cluster_is_empty(ci))
>                         offset =3D cluster_offset(si, ci);
> -               found =3D alloc_swap_scan_cluster(si, ci, offset, order, =
SWAP_HAS_CACHE);
> -               if (found)
> -                       *entry =3D swp_entry(si->type, found);
> +               alloc_swap_scan_cluster(si, ci, folio, offset);
>         } else {
>                 swap_cluster_unlock(ci);
>         }
>
>         put_swap_device(si);
> -       return !!found;
> +       return folio_test_swapcache(folio);
>  }
>
>  /* Rotate the device and switch to a new cluster */
> -static bool swap_alloc_slow(swp_entry_t *entry,
> -                           int order)
> +static void swap_alloc_slow(struct folio *folio)
>  {
> -       unsigned long offset;
>         struct swap_info_struct *si, *next;
>
>         spin_lock(&swap_avail_lock);
> @@ -1354,14 +1367,12 @@ static bool swap_alloc_slow(swp_entry_t *entry,
>                 plist_requeue(&si->avail_list, &swap_avail_head);
>                 spin_unlock(&swap_avail_lock);
>                 if (get_swap_device_info(si)) {
> -                       offset =3D cluster_alloc_swap_entry(si, order, SW=
AP_HAS_CACHE);
> +                       cluster_alloc_swap_entry(si, folio);
>                         put_swap_device(si);
> -                       if (offset) {
> -                               *entry =3D swp_entry(si->type, offset);
> -                               return true;
> -                       }
> -                       if (order)
> -                               return false;
> +                       if (folio_test_swapcache(folio))
> +                               return;
> +                       if (folio_test_large(folio))
> +                               return;
>                 }
>
>                 spin_lock(&swap_avail_lock);

My bad, following diff was lost during rebase to mm-new,
swap_alloc_slow should return void now:

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8d98f28907bc..0bc734eb32c4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1391,7 +1391,6 @@ static void swap_alloc_slow(struct folio *folio)
                        goto start_over;
        }
        spin_unlock(&swap_avail_lock);
-       return false;
 }

