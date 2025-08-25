Return-Path: <linux-kernel+bounces-785239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64863B347FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3176718993FC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093B2FF670;
	Mon, 25 Aug 2025 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mqpvkaV+"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC53221F32
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140879; cv=none; b=CthW5qS3Do1/k9g2xx+idRmndwW6xDpEbGi5+OwdrAMzWVmR3LeBCRrcEcFtfJfeCmRYcsPD22jp8igIMkmcG7fZFxl0U5IUKBXZgzLbwevOa78ABuyxfMZ+7vTk8dTDQW6up8zH8cEYSo19eGNc5S4hoHq7pMsMfT9bgA4sjkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140879; c=relaxed/simple;
	bh=M+3l9kNVTQmgn33MUV7rZLynN/rT3X6R3wVIbhxLNAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nwdopGtOaRiMh6n6qBI1NKHxthqN7AI+5j6v6G3FPMdW9Jl7TMsaXUOXuT4Jb3M6BS6pl6+z+mGJZxVjJmuoxu7D4ak8Nlq2N4W+xMO45O875JGRirJ66127Q0Qefqr6PfIM3G74AGm6DpXS/gI8OV3Km7u9QdK3FG+FKZcsM8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mqpvkaV+; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756140875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dZmzyywwnY7lchKOLgGY8doykdyDHwJJ4akbIOpMOs=;
	b=mqpvkaV+gR6VKDvX93iA5JZH4kv7rLy11Zbppcwm9x5N37j+I+IAD1ZEfrWxnee6mjf5pW
	fLJw2lyngoXCxU/07dF1HNmsODE42v0IGMe61UUL+hXzMJjUhUJQgyz7c5Hz6+3ktTRBld
	uealQshO024kKDTe1zIJigJAgbeNZHg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  "Matthew Wilcox (Oracle)"
 <willy@infradead.org>,  Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm: readahead: improve mmap_miss heuristic for
 concurrent faults
In-Reply-To: <ynl23xmeglxarrkrmh4r3sj3idvqbofwatrnhgx6tsl4zfrsxp@juc5kmjelwjn>
	(Mateusz Guzik's message of "Mon, 25 Aug 2025 14:27:58 +0200")
References: <20250815183224.62007-1-roman.gushchin@linux.dev>
	<ynl23xmeglxarrkrmh4r3sj3idvqbofwatrnhgx6tsl4zfrsxp@juc5kmjelwjn>
Date: Mon, 25 Aug 2025 09:54:29 -0700
Message-ID: <87plcjxry2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Mateusz Guzik <mjguzik@gmail.com> writes:

> On Fri, Aug 15, 2025 at 11:32:24AM -0700, Roman Gushchin wrote:
>> If two or more threads of an application faulting on the same folio,
>> the mmap_miss counter can be decreased multiple times. It breaks the
>> mmap_miss heuristic and keeps the readahead enabled even under extreme
>> levels of memory pressure.
>> 
>> It happens often if file folios backing a multi-threaded application
>> are getting evicted and re-faulted.
>> 
>> Fix it by skipping decreasing mmap_miss if the folio is locked.
>> 
>> This change was evaluated on several hundred thousands hosts in Google's
>> production over a couple of weeks. The number of containers being
>> stuck in a vicious reclaim cycle for a long time was reduced several
>> fold (~10-20x), as well as the overall fleet-wide cpu time spent in
>> direct memory reclaim was meaningfully reduced. No regressions were
>> observed.
>> 
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: linux-mm@kvack.org
>> ---
>>  mm/filemap.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index c21e98657e0b..983ba1019674 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3324,9 +3324,17 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>>  	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
>>  		return fpin;
>>  
>> -	mmap_miss = READ_ONCE(ra->mmap_miss);
>> -	if (mmap_miss)
>> -		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
>> +	/*
>> +	 * If the folio is locked, we're likely racing against another fault.
>> +	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
>> +	 * times for a single folio and break the balance with mmap_miss
>> +	 * increase in do_sync_mmap_readahead().
>> +	 */
>> +	if (likely(!folio_test_locked(folio))) {
>> +		mmap_miss = READ_ONCE(ra->mmap_miss);
>> +		if (mmap_miss)
>> +			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
>> +	}
>
> I'm not an mm person.
>
> The comment implies the change fixes the race, but it is not at all
> clear to me how.
>
> Does it merely make it significantly less likely?

It's not fixing any race, it's fixing the imbalance in the upward and
downward pressure on the mmap_miss variable. This improves the readahead
behavior under very special circumstances: a multi-threaded application
under very heavy memory pressure. There should be no visible difference
in behavior in other cases.

Thanks!

