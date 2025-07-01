Return-Path: <linux-kernel+bounces-710441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBCEAEEC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 04:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A353BC4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 02:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011D1AF0AF;
	Tue,  1 Jul 2025 02:40:07 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718BDDBC;
	Tue,  1 Jul 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751337607; cv=none; b=CGzDNiUvKWSrzXGMxwSwDTC+ppZqaqSnbaR0V0GrlrZZppCwVqqZrhhAjZgnxbrfueSY0Nc3HBAaiQVbHFRs3ooovbI7kzdGtwglt5y9k6t72+7GmJ8gOUMJDfcu49RzJoOFtNwzkt5KXZmLf2ufUMR2hGYWoc2TAPw9uyqoAS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751337607; c=relaxed/simple;
	bh=j/qKejejVjl3s9lT+h5fzUHFwqfZHA6D1FWAJuhms7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YSpUM6vXeu32TR902HmFCUbBL4n6uJ/G5foAZaZb63bh6DkD1rz1X2RH5HJSm9cWjI5TWeGQHqMQELqAOYsWjlOLo7Muzg7/BW2VuMKCSuLDoSYD9wSGFuvj9LkmO6/ueH/lcAQKkXv7rFN9lmH4d5d4kKVAa7ex9BKnsJPMj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bWRyG4FxBz13McB;
	Tue,  1 Jul 2025 10:37:26 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id A85D4180B57;
	Tue,  1 Jul 2025 10:39:54 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 1 Jul
 2025 10:39:53 +0800
Message-ID: <272e8673-36a9-4fef-a9f1-5be29a57c2dc@huawei.com>
Date: Tue, 1 Jul 2025 10:39:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-4-libaokun1@huawei.com>
 <xlzlyqudvp7a6ufdvc4rgsoe7ty425rrexuxgfbgwxoazfjd25@6eqbh66w7ayr>
 <1c2d7881-94bb-46ff-9cf6-ef1fbffc13e5@huawei.com>
 <mfybwoygcycblgaln2j4et4zmyzli2zibcgvixysanugjjhhh5@xyzoc4juy4wv>
 <db4b9d71-c34d-4315-a87d-2edf3bbaff2d@huawei.com>
 <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <e2dgjtqvqjapir5xizb5ixkilhzr7fm7m7ymxzk6ixzdbwxjjs@24n4nzolye77>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/1 0:32, Jan Kara wrote:
> On Mon 30-06-25 17:21:48, Baokun Li wrote:
>> On 2025/6/30 15:47, Jan Kara wrote:
>>> On Mon 30-06-25 11:48:20, Baokun Li wrote:
>>>> On 2025/6/28 2:19, Jan Kara wrote:
>>>>> On Mon 23-06-25 15:32:51, Baokun Li wrote:
>>>>>> After we optimized the block group lock, we found another lock
>>>>>> contention issue when running will-it-scale/fallocate2 with multiple
>>>>>> processes. The fallocate's block allocation and the truncate's block
>>>>>> release were fighting over the s_md_lock. The problem is, this lock
>>>>>> protects totally different things in those two processes: the list of
>>>>>> freed data blocks (s_freed_data_list) when releasing, and where to start
>>>>>> looking for new blocks (mb_last_group) when allocating.
>>>>>>
>>>>>> Now we only need to track s_mb_last_group and no longer need to track
>>>>>> s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
>>>>>> two are consistent, and we can ensure that the s_mb_last_group read is up
>>>>>> to date by using smp_store_release/smp_load_acquire.
>>>>>>
>>>>>> Besides, the s_mb_last_group data type only requires ext4_group_t
>>>>>> (i.e., unsigned int), rendering unsigned long superfluous.
>>>>>>
>>>>>> Performance test data follows:
>>>>>>
>>>>>> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
>>>>>> Observation: Average fallocate operations per container per second.
>>>>>>
>>>>>>                       | Kunpeng 920 / 512GB -P80|  AMD 9654 / 1536GB -P96 |
>>>>>>     Disk: 960GB SSD   |-------------------------|-------------------------|
>>>>>>                       | base  |    patched      | base  |    patched      |
>>>>>> -------------------|-------|-----------------|-------|-----------------|
>>>>>> mb_optimize_scan=0 | 4821  | 7612  (+57.8%)  | 15371 | 21647 (+40.8%)  |
>>>>>> mb_optimize_scan=1 | 4784  | 7568  (+58.1%)  | 6101  | 9117  (+49.4%)  |
>>>>>>
>>>>>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>>>>> ...
>>>>>
>>>>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>>>>> index 5cdae3bda072..3f103919868b 100644
>>>>>> --- a/fs/ext4/mballoc.c
>>>>>> +++ b/fs/ext4/mballoc.c
>>>>>> @@ -2168,11 +2168,9 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>>>>>     	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>>>>>>     	folio_get(ac->ac_buddy_folio);
>>>>>>     	/* store last allocated for subsequent stream allocation */
>>>>>> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>>>>>> -		spin_lock(&sbi->s_md_lock);
>>>>>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>>>>>> -		spin_unlock(&sbi->s_md_lock);
>>>>>> -	}
>>>>>> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
>>>>>> +		/* pairs with smp_load_acquire in ext4_mb_regular_allocator() */
>>>>>> +		smp_store_release(&sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
>>>>> Do you really need any kind of barrier (implied by smp_store_release())
>>>>> here? I mean the store to s_mb_last_group is perfectly fine to be reordered
>>>>> with other accesses from the thread, isn't it? As such it should be enough
>>>>> to have WRITE_ONCE() here...
>>>> WRITE_ONCE()/READ_ONCE() primarily prevent compiler reordering and ensure
>>>> that variable reads/writes access values directly from L1/L2 cache rather
>>>> than registers.
>>> I agree READ_ONCE() / WRITE_ONCE() are about compiler optimizations - in
>>> particular they force the compiler to read / write the memory location
>>> exactly once instead of reading it potentially multiple times in different
>>> parts of expression and getting inconsistent values, or possibly writing
>>> the value say byte by byte (yes, that would be insane but not contrary to
>>> the C standard).
>> READ_ONCE() and WRITE_ONCE() rely on the volatile keyword, which serves
>> two main purposes:
>>
>> 1. It tells the compiler that the variable's value can change unexpectedly,
>>     preventing the compiler from making incorrect optimizations based on
>>     assumptions about its stability.
>>
>> 2. It ensures the CPU directly reads from or writes to the variable's
>>     memory address. This means the value will be fetched from cache (L1/L2)
>>     if available, or from main memory otherwise, rather than using a stale
>>     value from a CPU register.
> Yes, we agree on this.
>
>>>> They do not guarantee that other CPUs see the latest values. Reading stale
>>>> values could lead to more useless traversals, which might incur higher
>>>> overhead than memory barriers. This is why we use memory barriers to ensure
>>>> the latest values are read.
>>> But smp_load_acquire() / smp_store_release() have no guarantee about CPU
>>> seeing latest values either. They are just speculation barriers meaning
>>> they prevent the CPU from reordering accesses in the code after
>>> smp_load_acquire() to be performed before the smp_load_acquire() is
>>> executed and similarly with smp_store_release(). So I dare to say that
>>> these barries have no (positive) impact on the allocation performance and
>>> just complicate the code - but if you have some data that show otherwise,
>>> I'd be happy to be proven wrong.
>> smp_load_acquire() / smp_store_release() guarantee that CPUs read the
>> latest data.
>>
>> For example, imagine a variable a = 0, with both CPU0 and CPU1 having
>> a=0 in their caches.
>>
>> Without a memory barrier:
>> When CPU0 executes WRITE_ONCE(a, 1), a=1 is written to the store buffer,
>> an RFO is broadcast, and CPU0 continues other tasks. After receiving ACKs,
>> a=1 is written to main memory and becomes visible to other CPUs.
>> Then, if CPU1 executes READ_ONCE(a), it receives the RFO and adds it to
>> its invalidation queue. However, it might not process it immediately;
>> instead, it could perform the read first, potentially still reading a=0
>> from its cache.
>>
>> With a memory barrier:
>> When CPU0 executes smp_store_release(&a, 1), a=1 is not only written to
>> the store buffer, but data in the store buffer is also written to main
>> memory. An RFO is then broadcast, and CPU0 waits for ACKs from all CPUs.
>>
>> When CPU1 executes smp_load_acquire(a), it receives the RFO and adds it
>> to its invalidation queue. Here, the invalidation queue is flushed, which
>> invalidates a in CPU1's cache. CPU1 then replies with an ACK, and when it
>> performs the read, its cache is invalid, so it reads the latest a=1 from
>> main memory.
> Well, here I think you assume way more about the CPU architecture than is
> generally true (and I didn't find what you write above guaranteed neither
> by x86 nor by arm64 CPU documentation). Generally I'm following the
> guarantees as defined by Documentation/memory-barriers.txt and there you
> can argue only about order of effects as observed by different CPUs but not
> really about when content is fetched to / from CPU caches.

Explaining why smp_load_acquire() and smp_store_release() guarantee the
latest data is read truly requires delving into their underlying
implementation details.

I suggest you Google "why memory barriers are needed." You might find
introductions to concepts like 'Total Store Order', 'Weak Memory Ordering',
MESI, store buffers, and invalidate queue, along with the stories behind
them.

The Documentation/memory-barriers.txt file does a good job of introducing
memory barrier concepts and guiding their usage (for instance, the
'MULTICOPY ATOMICITY' section covers CPU cache coherence in detail).
However, it skips many of the specific implementation details that are
quite often necessary for a deeper understanding.

>
> BTW on x86 in particular smp_load_acquire() and smp_store_release() aren't
> very different from pure READ_ONCE() / WRITE_ONCE:
>
> arch/x86/include/asm/barrier.h:
>
> #define __smp_store_release(p, v)                                       \
> do {                                                                    \
>          compiletime_assert_atomic_type(*p);                             \
>          barrier();                                                      \
>          WRITE_ONCE(*p, v);                                              \
> } while (0)
>
> #define __smp_load_acquire(p)                                           \
> ({                                                                      \
>          typeof(*p) ___p1 = READ_ONCE(*p);                               \
>          compiletime_assert_atomic_type(*p);                             \
>          barrier();                                                      \
>          ___p1;                                                          \
> })
>
> where barrier() is just a compiler barrier - i.e., preventing the compiler
> from reordering accesses around this point. This is because x86 is strongly
> ordered and the CPU can only reorder loads earlier than previous stores.
> TL;DR; on x86 there's no practical difference between using READ_ONCE() /
> WRITE_ONCE() and smp_load_acquire() and smp_store_release() in your code.
> So I still think using those will be clearer and I'd be curious if you can
> see any performance impacts from using READ_ONCE / WRITE_ONCE instead of
> smp_load_acquire() / smp_store_release().
>
> 								Honza

Yes, x86 is a strongly ordered memory architecture. For x86, we only need
to use READ_ONCE()/WRITE_ONCE() to ensure access to data in the CPU cache,
as x86 guarantees the cache is up-to-date.

However, the Linux kernel doesn't exclusively run on x86 architectures;
we have a large number of arm64 servers. Disregarding performance, it's
inherently unreasonable that x86 consistently sees the latest global goals
during block allocation while arm64 does not.


Cheers,
Baokun


