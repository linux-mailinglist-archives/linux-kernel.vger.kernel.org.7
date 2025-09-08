Return-Path: <linux-kernel+bounces-806161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92582B492A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F1D16E69B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492F330BF70;
	Mon,  8 Sep 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzvo55RM"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAC1C3BFC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344245; cv=none; b=OOgpZ76mPMy+bVkF09XjJf01ug0QdVepVDHvnRiax13GsGC9pSdpoPS3Kbu3w8UhySXSe3nL5zuOwFb/gXBWRWHzAIrzX+oYPpOR0GGYtxmc6kF1y4Pv+MULmwrg7UfXxdKiHCwH8SMyN1M3AYAQwMxGXJ3kgFh+Mp4/93q8IIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344245; c=relaxed/simple;
	bh=gxWSbA9eJNw9ZHVE/sN9jgcnjTBeZPUFrHxBRxp78Oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCA8QUy7/73kRWldiUhgybtn7od/x812juIeCBbqX9GhjmDrv34cH6lXH00BN/5vuKo5IWbU0HyWOXD+3Bh729L2GcZQ8TO9+jJ7EHB8vOswok7M2pYocJIWKOJ9YILRyeH4B1WKPef1DWLCQoCfCxD1CASsGkJeOkpvPqo7ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzvo55RM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso4942907a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757344242; x=1757949042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dO3Pa6dEWUP8pelQvefMYAqpzf+ZorOHLTvnJ330hQ=;
        b=mzvo55RMGtrnZ7aNST8kcjCoX3Um2GUoc15PSRWv2mWhBswbIncN4cB13R4dr9h54g
         SNQXd0Yyktto/ymRCmkGbR8w+H7Ygvbgw6cSdNSHsyFUuA/FOyorXaCz7CAVv3R0AmEg
         Lfs/nSSoDbAZzyPEvMcw0agQONO0KICVBiQC2mD56dIyJkLBwWvjp0G/JYGx5lIB93JY
         bGXKpVLd9GeYL8bFNbJFL101YVCiTFjFpUniW/+1Pbs/bkI9PpEASeNc+JkhthUk5lhq
         37xdQNUSM0wlYT+JhZzu+VFn25sUUBJlKTQvf9lPNpwSjj6FTo8ALfXrhlzZGEQcN50B
         684w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344242; x=1757949042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dO3Pa6dEWUP8pelQvefMYAqpzf+ZorOHLTvnJ330hQ=;
        b=pDOSXJ0hQ4hrjvIrKaEiv2wxKWWitO3qcyWxga6Ryn55uXFJE0/u88Kn7ANgbiiRVq
         VASySCTZRxFKOcGgZ5LKpz0nxXcpOR9xKXsK0uVvRR98TqrHIxWJSwwyMDV3g+8gDmu/
         6/PNB8OFoaBCqlmRZg5KItfirQxQXF3gODsnHdU6+qc6hg/NBn9UMBQaeOYk324jyUWb
         6NpaZvj6Tpkcp3M+lqf5iPrzvnnoO+tyhhO8OsyNcQONOErmSpw5DRnmzGFkN+gx7aJf
         YoMxXyfrxZSHI7aCA/0s0x6jWMS+672DNd0GJIHfrPq2qZwmjz7pYAeOLFBhekVgaZko
         DfiA==
X-Forwarded-Encrypted: i=1; AJvYcCVTlMmUu+CP5EeVFjB501uqoxCzrDIK35k9kV7MR1hgY326JsqH5jk47eAW4bQhluEilCX7bM3gI/xdTpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVG8goFo//GvCKK3Q1HNXKHN6ENwi+oa3tAd6hw8ZYcdDnQkUo
	G8sfa3xzGOGdl3TrpqP4U+Pgw8QFvvHRd5h2W0TN6nMldfITbZfXWpcXkDIw2cacICR2iSYIDNA
	7E5yOkIzIrqnd95YWyy+g1VkrA62pqAw=
X-Gm-Gg: ASbGncvhpgE7rtnHTSB6nOLit1MeGvt/B2Nill9VdY9Dc6um/GBuHl0cDo1lJpy5Vdq
	XxR37IaVR6scMQwD7wfb7EPvIkBCE4LgwhRt1K5UwTeVb9snuncW6ejhLsiV5+egg993E+IRzOj
	EZIw1SdsFqzxBMqQKSNhm2x1wsDbM2GLghhv5agWp5wPqiuyIK9gFOv/lEjUa+cdTxC117jP6C9
	Eijdn54yHE=
