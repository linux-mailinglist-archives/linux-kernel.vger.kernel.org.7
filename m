Return-Path: <linux-kernel+bounces-804323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B30BB4720E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CFF17AB566
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB1B20459A;
	Sat,  6 Sep 2025 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAq8jPbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960021D63DF
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172644; cv=none; b=HcKSKIbN327mqJzt5rQfih6JtRln3b3RniDB2fq/VeMAXECOFvU7+S/ClZfpmJZHzCRvTv2+XUtk33O1dCLnzhLmUQzv2SguKzInTKaKieLlu9D5HTjZhujb7iSnNVTeFufk0ck3vNw/ybr7a60T4oGMJVd0zRbzvId/k0kFr8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172644; c=relaxed/simple;
	bh=g1c7pmqYGdbllg7o35qAzoZrQoIU1NY0r9sjW7XaxNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fJ/tnTixLnQgTQ8w6RDvv+ckW3722HcMZzZNfJC/5zd0yYfQ7iuFy7xoTBHhcWDBcKN7RfvXAF5NQsRg82YZ4u0p/xN/m834QQY6WG6B1XMuAciYkfuMJa6g768Uod1jxmRYKym7OOpBFz7IIOu9JOmW/eUtwRcOC4DcyQTYZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAq8jPbx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43774C4AF0B
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757172644;
	bh=g1c7pmqYGdbllg7o35qAzoZrQoIU1NY0r9sjW7XaxNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mAq8jPbx0pyIJ1TWk1Cd20AkLdNlCtjwiFTA5S2eMQyBbwu2jHNhaXNcJrshfDj3I
	 L8rvZXxxzDYRYnaohxHUofmfTzX4xw5lW32DVcvRHaKz1qGXXfnVbJGlq45PEDNxgL
	 0UPT8CZsdoALZkgikerybaMZw71NvdTLADVAybFiYVyWGX10WYA+Yw6rn0l+WpQa/+
	 lWzmga2JVwUdyrQ8mHqT4bm6a5bNPIXFrSWQYsyKbU+MsIQfQJnY/hlTwCmHwOk0sO
	 2sKJYF8w+xVrX+OBBRHuEdxlALIE/iO+WUIa07feRo9s2sRjM59rF2otDjutmCjqqG
	 PHz3Ge6yZdpww==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45dd9d72f61so51755e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 08:30:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvk3BHeji6cGXTwD+Hjbc59j7TtLS/eCuW3brO1zOveHD0BhMfczkoGmglzbmsEA4u82wLFx5Ch0G1vr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcYzKFtm6iCMDl011Od6jxreFsyf/rI7Rcbat9gzK7fsRilt1
	MTo0qEZOcUiGdo6xMbCLBOjOHM6XUHNh8s+axzCDaKAMLS0z4gmJwuTvwWIh3IgL/X8+hTV1EmA
	0DyGwkVC5qmA98a76L4+bHfXXDtxcO9OzBf3J7aSb
X-Google-Smtp-Source: AGHT+IGcTDtOO7jVD2IShUgX/B8MUkNbthw2EEGd3v4tMOQuVs9TJUfUxLMoFi6zxaQjXsNqv9SNvBEP+lQ2OzrZUjU=
X-Received: by 2002:a05:600c:3ba6:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45dde171a90mr822485e9.1.1757172642757; Sat, 06 Sep 2025
 08:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-14-ryncsn@gmail.com>
In-Reply-To: <20250905191357.78298-14-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 6 Sep 2025 08:30:30 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNLUE87G5=MK-dpR4tAXoEO8jQYE0A+a7Rtk+f3yBcvxw@mail.gmail.com>
X-Gm-Features: AS18NWAXog6NTi4W8Zzjfo_0uE8VQjblDzke_IoBAmkHq0oxfQ3saVS4e3Z2VA8
Message-ID: <CAF8kJuNLUE87G5=MK-dpR4tAXoEO8jQYE0A+a7Rtk+f3yBcvxw@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] mm, swap: remove contention workaround for swap cache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Sep 5, 2025 at 12:15=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cluster setup will try to shuffle the clusters on initialization.
> It was helpful to avoid contention for the swap cache space. The cluster
> size (2M) was much smaller than each swap cache space (64M), so
> shuffling the cluster means the allocator will try to allocate swap
> slots that are in different swap cache spaces for each CPU, reducing the
> chance of two CPUs using the same swap cache space, and hence reducing
> the contention.
>
> Now, swap cache is managed by swap clusters, this shuffle is pointless.
> Just remove it, and clean up related macros.
>
> This also improves the HDD swap performance as shuffling IO is a bad
> idea for HDD, and now the shuffling is gone. Test have shown a ~40%
> performance gain for HDD [1]:
>
> Doing sequential swap in of 8G data using 8 processes with usemem,
> average of 3 test runs:
>
> Before: 1270.91 KB/s per process
> After:  1849.54 KB/s per process
>
> Link: https://lore.kernel.org/linux-mm/CAMgjq7AdauQ8=3DX0zeih2r21QoV=3D-W=
Wj1hyBxLWRzq74n-C=3D-Ng@mail.gmail.com/ [1]
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.co=
m
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Chris Li <chrisl@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---
>  mm/swap.h     |  4 ----
>  mm/swapfile.c | 32 ++++++++------------------------
>  mm/zswap.c    |  7 +++++--
>  3 files changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index e48431a26f89..c4fb28845d77 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -197,10 +197,6 @@ int swap_writeout(struct folio *folio, struct swap_i=
ocb **swap_plug);
>  void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)=
;
>
>  /* linux/mm/swap_state.c */
> -/* One swap address space for each 64M swap space */
> -#define SWAP_ADDRESS_SPACE_SHIFT       14
> -#define SWAP_ADDRESS_SPACE_PAGES       (1 << SWAP_ADDRESS_SPACE_SHIFT)
> -#define SWAP_ADDRESS_SPACE_MASK                (SWAP_ADDRESS_SPACE_PAGES=
 - 1)
