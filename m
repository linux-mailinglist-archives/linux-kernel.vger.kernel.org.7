Return-Path: <linux-kernel+bounces-870907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5991C0BF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 404A94EE89B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E5C2DC34E;
	Mon, 27 Oct 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PLIKYE15"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7AE9478;
	Mon, 27 Oct 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546537; cv=none; b=ezH9x/ynm93sLKImLwhtbTpLMFZwKxGz0O589G+GWgCZj2vlx9dwA/w9WwgSsva//EiTU6LxHbTlQbd8IJN0puiuqB4Bqkm4TsD0R2VPgEaSZg3l9BnPw4LPhHP6qFQtTaNuwH8L+yKgWcmlVRN2B+XhN0PYOQ83MfysWdGW2DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546537; c=relaxed/simple;
	bh=Z1W33HuZk2aG2C4J8ym0e4tPr7p8iUn/opzyXIyqM5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNELMqCLJpTC6S1TnJqmvzHalDXGj9/tTmHAOdhHLOP9q0PgXd1Uwzi9zPb60rULDmL3FXR2TQW6YISDjjIz+SQT4GocHsnF272uWoZ9gpQ60tvk2+rAc/MF2jPXDmwcwxsP2TeomBNYYxr7CuOqpTjnbRWfFoLlRWpVL9tsVPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PLIKYE15; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761546531; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u/Mdwh94NP58Pqt0bMM/980ITImsajkPeAqPd9JRQc4=;
	b=PLIKYE157XdehVAFuuSfqqV3MfVblXlvJ1dXnJDA1G4iHGhLU6/z3cKsozNt1yu2C5i+9orf+1CrOvcOEd+7cFHq9QrxDQqivwYDmndGAC6IcnJ+RkMofblTF72b5AzBaexfZVgkA86JPqgVsFD2S+L/MBZDGxE+35dddNP/68Q=
Received: from 30.74.144.189(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wr092Mq_1761546525 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 14:28:47 +0800
Message-ID: <3d70cc1e-6508-417c-87a5-8fe6de10f5ac@linux.alibaba.com>
Date: Mon, 27 Oct 2025 14:28:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 12/15] khugepaged: Introduce mTHP collapse
 support
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-13-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251022183717.70829-13-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/23 02:37, Nico Pache wrote:
> During PMD range scanning, track occupied pages in a bitmap. If mTHPs are
> enabled we remove the restriction of max_ptes_none during the scan phase
> to avoid missing potential mTHP candidates.
> 
> Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
> and determine the best eligible order for the collapse. A stack struct is
> used instead of traditional recursion. The algorithm splits the bitmap
> into smaller chunks to find the best fit mTHP.  max_ptes_none is scaled by
> the attempted collapse order to determine how "full" an order must be
> before being considered for collapse.
> 
> Once we determine what mTHP sizes fits best in that PMD range a collapse
> is attempted. A minimum collapse order of 2 is used as this is the lowest
> order supported by anon memory.
> 
> mTHP collapses reject regions containing swapped out or shared pages.
> This is because adding new entries can lead to new none pages, and these
> may lead to constant promotion into a higher order (m)THP. A similar
> issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
> introducing at least 2x the number of pages, and on a future scan will
> satisfy the promotion condition once again. This issue is prevented via
> the collapse_allowable_orders() function.
> 
> Currently madv_collapse is not supported and will only attempt PMD
> collapse.
> 
> We can also remove the check for is_khugepaged inside the PMD scan as
> the collapse_max_ptes_none() function handles this logic now.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

