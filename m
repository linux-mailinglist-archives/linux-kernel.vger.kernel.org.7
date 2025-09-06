Return-Path: <linux-kernel+bounces-804351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ADBB472B3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C211C2251A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AFD24169A;
	Sat,  6 Sep 2025 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SApPLkyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359F23E340
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173724; cv=none; b=Ev5VvBT6kwtE2DOo8Al2qV/QJa536K42lVO2HSREIDHGFs0X5kW8gihu1VDp1H+6mfWtHUj3m6RbWRxGSDIn/qv8uLq07L7qilGlfSLBkjZFRKd9RBq5ud0k/KoKlROdo+xulVzMzSoWFcALqIpGIFhORBRrfdOG8x9DtflFy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173724; c=relaxed/simple;
	bh=iuLWCsIBZxDQ2MBJdwm2NrZSglPZeOKYdQ7nbEyaEmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJDLlEYIIwhRa8pMIkKIk8OkuZ8KoXFocTCqayl16nfoWXJ2sQ1ML4E/GQJMJqNW+aigR29WV4l5ILVal9I/nsaY9aRyESXO6VF8FH1eBVC2zxB7EP+Rz1EuMlD0thlMKtBGzsOoI7kXWDWMXO9yIDWcvnwK7DNRAyMT5Z/FaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SApPLkyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBBBC4CEFE
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173724;
	bh=iuLWCsIBZxDQ2MBJdwm2NrZSglPZeOKYdQ7nbEyaEmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SApPLkyXCiYvF2/mq1ZP+u1HZoU5C54x+LWAvy2q+nGJykcSP7NG3LcaA2ZyxuD/a
	 vubz1HmWisy8GuQtm5mkBV1+qQZYtld9YZxiAdNMqtJzHg7olGziSzPQeNC5FX8rja
	 FuRauYCCbQPtnA71iyUZ+uJz1xQK95bcWrFbWKP+VoSDnjl/vQlT9JWDL5oyEpT4jQ
	 aGWzWymlaioi2m3V0rl0v4abwhrzUYt11adTgCWCP6siOhN5+hXMPSQ1FWlUvQHGCw
	 Qgdb42liiPGuIpoqXlRFa9PKSYGlkMtgNhZeHhIRmqhXTDy53jFLEBUOgJ9LIM54KN
	 Qq56MWUeWQX1w==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so52085e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:48:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVCouLfCZTXDACEK2Ajfdyj73jJxY/bfXEPwTChY5jvw6eGNar0fbZXbN1KpxFD++ilOjYIJv6lunkZkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7mo4ZCVCnGEmCn6tPPOW+X9sQEBUTsxR6wp4X/hhuWnNZJvS
	i0imzImhwnYwUrt2Q/EEiApsCIlPKYhzr9HJN115hXprN2QjFtf0YDMfo506AyadGPUEeRWJZvo
	FYLrG2ER6ckqJv1ADMx843vwxJWGgg7/cGOZSZhFm
X-Google-Smtp-Source: AGHT+IGfOHFfYjrv75nj+zPedFLz/C32IBV6OSZzlh+tt/0dkhgj6uNTqGVaCcOwBOvAkMKoeKUzATipNNt+w8JR9MA=
X-Received: by 2002:a05:600c:35d3:b0:45c:b4fb:f0b3 with SMTP id
 5b1f17b1804b1-45dde171ab0mr864355e9.3.1757173722805; Sat, 06 Sep 2025
 08:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-16-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-16-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 08:48:31 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOd5WHC5oHtyy3SOGNSVqwMp4YudYJi8vgdUAoskpbp9Q@mail.gmail.com>
X-Gm-Features: AS18NWBEcSo_7Xs5GSFLBOKA84DhgQEWJ_kmytYfUvUse6z9v7Oo0kH7y1QVMl4
Message-ID: <CAF8kJuOd5WHC5oHtyy3SOGNSVqwMp4YudYJi8vgdUAoskpbp9Q@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] mm, swap: use a single page for swap table when
 the size fits
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

I did not notice new changes, anyway.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Sep 5, 2025 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
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
> Acked-by: Chris Li <chrisl@kernel.org>
> ---
>  mm/swap_table.h |  2 ++
>  mm/swapfile.c   | 50 ++++++++++++++++++++++++++++++++++++++++---------
>  2 files changed, 43 insertions(+), 9 deletions(-)
>
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index 52254e455304..ea244a57a5b7 100644
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
> index 49f93069faef..ab6e877b0644 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -430,6 +430,38 @@ static inline unsigned int cluster_offset(struct swa=
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
> @@ -443,7 +475,7 @@ static void swap_cluster_free_table(struct swap_clust=
er_info *ci)
>         table =3D (void *)rcu_dereference_protected(ci->table, true);
>         rcu_assign_pointer(ci->table, NULL);
>
> -       kmem_cache_free(swap_table_cachep, table);
> +       swap_table_free(table);
>  }
>
>  /*
> @@ -467,8 +499,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
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
> @@ -483,7 +514,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>         if (!(si->flags & SWP_SOLIDSTATE))
>                 spin_unlock(&si->global_cluster_lock);
>         local_unlock(&percpu_swap_cluster.lock);
> -       table =3D kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_K=
ERNEL);
> +       table =3D swap_table_alloc(__GFP_HIGH | GFP_KERNEL);
>
>         local_lock(&percpu_swap_cluster.lock);
>         if (!(si->flags & SWP_SOLIDSTATE))
> @@ -520,7 +551,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
>
>  free_table:
>         if (table)
> -               kmem_cache_free(swap_table_cachep, table);
> +               swap_table_free(table);
>         return ci;
>  }
>
> @@ -738,7 +769,7 @@ static int inc_cluster_info_page(struct swap_info_str=
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
> @@ -4075,9 +4106,10 @@ static int __init swapfile_init(void)
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
>

