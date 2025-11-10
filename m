Return-Path: <linux-kernel+bounces-892622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA4C4577A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E5EF4347355
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A822FCBF7;
	Mon, 10 Nov 2025 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUPDg6ra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570262F25F1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765034; cv=none; b=AqnqAB+iyN3Jenb7wCRx6/Y2e42iT7+zEmyhtZWsnlnhaAFZEEJOgS8Btt1+/sjKWrb/OhA7rNH28k2bSLYYeUC7k/s/9jpXG9of2SrRKwZSCA/P6V4KrgQq8wIfDx4N1BP8s1sD+ypG60BbfsOCwg07d8r3vyPDaokIfoWbYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765034; c=relaxed/simple;
	bh=IWZV6AGpsZj8OoXU3sEMbwaFtC47+y+rHg8Ngr2ah+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ct9vLwIBj+ukj6DzS2ppeo9ir9KP8WvVK6UDuVbXdQtXRNAK/1tGIYu6DGeNUcQVgUipOaDlHnCcV/X038wHc9gJbbCh3nHMCRWJnA8xIUPb1wFEFj12rPouFVR7FYXDL71tXaWNpW9fP8mPGfWDIeYtZSjwHMd0eGZmGkaAZag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUPDg6ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C041BC4CEFB;
	Mon, 10 Nov 2025 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762765034;
	bh=IWZV6AGpsZj8OoXU3sEMbwaFtC47+y+rHg8Ngr2ah+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kUPDg6raagQDZr8nbIX4JGggpv2JCysZCrSuuJBXAvkOkpmldIwBO2hWImaNLdiJv
	 kuyZ+YysstcvNnb4WQPgVmbZM5CSDtPWRGxcrTlfEUOdvecOls9IMpgTaix+urYgbu
	 huWs+vQUy8KEoxb/3haW7OgXGUzXil/5g8ZfAqscM5+mxa+3Pfxw/t+wKX864xd4Ae
	 uy9sv43PYe2X08SideJ5+3Lm7vIMvh9xT8Vh59rBA4rVMl5Omjqti6IE8JnpWXPJqa
	 s309ybxosVHLOgq907b6dWUgmCDm4Nqb1urxPtDviC514V8DQgkz6Vj1x9eJ8eCQSL
	 wY9WtHl2+H3Dg==
Message-ID: <93b2f5eb-362c-49b7-9d90-01d250c9b6ff@kernel.org>
Date: Mon, 10 Nov 2025 09:57:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/7] mm, folio_zero_user: support clearing page ranges
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027202109.678022-7-ankur.a.arora@oracle.com>
 <77b2ae9c-2700-4c7a-ae45-323af6beaff3@kernel.org> <87346o582b.fsf@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <87346o582b.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 08:20, Ankur Arora wrote:
> 
> David Hildenbrand (Red Hat) <david@kernel.org> writes:
> 
>> On 27.10.25 21:21, Ankur Arora wrote:
>>> Clear contiguous page ranges in folio_zero_user() instead of clearing
>>> a page-at-a-time. This enables CPU specific optimizations based on
>>> the length of the region.
>>> Operating on arbitrarily large regions can lead to high preemption
>>> latency under cooperative preemption models. So, limit the worst
>>> case preemption latency via architecture specified PAGE_CONTIG_NR
>>> units.
>>> The resultant performance depends on the kinds of optimizations
>>> available to the CPU for the region being cleared. Two classes of
>>> of optimizations:
>>>     - clearing iteration costs can be amortized over a range larger
>>>       than a single page.
>>>     - cacheline allocation elision (seen on AMD Zen models).
>>> Testing a demand fault workload shows an improved baseline from the
>>> first optimization and a larger improvement when the region being
>>> cleared is large enough for the second optimization.
>>> AMD Milan (EPYC 7J13, boost=0, region=64GB on the local NUMA node):
>>>    $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5
>>>                       page-at-a-time     contiguous clearing      change
>>>                     (GB/s  +- %stdev)     (GB/s  +- %stdev)
>>>      pg-sz=2MB       12.92  +- 2.55%        17.03  +-  0.70%       + 31.8%
>>> preempt=*
>>>      pg-sz=1GB       17.14  +- 2.27%        18.04  +-  1.05% [#]   +  5.2%
>>> preempt=none|voluntary
>>>      pg-sz=1GB       17.26  +- 1.24%        42.17  +-  4.21%       +144.3%	preempt=full|lazy
>>> [#] AMD Milan uses a threshold of LLC-size (~32MB) for eliding cacheline
>>> allocation, which is larger than ARCH_PAGE_CONTIG_NR, so
>>> preempt=none|voluntary see no improvement on the pg-sz=1GB.
>>> Also as mentioned earlier, the baseline improvement is not specific to
>>> AMD Zen platforms. Intel Icelakex (pg-sz=2MB|1GB) sees a similar
>>> improvement as the Milan pg-sz=2MB workload above (~30%).
>>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>>> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>
>>> Tested-by: Raghavendra K T <raghavendra.kt@amd.com>
>>> ---
>>>    include/linux/mm.h |  6 ++++++
>>>    mm/memory.c        | 42 +++++++++++++++++++++---------------------
>>>    2 files changed, 27 insertions(+), 21 deletions(-)
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index ecbcb76df9de..02db84667f97 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -3872,6 +3872,12 @@ static inline void clear_page_guard(struct zone *zone, struct page *page,
>>>    				unsigned int order) {}
>>>    #endif	/* CONFIG_DEBUG_PAGEALLOC */
>>>    +#ifndef ARCH_PAGE_CONTIG_NR
>>> +#define PAGE_CONTIG_NR	1
>>> +#else
>>> +#define PAGE_CONTIG_NR	ARCH_PAGE_CONTIG_NR
>>> +#endif
>>
>> The name is a bit misleading. We need something that tells us that this is for
>> patch-processing (clearing? maybe alter copying?) contig pages. Likely spelling
>> out that this is for the non-preemptible case only.
>>
>> I assume we can drop the "CONTIG", just like clear_pages() doesn't contain it
>> etc.
>>
>> CLEAR_PAGES_NON_PREEMPT_BATCH
>>
>> PROCESS_PAGES_NON_PREEMPT_BATCH
> 
> I think this version is clearer. And would be viable for copying as well.
> 
>> Can you remind me again why this is arch specific, and why the default is 1
>> instead of, say 2,4,8 ... ?
> 
> So, the only use for this value is to decide a reasonable frequency
> for calling cond_resched() when operating on hugepages.
> 
> And the idea was the arch was best placed to have a reasonably safe
> value based on the expected spread of bandwidths it might see across
> uarchs. And the default choice of 1 was to keep it close to what we
> have now.
> 
> Thinking about it now though, maybe it is better to instead do this
> in common code. We could have two sets of defines,
> PROCESS_PAGES_NON_PREEMPT_BATCH_{LARGE,SMALL}, the first for archs
> that define __HAVE_ARCH_CLEAR_PAGES and the second, without.

Right, avoiding this dependency on arch code would be nice.

Also, it feels like something we can later optimize for archs without 
__HAVE_ARCH_CLEAR_PAGES in common code.

-- 
Cheers

David

