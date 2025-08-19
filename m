Return-Path: <linux-kernel+bounces-775227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 809FAB2BCDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0890C18906FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D221DED49;
	Tue, 19 Aug 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gIDVPsX8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="joa3cD8D"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CBC222584
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594922; cv=none; b=tMpYbWbIEfbfaQq4ohD/yFiZNeyjMQ4IdIj+XumXteGbXuIGAKfwRjJfCh/ZAA/talrai6tSXF1IyQ+hPvb9l4v+naXbQe5KrV3tozw02FxyEAYiOTN73ryJYzm01vKPXczECrQyshAKHFVNQHILrxBFS1bzIT4jkhYEGg/dPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594922; c=relaxed/simple;
	bh=gNQRVZVTczw+ePTXVXH8Kpnbr+r1oSQLXSCIBBnbXCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBH2/alg9PtNRh6G9qeoBJ1RbpuuTXNVbqnYXZLP2lCpgxglAMdIdv5t+ot9bfNFwxZoKVLT5n5DZZB5okpmYYA9dcSZQ0YE+Z0sqkhOEjwqEPWLXCqF/F6ZjFtBzNoz/j0+4py3V3KAyifvyAV0JFGmyH3Io0IYYf3YIr7Mvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gIDVPsX8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=joa3cD8D; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA2897A0283;
	Tue, 19 Aug 2025 05:15:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 05:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1755594917; x=
	1755681317; bh=dgchzZYWazF9bA9Qn52CgjOynPGZcFtDF4chSUl865s=; b=g
	IDVPsX8nnuo+iurEbpVYwhbWa/H1TFhJ+sVs4d4JHnwCzY6H6nJGgVkDi5mcUqia
	d11i6PpNCYYcrV1K4QVQpRrRqcsun7m1LnYVGPeh5nGHZA+6Dwl3AtpR67HZLgqV
	EUS2t66QYqCRk9Xdf9OVAcsHA1Ov77Lvqz/87+lTDthHodo9TPRMmLrYAcrIMWKN
	qqdY/9qqcdAAZy4s66v/rPbcRplDbNEIj/fymYCZxABIvwZ59NaHupu8ljWs9DGz
	KmlGomFt3fzFkm5YFmzR9Ks0uyMBqpISm6+/SZX8ZgxPKGy+gyUJG18ggV91JBUA
	OdwWqlsRazXYBpypq+uhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755594917; x=1755681317; bh=dgchzZYWazF9bA9Qn52CgjOynPGZcFtDF4c
	hSUl865s=; b=joa3cD8Dt9gEW3M5zysw7Lc89OexCKunQ+G/jXuzP1GDr3kviNa
	4Q/U3ysayzCpw/kF8lDkgXdC6aaNlLEYSUZlvasJQVOSoXr6dDKi4OYkEwIReoFW
	hGtKa1UZSlmtM9/ncLBPxn8pYBF3CP19GpTNRJUxL4CM6+WGUa4XRoaluCJ2R22I
	/eSRYGRs1tne3t3VP+9UuRAerKE0ko1ya7wofTrRSZYweO9lD+CZ6kTowPDm5cmG
	b4A/pK2x95ExE88QJLdzK7UvFs9LrQ8ljwOpb6YkHGa2piUam2MGA6pHfwTeOXnZ
	ey6dvFDD5V0qkOsVfIRQW8AfXwMwKRt1NaA==
X-ME-Sender: <xms:pECkaCbIZh3fDJ0gogqRxojcCyoWjLTQer_PIES9LduTvUwGH2mifQ>
    <xme:pECkaBEsQGBBXD2UbGZzju2z3d4BgNhl_aUl4lAqA4xdpyKOmIqtOtX7LvxfRD1YS
    i3NZL6KzqkYbXRusp0>
X-ME-Received: <xmr:pECkaHpi3pwuD9Kc7PAzKM0_1wQmiIoUSTArWgwV3hVKoSKL_ePtaZGjMQqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgeqnecugg
    ftrfgrthhtvghrnhepjeehueefuddvgfejkeeivdejvdegjefgfeeiteevfffhtddvtdel
    udfhfeefffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhoshhhuhgrrdhhrghhnhhjhi
    esghhmrghilhdrtghomhdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhr
    ghdprhgtphhtthhopegtlhhmsehfsgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepvhgsrggskhgrsehsuhhs
    vgdrtgiipdhrtghpthhtohepshhurhgvnhgssehgohhglhgvrdgtohhmpdhrtghpthhtoh
    epmhhhohgtkhhosehsuhhsvgdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:pECkaFnRy_k1BUFjyXLYFT6Ko9xfMd02hv5QZFvKfJjtSREh50UgrQ>
    <xmx:pECkaMtYp-5RQJ5tcyakOdcVcXqRMCiRAU6vzuctwVIFOuLHOIJmsg>
    <xmx:pECkaEdBB0564ee_gKFqhU1-i4VfJghTmmhUp5WGT2_FvxXxVKlXuQ>
    <xmx:pECkaObn-EvuSUMyxAhRt0Hm_4SmVnJjghRZwh-PpHtNz73s9knTbw>
    <xmx:pUCkaGaUG8N80olSqYgicV5NIk9jbsDuPQkrgdxuR0gj3iFjpsMgPzv2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 05:15:15 -0400 (EDT)
