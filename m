Return-Path: <linux-kernel+bounces-890005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3EC3F0C3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE6E2349D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9752F3002BC;
	Fri,  7 Nov 2025 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZnpX6ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D43002AF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505951; cv=none; b=kLlmAu6M9JLSe3koSV4c0uSap0Sr8IHDbxQO+3IE8Lc1usVTi2xGgZp4SSsu3+ZkWj4is4INV1JcMZAOTvC4UmLIxojItJUGfwOMxpUda65QiIYIyxvAN+rhrCQeb9cLIl/qkEpHY2q0eBBqMlEMquuzt+YnIILgJL+C051OFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505951; c=relaxed/simple;
	bh=FGs9k1s29rarNJs9NqYrMfUHU4lrNN1E8lsc4dNVyTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IYvGVIJ6U2+KEbDimgXSYsWZPgeBI2UKt7L3erVaGiOBE1v1bHOOiP2t4q/hMYVpQ/9GMP9HBy8mmupfyw6YZPpuewSCmGXr/yuTUT/j+fPFhQYnLCw8q60toV0OtbVpNrTcdE+SfyW7GL8BDewYU49sKFQdlEVcSTxPpi3Zciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZnpX6ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0809CC116B1;
	Fri,  7 Nov 2025 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762505950;
	bh=FGs9k1s29rarNJs9NqYrMfUHU4lrNN1E8lsc4dNVyTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KZnpX6ml6uRRB2JFyzIFBDCgIXhESmUP/cxrsm49i/lOlJ+Dmr7s61hw/h6N29KPe
	 lMw4g1mRCChOX+R7kmsd8VEpF7Xpuqmpiylml1zoJtrjPAMQJGAyt1/5lJ43p1+LrA
	 x9lGupxQ25fO4M6xU6hEKchg2YzbKMbqlgMzcTsV6/QDYkAwH47Qx4+1A/kK2JPC5m
	 43KPjUkR3sCN8c2sVaQ38P5t0sq42rzYDjo71UUeq4UtHeEenI/Xi/iXHK3fdaptMZ
	 2s0eaGEtUmzmo96Lll4REI1O/zG0vAueoBa+Nxnop+c6QyGdcgc49z5zXKnEAv6Y0g
	 3b2+qmUpdw5+A==
