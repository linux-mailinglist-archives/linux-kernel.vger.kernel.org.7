Return-Path: <linux-kernel+bounces-734873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34881B08774
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6644B17BBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEFE275855;
	Thu, 17 Jul 2025 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="UmhdZqgW"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7717262D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739288; cv=none; b=RJTedZf+iqyLOTu7Sjv8e+wHohobNBI4cfANZB7pyE6kRmpLiYJtdPYTjTrZS0F+SbNFLOK/tkgR/mHYwgWM5cQYE5E4pPpe75ITI9GcGwddV2SCtMVK79HmKwkj0IDVvkT4SVA7RR80eDpgo/8PUGYlsqJcp5g//rGDmqDVepw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739288; c=relaxed/simple;
	bh=2Wmgryy9Cdz9HhsDs9uP14L/aqJjm5OR9TQNYbMqupo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrd/OJMpxRV4BvTdg7azCZpzGQL8LdxUgiK2cA1dapY2KAAxyCYj3XclOoQ6DO6Z/1/ccZCpxCEncpFfPsfkmMkZDSnCzeJcO7ADeCxI8dyUNvtt5ewxBL2WDvybsew3yC01uoetQ4YDAXw5BipFM/Ii+3T/Zm8Ti1CNqybcf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=UmhdZqgW; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752739277; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lm57nyWYAq4OaHT76qweXZ54dO7dav1Hwaj3vqzFXs4=;
	b=UmhdZqgWEz+5K4lDZDkgsAkbmDLsK/0XpTWpyM0PzDK3kGH9U7s+KWo7lYFAJXNwlF6ZHb7IoEqnwK5xZW+wWfvJh38JlJ98FsH2GU06ryBkisGwIQ+Tl1EnGmjZezMK+gb4o6hv+XHOirTAMiOU8WrttftSY0rGZNQx21vjkm4=