X-Google-Smtp-Source: AGHT+IHnINkBVpoQfKvgRMifbAKSbbKVvSSsU75fh0HsrYLeTsWizN/4a6ihqC0j6vCvL42vfQxG+u48mAibFUSQ4OI=
X-Received: by 2002:a05:6402:2553:b0:617:b28c:e134 with SMTP id
 4fb4d7f45d1cf-6236d2ca6cfmr8301330a12.0.1757344241773; Mon, 08 Sep 2025
 08:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905191357.78298-1-ryncsn@gmail.com> <20250905191357.78298-12-ryncsn@gmail.com>
 <vj7utcgrseaot6ktpbwgshthmjza7w7vk2glede273tza7yfi6@cyxppxoney5u>
 <CAMgjq7CLSuSfRwMYqNL9ZU3ehpZfR6oewHsYtLD4CTXcvEKOTg@mail.gmail.com> <eu3s6hqfcbkymjqk2rrngzx7qxjzpivfty2dr4lrduxohxuuuv@g63qihvder5d>
In-Reply-To: <eu3s6hqfcbkymjqk2rrngzx7qxjzpivfty2dr4lrduxohxuuuv@g63qihvder5d>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 8 Sep 2025 23:10:05 +0800
X-Gm-Features: AS18NWAOZumiwP4vIZdf4GKuXoH9G7uXKNhi2ON0m9FsP07PZ039SG3x5bSA-As
Message-ID: <CAMgjq7AHZ+X83pOUiOfhXWkV158uAvv=NQE6ibh33BQVgPJ5iA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:01=E2=80=AFPM Klara Modin <klarasmodin@gmail.com>=
 wrote:
>
> On 2025-09-08 22:34:04 +0800, Kairui Song wrote:
> > On Sun, Sep 7, 2025 at 8:59=E2=80=AFPM Klara Modin <klarasmodin@gmail.c=
om> wrote:
> > >
> > > On 2025-09-06 03:13:53 +0800, Kairui Song wrote:
> > > > From: Kairui Song <kasong@tencent.com>
> > > >
> > > > Introduce basic swap table infrastructures, which are now just a
> > > > fixed-sized flat array inside each swap cluster, with access wrappe=
rs.
> > > >
> > > > Each cluster contains a swap table of 512 entries. Each table entry=
 is
> > > > an opaque atomic long. It could be in 3 types: a shadow type (XA_VA=
LUE),
> > > > a folio type (pointer), or NULL.
> > > >
> > > > In this first step, it only supports storing a folio or shadow, and=
 it
