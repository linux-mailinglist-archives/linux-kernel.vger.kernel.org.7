Return-Path: <linux-kernel+bounces-792708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17896B3C7DF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 068734E14DE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE2277009;
	Sat, 30 Aug 2025 04:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAuPgW6D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722452264DB
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756527815; cv=none; b=bsG+7hKmNQFq7j4AnNee1M2F3CMStwvd8vhhAtYB/vtnIqbXOeDxyHZqVGs76QVAqnQxjyJfNGAvUWRtBzYKrIi3iTchG0/1Emr2hTVApvWiVVOkPzfWPHOX6phFev0PEGeCuvi9SHRBbMbuq0uYo9qiWu5AAcyaG4oXgSelfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756527815; c=relaxed/simple;
	bh=D9KYpDUP5BVnW8FywXZwKnRRF1ITjfxzDIQ9H8sxo4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+mfR2ZolsUc6RcfGnjFxlIks9oPG/U+YfYGTF79qG4dVMlIS/wXRHmseKdZOVkLXcqnhBFvoacs/983acdQd1r9MLjzFheKeLd26av5pKP3XdeyuilodLj1+IwZyK8SV//sjB2y11EQDI4N9yc0PAuhA5hk8K0++GdLRNFREPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAuPgW6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E221AC4CEF9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756527814;
	bh=D9KYpDUP5BVnW8FywXZwKnRRF1ITjfxzDIQ9H8sxo4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PAuPgW6DTcFnirnw9UcqldJvkgib7KlFB/JhUA3yke1jVHWwKEou+iqZedEtWCd9f
	 tkGu1jrZxyuHCq56vlsy2IwPWxY8PL5832VV3EaVn8azpr2q5SI1jbKS1yWC+zZWQQ
	 allQPhuRUoHiDg1wV5RcCmDknW8AJHFEkq7ZQqOTMVVSDXfIXsMoaNLHLMeioUlxbI
	 HJ7lyW8uQ79M0MEosGWBzqqsE7wLSE++eqa4tcYess/I/lvAtHhWcLfD30c/MeMuCW
	 ZpQeUmMGZXz24pA4Gc3rxzpSiCYP4s6xaZSJuNW0NhHU3PkxOyPRcyHx1JV1tct38z
	 78x0KotLZGQsA==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e970a7f0e54so2343300276.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:23:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1VkgBjTsunSFeVt2BXOYbLpYwoWZWyGGbDkiJ7Gxx48zfqIS+kphTNYctoSU6r8dDKnql//e2SzexS54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dAdY9HlQ5a4sr7I8VxPsNAzSlwCU8qrOiZUQvkXknoOXr+bH
	oMBK5xzL9eKWBYuqQPlIwXzeVDa0QiA7Jbd9trcm9vR5kpIRuOFuhKN+V3TwXNBwQeHZLOO764R
	gul411roiGA6jjg8cUccbVCCdl7LZdNHMabgZE8Qimw==
X-Google-Smtp-Source: AGHT+IHUYw5iTZZitWn5/kKGBPhEdinJ2+s/C+umqFngBTgvc3KVlGfasTHujxDCl4c1wk8GQEV+wkrPMOG9LwOTEh4=
X-Received: by 2002:a05:690c:a053:b0:722:7941:4f63 with SMTP id
 00721157ae682-722794152b5mr2931557b3.38.1756527814094; Fri, 29 Aug 2025
 21:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-10-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-10-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 21:23:23 -0700
X-Gmail-Original-Message-ID: <CACePvbWSsy4BzJuWOHr5k_g9D3jqjevdWtwPoTg88H0O+noE0A@mail.gmail.com>
X-Gm-Features: Ac12FXz6jrOEFnuqwA82LzX_2OD8nZLAfwzRWUeO3BPVny99yHfT1S7Pw2lZEkg
Message-ID: <CACePvbWSsy4BzJuWOHr5k_g9D3jqjevdWtwPoTg88H0O+noE0A@mail.gmail.com>
Subject: Re: [PATCH 9/9] mm, swap: use a single page for swap table when the
 size fits
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