Received: from 30.74.144.120(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wj7QPdo_1752739274 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 16:01:15 +0800
Message-ID: <a1c9ba0f-544d-4204-ad3b-60fe1be2ab32@linux.alibaba.com>
Date: Thu, 17 Jul 2025 16:01:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
To: Hugh Dickins <hughd@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, david@redhat.com, ziy@nvidia.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
 <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
 <d0b24095-d7fc-459d-85ed-9c0797e9fca3@lucifer.local>
 <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <3bf50873-4d1b-a7c7-112e-3a17ac16077f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/16 04:03, Hugh Dickins wrote:
> On Wed, 9 Jul 2025, Lorenzo Stoakes wrote:
>> On Tue, Jul 08, 2025 at 03:53:56PM +0800, Baolin Wang wrote:
>>> On 2025/7/7 21:33, Lorenzo Stoakes wrote:
>>>> On Sun, Jul 06, 2025 at 10:02:35AM +0800, Baolin Wang wrote:
>>>>> On 2025/7/5 06:18, Andrew Morton wrote:
>>>>>> On Fri,  4 Jul 2025 11:19:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>>>>
>>>>>>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
>>>>>>> tmpfs can also support large folio allocation (not just PMD-sized large
>>>>>>> folios).
>>>>>>>
>>>>>>> However, when accessing tmpfs via mmap(), although tmpfs supports large folios,
>>>>>>> we still establish mappings at the base page granularity, which is unreasonable.
>>>>>>>
>>>>>>> We can map multiple consecutive pages of a tmpfs folios at once according to
>>>>>>> the size of the large folio. On one hand, this can reduce the overhead of page
>>>>>>> faults; on the other hand, it can leverage hardware architecture optimizations
>>>>>>> to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
>>>>>>>
>>>>>>> Moreover, tmpfs mount will use the 'huge=' option to control large folio
>>>>>>> allocation explicitly. So it can be understood that the process's RSS statistics
>>>>>>> might increase, and I think this will not cause any obvious effects for users.
>>>>>>>
>>>>>>> Performance test:
>>>>>>> I created a 1G tmpfs file, populated with 64K large folios, and write-accessed it
>>>>>>> sequentially via mmap(). I observed a significant performance improvement:
>>>>>>
>>>>>> That doesn't sound like a crazy thing to do.
>>>>>>
>>>>>>> Before the patch:
>>>>>>> real	0m0.158s
>>>>>>> user	0m0.008s
>>>>>>> sys	0m0.150s
>>>>>>>
>>>>>>> After the patch:
>>>>>>> real	0m0.021s
>>>>>>> user	0m0.004s
>>>>>>> sys	0m0.017s
>>>>>>
>>>>>> And look at that.
>>>>>>
>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>> index 0f9b32a20e5b..9944380e947d 100644
>>>>>>> --- a/mm/memory.c
>>>>>>> +++ b/mm/memory.c
>>>>>>> @@ -5383,10 +5383,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>>>>     	/*
>>>>>>>     	 * Using per-page fault to maintain the uffd semantics, and same
>>>>>>> -	 * approach also applies to non-anonymous-shmem faults to avoid
>>>>>>> +	 * approach also applies to non shmem/tmpfs faults to avoid
>>>>>>>     	 * inflating the RSS of the process.
>>>>>>>     	 */
>>>>>>> -	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>>>>>> +	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>>>>>>     	    unlikely(needs_fallback)) {
>>>>>>>     		nr_pages = 1;
>>>>>>>     	} else if (nr_pages > 1) {
>>>>>>
>>>>>> and that's it?
>>>>>>
>>>>>> I'm itching to get this into -stable, really.  What LTS user wouldn't
>>>>>> want this?
>>>>>
>>>>> This is an improvement rather than a bugfix, so I don't think it needs to go
>>>>> into LTS.
>>>>>
>>>>> Could it be viewed as correcting an oversight in
>>>>>> acd7ccb284b8?
>>>>>
>>>>> Yes, I should have added this optimization in the series of the commit
>>>>> acd7ccb284b8. But obviously, I missed this :(.
>>>>
>>>> Buuut if this was an oversight for that patch that causes an unnecessary
>>>> perf degradation, surely this should have fixes tag + cc stable no?
>>>
>>> IMO, this commit acd7ccb284b8 won't cause perf degradation, instead it is
>>> used to introduce a new feature, while the current patch is a further
>>> reasonable optimization. As I mentioned, this is an improvement, not a
>>> bugfix or a patch to address performance regression.
>>
>> 4Well :) you say yourself it was an oversight, and it very clearly has a perf
>> _impact_, which if you compare backwards to acd7ccb284b8 is a degradation, but I
>> get your point.
>>
>> However, since you say 'oversight' this seems to me that you really meant to
>> have included it but hadn't noticed, and additionally, since it just seems to be
>> an unequivical good - let's maybe flip this round - why NOT backport it to
>> stable?
> 
> I strongly agree with Baolin: this patch is good, thank you, but it is
> a performance improvement, a new feature, not a candidate for the stable
> tree.  I'm surprised anyone thinks otherwise: Andrew, please delete that
> stable tag before advancing the patch from mm-unstable to mm-stable.
> 
> And the Fixee went into 6.14, so it couldn't go to 6.12 LTS anyway.

Agree.

> An unequivocal good? I'm not so sure.
> 
> I expect it ought to be limited, by fault_around_bytes (or suchlike).
> 
> If I understand all the mTHP versus large folio versus PMD-huge handling
> correctly (and of course I do not, I'm still weeks if not months away
> from understanding most of it), the old vma_is_anon_shmem() case would
> be limited by the shmem mTHP tunables, and one can reasonably argue that
> they would already take fault_around_bytes-like considerations into account;
> but the newly added file-written cases are governed by huge= mount options
> intended for PMD-size, but (currently) permitting all lesser orders.
> I don't think that mounting a tmpfs huge=always implies that mapping
> 256 PTEs for one fault is necessarily a good strategy.
> 
> But looking in the opposite direction, why is there now a vma_is_shmem()
> check there in finish_fault() at all?  If major filesystems are using
> large folios, why aren't they also allowed to benefit from mapping
> multiple PTEs at once (in this shared-writable case which the existing
> fault-around does not cover - I presume to avoid write amplification,
> but that's not an issue when the folio is large already).

This is what I'm going to do next. For other filesystems, I think they 
should also map multiple PTEs at once. IIUC, I don't think this will 
lead to write amplification (because large folios are already allocated, 
it will just cause RSS to inflate, but I wonder if this actually causes 
any problem?), instead the current dirty tracking for mmap write access 
is per-folio (see iomap_page_mkwrite()), which can cause write 
amplification.

> It's fine to advance cautiously, keeping this to shmem in coming release;
> but I think it should be extended soon (without any backport to stable),
> and consideration given to limiting it.

Yes, I will consider that. But fault_around_bytes is tricky, we can 
discuss it in subsequent patches. Thanks for your comments.

