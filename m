Return-Path: <linux-kernel+bounces-803984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA8B46849
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0491B24BBE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502F1F5847;
	Sat,  6 Sep 2025 02:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpX8BKBo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7C679F5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124739; cv=none; b=djwMAwPe3j/QO7KhUxJnXm/L5NCbnXdl+rBqn+DjVhgg2mqa+IYeWebfqhkSl1IghKSFnEF228m4AgtRUwC3CLtCl0ikAu9MtKK9cTPK0X9EnwnZ5AdHtk0SrODnoP7V/ELNQoISqaYTXFM1VCr18Y3j1xWguxopkdKMxOKD0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124739; c=relaxed/simple;
	bh=yML2qgT+qxBmlSd/IZdm7TNlpAMRVBX1yWUFsXuETco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tb36cvpod8s4HXWirD57rtmQZu/DwuZgPBD5AEO0bf7vyDOcJWMyNUt2jcLQjuAAiyiHsvvXfwGh6AKkBh/7rDuAT6h5U2fC+Wq3Q++k1VUcMuAfLlU2yZnvnlV1adyztlc8AYXBV/LDAgfQ5v17wzu/v+8EZJu5LFsjtDZ4SWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpX8BKBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C2FC4CEFF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757124738;
	bh=yML2qgT+qxBmlSd/IZdm7TNlpAMRVBX1yWUFsXuETco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YpX8BKBoOp9qHx+Gji1p6dbvNZ2tTGH50T0TdZp5S7TOZ2DERWwYhco9fbAVHscPO
	 29mEruYFE3Vu4JsPH/yvK0jDmQ74drXQD+gcQWW/hFFB6SLoO5KBYC9or/t6ebPyMj
	 MV6H9cp2/auZ1YM4PD3fv/MGU6SLh7Db/GhHHSgNWPBEUqqm6bWXa8ho+RsWxLqs1f
	 6TJPQsZDSAuc1Xd2DanpaSqq//jbuP7MuUKPVmiaPhde+z0nbuNvZzd+Ta9BAB/od4
	 6KPclfUL2IKfN976oxRb/ahGKXtEaNRcOSNSNB1uMUwaTVsnNXOicVV0REoZ558BLc
	 AGbjBkrtXSP2g==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so33195e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:12:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzHpN8atmaDkkCk+shMLhDTbBGZ6mo5ZdUctCm2eo6C8dUgTsXfIvnS/531XZC+cVoBUdzL+GjRYEmNTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGHx2VYWnqkifyNScHluym9WFQp4TmET5Sk7zKS74x1xieDu0V
	deCmrcoZ8XyIlTSmXkjLQu76qurpcLot5azcfyvbiaJaiJ5X5PMFRSIU+QpEAcCw1BgUDWhcB5x
	BqJF/w61CmU+6TFLb66eMne1Yrd+5xhkq4tsx0Iiz
X-Google-Smtp-Source: AGHT+IHKT6GE2df18G/b/qZaSo1a90rXDasB7VtwNKZ1fV2iHfqLus/pUkJM1UPUZUqxY/NljemSK47uT4nMbvBRAso=
X-Received: by 2002:a05:600c:34cb:b0:45c:b678:296 with SMTP id
 5b1f17b1804b1-45dde17c034mr425685e9.5.1757124737301; Fri, 05 Sep 2025
 19:12:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-6-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-6-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 19:12:06 -0700
X-Gmail-Original-Message-ID: <CAF8kJuM1Qjq2QjX-=XiUZ3EATPcX8wY0_COdce+Zf8nb=1v8Aw@mail.gmail.com>
X-Gm-Features: Ac12FXxhZJcLtO8jUl865bVVKEgfpFIwarkLqkM1zXOafPNb9tKeXQh2_BzYo_c
Message-ID: <CAF8kJuM1Qjq2QjX-=XiUZ3EATPcX8wY0_COdce+Zf8nb=1v8Aw@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] mm, swap: always lock and check the swap cache
 folio before use
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

Looks correct to me.

Acked-by: Chris Li <chrisl@kernel.org>

