Return-Path: <linux-kernel+bounces-759190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A90B1D9E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84518189CB8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDCE25D549;
	Thu,  7 Aug 2025 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CuyGTcNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A772B2DA;
	Thu,  7 Aug 2025 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576654; cv=none; b=e1+ZaMvu+jyEbh1IHdh8pY0sG/+3EqY3ov0XNuK9xYsxjOCJZzlA2vDKUqUFWoqAj7Y0oVpt6XOg+5l+e9gGlKiEKab6cJ1SbQA0VMz97aO7YVIXZyF/yUBSr353Ef1Ik3OaQ8ihm/jlNVMXKUoksUF8uTL3W05BfYfNtwqpRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576654; c=relaxed/simple;
	bh=3147mCzUDBc1B+hoOJzDTLpUzmPCJflpq7Pn7DUh6qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXWLKJ1He9JnQMCWVw2OnnABvKG5lXPbqLGwc+sUpF1EfwI/9uFKsAK/UFio/FBY6D0i2oe1POxLAGWySX03uGYjAFiUVwE65rtRDTk/Ew+5bkck19QtrIqj+PvrrSBLs0UwahSSBZDUJnAlj8uNNM3rafEdOVJMEY+RQTxj4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CuyGTcNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E87C4CEEB;
	Thu,  7 Aug 2025 14:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754576653;
	bh=3147mCzUDBc1B+hoOJzDTLpUzmPCJflpq7Pn7DUh6qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CuyGTcNUBXr8BfDjkDV9hpHs2YgJ7scoqV4R2Kg0FBe0uHRYtzZEnCwCGB/IGM6V8
	 rasZLjMkB26E5d6xqcfd1S7traXJs5eksjWXGHUGIT4ubyA8tx8VMy5LpIkiQfrMNP
	 9YJFu4FIn8VU/Naa2eXYD3dgXrno9vSvc3N0DsUU=
Date: Thu, 7 Aug 2025 15:24:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: liuqiqi@kylinos.cn
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-57884  patch review feedback
 (https://lore.kernel.org/linux-cve-announce/2025011510-CVE-2024-57884-4cf8@gregkh/#R)
Message-ID: <2025080744-buckskin-triumph-2f79@gregkh>
References: <2025011510-CVE-2024-57884-4cf8@gregkh>
 <20250807130515.1445117-1-liuqiqi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807130515.1445117-1-liuqiqi@kylinos.cn>

On Thu, Aug 07, 2025 at 09:05:15PM +0800, liuqiqi@kylinos.cn wrote:
> CVE-2024-57884  patch fixes  mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim() modify as follows
> @@ -342,7 +342,14 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>  	if (get_nr_swap_pages() > 0)
>  		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>  			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
> -
> +	/*
> +	 * If there are no reclaimable file-backed or anonymous pages,
> +	 * ensure zones with sufficient free pages are not skipped.
> +	 * This prevents zones like DMA32 from being ignored in reclaim
> +	 * scenarios where they can still help alleviate memory pressure.
> +	 */
> +	if (nr == 0)
> +		nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
>  	return nr;
>  }
> However, should_reclaim_retry() function calls zone_reclaimable_pages to count free pages. When nr is 0, it double-counts NR_FREE_PAGES. This seems to cause inaccurate page statistics, right?
> static inline bool
> should_reclaim_retry(gfp_t gfp_mask, unsigned order,
> 		     struct alloc_context *ac, int alloc_flags,
> 		     bool did_some_progress, int *no_progress_loops)
> {
> ......
> 
> 		available = reclaimable = zone_reclaimable_pages(zone);
> 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
> 
> 		/*
> 		 * Would the allocation succeed if we reclaimed all
> 		 * reclaimable pages?
> 		 */
> 		wmark = __zone_watermark_ok(zone, order, min_wmark,
> 				ac->highest_zoneidx, alloc_flags, available);
> 
> compaction_zonelist_suitable() function has the same problem.
> bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
> 		int alloc_flags)
> {
> ......
> 		available = zone_reclaimable_pages(zone) / order;
> 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
> 		if (__compaction_suitable(zone, order, min_wmark_pages(zone),
> 					  ac->highest_zoneidx, available))
> 
> If this is problematic, can it be modified as follows:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6417,7 +6417,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
>                 return true;
>  
>         for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
> -               if (!zone_reclaimable_pages(zone))
> +               if (!zone_reclaimable_pages(zone) || !(zone_page_state_snapshot(zone, NR_FREE_PAGES)))
>                         continue;
> 
> Signed-off-by: liuqiqi <liuqiqi@kylinos.cn>

I have no idea what you are asking about or wishing to see change.
Please read the kernel documentation for how to send a proper patch.

thanks,

greg k-h

