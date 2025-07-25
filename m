Return-Path: <linux-kernel+bounces-746463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBAB126F9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7561C837DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7002F2472AE;
	Fri, 25 Jul 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nZ6pCdAv"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1E8248C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753483340; cv=none; b=EqIa6F0rROMjcrFRW7Djoy4QhtfLboZff9W6GvzagBwgMEmwxkc30NYGxB/3aZnNAIv89xHGzdk675EkxsByicei1wj8fR0TQr9bD6zSkRRmVxy7eTSA/YjJ35yljrVQmXk38CkYm77OoDuakidR/sm6g3PE5Xgt0eWo+jhAMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753483340; c=relaxed/simple;
	bh=nCCY7aiyOCKnKYofLCFzHorKrqQhAEtDBuhf4vItKNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PM8i3B2daySaEMtSxQESGGbcis47z15tXHOSOZ/ccWIEXFWXInL4/j35JW9UfbtShAZeYEAoM+WTkHpJs1g5jciSiXQxGxoS0X5Ccu9Z4TTADmjpEkMGj8hmsT461l9JHg/cTD3Tc0+J8fXOyIwJwYFn4SfS5bOD9ADDxX5UMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nZ6pCdAv; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753483332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A0Ko/T008kKzATvgo21S/8DgIEmpbQO5L/7e7R+RnuA=;
	b=nZ6pCdAvBYhWZg4stmEXGZH5XqIb8tSQDnvH847rHfYlDIMqVqE+C+HBAtAuhl/pQtur2N
	CNgAVpr+Hv1R6Rh1tfJkcGv1PPIsoJ0daGeq/bGM3KlgCCf9CnVBmQGGWh/f1tKWxgZy6c
	uBfKo+1+LocCIHfJ9czveJ9oEIpY/00=
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
Date: Fri, 25 Jul 2025 15:42:07 -0700
Message-ID: <875xffsxj4.fsf@linux.dev>
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
>
> Once we better understand the situation, let me also mention that I have
> two patches which I originally proposed to fix Liu's problems. They didn't
> quite fix them so his patches got merged in the end but the problems
> described there are still somewhat valid:

Ok, I got a better understanding of the situation now. Basically we have
a multi-threaded application which is under very heavy memory pressure.
I multiple threads are faulting simultaneously into the same page,
do_sync_mmap_readahead() can be called multiple times for the same page.
This creates a negative pressure on the mmap_miss counter, which can't be
matched by do_sync_mmap_readahead(), which is be called only once
for every page. This basically keeps the readahead on, despite the heavy
memory pressure.

The following patch solves the problem, at least in my test scenario.
Wdyt?

Thanks!

--

@@ -3323,6 +3323,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
 
+	/* We're likely racing against another fault, bail out */
+	if (folio_test_locked(folio) && !folio_test_uptodate(folio))
+		return fpin;
+
 	mmap_miss = READ_ONCE(ra->mmap_miss);
 	if (mmap_miss)
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);



