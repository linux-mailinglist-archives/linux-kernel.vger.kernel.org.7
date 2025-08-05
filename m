Return-Path: <linux-kernel+bounces-757065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE858B1BD4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677F53AA9DD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FEC23D2BF;
	Tue,  5 Aug 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLmpCmZY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D880323E340
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436615; cv=none; b=u+f0jfn+CMNGlaELY0yMM0+KCkJMBPhfB6MWS9rTITP3JUOaz/s+HjUyB9K9OnNwN8cQpS/k6EOpOmnUoAtlWH0lviiima9HdaPov4vGDS39EHQlrmY6psZMtlwWVok+ysB4iwytTxKaSGFR8VEjGLbW3wVc90fnyjQeIOphZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436615; c=relaxed/simple;
	bh=AurWwft0/kG2VXE48L1u4X8kP0ymfZEYEf/HqYpJ1ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdZZkgkTNU3/aKGCRws39O+/nQv9W2I0vxmEMhKX91wEzdDUOIgDzu7UrLL/MMRxLWSBac2GC9ONuaWzrRD3XT9fLSqqbWJEsCxyoSdCdKzzRQq3slOYNDXpKl2LULF3G0zur53q4/CIQX+N6wDfzKfdCiW2nqGYqJD7WS/4FqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLmpCmZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401F8C4CEF9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436615;
	bh=AurWwft0/kG2VXE48L1u4X8kP0ymfZEYEf/HqYpJ1ew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NLmpCmZYYhuXPbYd4jQm3g2ZWJwOzF/PrmGmhFPRqp6I12nIUYGnKEclge6u9rV9+
	 T7dvF92Wd2XlVjuV/tVpnCN0412Uu68zHguZIPKBnCSBox9aCzwbTu+NbJefPYFtcD
	 SkkVgTbTLETNPrsESvp+a2NvVVGi+N32REPbH8kBrqN4wLQKrzYl0f3wanCaggUa7c
	 H79mo4xDFllMBJgJ4couSj6tBE7QELPMWX90E1cmf1s/VCIfmOkUUmX2jN/ot5KW84
	 KLNPZuyn/ysam38tXXd0GSqKmQreK45ZhO3kxnLxCrN4/atpY139U1d5HGrz+raYG8
	 i/fVABd3wFm0Q==
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459b3904fdeso12995e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:30:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGPsxPoCccvI5RBjZ0ciIPKAeu3qvDBt9ux2nu7xJCeJ3cpOr3fKhnHPcSkaC+KdCGUwbHOXh96RTcvQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgN+TGCI6RJhLoCrSCb17gC1CSdr4e+oDEqBsyurTY8vKfGJ9x
	K/zLYukuzFkU5uKUTERbwdktJlQRHu2DznTgamR0tfw9Px0ivs+/eydrOvzxbaf5FHd0nTSfP4b
	LpWioy7Fc31ReLeHZlxX85vGTrmK44gKC5yZjThFK
X-Google-Smtp-Source: AGHT+IG3PMiScD3qbIYh5VUh6lcYUbjTYVJUKBP49fdNfQWRFTwKG+WZIIFDl9jUb9q2WKH0ejwk8EEJYQ8uZXZ8ipw=
X-Received: by 2002:a05:600c:3111:b0:459:d7da:3179 with SMTP id
 5b1f17b1804b1-459e74c0f21mr296005e9.5.1754436613909; Tue, 05 Aug 2025
 16:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804172439.2331-1-ryncsn@gmail.com> <20250804172439.2331-2-ryncsn@gmail.com>
In-Reply-To: <20250804172439.2331-2-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 5 Aug 2025 16:30:02 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPY20cybaFqBXk34sEgZ8ydNOk7AoOtmNGLtdO3huzE-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwfQtbdLl-ZH8xY_rHbGNg2CrKCn-AyfB_UOtUyNCuCGMOEJxBOJsdu2Bk
Message-ID: <CAF8kJuPY20cybaFqBXk34sEgZ8ydNOk7AoOtmNGLtdO3huzE-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, swap: don't scan every fragment cluster
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good to me with minor nit picks on commit messages and comments.