> > > > is a drop-in replacement for the current swap cache. Convert all sw=
ap
> > > > cache users to use the new sets of APIs. Chris Li has been suggesti=
ng
> > > > using a new infrastructure for swap cache for better performance, a=
nd
> > > > that idea combined well with the swap table as the new backing
> > > > structure. Now the lock contention range is reduced to 2M clusters,
> > > > which is much smaller than the 64M address_space. And we can also d=
rop
> > > > the multiple address_space design.
> > > >
> > > > All the internal works are done with swap_cache_get_* helpers. Swap
> > > > cache lookup is still lock-less like before, and the helper's conte=
xts
> > > > are same with original swap cache helpers. They still require a pin
> > > > on the swap device to prevent the backing data from being freed.
> > > >
> > > > Swap cache updates are now protected by the swap cluster lock
> > > > instead of the Xarray lock. This is mostly handled internally, but =
new
> > > > __swap_cache_* helpers require the caller to lock the cluster. So, =
a
> > > > few new cluster access and locking helpers are also introduced.
> > > >
> > > > A fully cluster-based unified swap table can be implemented on top
> > > > of this to take care of all count tracking and synchronization work=
,
> > > > with dynamic allocation. It should reduce the memory usage while
> > > > making the performance even better.
> > > >
> > > > Co-developed-by: Chris Li <chrisl@kernel.org>
> > > > Signed-off-by: Chris Li <chrisl@kernel.org>
> > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > ---
> > > >  MAINTAINERS          |   1 +
> > > >  include/linux/swap.h |   2 -
> > > >  mm/huge_memory.c     |  13 +-
> > > >  mm/migrate.c         |  19 ++-
> > > >  mm/shmem.c           |   8 +-
> > > >  mm/swap.h            | 157 +++++++++++++++++------
> > > >  mm/swap_state.c      | 289 +++++++++++++++++++--------------------=
----
> > > >  mm/swap_table.h      |  97 +++++++++++++++
> > > >  mm/swapfile.c        | 100 +++++++++++----
> > > >  mm/vmscan.c          |  20 ++-
> > > >  10 files changed, 458 insertions(+), 248 deletions(-)
> > > >  create mode 100644 mm/swap_table.h
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 1c8292c0318d..de402ca91a80 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -16226,6 +16226,7 @@ F:    include/linux/swapops.h
> > > >  F:   mm/page_io.c
> > > >  F:   mm/swap.c
> > > >  F:   mm/swap.h
> > > > +F:   mm/swap_table.h
> > > >  F:   mm/swap_state.c
> > > >  F:   mm/swapfile.c
> > > >
> > >
> > > ...
> > >
> > > >  #include <linux/swapops.h> /* for swp_offset */
> > >
> > > Now that swp_offset() is used in folio_index(), should this perhaps a=
lso be
> > > included for !CONFIG_SWAP?
> >
> > Hi, Thanks for looking at this series.
> >
> > >
> > > >  #include <linux/blk_types.h> /* for bio_end_io_t */
> > > >
> > ...
> >
> > > >       if (unlikely(folio_test_swapcache(folio)))
> > >
> > > > -             return swap_cache_index(folio->swap);
> > > > +             return swp_offset(folio->swap);
> > >
> > > This is outside CONFIG_SWAP.
> >
> > Right, but there are users of folio_index that are outside of
> > CONFIG_SWAP (mm/migrate.c), and swp_offset is also outside of SWAP so
> > that's OK.
> >
> > If we wrap it, the CONFIG_SWAP build will fail. I've test !CONFIG_SWAP
> > build on this patch and after the whole series, it works fine.
> >
> > We should drop the usage of folio_index in migrate.c, that's not
> > really related to this series though.
>
> Interesting that it works for you. I have a config with !CONFIG_SWAP whic=
h
> fails with:
>
>  In file included from mm/shmem.c:44:
>  mm/swap.h: In function =E2=80=98folio_index=E2=80=99:
>  mm/swap.h:461:24: error: implicit declaration of function =E2=80=98swp_o=
ffset=E2=80=99; did you mean =E2=80=98pmd_offset=E2=80=99? [-Wimplicit-func=
tion-declaration]
>    461 |                 return swp_offset(folio->swap);
>        |                        ^~~~~~~~~~
>        |                        pmd_offset
>
> (though it's possible I have misapplied the series somehow).
> If I just move the linux/swapops.h include outside the CONFIG_SWAP ifdef:
>
> diff --git a/mm/swap.h b/mm/swap.h
> index caff4fe30fc5..12dd7d6478ff 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -3,6 +3,7 @@
>  #define _MM_SWAP_H
>
>  #include <linux/atomic.h> /* for atomic_long_t */
> +#include <linux/swapops.h> /* for swp_offset */
>  struct mempolicy;
>  struct swap_iocb;
>
> @@ -54,7 +55,6 @@ enum swap_cluster_flags {
>  };
>
>  #ifdef CONFIG_SWAP
> -#include <linux/swapops.h> /* for swp_offset */

Oh, I think I know what the problem is here. You disabled SHMEM too.
Most users of swap.h includes linux/swapops.h already. But for
shmem.c, it doesn't include linux/swapops.h when !CONFIG_SHMEM
 so swp_offset is undefined.

It's true that the problem is in swap.h, it should include swapops.h
for !SWAP too to avoid build error like this. Thanks for the report!


>  #include <linux/blk_types.h> /* for bio_end_io_t */
>
>  static inline unsigned int swp_cluster_offset(swp_entry_t entry)
>
> it fixes that issue for me, and my other CONFIG_SWAP builds do not seem
> to be impacted. I attached the config in case it's useful.
>
> >
> > >
> > > >       return folio->index;
> > > >  }
> > >
> > > ...
> > >
> > > Regards,
> > > Klara Modin
> > >

