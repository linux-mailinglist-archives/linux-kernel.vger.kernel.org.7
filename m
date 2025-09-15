Return-Path: <linux-kernel+bounces-817283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E703B58032
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC62D18867FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55A341648;
	Mon, 15 Sep 2025 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnOB47F2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577B0340DB7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948980; cv=none; b=T1TLRLirrnaYiRHUZpUfSHcjiKoYuOBbyUMBqLjcWQCHDvBXT1lw8326q64q3mXm9fbZpgdXX0lRc4JG5VRY4T0XAVYPJCZ2YW/OKUkHxU9XU29rTgo/Nxat1XrVNjkd+THwm/wr2trIoJkrHT3mDVMidQK3Pe1KfyZycnloCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948980; c=relaxed/simple;
	bh=sAILtEQ6hGjB1SZc5TaU5PYDq7RHDNmXbwdIprhruRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0c8uOt+cM5L86ZsSINNm/0fTbGNiNAEbUFOsoxD3VjpcISd4hxynK0B35sBxhMHKhssfiGHgTlZrfCMSaXwkISUZg8bGDlBrRtK/dUbIIDKP0lItNO040QILXT3/PggDJaPuVu5VK7Cc53XlajkS4o6DL+U9NzRtzpKIjgLcmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnOB47F2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7E1C4AF09
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948979;
	bh=sAILtEQ6hGjB1SZc5TaU5PYDq7RHDNmXbwdIprhruRw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MnOB47F25pAVMRV7B7hOz+/+mz8iKxW4EC1uh2wRJouQGxZ8db9vC80o7Mj0Bcpzc
	 78sBKRFywdV0HEO5N0KRUHTEeidc2pFutLjUOqTRlnJh3a5e6OLve0pQbYvPEKcNk+
	 jr/cJzlITPy3WMtZ0BPLskDEXI0ndTO0/ZhyDln/opdykVUfOtRbuMOaXZLPnflZUQ
	 dsKY0Ytk5+RszljahsY2Bcu0juZU/ngjxGIjupJDtMdOnLtlmdvxOcGvPobcOiRzsT
	 cPep2YVYK/TETJYRHh306VuADIXZjwjkJwykO/7+6U25dnrm+OcL4lpJXFOX+Q+uhq
	 MypiuGG5z/9BA==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so27200855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:09:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4cBgh05Ve2+1tEHkJ3eLhy9ucRGNQOFgBdGHgMlVaf4o9l9jhDy6zNsFLHroYwa6B8yB34aKbccYYiP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlwPqZluwcjqCfAdI68unzz8oAPBYzSr6ejvM+jimfODiu2ZYp
	hPGQQn/EMzRG2xWyL2MnTm/5MFjBTok4tnJKRSGOLrDUYOPJuUQQ9mei7F0h8q6/1WaSta2UGSY
	LRBN5xBqISBflPUaAilxiPpGkzzIAP2ffuP1AwrmdJQ==
X-Google-Smtp-Source: AGHT+IFZcDUDotIs1MFDsw2dmuzKjvdCb4zDoIEg+yTNJzNFpyVIBaetpEjE4dOCgEJV2HI6RJBat69v2VCnXmjopK4=
X-Received: by 2002:a5d:55c6:0:b0:3e7:d909:4c1c with SMTP id
 ffacd0b85a97d-3e7d9094ccemr8362992f8f.11.1757948978654; Mon, 15 Sep 2025
 08:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-11-ryncsn@gmail.com>