>  extern struct address_space swap_space __ro_after_init;
>  static inline struct address_space *swap_address_space(swp_entry_t entry=
)
>  {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cbb7d4c0773d..6b3b35a7ddd9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3202,21 +3202,14 @@ static int setup_swap_map(struct swap_info_struct=
 *si,
>         return 0;
>  }
>
> -#define SWAP_CLUSTER_INFO_COLS                                         \
> -       DIV_ROUND_UP(L1_CACHE_BYTES, sizeof(struct swap_cluster_info))
> -#define SWAP_CLUSTER_SPACE_COLS                                         =
       \
> -       DIV_ROUND_UP(SWAP_ADDRESS_SPACE_PAGES, SWAPFILE_CLUSTER)
> -#define SWAP_CLUSTER_COLS                                              \
> -       max_t(unsigned int, SWAP_CLUSTER_INFO_COLS, SWAP_CLUSTER_SPACE_CO=
LS)
> -
>  static struct swap_cluster_info *setup_clusters(struct swap_info_struct =
*si,
>                                                 union swap_header *swap_h=
eader,
>                                                 unsigned long maxpages)
>  {
>         unsigned long nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_CLU=
STER);
>         struct swap_cluster_info *cluster_info;
> -       unsigned long i, j, idx;
>         int err =3D -ENOMEM;
> +       unsigned long i;
>
>         cluster_info =3D kvcalloc(nr_clusters, sizeof(*cluster_info), GFP=
_KERNEL);
>         if (!cluster_info)
> @@ -3265,22 +3258,13 @@ static struct swap_cluster_info *setup_clusters(s=
truct swap_info_struct *si,
>                 INIT_LIST_HEAD(&si->frag_clusters[i]);
>         }
>
> -       /*
> -        * Reduce false cache line sharing between cluster_info and
> -        * sharing same address space.
> -        */
> -       for (j =3D 0; j < SWAP_CLUSTER_COLS; j++) {
> -               for (i =3D 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_=
COLS); i++) {
> -                       struct swap_cluster_info *ci;
> -                       idx =3D i * SWAP_CLUSTER_COLS + j;
> -                       ci =3D cluster_info + idx;
> -                       if (idx >=3D nr_clusters)
> -                               continue;
> -                       if (ci->count) {
> -                               ci->flags =3D CLUSTER_FLAG_NONFULL;
> -                               list_add_tail(&ci->list, &si->nonfull_clu=
sters[0]);
> -                               continue;
> -                       }
> +       for (i =3D 0; i < nr_clusters; i++) {
> +               struct swap_cluster_info *ci =3D &cluster_info[i];
> +
> +               if (ci->count) {
> +                       ci->flags =3D CLUSTER_FLAG_NONFULL;
> +                       list_add_tail(&ci->list, &si->nonfull_clusters[0]=
);
> +               } else {
>                         ci->flags =3D CLUSTER_FLAG_FREE;
>                         list_add_tail(&ci->list, &si->free_clusters);
>                 }
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3dda4310099e..cba7077fda40 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -225,10 +225,13 @@ static bool zswap_has_pool;
>  * helpers and fwd declarations
>  **********************************/
>
> +/* One swap address space for each 64M swap space */
> +#define ZSWAP_ADDRESS_SPACE_SHIFT 14
> +#define ZSWAP_ADDRESS_SPACE_PAGES (1 << ZSWAP_ADDRESS_SPACE_SHIFT)
>  static inline struct xarray *swap_zswap_tree(swp_entry_t swp)
>  {
>         return &zswap_trees[swp_type(swp)][swp_offset(swp)
> -               >> SWAP_ADDRESS_SPACE_SHIFT];
> +               >> ZSWAP_ADDRESS_SPACE_SHIFT];
>  }
>
>  #define zswap_pool_debug(msg, p)                       \
> @@ -1674,7 +1677,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
>         struct xarray *trees, *tree;
>         unsigned int nr, i;
>
> -       nr =3D DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
> +       nr =3D DIV_ROUND_UP(nr_pages, ZSWAP_ADDRESS_SPACE_PAGES);
>         trees =3D kvcalloc(nr, sizeof(*tree), GFP_KERNEL);
>         if (!trees) {
>                 pr_err("alloc failed, zswap disabled for swap type %d\n",=
 type);
> --
> 2.51.0
>
>

