Return-Path: <linux-kernel+bounces-776232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C04B2CA56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E3B1770FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D22BDC19;
	Tue, 19 Aug 2025 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PM0s0ghi"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83524DFF3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755623751; cv=none; b=hj9vF5f4p4/PUgqcZSDJChERfkuKhnNT74Xukold0Bn6EQnGKnlslMbhSSVvandzFjoMp6CpSFNguPj6Q/SlyJzZdu/12nBRFOEGIlq6ZEM2VpeCpjfoJwrj9smlJZOUe8zO66kMsYSistSLM6WqUmh7WdjJrU6dydAgp0HY4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755623751; c=relaxed/simple;
	bh=59OLgn+Wmey6vGPWX7fJHZWyFNGVdSSj6E7kpEluAdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUdwLh22bLuxXeG/+VIp7L/khhau7smYOlnSgAScHyEvDx8VQocvfVGo6yk/rnZxVXQk+mOXefhq2TYNaoKog/Uqx4Mxf1pKqgeejzVJKbVRDuOnu3XtyWROpAtPm6N9ZPoPoLYjzSGOGPDnqtN9r4lilgW1fE14k1PcuyOJLdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PM0s0ghi; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 Aug 2025 10:15:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755623745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PiJkya2g4FSff5yfUkVXC41MIiQghloJYZcE1SJkKQ0=;
	b=PM0s0ghiradGy03X4ixMIgB1feFBiOl0LfEPp8M3JIx3pNrtNS/5jHMuSo99IfK4CmL9rL
	ksudLu01f1It0+rLdkLKcTRguI9GVKcf3BArCXnHtENWbUHVDqWhDiffebMOI53+S9fbn/
	XRR8xy3T+P5gUIbforqLuYGimUzOt54=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@gogle.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/page_alloc: Occasionally relinquish zone lock in
 batch freeing
Message-ID: <x3xp3cj6wpgxu5mjsd62fzvuzpn2mxpvlk6sau65si7bk6ncu5@dx6jbuacy42i>
References: <20250818185804.21044-1-joshua.hahnjy@gmail.com>
 <k6fpx5adh45t4jrxgiccq7acubwcgmi746crggxi6e4oihtvpt@thks5zrn53n3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k6fpx5adh45t4jrxgiccq7acubwcgmi746crggxi6e4oihtvpt@thks5zrn53n3>
X-Migadu-Flow: FLOW_OUT

