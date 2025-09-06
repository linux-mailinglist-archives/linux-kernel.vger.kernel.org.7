Return-Path: <linux-kernel+bounces-803987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D8B46850
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 04:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71B15C0A6F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 02:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8B1F8EFF;
	Sat,  6 Sep 2025 02:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvStcudk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12031F4C92
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757124871; cv=none; b=Rb/qkacZQc8Xd0pmuUFRZuLSMdP+LadfHcfsWAsAy/Nn4Q5MIi6j5AoDzxZjU201kCCndVi8ghgmQ9cnHO1liYO6bwczcCPzT8+CYScSU11czVFIxNaBscNo3TFgMpOfyq7PFwEk8A+Aa1CQm+Iug3lRTGaVjM30U/x4VDal+Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757124871; c=relaxed/simple;
	bh=g3DlQn4KklhNo1wDVC9prsucRrVcq1JkQunm7KfqZy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUV7tlweLSZB0rJygR7qiB1RPD2T91X8Lg3buaILfvaDYDaK/HGelg9yvL7aLRLzz5d3EjMm09doZLKWPmEJnwHVPbgZCNEnPWvxP6PZsoidBKmbV/s8/k7nmAsSLlXgqPP/RzLafysKTnyu7jMQAz+ifCn+7PTMLjn568EE7DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvStcudk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F3C4CEF9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 02:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757124871;
	bh=g3DlQn4KklhNo1wDVC9prsucRrVcq1JkQunm7KfqZy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OvStcudkWkCIw7WLotScd4gyyfOMc+UExFpzSL6/Gdn52LswO0P+9WNchdowzaSt6
	 I7+QRRlhr1wNAzLu1mRO/1tCGRKj6nqS3tZsN0ZfRt44AiUAPyhM8wL0p9piO74JzL
	 +AxrRIRc3E4MMbw+F3nkHmWzVPRBCchKzqQdlHJntTwTslvRKSOaXqLMFqRvuDvcOg
	 03m21t+2FVOEWIQotGeUklrPFKLDm7QO8wSkC2/ooLBT3HHSx9moU/1rzSKLaHxjS6
	 RqdtZybULbGsvESHIbStEfo3OOROM0KMjZRwKpXPuyBfqOerv8KuZxoimOZYlPSIiB
	 p9GZlMPzA874g==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so33385e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 19:14:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwmhzFYSFdx/pTPdhcHXQMq6pNjibahlv9BpIQcQd52Mz6sZ6U1u1plXpfGvvsUGW84USOqfhrXiHYeJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXGaRs4NEPwspnq5r3SrIKhVnOhHILQ9ktUh1Iqser5QiC8iN
	pAng20Zyv0CbhuhdDi59qHn7/Sc3lIt4lViX3e5MoVWPN+Ws+KO+uSvQ8SatDQrRRnWnhvBDf6p
	ARldQvOIn6QutG/HPtwAtDKDXToKAJXgZnZ4qwrmb
X-Google-Smtp-Source: AGHT+IFqp8G3aCcPMUMN2b0PpCHnjwMvBKuu6o00kPN8nc0HwmPdM8mfKCIk6If8kQfqG4MuieSp/W2cZvum3TzoZxs=
X-Received: by 2002:a05:600c:4f50:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45dddad796amr664975e9.6.1757124870236; Fri, 05 Sep 2025
 19:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-8-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-8-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 5 Sep 2025 19:14:19 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMKRbxd=4vNaCwOmKWRQtBRsGczzeoFa6tAj0HL1To0sg@mail.gmail.com>
X-Gm-Features: Ac12FXzn0RX1gdFQALqCYuScgI2lXY1l58-FKpY_B4t9r6rpfwJpWxeLh4avL2U
Message-ID: <CAF8kJuMKRbxd=4vNaCwOmKWRQtBRsGczzeoFa6tAj0HL1To0sg@mail.gmail.com>
Subject: Re: [PATCH v2 07/15] mm, swap: tidy up swap device and cluster info helpers
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

