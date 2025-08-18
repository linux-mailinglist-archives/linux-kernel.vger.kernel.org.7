Return-Path: <linux-kernel+bounces-772748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC591B2971A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547351964E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498E92571B9;
	Mon, 18 Aug 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1W8EUmg"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2649325744D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755484767; cv=none; b=HVL4H2y2O+o56BLusty1Rh/45wCRN2tvjH2HANFx994i8mvvF6gwuipxWGM3n5S9snPun+Uh8UdFp4Gas6W6ninUPj0xZQcVSNlGrFOvPO23QYs4L7XBVMSxnHvtzUY5x3vw8yRxTZOaDxv4Mm5WEWWGur7ODrWtaWrOKAAHdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755484767; c=relaxed/simple;
	bh=xLTu8Tf6taw9EUdqb9ArOi8PuQjvysLy87QtVmY7UeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1DEE2FKj7CMEkAIARAe8fD4BKTeceSSWE56tB9415nkHIqRUcBBG+XkYj9NcGfqs6K9otmyg+FCOaXmn/sRlhxGGG72UvfFhZ62NV3Dm3Ma0p7Y+YtVw1SjVx6GyEH5YjFf47nvMR3Lq5A4OXH32XMrfXpdQxOnJIOCstqjMY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m1W8EUmg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b365c8a8-efce-494d-b57d-b0aa334d73ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755484761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KGmZRweKUDZ2JbdZthO63Ztp0At0JtBfciRWpCzRtA=;
	b=m1W8EUmgYYFK5ejswzI+sIVEQVjMaWZahYjv3dXqmBZSBnoCZ91vRWABw10wfZz9EbH/dd
	ac+eXLjREpFMV7lHKnLY9kMv34hcXFHcZ2fx/FnacQadIjNsSnf9l1pgOkJbH/6WZZrb5U
	V0qm9GzvjYfxliV//Yar8DDNOTp7CVs=
Date: Mon, 18 Aug 2025 10:39:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm:fix duplicate accounting of free pages in
 should_reclaim_retry()
To: liuqiqi@kylinos.cn, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250812070210.1624218-1-liuqiqi@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <20250812070210.1624218-1-liuqiqi@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/8/12 15:02, liuqiqi@kylinos.cn 写道:
> From: liuqiqi <liuqiqi@kylinos.cn>
>
> In the zone_reclaimable_pages() function, if the page counts for
> NR_ZONE_INACTIVE_FILE, NR_ZONE_ACTIVE_FILE, NR_ZONE_INACTIVE_ANON,
> and NR_ZONE_ACTIVE_ANON are all zero,
> the function returns the number of free pages as the result.
>
> In this case, when should_reclaim_retry() calculates reclaimable pages,
> it will inadvertently double-count the free pages in its accounting.
>
> static inline bool
> should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>                      struct alloc_context *ac, int alloc_flags,
>                      bool did_some_progress, int *no_progress_loops)
> {
>         ...
>                 available = reclaimable = zone_reclaimable_pages(zone);
>                 available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
A "fixes" should be added here.                                                                                 
Fixes: 6aaced5abd32 ("mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()")
Reviewed-by: Ye Liu <liuye@kylinos.cn>
> Signed-off-by: liuqiqi <liuqiqi@kylinos.cn>
> ---
>  mm/vmscan.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 34410d24dc15..a9aaefdba7a2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -393,14 +393,7 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>  	if (can_reclaim_anon_pages(NULL, zone_to_nid(zone), NULL))
>  		nr += zone_page_state_snapshot(zone, NR_ZONE_INACTIVE_ANON) +
>  			zone_page_state_snapshot(zone, NR_ZONE_ACTIVE_ANON);
> -	/*
> -	 * If there are no reclaimable file-backed or anonymous pages,
> -	 * ensure zones with sufficient free pages are not skipped.
> -	 * This prevents zones like DMA32 from being ignored in reclaim
> -	 * scenarios where they can still help alleviate memory pressure.
> -	 */
> -	if (nr == 0)
> -		nr = zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +
>  	return nr;
>  }
>  
> @@ -6417,7 +6410,7 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
>  		return true;
>  
>  	for_each_managed_zone_pgdat(zone, pgdat, i, ZONE_NORMAL) {
> -		if (!zone_reclaimable_pages(zone))
> +		if (!zone_reclaimable_pages(zone) && zone_page_state_snapshot(zone, NR_FREE_PAGES))
>  			continue;
>  
>  		pfmemalloc_reserve += min_wmark_pages(zone);

-- 
Thanks,
Ye Liu


