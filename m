Return-Path: <linux-kernel+bounces-746494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB76B12763
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 01:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31F81CE3291
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C997260575;
	Fri, 25 Jul 2025 23:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fw/uCp44"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8EC25FA10
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485960; cv=none; b=OBT1npXXarVqzfonD7KoDlL4TNOSHyYL20aELb3i6gjGqxyerp/2Jun53K6vsq1BTeYFNZF4GanOxnyobLQrJN5iENT19KSik3KQgEFkjNqAihOgQWDYCz5n6MdAZGlrw6FMjIYc+m74dLv13AIZpr9OsEjTPSD1jhULiKgSVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485960; c=relaxed/simple;
	bh=hZp1Z718D4mvR1fNlc9+a3W7QzX63K59MD6FgY0LEzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fSyvYK+wbCL3mfDvlur5hxYyC5t8WIhF07eY2lVem6SFoUObX+hK9rSYJ+Hkc0SL101t2UieqwVHq/cWmWgVrDDSWynStThx6kRANZGq1Xuch264/so58sQOjvsVRZyDX10dybljMQMIUEdCk30oly5uRXWG6urLZLkXRfUs6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fw/uCp44; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753485954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aaydfYuqVafMA2JLko3KZS5h6j/lPMMeqjP2Raw9h1E=;
	b=Fw/uCp44j50elRecwJYSlIwHTVK4my4ZXuqt1jXAPGzfYKW68TOQLEWcy0aYrAYuOUS2tp
	5weDJPJQbYnUTtSguNmZ4Q2Fu3dMoSEHhjiXvQJeCIzfWSQfoDu/L3p10rq1rkRSyGO9YO
	qQ0u6ug7uwAzA06C4Eu0TAeQqCl8Hu4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: consider disabling readahead if there are signs of
 thrashing
In-Reply-To: <875xffsxj4.fsf@linux.dev> (Roman Gushchin's message of "Fri, 25
	Jul 2025 15:42:07 -0700")
References: <20250710195232.124790-1-roman.gushchin@linux.dev>
	<at4ojyziprhhktjgtfmuyzrqwfmomnly6fubkvmbtxkdnx6hpb@5nldc3vipwny>
	<875xffsxj4.fsf@linux.dev>
Date: Fri, 25 Jul 2025 16:25:49 -0700
Message-ID: <87jz3vdf9e.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Roman Gushchin <roman.gushchin@linux.dev> writes:

> Jan Kara <jack@suse.cz> writes:
>
>> On Thu 10-07-25 12:52:32, Roman Gushchin wrote:
>>> We've noticed in production that under a very heavy memory pressure
>>> the readahead behavior becomes unstable causing spikes in memory
>>> pressure and CPU contention on zone locks.
>>> 
>>> The current mmap_miss heuristics considers minor pagefaults as a
>>> good reason to decrease mmap_miss and conditionally start async
>>> readahead. This creates a vicious cycle: asynchronous readahead
>>> loads more pages, which in turn causes more minor pagefaults.
>>> This problem is especially pronounced when multiple threads of
>>> an application fault on consecutive pages of an evicted executable,
>>> aggressively lowering the mmap_miss counter and preventing readahead
>>> from being disabled.
>>
>> I think you're talking about filemap_map_pages() logic of handling
>> mmap_miss. It would be nice to mention it in the changelog. There's one
>> thing that doesn't quite make sense to me: When there's memory pressure,
>> I'd expect the pages to be reclaimed from memory and not just unmapped. 
>> Also given your solution uses !uptodate folios suggests the pages were
>> actually fully reclaimed and the problem really is that filemap_map_pages()
>> treats as minor page fault (i.e., cache hit) what is in fact a major page
>> fault (i.e., cache miss)?
>>
>> Actually, now that I digged deeper I've remembered that based on Liu
>> Shixin's report
>> (https://lore.kernel.org/all/20240201100835.1626685-1-liushixin2@huawei.com/)
>> which sounds a lot like what you're reporting, we have eventually merged his
>> fixes (ended up as commits 0fd44ab213bc ("mm/readahead: break read-ahead
>> loop if filemap_add_folio return -ENOMEM"), 5c46d5319bde ("mm/filemap:
>> don't decrease mmap_miss when folio has workingset flag")). Did you test a
>> kernel with these fixes (6.10 or later)? In particular after these fixes
>> the !folio_test_workingset() check in filemap_map_folio_range() and
>> filemap_map_order0_folio() should make sure we don't decrease mmap_miss
>> when faulting fresh pages. Or was in your case page evicted so long ago
>> that workingset bit is already clear?
>>
>> Once we better understand the situation, let me also mention that I have
>> two patches which I originally proposed to fix Liu's problems. They didn't
>> quite fix them so his patches got merged in the end but the problems
>> described there are still somewhat valid:
>
> Ok, I got a better understanding of the situation now. Basically we have
> a multi-threaded application which is under very heavy memory pressure.
> I multiple threads are faulting simultaneously into the same page,
> do_sync_mmap_readahead() can be called multiple times for the same page.
> This creates a negative pressure on the mmap_miss counter, which can't be
> matched by do_sync_mmap_readahead(), which is be called only once
> for every page. This basically keeps the readahead on, despite the heavy
> memory pressure.
>
> The following patch solves the problem, at least in my test scenario.
> Wdyt?

Actually, a better version is below. We don't have to avoid the actual
readahead, just not decrease mmap_miss if the page is locked.

--

diff --git a/mm/filemap.c b/mm/filemap.c
index 0d0369fb5fa1..1756690dd275 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3323,9 +3323,15 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
        if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
                return fpin;
 
-       mmap_miss = READ_ONCE(ra->mmap_miss);
-       if (mmap_miss)
-               WRITE_ONCE(ra->mmap_miss, --mmap_miss);
+       /* If folio is locked, we're likely racing against another fault,
+        * don't decrease the mmap_miss counter to avoid decreasing it
+        * multiple times for the same page and break the balance.
+        */
+       if (likely(!folio_test_locked(folio))) {
+               mmap_miss = READ_ONCE(ra->mmap_miss);
+               if (mmap_miss)
+                       WRITE_ONCE(ra->mmap_miss, --mmap_miss);
+       }
 
        if (folio_test_readahead(folio)) {
                fpin = maybe_unlock_mmap_for_io(vmf, fpin);

