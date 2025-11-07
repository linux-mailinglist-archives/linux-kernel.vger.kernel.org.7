Return-Path: <linux-kernel+bounces-890006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6CC3F0C6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2270F349C7D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05172FFFAD;
	Fri,  7 Nov 2025 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWCKRYcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C60B24EF8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505982; cv=none; b=MOb/cpJH2ez7oIiLaX4YES/u1C6FxkWXZjUWALwnDhY/E+G1tdMprskfkeuQHTDgL3MBYFFLp9tAAeQ4sH0EhaN3y5F3zzeHjXDR/JCmhsQoJyhq6ME15P9mBIX1+AMhA/3QvS/hOb3QzPCabzc8zlhDGRwUm1kcQv6IIYJszzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505982; c=relaxed/simple;
	bh=1cEOC2jcm0VXC7GcvRmuZj9kiS1YKJGfs50Jfr0agNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuExqnXskjChRVUlTW0zoqhSHKS6DostugQTWPE2d+64P/g1KQVTKjBKgKfqRdjNYKJsp/BPuXqzru4MXVjWr+w+9bD5fs38VkSt5VV1jvj4zuvjh4StdgTRmeZD+gs8Z7lxqH6zTT2YFXV0v8cbsrdgK4nNa9HzIRb3sD08YCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWCKRYcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709B4C4CEF5;
	Fri,  7 Nov 2025 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762505981;
	bh=1cEOC2jcm0VXC7GcvRmuZj9kiS1YKJGfs50Jfr0agNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YWCKRYcHldP2qaFfyuTLw7bLSDGTzaIYmWgsCX1WKZBbq4oynkcSk0qmrMgRe2dnM
	 bOIf3Du/lRLpehU0JZUcoDnXOkgGNgjaPIjrGNkMTe/Jalnj5PkECR1tF58ytoZ7u+
	 n8EQGZ0SHqONXVMb5kIPmX4xqoarJufqR2/D1TyeJTKey6o4tlFhug7gExBl/AyD82
	 m+dyE5PLWi7SNJjQGIS2Dwja5MgypbZqQ21mjwJzS04R3lEZ/HhbcRYtVpEvJPopTb
	 CzO5IcXOktCnKeRxabcda9ieIVN54RS3C+h7UJC52vML+lDPVdy6cJPr4dAjKbOqPS
	 p97gG2jYnBdVA==
Message-ID: <52f67ca1-24c6-4081-99e6-0a1d30da1bd6@kernel.org>
Date: Fri, 7 Nov 2025 09:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] mm: folio_zero_user: clear contiguous pages
To: Ankur Arora <ankur.a.arora@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, tglx@linutronix.de, willy@infradead.org,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20251027202109.678022-1-ankur.a.arora@oracle.com>
 <20251027143309.4331a65f38f05ea95d9e46ad@linux-foundation.org>
 <87qzunq6v4.fsf@oracle.com> <87h5v676f4.fsf@oracle.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <87h5v676f4.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.11.25 06:33, Ankur Arora wrote:
