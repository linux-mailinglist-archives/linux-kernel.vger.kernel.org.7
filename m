Return-Path: <linux-kernel+bounces-751532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027F3B16A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151F517F3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B06520E702;
	Thu, 31 Jul 2025 02:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RiArcWtE"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD83E15383A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930690; cv=none; b=bDzxusA6cMXrBrCy21Q9RUA7Y9XmktMFdaaB8SITeyz8HT+MG98fvk7MP7QlN9K/JbwWzcTkhJDALJB0EMq3Bycm/8TbUpgGAarNnIXE6Pv5Q53r5KAPV/mEbIzZT4JqJU12ZKdIRjxpAdbejC7jBCHOXYRKBR466eRPJ9KeNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930690; c=relaxed/simple;
	bh=RADIpNTbwcg78lKaTRqnDtzYF7XfagFHbqzK3pkwI38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DOU3FA+BKBKtCGdoNK0VAT2XeWsXNwpM1Atm4otS3TTXphHUpQuObgFcgp3KmyKJqEEFpg9WPg5hGVib96tMRcD0aPtvuJ669FviCklp05WYKuj/R7pLr+Hp83Be4n0Obj177AEVEkdUfWcjK0tAZP7iIyzO7dkaeMDRkFIhR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RiArcWtE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753930678; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0DMe1rYjfdKcGwYqc0RA2Njo+26yNUA5TqRbqsuCvok=;
	b=RiArcWtEcSucS0zekfL6tQyYkIWR8wLDkc7eE7QYCUMJzGAAt/QcuUKsALbRQzXU6bJd1WW5xWUtzBK4htbDPmZaO39og3XEphwfREIK8y2WU8xNQSx6btgTBAjm1W1zE8PEg1mANGjesowAn2UcQumHM/N4pN11VXHZasXM3WI=
