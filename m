Return-Path: <linux-kernel+bounces-792698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD79B3C7C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 06:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341965E5C91
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 04:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B42773D1;
	Sat, 30 Aug 2025 04:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZpDZxWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB842765DF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526881; cv=none; b=IJaBN7eJs5Cmm2CnFRsmbOhOKVZZsLpC9MSm2Y+drwGOjLHqTt7XO1FSGRlWRXEVjbyGGyX8SYUbO7dBGbKmlN9I7XQ2/AvnrDvLf/Qmsv7/La9GLkkb6mdZ/74T4CbbJ4QNQfH1lSfocYP9w9pjVMnK7A9v0+hYSnwrni/C71I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526881; c=relaxed/simple;
	bh=WE5PVICidQ/Af11xBg6ROnfejgezwmEu2dAUnN1Ax9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z31gE6DqOX9YRKt9DE1VfDjzAul530IKyTbREknQwEQhCG0mGFPfydtQm1MC6TMpei2lTUWjfw6g3XWMRHLN7zr3cxKdnKnQXrfilCGlk7O1/ushqA/tVz+m+UA2TPaoUDIxt/e4U5AnX/T4rw6jUE4xei0U266/NnenxmAH7Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZpDZxWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FEAC4CEFA
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 04:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756526881;
	bh=WE5PVICidQ/Af11xBg6ROnfejgezwmEu2dAUnN1Ax9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eZpDZxWQT3IG2krT879UGpSzN5RzbGHJh4R0zVZ7uGMiUHn9vzgyEpNesCpzJttIP
	 Wavmb7fxmdjDfdyIznYFmLzyccor4zA7tB8+KZNJ54JnHtfYdh/+3/AZRVUJRMosxE
	 bDnlQNOvVF6AtmC+vvYY7aJH7NwsrQaiwftxlHF0/3oX1YaFzsq44Zlnj01PYssn6p
	 f0aFN4/rZmKMckNvoqCgwhnZxrKLQkV8RI4Vq1pdejiy5cfPu+wbeykDcUUNm9/77C
	 bLEuAt8rlvFGiUCMdqkSSI9cI1haGMJUhDn0bDrubL+QdOEiOiXOKsCIzUaqEgzzrj
	 1xiglQJrE1AUg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d5fe46572so25635417b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:08:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVYP7FndMJfbuOdGrVPTR6ffJ/MoTCLjd1PUn6+fZBJZ0nbPSS01af+4Ekv5N6xhVUYju4ODb4IKK9LXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI28d60XP4KOY8AQDw6/jMRJ2t7QGzQVSBgCvSertpekmCERMj
	MdErE8GYj/ChohPFflzCN3fmNLvek6yNg/P2RBYApJago1SNhf/yM4OFL1FxXuVGq6CnszDjrGd
	1prHnPIEpGEXhs9eONFnbb/hp8Jl4H1Rj+wuz2pMNRw==
X-Google-Smtp-Source: AGHT+IEGj0eWIZC0zESlF+y3aUbu6XK1GeXnZhulqFwB5QqMwxUlAK1udpHTk2v6e+YYWXkxZsvYyAECgDQ3J6/NAFw=
X-Received: by 2002:a05:690c:55c6:b0:720:950:1559 with SMTP id
 00721157ae682-72273d26f59mr12885407b3.17.1756526880512; Fri, 29 Aug 2025
 21:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-8-ryncsn@gmail.com>
In-Reply-To: <20250822192023.13477-8-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 29 Aug 2025 21:07:49 -0700
X-Gmail-Original-Message-ID: <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com>
X-Gm-Features: Ac12FXzbMtEozPRn03rr8JMWk3TBwwY9nmEZgIuso-7nlwmYTCX6dNBl0fu1UwE
Message-ID: <CACePvbXB-G5vhoEt87BZcjDZ8kZWo3mZtAZ60YbR_gcjnPz29w@mail.gmail.com>
Subject: Re: [PATCH 7/9] mm, swap: remove contention workaround for swap cache
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

Hi Kairui,

It feels so good to remove that 64M swap cache space. Thank you for
making it happen.

Some nitpick follows. I am fine as is as well.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Fri, Aug 22, 2025 at 12:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap cluster setup will try to shuffle the clusters on initialization.
> It was helpful to avoid contention for the swap cache space. The cluster
> size (2M) was much smaller than each swap cache space (64M), so shuffling
> the cluster means the allocator will try to allocate swap slots that are
> in different swap cache spaces for each CPU, reducing the chance of two
> CPUs using the same swap cache space, and hence reducing the contention.
>
> Now, swap cache is managed by swap clusters, this shuffle is pointless.
> Just remove it, and clean up related macros.
>
> This should also improve the HDD swap performance as shuffling IO is a
> bad idea for HDD, and now the shuffling is gone.

Did you have any numbers to prove that :-). Last time the swap
allocator stress testing has already destroyed two of my SAS drives
dedicated for testing. So I am not very keen on running the HDD swap
stress test. The HDD swap stress test are super slow to run, it takes
ages.

>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202504241621.f27743ec-lkp@intel.co=
m
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h     |  4 ----
>  mm/swapfile.c | 32 ++++++++------------------------
>  mm/zswap.c    |  7 +++++--
>  3 files changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 4af42bc2cd72..ce3ec62cc05e 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -153,10 +153,6 @@ int swap_writeout(struct folio *folio, struct swap_i=
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
> index df68b5e242a6..0c8001c99f30 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3203,21 +3203,14 @@ static int setup_swap_map(struct swap_info_struct=
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

Nitpick: This line location change is not necessary.

>
>         cluster_info =3D kvcalloc(nr_clusters, sizeof(*cluster_info), GFP=
_KERNEL);
>         if (!cluster_info)
> @@ -3266,22 +3259,13 @@ static struct swap_cluster_info *setup_clusters(s=
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

struct swap_cluster_info *ci =3D cluster_info + i;
looks simpler. Pure nitpick and personal preference, you don't have to
follow it.

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
> index c869859eec77..c0a9be14a725 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -237,10 +237,13 @@ static bool zswap_has_pool;
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
>  #define zswap_pool_debug(msg, p)                               \
> @@ -1771,7 +1774,7 @@ int zswap_swapon(int type, unsigned long nr_pages)
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