> 
> Ankur Arora <ankur.a.arora@oracle.com> writes:
> 
>> [ My earlier reply to this ate up some of the headers and broke out of
>> the thread. Resending. ]
>>
>> Andrew Morton <akpm@linux-foundation.org> writes:
>>
>>> On Mon, 27 Oct 2025 13:21:02 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>>
> 
> [ ... ]
> 
>>
>>> It's possible that we're being excessively aggressive with those
>>> cond_resched()s.  Have you investigating tuning their frequency so we
>>> can use larger extent sizes with these preemption models?
>>
>>
>> folio_zero_user() does a small part of that: for 2MB pages the clearing
>> is split in three parts with an intervening cond_resched() for each.
>>
>> This is of course much simpler than the process_huge_page() approach where
>> we do a left right dance around the faulting page.
>>
>> I had implemented a version of process_huge_page() with larger extent
>> sizes that narrowed as we got closer to the faulting page in [a] (x86
>> performance was similar to the current series. See [b]).
>>
>> In hindsight however, that felt too elaborate and probably unnecessary
>> on most modern systems where you have reasonably large caches.
>> Where it might help, however, is on more cache constrained systems where
>> the spatial locality really does matter.
>>
>> So, my idea was to start with a simple version, get some testing and
>> then fill in the gaps instead of starting with something like [a].
>>
>>
>> [a] https://lore.kernel.org/lkml/20220606203725.1313715-1-ankur.a.arora@oracle.com/#r
>> [b] https://lore.kernel.org/lkml/20220606202109.1306034-1-ankur.a.arora@oracle.com/
>>
>>>> The anon-w-seq test in the vm-scalability benchmark, however, does show
>>>> worse performance with utime increasing by ~9%:
>>>>
>>>>                           stime                  utime
>>>>
>>>>    baseline         1654.63 ( +- 3.84% )     811.00 ( +- 3.84% )
>>>>    +series          1630.32 ( +- 2.73% )     886.37 ( +- 5.19% )
>>>>
>>>> In part this is because anon-w-seq runs with 384 processes zeroing
>>>> anonymously mapped memory which they then access sequentially. As
>>>> such this is a likely uncommon pattern where the memory bandwidth
>>>> is saturated while also being cache limited because we access the
>>>> entire region.
>>>>
>>>> Raghavendra also tested previous version of the series on AMD Genoa [1].
>>>
>>> I suggest you paste Raghavendra's results into this [0/N] - it's
>>> important material.
>>
>> Thanks. Will do.
>>
>>>>
>>>> ...
>>>>
>>>>   arch/alpha/include/asm/page.h      |  1 -
>>>>   arch/arc/include/asm/page.h        |  2 +
>>>>   arch/arm/include/asm/page-nommu.h  |  1 -
>>>>   arch/arm64/include/asm/page.h      |  1 -
>>>>   arch/csky/abiv1/inc/abi/page.h     |  1 +
>>>>   arch/csky/abiv2/inc/abi/page.h     |  7 ---
>>>>   arch/hexagon/include/asm/page.h    |  1 -
>>>>   arch/loongarch/include/asm/page.h  |  1 -
>>>>   arch/m68k/include/asm/page_mm.h    |  1 +
>>>>   arch/m68k/include/asm/page_no.h    |  1 -
>>>>   arch/microblaze/include/asm/page.h |  1 -
>>>>   arch/mips/include/asm/page.h       |  1 +
>>>>   arch/nios2/include/asm/page.h      |  1 +
>>>>   arch/openrisc/include/asm/page.h   |  1 -
>>>>   arch/parisc/include/asm/page.h     |  1 -
>>>>   arch/powerpc/include/asm/page.h    |  1 +
>>>>   arch/riscv/include/asm/page.h      |  1 -
>>>>   arch/s390/include/asm/page.h       |  1 -
>>>>   arch/sparc/include/asm/page_32.h   |  2 +
>>>>   arch/sparc/include/asm/page_64.h   |  1 +
>>>>   arch/um/include/asm/page.h         |  1 -
>>>>   arch/x86/include/asm/page.h        |  6 ---
>>>>   arch/x86/include/asm/page_32.h     |  6 +++
>>>>   arch/x86/include/asm/page_64.h     | 64 ++++++++++++++++++-----
>>>>   arch/x86/lib/clear_page_64.S       | 39 +++-----------
>>>>   arch/xtensa/include/asm/page.h     |  1 -
>>>>   include/linux/highmem.h            | 29 +++++++++++
>>>>   include/linux/mm.h                 | 69 +++++++++++++++++++++++++
>>>>   mm/memory.c                        | 82 ++++++++++++++++++++++--------
>>>>   mm/util.c                          | 13 +++++
>>>>   30 files changed, 247 insertions(+), 91 deletions(-)
>>>
>>> I guess this is an mm.git thing, with x86 acks (please).
>>
>> Ack that.
>>
>>> The documented review activity is rather thin at this time so I'll sit
>>> this out for a while.  Please ping me next week and we can reassess,
>>
>> Will do. And, thanks for the quick look!
> 
> Hi Andrew
> 
> So, the comments I have so far are mostly about clarity around the
> connection with preempt model and some cleanups on the x86 patches.
> 
> Other than that, my major concern is wider testing (platforms and
> workloads) than mine has been.
> 
> Could you take another look at the series and see what else you think
> it needs.

Sorry for the delay from my side, I took another look at patches and had 
some smaller comments.

-- 
Cheers

David

