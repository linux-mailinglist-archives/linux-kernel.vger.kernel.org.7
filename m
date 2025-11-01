Return-Path: <linux-kernel+bounces-881113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 809D3C277C6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 05:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E5024E2C6C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 04:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0228725B;
	Sat,  1 Nov 2025 04:51:48 +0000 (UTC)
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE1C2FB
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761972707; cv=none; b=pEmphOsPOOrtc9ChJ6fxuzXAucuT+kn89SNgT3EMX8jcEaWjZ9SwGWbsNm+2c0Jzs5o4cbQl+w5Fs7mHg4ueJ4UVxasoO+Y57Gxw9RT/wTHUmPFeHDSD6TM0uPSthszPrg+ZSSlJqrVG8DFaBkSAB1r3AcVym+aXl+SAV8MJqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761972707; c=relaxed/simple;
	bh=5Rrd59PenmFjOUN1BQvqDAW4qD3tPAEBgYjwKBsx9do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/nsuEUHHG/lhJOwFfpvpPzCgFZHqFTesfrx8feKpBEiVbGD/bYP8AIa7igx3QO5SPbt6GpIVOg/cuQuyrKjdVlixx8nMcZFpY9G4CexMBpWjtpM+YNpyaqGFxhThQekQnTUWYvyZ2YguX6ylytrgNUCUFX+wRm3sv6DuYTrens=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 1 Nov 2025 13:51:41 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 1 Nov 2025 13:51:41 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 14/19] mm, swap: sanitize swap entry management workflow
Message-ID: <aQWR3fK/GtTkx0kX@yjaykim-PowerEdge-T330>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-14-3d43f3b6ec32@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-swap-table-p2-v1-14-3d43f3b6ec32@tencent.com>

On Wed, Oct 29, 2025 at 11:58:40PM +0800, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>

Hello Kairui!

> The current swap entry allocation/freeing workflow has never had a clear
> definition. This makes it hard to debug or add new optimizations.
> 
> This commit introduces a proper definition of how swap entries would be
> allocated and freed. Now, most operations are folio based, so they will
> never exceed one swap cluster, and we now have a cleaner border between
> swap and the rest of mm, making it much easier to follow and debug,
> especially with new added sanity checks. Also making more optimization
> possible.
> 
> Swap entry will be mostly allocated and free with a folio bound.
> The folio lock will be useful for resolving many swap ralated races.
> 
> Now swap allocation (except hibernation) always starts with a folio in
> the swap cache, and gets duped/freed protected by the folio lock:
> 
> - folio_alloc_swap() - The only allocation entry point now.
>   Context: The folio must be locked.
>   This allocates one or a set of continuous swap slots for a folio and
>   binds them to the folio by adding the folio to the swap cache. The
>   swap slots' swap count start with zero value.
> 
> - folio_dup_swap() - Increase the swap count of one or more entries.
>   Context: The folio must be locked and in the swap cache. For now, the
>   caller still has to lock the new swap entry owner (e.g., PTL).
>   This increases the ref count of swap entries allocated to a folio.
>   Newly allocated swap slots' count has to be increased by this helper
>   as the folio got unmapped (and swap entries got installed).
> 
> - folio_put_swap() - Decrease the swap count of one or more entries.
>   Context: The folio must be locked and in the swap cache. For now, the
>   caller still has to lock the new swap entry owner (e.g., PTL).
>   This decreases the ref count of swap entries allocated to a folio.
>   Typically, swapin will decrease the swap count as the folio got
>   installed back and the swap entry got uninstalled
> 
>   This won't remove the folio from the swap cache and free the
>   slot. Lazy freeing of swap cache is helpful for reducing IO.
>   There is already a folio_free_swap() for immediate cache reclaim.
>   This part could be further optimized later.
> 
> The above locking constraints could be further relaxed when the swap
> table if fully implemented. Currently dup still needs the caller
> to lock the swap entry container (e.g. PTL), or a concurrent zap
> may underflow the swap count.
> 
> Some swap users need to interact with swap count without involving folio
> (e.g. forking/zapping the page table or mapping truncate without swapin).
> In such cases, the caller has to ensure there is no race condition on
> whatever owns the swap count and use the below helpers:
> 
> - swap_put_entries_direct() - Decrease the swap count directly.
>   Context: The caller must lock whatever is referencing the slots to
>   avoid a race.
> 
>   Typically the page table zapping or shmem mapping truncate will need
>   to free swap slots directly. If a slot is cached (has a folio bound),
>   this will also try to release the swap cache.
> 
> - swap_dup_entry_direct() - Increase the swap count directly.
>   Context: The caller must lock whatever is referencing the entries to
>   avoid race, and the entries must already have a swap count > 1.
> 
>   Typically, forking will need to copy the page table and hence needs to
>   increase the swap count of the entries in the table. The page table is
>   locked while referencing the swap entries, so the entries all have a
>   swap count > 1 and can't be freed.
> 
> Hibernation subsystem is a bit different, so two special wrappers are here:
> 
> - swap_alloc_hibernation_slot() - Allocate one entry from one device.
> - swap_free_hibernation_slot() - Free one entry allocated by the above
> helper.

During the code review, I found something to be verified.
It is not directly releavant your patch, 
I send the email for checking it right and possible fix on this patch.

on the swap_alloc_hibernation_slot function
nr_swap_pages is decreased. but as I think it is decreased on swap_range_alloc.

The nr_swap_pages are decremented as the callflow as like the below.

cluster_alloc_swap_entry -> alloc_swap_scan_cluster
-> closter_alloc_range -> swap_range_alloc

Introduced on
4f78252da887ee7e9d1875dd6e07d9baa936c04f
mm: swap: move nr_swap_pages counter decrement  from folio_alloc_swap() to swap_range_alloc()

 #ifdef CONFIG_HIBERNATION
 /* Allocate a slot for hibernation */
 swp_entry_t swap_alloc_hibernation_slot(int type)
 {
....
                       local_unlock(&percpu_swap_cluster.lock);
                        if (offset) {
                                entry = swp_entry(si->type, offset);
                                atomic_long_dec(&nr_swap_pages); // here


Thank you,
Youngjun Park