Let me know if you will refresh a version or not.

Nit: I suggest the patch title use positive terms, something along the line=
s:
"Only scan one cluster in fragment list"
"Don't scan" seems to describe what the patch does not do rather than
what the patch does.

On Mon, Aug 4, 2025 at 10:24=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> Fragment clusters were mostly failing high order allocation already.
> The reason we scan it now is that a swap slot may get freed without
> releasing the swap cache, so a swap map entry will end up in HAS_CACHE
> only status, and the cluster won't be moved back to non-full or free
> cluster list.
>
> Usually this only happens for !SWP_SYNCHRONOUS_IO devices when the swap

Nit: Please clarify what "this" here means. I assume scanning fragment list=
s.
From the context it can almost mean "map entry will end up in HAS_CACHE".


> device usage is low (!vm_swap_full()) since swap will try to lazy free
> the swap cache.
>
> It's unlikely to cause any real issue. Fragmentation is only an issue
> when the device is getting full, and by  that time, swap will already
> be releasing the swap cache aggressively. And swap cache reclaim happens
> when the allocator scans a cluster too. Scanning one fragment cluster
> should be good enough to reclaim these pinned slots.
>
> And besides, only high order allocation requires iterating over a
> cluster list, order 0 allocation will succeed on the first attempt.
> And high order allocation failure isn't a serious problem.
>
> So the iteration of fragment clusters is trivial, but it will slow down
> mTHP allocation by a lot when the fragment cluster list is long.
> So it's better to drop this fragment cluster iteration design. Only
> scanning one fragment cluster is good enough in case any cluster is
> stuck in the fragment list; this ensures order 0 allocation never
> falls, and large allocations still have an acceptable success rate.
>
> Test on a 48c96t system, build linux kernel using 10G ZRAM, make -j48,
> defconfig with 768M cgroup memory limit, on top of tmpfs, 4K folio
> only:
>
> Before: sys time: 4407.28s
> After:  sys time: 4425.22s
>
> Change to make -j96, 2G memory limit, 64kB mTHP enabled, and 10G ZRAM:
>
> Before: sys time: 10230.22s  64kB/swpout: 1793044  64kB/swpout_fallback: =
17653
> After:  sys time: 5527.90s   64kB/swpout: 1789358  64kB/swpout_fallback: =
17813
>
> Change to 8G ZRAM:
>
> Before: sys time: 21929.17s  64kB/swpout: 1634681  64kB/swpout_fallback: =
173056
> After:  sys time: 6121.01s   64kB/swpout: 1638155  64kB/swpout_fallback: =
189562
>
> Change to use 10G brd device with SWP_SYNCHRONOUS_IO flag removed:
>
> Before: sys time: 7368.41s  64kB/swpout:1787599  swpout_fallback: 0
> After:  sys time: 7338.27s  64kB/swpout:1783106  swpout_fallback: 0
>
> Change to use 8G brd device with SWP_SYNCHRONOUS_IO flag removed:
>
> Before: sys time: 28139.60s 64kB/swpout:1645421  swpout_fallback: 148408
> After:  sys time: 8941.90s  64kB/swpout:1592973  swpout_fallback: 265010
>
> The performance is a lot better and large order allocation failure rate
> is only very slightly higher or unchanged.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/swap.h |  1 -
>  mm/swapfile.c        | 30 ++++++++----------------------
>  2 files changed, 8 insertions(+), 23 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 2fe6ed2cc3fd..a060d102e0d1 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -310,7 +310,6 @@ struct swap_info_struct {
>                                         /* list of cluster that contains =
at least one free slot */
>         struct list_head frag_clusters[SWAP_NR_ORDERS];
>                                         /* list of cluster that are fragm=
ented or contented */
> -       atomic_long_t frag_cluster_nr[SWAP_NR_ORDERS];

Nit: please have some comment in the commit log that why remove the
frag_cluster_nr counter.
I feel this change can be split out from the main change of this
patch. The main performance improvement is from only scanning one
fragment cluster rather than the full list right? Delete the counter
helps, but in a much smaller number.

Chris