In-Reply-To: <20250910160833.3464-11-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 15 Sep 2025 08:09:26 -0700
X-Gmail-Original-Message-ID: <CACePvbUM1-xmgttL5R06qrULDq_eiHT0jPRpcfrZJX2ch6tZSg@mail.gmail.com>
X-Gm-Features: AS18NWBTpBv2ceo-93-keDns1VW92yPyG7W7vfAHNpWFmTjFfAIjeCnq2vHXyIM
Message-ID: <CACePvbUM1-xmgttL5R06qrULDq_eiHT0jPRpcfrZJX2ch6tZSg@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] mm, swap: wrap swap cache replacement with a helper
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Wed, Sep 10, 2025 at 9:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> There are currently three swap cache users that are trying to replace an
> existing folio with a new one: huge memory splitting, migration, and
> shmem replacement. What they are doing is quite similar.
>
> Introduce a common helper for this. In later commits, this can be easily
> switched to use the swap table by updating this helper.
>
> The newly added helper also makes the swap cache API better defined, and
> make debugging easier by adding a few more debug checks.
>
> Migration and shmem replace are meant to clone the folio, including
> content, swap entry value, and flags. And splitting will adjust each
> sub folio's swap entry according to order, which could be non-uniform in
> the future. So document it clearly that it's the caller's responsibility
> to set up the new folio's swap entries and flags before calling the helpe=
r.
> The helper will just follow the new folio's entry value.
>
> This also prepares for replacing high-order folios in the swap cache.
> Currently, only splitting to order 0 is allowed for swap cache folios.
> Using the new helper, we can handle high-order folio splitting better.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/huge_memory.c |  4 +---
>  mm/migrate.c     | 11 +++--------
>  mm/shmem.c       | 10 ++--------
>  mm/swap.h        |  5 +++++
>  mm/swap_state.c  | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 44 insertions(+), 19 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd7418..4c66e358685b 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3798,9 +3798,7 @@ static int __folio_split(struct folio *folio, unsig=
ned int new_order,
>                          * NOTE: shmem in swap cache is not supported yet=
.
>                          */
>                         if (swap_cache) {
> -                               __xa_store(&swap_cache->i_pages,
> -                                          swap_cache_index(new_folio->sw=
ap),
> -                                          new_folio, 0);
> +                               __swap_cache_replace_folio(folio, new_fol=
io);
>                                 continue;
>                         }
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8e435a078fc3..c69cc13db692 100644
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
> +               __swap_cache_replace_folio(folio, newfolio);
> +       else
>                 xas_store(&xas, newfolio);
> -               xas_next(&xas);
> -       }
>
>         /*
>          * Drop cache reference from old folio by unfreezing
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5f395fab489c..8930780325da 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2086,10 +2086,8 @@ static int shmem_replace_folio(struct folio **foli=
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
> @@ -2118,12 +2116,8 @@ static int shmem_replace_folio(struct folio **foli=
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
> +       __swap_cache_replace_folio(old, new);
>         xa_unlock_irq(&swap_mapping->i_pages);
>
>         mem_cgroup_replace_folio(old, new);
> diff --git a/mm/swap.h b/mm/swap.h
> index 6c4acb549bec..fe579c81c6c4 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -185,6 +185,7 @@ int swap_cache_add_folio(struct folio *folio, swp_ent=
ry_t entry,
>  void swap_cache_del_folio(struct folio *folio);
>  void __swap_cache_del_folio(struct folio *folio,
>                             swp_entry_t entry, void *shadow);
> +void __swap_cache_replace_folio(struct folio *old, struct folio *new);
>  void swap_cache_clear_shadow(int type, unsigned long begin,
>                              unsigned long end);
>
> @@ -336,6 +337,10 @@ static inline void __swap_cache_del_folio(struct fol=
io *folio, swp_entry_t entry
>  {
>  }
>
> +static inline void __swap_cache_replace_folio(struct folio *old, struct =
folio *new)
> +{
> +}
> +
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
>         return 0;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index f3a32a06a950..d1f5b8fa52fc 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -234,6 +234,39 @@ void swap_cache_del_folio(struct folio *folio)
>         folio_ref_sub(folio, folio_nr_pages(folio));
>  }
>
> +/**
> + * __swap_cache_replace_folio - Replace a folio in the swap cache.
> + * @old: The old folio to be replaced.
> + * @new: The new folio.
> + *
> + * Replace an existing folio in the swap cache with a new folio. The
> + * caller is responsible for setting up the new folio's flag and swap
> + * entries. Replacement will take the new folio's swap entry value as
> + * the starting offset to override all slots covered by the new folio.
> + *
> + * Context: Caller must ensure both folios are locked, also lock the
> + * swap address_space that holds the old folio to avoid races.
> + */
> +void __swap_cache_replace_folio(struct folio *old, struct folio *new)
> +{
> +       swp_entry_t entry =3D new->swap;
> +       unsigned long nr_pages =3D folio_nr_pages(new);
> +       unsigned long offset =3D swap_cache_index(entry);
> +       unsigned long end =3D offset + nr_pages;
> +
> +       XA_STATE(xas, &swap_address_space(entry)->i_pages, offset);
> +
> +       VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcac=
he(new));
> +       VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new=
));
> +       VM_WARN_ON_ONCE(!entry.val);
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

