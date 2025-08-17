Return-Path: <linux-kernel+bounces-772609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C457B294D3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28AB5E0DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA9027453;
	Sun, 17 Aug 2025 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="n3PyGRtm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30181E47BA
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755457218; cv=none; b=N79JCFzL7hQOXjMN5z4VeSDYyJvMFJ2niMP2V7s3YHKsxa5jM0L506RF1oDvdTFf2h6e6AtmrnFwaI3bO+aeE2his2Q2jOAkfzY87+g4wcHv1327oqlndUVRr3UU4zjvtjA0xLgIdxEYzaT4mECXGr9mdgcKTtJtt7DBYxgR2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755457218; c=relaxed/simple;
	bh=csRlLWwAyxG0z9swGUI1LX969xN6gyudBnqkJnmj/TI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DhZl2toxYaaC8g3avsknXPyy0squClczmYEYnmU0SCvPIT6y8rr1J1r4WaujH4febUYm3cJWhvQtkdAxn3JcrOqPlTaDlfkeI3pXSDj4YQYezv3R4EkAp/TR1z0kTvwWHoA9xb4ltYVlnJYxpWmRrZd/z6wS8nwmTvOKVjLnutM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n3PyGRtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3833DC4CEEB;
	Sun, 17 Aug 2025 19:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755457217;
	bh=csRlLWwAyxG0z9swGUI1LX969xN6gyudBnqkJnmj/TI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n3PyGRtmeAXUTAe/pUJ76L1k5xR1uEZ934ueomG3TwPMOeKePCAseCwTWc9NkFZUb
	 6JTxGToVVVORz5Mh0kc0u6CAlLsBnepzuhrWVHc2vhvivsRsoCe+lMSm2CPkKPW8Cx
	 jYS/+9cd3z4UZisvN9BrPaPDyPLdeL0sF/PFHaqY=
Date: Sun, 17 Aug 2025 12:00:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: liuqiqi@kylinos.cn
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:fix duplicate accounting of free pages in
 should_reclaim_retry()
Message-Id: <20250817120016.8dcc091c5b7114d6993a29ae@linux-foundation.org>
In-Reply-To: <20250812070210.1624218-1-liuqiqi@kylinos.cn>
References: <20250812070210.1624218-1-liuqiqi@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 15:02:10 +0800 liuqiqi@kylinos.cn wrote:

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

Thanks.  Does this have any significant runtime effects?

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

