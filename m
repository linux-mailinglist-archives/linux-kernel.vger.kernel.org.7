Return-Path: <linux-kernel+bounces-721099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4225EAFC4B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12AD4A7F99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976BC1FFC41;
	Tue,  8 Jul 2025 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mNy2f5P5"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B50203706
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961245; cv=none; b=Zsste9PJUT1COZ7XyUANM18FagdGgpBlZCLgg/cRL3FP1zY0dU9n+55BkxP/X//ZTn/M/ohoW4VognAX6XG07nIm47iRINfMNVxToYs9gvo7GOV2lh9YaMHvUTgBl9CfBrJwE7bcknk7T2w4Dmcb+GC4O6B4xnA9meNV3JYNGaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961245; c=relaxed/simple;
	bh=Y0uxjOZKAIehwxOwZRu+r+eyUc2ebvQ/3q0wvD36E0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8fAokGBZL8BC8hJc2ltDz0mLc/JjrrW1lppwux2DzLT//XC/CgrgVfXnTspgjAxDYILqHlvF8ocAZwqjjAusQjT8+WyWSxuqJT/ON86kVN3IIqhN6S3tLBV0E+fuBspNFc2pvqFun/RZu3QRIm064OvGyorimgylM+jeGcfc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mNy2f5P5; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751961239; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DNfi3XvvaPQFWN6RIuvca87fevIPOyq+CtUUka0qa+g=;
	b=mNy2f5P5NEUV540Ng+TQkuzQdtWSBcfol28wgWsfSADKf6T3629medG5kJhQIS5da+aBv3UQs6LrC7zFMz1bCPn+qSkhusiPcAju07BK+apr3ftVCHxwR+XJEtcB5hYw5WXOv3ZVLzJU+OB/Pf8Dw0CkzNGI3Z8oKG1D4WPJX60=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiLpkEF_1751961236 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 15:53:57 +0800
Message-ID: <23f1c3ab-16ca-41db-b008-22448d9e08f2@linux.alibaba.com>
Date: Tue, 8 Jul 2025 15:53:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: fault in complete folios instead of individual
 pages for tmpfs
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
 david@redhat.com, ziy@nvidia.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <440940e78aeb7430c5cc8b6d2088ae98265b9809.1751599072.git.baolin.wang@linux.alibaba.com>
 <20250704151858.73d35a24b4c2f53bdb0c1b85@linux-foundation.org>
 <4c055849-d7dd-4b9f-9666-fcb0bccf8681@linux.alibaba.com>
 <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <007c4a94-c94a-418e-9907-7510422f8ca4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/7 21:33, Lorenzo Stoakes wrote:
> On Sun, Jul 06, 2025 at 10:02:35AM +0800, Baolin Wang wrote:
>>
>>
>> On 2025/7/5 06:18, Andrew Morton wrote:
>>> On Fri,  4 Jul 2025 11:19:26 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>>
>>>> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"),
>>>> tmpfs can also support large folio allocation (not just PMD-sized large
>>>> folios).
>>>>
>>>> However, when accessing tmpfs via mmap(), although tmpfs supports large folios,
>>>> we still establish mappings at the base page granularity, which is unreasonable.
>>>>
>>>> We can map multiple consecutive pages of a tmpfs folios at once according to
>>>> the size of the large folio. On one hand, this can reduce the overhead of page
>>>> faults; on the other hand, it can leverage hardware architecture optimizations
>>>> to reduce TLB misses, such as contiguous PTEs on the ARM architecture.
>>>>
>>>> Moreover, tmpfs mount will use the 'huge=' option to control large folio
>>>> allocation explicitly. So it can be understood that the process's RSS statistics
>>>> might increase, and I think this will not cause any obvious effects for users.
>>>>
>>>> Performance test:
>>>> I created a 1G tmpfs file, populated with 64K large folios, and write-accessed it
>>>> sequentially via mmap(). I observed a significant performance improvement:
>>>
>>> That doesn't sound like a crazy thing to do.
>>>
>>>> Before the patch:
>>>> real	0m0.158s
>>>> user	0m0.008s
>>>> sys	0m0.150s
>>>>
>>>> After the patch:
>>>> real	0m0.021s
>>>> user	0m0.004s
>>>> sys	0m0.017s
>>>
>>> And look at that.
>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 0f9b32a20e5b..9944380e947d 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -5383,10 +5383,10 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>>    	/*
>>>>    	 * Using per-page fault to maintain the uffd semantics, and same
>>>> -	 * approach also applies to non-anonymous-shmem faults to avoid
>>>> +	 * approach also applies to non shmem/tmpfs faults to avoid
>>>>    	 * inflating the RSS of the process.
>>>>    	 */
>>>> -	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>>> +	if (!vma_is_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
>>>>    	    unlikely(needs_fallback)) {
>>>>    		nr_pages = 1;
>>>>    	} else if (nr_pages > 1) {
>>>
>>> and that's it?
>>>
>>> I'm itching to get this into -stable, really.  What LTS user wouldn't
>>> want this?
>>
>> This is an improvement rather than a bugfix, so I don't think it needs to go
>> into LTS.
>>
>> Could it be viewed as correcting an oversight in
>>> acd7ccb284b8?
>>
>> Yes, I should have added this optimization in the series of the commit
>> acd7ccb284b8. But obviously, I missed this :(.
> 
> Buuut if this was an oversight for that patch that causes an unnecessary
> perf degradation, surely this should have fixes tag + cc stable no?

IMO, this commit acd7ccb284b8 won't cause perf degradation, instead it 
is used to introduce a new feature, while the current patch is a further 
reasonable optimization. As I mentioned, this is an improvement, not a 
bugfix or a patch to address performance regression.

