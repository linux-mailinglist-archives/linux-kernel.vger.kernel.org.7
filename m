Return-Path: <linux-kernel+bounces-730700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61827B0484D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A131AA0414
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3356256C9B;
	Mon, 14 Jul 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jUbqEtrI"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E0322D4DC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752523991; cv=none; b=IibKLHnS+IzRi19WZ+lmu4jTDMtB9pO68WEqY34TOiBzWgrl0nxh7Dm9mqrBZweoHzIcDqFmxZ7wcnFGWwRq7ZP/519DJdIGjmGqTmrOvFWIZtsvyllxW19dnoXSLvd7N+AynyhVK3T2+gnMHHNdvQBiOY9tkqMHgr2f5alsWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752523991; c=relaxed/simple;
	bh=A44f3lNevYuPGKRHXO9elF643pyTcYzKm8Kur7midwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uIYYqmeyRLCuMWbrZOUqaCY1cSqvwnBZoQulVvAO2MfjZynaccDClZQRv0+WdSgiHYlydzrRNulXVt8t4kkR4l11Rgr2ZK9TpDjpikAC0H70WyHEWV53GejSdh9r3VTkxq40sVLFX0XrHbGrhcO1m/1l4zkDmTqb/VsxVNnFXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jUbqEtrI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752523984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8XoKnjcBylfGEBNdUuIZFyv37qBPEWmYJJGzJJn5qtA=;
	b=jUbqEtrIIB2vzENsalRF51bVNRuElUwz3OuvWK9eJUIEL9TU/4JvH0+0CUO0c+gxY2B0tq
	HWDjYCcu3tWqOmFriyfbEFcbh8HD+p6BypbIj9zo+yDUzwWWczYdj1+b240IKfnWvyCBtC
	btjTnmQBNMLb0kUvbv5O35xZ4Zesb4Q=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
In-Reply-To: <at4ojyziprhhktjgtfmuyzrqwfmomnly6fubkvmbtxkdnx6hpb@5nldc3vipwny>
	(Jan Kara's message of "Mon, 14 Jul 2025 17:16:51 +0200")
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
	<at4ojyziprhhktjgtfmuyzrqwfmomnly6fubkvmbtxkdnx6hpb@5nldc3vipwny>
Date: Mon, 14 Jul 2025 13:12:59 -0700
Message-ID: <87ms96v8dw.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jan Kara <jack@suse.cz> writes:

> On Thu 10-07-25 12:52:32, Roman Gushchin wrote:
>> We've noticed in production that under a very heavy memory pressure
>> the readahead behavior becomes unstable causing spikes in memory
>> pressure and CPU contention on zone locks.
>> 
>> The current mmap_miss heuristics considers minor pagefaults as a
>> good reason to decrease mmap_miss and conditionally start async
>> readahead. This creates a vicious cycle: asynchronous readahead
>> loads more pages, which in turn causes more minor pagefaults.
>> This problem is especially pronounced when multiple threads of
>> an application fault on consecutive pages of an evicted executable,
>> aggressively lowering the mmap_miss counter and preventing readahead
>> from being disabled.
>
> I think you're talking about filemap_map_pages() logic of handling
> mmap_miss. It would be nice to mention it in the changelog. There's one
> thing that doesn't quite make sense to me: When there's memory pressure,
> I'd expect the pages to be reclaimed from memory and not just unmapped. 
> Also given your solution uses !uptodate folios suggests the pages were
> actually fully reclaimed and the problem really is that filemap_map_pages()
> treats as minor page fault (i.e., cache hit) what is in fact a major page
> fault (i.e., cache miss)?
>
> Actually, now that I digged deeper I've remembered that based on Liu
> Shixin's report
> (https://lore.kernel.org/all/20240201100835.1626685-1-liushixin2@huawei.com/)
> which sounds a lot like what you're reporting, we have eventually merged his
> fixes (ended up as commits 0fd44ab213bc ("mm/readahead: break read-ahead
> loop if filemap_add_folio return -ENOMEM"), 5c46d5319bde ("mm/filemap:
> don't decrease mmap_miss when folio has workingset flag")). Did you test a
> kernel with these fixes (6.10 or later)? In particular after these fixes
> the !folio_test_workingset() check in filemap_map_folio_range() and
> filemap_map_order0_folio() should make sure we don't decrease mmap_miss
> when faulting fresh pages. Or was in your case page evicted so long ago
> that workingset bit is already clear?

Hi Jan!

I've tried to cherry-pick those changes into the kernel I'm looking at
(it's 6.6-based), it didn't help much. I haven't looked why, but at some
point I added traces into filemap_map_pages() and I don't remember
seeing anything. Most likely because pages are not uptodate at the
moment of fault.

In my case I saw a large number of minor pagefaults on consequent pages.
It seems like one thread is having a major pagefault and then a bunch
of other threads are faulting into next pages, effectively breaking
the mmap_miss heuristics. Sometimes it reaches 1000, but struggles
to stay there.

>
> Once we better understand the situation, let me also mention that I have
> two patches which I originally proposed to fix Liu's problems. They didn't
> quite fix them so his patches got merged in the end but the problems
> described there are still somewhat valid:
>
>     mm/readahead: Improve page readaround miss detection
>     
>     filemap_map_pages() decreases ra->mmap_miss for every page it maps. This
>     however overestimates number of real cache hits because we have no idea
>     whether the application will use the pages we map or not. This is
>     problematic in particular in memory constrained situations where we
>     think we have great readahead success rate although in fact we are just
>     trashing page cache & disk. Change filemap_map_pages() to count only
>     success of mapping the page we are faulting in. This should be actually
>     enough to keep mmap_miss close to 0 for workloads doing sequential reads
>     because filemap_map_pages() does not map page with readahead flag and
>     thus these are going to contribute to decreasing the mmap_miss counter.
>
>     Fixes: f1820361f83d ("mm: implement ->map_pages for page cache")
>
> -
>     mm/readahead: Fix readahead miss detection with FAULT_FLAG_RETRY_NOWAIT
>     
>     When the page fault happens with FAULT_FLAG_RETRY_NOWAIT (which is
>     common) we will bail out of the page fault after issuing reads and retry
>     the fault. That will then find the created pages in filemap_map_pages()
>     and hence will be treated as cache hit canceling out the cache miss in
>     do_sync_mmap_readahead(). Increment mmap_miss by two in
>     do_sync_mmap_readahead() in case FAULT_FLAG_RETRY_NOWAIT is set to
>     account for the following expected hit. If the page gets evicted even
>     before we manage to retry the fault, we are under so heavy memory
>     pressure that increasing mmap_miss by two is fine.
>
>     Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")

Yeah, this looks interesting...

Thanks!