On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> We have a cluster size of 512 slots. Each slot consumes 8 bytes in swap
> table so the swap table size of each cluster is exactly one page (4K).
>
> If that condition is true, allocate one page direct and disable the slab
> cache to reduce the memory usage of swap table and avoid fragmentation.
>
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_table.h |  2 ++
>  mm/swapfile.c   | 50 ++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index 4e97513b11ef..984474e37dd7 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -11,6 +11,8 @@ struct swap_table {
>         atomic_long_t entries[SWAPFILE_CLUSTER];
>  };
>
> +#define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) =3D=3D PAGE_SIZE)
> +
>  /*
>   * A swap table entry represents the status of a swap slot on a swap
>   * (physical or virtual) device. The swap table in each cluster is a
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 00651e947eb2..7539ee26d59a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -432,6 +432,38 @@ static inline unsigned int cluster_offset(struct swa=
p_info_struct *si,
>         return cluster_index(si, ci) * SWAPFILE_CLUSTER;
>  }
>
> +static struct swap_table *swap_table_alloc(gfp_t gfp)
> +{
> +       struct folio *folio;
> +
> +       if (!SWP_TABLE_USE_PAGE)
> +               return kmem_cache_zalloc(swap_table_cachep, gfp);
> +
> +       folio =3D folio_alloc(gfp | __GFP_ZERO, 0);
> +       if (folio)
> +               return folio_address(folio);
> +       return NULL;
> +}
> +
> +static void swap_table_free_folio_rcu_cb(struct rcu_head *head)
> +{
> +       struct folio *folio;
> +
> +       folio =3D page_folio(container_of(head, struct page, rcu_head));
> +       folio_put(folio);
> +}
> +
> +static void swap_table_free(struct swap_table *table)
> +{
> +       if (!SWP_TABLE_USE_PAGE) {
> +               kmem_cache_free(swap_table_cachep, table);
> +               return;
> +       }
> +
> +       call_rcu(&(folio_page(virt_to_folio(table), 0)->rcu_head),
> +                swap_table_free_folio_rcu_cb);
> +}
> +
>  static void swap_cluster_free_table(struct swap_cluster_info *ci)
>  {
>         unsigned int ci_off;
> @@ -445,7 +477,7 @@ static void swap_cluster_free_table(struct swap_clust=
er_info *ci)
>         table =3D (void *)rcu_dereference_protected(ci->table, true);
>         rcu_assign_pointer(ci->table, NULL);
>
> -       kmem_cache_free(swap_table_cachep, table);
> +       swap_table_free(table);
>  }
>
>  /*
> @@ -469,8 +501,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>         lockdep_assert_held(&ci->lock);
>         lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
>
> -       table =3D kmem_cache_zalloc(swap_table_cachep,
> -                                 __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_N=
OWARN);
> +       table =3D swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_=
NOWARN);
>         if (table) {
>                 rcu_assign_pointer(ci->table, table);
>                 return ci;
> @@ -485,7 +516,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>         if (!(si->flags & SWP_SOLIDSTATE))
>                 spin_unlock(&si->global_cluster_lock);
>         local_unlock(&percpu_swap_cluster.lock);
> -       table =3D kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_K=
ERNEL);
> +       table =3D swap_table_alloc(__GFP_HIGH | GFP_KERNEL);
>
>         local_lock(&percpu_swap_cluster.lock);
>         if (!(si->flags & SWP_SOLIDSTATE))
> @@ -522,7 +553,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>
>  free_table:
>         if (table)
> -               kmem_cache_free(swap_table_cachep, table);
> +               swap_table_free(table);
>         return ci;
>  }
>
> @@ -740,7 +771,7 @@ static int inc_cluster_info_page(struct swap_info_str=
uct *si,
>
>         ci =3D cluster_info + idx;
>         if (!ci->table) {
> -               table =3D kmem_cache_zalloc(swap_table_cachep, GFP_KERNEL=
);
> +               table =3D swap_table_alloc(GFP_KERNEL);
>                 if (!table)
>                         return -ENOMEM;
>                 rcu_assign_pointer(ci->table, table);
> @@ -4076,9 +4107,10 @@ static int __init swapfile_init(void)
>          * only, and all swap cache readers (swap_cache_*) verifies
>          * the content before use. So it's safe to use RCU slab here.
>          */
> -       swap_table_cachep =3D kmem_cache_create("swap_table",
> -                           sizeof(struct swap_table),
> -                           0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);
> +       if (!SWP_TABLE_USE_PAGE)
> +               swap_table_cachep =3D kmem_cache_create("swap_table",
> +                                   sizeof(struct swap_table),
> +                                   0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,=
 NULL);
>
>  #ifdef CONFIG_MIGRATION
>         if (swapfile_maximum_size >=3D (1UL << SWP_MIG_TOTAL_BITS))
> --
> 2.51.0
>