On Fri, Sep 5, 2025 at 12:14=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> swp_swap_info is the most commonly used helper for retrieving swap info.
> It has an internal check that may lead to a NULL return value, but
> almost none of its caller checks the return value, making the internal
> check pointless. In fact, most of these callers already ensured the
> entry is valid and never expect a NULL value.
>
> Tidy this up and shorten the name. If the caller can make sure the
> swap entry/type is valid and the device is pinned, use the new introduced
> __swap_entry_to_info/__swap_type_to_info instead. They have more debug
> sanity checks and lower overhead as they are inlined.
>
> Callers that may expect a NULL value should use
> swap_entry_to_info/swap_type_to_info instead.
>
> No feature change. The rearranged codes should have had no effect, or
> they should have been hitting NULL de-ref bugs already. Only some new
> sanity checks are added so potential issues may show up in debug build.
>
> The new helpers will be frequently used with swap table later when workin=
g
> with swap cache folios. A locked swap cache folio ensures the entries are
> valid and stable so these helpers are very helpful.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  include/linux/swap.h |  6 ------
>  mm/page_io.c         | 12 ++++++------
>  mm/swap.h            | 38 +++++++++++++++++++++++++++++++++-----
>  mm/swap_state.c      |  4 ++--
>  mm/swapfile.c        | 37 +++++++++++++++++++------------------
>  5 files changed, 60 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 7e1fe4ff3d30..6db105383782 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -479,7 +479,6 @@ extern sector_t swapdev_block(int, pgoff_t);
>  extern int __swap_count(swp_entry_t entry);
>  extern bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t =
entry);
>  extern int swp_swapcount(swp_entry_t entry);
> -struct swap_info_struct *swp_swap_info(swp_entry_t entry);
>  struct backing_dev_info;
>  extern int init_swap_address_space(unsigned int type, unsigned long nr_p=
ages);
>  extern void exit_swap_address_space(unsigned int type);
> @@ -492,11 +491,6 @@ static inline void put_swap_device(struct swap_info_=
struct *si)
>  }
>
>  #else /* CONFIG_SWAP */
> -static inline struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> -{
> -       return NULL;
> -}
> -
>  static inline struct swap_info_struct *get_swap_device(swp_entry_t entry=
)
>  {
>         return NULL;
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a2056a5ecb13..3c342db77ce3 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -204,7 +204,7 @@ static bool is_folio_zero_filled(struct folio *folio)
>  static void swap_zeromap_folio_set(struct folio *folio)
>  {
>         struct obj_cgroup *objcg =3D get_obj_cgroup_from_folio(folio);
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         int nr_pages =3D folio_nr_pages(folio);
>         swp_entry_t entry;
>         unsigned int i;
> @@ -223,7 +223,7 @@ static void swap_zeromap_folio_set(struct folio *foli=
o)
>
>  static void swap_zeromap_folio_clear(struct folio *folio)
>  {
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         swp_entry_t entry;
>         unsigned int i;
>
> @@ -374,7 +374,7 @@ static void sio_write_complete(struct kiocb *iocb, lo=
ng ret)
>  static void swap_writepage_fs(struct folio *folio, struct swap_iocb **sw=
ap_plug)
>  {
>         struct swap_iocb *sio =3D swap_plug ? *swap_plug : NULL;
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         struct file *swap_file =3D sis->swap_file;
>         loff_t pos =3D swap_dev_pos(folio->swap);
>
> @@ -446,7 +446,7 @@ static void swap_writepage_bdev_async(struct folio *f=
olio,
>
>  void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
>  {
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>
>         VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
>         /*
> @@ -537,7 +537,7 @@ static bool swap_read_folio_zeromap(struct folio *fol=
io)
>
>  static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **p=
lug)
>  {
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         struct swap_iocb *sio =3D NULL;
>         loff_t pos =3D swap_dev_pos(folio->swap);
>
> @@ -608,7 +608,7 @@ static void swap_read_folio_bdev_async(struct folio *=
folio,
>
>  void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
>  {
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         bool synchronous =3D sis->flags & SWP_SYNCHRONOUS_IO;
>         bool workingset =3D folio_test_workingset(folio);
>         unsigned long pflags;
> diff --git a/mm/swap.h b/mm/swap.h
> index 39b27337bc0a..a65e72edb087 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -15,6 +15,8 @@ extern int page_cluster;
>  #define swap_entry_order(order)        0
>  #endif
>
> +extern struct swap_info_struct *swap_info[];
> +
>  /*
>   * We use this to track usage of a cluster. A cluster is a block of swap=
 disk
>   * space with SWAPFILE_CLUSTER pages long and naturally aligns in disk. =
All
> @@ -53,9 +55,29 @@ enum swap_cluster_flags {
>  #include <linux/swapops.h> /* for swp_offset */
>  #include <linux/blk_types.h> /* for bio_end_io_t */
>
> -static inline struct swap_cluster_info *swp_offset_cluster(
> +/*
> + * Callers of all helpers below must ensure the entry, type, or offset i=
s
> + * valid, and protect the swap device with reference count or locks.
> + */
> +static inline struct swap_info_struct *__swap_type_to_info(int type)
> +{
> +       struct swap_info_struct *si;
> +
> +       si =3D READ_ONCE(swap_info[type]); /* rcu_dereference() */
> +       VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
> +       return si;
> +}
> +
> +static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t =
entry)
> +{
> +       return __swap_type_to_info(swp_type(entry));
> +}
> +
> +static inline struct swap_cluster_info *__swap_offset_to_cluster(
>                 struct swap_info_struct *si, pgoff_t offset)
>  {
> +       VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
> +       VM_WARN_ON_ONCE(offset >=3D si->max);
>         return &si->cluster_info[offset / SWAPFILE_CLUSTER];
>  }
>
> @@ -70,8 +92,9 @@ static inline struct swap_cluster_info *swp_offset_clus=
ter(
>  static inline struct swap_cluster_info *swap_cluster_lock(
>                 struct swap_info_struct *si, unsigned long offset)
>  {
> -       struct swap_cluster_info *ci =3D swp_offset_cluster(si, offset);
> +       struct swap_cluster_info *ci =3D __swap_offset_to_cluster(si, off=
set);
>
> +       VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
>         spin_lock(&ci->lock);
>         return ci;
>  }
> @@ -167,7 +190,7 @@ void swap_update_readahead(struct folio *folio, struc=
t vm_area_struct *vma,
>
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> -       return swp_swap_info(folio->swap)->flags;
> +       return __swap_entry_to_info(folio->swap)->flags;
>  }
>
>  /*
> @@ -178,7 +201,7 @@ static inline unsigned int folio_swap_flags(struct fo=
lio *folio)
>  static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
>                 bool *is_zeromap)
>  {
> -       struct swap_info_struct *sis =3D swp_swap_info(entry);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(entry);
>         unsigned long start =3D swp_offset(entry);
>         unsigned long end =3D start + max_nr;
>         bool first_bit;
> @@ -197,7 +220,7 @@ static inline int swap_zeromap_batch(swp_entry_t entr=
y, int max_nr,
>
>  static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
>  {
> -       struct swap_info_struct *si =3D swp_swap_info(entry);
> +       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         pgoff_t offset =3D swp_offset(entry);
>         int i;
>
> @@ -216,6 +239,11 @@ static inline int non_swapcache_batch(swp_entry_t en=
try, int max_nr)
>
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
> +static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t =
entry)
> +{
> +       return NULL;
> +}
> +
>  static inline void swap_read_folio(struct folio *folio, struct swap_iocb=
 **plug)
>  {
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 9225d6b695ad..0ad4f3b41f1b 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -336,7 +336,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>                 struct mempolicy *mpol, pgoff_t ilx, bool *new_page_alloc=
ated,
>                 bool skip_if_exists)
>  {
> -       struct swap_info_struct *si =3D swp_swap_info(entry);
> +       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         struct folio *folio;
>         struct folio *new_folio =3D NULL;
>         struct folio *result =3D NULL;
> @@ -560,7 +560,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entr=
y, gfp_t gfp_mask,
>         unsigned long offset =3D entry_offset;
>         unsigned long start_offset, end_offset;
>         unsigned long mask;
> -       struct swap_info_struct *si =3D swp_swap_info(entry);
> +       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         struct blk_plug plug;
>         struct swap_iocb *splug =3D NULL;
>         bool page_allocated;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 547ad4bfe1d8..367481d319cd 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -102,7 +102,7 @@ static PLIST_HEAD(swap_active_head);
>  static struct plist_head *swap_avail_heads;
>  static DEFINE_SPINLOCK(swap_avail_lock);
>
> -static struct swap_info_struct *swap_info[MAX_SWAPFILES];
> +struct swap_info_struct *swap_info[MAX_SWAPFILES];
>
>  static DEFINE_MUTEX(swapon_mutex);
>
> @@ -124,14 +124,20 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, p=
ercpu_swap_cluster) =3D {
>         .lock =3D INIT_LOCAL_LOCK(),
>  };
>
> -static struct swap_info_struct *swap_type_to_swap_info(int type)
> +/* May return NULL on invalid type, caller must check for NULL return */
> +static struct swap_info_struct *swap_type_to_info(int type)
>  {
>         if (type >=3D MAX_SWAPFILES)
>                 return NULL;
> -
>         return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>
> +/* May return NULL on invalid entry, caller must check for NULL return *=
/
> +static struct swap_info_struct *swap_entry_to_info(swp_entry_t entry)
> +{
> +       return swap_type_to_info(swp_type(entry));
> +}
> +
>  static inline unsigned char swap_count(unsigned char ent)
>  {
>         return ent & ~SWAP_HAS_CACHE;   /* may include COUNT_CONTINUED fl=
ag */
> @@ -341,7 +347,7 @@ offset_to_swap_extent(struct swap_info_struct *sis, u=
nsigned long offset)
>
>  sector_t swap_folio_sector(struct folio *folio)
>  {
> -       struct swap_info_struct *sis =3D swp_swap_info(folio->swap);
> +       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         struct swap_extent *se;
>         sector_t sector;
>         pgoff_t offset;
> @@ -1299,7 +1305,7 @@ static struct swap_info_struct *_swap_info_get(swp_=
entry_t entry)
>
>         if (!entry.val)
>                 goto out;
> -       si =3D swp_swap_info(entry);
> +       si =3D swap_entry_to_info(entry);
>         if (!si)
>                 goto bad_nofile;
>         if (data_race(!(si->flags & SWP_USED)))
> @@ -1414,7 +1420,7 @@ struct swap_info_struct *get_swap_device(swp_entry_=
t entry)
>
>         if (!entry.val)
>                 goto out;
> -       si =3D swp_swap_info(entry);
> +       si =3D swap_entry_to_info(entry);
>         if (!si)
>                 goto bad_nofile;
>         if (!get_swap_device_info(si))
> @@ -1537,7 +1543,7 @@ static void swap_entries_free(struct swap_info_stru=
ct *si,
>         unsigned char *map_end =3D map + nr_pages;
>
>         /* It should never free entries across different clusters */
> -       VM_BUG_ON(ci !=3D swp_offset_cluster(si, offset + nr_pages - 1));
> +       VM_BUG_ON(ci !=3D __swap_offset_to_cluster(si, offset + nr_pages =
- 1));
>         VM_BUG_ON(cluster_is_empty(ci));
>         VM_BUG_ON(ci->count < nr_pages);
>
> @@ -1595,7 +1601,7 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
>
>  int __swap_count(swp_entry_t entry)
>  {
> -       struct swap_info_struct *si =3D swp_swap_info(entry);
> +       struct swap_info_struct *si =3D __swap_entry_to_info(entry);
>         pgoff_t offset =3D swp_offset(entry);
>
>         return swap_count(si->swap_map[offset]);
> @@ -1826,7 +1832,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int =
nr)
>
>  swp_entry_t get_swap_page_of_type(int type)
>  {
> -       struct swap_info_struct *si =3D swap_type_to_swap_info(type);
> +       struct swap_info_struct *si =3D swap_type_to_info(type);
>         unsigned long offset;
>         swp_entry_t entry =3D {0};
>
> @@ -1907,7 +1913,7 @@ int find_first_swap(dev_t *device)
>   */
>  sector_t swapdev_block(int type, pgoff_t offset)
>  {
> -       struct swap_info_struct *si =3D swap_type_to_swap_info(type);
> +       struct swap_info_struct *si =3D swap_type_to_info(type);
>         struct swap_extent *se;
>
>         if (!si || !(si->flags & SWP_WRITEOK))
> @@ -2835,7 +2841,7 @@ static void *swap_start(struct seq_file *swap, loff=
_t *pos)
>         if (!l)
>                 return SEQ_START_TOKEN;
>
> -       for (type =3D 0; (si =3D swap_type_to_swap_info(type)); type++) {
> +       for (type =3D 0; (si =3D swap_type_to_info(type)); type++) {
>                 if (!(si->flags & SWP_USED) || !si->swap_map)
>                         continue;
>                 if (!--l)
> @@ -2856,7 +2862,7 @@ static void *swap_next(struct seq_file *swap, void =
*v, loff_t *pos)
>                 type =3D si->type + 1;
>
>         ++(*pos);
> -       for (; (si =3D swap_type_to_swap_info(type)); type++) {
> +       for (; (si =3D swap_type_to_info(type)); type++) {
>                 if (!(si->flags & SWP_USED) || !si->swap_map)
>                         continue;
>                 return si;
> @@ -3529,7 +3535,7 @@ static int __swap_duplicate(swp_entry_t entry, unsi=
gned char usage, int nr)
>         unsigned char has_cache;
>         int err, i;
>
> -       si =3D swp_swap_info(entry);
> +       si =3D swap_entry_to_info(entry);
>         if (WARN_ON_ONCE(!si)) {
>                 pr_err("%s%08lx\n", Bad_file, entry.val);
>                 return -EINVAL;
> @@ -3644,11 +3650,6 @@ void swapcache_clear(struct swap_info_struct *si, =
swp_entry_t entry, int nr)
>         swap_entries_put_cache(si, entry, nr);
>  }
>
> -struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> -{
> -       return swap_type_to_swap_info(swp_type(entry));
> -}
> -
>  /*
>   * add_swap_count_continuation - called when a swap count is duplicated
>   * beyond SWAP_MAP_MAX, it allocates a new page and links that to the en=
try's
> --
> 2.51.0
>
>

