Return-Path: <linux-kernel+bounces-757078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04660B1BD68
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B54216C236
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D4823BCFD;
	Tue,  5 Aug 2025 23:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3CN78Af"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573A4315E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436944; cv=none; b=RKXsvGVvMcbkUv7PjLLWusUmvBLur6McRKef7yOj/jm484g2xgT3h7kuN93MbmaFwnQ7tBkYbu2qa48Qo8CydYX2R+uBYkNYRkrLk1HUuyMF/CL8aq8k8+I/DtBf2MaoUMNULS/UvJHsLiAouEQYxw5TF8pfeA4N6jPR9CZuwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436944; c=relaxed/simple;
	bh=dfkF4zvAOrOAcEgTbDmIN6zbS+Jp+b4BXY/3cALRqYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TfQ4RZCTZIf3eKX3RKqZyrLz9LrUSxoUbLUqbyGrZprXjsgu3CL+zIAe9GIFpk56QXm5aqHah+4kTxq9aEJUjU4oTUvfXxxRxMN5RFLeSiSCD7SbK/tn3o2rNk5eGIxKyw1rP0D8WdEVXnOQRVeWM5Ely2y0RaLirp7LHhruiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3CN78Af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B84C4AF09
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436943;
	bh=dfkF4zvAOrOAcEgTbDmIN6zbS+Jp+b4BXY/3cALRqYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=s3CN78Af9yWKiBUxjlkgWJhfr4II0NvCuH4P+hENta1qr5y1VUHImFg4s3fZSe/ve
	 cS1IQlvh0ARJWO2rcxnZVxatO9PhaWaSjKECPAy/1UWzhG1RaXBQecz6+udMxamGp2
	 Wnv6QSyxNxjdIS/b7vc4HwOMGDkHvm9/Y3uBmaK0G9g8MVMxlhTf0CU6PXChlACrJH
	 TwGnQQhWI1eq7d8FH4C0CaVmuy960tyRCr4RidvQRYpSNGYxx6g/2kfg28jzukHv8f
	 qlAfgmnrxeySqGNOlon4nOsnFlHVpssWtEWdFktZAnr2C66wj9l4qZVjDm8PBA674I
	 FH5h3D+xNn9fw==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459b3904fdeso13315e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:35:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUB7FEPFxnPgffUsicDW5sFhBsX0Oo/VNwefAEzLGNd+q9oKcwkGGVx+A/6jfCsq/lJe5R85MxaeN4DdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywZPxjt5sa7E6fFQ3Ui8bFc6eG+pBpepbktEBYWdMtTm5P/J65
	k+1vptku4BjhxkhCc7SqDW03dG3CvxUpXW+7SLAWXAqULOpJ6m0gnw81Zu8DUQLdE/DzGxSHQEt
	PxdBS4IP4hjxmPes2ebi8czz4p6IfZ5w9Rc59d6Xl
X-Google-Smtp-Source: AGHT+IGfyIalU4sN4H/oUM8GTkhl1j2T8Urex0TikGxCJcfJ+0k0dcHQ0Be0nqxa0koy6Uz18uZaVunzfvOXK8orVDw=
X-Received: by 2002:a05:600c:c0d4:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-459e6d019d5mr494105e9.2.1754436942237; Tue, 05 Aug 2025
 16:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-3-ryncsn@gmail.com>
In-Reply-To: <20250804172439.2331-3-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 5 Aug 2025 16:35:30 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPCZ8BEEAWT4QYVAMW4BD_1=77NuJySnWo3TopegOH5Gg@mail.gmail.com>
X-Gm-Features: Ac12FXyZva7-b-yvuQVjG4V3fUaLnUEQDNn-uRvVqaWk9MtjWv3FA-Q454exq7c
Message-ID: <CAF8kJuPCZ8BEEAWT4QYVAMW4BD_1=77NuJySnWo3TopegOH5Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, swap: prefer nonfull over free clusters
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

On Mon, Aug 4, 2025 at 10:25=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> We prefer a free cluster over a nonfull cluster whenever a CPU local
> cluster is drained to respect the SSD discard behavior [1]. It's not
> a best practice for non-discarding devices. And this is causing a
> chigher fragmentation rate.

