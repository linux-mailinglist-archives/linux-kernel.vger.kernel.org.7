Return-Path: <linux-kernel+bounces-758651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FFFB1D20C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF0D723F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4B11E521A;
	Thu,  7 Aug 2025 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj1Wrf5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02274FBF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544772; cv=none; b=c4Z0uyrRDaTRno4umWZd0OqyVksylyJUMqpxIqQ7oDshNc4jTe+upOE5lMlDShU+Nd9OE7iN4YAFq947QFqqRZWNdly2J4J4k3j3uGGhVFGWSHN32glV4VV/ZOVGTdvIr17+gkJG74q68xYxOJwswSOwy/CkZSHlNbDyojJUJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544772; c=relaxed/simple;
	bh=rAB/UBmBSFxnXd0nKV8bRIRC+NXmYJqrmY/gqpJtuMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MooX+hRdtoOm9o4UGS77glg05teVfzP9h5qZaKXGvXM+w+2IDpodwnea/9Xm8/YASfPJpznp6nHQWJWSeJujgHDpQNjtk2FpKiPdEu5po/fai4LYj8egjqhoJZelnEsRFTL2Xs0QoFKjyeuOTrZyo8CR4DgGG1upfsIBGMeKkIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj1Wrf5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA41C4CEF6
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754544771;
	bh=rAB/UBmBSFxnXd0nKV8bRIRC+NXmYJqrmY/gqpJtuMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lj1Wrf5l+enWTJt92Q1f37ftQ6dRrRa/7pz9cNsSfOpR54nNChwjJSgnINjviPBQK
	 cxfld5TJinjB/Tm9qvyqfqEsPcQ4N/3QGYgZ0T4RtEYtKtq+yndJPnApo2uiUrPVza
	 kzZ+1f1c/k/slOvXg/YsoEtEqftXUCeH7rIl5Y7fxZ/j6GNA3LqAO+plYqOvLlgO2p
	 t739YkcQDv+WWMV9ItEuD26oJu2rjg/m02FbN0apS5WFYLQT4chCJMyBQtN6Jnv3VZ
	 QU6LLIG7kjmsjf250GeDS3LxclJ7YNvZvMzskGIKOA8n4l59GHG/73thCogbgHfuoy
	 rSUED+Qb852tA==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459e497776cso43905e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 22:32:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9InYPQYR2lBZhbKF6mDr6SxBGmriuUJ9lH+Yyc+V5m+9/f4N9iLQLlV3sTgoJeb6qv0/R16mncPH71no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHokdERPxodzk76dE9/aaIrDFG1oedqN3aNeRvaE40pUE4S+H
	tf61fZgTYRQRFTdEyKTvNnZfzgGfsSNEwlhbZ8xJsiRRmV6eIKRmN6ALSoxPUrB2VTVGoysmRic
	wnocNlVFwm06W3I3JFbZyCLqV+m4AdjGTD2e5vmmo
X-Google-Smtp-Source: AGHT+IHRY2M2xDkw4ZJWViT3kxgvACrWtMMqxvgefNDPmHZPVLE+Ow533nj6Df/LWU4LDwUk6uK+U/WK5zAooMEDvyA=
X-Received: by 2002:a05:600c:3148:b0:456:4607:b193 with SMTP id
 5b1f17b1804b1-459f0357255mr301155e9.7.1754544770158; Wed, 06 Aug 2025
 22:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806161748.76651-1-ryncsn@gmail.com> <20250806161748.76651-2-ryncsn@gmail.com>
In-Reply-To: <20250806161748.76651-2-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 Aug 2025 22:32:38 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNSvQTxEOiWZRwwB4117713Ks51AvD0gbMhuA7KUhtARA@mail.gmail.com>
X-Gm-Features: Ac12FXyXdS9CEOgVD9cnX_UtpBJ_eBgMrn2QY5iTZyySscX0lUCFjLmmrl_fVCE
Message-ID: <CAF8kJuNSvQTxEOiWZRwwB4117713Ks51AvD0gbMhuA7KUhtARA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, swap: only scan one cluster in fragment list
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Wed, Aug 6, 2025 at 9:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> Fragment clusters were mostly failing high order allocation already.
> The reason we scan it through now is that a swap slot may get freed
> without releasing the swap cache, so a swap map entry will end up in
> HAS_CACHE only status, and the cluster won't be moved back to non-full
> or free cluster list. This may cause a higher allocation failure rate.
>
> Usually only !SWP_SYNCHRONOUS_IO devices may have a large number of
> slots stuck in HAS_CACHE only status. Because when a !SWP_SYNCHRONOUS_IO
> device's usage is low (!vm_swap_full()), it will try to lazy free
> the swap cache.
>
> But this fragment list scan out is a bit overkill. Fragmentation
> is only an issue for the allocator when the device is getting full,
> and by that time, swap will be releasing the swap cache aggressively
> already. Only scan one fragment cluster at a time is good enough to