On Tue, Aug 19, 2025 at 10:15:13AM +0100, Kiryl Shutsemau wrote:
> On Mon, Aug 18, 2025 at 11:58:03AM -0700, Joshua Hahn wrote:
> > While testing workloads with high sustained memory pressure on large machines
> > (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> > Further investigation showed that the lock in free_pcppages_bulk was being held
> > for a long time, even being held while 2k+ pages were being freed.
> > 
> > Instead of holding the lock for the entirety of the freeing, check to see if
> > the zone lock is contended every pcp->batch pages. If there is contention,
> > relinquish the lock so that other processors have a change to grab the lock
> > and perform critical work.
> 
> Hm. It doesn't necessary to be contention on the lock, but just that you
> holding the lock for too long so the CPU is not available for the scheduler.
> 
> > In our fleet, we have seen that performing batched lock freeing has led to
> > significantly lower rates of softlockups, while incurring relatively small
> > regressions (relative to the workload and relative to the variation).
> > 
> > The following are a few synthetic benchmarks:
> > 
> > Test 1: Small machine (30G RAM, 36 CPUs)
> > 
> > stress-ng --vm 30 --vm-bytes 1G -M -t 100
> > +----------------------+---------------+-----------+
> > |        Metric        | Variation (%) | Delta (%) |
> > +----------------------+---------------+-----------+
> > | bogo ops             |        0.0076 |   -0.0183 |
> > | bogo ops/s (real)    |        0.0064 |   -0.0207 |
> > | bogo ops/s (usr+sys) |        0.3151 |   +0.4141 |
> > +----------------------+---------------+-----------+
> > 
> > stress-ng --vm 20 --vm-bytes 3G -M -t 100
> > +----------------------+---------------+-----------+
> > |        Metric        | Variation (%) | Delta (%) |
> > +----------------------+---------------+-----------+
> > | bogo ops             |        0.0295 |   -0.0078 |
> > | bogo ops/s (real)    |        0.0267 |   -0.0177 |
> > | bogo ops/s (usr+sys) |        1.7079 |   -0.0096 |
> > +----------------------+---------------+-----------+
> > 
> > Test 2: Big machine (250G RAM, 176 CPUs)
> > 
> > stress-ng --vm 50 --vm-bytes 5G -M -t 100
> > +----------------------+---------------+-----------+
> > |        Metric        | Variation (%) | Delta (%) |
> > +----------------------+---------------+-----------+
> > | bogo ops             |        0.0362 |   -0.0187 |
> > | bogo ops/s (real)    |        0.0391 |   -0.0220 |
> > | bogo ops/s (usr+sys) |        2.9603 |   +1.3758 |
> > +----------------------+---------------+-----------+
> > 
> > stress-ng --vm 10 --vm-bytes 30G -M -t 100
> > +----------------------+---------------+-----------+
> > |        Metric        | Variation (%) | Delta (%) |
> > +----------------------+---------------+-----------+
> > | bogo ops             |        2.3130 |   -0.0754 |
> > | bogo ops/s (real)    |        3.3069 |   -0.8579 |
> > | bogo ops/s (usr+sys) |        4.0369 |   -1.1985 |
> > +----------------------+---------------+-----------+
> > 
> > Suggested-by: Chris Mason <clm@fb.com>
> > Co-developed-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > 
> > ---
> >  mm/page_alloc.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index a8a84c3b5fe5..bd7a8da3e159 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1238,6 +1238,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  	 * below while (list_empty(list)) loop.
> >  	 */
> >  	count = min(pcp->count, count);
> > +	if (!count)
> > +		return;
> >  
> >  	/* Ensure requested pindex is drained first. */
> >  	pindex = pindex - 1;
> > @@ -1247,6 +1249,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  	while (count > 0) {
> >  		struct list_head *list;
> >  		int nr_pages;
> > +		int batch = min(count, pcp->batch);
> >  
> >  		/* Remove pages from lists in a round-robin fashion. */
> >  		do {
> > @@ -1267,12 +1270,22 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >  
> >  			/* must delete to avoid corrupting pcp list */
> >  			list_del(&page->pcp_list);
> > +			batch -= nr_pages;
> >  			count -= nr_pages;
> >  			pcp->count -= nr_pages;
> >  
> >  			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
> >  			trace_mm_page_pcpu_drain(page, order, mt);
> > -		} while (count > 0 && !list_empty(list));
> > +		} while (batch > 0 && !list_empty(list));
> > +
> > +		/*
> > +		 * Prevent starving the lock for other users; every pcp->batch
> > +		 * pages freed, relinquish the zone lock if it is contended.
> > +		 */
> > +		if (count && spin_is_contended(&zone->lock)) {
> 
> I would rather drop the count thing and do something like this:
> 
> 		if (need_resched() || spin_needbreak(&zone->lock) {
> 			spin_unlock_irqrestore(&zone->lock, flags);
> 			cond_resched();

Can this function be called from non-sleepable context?

> 			spin_lock_irqsave(&zone->lock, flags);
> 		}
> 
> > +			spin_unlock_irqrestore(&zone->lock, flags);
> > +			spin_lock_irqsave(&zone->lock, flags);
> > +		}
> >  	}
> >  
> >  	spin_unlock_irqrestore(&zone->lock, flags);
> > 
> > base-commit: 137a6423b60fe0785aada403679d3b086bb83062
> > -- 
> > 2.47.3
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

