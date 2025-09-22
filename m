Return-Path: <linux-kernel+bounces-826582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D3B8ED9C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8950C173C46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF232ECD37;
	Mon, 22 Sep 2025 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r3K7dwil"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32024886A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511271; cv=none; b=XDOFYlyHmF+lk22v8USAcENVt4F7UXs7dueiaz/l175bb60lWXAvzJMYvIUuOpcSSj/UWKvFnFO/inu2Bvc2f2EL7Qr4eA3MdAwkex68jyKFzA+0J0DrEbA7BxE60Uwj0x7lyZB9GhMzyIaQdjaz1zsF0Ki1UHhsmiblzPZlLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511271; c=relaxed/simple;
	bh=7/AuCQHhJ7zokt309WTcBj0n5rvQPYkKt88ezeqHdeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FLk66w2EqyBdNqm3GmE5ZOW41QKuUBDCQPDUGXMfu9ZaBnNukFEcSOA6mIL4An7n/UC5z5HocNVLzynbyN4bJJcyFDnlCF0Xt22ieKnnYFufqv31nwgIxLyJmJIiFJOSNZvHpR2shRZyMoO8frDp9B3IzkmB/pXuxQB7XrGqAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r3K7dwil; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758511260; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ixrh/iVBsgE1vkoJFlHD/3G5r4MUeYbHEFcICJyE87Y=;
	b=r3K7dwilxmPqVeGKZYGPXtWBdww9JMphb//Vwh0/a2GQ7GxGUB5cXBnMPY2mHg6q/52350KAiz+0aiDXWiY2k03cmO+m02m9WYO/ajdj6jKgrR9TEvqSFoV4WvEkuNxzoWTsbkD/0gjGS8kqxI5QCFpTM3R7UG7TPqIv8XX3qfg=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WoRD3UW_1758511258 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Sep 2025 11:20:59 +0800
Message-ID: <29d9fa8a-5ff2-47f3-8503-fe3032097e5e@linux.alibaba.com>
Date: Mon, 22 Sep 2025 11:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 5/5] mm/rmap: Improve mlock tracking for large folios
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-6-kirill@shutemov.name>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250919124036.455709-6-kirill@shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/19 20:40, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The kernel currently does not mlock large folios when adding them to
> rmap, stating that it is difficult to confirm that the folio is fully
> mapped and safe to mlock it.
> 
> This leads to a significant undercount of Mlocked in /proc/meminfo,
> causing problems in production where the stat was used to estimate
> system utilization and determine if load shedding is required.
> 
> However, nowadays the caller passes a number of pages of the folio that
> are getting mapped, making it easy to check if the entire folio is
> mapped to the VMA.
> 
> mlock the folio on rmap if it is fully mapped to the VMA.
> 
> Mlocked in /proc/meminfo can still undercount, but the value is closer
> the truth and is useful for userspace.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   mm/rmap.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 482e6504fa88..6e09956670f4 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1462,12 +1462,12 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
>   	}
>   
>   	/*
> -	 * For large folio, only mlock it if it's fully mapped to VMA. It's
> -	 * not easy to check whether the large folio is fully mapped to VMA
> -	 * here. Only mlock normal 4K folio and leave page reclaim to handle
> -	 * large folio.
> +	 * Only mlock it if the folio is fully mapped to the VMA.
> +	 *
> +	 * Partially mapped folios can be split on reclaim and part outside
> +	 * of mlocked VMA can be evicted or freed.
>   	 */
> -	if (!folio_test_large(folio))
> +	if (folio_nr_pages(folio) == nr_pages)
>   		mlock_vma_folio(folio, vma);
>   }
>   
> @@ -1603,8 +1603,13 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>   	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
>   	__folio_mod_stat(folio, nr, nr_pmdmapped);
>   
> -	/* See comments in folio_add_anon_rmap_*() */
> -	if (!folio_test_large(folio))
> +	/*
> +	 * Only mlock it if the folio is fully mapped to the VMA.
> +	 *
> +	 * Partially mapped folios can be split on reclaim and part outside
> +	 * of mlocked VMA can be evicted or freed.
> +	 */
> +	if (folio_nr_pages(folio) == nr_pages)
>   		mlock_vma_folio(folio, vma);
>   }
>   


