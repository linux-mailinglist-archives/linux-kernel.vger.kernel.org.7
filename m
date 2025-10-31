Return-Path: <linux-kernel+bounces-879519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE31C234BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3104E1C14
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A1B2D838F;
	Fri, 31 Oct 2025 05:40:36 +0000 (UTC)
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2933EC
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889236; cv=none; b=rYEcaGx9WLr9EgOOXKei8CHMveA6IBCRM+yDNOYCqNw1M2PyiGlk7XTDe4ZUH9hCienel98DwbB77g5YMlp57cnqxlYOTwSlG+JSza/IYNcrHLYD310VLFdd8GsLZqzSlD0pBg129GRfns/NCi5Jfc5G59EFs+dpw9CLRSZt7ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889236; c=relaxed/simple;
	bh=SJzAFZea1oiGOiw2zfv7EXCRA2xVycSzR9TjCgcnTXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d62fOepgPRAuUVTB2yrljes6cS4KpGMtxhWcUOAd8VdRijgulLhTjSVtIFsrLdjhX5nxXcmIWebkpcYPcK77keOGQBiXTEjRGqqze0uuYY53PsLuWFaD2aCF5rxuqhB9yQsk8KdC2QbiCMkD5dWswGkDmSUeUzu/UR2hCvo2QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 31 Oct 2025 14:25:29 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 31 Oct 2025 14:25:12 +0900
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
Subject: Re: [PATCH 10/19] mm, swap: consolidate cluster reclaim and check
 logic
Message-ID: <aQRIOMsAkDciWFw/@yjaykim-PowerEdge-T330>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
 <20251029-swap-table-p2-v1-10-3d43f3b6ec32@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029-swap-table-p2-v1-10-3d43f3b6ec32@tencent.com>

On Wed, Oct 29, 2025 at 11:58:36PM +0800, Kairui Song wrote:

> From: Kairui Song <kasong@tencent.com>
> 

Hello Kairu, great work on your patchwork. :)                                    
> Swap cluster cache reclaim requires releasing the lock, so some extra
> checks are needed after the reclaim. To prepare for checking swap cache
> using the swap table directly, consolidate the swap cluster reclaim and
> check the logic.
> 
> Also, adjust it very slightly. By moving the cluster empty and usable
> check into the reclaim helper, it will avoid a redundant scan of the
> slots if the cluster is empty.

This is Change 1

> And always scan the whole region during reclaim, don't skip slots
> covered by a reclaimed folio. Because the reclaim is lockless, it's
> possible that new cache lands at any time. And for allocation, we want
> all caches to be reclaimed to avoid fragmentation. And besides, if the
> scan offset is not aligned with the size of the reclaimed folio, we are
> skipping some existing caches.

This is Change 2

> There should be no observable behavior change, which might slightly
> improve the fragmentation issue or performance.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swapfile.c | 47 +++++++++++++++++++++++------------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d66141f1c452..e4c521528817 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -778,42 +778,50 @@ static int swap_cluster_setup_bad_slot(struct swap_cluster_info *cluster_info,
>  	return 0;
>  }
>  
> -static bool cluster_reclaim_range(struct swap_info_struct *si,
> -				  struct swap_cluster_info *ci,
> -				  unsigned long start, unsigned long end)
> +static unsigned int cluster_reclaim_range(struct swap_info_struct *si,
> +					  struct swap_cluster_info *ci,
> +					  unsigned long start, unsigned int order)
>  {
> +	unsigned int nr_pages = 1 << order;
> +	unsigned long offset = start, end = start + nr_pages;
>  	unsigned char *map = si->swap_map;
> -	unsigned long offset = start;
>  	int nr_reclaim;
>  
>  	spin_unlock(&ci->lock);
>  	do {
>  		switch (READ_ONCE(map[offset])) {
>  		case 0:
> -			offset++;
>  			break;
>  		case SWAP_HAS_CACHE:
>  			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
> -			if (nr_reclaim > 0)
> -				offset += nr_reclaim;
> -			else
> +			if (nr_reclaim < 0)
>  				goto out;
>  			break;
>  		default:
>  			goto out;
>  		}
> -	} while (offset < end);
> +	} while (++offset < end);

Change 2

>  out:
>  	spin_lock(&ci->lock);
> +
> +	/*
> +	 * We just dropped ci->lock so cluster could be used by another
> +	 * order or got freed, check if it's still usable or empty.
> +	 */
> +	if (!cluster_is_usable(ci, order))
> +		return SWAP_ENTRY_INVALID;
> +	if (cluster_is_empty(ci))
> +		return cluster_offset(si, ci);
> +

Change 1

>  	/*
>  	 * Recheck the range no matter reclaim succeeded or not, the slot
>  	 * could have been be freed while we are not holding the lock.
>  	 */
>  	for (offset = start; offset < end; offset++)
>  		if (READ_ONCE(map[offset]))
> -			return false;
> +			return SWAP_ENTRY_INVALID;
>  
> -	return true;
> +	return start;
>  }
>  
>  static bool cluster_scan_range(struct swap_info_struct *si,
> @@ -901,7 +909,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
>  	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
>  	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
>  	unsigned int nr_pages = 1 << order;
> -	bool need_reclaim, ret;
> +	bool need_reclaim;
>  
>  	lockdep_assert_held(&ci->lock);
>  
> @@ -913,20 +921,11 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
>  		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
>  			continue;
>  		if (need_reclaim) {
> -			ret = cluster_reclaim_range(si, ci, offset, offset + nr_pages);
> -			/*
> -			 * Reclaim drops ci->lock and cluster could be used
> -			 * by another order. Not checking flag as off-list
> -			 * cluster has no flag set, and change of list
> -			 * won't cause fragmentation.
> -			 */
> -			if (!cluster_is_usable(ci, order))
> -				goto out;
> -			if (cluster_is_empty(ci))
> -				offset = start;
> +			found = cluster_reclaim_range(si, ci, offset, order);
>  			/* Reclaim failed but cluster is usable, try next */
> -			if (!ret)

Part of Change 1 (apply return value change)

As I understand Change 1 just remove redudant checking.
But, I think another part changed also.
(maybe I don't fully understand comment or something)

cluster_reclaim_range can return SWAP_ENTRY_INVALID
if the cluster becomes unusable for the requested order. 
(!cluster_is_usable return SWAP_ENTRY_INVALID)
And it continues loop to the next offset for reclaim try.
Is this the intended behavior?

If this is the intended behavior, the comment:
    /* Reclaim failed but cluster is usable, try next */
might be a bit misleading, as the cluster could be unusable in this
failure case. Perhaps it could be updated to reflect this? 
Or I think any other thing need to be changed..? 
(cluster_is_usable function name change etc)

Thanks.
Youngjun Park