Message-ID: <77b2ae9c-2700-4c7a-ae45-323af6beaff3@kernel.org>
Date: Fri, 7 Nov 2025 09:59:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] mm, folio_zero_user: support clearing page ranges
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-7-ankur.a.arora@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251027202109.678022-7-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 21:21, Ankur Arora wrote:
> Clear contiguous page ranges in folio_zero_user() instead of clearing
> a page-at-a-time. This enables CPU specific optimizations based on
> the length of the region.
> 
> Operating on arbitrarily large regions can lead to high preemption
> latency under cooperative preemption models. So, limit the worst
> case preemption latency via architecture specified PAGE_CONTIG_NR
> units.
> 
> The resultant performance depends on the kinds of optimizations
> available to the CPU for the region being cleared. Two classes of
> of optimizations:
> 
>    - clearing iteration costs can be amortized over a range larger
>      than a single page.
>    - cacheline allocation elision (seen on AMD Zen models).
> 
> Testing a demand fault workload shows an improved baseline from the
> first optimization and a larger improvement when the region being
> cleared is large enough for the second optimization.
> 
> AMD Milan (EPYC 7J13, boost=0, region=64GB on the local NUMA node):
> 
>   $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5
> 
>                      page-at-a-time     contiguous clearing      change
> 
>                    (GB/s  +- %stdev)     (GB/s  +- %stdev)
> 
>     pg-sz=2MB       12.92  +- 2.55%        17.03  +-  0.70%       + 31.8%	preempt=*
> 
>     pg-sz=1GB       17.14  +- 2.27%        18.04  +-  1.05% [#]   +  5.2%	preempt=none|voluntary
>     pg-sz=1GB       17.26  +- 1.24%        42.17  +-  4.21%       +144.3%	preempt=full|lazy
> 
> [#] AMD Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
> allocation, which is larger than ARCH_PAGE_CONTIG_NR, so
> preempt=none|voluntary see no improvement on the pg-sz=1GB.
> 
> Also as mentioned earlier, the baseline improvement is not specific to
> AMD Zen platforms. Intel Icelakex (pg-sz=2MB|1GB) sees a similar
> improvement as the Milan pg-sz=2MB workload above (~30%).
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
> Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>   include/linux/mm.h |  6 ++++++
>   mm/memory.c        | 42 +++++++++++++++++++++---------------------
>   2 files changed, 27 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecbcb76df9de..02db84667f97 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3872,6 +3872,12 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>   				unsigned int order) {}
>   #endif	/* CONFIG_DEBUG_PAGEALLOC */
>   
> +#ifndef ARCH_PAGE_CONTIG_NR
> +#define PAGE_CONTIG_NR	1
> +#else
> +#define PAGE_CONTIG_NR	ARCH_PAGE_CONTIG_NR
> +#endif

The name is a bit misleading. We need something that tells us that this 
is for patch-processing (clearing? maybe alter copying?) contig pages. 
Likely spelling out that this is for the non-preemptible case only.

I assume we can drop the "CONTIG", just like clear_pages() doesn't 
contain it etc.

CLEAR_PAGES_NON_PREEMPT_BATCH

PROCESS_PAGES_NON_PREEMPT_BATCH

Can you remind me again why this is arch specific, and why the default 
is 1 instead of, say 2,4,8 ... ?

> +
>   #ifndef __HAVE_ARCH_CLEAR_PAGES
>   /**
>    * clear_pages() - clear a page range for kernel-internal use.
> diff --git a/mm/memory.c b/mm/memory.c
> index 74b45e258323..7781b2aa18a8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7144,40 +7144,40 @@ static inline int process_huge_page(
>   	return 0;
>   }
>   
> -static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
> -				unsigned int nr_pages)
> +/*
> + * Clear contiguous pages chunking them up when running under
> + * non-preemptible models.
> + */
> +static void clear_contig_highpages(struct page *page, unsigned long addr,
> +				   unsigned int npages)
>   {
> -	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(folio));
> -	int i;
> +	unsigned int i, count, unit;
>   
> -	might_sleep();
> -	for (i = 0; i < nr_pages; i++) {
> +	unit = preempt_model_preemptible() ? npages : PAGE_CONTIG_NR;
> +
> +	for (i = 0; i < npages; ) {
> +		count = min(unit, npages - i);
> +		clear_user_highpages(page + i,
> +				     addr + i * PAGE_SIZE, count);
> +		i += count;

Why not

for (i = 0; i < nr_pages; i += count) {

Also, I would leave the cond_resched(); where it was (before the 
invocation) to perform as little change as possible.

>   		cond_resched();
> -		clear_user_highpage(folio_page(folio, i), addr + i * PAGE_SIZE);
>   	}
>   }
>   
> -static int clear_subpage(unsigned long addr, int idx, void *arg)
> -{
> -	struct folio *folio = arg;
> -
> -	clear_user_highpage(folio_page(folio, idx), addr);
> -	return 0;
> -}
> -
>   /**
>    * folio_zero_user - Zero a folio which will be mapped to userspace.
>    * @folio: The folio to zero.
> - * @addr_hint: The address will be accessed or the base address if uncelar.
> + * @addr_hint: The address accessed by the user or the base address.
> + *
> + * Uses architectural support for clear_pages() to zero page extents
> + * instead of clearing page-at-a-time.
>    */
>   void folio_zero_user(struct folio *folio, unsigned long addr_hint)
>   {
> -	unsigned int nr_pages = folio_nr_pages(folio);
> +	unsigned long base_addr = ALIGN_DOWN(addr_hint, folio_size(folio));
>   
> -	if (unlikely(nr_pages > MAX_ORDER_NR_PAGES))
> -		clear_gigantic_page(folio, addr_hint, nr_pages);
> -	else
> -		process_huge_page(addr_hint, nr_pages, clear_subpage, folio);
> +	clear_contig_highpages(folio_page(folio, 0),
> +				base_addr, folio_nr_pages(folio));
>   }
>   
>   static int copy_user_gigantic_page(struct folio *dst, struct folio *src,


-- 
Cheers

David

