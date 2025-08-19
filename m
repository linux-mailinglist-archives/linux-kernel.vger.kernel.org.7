Return-Path: <linux-kernel+bounces-775463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B20B2BF71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219E01960AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D09326D48;
	Tue, 19 Aug 2025 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zta/O5+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FB31AF01;
	Tue, 19 Aug 2025 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600894; cv=none; b=mCoI1AtbN/3Ge3vWmbOD69W00gshtFJkRIn4Y2KEwd1f0J30evlNtg0WYaEVGoOY6C23PaBn/jYfNQK8Rh2Kg2Jh+qeS0kjNolvtDrQWEZ6BnNWyENGI3JzTn/1ahZGqD3rI3k2u7o9gjOuSPO+gxruGs4D+dugjbY0UyfDGlBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600894; c=relaxed/simple;
	bh=ObmAp/lIF5T9u/FjKqRF/LtJfWE6tMEI8MTlJt/e9nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk4eyRsx5OfSRGbPR1a+rZpUIKrDEmFPZ1xus/rbL2X96nO3a4+KpcPNuVj3soSBCOqYGq5/2ha+t1hDKFHmwSO/s7GWrdunDblvqfWezW7Frg85NXaD4NB8CVq1RRSVPOjW2oiNZI14lmOivhwrFSOwEY8PwOJ7F1MNtCwabUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zta/O5+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F22C113D0;
	Tue, 19 Aug 2025 10:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755600894;
	bh=ObmAp/lIF5T9u/FjKqRF/LtJfWE6tMEI8MTlJt/e9nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zta/O5+p9ya6IXOH6Q7+cZxn7RNLi4adAXeXJsIjFJrS4XDeTkRVROzGnykGbj9J2
	 NawVnEa149OU4BcSauE9RmG3C+CsjjIGw1oweDUqwiB2dxsmRyIgiehjb3nfRXZ1Ah
	 VM3Uy4z5JQpl3nONPeMkKwaXkiitTtOTyXHhhGV8TBYtuTatsLx2rO+/S8DI4mwUsU
	 cG2J1m3fnnh8yfygqKj6NZ3KZNe4kBJiQv/d1flLffralOMTvlvoy+fc9T46+MmrsV
	 WkHwsu1lFOfifsozGXTMdonZzMmF52USglfRh7fun0atw7wsUgzQ+/wZctq18qXR3H
	 KS5CRwxz0/85w==
Date: Tue, 19 Aug 2025 13:54:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Justin Stitt <justinstitt@google.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/4] mm/mm_init: use deferred_init_memmap_chunk() in
 deferred_grow_zone()
Message-ID: <aKRX9iIe8h9fFi9v@kernel.org>
References: <20250818064615.505641-1-rppt@kernel.org>
 <20250818064615.505641-2-rppt@kernel.org>
 <20250819095223.ckjdsii4gc6u4nec@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819095223.ckjdsii4gc6u4nec@master>

On Tue, Aug 19, 2025 at 09:52:23AM +0000, Wei Yang wrote:
> Hi, Mike
> 
> After going through the code again, I have some trivial thoughts to discuss
> with you. If not right, please let me know.
> 
> On Mon, Aug 18, 2025 at 09:46:12AM +0300, Mike Rapoport wrote:
> [...]
> > bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
> > {
> >-	unsigned long nr_pages_needed = ALIGN(1 << order, PAGES_PER_SECTION);
> >+	unsigned long nr_pages_needed = SECTION_ALIGN_UP(1 << order);
> > 	pg_data_t *pgdat = zone->zone_pgdat;
> > 	unsigned long first_deferred_pfn = pgdat->first_deferred_pfn;
> > 	unsigned long spfn, epfn, flags;
> > 	unsigned long nr_pages = 0;
> >-	u64 i = 0;
> > 
> > 	/* Only the last zone may have deferred pages */
> > 	if (zone_end_pfn(zone) != pgdat_end_pfn(pgdat))
> >@@ -2262,37 +2272,26 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
> > 		return true;
> > 	}
> 
> In the file above this line, there is a compare between first_deferred_pfn and
> its original value after grab pgdat_resize_lock.

Do you mean this one:

	if (first_deferred_pfn != pgdat->first_deferred_pfn) {
		pgdat_resize_unlock(pgdat, &flags);
		return true;
	}
 
> I am thinking to compare first_deferred_pfn with ULONG_MAX, as it compared in
> deferred_init_memmap(). This indicate this zone has already been initialized
> totally.

It may be another CPU ran deferred_grow_zone() and won the race for resize
lock. Then pgdat->first_deferred_pfn will be larger than
first_deferred_pfn, but still not entire zone would be initialized.
 
> Current code guard this by spfn < zone_end_pfn(zone). Maybe a check ahead
> would be more clear?

Not sure I follow you here. The check that we don't pass zone_end_pfn is
inside the loop for every section we initialize.
 
> > 
> >-	/* If the zone is empty somebody else may have cleared out the zone */
> >-	if (!deferred_init_mem_pfn_range_in_zone(&i, zone, &spfn, &epfn,
> >-						 first_deferred_pfn)) {
> >-		pgdat->first_deferred_pfn = ULONG_MAX;
> >-		pgdat_resize_unlock(pgdat, &flags);
> >-		/* Retry only once. */
> >-		return first_deferred_pfn != ULONG_MAX;
> >+	/*
> >+	 * Initialize at least nr_pages_needed in section chunks.
> >+	 * If a section has less free memory than nr_pages_needed, the next
> >+	 * section will be also initalized.
> >+	 * Note, that it still does not guarantee that allocation of order can
> >+	 * be satisfied if the sections are fragmented because of memblock
> >+	 * allocations.
> >+	 */
> >+	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
> 
> I am expecting first_deferred_pfn is section aligned. So epfn += PAGES_PER_SECTION
> is fine?

It should be, but I'd prefer to be on the safe side and keep it this way.
 
> Maybe I missed something.
> 
> >+	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
> >+	     spfn = epfn, epfn += PAGES_PER_SECTION) {
> >+		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
> > 	}
> > 
> > 	/*
> >-	 * Initialize and free pages in MAX_PAGE_ORDER sized increments so
> >-	 * that we can avoid introducing any issues with the buddy
> >-	 * allocator.
> >+	 * There were no pages to initialize and free which means the zone's
> >+	 * memory map is completely initialized.
> > 	 */
> >-	while (spfn < epfn) {
> >-		/* update our first deferred PFN for this section */
> >-		first_deferred_pfn = spfn;
> >-
> >-		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
> >-		touch_nmi_watchdog();
> >-
> >-		/* We should only stop along section boundaries */
> >-		if ((first_deferred_pfn ^ spfn) < PAGES_PER_SECTION)
> >-			continue;
> >-
> >-		/* If our quota has been met we can stop here */
> >-		if (nr_pages >= nr_pages_needed)
> >-			break;
> >-	}
> >+	pgdat->first_deferred_pfn = nr_pages ? spfn : ULONG_MAX;
> 
> If we come here because spfn >= zone_end_pfn(zone), first_deferred_pfn is left
> a "valid" value and deferred_init_memmap() will try to do its job. But
> actually nothing left to initialize.

We anyway run a thread for each node with memory. In the very unlikely case
we've completely initialized a deferred zone that thread will finish much
faster :)
 
> For this case, I suggest to set it ULONG_MAX too. But this is really corner
> case.

-- 
Sincerely yours,
Mike.

