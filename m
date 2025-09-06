Return-Path: <linux-kernel+bounces-804348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530B6B472A6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC898585A32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B81E51F6;
	Sat,  6 Sep 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTXhY+Ja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C717BB21
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173572; cv=none; b=D9ZIAagYZyBP/pElRmi9kTHWrsOKWW4XWuxnRDor0UDcOQh8iGM+IDe9L0vlF1gsqG8Q4KsJXw4BLqTcebAtg1o5ziXRDe/xQ2C/Fulivly46+ouajZCA+NeHAYIHaQPOSyhKMHYKum6hjP8p+IkzcGnrkZpj9FdmWEVJK7FUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173572; c=relaxed/simple;
	bh=pSyIDU2hLY3qQptgMaAePd4jge78L56qK1Uy5LiYg2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbdluJo8RPcQBQ8rI2Ux0igH6Ppbf61u5gtbQBdYWkK/CHhAJRKyVU3iciWlxqy+rxI/9bRN+ccSuxoMDDEbfl3fn+9eGFCzBYh2RJmkii0SuhanJZrvr3DpI7k1dUNjX0iQ8/0W9EPeu0ZpzGjPh92qiB55HyK1lmKnG79s9f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTXhY+Ja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B19C4CEE7
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757173571;
	bh=pSyIDU2hLY3qQptgMaAePd4jge78L56qK1Uy5LiYg2c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aTXhY+JaOnd6pny4umxx1Vp4cyPwsDegs5T5m8iyNkr94TzfMSevU9G5Nxw1e1XWx
	 RHtUIAqDM5y257qlpUL8UCKxqGhGYl8z/bKvCa7QgpD5SeTbce2RxlKfvjwSeNluvi
	 pOcijq9Fo9LzBznlxJIbHd+lyzqnR7NBuhUYuPYBYC7oqeLvOtffoCGE4dR7r+LqLi
	 bX9+y9yNVgpaQsdpyKn/EX6Yecd8nMQjyKOKnQ55Qt56wlFM2OA/ttFV3QQUIzYPAl
	 q/Ce+vPdKZ89Iu16Lm2ArRBuR5yjVG3/x3ooeGK+5wlZWaKxzSAbFo41+zWWPQY7Uf
	 8lWWhxM92XNxQ==
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b886f92ccso58995e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:46:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCOLI+vCZvuithxEg2+GStbZtsjmM+XnnDGwcvKHfiT0CRuxC1uDT8lG8spb1HYruA3PtV15aU4hVyuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUQgfyhmUVCka+Z4GmJEtO9JfLBDge9LUksSTuApO+mg8Eziz
	zi5U9bt2vE6i+17Ru584DGilH2SFIoNc+AnEPr87I4MaXhlQPnM2XX8o5S+gVRnyWLVm29ALLoe
	F5CMxjr+VP4IRnz28dligpf2BBkj/NAkQoPUfPo1N
X-Google-Smtp-Source: AGHT+IGIIiVfqvRlAU81nYDAUqzZauORFqvQc6LSmK7H89Jxg6D/UxeUiXkoTM1y8xYjxRi0GTe5livqVZWKXmKVOl8=
X-Received: by 2002:a05:600c:a406:b0:45b:74f7:9d30 with SMTP id
 5b1f17b1804b1-45dde17196dmr826615e9.1.1757173569390; Sat, 06 Sep 2025
 08:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-15-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-15-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 08:45:58 -0700
X-Gmail-Original-Message-ID: <CAF8kJuO31q0nZmZwxeMZDq--wH=zeXwsZ8YK2M_7CyYmbsOouw@mail.gmail.com>
X-Gm-Features: AS18NWBcP6A5y1khhA7NyClG4UyDuZUKf2c98kWsPhAUNdB4LDDBZB9aX271Afc
Message-ID: <CAF8kJuO31q0nZmZwxeMZDq--wH=zeXwsZ8YK2M_7CyYmbsOouw@mail.gmail.com>
Subject: Re: [PATCH v2 14/15] mm, swap: implement dynamic allocation of swap table
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

Hi Kairui,

Acked-by: Chris Li <chrisl@kernel.org>

BTW, if you made some changes after my last ack, please drop my ack
tag on the new version or clarify ack was on the older version so I
know this version has new changes.