Date: Tue, 19 Aug 2025 10:15:13 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@gogle.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in
 batch freeing
Message-ID: <k6fpx5adh45t4jrxgiccq7acubwcgmi746crggxi6e4oihtvpt@thks5zrn53n3>
References: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818185804.21044-1-joshua.hahnjy@gmail.com>

On Mon, Aug 18, 2025 at 11:58:03AM -0700, Joshua Hahn wrote:
> While testing workloads with high sustained memory pressure on large machines
> (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> Further investigation showed that the lock in free_pcppages_bulk was being held
> for a long time, even being held while 2k+ pages were being freed.
> 
> Instead of holding the lock for the entirety of the freeing, check to see if
> the zone lock is contended every pcp->batch pages. If there is contention,
> relinquish the lock so that other processors have a change to grab the lock
> and perform critical work.

Hm. It doesn't necessary to be contention on the lock, but just that you
holding the lock for too long so the CPU is not available for the scheduler.

> In our fleet, we have seen that performing batched lock freeing has led to
> significantly lower rates of softlockups, while incurring relatively small
> regressions (relative to the workload and relative to the variation).
> 
> The following are a few synthetic benchmarks:
> 
> Test 1: Small machine (30G RAM, 36 CPUs)
> 
> stress-ng --vm 30 --vm-bytes 1G -M -t 100
> +----------------------+---------------+-----------+
> |        Metric        | Variation (%) | Delta (%) |
> +----------------------+---------------+-----------+
> | bogo ops             |        0.0076 |   -0.0183 |
> | bogo ops/s (real)    |        0.0064 |   -0.0207 |
> | bogo ops/s (usr+sys) |        0.3151 |   +0.4141 |
> +----------------------+---------------+-----------+
> 
> stress-ng --vm 20 --vm-bytes 3G -M -t 100
> +----------------------+---------------+-----------+
> |        Metric        | Variation (%) | Delta (%) |
> +----------------------+---------------+-----------+
> | bogo ops             |        0.0295 |   -0.0078 |
> | bogo ops/s (real)    |        0.0267 |   -0.0177 |
> | bogo ops/s (usr+sys) |        1.7079 |   -0.0096 |
> +----------------------+---------------+-----------+
> 
> Test 2: Big machine (250G RAM, 176 CPUs)
> 
> stress-ng --vm 50 --vm-bytes 5G -M -t 100
> +----------------------+---------------+-----------+
> |        Metric        | Variation (%) | Delta (%) |
> +----------------------+---------------+-----------+
> | bogo ops             |        0.0362 |   -0.0187 |
> | bogo ops/s (real)    |        0.0391 |   -0.0220 |
> | bogo ops/s (usr+sys) |        2.9603 |   +1.3758 |
> +----------------------+---------------+-----------+
> 
> stress-ng --vm 10 --vm-bytes 30G -M -t 100
> +----------------------+---------------+-----------+
> |        Metric        | Variation (%) | Delta (%) |
> +----------------------+---------------+-----------+
> | bogo ops             |        2.3130 |   -0.0754 |
> | bogo ops/s (real)    |        3.3069 |   -0.8579 |
> | bogo ops/s (usr+sys) |        4.0369 |   -1.1985 |
> +----------------------+---------------+-----------+
> 
> Suggested-by: Chris Mason <clm@fb.com>
> Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> 
> ---
>  mm/page_alloc.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a8a84c3b5fe5..bd7a8da3e159 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1238,6 +1238,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	 * below while (list_empty(list)) loop.
>  	 */
>  	count = min(pcp->count, count);
> +	if (!count)
> +		return;
>  
>  	/* Ensure requested pindex is drained first. */
>  	pindex = pindex - 1;
> @@ -1247,6 +1249,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	while (count > 0) {
>  		struct list_head *list;
>  		int nr_pages;
> +		int batch = min(count, pcp->batch);
>  
>  		/* Remove pages from lists in a round-robin fashion. */
>  		do {
> @@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  
>  			/* must delete to avoid corrupting pcp list */
>  			list_del(&page->pcp_list);
> +			batch -= nr_pages;
>  			count -= nr_pages;
>  			pcp->count -= nr_pages;
>  
>  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
>  			trace_mm_page_pcpu_drain(page, order, mt);
> -		} while (count > 0 && !list_empty(list));
> +		} while (batch > 0 && !list_empty(list));
> +
> +		/*
> +		 * Prevent starving the lock for other users; every pcp->batch
> +		 * pages freed, relinquish the zone lock if it is contended.
> +		 */
> +		if (count && spin_is_contended(&zone->lock)) {

I would rather drop the count thing and do something like this:

		if (need_resched() || spin_needbreak(&zone->lock) {
			spin_unlock_irqrestore(&zone->lock, flags);
			cond_resched();
			spin_lock_irqsave(&zone->lock, flags);
		}

> +			spin_unlock_irqrestore(&zone->lock, flags);
> +			spin_lock_irqsave(&zone->lock, flags);
> +		}
>  	}
>  
>  	spin_unlock_irqrestore(&zone->lock, flags);
> 
> base-commit: 137a6423b60fe0785aada403679d3b086bb83062
> -- 
> 2.47.3

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