Not only does it cause a higher fragmentation rate. It also causes
limit working set size over a long period of continued swapping can
write to the whole swapping partition. That is bad from the SSD point
of view if the swap page access pattern is random. Because at random
access patterns, very few clusters can have all 512 free, which can
reach to the discard. The previously preferred new cluster approach
works best with batched short to medium running cycle jobs, so at the
end of batch, there is a time where most of the working of swap is
released. That can release the nonfull cluster to a free cluster. For
long running jobs and random access of swap entry, very low change
frees a cluster to discard.

This patch will cause the limit working set to only write to a limited
swap area. Which is a good thing from the SSD wearing point of view.

Chris

> So for a non-discarding device, prefer nonfull over free clusters. This
> reduces the fragmentation issue by a lot.
>
> Testing with make -j96, defconfig, using 64k mTHP, 8G ZRAM:
>
> Before: sys time: 6121.0s  64kB/swpout: 1638155  64kB/swpout_fallback: 18=
9562
> After:  sys time: 6145.3s  64kB/swpout: 1761110  64kB/swpout_fallback: 66=
071
>
> Testing with make -j96, defconfig, using 64k mTHP, 10G ZRAM:
>
> Before: sys time 5527.9s  64kB/swpout: 1789358  64kB/swpout_fallback: 178=
13
> After:  sys time 5538.3s  64kB/swpout: 1813133  64kB/swpout_fallback: 0
>
> Performance is basically unchanged, and the large allocation failure rate
> is lower. Enabling all mTHP sizes showed a more significant result:
>
> Using the same test setup with 10G ZRAM and enabling all mTHP sizes:
>
> 128kB swap failure rate:
> Before: swpout:449548 swpout_fallback:55894
> After:  swpout:497519 swpout_fallback:3204
>
> 256kB swap failure rate:
> Before: swpout:63938  swpout_fallback:2154
> After:  swpout:65698  swpout_fallback:324
>
> 512kB swap failure rate:
> Before: swpout:11971  swpout_fallback:2218
> After:  swpout:14606  swpout_fallback:4
>
> 2M swap failure rate:
> Before: swpout:12     swpout_fallback:1578
> After:  swpout:1253   swpout_fallback:15
>
> The success rate of large allocations is much higher.
>
> Link: https://lore.kernel.org/linux-mm/87v8242vng.fsf@yhuang6-desk2.ccr.c=
orp.intel.com/ [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5fdb3cb2b8b7..4a0cf4fb348d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -908,18 +908,20 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si, int o
>         }
>
>  new_cluster:
> -       ci =3D isolate_lock_cluster(si, &si->free_clusters);
> -       if (ci) {
> -               found =3D alloc_swap_scan_cluster(si, ci, cluster_offset(=
si, ci),
> -                                               order, usage);
> -               if (found)
> -                       goto done;
> +       /*
> +        * If the device need discard, prefer new cluster over nonfull
> +        * to spread out the writes.
> +        */
> +       if (si->flags & SWP_PAGE_DISCARD) {
> +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> +               if (ci) {
> +                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> +                                                       order, usage);
> +                       if (found)
> +                               goto done;
> +               }
>         }
>
> -       /* Try reclaim from full clusters if free clusters list is draine=
d */
> -       if (vm_swap_full())
> -               swap_reclaim_full_clusters(si, false);
> -
>         if (order < PMD_ORDER) {
>                 while ((ci =3D isolate_lock_cluster(si, &si->nonfull_clus=
ters[order]))) {
>                         found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> @@ -927,7 +929,23 @@ static unsigned long cluster_alloc_swap_entry(struct=
 swap_info_struct *si, int o
>                         if (found)
>                                 goto done;
>                 }
> +       }
>
> +       if (!(si->flags & SWP_PAGE_DISCARD)) {
> +               ci =3D isolate_lock_cluster(si, &si->free_clusters);
> +               if (ci) {
> +                       found =3D alloc_swap_scan_cluster(si, ci, cluster=
_offset(si, ci),
> +                                                       order, usage);
> +                       if (found)
> +                               goto done;
> +               }
> +       }
> +
> +       /* Try reclaim full clusters if free and nonfull lists are draine=
d */
> +       if (vm_swap_full())
> +               swap_reclaim_full_clusters(si, false);
> +
> +       if (order < PMD_ORDER) {
>                 /*
>                  * Scan only one fragment cluster is good enough. Order 0
>                  * allocation will surely success, and large allocation
> --
> 2.50.1
>
>