Chris

On Fri, Sep 5, 2025 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now swap table is cluster based, which means free clusters can free its
> table since no one should modify it.
>
> There could be speculative readers, like swap cache look up, protect
> them by making them RCU protected. All swap table should be filled with
> null entries before free, so such readers will either see a NULL pointer
> or a null filled table being lazy freed.
>
> On allocation, allocate the table when a cluster is used by any order.
>
> This way, we can reduce the memory usage of large swap device
> significantly.
>
> This idea to dynamically release unused swap cluster data was initially
> suggested by Chris Li while proposing the cluster swap allocator and
> it suits the swap table idea very well.
>
> Co-developed-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> ---
>  mm/swap.h       |   2 +-
>  mm/swap_state.c |   9 +--
>  mm/swap_table.h |  37 ++++++++-
>  mm/swapfile.c   | 202 ++++++++++++++++++++++++++++++++++++++----------
>  4 files changed, 199 insertions(+), 51 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index c4fb28845d77..caff4fe30fc5 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -36,7 +36,7 @@ struct swap_cluster_info {
>         u16 count;
>         u8 flags;
>         u8 order;
> -       atomic_long_t *table;   /* Swap table entries, see mm/swap_table.=
h */
> +       atomic_long_t __rcu *table;     /* Swap table entries, see mm/swa=
p_table.h */
>         struct list_head list;
>  };
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 209d5e9e8d90..dfe8f42fc309 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -92,8 +92,8 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
>         struct folio *folio;
>
>         for (;;) {
> -               swp_tb =3D __swap_table_get(__swap_entry_to_cluster(entry=
),
> -                                         swp_cluster_offset(entry));
> +               swp_tb =3D swap_table_get(__swap_entry_to_cluster(entry),
> +                                       swp_cluster_offset(entry));
>                 if (!swp_tb_is_folio(swp_tb))
>                         return NULL;
>                 folio =3D swp_tb_to_folio(swp_tb);
> @@ -116,11 +116,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
>  {
>         unsigned long swp_tb;
>
> -       swp_tb =3D __swap_table_get(__swap_entry_to_cluster(entry),
> -                                 swp_cluster_offset(entry));
> +       swp_tb =3D swap_table_get(__swap_entry_to_cluster(entry),
> +                               swp_cluster_offset(entry));
>         if (swp_tb_is_shadow(swp_tb))
>                 return swp_tb_to_shadow(swp_tb);
> -
>         return NULL;
>  }
>
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index e1f7cc009701..52254e455304 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -2,8 +2,15 @@
>  #ifndef _MM_SWAP_TABLE_H
>  #define _MM_SWAP_TABLE_H
>
> +#include <linux/rcupdate.h>
> +#include <linux/atomic.h>
>  #include "swap.h"
>
> +/* A typical flat array in each cluster as swap table */
> +struct swap_table {
> +       atomic_long_t entries[SWAPFILE_CLUSTER];
> +};
> +
>  /*
>   * A swap table entry represents the status of a swap slot on a swap
>   * (physical or virtual) device. The swap table in each cluster is a
> @@ -76,22 +83,46 @@ static inline void *swp_tb_to_shadow(unsigned long sw=
p_tb)
>  static inline void __swap_table_set(struct swap_cluster_info *ci,
>                                     unsigned int off, unsigned long swp_t=
b)
>  {
> +       atomic_long_t *table =3D rcu_dereference_protected(ci->table, tru=
e);
> +
> +       lockdep_assert_held(&ci->lock);
>         VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> -       atomic_long_set(&ci->table[off], swp_tb);
> +       atomic_long_set(&table[off], swp_tb);
>  }
>
>  static inline unsigned long __swap_table_xchg(struct swap_cluster_info *=
ci,
>                                               unsigned int off, unsigned =
long swp_tb)
>  {
> +       atomic_long_t *table =3D rcu_dereference_protected(ci->table, tru=
e);
> +
> +       lockdep_assert_held(&ci->lock);
>         VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
>         /* Ordering is guaranteed by cluster lock, relax */
> -       return atomic_long_xchg_relaxed(&ci->table[off], swp_tb);
> +       return atomic_long_xchg_relaxed(&table[off], swp_tb);
>  }
>
>  static inline unsigned long __swap_table_get(struct swap_cluster_info *c=
i,
>                                              unsigned int off)
>  {
> +       atomic_long_t *table;
> +
>         VM_WARN_ON_ONCE(off >=3D SWAPFILE_CLUSTER);
> -       return atomic_long_read(&ci->table[off]);
> +       table =3D rcu_dereference_check(ci->table, lockdep_is_held(&ci->l=
ock));
> +
> +       return atomic_long_read(&table[off]);
> +}
> +
> +static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
> +                                       unsigned int off)
> +{
> +       atomic_long_t *table;
> +       unsigned long swp_tb;
> +
> +       rcu_read_lock();
> +       table =3D rcu_dereference(ci->table);
> +       swp_tb =3D table ? atomic_long_read(&table[off]) : null_to_swp_tb=
();
> +       rcu_read_unlock();
> +
> +       return swp_tb;
>  }
>  #endif
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6b3b35a7ddd9..49f93069faef 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -105,6 +105,8 @@ static DEFINE_SPINLOCK(swap_avail_lock);
>
>  struct swap_info_struct *swap_info[MAX_SWAPFILES];
>
> +static struct kmem_cache *swap_table_cachep;
> +
>  static DEFINE_MUTEX(swapon_mutex);
>
>  static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
> @@ -400,10 +402,17 @@ static inline bool cluster_is_discard(struct swap_c=
luster_info *info)
>         return info->flags =3D=3D CLUSTER_FLAG_DISCARD;
>  }
>
> +static inline bool cluster_table_is_alloced(struct swap_cluster_info *ci=
)
> +{
> +       return rcu_dereference_protected(ci->table, lockdep_is_held(&ci->=
lock));
> +}
> +
>  static inline bool cluster_is_usable(struct swap_cluster_info *ci, int o=
rder)
>  {
>         if (unlikely(ci->flags > CLUSTER_FLAG_USABLE))
>                 return false;
> +       if (!cluster_table_is_alloced(ci))
> +               return false;
>         if (!order)
>                 return true;
>         return cluster_is_empty(ci) || order =3D=3D ci->order;
> @@ -421,32 +430,98 @@ static inline unsigned int cluster_offset(struct sw=
ap_info_struct *si,
>         return cluster_index(si, ci) * SWAPFILE_CLUSTER;
>  }
>
> -static int swap_table_alloc_table(struct swap_cluster_info *ci)
> +static void swap_cluster_free_table(struct swap_cluster_info *ci)
>  {
> -       WARN_ON(ci->table);
> -       ci->table =3D kzalloc(sizeof(unsigned long) * SWAPFILE_CLUSTER, G=
FP_KERNEL);
> -       if (!ci->table)
> -               return -ENOMEM;
> -       return 0;
> +       unsigned int ci_off;
> +       struct swap_table *table;
> +
> +       /* Only empty cluster's table is allow to be freed  */
> +       lockdep_assert_held(&ci->lock);
> +       VM_WARN_ON_ONCE(!cluster_is_empty(ci));
> +       for (ci_off =3D 0; ci_off < SWAPFILE_CLUSTER; ci_off++)
> +               VM_WARN_ON_ONCE(!swp_tb_is_null(__swap_table_get(ci, ci_o=
ff)));
> +       table =3D (void *)rcu_dereference_protected(ci->table, true);
> +       rcu_assign_pointer(ci->table, NULL);
> +
> +       kmem_cache_free(swap_table_cachep, table);
>  }
>
> -static void swap_cluster_free_table(struct swap_cluster_info *ci)
> +/*
> + * Allocate a swap table may need to sleep, which leads to migration,
> + * so attempt an atomic allocation first then fallback and handle
> + * potential race.
> + */
> +static struct swap_cluster_info *
> +swap_cluster_alloc_table(struct swap_info_struct *si,
> +                        struct swap_cluster_info *ci,
> +                        int order)
>  {
> -       unsigned int ci_off;
> -       unsigned long swp_tb;
> +       struct swap_cluster_info *pcp_ci;
> +       struct swap_table *table;
> +       unsigned long offset;
>
> -       if (!ci->table)
> -               return;
> +       /*
> +        * Only cluster isolation from the allocator does table allocatio=
n.
> +        * Swap allocator uses a percpu cluster and holds the local lock.
> +        */
> +       lockdep_assert_held(&ci->lock);
> +       lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
> +
> +       table =3D kmem_cache_zalloc(swap_table_cachep,
> +                                 __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_N=
OWARN);
> +       if (table) {
> +               rcu_assign_pointer(ci->table, table);
> +               return ci;
> +       }
> +
> +       /*
> +        * Try a sleep allocation. Each isolated free cluster may cause
> +        * a sleep allocation, but there is a limited number of them, so
> +        * the potential recursive allocation should be limited.
> +        */
> +       spin_unlock(&ci->lock);
> +       if (!(si->flags & SWP_SOLIDSTATE))
> +               spin_unlock(&si->global_cluster_lock);
> +       local_unlock(&percpu_swap_cluster.lock);
> +       table =3D kmem_cache_zalloc(swap_table_cachep, __GFP_HIGH | GFP_K=
ERNEL);
>
> -       for (ci_off =3D 0; ci_off < SWAPFILE_CLUSTER; ci_off++) {
> -               swp_tb =3D __swap_table_get(ci, ci_off);
> -               if (!swp_tb_is_null(swp_tb))
> -                       pr_err_once("swap: unclean swap space on swapoff:=
 0x%lx",
> -                                   swp_tb);
> +       local_lock(&percpu_swap_cluster.lock);
> +       if (!(si->flags & SWP_SOLIDSTATE))
> +               spin_lock(&si->global_cluster_lock);
> +       /*
> +        * Back to atomic context. First, check if we migrated to a new
> +        * CPU with a usable percpu cluster. If so, try using that instea=
d.
> +        * No need to check it for the spinning device, as swap is
> +        * serialized by the global lock on them.
> +        *
> +        * The is_usable check is a bit rough, but ensures order 0 succes=
s.
> +        */
> +       offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> +       if ((si->flags & SWP_SOLIDSTATE) && offset) {
> +               pcp_ci =3D swap_cluster_lock(si, offset);
> +               if (cluster_is_usable(pcp_ci, order) &&
> +                   pcp_ci->count < SWAPFILE_CLUSTER) {
> +                       ci =3D pcp_ci;
> +                       goto free_table;
> +               }
> +               swap_cluster_unlock(pcp_ci);
>         }
>
> -       kfree(ci->table);
> -       ci->table =3D NULL;
> +       if (!table)
> +               return NULL;
> +
> +       spin_lock(&ci->lock);
> +       /* Nothing should have touched the dangling empty cluster. */
> +       if (WARN_ON_ONCE(cluster_table_is_alloced(ci)))
> +               goto free_table;
> +
> +       rcu_assign_pointer(ci->table, table);
> +       return ci;
> +
> +free_table:
> +       if (table)
> +               kmem_cache_free(swap_table_cachep, table);
> +       return ci;
>  }
>
>  static void move_cluster(struct swap_info_struct *si,
> @@ -478,7 +553,7 @@ static void swap_cluster_schedule_discard(struct swap=
_info_struct *si,
>
>  static void __free_cluster(struct swap_info_struct *si, struct swap_clus=
ter_info *ci)
>  {
> -       lockdep_assert_held(&ci->lock);
> +       swap_cluster_free_table(ci);
>         move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
>         ci->order =3D 0;
>  }
> @@ -493,15 +568,11 @@ static void __free_cluster(struct swap_info_struct =
*si, struct swap_cluster_info
>   * this returns NULL for an non-empty list.
>   */
>  static struct swap_cluster_info *isolate_lock_cluster(
> -               struct swap_info_struct *si, struct list_head *list)
> +               struct swap_info_struct *si, struct list_head *list, int =
order)
>  {
> -       struct swap_cluster_info *ci, *ret =3D NULL;
> +       struct swap_cluster_info *ci, *found =3D NULL;
>
>         spin_lock(&si->lock);
> -
> -       if (unlikely(!(si->flags & SWP_WRITEOK)))
> -               goto out;
> -
>         list_for_each_entry(ci, list, list) {
>                 if (!spin_trylock(&ci->lock))
>                         continue;
> @@ -513,13 +584,19 @@ static struct swap_cluster_info *isolate_lock_clust=
er(
>
>                 list_del(&ci->list);
>                 ci->flags =3D CLUSTER_FLAG_NONE;
> -               ret =3D ci;
> +               found =3D ci;
>                 break;
>         }
> -out:
>         spin_unlock(&si->lock);
>
> -       return ret;
> +       if (found && !cluster_table_is_alloced(found)) {
> +               /* Only an empty free cluster's swap table can be freed. =
*/
> +               VM_WARN_ON_ONCE(list !=3D &si->free_clusters);
> +               VM_WARN_ON_ONCE(!cluster_is_empty(found));
> +               return swap_cluster_alloc_table(si, found, order);
> +       }
> +
> +       return found;
>  }
>
>  /*
> @@ -652,17 +729,27 @@ static void relocate_cluster(struct swap_info_struc=
t *si,
>   * added to free cluster list and its usage counter will be increased by=
 1.
>   * Only used for initialization.
>   */
> -static void inc_cluster_info_page(struct swap_info_struct *si,
> +static int inc_cluster_info_page(struct swap_info_struct *si,
>         struct swap_cluster_info *cluster_info, unsigned long page_nr)
>  {
>         unsigned long idx =3D page_nr / SWAPFILE_CLUSTER;
> +       struct swap_table *table;
>         struct swap_cluster_info *ci;
>
>         ci =3D cluster_info + idx;
> +       if (!ci->table) {
> +               table =3D kmem_cache_zalloc(swap_table_cachep, GFP_KERNEL=
);
> +               if (!table)
> +                       return -ENOMEM;
> +               rcu_assign_pointer(ci->table, table);
> +       }
> +
>         ci->count++;
>
>         VM_BUG_ON(ci->count > SWAPFILE_CLUSTER);
>         VM_BUG_ON(ci->flags);
> +
> +       return 0;
>  }
>
>  static bool cluster_reclaim_range(struct swap_info_struct *si,
> @@ -844,7 +931,7 @@ static unsigned int alloc_swap_scan_list(struct swap_=
info_struct *si,
>         unsigned int found =3D SWAP_ENTRY_INVALID;
>
>         do {
> -               struct swap_cluster_info *ci =3D isolate_lock_cluster(si,=
 list);
> +               struct swap_cluster_info *ci =3D isolate_lock_cluster(si,=
 list, order);
>                 unsigned long offset;
>
>                 if (!ci)
> @@ -869,7 +956,7 @@ static void swap_reclaim_full_clusters(struct swap_in=
fo_struct *si, bool force)
>         if (force)
>                 to_scan =3D swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
>
> -       while ((ci =3D isolate_lock_cluster(si, &si->full_clusters))) {
> +       while ((ci =3D isolate_lock_cluster(si, &si->full_clusters, 0))) =
{
>                 offset =3D cluster_offset(si, ci);
>                 end =3D min(si->max, offset + SWAPFILE_CLUSTER);
>                 to_scan--;
> @@ -1017,6 +1104,7 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>  done:
>         if (!(si->flags & SWP_SOLIDSTATE))
>                 spin_unlock(&si->global_cluster_lock);
> +
>         return found;
>  }
>
> @@ -1884,7 +1972,13 @@ swp_entry_t get_swap_page_of_type(int type)
>         /* This is called for allocating swap entry, not cache */
>         if (get_swap_device_info(si)) {
>                 if (si->flags & SWP_WRITEOK) {
> +                       /*
> +                        * Grab the local lock to be complaint
> +                        * with swap table allocation.
> +                        */
> +                       local_lock(&percpu_swap_cluster.lock);
>                         offset =3D cluster_alloc_swap_entry(si, 0, 1);
> +                       local_unlock(&percpu_swap_cluster.lock);
>                         if (offset) {
>                                 entry =3D swp_entry(si->type, offset);
>                                 atomic_long_dec(&nr_swap_pages);
> @@ -2677,12 +2771,21 @@ static void wait_for_allocation(struct swap_info_=
struct *si)
>  static void free_cluster_info(struct swap_cluster_info *cluster_info,
>                               unsigned long maxpages)
>  {
> +       struct swap_cluster_info *ci;
>         int i, nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
>
>         if (!cluster_info)
>                 return;
> -       for (i =3D 0; i < nr_clusters; i++)
> -               swap_cluster_free_table(&cluster_info[i]);
> +       for (i =3D 0; i < nr_clusters; i++) {
> +               ci =3D cluster_info + i;
> +               /* Cluster with bad marks count will have a remaining tab=
le */
> +               spin_lock(&ci->lock);
> +               if (rcu_dereference_protected(ci->table, true)) {
> +                       ci->count =3D 0;
> +                       swap_cluster_free_table(ci);
> +               }
> +               spin_unlock(&ci->lock);
> +       }
>         kvfree(cluster_info);
>  }
>
> @@ -2718,6 +2821,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         struct address_space *mapping;
>         struct inode *inode;
>         struct filename *pathname;
> +       unsigned int maxpages;
>         int err, found =3D 0;
>
>         if (!capable(CAP_SYS_ADMIN))
> @@ -2824,8 +2928,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         p->swap_map =3D NULL;
>         zeromap =3D p->zeromap;
>         p->zeromap =3D NULL;
> +       maxpages =3D p->max;
>         cluster_info =3D p->cluster_info;
> -       free_cluster_info(cluster_info, p->max);
>         p->max =3D 0;
>         p->cluster_info =3D NULL;
>         spin_unlock(&p->lock);
> @@ -2837,6 +2941,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         p->global_cluster =3D NULL;
>         vfree(swap_map);
>         kvfree(zeromap);
> +       free_cluster_info(cluster_info, maxpages);
>         /* Destroy swap account information */
>         swap_cgroup_swapoff(p->type);
>
> @@ -3215,11 +3320,8 @@ static struct swap_cluster_info *setup_clusters(st=
ruct swap_info_struct *si,
>         if (!cluster_info)
>                 goto err;
>
> -       for (i =3D 0; i < nr_clusters; i++) {
> +       for (i =3D 0; i < nr_clusters; i++)
>                 spin_lock_init(&cluster_info[i].lock);
> -               if (swap_table_alloc_table(&cluster_info[i]))
> -                       goto err_free;
> -       }
>
>         if (!(si->flags & SWP_SOLIDSTATE)) {
>                 si->global_cluster =3D kmalloc(sizeof(*si->global_cluster=
),
> @@ -3238,16 +3340,23 @@ static struct swap_cluster_info *setup_clusters(s=
truct swap_info_struct *si,
>          * See setup_swap_map(): header page, bad pages,
>          * and the EOF part of the last cluster.
>          */
> -       inc_cluster_info_page(si, cluster_info, 0);
> +       err =3D inc_cluster_info_page(si, cluster_info, 0);
> +       if (err)
> +               goto err;
>         for (i =3D 0; i < swap_header->info.nr_badpages; i++) {
>                 unsigned int page_nr =3D swap_header->info.badpages[i];
>
>                 if (page_nr >=3D maxpages)
>                         continue;
> -               inc_cluster_info_page(si, cluster_info, page_nr);
> +               err =3D inc_cluster_info_page(si, cluster_info, page_nr);
> +               if (err)
> +                       goto err;
> +       }
> +       for (i =3D maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i+=
+) {
> +               err =3D inc_cluster_info_page(si, cluster_info, i);
> +               if (err)
> +                       goto err;
>         }
> -       for (i =3D maxpages; i < round_up(maxpages, SWAPFILE_CLUSTER); i+=
+)
> -               inc_cluster_info_page(si, cluster_info, i);
>
>         INIT_LIST_HEAD(&si->free_clusters);
>         INIT_LIST_HEAD(&si->full_clusters);
> @@ -3961,6 +4070,15 @@ static int __init swapfile_init(void)
>
>         swapfile_maximum_size =3D arch_max_swapfile_size();
>
> +       /*
> +        * Once a cluster is freed, it's swap table content is read
> +        * only, and all swap cache readers (swap_cache_*) verifies
> +        * the content before use. So it's safe to use RCU slab here.
> +        */
> +       swap_table_cachep =3D kmem_cache_create("swap_table",
> +                           sizeof(struct swap_table),
> +                           0, SLAB_PANIC | SLAB_TYPESAFE_BY_RCU, NULL);
> +
>  #ifdef CONFIG_MIGRATION
>         if (swapfile_maximum_size >=3D (1UL << SWP_MIG_TOTAL_BITS))
>                 swap_migration_ad_supported =3D true;
> --
> 2.51.0
>
>