Received: from 30.74.144.125(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WkWYsmM_1753930676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 31 Jul 2025 10:57:56 +0800
Message-ID: <7ee29e25-d4d5-4e3f-816c-a877f1a5e7de@linux.alibaba.com>
Date: Thu, 31 Jul 2025 10:57:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: shmem: fix the strategy for the tmpfs 'huge='
 options
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
 david@redhat.com, ziy@nvidia.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <701271092af74c2d969b195321c2c22e15e3c694.1753863013.git.baolin.wang@linux.alibaba.com>
 <5578907d-3583-4a87-8b60-0cda0284a358@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <5578907d-3583-4a87-8b60-0cda0284a358@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/30 23:17, Lorenzo Stoakes wrote:
> On Wed, Jul 30, 2025 at 04:14:55PM +0800, Baolin Wang wrote:
>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
>> we have extended tmpfs to allow any sized large folios, rather than just
>> PMD-sized large folios.
>>
>> The strategy discussed previously was:
>>
>> "
>> Considering that tmpfs already has the 'huge=' option to control the
>> PMD-sized large folios allocation, we can extend the 'huge=' option to
>> allow any sized large folios.  The semantics of the 'huge=' mount option
>> are:
>>
>>      huge=never: no any sized large folios
>>      huge=always: any sized large folios
>>      huge=within_size: like 'always' but respect the i_size
>>      huge=advise: like 'always' if requested with madvise()
> 
> Sort of hate we have a million different ways of setting behaviour for THP
> and they all differ in subtle ways.
> 
> Also this is similar to sysfs settings but with slightly different
> semantics... <insert appropriate meme here>.
> 
>>
>> Note: for tmpfs mmap() faults, due to the lack of a write size hint, still
>> allocate the PMD-sized huge folios if huge=always/within_size/advise is
>> set.
>>
>> Moreover, the 'deny' and 'force' testing options controlled by
>> '/sys/kernel/mm/transparent_hugepage/shmem_enabled', still retain the same
>> semantics.  The 'deny' can disable any sized large folios for tmpfs, while
>> the 'force' can enable PMD sized large folios for tmpfs.
> 
> And what about MADV_COLLAPSE?

As Hugh mentioned beore, the 'deny' option will prohibit MADV_COLLAPSE 
for shmem, while 'force' option will allow it.

>> This means that when tmpfs is mounted with 'huge=always' or 'huge=within_size',
>> tmpfs will allow getting a highest order hint based on the size of write() and
>> fallocate() paths. It will then try each allowable large order, rather than
>> continually attempting to allocate PMD-sized large folios as before.
>>
>> However, this might break some user scenarios for those who want to use
>> PMD-sized large folios, such as the i915 driver which did not supply a write
>> size hint when allocating shmem [1].
> 
> Hmm, this is unclear to me, surely because it doesn't provide a write size
> hint it's not this behaviour that breaks anything, but rather the fact that
> we base things on the write hint at all?

Yes, we changed the allocation strategy for shmem large folios, but 
forgot to update the shmem allocation method for the i915 driver.

>> Moreover, Hugh also complained that this will cause a regression in userspace
>> with 'huge=always' or 'huge=within_size'.
> 
> Will cause? Is this not already the case?
> 
> And what is the regression precisely? That i915 doesn't get huge pages
> because it doesn't provide a hint?

Yes, see above.

>> So, let's revisit the strategy for tmpfs large page allocation. A simple fix
>> would be to always try PMD-sized large folios first, and if that fails, fall
>> back to smaller large folios. However, this approach differs from the strategy
>> for large folio allocation used by other file systems. Is this acceptable?
> 
> Doesn't this imply a waste of memory?

Right. As I replied to David, using the write size as an indication to 
allocate large folios is certainly reasonable in some scenarios, as it 
avoids memory bloat while leveraging the advantages of large folios.

However, there may be scenarios where PMD-sized large folios are always 
expected, such as the i915 driver. It's uncertain whether user-space 
tmpfs mounts with 'huge=' options have such scenarios, but we do have 
this concern.

> I mean if the 'implicit' semantics now are 'always ...but respecting a
> write size hint' (which kind of sucks), is changing this ok?
> 
> Maybe somebody relies on that?
> 
> It seems (unless I'm missing something here) that in THP we've both made
> never not mean never, and always not mean always.
> 
>>
>> [1] https://lore.kernel.org/lkml/0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com/
>> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>> Note: this is just an RFC patch. I would like to hear others' opinions or
>> see if there is a better way to address Hugh's concern.
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst |  6 ++-
>>   mm/shmem.c                                 | 47 +++-------------------
>>   2 files changed, 10 insertions(+), 43 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index 878796b4d7d3..121cbb3a72f7 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -383,12 +383,16 @@ option: ``huge=``. It can have following values:
>>
>>   always
>>       Attempt to allocate huge pages every time we need a new page;
>> +    Always try PMD-sized huge pages first, and fall back to smaller-sized
>> +    huge pages if the PMD-sized huge page allocation fails;
>>
>>   never
>>       Do not allocate huge pages;
>>
>>   within_size
>> -    Only allocate huge page if it will be fully within i_size.
>> +    Only allocate huge page if it will be fully within i_size;
>> +    Always try PMD-sized huge pages first, and fall back to smaller-sized
>> +    huge pages if the PMD-sized huge page allocation fails;
>>       Also respect madvise() hints;
>>
>>   advise
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 75cc2cb92950..c1040a115f08 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -566,42 +566,6 @@ static int shmem_confirm_swap(struct address_space *mapping, pgoff_t index,
>>   static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>>   static int tmpfs_huge __read_mostly = SHMEM_HUGE_NEVER;
>>
>> -/**
>> - * shmem_mapping_size_orders - Get allowable folio orders for the given file size.
>> - * @mapping: Target address_space.
>> - * @index: The page index.
>> - * @write_end: end of a write, could extend inode size.
>> - *
>> - * This returns huge orders for folios (when supported) based on the file size
>> - * which the mapping currently allows at the given index. The index is relevant
>> - * due to alignment considerations the mapping might have. The returned order
>> - * may be less than the size passed.
>> - *
>> - * Return: The orders.
>> - */
>> -static inline unsigned int
>> -shmem_mapping_size_orders(struct address_space *mapping, pgoff_t index, loff_t write_end)
>> -{
>> -	unsigned int order;
>> -	size_t size;
>> -
>> -	if (!mapping_large_folio_support(mapping) || !write_end)
>> -		return 0;
>> -
>> -	/* Calculate the write size based on the write_end */
>> -	size = write_end - (index << PAGE_SHIFT);
>> -	order = filemap_get_order(size);
>> -	if (!order)
>> -		return 0;
>> -
>> -	/* If we're not aligned, allocate a smaller folio */
>> -	if (index & ((1UL << order) - 1))
>> -		order = __ffs(index);
> 
> We need to care about alignment still no?

We‘ve already done alignment during shmem allocation.

>> -
>> -	order = min_t(size_t, order, MAX_PAGECACHE_ORDER);
>> -	return order > 0 ? BIT(order + 1) - 1 : 0;
>> -}
>> -
>>   static unsigned int shmem_get_orders_within_size(struct inode *inode,
>>   		unsigned long within_size_orders, pgoff_t index,
>>   		loff_t write_end)
>> @@ -648,22 +612,21 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
>>   	 * For tmpfs mmap()'s huge order, we still use PMD-sized order to
>>   	 * allocate huge pages due to lack of a write size hint.
>>   	 *
>> -	 * Otherwise, tmpfs will allow getting a highest order hint based on
>> -	 * the size of write and fallocate paths, then will try each allowable
>> -	 * huge orders.
>> +	 * For tmpfs with 'huge=always' or 'huge=within_size' mount option,
>> +	 * we will always try PMD-sized order first. If that failed, it will
>> +	 * fall back to small large folios.
>>   	 */
>>   	switch (SHMEM_SB(inode->i_sb)->huge) {
>>   	case SHMEM_HUGE_ALWAYS:
>>   		if (vma)
>>   			return maybe_pmd_order;
>>
>> -		return shmem_mapping_size_orders(inode->i_mapping, index, write_end);
>> +		return THP_ORDERS_ALL_FILE_DEFAULT;
>>   	case SHMEM_HUGE_WITHIN_SIZE:
>>   		if (vma)
>>   			within_size_orders = maybe_pmd_order;
>>   		else
>> -			within_size_orders = shmem_mapping_size_orders(inode->i_mapping,
>> -								       index, write_end);
>> +			within_size_orders = THP_ORDERS_ALL_FILE_DEFAULT;
>>
>>   		within_size_orders = shmem_get_orders_within_size(inode, within_size_orders,
>>   								  index, write_end);
>> --
>> 2.43.5
>>