I've tested this patch, and it works as expected. (Some nits are listed 
below)
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   include/linux/khugepaged.h |   2 +
>   mm/khugepaged.c            | 128 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 122 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index eb1946a70cff..179ce716e769 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -1,6 +1,8 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   #ifndef _LINUX_KHUGEPAGED_H
>   #define _LINUX_KHUGEPAGED_H
> +#define KHUGEPAGED_MIN_MTHP_ORDER	2
> +#define MAX_MTHP_BITMAP_STACK	(1UL << (ilog2(MAX_PTRS_PER_PTE) - KHUGEPAGED_MIN_MTHP_ORDER))
>   
>   #include <linux/mm.h>
>   
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 89a105124790..e2319bfd0065 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -93,6 +93,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>   
>   static struct kmem_cache *mm_slot_cache __ro_after_init;
>   
> +struct scan_bit_state {
> +	u8 order;
> +	u16 offset;
> +};
> +
>   struct collapse_control {
>   	bool is_khugepaged;
>   
> @@ -101,6 +106,13 @@ struct collapse_control {
>   
>   	/* nodemask for allocation fallback */
>   	nodemask_t alloc_nmask;
> +
> +	/*
> +	 * bitmap used to collapse mTHP sizes.
> +	 */
> +	 DECLARE_BITMAP(mthp_bitmap, HPAGE_PMD_NR);
> +	 DECLARE_BITMAP(mthp_bitmap_mask, HPAGE_PMD_NR);

Nit: please remove the extra spaces.

> +	struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_STACK];
>   };
>   
>   /**
> @@ -1357,6 +1369,85 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long pmd_address,
>   	return result;
>   }
>   
> +static void push_mthp_bitmap_stack(struct collapse_control *cc, int *top,
> +				   u8 order, u16 offset)
> +{
> +	cc->mthp_bitmap_stack[++*top] = (struct scan_bit_state)
> +		{ order, offset };
> +}
> +
> +/*
> + * collapse_scan_bitmap() consumes the bitmap that is generated during
> + * collapse_scan_pmd() to determine what regions and mTHP orders fit best.
> + *
> + * Each bit in the bitmap represents a single occupied (!none/zero) page.
> + * A stack structure cc->mthp_bitmap_stack is used to check different regions
> + * of the bitmap for collapse eligibility. We start at the PMD order and
> + * check if it is eligible for collapse; if not, we add two entries to the
> + * stack at a lower order to represent the left and right halves of the region.
> + *
> + * For each region, we calculate the number of set bits and compare it
> + * against a threshold derived from collapse_max_ptes_none(). A region is
> + * eligible if the number of set bits exceeds this threshold.
> + */
> +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
> +		int referenced, int unmapped, struct collapse_control *cc,
> +		bool *mmap_locked, unsigned long enabled_orders)
> +{
> +	u8 order, next_order;
> +	u16 offset, mid_offset;
> +	int num_chunks;
> +	int bits_set, threshold_bits;
> +	int top = -1;
> +	int collapsed = 0;
> +	int ret;
> +	struct scan_bit_state state;
> +	unsigned int max_none_ptes;

Nit: could you rearrange the order of variable definitions? Like reverse 
Christmas trees.

> +
> +	push_mthp_bitmap_stack(cc, &top, HPAGE_PMD_ORDER - KHUGEPAGED_MIN_MTHP_ORDER, 0);
> +
> +	while (top >= 0) {
> +		state = cc->mthp_bitmap_stack[top--];
> +		order = state.order + KHUGEPAGED_MIN_MTHP_ORDER;
> +		offset = state.offset;
> +		num_chunks = 1UL << order;

Nit: ‘num_chunks’ should be 'unsigned long'.

> +
> +		/* Skip mTHP orders that are not enabled */
> +		if (!test_bit(order, &enabled_orders))
> +			goto next_order;
> +
> +		max_none_ptes = collapse_max_ptes_none(order, !cc->is_khugepaged);
> +
> +		/* Calculate weight of the range */
> +		bitmap_zero(cc->mthp_bitmap_mask, HPAGE_PMD_NR);
> +		bitmap_set(cc->mthp_bitmap_mask, offset, num_chunks);
> +		bits_set = bitmap_weight_and(cc->mthp_bitmap,
> +					     cc->mthp_bitmap_mask, HPAGE_PMD_NR);
> +
> +		threshold_bits = (1UL << order) - max_none_ptes - 1;
> +
> +		/* Check if the region is eligible based on the threshold */
> +		if (bits_set > threshold_bits) {
> +			ret = collapse_huge_page(mm, address, referenced,
> +						 unmapped, cc, mmap_locked,
> +						 order, offset);
> +			if (ret == SCAN_SUCCEED) {
> +				collapsed += 1UL << order;
> +				continue;
> +			}
> +		}
> +
> +next_order:
> +		if (state.order > 0) {
> +			next_order = state.order - 1;
> +			mid_offset = offset + (num_chunks / 2);
> +			push_mthp_bitmap_stack(cc, &top, next_order, mid_offset);
> +			push_mthp_bitmap_stack(cc, &top, next_order, offset);
> +		}
> +	}
> +	return collapsed;
> +}
> +
>   static int collapse_scan_pmd(struct mm_struct *mm,
>   			     struct vm_area_struct *vma,
>   			     unsigned long start_addr, bool *mmap_locked,
> @@ -1364,11 +1455,15 @@ static int collapse_scan_pmd(struct mm_struct *mm,
>   {
>   	pmd_t *pmd;
>   	pte_t *pte, *_pte;
> +	int i;
>   	int result = SCAN_FAIL, referenced = 0;
> -	int none_or_zero = 0, shared = 0;
> +	int none_or_zero = 0, shared = 0, nr_collapsed = 0;
>   	struct page *page = NULL;
> +	unsigned int max_ptes_none;
>   	struct folio *folio = NULL;
>   	unsigned long addr;
> +	unsigned long enabled_orders;
> +	bool full_scan = true;
>   	spinlock_t *ptl;
>   	int node = NUMA_NO_NODE, unmapped = 0;
>   
> @@ -1378,16 +1473,29 @@ static int collapse_scan_pmd(struct mm_struct *mm,
>   	if (result != SCAN_SUCCEED)
>   		goto out;
>   
> +	bitmap_zero(cc->mthp_bitmap, HPAGE_PMD_NR);
>   	memset(cc->node_load, 0, sizeof(cc->node_load));
>   	nodes_clear(cc->alloc_nmask);
> +
> +	enabled_orders = collapse_allowable_orders(vma, vma->vm_flags, cc->is_khugepaged);
> +
> +	/*
> +	 * If PMD is the only enabled order, enforce max_ptes_none, otherwise
> +	 * scan all pages to populate the bitmap for mTHP collapse.
> +	 */
> +	if (cc->is_khugepaged && enabled_orders == _BITUL(HPAGE_PMD_ORDER))
> +		full_scan = false;
> +	max_ptes_none = collapse_max_ptes_none(HPAGE_PMD_ORDER, full_scan);
> +
>   	pte = pte_offset_map_lock(mm, pmd, start_addr, &ptl);
>   	if (!pte) {
>   		result = SCAN_PMD_NULL;
>   		goto out;
>   	}
>   
> -	for (addr = start_addr, _pte = pte; _pte < pte + HPAGE_PMD_NR;
> -	     _pte++, addr += PAGE_SIZE) {
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +		_pte = pte + i;
> +		addr = start_addr + i * PAGE_SIZE;
>   		pte_t pteval = ptep_get(_pte);
>   		if (is_swap_pte(pteval)) {
>   			++unmapped;
> @@ -1412,8 +1520,7 @@ static int collapse_scan_pmd(struct mm_struct *mm,
>   		if (pte_none_or_zero(pteval)) {
>   			++none_or_zero;
>   			if (!userfaultfd_armed(vma) &&
> -			    (!cc->is_khugepaged ||
> -			     none_or_zero <= khugepaged_max_ptes_none)) {
> +			    none_or_zero <= max_ptes_none) {
>   				continue;
>   			} else {
>   				result = SCAN_EXCEED_NONE_PTE;
> @@ -1461,6 +1568,8 @@ static int collapse_scan_pmd(struct mm_struct *mm,
>   			}
>   		}
>   
> +		/* Set bit for occupied pages */
> +		bitmap_set(cc->mthp_bitmap, i, 1);
>   		/*
>   		 * Record which node the original page is from and save this
>   		 * information to cc->node_load[].
> @@ -1517,9 +1626,12 @@ static int collapse_scan_pmd(struct mm_struct *mm,
>   out_unmap:
>   	pte_unmap_unlock(pte, ptl);
>   	if (result == SCAN_SUCCEED) {
> -		result = collapse_huge_page(mm, start_addr, referenced,
> -					    unmapped, cc, mmap_locked,
> -					    HPAGE_PMD_ORDER, 0);
> +		nr_collapsed = collapse_scan_bitmap(mm, start_addr, referenced, unmapped,
> +					      cc, mmap_locked, enabled_orders);
> +		if (nr_collapsed > 0)
> +			result = SCAN_SUCCEED;
> +		else
> +			result = SCAN_FAIL;
>   	}
>   out:
>   	trace_mm_khugepaged_scan_pmd(mm, folio, referenced,