Only *scanning* one fragment cluster...

> reclaim already pinned slots, and move the cluster back to nonfull.
>
> And besides, only high order allocation requires iterating over the
> list, order 0 allocation will succeed on the first attempt. And
> high order allocation failure isn't a serious problem.
>
> So the iteration of fragment clusters is trivial, but it will slow down
> large allocation by a lot when the fragment cluster list is long.
> So it's better to drop this fragment cluster iteration design.

One side note is that we make some trade off here. We trade lower
success rates >4K swap entry allocation on fragment lists with overall
faster swap entry time, because we stop searching the fragment list
early.

I notice this patch will suffer from fragment list trap behavior. The
clusters go from free -> non full -> fragment -> free again (ignore
the full list for now). Only when the cluster is completely free
again, it will reset the cluster back to the free list. Otherwise
given random swap entry access pattern, and long life cycle of some
swap entry.  Free clusters are very hard to come by. Once it is in the
fragment list, it is not easy to move back to a non full list. The
cluster will eventually gravitate towards the fragment list and trap
there. This kind of problem is not easy to expose by the kernel
compile work load, which is a batch job in nature, with very few long
running processes. If most of the clusters in the swapfile are in the
fragment list. This will cause us to give up too early and force the
more expensive swap cache reclaim path more often.

To counter that fragmentation list trap effect,  one idea is that not
all clusters in the fragment list are equal. If we make the fragment
list into a few buckets by how empty it is. e.g. >50% vs <50%. I
expect the <50% free cluster has a very low success rate for order >0
allocation. Given an order "o", we can have a math formula P(o, count)
of the success rate if slots are even randomly distributed with count
slots used. The >50% free cluster will likely have a much higher
success rate.  We should set a different search termination threshold
for different bucket classes. That way we can give the cluster a
chance to move up or down the bucket class. We should try the high
free bucket before the low free bucket.

That can combat the fragmentation list trap behavior.

BTW, we can have some simple bucket statistics to see what is the
distribution of fragmented clusters. The bucket class threshold can
dynamically adjust using the overall fullness of the swapfile.

Chris

>
> Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
> defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
> only:
>
> Before: sys time: 4432.56s
> After:  sys time: 4430.18s
>
> Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:
>
> Before: sys time: 11609.69s  64kB/swpout: 1787051  64kB/swpout_fallback: =
20917
> After:  sys time: 5572.85s   64kB/swpout: 1797612  64kB/swpout_fallback: =
19254
>
> Change to 8G ZRAM:
>
> Before: sys time: 21524.35s  64kB/swpout: 1687142  64kB/swpout_fallback: =
128496
> After:  sys time: 6278.45s   64kB/swpout: 1679127  64kB/swpout_fallback: =
130942
>
> Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:
>
> Before: sys time: 7393.50s  64kB/swpout:1788246  swpout_fallback: 0
> After:  sys time: 7399.88s  64kB/swpout:1784257  swpout_fallback: 0
>
> Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:
>
> Before: sys time: 26292.26s 64kB/swpout:1645236  swpout_fallback: 138945
> After:  sys time: 9463.16s  64kB/swpout:1581376  swpout_fallback: 259979
>
> The performance is a lot better for large folios, and the large order
> allocation failure rate is only very slightly higher or unchanged even
> for !SWP_SYNCHRONOUS_IO devices high pressure.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/swapfile.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index b4f3cc712580..1f1110e37f68 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -926,32 +926,25 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>                 swap_reclaim_full_clusters(si, false);
>
>         if (order < PMD_ORDER) {
> -               unsigned int frags =3D 0, frags_existing;
> -
>                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[order]))) {
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
>                                                         order, usage);
>                         if (found)
>                                 goto done;
> -                       /* Clusters failed to allocate are moved to frag_=
clusters */
> -                       frags++;
>                 }
>
> -               frags_existing =3D atomic_long_read(&si->frag_cluster_nr[=
order]);
> -               while (frags < frags_existing &&
> -                      (ci =3D isolate_lock_cluster(si, &si->frag_cluster=
s[order]))) {
> -                       atomic_long_dec(&si->frag_cluster_nr[order]);
> -                       /*
> -                        * Rotate the frag list to iterate, they were all
> -                        * failing high order allocation or moved here du=
e to
> -                        * per-CPU usage, but they could contain newly re=
leased
> -                        * reclaimable (eg. lazy-freed swap cache) slots.
> -                        */
> +               /*
> +                * Scan only one fragment cluster is good enough. Order 0
> +                * allocation will surely success, and large allocation
> +                * failure is not critical. Scanning one cluster still
> +                * keeps the list rotated and reclaimed (for HAS_CACHE).
> +                */
> +               ci =3D isolate_lock_cluster(si, &si->frag_clusters[order]=
);
> +               if (ci) {
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
>                                                         order, usage);
>                         if (found)
>                                 goto done;
> -                       frags++;
>                 }
>         }
>
> --
> 2.50.1
>
>