With some nitpick follows,

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cache lookup only increases the reference count of the returned
> folio. That's not enough to ensure a folio is stable in the swap
> cache, so the folio could be removed from the swap cache at any
> time. The caller should always lock and check the folio before using it.
>
> We have just documented this in kerneldoc, now introduce a helper for swa=
p
> cache folio verification with proper sanity checks.
>
> Also, sanitize a few current users to use this convention and the new
> helper for easier debugging. They were not having observable problems
> yet, only trivial issues like wasted CPU cycles on swapoff or
> reclaiming. They would fail in some other way, but it is still better to
> always follow this convention to make things robust and make later
> commits easier to do.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     |  3 +--
>  mm/swap.h       | 24 ++++++++++++++++++++++++
>  mm/swap_state.c |  7 +++++--
>  mm/swapfile.c   | 10 +++++++---
>  4 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 94a5928e8ace..5808c4ef21b3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4748,8 +4748,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                  * swapcache, we need to check that the page's swap has n=
ot
>                  * changed.
>                  */
> -               if (unlikely(!folio_test_swapcache(folio) ||
> -                            page_swap_entry(page).val !=3D entry.val))
> +               if (unlikely(!folio_matches_swap_entry(folio, entry)))
>                         goto out_page;
>
>                 if (unlikely(PageHWPoison(page))) {
> diff --git a/mm/swap.h b/mm/swap.h
> index efb6d7ff9f30..a69e18b12b45 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -52,6 +52,25 @@ static inline pgoff_t swap_cache_index(swp_entry_t ent=
ry)
>         return swp_offset(entry) & SWAP_ADDRESS_SPACE_MASK;
>  }
>
> +/**
> + * folio_matches_swap_entry - Check if a folio matches a given swap entr=
y.
> + * @folio: The folio.
> + * @entry: The swap entry to check against.
> + *
> + * Context: The caller should have the folio locked to ensure it's stabl=
e
> + * and nothing will move it in or out of the swap cache.
> + * Return: true or false.
> + */
> +static inline bool folio_matches_swap_entry(const struct folio *folio,
> +                                           swp_entry_t entry)
> +{
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +       if (!folio_test_swapcache(folio))
> +               return false;
> +       VM_WARN_ON_ONCE_FOLIO(!IS_ALIGNED(folio->swap.val, folio_nr_pages=
(folio)), folio);

You should cache the folio->swap.val into a local register value.
Because WARN_ON_ONCE I think the compiler has no choice but to load it
twice? Haven't verified it myself.

There is no downside in compiler point of view using more local
variables, the compiler generates an internal version of the local
variable equivalent anyway.

> +       return folio->swap.val =3D=3D round_down(entry.val, folio_nr_page=
s(folio));

Same for folio_nr_pages(folio), you should cache it. The function will
look less busy.

Chris

> +}
> +
>  void show_swap_cache_info(void);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);
>  int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
> @@ -144,6 +163,11 @@ static inline pgoff_t swap_cache_index(swp_entry_t e=
ntry)
>         return 0;
>  }
>
> +static inline bool folio_matches_swap_entry(const struct folio *folio, s=
wp_entry_t entry)
> +{
> +       return false;
> +}
> +
>  static inline void show_swap_cache_info(void)
>  {
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 68ec531d0f2b..9225d6b695ad 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -79,7 +79,7 @@ void show_swap_cache_info(void)
>   * with reference count or locks.
>   * Return: Returns the found folio on success, NULL otherwise. The calle=
r
>   * must lock and check if the folio still matches the swap entry before
> - * use.
> + * use (e.g. with folio_matches_swap_entry).
>   */
>  struct folio *swap_cache_get_folio(swp_entry_t entry)
>  {
> @@ -346,7 +346,10 @@ struct folio *__read_swap_cache_async(swp_entry_t en=
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
> index 4c63fc62f4cb..1bd90f17440f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -240,14 +240,12 @@ static int __try_to_reclaim_swap(struct swap_info_s=
truct *si,
>          * Offset could point to the middle of a large folio, or folio
>          * may no longer point to the expected offset before it's locked.
>          */
> -       if (offset < swp_offset(folio->swap) ||
> -           offset >=3D swp_offset(folio->swap) + nr_pages) {
> +       if (!folio_matches_swap_entry(folio, entry)) {
>                 folio_unlock(folio);
>                 folio_put(folio);
>                 goto again;
>         }
>         offset =3D swp_offset(folio->swap);
> -
>         need_reclaim =3D ((flags & TTRS_ANYWAY) ||
>                         ((flags & TTRS_UNMAPPED) && !folio_mapped(folio))=
 ||
>                         ((flags & TTRS_FULL) && mem_cgroup_swap_full(foli=
o)));
> @@ -2150,6 +2148,12 @@ static int unuse_pte_range(struct vm_area_struct *=
vma, pmd_t *pmd,
>                 }
>
>                 folio_lock(folio);
> +               if (!folio_matches_swap_entry(folio, entry)) {
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

